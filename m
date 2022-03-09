Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC94D2B5C
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 10:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiCIJGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 04:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiCIJGH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 04:06:07 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2216F16BCDD
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 01:05:07 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22961Han005625
        for <bpf@vger.kernel.org>; Wed, 9 Mar 2022 01:05:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=904+qYWXii4VyKevx9RkCDXwccKJTfTCWm36Vv74US0=;
 b=qFJ85hytLi6dFCIfZKW+zUPKtzdGNIyPu3SL/n3QaiowuThxrTMMOeXLz7lrJDo/vpkN
 2aKiOjuBbmbtRaFcThBwj5ceRJMcCD8p/ZOuvYqt4JZrd5vtXvpbLsWF4jx1FUPjOJGD
 oIDbxgNsR5QWjPAvdD8Asphd/RWe1S4X0Ms= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eppkk0pmd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 01:05:06 -0800
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 01:05:04 -0800
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id A40D11ADC5E4; Wed,  9 Mar 2022 01:04:56 -0800 (PST)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Subject: [PATCH bpf-next 2/5] bpf: Simplify insn rewrite on BPF_READ __sk_buff->tstamp
Date:   Wed, 9 Mar 2022 01:04:56 -0800
Message-ID: <20220309090456.3711530-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309090444.3710464-1-kafai@fb.com>
References: <20220309090444.3710464-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8Dos9A7jmk_yn9vwrCyrtqzj9Qq7GaNs
X-Proofpoint-GUID: 8Dos9A7jmk_yn9vwrCyrtqzj9Qq7GaNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The skb->tc_at_ingress and skb->mono_delivery_time are at the same
byte offset.  Thus, only one BPF_LDX_MEM(BPF_B) is needed
and both bits can be tested together.

/* BPF_READ: a =3D __sk_buff->tstamp */
if (skb->tc_at_ingress && skb->mono_delivery_time)
	a =3D 0;
else
	a =3D skb->tstamp;

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/filter.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 738a294a3c82..2c83d1f38704 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8956,21 +8956,22 @@ static struct bpf_insn *bpf_convert_tstamp_read(c=
onst struct bpf_prog *prog,
 	__u8 skb_reg =3D si->src_reg;
=20
 #ifdef CONFIG_NET_CLS_ACT
+	/* If the delivery_time_type is read,
+	 * the bpf prog is aware the tstamp could have delivery time.
+	 * Thus, read skb->tstamp as is if delivery_time_access is true.
+	 */
 	if (!prog->delivery_time_access) {
+		/* AX is needed because src_reg and dst_reg could be the same */
 		__u8 tmp_reg =3D BPF_REG_AX;
=20
 		*insn++ =3D BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, PKT_VLAN_PRESENT_OFFS=
ET);
-		*insn++ =3D BPF_ALU32_IMM(BPF_AND, tmp_reg, TC_AT_INGRESS_MASK);
-		*insn++ =3D BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0, 5);
-		/* @ingress, read __sk_buff->tstamp as the (rcv) timestamp,
-		 * so check the skb->mono_delivery_time.
-		 */
-		*insn++ =3D BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
-				      PKT_VLAN_PRESENT_OFFSET);
 		*insn++ =3D BPF_ALU32_IMM(BPF_AND, tmp_reg,
-					SKB_MONO_DELIVERY_TIME_MASK);
-		*insn++ =3D BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0, 2);
-		/* skb->mono_delivery_time is set, read 0 as the (rcv) timestamp. */
+					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
+		*insn++ =3D BPF_JMP32_IMM(BPF_JNE, tmp_reg,
+					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
+		/* skb->tc_at_ingress && skb->mono_delivery_time,
+		 * read 0 as the (rcv) timestamp.
+		 */
 		*insn++ =3D BPF_MOV64_IMM(value_reg, 0);
 		*insn++ =3D BPF_JMP_A(1);
 	}
--=20
2.30.2

