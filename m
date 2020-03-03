Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0A178631
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 00:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCCXQC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 18:16:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44362 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727199AbgCCXQB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Mar 2020 18:16:01 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023NAo2c028073
        for <bpf@vger.kernel.org>; Tue, 3 Mar 2020 15:16:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=kjADTu40/usqjHcCGfbesUH36EVv82A7PHFpgKJ8kfQ=;
 b=qOSI9UmcDlIJYvM079aQSf3vCNJT15FxKRl0tDVOHBkmfI5b/eeUPPj2PVagv0HdhKnr
 nWFXJ8u2dLvdHEnRxQWp9/D/UTa+Rq2FlcP0Ucu0gZJGxqWmi04mG+IdJaLLq4XX12qP
 rjV6kwX6kNkXeNwvPaEVZvbBVh6R3hhNTfY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yht6y2hkx-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 15:16:00 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 3 Mar 2020 15:15:55 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id A67EE3701059; Tue,  3 Mar 2020 15:15:54 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 0/2] bpf: fix bpf_send_signal()/bpf_send_signal_thread() helper in NMI mode
Date:   Tue, 3 Mar 2020 15:15:54 -0800
Message-ID: <20200303231554.2553105-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_08:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=921
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 suspectscore=13 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003030151
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
introduced bpf_send_signal() helper and Commit 8482941f0906
("bpf: Add bpf_send_signal_thread() helper") added bpf_send_signal_thread()
helper. Both helpers try to send a signel to current process or thread.

When the bpf prog, hence the helper, is called in nmi mode,
the actual sending of signal is delayed to an irq_work.
But this is still not always safe as nmi could happen
in scheduler with scheduler lock is taken, later on
the routine to send signal may tries to acquire the same
spinlock and caused a deadlock. See patch #1 for more
detailed description of the problem and how to use
task_work to solve the problem.

Patch #2 is an optimization. task_work can be set up
directly in nmi mode if CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
is true. Indeed, CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is true
for most modern architectures.

Patch #1 is for bpf tree. Patch #2 is intended for bpf-next tree.

Yonghong Song (2):
  bpf: fix bpf_send_signal()/bpf_send_signal_thread() helper in NMI mode
  bpf: avoid irq_work for bpf_send_signal() if
    CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG

 kernel/trace/bpf_trace.c | 82 ++++++++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 15 deletions(-)

-- 
2.17.1

