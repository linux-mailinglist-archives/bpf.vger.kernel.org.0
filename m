Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8D713B85E
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 04:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAODuJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 22:50:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44992 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728904AbgAODuJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jan 2020 22:50:09 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00F3nMmm017000
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 19:50:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=P3pEsFxOb9YUXvtt7dDROweeiqZPL9QFJHf1Jtp4Hyk=;
 b=CtS0KN9c277NKLA/Ah5zocqBCfE/AAUGDKnPZggc/8CsbFKCIRS3DuOrny6N3eFN6QU4
 Ej6nImnX0sc7HXz2op826veo0b/Dz77ZSxh7tAcbzCOtYQCk9Q9S0zQIkLxMT0xQA1eZ
 wNWwfvvPBi2i+5V2RlBZXb+SAr/7W2W0WDY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xhaj2cxa5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 19:50:08 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 14 Jan 2020 19:50:07 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3CB5437047F1; Tue, 14 Jan 2020 19:50:02 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v3 0/2] bpf: add bpf_send_signal_thread() helper
Date:   Tue, 14 Jan 2020 19:50:02 -0800
Message-ID: <20200115035002.602280-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 mlxlogscore=882 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001150031
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 8b401f9ed244 ("bpf: implement bpf_send_signal() helper") 
added helper bpf_send_signal() which permits bpf program to
send a signal to the current process. The signal may send to 
any thread of the process.
 
This patch implemented a new helper bpf_send_signal_thread()
to send a signal to the thread corresponding to the kernel current task. 
This helper can simplify user space code if the thread context of
bpf sending signal is needed in user space. Please see Patch #1 for 
details of use case and kernel implementation.
 
Patch #2 added some bpf self tests for the new helper.
 
Changelogs:
  v2 -> v3:
    - More simplification for skeleton codes by removing not-needed
      mmap code and redundantly created tracepoint link.
  v1 -> v2: 
    - More description for the difference between bpf_send_signal()
      and bpf_send_signal_thread() in the uapi header bpf.h. 
    - Use skeleton and mmap for send_signal test.

Yonghong Song (2):
  bpf: add bpf_send_signal_thread() helper
  tools/bpf: add self tests for bpf_send_signal_thread()

 include/uapi/linux/bpf.h                      |  19 ++-
 kernel/trace/bpf_trace.c                      |  27 +++-
 tools/include/uapi/linux/bpf.h                |  19 ++-
 .../selftests/bpf/prog_tests/send_signal.c    | 128 +++++++-----------
 .../bpf/progs/test_send_signal_kern.c         |  51 +++----
 5 files changed, 131 insertions(+), 113 deletions(-)

-- 
2.17.1

