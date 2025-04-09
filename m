Return-Path: <bpf+bounces-55593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1FFA833A4
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5661B8073B
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51221C9EF;
	Wed,  9 Apr 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW9dJnML"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F420298E;
	Wed,  9 Apr 2025 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235179; cv=none; b=kdZWGQvWXt4Dk/b/fj5kezwLeWrygV5awJ8EaBHjjhbj3Qjk9V7zUaSB9baqEAPAKRx/Itgfhhvg4qxm2Nc5AjAYRiNs9NIrJ7uZwhWgv4HswZD7r/Etvu0EH4mctD73TGY/cUq3RKjQiHjujjccZjjUN6/XFk9RpN/xx7skHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235179; c=relaxed/simple;
	bh=btqMoGbYeZhkkjj5rQSDn8rJfomeuwBI6ynVxR9DRDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwH//SMbeZoyn76n9GJw9ujQboSh5KBBz15SUyRZyNGGnQ2E0NpDNSLim7v1ciRRL15KLNamFJHfYon3O9rEMF98vD4NirtfrP5dgScJn3RepQBLuWP5slIMQzUWylPYyfjDC1B3Gs2BLBExFqlPjNXDFxCy15MbwKx8W9a9XUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW9dJnML; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376e311086so109133b3a.3;
        Wed, 09 Apr 2025 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235175; x=1744839975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31CpfObX2eGPSgjTgTNcr5qnzFMbgrPtDWbjGnbqUeQ=;
        b=ZW9dJnMLglgOWL5Mw/f8TLh5qgJ9UiL8/okBTDT96UiIL9xPHPnSR5V3KCPovsO1sB
         6aus/H7muqeIPtuaR/OSFXAZL8y7CYsXla1L3l//dfKpydjEcg4TzJ7UlDL4JAUBeP7M
         2/81TDHc5Qe9oHtXBD9pgcaAsRIfR1H/GJsjMTHgykysI1OdBjA2XrJEQA51MSNpcJ6O
         A28ffCDK/iLw/yqty+FFEB1Ah3n6ofnwL8q0whR+s4TaFxz9OIYQZ1W++LEe+gPw8hP0
         2qluHAwh54pwmaqg63jwm47obprwtV04zEpokH9cfxVVCP8G1TSHfmmWSA0IKUMriWDC
         R0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235175; x=1744839975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31CpfObX2eGPSgjTgTNcr5qnzFMbgrPtDWbjGnbqUeQ=;
        b=n0HD+JsI1IGzF0nWHYSQNxK/bnQwvDXztjJjMOmSoGEZPWZ0Txg8Tjf+u4e0f+ehrB
         c8OPredAo3QpInwmob2pX73KUJi3XbSrCueM2kEuJhK0yKRQ+BtCiysAshsWJiGk3bWt
         MWyiqqWJx5Z34VcxsSrqcKEz+1Q+W4DZ94Zi6M/ppkQlhhWOZdDiX88d9stiLjrVgd5O
         edWJlYI62VBl8D3rTbWRJC/d8vDCuSkNNqYsH2k3ZbSE9niFj2PUGS7uXGL8Y9P/RPVn
         fkSZVuIxDtQLvyNtUK8enVLOWLs7X43lEeeBPPc0werQF6pxnkoZxi/SZuA4XHrwxI7I
         e8lQ==
X-Gm-Message-State: AOJu0Yy8jbT6aS4SHLfWb4VaJYACaed/x1BCUjaxVh6hTX7nBAsqzMzo
	O7UQqav/hKZH+Pzlo5FGpicRZQxrhqjpcaeDeBTbwhlipYm0lUO/bqIBr7A1
X-Gm-Gg: ASbGncsLNGCg8RRj1gcKPhCc5u72mtzejzINvF9R2RN0dAmLrvVcZqAk07rkDvTAEzv
	WYcNxoHJ0htGKeK039dfbpkV0M9ZhjViosRneGrgCYRFZT4aG0nBZTBuiH2DjCcW22KLbe6r9Pu
	IN9EFRtqBD9Hv1rZuhOHbJhcHX98OKAVhqbRKN8vwZa+MXTHO7AppfNO6m5LwFo2E4WkxQZ2Z9Y
	WdhVXL2+NpmBED5rE2yd2xUwgN85J+f3055R1lDCSRnArIQ2NTJAPbBwRXS2X3x36ACObh3B6gK
	Q5YiQL7HGP8wWo2zpT98vslIgtrE3pQ=
X-Google-Smtp-Source: AGHT+IGDPEGm0uOrlmHmBg7lX4Yr9qCDSu92R0Pe5OupmfFQD1ZK6FpJGGRjGsB+sAWgmKvx/bUIsg==
X-Received: by 2002:a05:6a21:3408:b0:1f5:8d91:293a with SMTP id adf61e73a8af0-201695e1bf1mr1062392637.41.1744235175580;
        Wed, 09 Apr 2025 14:46:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d492eesm1934085b3a.59.2025.04.09.14.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	martin.lau@kernel.org,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	toke@redhat.com,
	sinquersw@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 06/10] bpf: net_sched: Disable attaching bpf qdisc to non root
Date: Wed,  9 Apr 2025 14:46:02 -0700
Message-ID: <20250409214606.2000194-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250409214606.2000194-1-ameryhung@gmail.com>
References: <20250409214606.2000194-1-ameryhung@gmail.com>
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


