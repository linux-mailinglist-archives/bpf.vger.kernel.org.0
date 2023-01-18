Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69886729A7
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 21:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjARUsY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 15:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjARUsY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 15:48:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECDA470A9
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 12:48:23 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IKdBlk032583
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 12:48:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=SzpPR/ZCkZ7B3nf26yQCHx3G5PSqqSXpyJoPWZSSIQ8=;
 b=k6FvvO9Kl7lzE3IDqae7AAoOAUe/8nLqJ1b/jW3VsLufaRlR7VQGx7RihLdlf/8zF568
 WxdFjnP53eaNiA8QAx48ZfWeeEBVg69K1C0D3U5oOm/BNk8SN3Jps7FItrsI7lKVWGoG
 ciItUzNIE70gbnLV64ptI1EXcD0n6bKoQS8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n6h1mjrbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 12:48:22 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 12:48:20 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 8828B15E73EE4; Wed, 18 Jan 2023 12:48:15 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf] bpf: Fix a possible task gone issue with bpf_send_signal[_thread]() helpers
Date:   Wed, 18 Jan 2023 12:48:15 -0800
Message-ID: <20230118204815.3331855-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Fp1MKM-gNb_PyXIsDPZocq4353XCX_eG
X-Proofpoint-ORIG-GUID: Fp1MKM-gNb_PyXIsDPZocq4353XCX_eG
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In current bpf_send_signal() and bpf_send_signal_thread() helper
implementation, irq_work is used to handle nmi context. Hao Sun
reported in [1] that the current task at the entry of the helper
might be gone during irq_work callback processing. To fix the issue,
a reference is acquired for the current task before enqueuing into
the irq_work so that the queued task is still available during
irq_work callback processing.

  [1] https://lore.kernel.org/bpf/20230109074425.12556-1-sunhao.th@gmail.co=
m/

Fixes: 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
Tested-by: Hao Sun <sunhao.th@gmail.com>
Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

NOTE:
  I didn't add a unit test case since it is very hard to construct one
  which can reliably reproducing the issue in short amount of time.
  I cannot even reproduce the issue with Hao's reproducer in my local
  environment. Hopefully, the patch itself can explain the issue
  and the fix.

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f47274de012b..c09792c551bf 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -833,6 +833,7 @@ static void do_bpf_send_signal(struct irq_work *entry)
=20
 	work =3D container_of(entry, struct send_signal_irq_work, irq_work);
 	group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->type);
+	put_task_struct(work->task);
 }
=20
 static int bpf_send_signal_common(u32 sig, enum pid_type type)
@@ -867,7 +868,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_typ=
e type)
 		 * to the irq_work. The current task may change when queued
 		 * irq works get executed.
 		 */
-		work->task =3D current;
+		work->task =3D get_task_struct(current);
 		work->sig =3D sig;
 		work->type =3D type;
 		irq_work_queue(&work->irq_work);
--=20
2.30.2

