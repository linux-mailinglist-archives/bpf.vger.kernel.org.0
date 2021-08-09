Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E843E3F80
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhHIGDh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 02:03:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57328 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233045AbhHIGDg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 02:03:36 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17960RnT011918
        for <bpf@vger.kernel.org>; Sun, 8 Aug 2021 23:03:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=01gH7D4Oy835j3pxJceW+YkgVNDJgMZ8shM6fyVO7WA=;
 b=Mqba2jTie8lAdPabZHvJpG0bA+KFBfBFJs1Q4HqU+hcGIfsbGEZIH0GjoqENxlxj/Hle
 cp8jRjHqymsAZhi5rJYOq845L9N4fVXN6k2dKtBNzZGb1wWNQr9dTYTpB2HDBLNHVmUH
 Ux10rQ66Nsy3JwX801nC4WwQJtJ3oxUaMvc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3a9npdf3ag-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 Aug 2021 23:03:15 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 8 Aug 2021 23:03:13 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 123455CD4CD9; Sun,  8 Aug 2021 23:03:10 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf v2 0/2] bpf: fix a couple of issues with syscall program
Date:   Sun, 8 Aug 2021 23:03:09 -0700
Message-ID: <20210809060310.1174777-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: QttQAcYHuIGntsOhl_cBcjRwd5RJlfZR
X-Proofpoint-ORIG-GUID: QttQAcYHuIGntsOhl_cBcjRwd5RJlfZR
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_01:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=589
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot ([1]) reported a rcu warning for syscall program when
bpf_get_current_cgroup_id() is called in the program. The
bpf_get_current_cgroup_id() helper expects cgroup related
mutex or rcu_read_lock(). The sleepable program cannot be
protected with rcu read_lock, hence the warning.

Previous version ([2]) tried to add rcu_read_lock() surrounding
bpf_prog_run_pin_on_cpu() for syscall program. This doesn't work
and will trigger other warning since syscall program is a sleepable
program.

In this version, patch #1 disallows to call
bpf_get_current_cgroup_id() and bpf_get_current_ancestor_cgroup_id()
for sleepable programs to silence the warning. Further, syscall program
should be protected with bpf_read_lock_trace() which is implemented
in Patch #2.

 [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/
 [2] https://lore.kernel.org/bpf/20210728172307.1030271-1-yhs@fb.com/

Changelog:
  v1 -> v2:
    - use bpf_read_lock_trace() instead of bpf_read_lock() for
      bpf_prog_run_pin_on_cpu().
    - disallow bpf_get_current_[ancestor_]cgroup_id() helper.

Yonghong Song (2):
  bpf: don't call bpf_get_current_[ancestor_]cgroup_id() in sleepable
    progs
  bpf: add missing bpf_read_[un]lock_trace() for syscall program

 kernel/trace/bpf_trace.c | 6 ++++--
 net/bpf/test_run.c       | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

--=20
2.30.2

