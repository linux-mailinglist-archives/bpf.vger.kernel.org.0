Return-Path: <bpf+bounces-49749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D59A1C06F
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F9416CBD5
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642711FA26C;
	Sat, 25 Jan 2025 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpzrgAxS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D01FBCB5
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771548; cv=none; b=fk+BMnJT0E/f1miDRKaHvHnJeFkYfna1NQiOzwWg/+uoNilD738YVPAdJvQvGt1qBXjEKBrgpeGxTk1N67Ovb3V9Y6lLDxH7V671g9Ng44Yvj/P2BE5axiFlrj2Jf7pHnuJpTPJCmRrwnROfrtpunppQO8Zc2RaqRj51ZrH24eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771548; c=relaxed/simple;
	bh=WidbeIeXnurJYytUhC+gK2quyPI+yX7Ip0iFSlOCYz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L+dxBSl1j6563R2gcsy/aRzR6rYb7q/3PcBn7bamfXfxM1FQlKlybGEo3WFRS3ZpWzwIkAY8CcpmTwZo3NBEHHNzz8yu82C1j/VF/2jdvsTGckl2TLuWAnY4IGW1Ixf6ud1DKxe2N0+nJIgZif+cY096g2KyOxZB86HH879xYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpzrgAxS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216387ddda8so60395495ad.3
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771545; x=1738376345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ff8OoM3RwJ/YS9q+sO/KvAZcdKn8t6Rkpge4WfBIGvQ=;
        b=EpzrgAxSinsKwjeNdGSPBQMv+CASZ4UQxtFbbh98JTiYk/qHvLZEIXU1RDlqg2bdI+
         /e5fCz8puYaUqvDtBkzcyO/FwplL0jtjW6YazG39yz1kfmQLV3IOqzqK0J3TxtyA9hSr
         Q2za6YAU6l2RcZCzwN+5xieGls/VevefYslHbDERmkeolqjF9aShiq+Z+MiQTuulvjJP
         aZfigvS7xfocokZOP0GJF+xxLLXpjCsK1rZUkA1w7uWkmT5gTsCiS2EWSl7kk5WXUwId
         Qn3Nd5dslahmQopVq/UBZQCmoRZap0+aeNaPAHTiqNTXTpHUIq2rGIAcCPfHNO+BYt+H
         bK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771545; x=1738376345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ff8OoM3RwJ/YS9q+sO/KvAZcdKn8t6Rkpge4WfBIGvQ=;
        b=Z8s9Z5GsrJtVW2uDVm106JTgzvAQlxCVYeigxT6i09EXDM793PMTdIJfRMOOdt1w05
         3ySnUZZMySKsF4v8vflrtIx+2V4eAolmXqvlDvHNvCp0dWyGP7pg04v/T01WyK4skauB
         LaW8dVlWUSzodutPfB16qOLqi0zUWPg3FwiubJwU71x+jMJVqSSSB11id5E7JvTPkwWh
         RxPxhlultV+Dn8i0FiY0RZyhb1IcUpL7iaaNZy1nwz/YWC0UloikudSrxdKMC/GFkbRl
         3uDS03WXM2W/Vj2go2nECmITOrBi/D5qbbeB7JLp9bNYEdG8m66wbwhten60xs7xswhd
         aJcA==
X-Gm-Message-State: AOJu0Yzdr63nRIpKomA3SOD4OxVq4xPNwVZlwP4V9G1zsIfcPmXxOifJ
	uTHVjf8pJIr6J1RvwLRwOhAJ3/NyFLWSM+j1ZPE59I6VCDXde1vxCCaLSv+qVNl4WLevd1vLYv4
	BOw3FJXY0Kxs7AcX3CLZHMWmePgINN5RK77hfuhcJ4Js1kOAwHyraiDh89u88ZRPZPGW484RG5Q
	d3XWEyoKixLgVOA8cRppixj3ZHiPpnc5S7iHUphJs=
X-Google-Smtp-Source: AGHT+IF5yitEZ2ynO7/1xRDH6f+mEY3tHHd6tHuHsyfWb71s1fY6pLTuNoYRwXYGNFFpe0KHLpuGhOpUmxzkiQ==
X-Received: from plgn4.prod.google.com ([2002:a17:902:f604:b0:212:4d11:70f5])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce01:b0:211:e812:3948 with SMTP id d9443c01a7336-21c34cc010emr536071555ad.0.1737771545532;
 Fri, 24 Jan 2025 18:19:05 -0800 (PST)
Date: Sat, 25 Jan 2025 02:19:00 +0000
In-Reply-To: <cover.1737763916.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <7544131164e5a3ab1aa192e895c883106d8dd324.1737763916.git.yepeilin@google.com>
Subject: [PATCH bpf-next v1 5/8] arm64: insn: Add load-acquire and
 store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add load-acquire ("load_acq", LDAR{,B,H}) and store-release
("store_rel", STLR{,B,H}) instructions.  Breakdown of encoding:

                                size        L   (Rs)  o0 (Rt2) Rn    Rt
             mask (0x3fdffc00): 00 111111 1 1 0 11111 1  11111 00000 00000
  value, load_acq (0x08dffc00): 00 001000 1 1 0 11111 1  11111 00000 00000
 value, store_rel (0x089ffc00): 00 001000 1 0 0 11111 1  11111 00000 00000

As suggested by Xu [1], include all Should-Be-One (SBO) bits ("Rs" and
"Rt2" fields) in the "mask" and "value" numbers.

It is worth noting that we are adding the "no offset" variant of STLR
instead of the "pre-index" variant, which has a different encoding.

Reference: Arm Architecture Reference Manual (ARM DDI 0487K.a,
           ID032224),

  * C6.2.161 LDAR
  * C6.2.353 STLR

[1] https://lore.kernel.org/bpf/4e6641ce-3f1e-4251-8daf-4dd4b77d08c4@huaweicloud.com/

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/include/asm/insn.h |  8 ++++++++
 arch/arm64/lib/insn.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 2d8316b3abaf..39577f1d079a 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -188,8 +188,10 @@ enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
 	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
+	AARCH64_INSN_LDST_LOAD_ACQ,
 	AARCH64_INSN_LDST_LOAD_EX,
 	AARCH64_INSN_LDST_LOAD_ACQ_EX,
+	AARCH64_INSN_LDST_STORE_REL,
 	AARCH64_INSN_LDST_STORE_EX,
 	AARCH64_INSN_LDST_STORE_REL_EX,
 	AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET,
@@ -351,6 +353,8 @@ __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
+__AARCH64_INSN_FUNCS(load_acq,  0x3FDFFC00, 0x08DFFC00)
+__AARCH64_INSN_FUNCS(store_rel, 0x3FDFFC00, 0x089FFC00)
 __AARCH64_INSN_FUNCS(load_ex,	0x3FC00000, 0x08400000)
 __AARCH64_INSN_FUNCS(store_ex,	0x3FC00000, 0x08000000)
 __AARCH64_INSN_FUNCS(mops,	0x3B200C00, 0x19000400)
@@ -602,6 +606,10 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     int offset,
 				     enum aarch64_insn_variant variant,
 				     enum aarch64_insn_ldst_type type);
+u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
+					enum aarch64_insn_register base,
+					enum aarch64_insn_size_type size,
+					enum aarch64_insn_ldst_type type);
 u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register base,
 				   enum aarch64_insn_register state,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index b008a9b46a7f..f8b83f4d9171 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -540,6 +540,34 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 					     offset >> shift);
 }
 
+u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
+					enum aarch64_insn_register base,
+					enum aarch64_insn_size_type size,
+					enum aarch64_insn_ldst_type type)
+{
+	u32 insn;
+
+	switch (type) {
+	case AARCH64_INSN_LDST_LOAD_ACQ:
+		insn = aarch64_insn_get_load_acq_value();
+		break;
+	case AARCH64_INSN_LDST_STORE_REL:
+		insn = aarch64_insn_get_store_rel_value();
+		break;
+	default:
+		pr_err("%s: unknown load-acquire/store-release encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
+					    reg);
+
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    base);
+}
+
 u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register base,
 				   enum aarch64_insn_register state,
-- 
2.48.1.262.g85cc9f2d1e-goog


