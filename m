Return-Path: <bpf+bounces-79510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 262C2D3B7B5
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F65E3027587
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C502E228C;
	Mon, 19 Jan 2026 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PNhlhes2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4D2E4257
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852442; cv=none; b=l3JoI8HYMxnAf3A7nzBYIMxCkrCtkCyrkvGXN3djefB4XqxUNPMMv3mZIi/inRlSPpleIkyqxvSB0atMlWJv8ijZ/sanYNI20iO9aVPKuz23sG9/oFVQQpwQiz+Mk1C2vkRXf7Yh+NQXmTsUcwM2Z0QfACV0oVlFh83P9CciWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852442; c=relaxed/simple;
	bh=XPY8f92gY5l+PxSggY67J74gEUpY715vo4yA93jjTvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3JZK4klOtQty6YjlxFFOsGQYqvnRwx/vfeAhqaQuZwmINhMQi3jZEyFoFiciFT26h3ZlOSXL1HvMMc9Ttpi/wVR5/gJOtSZodbW/3qZuZD3hpRoUaUy2sW4d/qQA+pAJI/ZqCp6BrnaphCExL1LxQqdzmYWOeS+gbHk0r6BkVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PNhlhes2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b879d5c1526so663787966b.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768852438; x=1769457238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h04Zr1La7PRpKhgRarx4qbf+Xu+NHw/7xbmMDgNEciE=;
        b=PNhlhes25ubUtoAhq7eBxZemthCGrKQ0UQy3F10EITc1gI9pAVy4kIIlivTTDnNkBd
         aCHwwobOaro2J82CwQ6ad3mObRP43QIDgIkMdUl8P4/U2XvdXyNvHeeA9TyP+oqRvILP
         t7OLhl2Kvw0/4jBnwMR2t4/GWb1uHtNufF39sG7qeMDd0nP2xfL2bqeJLutUy9CZ/oiv
         o3eehQpQFWPelhr2BkX04fS4pBnqo2+J5qHly47IfKw8pZJeFeN3cgXhzXzwFxS/heIN
         ea99qpvnUNQAdjr8LM44sgs68Qfe9r8P3ipszw4Yq24IvUiC0ELLq9/tcQ1oNqWnQ5Cl
         3giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852438; x=1769457238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h04Zr1La7PRpKhgRarx4qbf+Xu+NHw/7xbmMDgNEciE=;
        b=q0lMszb33gEZgo6qfINavYMGGi1OHSpHPcp9pv1tDPhSdW0hcYzBlS1NqEWo8e7kfo
         PDUvqmlyTdCRRGQP8xFW/dnZHL1iYQn72xfZK6+jSMnR7IIKu2u/ZzevihrJOc3CWuFw
         BtTg5kh6dCXlH936VIVsz41KZ77mBwgruzzf2uX9oZPv72B++GKyWnV/JRf9Tn38k4Pl
         kppLLv/p/Y0SnrmIJ7KWoMLwqO0ibhoIqWKEpY+A8EOjtSfiOjRy/V2Y+Wy3rhInV06O
         6bIhEEZlSFmSrFM+SCYUidpet0KorNDrPo6LQRTvPD1EyF1BuiHrvKvUfXnOD9/i8ztX
         wGrg==
X-Gm-Message-State: AOJu0YyFmdgnv3yNtJZxmxVAMIpOGWjoulTU7xmjY9TxOCFbaK+iKtrN
	eUXXMT8xyhHAszdYrui2qh1csXS3dXxSU4DBkt3rcPP3Fa5VPxnIK8A5zhXg+lzvrU4=
X-Gm-Gg: AZuq6aIwcIOuZ3t+kGpmJRcsRT3OnY6z7+6UpcnQgzyXHTSFvQWUJfH4csqutDM8XkA
	Bm/52KyiQE34j+oefnYgLlblBlqD7vfhxXy1D3/lm3rNsFn/LFvo/xGaPmN3hcrFgpWwsn0ktfn
	otDD2pL6o0nKrI3eGEqBTc/w2+w5V1FwXaRDX3of2GMWiufLWybEUyyQLXDdiZ3F3S6q9W0MGbh
	YwPH1wOoyCxEeNiD47++wdNUkF//k3YOZPLWPFjPYFOd00A3Ze576qjmp7xqeorv0GMIMdWrtSr
	EP9uWKE8UhcebVsEWRvbxjv+8BTOznosVZ5koNu1T0zNn+Cn2jAhOU/LF1HfMZukSXmhKCoDcc6
	OojVU1ej6S9TWeuk3aGY8vQpAe0BlECwmgOmHHYraw7PNSNMmaWhDTiRCyMKPp7oy25vaqUsPBs
	scUSjrxEw6tofV2pymWJQ9/9NAyZf6Snd9PFfEAYOtEJLgBciIy0nHbJPsyGA=
X-Received: by 2002:a17:907:1c1f:b0:b87:2abc:4a26 with SMTP id a640c23a62f3a-b87968e2de0mr1059949566b.14.1768852438311;
        Mon, 19 Jan 2026 11:53:58 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9fbbsm1216423666b.38.2026.01.19.11.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:53:57 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 19 Jan 2026 20:53:52 +0100
Subject: [PATCH bpf-next 2/4] bpf: net_sched: Use direct helper calls
 instead of kfuncs in pro/epilogue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-2-e8b88d6430d8@cloudflare.com>
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Convert bpf_qdisc prologue and epilogue to use BPF_EMIT_CALL for direct
helper calls instead of BPF_CALL_KFUNC.

Remove the BTF_ID_LIST entries for these functions since they are no longer
registered as kfuncs.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/sched/bpf_qdisc.c | 76 ++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 098ca02aed89..cad9701d3b95 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -130,7 +130,30 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
-BTF_ID_LIST_SINGLE(bpf_qdisc_init_prologue_ids, func, bpf_qdisc_init_prologue)
+/* bpf_qdisc_init_prologue - Called in prologue of .init. */
+BPF_CALL_2(bpf_qdisc_init_prologue, struct Qdisc *, sch,
+	   struct netlink_ext_ack *, extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct Qdisc *p;
+
+	qdisc_watchdog_init(&q->watchdog, sch);
+
+	if (sch->parent != TC_H_ROOT) {
+		/* If qdisc_lookup() returns NULL, it means .init is called by
+		 * qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
+		 * has not been added to qdisc_hash yet.
+		 */
+		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
+		if (p && !(p->flags & TCQ_F_MQROOT)) {
+			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
 
 static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 				  const struct bpf_prog *prog)
@@ -151,7 +174,7 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 16);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);
+	*insn++ = BPF_EMIT_CALL(bpf_qdisc_init_prologue);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1);
 	*insn++ = BPF_EXIT_INSN();
 	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
@@ -160,7 +183,15 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	return insn - insn_buf;
 }
 
-BTF_ID_LIST_SINGLE(bpf_qdisc_reset_destroy_epilogue_ids, func, bpf_qdisc_reset_destroy_epilogue)
+/* bpf_qdisc_reset_destroy_epilogue - Called in epilogue of .reset and .destroy */
+BPF_CALL_1(bpf_qdisc_reset_destroy_epilogue, struct Qdisc *, sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+
+	return 0;
+}
 
 static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
 				  s16 ctx_stack_off)
@@ -178,7 +209,7 @@ static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_pr
 	 */
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_reset_destroy_epilogue_ids[0]);
+	*insn++ = BPF_EMIT_CALL(bpf_qdisc_reset_destroy_epilogue);
 	*insn++ = BPF_EXIT_INSN();
 
 	return insn - insn_buf;
@@ -230,41 +261,6 @@ __bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64
 	qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
 }
 
-/* bpf_qdisc_init_prologue - Hidden kfunc called in prologue of .init. */
-__bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
-					struct netlink_ext_ack *extack)
-{
-	struct bpf_sched_data *q = qdisc_priv(sch);
-	struct net_device *dev = qdisc_dev(sch);
-	struct Qdisc *p;
-
-	qdisc_watchdog_init(&q->watchdog, sch);
-
-	if (sch->parent != TC_H_ROOT) {
-		/* If qdisc_lookup() returns NULL, it means .init is called by
-		 * qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
-		 * has not been added to qdisc_hash yet.
-		 */
-		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
-		if (p && !(p->flags & TCQ_F_MQROOT)) {
-			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-/* bpf_qdisc_reset_destroy_epilogue - Hidden kfunc called in epilogue of .reset
- * and .destroy
- */
-__bpf_kfunc void bpf_qdisc_reset_destroy_epilogue(struct Qdisc *sch)
-{
-	struct bpf_sched_data *q = qdisc_priv(sch);
-
-	qdisc_watchdog_cancel(&q->watchdog);
-}
-
 /* bpf_qdisc_bstats_update - Update Qdisc basic statistics
  * @sch: The qdisc from which an skb is dequeued.
  * @skb: The skb to be dequeued.
@@ -282,8 +278,6 @@ BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
-BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
-BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
 BTF_ID_FLAGS(func, bpf_qdisc_bstats_update)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 

-- 
2.43.0


