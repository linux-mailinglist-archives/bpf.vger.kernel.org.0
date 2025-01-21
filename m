Return-Path: <bpf+bounces-49334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A4A17691
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 05:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8057F188B264
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 04:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040C1922FB;
	Tue, 21 Jan 2025 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZLc7tUfQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSAL5ixW"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5B1A8F7A;
	Tue, 21 Jan 2025 04:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434137; cv=none; b=GmClSL3FaDLIhLNlwt9hL1kINettp2iJ1nBQypv9m4eYL716RJDa/3osyaA5LyrhA+8c4MuzhtSw2PP7eU9rXBXd/8dpqBVdkdPCkMoDutI7QKGznVGVSGD6vlEahhmkg1ILOjKrnWI9jWFRtPs2HJHZvAQbqmkSGRQ2pah7KfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434137; c=relaxed/simple;
	bh=eVM7SdtXCFlUVH4oy/Vkcn3phtLYk4plrqvtCWZRjUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6DNZmNiCyEdGU3spfW8dmQSq56JR/TRTo9O6vGOmO/w0aNKEZQZn6wS3upoK64Ewy7KGMdYbDKKedC45NyQ9Jz4CnXxgH4PWYtjtW9N6+tsR0H+2OpRC/WiHipd3h+AychiE/y2bC3rmvliTTZTV9QeUxAiD+vVrN+PDx/EDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ZLc7tUfQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSAL5ixW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A922111401CA;
	Mon, 20 Jan 2025 23:35:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 20 Jan 2025 23:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737434134; x=
	1737520534; bh=rLsYj07eT2ZgMjURoHuQghZV4EHGquLJkQ6YJEcpFpQ=; b=Z
	Lc7tUfQPfpSIDE8rmrR+JI286lmvZbFvC7/2tLp5A4KswkXteX53qnyliP27Khqi
	BvoJs1MIsDeBWDOFl1LlbxV5a800IwK4AJ+tqaxyarxP79BoojTgwPk1jdQAnUlE
	dohhjMzi6ObQDST56uaDrQRB/YMc0ITThtttt/ZulCBXuNf9LhUuz80TGEo2nrJP
	/LbhzNDF5RGeg20zRGJnfrxs0nyAx4kHksn8uA+BCLj49NQ+gbAL6D3MlxR73QTK
	tMXsQSFF8qx3swCgQfr/63FM9z203NxCAol9NeY5RTuOjf+qikj7LrrtUGdM31p/
	/Dv2Pg6oJe9afcXryDM3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737434134; x=1737520534; bh=r
	LsYj07eT2ZgMjURoHuQghZV4EHGquLJkQ6YJEcpFpQ=; b=SSAL5ixWDnss6aW2j
	9DjM2r9L33oINZKhHGk2cxZpvCzOC//HeN0DiWxB47CnZeiGa1NTPxsG+MHt3DmI
	ELa64sZU9c4g6iqhdKoyuDFfm9O2i/wCjt3Spb4YBibnv1XXyDkdwU9SkdeN8lwu
	8N/Z8V1WpJ5SSBhCFKuHZO5PfRr7iWVdIdeBySeuGGP7yc5MaxKCwdxZ+O4oep35
	x+723wcbr5Xjll6LkoNAu3NecFL6oe++ivCzbK+0IXsxvY4XgBdaD26D8Mjc1jJm
	QG8cgusjbGIvehFczGXwX/7bePtomfErTiU58FPPHzrfJz5dcuj1h/V8lT1UjR+C
	Q/goQ==
X-ME-Sender: <xms:FiSPZ8rxXepHUV-1ZAzC_SJRX2O3cf2HgJ6kLfMIVAB28KLEhZh48Q>
    <xme:FiSPZyqLaYsCuzRyhr_5Z6RKYFtuXrhd3EydS4xdHeIW3RzHYh0DCMg0_15EV7w1T
    FJSWQx70QMIl2JoRg>
X-ME-Received: <xmr:FiSPZxNVEN38IhmJetSoTM8UQ0xu9H8XcFsRF5fufpTFV-_OkMfNCeYBqfZ7GIeMlFNcFGncQb9DD5RFvXtt_dYRM5Smn9r69_emyRxO13AGthntmQ_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhope
    grshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtg
    hpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhnghes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinh
    hugidruggvvhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdr
    tghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FiSPZz63yvglGUyB5ce0ig1yptSG_WiS_nEQbnBMutxJYAMGr8QuNg>
    <xmx:FiSPZ759XfwNWDGVcj7wCY3ai2RbRH5UHuaS_pz3e6pmwR0NHy9qmQ>
    <xmx:FiSPZzja1aKTGeBBGb1NIpPUc0EzI4zdC0GflaaEd-S23kozGJ-u1w>
    <xmx:FiSPZ17LWaUzepP38INLjXbzJh0jLIjPaSMf8lhE_i-WJcNoeWkGFA>
    <xmx:FiSPZ6RLQr49-kyONtxZLXbqMcXznfm3vGKKW88lmhSKvxGtEqTP46KO>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 23:35:32 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/3] bpf: arraymap: Skip boundscheck during inlining when possible
Date: Mon, 20 Jan 2025 21:35:12 -0700
Message-ID: <7bfb3b6b1d3400d03fd9b7a7e15586c826449c71.1737433945.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737433945.git.dxu@dxuuu.xyz>
References: <cover.1737433945.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For regular arraymaps and percpu arraymaps, if the lookup is known to be
inbounds, the inlined bounds check can be omitted. One fewer jump puts less
pressure on the branch predictor. While it probably won't affect real
workloads much, we can basically get this for free. So might as well -
free wins are nice.

JIT diff for regular arraymap (x86-64):

     ; val = bpf_map_lookup_elem(&map_array, &key);
    -  22:   movabsq $-131387164803072, %rdi
    +  22:   movabsq $-131387246749696, %rdi
       2c:   addq    $472, %rdi
       33:   movl    (%rsi), %eax
    -  36:   cmpq    $2, %rax
    -  3a:   jae     0x45
    -  3c:   imulq   $48, %rax, %rax
    -  40:   addq    %rdi, %rax
    -  43:   jmp     0x47
    -  45:   xorl    %eax, %eax
    -  47:   movl    $4, %edi
    +  36:   imulq   $48, %rax, %rax
    +  3a:   addq    %rdi, %rax
    +  3d:   jmp     0x41
    +  3f:   xorl    %eax, %eax
    +  41:   movl    $4, %edi

JIT diff for percpu arraymap (x86-64):

     ; val = bpf_map_lookup_elem(&map_array_pcpu, &key);
    -  22:   movabsq $-131387183532032, %rdi
    +  22:   movabsq $-131387273779200, %rdi
       2c:   addq    $472, %rdi
       33:   movl    (%rsi), %eax
    -  36:   cmpq    $2, %rax
    -  3a:   jae     0x52
    -  3c:   shlq    $3, %rax
    -  40:   addq    %rdi, %rax
    -  43:   movq    (%rax), %rax
    -  47:   addq    %gs:170664, %rax
    -  50:   jmp     0x54
    -  52:   xorl    %eax, %eax
    -  54:   movl    $4, %edi
    +  36:   shlq    $3, %rax
    +  3a:   addq    %rdi, %rax
    +  3d:   movq    (%rax), %rax
    +  41:   addq    %gs:170664, %rax
    +  4a:   jmp     0x4e
    +  4c:   xorl    %eax, %eax
    +  4e:   movl    $4, %edi

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/arraymap.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 8dbdceeead95..7385104dc0d0 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -221,11 +221,13 @@ static int array_map_gen_lookup(struct bpf_map *map,
 
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
-	if (!map->bypass_spec_v1) {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4);
-		*insn++ = BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
-	} else {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 3);
+	if (!inbounds) {
+		if (!map->bypass_spec_v1) {
+			*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4);
+			*insn++ = BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
+		} else {
+			*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 3);
+		}
 	}
 
 	if (is_power_of_2(elem_size)) {
@@ -269,11 +271,13 @@ static int percpu_array_map_gen_lookup(struct bpf_map *map,
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct bpf_array, pptrs));
 
 	*insn++ = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0);
-	if (!map->bypass_spec_v1) {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 6);
-		*insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);
-	} else {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 5);
+	if (!inbounds) {
+		if (!map->bypass_spec_v1) {
+			*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 6);
+			*insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);
+		} else {
+			*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 5);
+		}
 	}
 
 	*insn++ = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
-- 
2.47.1


