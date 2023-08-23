Return-Path: <bpf+bounces-8337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0611A784E86
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 04:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33A628125D
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724C217C6;
	Wed, 23 Aug 2023 02:07:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E715BC
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 02:07:10 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88408E4A;
	Tue, 22 Aug 2023 19:07:08 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-570c51530e5so2077997eaf.3;
        Tue, 22 Aug 2023 19:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692756428; x=1693361228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU5FNyFto872iS/tgMcoUPNuBwmFiNSaWS6P6+DDA0A=;
        b=bqPT7KEGvEt18ZuX9+5swBL7588zuwbuMEViBE41KMRQ6MdDCO0QThdph7lElc9zNZ
         3Ymtv4PjGYjWE42q4cLbs4SCuRKlxUN4kle+V0k2jEh/yxkck+re40e7ob0uDCON8Smw
         oWUObyw22V2bAFc+Yc9RCKpq63fbmfkQk6mLaN57sAO64ZPsvhLHWzS9ucZuwtPC5efi
         SQ8E0qzMfrAVEskFvIFUJIPByQNbAL5L/XxXWM+fwcuGrtWB14jUYTPyRn4Z6AWVM2WI
         +CeFdaGw87X+O4l3CU9yaQ3qzr7PCPEDqBEZVklu+WpGHlHAajedKjClKH3fz4sIi3Xd
         pUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692756428; x=1693361228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mU5FNyFto872iS/tgMcoUPNuBwmFiNSaWS6P6+DDA0A=;
        b=RVOEL2VppRh4TcQXOk+pHyzcYj/R5iS9Wi+4r+PrR6RDl7BJTzIV3f0mlaas6LUPN/
         yVaNDk4BHyjdMfzXPdrI9KLerFl4Qw17+l5C//zc5b7f/0CdGkR+oz1/0RAXJwOLLJi0
         ZxJWxr1n2o5ceVYxjBccQ6iyduVYDLjB++6p0BBUaPDENZLSVCQ+ArY6P2MhV77XbFqE
         YbN2abK1Vi6rCGgMSLp1KX1ZNpMqvhhg2lXaoFuI3sUmb1FQ2Q5NcrOO9DdVlo/61hqb
         iWxsWtJ8ruLd8lO05lFnNCTExT2CamL4jeH42q7EZ5JwLMoqimEyQgnRIniUw7bu8+Xg
         /Ihg==
X-Gm-Message-State: AOJu0YyOWGk2siv3AX8IUsY7Qkrc9TRz4M773iCgBipZCksS0Eg9zLo8
	3tq6MWE2bBdEu/usG3t7tPMwtn7xOqYcNg+0
X-Google-Smtp-Source: AGHT+IEeK3Vu67X8WCCYwtmrQ+ZC4f647aPpKtj9+3HlQa7BuPidkBfHgPUcMNKxzbhjH7bgJmpn9A==
X-Received: by 2002:a05:6358:2608:b0:134:c785:5932 with SMTP id l8-20020a056358260800b00134c7855932mr10335787rwc.32.1692756427789;
        Tue, 22 Aug 2023 19:07:07 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7804f000000b0064f7c56d8b7sm8313627pfm.219.2023.08.22.19.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 19:07:07 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 bpf-next 1/2] bpf: Fix issue in verifying allow_ptr_leaks
Date: Wed, 23 Aug 2023 02:07:02 +0000
Message-Id: <20230823020703.3790-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230823020703.3790-1-laoar.shao@gmail.com>
References: <20230823020703.3790-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After we converted the capabilities of our networking-bpf program from
cap_sys_admin to cap_net_admin+cap_bpf, our networking-bpf program
failed to start. Because it failed the bpf verifier, and the error log
is "R3 pointer comparison prohibited".

A simple reproducer as follows,

SEC("cls-ingress")
int ingress(struct __sk_buff *skb)
{
	struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);

	if ((long)(iph + 1) > (long)skb->data_end)
		return TC_ACT_STOLEN;
	return TC_ACT_OK;
}

Per discussion with Yonghong and Alexei [1], comparison of two packet
pointers is not a pointer leak. This patch fixes it.

Our local kernel is 6.1.y and we expect this fix to be backported to
6.1.y, so stable is CCed.

[1]. https://lore.kernel.org/bpf/CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94aXSy4uQ9vBg@mail.gmail.com/

Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: stable@vger.kernel.org
---
 kernel/bpf/verifier.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ccca1f..b6b60cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14047,6 +14047,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	/* check src2 operand */
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+	if (err)
+		return err;
+
+	dst_reg = &regs[insn->dst_reg];
 	if (BPF_SRC(insn->code) == BPF_X) {
 		if (insn->imm != 0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -14058,12 +14064,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		if (err)
 			return err;
 
-		if (is_pointer_value(env, insn->src_reg)) {
+		src_reg = &regs[insn->src_reg];
+		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)) &&
+		    is_pointer_value(env, insn->src_reg)) {
 			verbose(env, "R%d pointer comparison prohibited\n",
 				insn->src_reg);
 			return -EACCES;
 		}
-		src_reg = &regs[insn->src_reg];
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -14071,12 +14078,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		}
 	}
 
-	/* check src2 operand */
-	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
-	if (err)
-		return err;
-
-	dst_reg = &regs[insn->dst_reg];
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 
 	if (BPF_SRC(insn->code) == BPF_K) {
-- 
1.8.3.1


