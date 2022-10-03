Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8037D5F277A
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 03:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJCBRu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Oct 2022 21:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJCBRo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Oct 2022 21:17:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF2B36DE1
        for <bpf@vger.kernel.org>; Sun,  2 Oct 2022 18:17:43 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 292FXUnJ002903
        for <bpf@vger.kernel.org>; Sun, 2 Oct 2022 18:17:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=hlp5ryTmqjBjQ2EEXTXmXfekvKB1OsQjLVQVH3KW2MU=;
 b=TGcGd+26mavBDPjJvc0eDCyKRAI6t4yw014+oflS8UjJFwueS2CWRDIqqN+iJpXYBAG0
 anTeKy4Ws2VkYico86U4tM7s+W12yD/HFzQspay3/fD6tHumBxmogo8Huz+AuWXZYJPO
 0jpzMD430WXxr5L7MAM2tSMTTU2NWUJbAA0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jxk8qxy2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 02 Oct 2022 18:17:43 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 2 Oct 2022 18:17:41 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id 734F410FF8977; Sun,  2 Oct 2022 18:17:29 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next] bpf,x64: Remove unnecessary check on existence of SSE2
Date:   Sun, 2 Oct 2022 18:17:27 -0700
Message-ID: <20221003011727.1192900-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rbRmADNS7_Cb6XclFJ_q0navoKQGfpNX
X-Proofpoint-ORIG-GUID: rbRmADNS7_Cb6XclFJ_q0navoKQGfpNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-02_04,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SSE2 and hence lfence are architectural in x86-64 and no need to check
whether they're supported in CPU.

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d09c54f3d2e0..b2124521305e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1289,8 +1289,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
=20
 			/* speculation barrier */
 		case BPF_ST | BPF_NOSPEC:
-			if (boot_cpu_has(X86_FEATURE_XMM2))
-				EMIT_LFENCE();
+			EMIT_LFENCE();
 			break;
=20
 			/* ST: *(u8*)(dst_reg + off) =3D imm */
--=20
2.30.2

