Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97344179736
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 18:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCDRxP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 12:53:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11206 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726561AbgCDRxP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 12:53:15 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 024Hha4j029994
        for <bpf@vger.kernel.org>; Wed, 4 Mar 2020 09:53:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=R+J1LbJnF+sejUQXpLAYjfjFvzkTyC0ciHu9FP6Uymw=;
 b=E/WfyQYgcLeqjOKOa8gfanB8/plLzS2jB17ERu8rd+MAKeZSyFuJjZRTL9ffsQEaIZg0
 zfjDsERy0++FJGHJ3Jqd179siDX4o6vcCmX3kuFAULnLp1ckqiL+JfF355dubYGLDOln
 QkZgWdyek+dHOS2eUSlCGjGu6MKGYt1hH4k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 2yhwxxnrky-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 09:53:14 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 09:53:12 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 4707437010C5; Wed,  4 Mar 2020 09:53:10 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v2 0/2] bpf: Fix deadlock with rq_lock in bpf_send_signal()
Date:   Wed, 4 Mar 2020 09:53:10 -0800
Message-ID: <20200304175310.2389842-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=13 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040123
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
introduced bpf_send_signal() helper and Commit 8482941f0906
("bpf: Add bpf_send_signal_thread() helper") added bpf_send_signal_thread()
helper. Both helpers try to send a signel to current process or thread.

When bpf_prog is called with scheduler rq_lock held, a deadlock
could happen since bpf_send_signal() and bpf_send_signal_thread()
will call group_send_sig_info() which may ultimately want to acquire
rq_lock() again. This happens in 5.2 and 4.16 based kernels in our
production environment with perf_sw_event.

In a different scenario, the following is also possible in the last kernel:
  cpu 1:
     do_task_stat <- holding sighand->siglock
     ...
     task_sched_runtime <- trying to grab rq_lock

  cpu 2:
     __schedule <- holding rq_lock
     ...
     do_send_sig_info <- trying to grab sighand->siglock

Commit eac9153f2b58 ("bpf/stackmap: Fix deadlock with
rq_lock in bpf_get_stack()") has a similar issue with above
rq_lock() deadlock. This patch set addressed the issue
in a similar way. Patch #1 provided kernel solution and
Patch #2 added a selftest.

Changelogs:
  v1 -> v2:
    . previous fix using task_work in nmi() is incorrect.
      there is no nmi() involvement here. Using task_work
      in all cases might be a solution. But decided to
      use a similar fix as in Commit eac9153f2b58.

Yonghong Song (2):
  bpf: Fix deadlock with rq_lock in bpf_send_signal()
  selftests/bpf: add send_signal_sched_switch test

 kernel/trace/bpf_trace.c                      |  5 +-
 .../bpf/prog_tests/send_signal_sched_switch.c | 89 +++++++++++++++++++
 .../bpf/progs/test_send_signal_kern.c         |  6 ++
 3 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c

-- 
2.17.1

