Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128C1341166
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 01:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCSASg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 20:18:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38776 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230510AbhCSASI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Mar 2021 20:18:08 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12J0EfR3021502
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 17:18:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=hIx8HrMirXcs8S8PEFjNSLpO088tQkm7nTaDMrnB1Lo=;
 b=aK9bUts8ZfjiA6jlbLXUoivfVpTmCuo8BZ5Jgwy/qHvDClltNSQjSpg0mXQZY+GonTWu
 fEzSOjaJySsaZB1WGRvolPc0smSvzKdyuS23DNOhNagPBp0bgI501QKYAjkpUZWInZmK
 UHcB6nGnX9LRvQWfN6OWnJKgVKGwvO9BnVI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 37bs1h7s65-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 17:18:07 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 17:18:06 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 046F87907E4; Thu, 18 Mar 2021 17:17:59 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/2] bpf: fix NULL pointer dereference in
Date:   Thu, 18 Mar 2021 17:17:59 -0700
Message-ID: <20210319001759.2165191-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_19:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=437 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri Olsa reported a bug in
  https://lore.kernel.org/bpf/CAKH8qBuXCfUz=3Dw8L+Fj74OaUpbosO29niYwTki7e3A=
g044_aww@mail.gmail.com/T
where cgroup local storage pointer may be NULL in bpf_get_local_storage()
helper. There are two issues uncovered by this bug:
    (1). kprobe or tracepoint prog incorrectly sets cgroup local storage
         before prog run,
    (2). due to change from preempt_disable to migrate_disable,
         preemption is possible and percpu storage might be overwritten
         by other tasks.
Issue (1) has been fixed and this patch set fixed issue (2).
Please see details of Patch #1 for detailed fix.
Patch #2 fixed bpf_prog_test_run to use new signature for
bpf_cgroup_storage_set().

Patch #1 can be backported to bpf tree and Patch #2 cannot due to
refactoring done in bpf-next only.
I did not put a Fix tag as I am not able to find a proper one.
The original commit which changed from preempt_disable to
migrate_disable in bpf.h is just a wrapper where migrate_disable
still calls preempt_disable. The real migrate_disable change happens
later in kernel/sched/*.

Yonghong Song (2):
  bpf: fix NULL pointer dereference in bpf_get_local_storage() helper
  bpf: fix bpf_cgroup_storage_set() usage in test_run

 include/linux/bpf-cgroup.h | 53 +++++++++++++++++++++++++++++++++-----
 include/linux/bpf.h        | 22 +++++++++++++---
 kernel/bpf/helpers.c       | 15 ++++++++---
 kernel/bpf/local_storage.c |  3 ++-
 net/bpf/test_run.c         |  6 ++++-
 5 files changed, 83 insertions(+), 16 deletions(-)

--=20
2.30.2

