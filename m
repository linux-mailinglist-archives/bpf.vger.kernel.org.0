Return-Path: <bpf+bounces-54410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92BA69B9B
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0BF98072B
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB421E0AC;
	Wed, 19 Mar 2025 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB4rYGib"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B121D599;
	Wed, 19 Mar 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421259; cv=none; b=e3r5hRVmTCgJpPfbnS6zuY3TJKNo+LtACnOOasc3VLvB6tr+3kdwz2pTYtLT9sh7hxu1bCT+nX+27lZZu1VrJZvbA4mXFEMCxsU4dU8oXgQbg3chkEM3NlQLRkqTBvcCDFL78LmLWCIQm6WPkz08cGOaBd1pUNyaxUx9znBjJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421259; c=relaxed/simple;
	bh=btqMoGbYeZhkkjj5rQSDn8rJfomeuwBI6ynVxR9DRDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCbPGqBCLR0+LWoOgb/OtRVGnCVToYSKTOXaeC7PXFPOtQS1F+js+TT7n7R1NeiRakmsZxashWi5t3lqNL3aTBK0+4hUxqgqpkBpn4sKy7rbzSyPLXTqwjPhFDqKY7EjScxqsywbJgITm13nCV98NUEsqOnkq51dIE4Y/1/M7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB4rYGib; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22622ddcc35so944705ad.2;
        Wed, 19 Mar 2025 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421257; x=1743026057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31CpfObX2eGPSgjTgTNcr5qnzFMbgrPtDWbjGnbqUeQ=;
        b=FB4rYGibbrAJ8Y+xkqH+eHqlw4sTq5MNlZ8sh7s1nEYq9ocWJzgdynKwOiNMryJblk
         7QtMWfNLNRMlL64P3cNTNnqkngaZ3nmsFTnxWqI7ulyoFDcvRNEBfmfDgqGtaQ/fFuBt
         KcFo5ZAY92NH0k5NHHVyOOEjo7LLrtuf547qwIyob4vkgAxvdjTZ0PljiOdQtb8d7JmQ
         TvoyMgFvKV3Ch37h2y6k9VPU7Tbc2J30rV6IYAfsED6k/9RJ3kwAbxMiZLV9v+evBWya
         JwCqWSG1jekZKwLcMkdocblWDXYUB0hx64E239iNZDslxVfpivR/MKQEFl6t0Kg0nQkH
         ulnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421257; x=1743026057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31CpfObX2eGPSgjTgTNcr5qnzFMbgrPtDWbjGnbqUeQ=;
        b=JA2HRUvvNcaySQbn4MYBIgMTwozZvPGi/Tk2LslSzVi9qvrdtj4eo9hZs+8TpE7Mtv
         W7CA6XSZi9nPTnzDGsrtK6RkA5NX61Exrny7uddU3aPJpLkONUB7HetoM6W+zSk58BsI
         XPb9k4rl9j9oxVY4W7ccS127aLyfuaGi17DUg3CEuTVcj/Hp98j6deX/17tZJVQ9eU9M
         kupgEYQKcWt1loTTc0pDtYC5fnlMa7hmuS+sq13GpG89oKnl9iVDYHa6BeNXqelTbDBa
         1g2N69rwPaUph999l58JyGR+HLb5vjO1sERG6C+WL+lpBVtwGw9KzG6yHbV028s3x/J0
         +3Mw==
X-Gm-Message-State: AOJu0YyWVlNhdjX/Weeo81MTUD/lSw9CtJJivbXV09RJXn6dyGvRul7b
	ynzr5cPuJuAN4/mgy2VLOfXVdyqi9+i0I2NBhPeH1Dv/cUS4QiBsW6muwD5s7AQ=
X-Gm-Gg: ASbGncsbU9tXDv48+2BmES96tqzu0E4IfoF7IkyxUKKxuaWgDyGEiy/eacdo/JGwmYE
	TtSjcWjjhhvxw21+Hm++gBMl44JPYIsMdd3gQ9/qq7MxDKV2VnDkOU1+k1A91oqdvqM60Ry7fF0
	AAq8FNPCk1nEKhDyLcU2xH7VFpB5l+A6Jxxto1bsgeosTVcILNMKpVWxoOYaMzdXcsDl6xFlifV
	OWeNvH6Xe/dpkh9aTu7sksUTPTG3v2py5bb9J9bq8rFwCbUqHZ0IgMbXncHZZsqJqYho+nr4oHJ
	xMTifhvAi8lTJhVQ9PtGKyfseXoo89kHPteqzAE0hBabGo036jK5HrJUKRkWdl5U9V3yx4A1Y1A
	lPwIpwqOd3gYBWp3EYZw=
X-Google-Smtp-Source: AGHT+IF6+oXuAo43AC0Hu3btbLc1k7CE8PxBOi1Jz5C+dHbIFB6l4Cypd+w8kGU+hr2hcsNkEdjInA==
X-Received: by 2002:a17:902:c94e:b0:215:94eb:adb6 with SMTP id d9443c01a7336-22649a80a38mr66580435ad.40.1742421257477;
        Wed, 19 Mar 2025 14:54:17 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	juntong.deng@outlook.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 07/11] bpf: net_sched: Disable attaching bpf qdisc to non root
Date: Wed, 19 Mar 2025 14:53:54 -0700
Message-ID: <20250319215358.2287371-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319215358.2287371-1-ameryhung@gmail.com>
References: <20250319215358.2287371-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Do not allow users to attach bpf qdiscs to classful qdiscs. This is to
prevent accidentally breaking existings classful qdiscs if they rely on
some data in the child qdisc. This restriction can potentially be lifted
in the future. Note that, we still allow bpf qdisc to be attached to mq.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/bpf_qdisc.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5aff83d7d1d8..cb158c8c433e 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -158,13 +158,19 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 		return 0;
 
 	/* r6 = r1; // r6 will be "u64 *ctx". r1 is "u64 *ctx".
+	 * r2 = r1[16]; // r2 will be "struct netlink_ext_ack *extack"
 	 * r1 = r1[0]; // r1 will be "struct Qdisc *sch"
-	 * r0 = bpf_qdisc_init_prologue(r1);
+	 * r0 = bpf_qdisc_init_prologue(r1, r2);
+	 * if r0 == 0 goto pc+1;
+	 * BPF_EXIT;
 	 * r1 = r6; // r1 will be "u64 *ctx".
 	 */
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 16);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
 	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);
+	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1);
+	*insn++ = BPF_EXIT_INSN();
 	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
 	*insn++ = prog->insnsi[0];
 
@@ -237,11 +243,26 @@ __bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64
 }
 
 /* bpf_qdisc_init_prologue - Hidden kfunc called in prologue of .init. */
-__bpf_kfunc void bpf_qdisc_init_prologue(struct Qdisc *sch)
+__bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
+					struct netlink_ext_ack *extack)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct Qdisc *p;
+
+	if (sch->parent != TC_H_ROOT) {
+		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
+		if (!p)
+			return -ENOENT;
+
+		if (!(p->flags & TCQ_F_MQROOT)) {
+			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
+			return -EINVAL;
+		}
+	}
 
 	qdisc_watchdog_init(&q->watchdog, sch);
+	return 0;
 }
 
 /* bpf_qdisc_reset_destroy_epilogue - Hidden kfunc called in epilogue of .reset
-- 
2.47.1


