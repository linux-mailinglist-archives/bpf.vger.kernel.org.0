Return-Path: <bpf+bounces-59687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C0AACE6A2
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 00:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDB63A87BC
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931D221DAE;
	Wed,  4 Jun 2025 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lQP3IBbe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A711EEA47
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076117; cv=none; b=BQ5cPsITbSP274y8LgwemfD574ACQ+RN18qVPaGg8D+BwltQ7jDv8m6zaxnuj7UjrZbXj0KAdu2nQumaUgeuXwie2v2e0+PIVaevXmFQKa36uSkfpyVt0ZaAoWCJV169QtpjkS7OpT58tpLMb/gnE4ydNVgg36xuL9L4UQi1wgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076117; c=relaxed/simple;
	bh=ModqsCBrFmdPKCY7KyZBdvaVC9o4FwbS4e0il+sD1Pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKmKjNGvsxSLyvZYKNLwjdgr5bQ7b1KSnRBz/4fTM7AbM2EbjyzfjI6JyEgodkyRlZGOgl/5r3+pNIs+4Hzpq9YdFjCrWPiRYvNB6qyC61NeP4SvA8SvUyQBMSCzAGqPeEZVdfNa4vMmBKmvvGfVjzGkSQmG0ubP7S2NzMsfnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lQP3IBbe; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 554MPi8D003528
	for <bpf@vger.kernel.org>; Wed, 4 Jun 2025 15:28:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=SwkVB8OB/PCyzLTD4BGRlVMqGcpAxsh3XvN0roqoU8I=; b=
	lQP3IBbeWgftvBTKv4uVBsGrjghcThVp6M5sTzN/Y4XMXmv3vhMRQYEP7We2Y/Ae
	CBQ5ekiSpmvFeaquDiXZHFMrNFy5mB2rqSYJoMuyi7qnt5sZAT4gIv7HHQpz4+1r
	EBKMugCs5tV43ZbsRb77CNW6agnKvj7SIaacriYb0FeCCZxRuN1QNagqNwG5XGTz
	ItTanbYaHVK5Fkf+mypd9zWJzW80rrcSGca6rjWkZCzehMQH4jmCLSreSDNBckam
	JO8CYQ6/oxR55uXYit4jLQ8DCufvFE408/xA63WOiNe+fKICOhYdZ0XhfQHxOVbb
	2pGoA9Vaphtdkr2864DgIQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 472nqpmrq8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 15:28:33 -0700 (PDT)
Received: from twshared15756.17.prn3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 4 Jun 2025 22:28:06 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 1F57446C87C; Wed,  4 Jun 2025 15:27:59 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <yonghong.song@linux.dev>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: add test cases with CONST_PTR_TO_MAP null checks
Date: Wed, 4 Jun 2025 15:27:29 -0700
Message-ID: <20250604222729.3351946-3-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250604222729.3351946-1-isolodrai@meta.com>
References: <20250604222729.3351946-1-isolodrai@meta.com>
Reply-To: <ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE4NSBTYWx0ZWRfX5HxOQgOAy3IA HK9ey76kt2bWu9i1L9SAyur0ZtcWFVFxzbQJ6tHxGMEZHJamsqsNVBB/gu6SdS9rAegAa2VL32g jiJ2Mftuv7FQOMBGH31C4FnbeJ0tulQMcrD89P1YQYhYSLFpYNLU/C7KuWsFZergqNKg4vKio5T
 S9bizcQ8igWlEAil4FFdl6S+h3B0t+8q+sxFvvefU4FW0vnKtByqKktP6IAzBF12cZ4QHvPxahb QNHuwbpVAxK6LZCIhZDBTx5+N2EcVG5iHOwJ104dcTDzVdl//in+367VMF8EKvo0M1ATZm1hR2K /QT8QG7C6hlkwhFCFChLqUT3N1hz+fkTAA8f2JWVsGA1OmF+QfwfePvj3GJ2K6OegJcRY4qryMg
 GRCMGaToD4nG/jcJ/0VElWYQAHzuk+OLS9WulVUvQS9/j3BKgvSPrOaw3/AJGcml5RpGb9Pv
X-Proofpoint-ORIG-GUID: d2qaVwmKKMacVdzl77NzVIrVXgozIZb9
X-Authority-Analysis: v=2.4 cv=M7NNKzws c=1 sm=1 tr=0 ts=6840c891 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=-RqxKfJqtAKTVEPrGAIA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: d2qaVwmKKMacVdzl77NzVIrVXgozIZb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01

A test requires the following to happen:
  * CONST_PTR_TO_MAP value is put on the stack
  * then this value is checked for null
  * the code in the null branch fails verification

I was able to achieve this by using a stack allocated array of maps,
populated with values from a global map. This is the first test case:
map_ptr_is_never_null.

The second test case (map_ptr_is_never_null_rb) involves an array of
ringbufs and attempts to recreate a common coding pattern [1].

[1] https://lore.kernel.org/bpf/CAEf4BzZNU0gX_sQ8k8JaLe1e+Veth3Rk=3D4x7MD=
hv=3DhQxvO8EDw@mail.gmail.com/

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../selftests/bpf/progs/verifier_map_in_map.c | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/to=
ols/testing/selftests/bpf/progs/verifier_map_in_map.c
index 7d088ba99ea5..1dd5c6902c53 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -139,4 +139,81 @@ __naked void on_the_inner_map_pointer(void)
 	: __clobber_all);
 }
=20
+SEC("socket")
+int map_ptr_is_never_null(void *ctx)
+{
+	struct bpf_map *maps[2] =3D { 0 };
+	struct bpf_map *map =3D NULL;
+	int __attribute__((aligned(8))) key =3D 0;
+
+	for (key =3D 0; key < 2; key++) {
+		map =3D bpf_map_lookup_elem(&map_in_map, &key);
+		if (map)
+			maps[key] =3D map;
+		else
+			return 0;
+	}
+
+	/* After the loop every element of maps is CONST_PTR_TO_MAP so
+	 * the invalid branch should not be explored by the verifier.
+	 */
+	if (!maps[0])
+		asm volatile ("r10 =3D 0;");
+
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_RINGBUF);
+		__uint(max_entries, 4096);
+	});
+} rb_in_map SEC(".maps");
+
+struct rb_ctx {
+	void *rb;
+	struct bpf_dynptr dptr;
+};
+
+static __always_inline struct rb_ctx __rb_event_reserve(__u32 sz)
+{
+	struct rb_ctx rb_ctx =3D {};
+	void *rb;
+	__u32 cpu =3D bpf_get_smp_processor_id();
+	__u32 rb_slot =3D cpu & 1;
+
+	rb =3D bpf_map_lookup_elem(&rb_in_map, &rb_slot);
+	if (!rb)
+		return rb_ctx;
+
+	rb_ctx.rb =3D rb;
+	bpf_ringbuf_reserve_dynptr(rb, sz, 0, &rb_ctx.dptr);
+
+	return rb_ctx;
+}
+
+static __noinline void __rb_event_submit(struct rb_ctx *ctx)
+{
+	if (!ctx->rb)
+		return;
+
+	/* If the verifier (incorrectly) concludes that ctx->rb can be
+	 * NULL at this point, we'll get "BPF_EXIT instruction in main
+	 * prog would lead to reference leak" error
+	 */
+	bpf_ringbuf_submit_dynptr(&ctx->dptr, 0);
+}
+
+SEC("socket")
+int map_ptr_is_never_null_rb(void *ctx)
+{
+	struct rb_ctx event_ctx =3D __rb_event_reserve(256);
+	__rb_event_submit(&event_ctx);
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.47.1


