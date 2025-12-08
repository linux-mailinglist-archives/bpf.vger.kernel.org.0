Return-Path: <bpf+bounces-76240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E2CABCF6
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 03:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1E573012744
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 02:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449B2E8B66;
	Mon,  8 Dec 2025 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7TZf8Yk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D02E765E
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159752; cv=none; b=Xiig6BlLr9hnlXnVRQJ3Pw1hE8CkDjnWch93JZ34USFmbV044iOQF0keIt1wP+ocdhXEETypwYUq9ToYrKyuj3Tsfojt5kpxSghpYEju6nm4nqHHcIH5Xm8RD8tLrl3PHNGzf9IPs9OOpQOfwNd7ZH+YccVNsUVe3L57p83Fd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159752; c=relaxed/simple;
	bh=vHFtWh7QKVO6cMPngtvM+H5QbyunJxMqywxc+99L1aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjquCr6usf0M7Myte/FJ1F+u0eZ29vC2s/eJzxongWcwbRMdXttnGbcC8gExkR8kqAFYYeuevVoeXb7L1I6D07u8T8v8EkXyZnS3bae+Ic2n4VkmzBk2ro8mmLG5Z+w/kSXTDxkkvhw6D9HTDbKe91RUA4xsCqm+aBvvksmRpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7TZf8Yk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297dd95ffe4so35323855ad.3
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 18:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765159749; x=1765764549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5D9HsKpXhHwGNX76p53vmtD9NyvNMqohbBibv1jkcw=;
        b=M7TZf8YkDgV39mUVOG5GbYx+npU04fxJgsZTnxC7CCSugQK/bYvT2p4b5LTdguq6Bt
         xuJnJKXQOPjK/M6Dx5ZxgVFaJsO4WM0PO0IqELjjE4h0WAP8kKW9DA/NdPZKHb5I49Ok
         YHrtCI06MLH9KHoXDuCDadJcPtcdg5DeF8m6nkCHSkjR85fp1qNDUIdKHaPObfPSyPpb
         WFxwLV43oN/MIfRm7QaEKrHNITZYEx7CFespOHMrJWLg60u96E2mIUZAH6+4vJGcw8eu
         UYGYO8tFdkJTrKuuEKwYbSn9Ez2jEHaXeWI2NosP+8SCYYqaiSgoFsCPeBTji9kp7O1Y
         8Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159750; x=1765764550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5D9HsKpXhHwGNX76p53vmtD9NyvNMqohbBibv1jkcw=;
        b=sEKoE46dk0SmWoXr8KNWWfgIB2iAaIsPBZMbOqoqR9x/0iIKdIWvf43gBfYUMqcB+u
         gwmLMJwcNSsZX63v0pmSN8O+3niv8h9w+35X6A3UlrDkUVKs7XUTWMnL/oih3qaCT1Wl
         kmYOkSkww5UzPrxWaWkS/qnYO5uKwFuA6QBtUJE9r51cua+H9PrrJOBG0q/v8OXGX3fd
         bRTK0YKddoFhaCGBOQUsxiyYXsJYuOnHt6USdWh4c5e5kZjbsR5/NHbFWj+zGNDD8Ob8
         Dh5Y9gIlOSgGYiFpVsEU1+JAw+sLxnOW3kAeMGLj9fnKG3hBfwQYAdmEWAXlJnQB6fme
         +bMw==
X-Gm-Message-State: AOJu0YyumDtU+t+tghnppPxhMvkJomEpi7cyATQkgDr0BWrODoO7ycug
	d8LGuGgGHOQxA4flzyJwM2PLgHqrX1Q7xb57DhKe7r78cSA7HJAzfDf/OCMjYPO3
X-Gm-Gg: ASbGnctzqsDjU9fFpdnfOypCzEk7OCR/nAkc/2vzbd1H+ROIS2RY0BHNeZVaFdvQc8h
	KACZ2XoAEgWmV7VvEZxo5vO+qNISr5apntq5tF9qXaFaIO5tY5/6HCinRT5LXdCcZ8JZELmvv/U
	zsUiDFD+Uecaf5BmLeOPhZUeqZE2LkA1b3Q/cXe1ChfYGccKAwUxnNtTcES+VU5qULucIDaLf+S
	jIj7m8nnH5gT/17FKYcGIiKyp5hkhmqwRrQZQEPhhkZL4bDlwa8dk/iO0KXrFgawRdRU0eUKGJc
	KA/iVC510UL9yKeSnfc9TWbtNdyjgm9bJcrC+XaUfbRhH651ic2ZBuPV/rIiUT90R0dzVzcGdUn
	MSCwNlUHe4JyAP0HmvHIjulOhGZctKwPIknngNK3HsKSz4LTwzubRjtF09e7QjbvGRnat+4GgwQ
	ollzaIFQ==
X-Google-Smtp-Source: AGHT+IFkayPA5D6N36GND9casKi2MqvafXpsRAwpUS1jAPv0PktPeDJ8byLSJGjuwi3aKOZaQYW85Q==
X-Received: by 2002:a17:902:e752:b0:297:f09a:51db with SMTP id d9443c01a7336-29df5a9ec81mr56918775ad.15.1765159749573;
        Sun, 07 Dec 2025 18:09:09 -0800 (PST)
Received: from Tunnel ([64.104.44.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6ffesm109161515ad.97.2025.12.07.18.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:09:08 -0800 (PST)
Date: Mon, 8 Dec 2025 11:09:04 +0900
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 6/8] bpf: Check oracle in interpreter
Message-ID: <b2e0be3b88386a1101656b4d8faa38b02e317ea5.1765158925.git.paul.chaignon@gmail.com>
References: <cover.1765158924.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765158924.git.paul.chaignon@gmail.com>

If we run into our special BPF_PSEUDO_MAP_ORACLE instruction in the
interpreter, we need to run the oracle test to check for inconsistencies
between concrete values and verifier states. This patch implements that
check and throws a kernel warning if any inconsistency is found.

The kernel warning message looks as follows, if only R6 was found not to
match some states:

    oracle caught invalid states in oracle_map[id:21]: r6=0xffffffffffffffd4

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 include/linux/tnum.h         |  3 ++
 kernel/bpf/core.c            | 12 +++++--
 kernel/bpf/oracle.c          | 65 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/tnum.c            |  5 +++
 5 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cffbd0552b43..6a53087cdd1d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1130,5 +1130,6 @@ int save_state_in_oracle(struct bpf_verifier_env *env, int insn_idx);
 struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					 int i, int *cnt);
 int create_and_populate_oracle_map(struct bpf_verifier_env *env);
+void oracle_test(struct bpf_map *oracle_states, u64 *regs);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index c52b862dad45..e028869371ca 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -54,6 +54,9 @@ struct tnum tnum_mul(struct tnum a, struct tnum b);
 /* Return true if the known bits of both tnums have the same value */
 bool tnum_overlap(struct tnum a, struct tnum b);
 
+/* Return true if tnum a matches value b. */
+bool tnum_match(struct tnum a, u64 b);
+
 /* Return a tnum representing numbers satisfying both @a and @b */
 struct tnum tnum_intersect(struct tnum a, struct tnum b);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 67226145a4db..fe251f1ff703 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1848,10 +1848,18 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 	ALU64_MOV_K:
 		DST = IMM;
 		CONT;
-	LD_IMM_DW:
-		DST = (u64) (u32) insn[0].imm | ((u64) (u32) insn[1].imm) << 32;
+	LD_IMM_DW: {
+		u64 address = (u64)(u32)insn[0].imm | ((u64)(u32)insn[1].imm) << 32;
+
+		if (insn[0].src_reg == BPF_PSEUDO_MAP_ORACLE) {
+			oracle_test((struct bpf_map *)address, regs);
+			insn++;
+			CONT;
+		}
+		DST = address;
 		insn++;
 		CONT;
+	}
 	ALU_ARSH_X:
 		DST = (u64) (u32) (((s32) DST) >> (SRC & 31));
 		CONT;
diff --git a/kernel/bpf/oracle.c b/kernel/bpf/oracle.c
index 44b86e6ef3b2..ce330853b53f 100644
--- a/kernel/bpf/oracle.c
+++ b/kernel/bpf/oracle.c
@@ -8,6 +8,8 @@
 
 #include <linux/bpf_verifier.h>
 
+#define REGS_FMT_BUF_LEN 221
+
 static void convert_oracle_state(struct bpf_verifier_state *istate, struct bpf_oracle_state *ostate)
 {
 	struct bpf_func_state *frame = istate->frame[istate->curframe];
@@ -320,3 +322,66 @@ int create_and_populate_oracle_map(struct bpf_verifier_env *env)
 
 	return populate_oracle_map(env, oracle_map);
 }
+
+static bool oracle_test_reg(struct bpf_reg_oracle_state *exp, u64 reg)
+{
+	if (exp->scalar) {
+		if (reg < exp->umin_value || reg > exp->umax_value ||
+		    (s64)reg < exp->smin_value || (s64)reg > exp->smax_value ||
+		    (u32)reg < exp->u32_min_value || (u32)reg > exp->u32_max_value ||
+		    (s32)reg < exp->s32_min_value || (s32)reg > exp->s32_max_value ||
+		    !tnum_match(exp->var_off, reg))
+			return true;
+	} else if (exp->ptr_not_null && !reg) {
+		return true;
+	}
+	return false;
+}
+
+static bool oracle_test_state(struct bpf_oracle_state *state, u64 *regs, u32 *non_match_regs)
+{
+	int i;
+
+	for (i = 0; i < MAX_BPF_REG - 1; i++) {
+		if (oracle_test_reg(&state->regs[i], regs[i])) {
+			*non_match_regs |= 1 << i;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static void format_non_match_regs(u32 non_match_regs, u64 *regs, char *buf)
+{
+	int i, delta = 0;
+
+	for (i = 0; i < MAX_BPF_REG - 1; i++) {
+		if (non_match_regs & (1 << i)) {
+			delta += snprintf(buf + delta, REGS_FMT_BUF_LEN - delta, "r%d=%#llx ",
+					  i, regs[i]);
+		}
+	}
+}
+
+void oracle_test(struct bpf_map *oracle_states, u64 *regs)
+{
+	struct bpf_oracle_state *state;
+	u32 non_match_regs = 0;
+	char regs_fmt[REGS_FMT_BUF_LEN];
+	bool expected = false;
+	int i;
+
+	for (i = 0; i < oracle_states->max_entries; i++) {
+		state = oracle_states->ops->map_lookup_elem(oracle_states, &i);
+		if (!oracle_test_state(state, regs, &non_match_regs)) {
+			expected = true;
+			break;
+		}
+	}
+	if (!expected) {
+		format_non_match_regs(non_match_regs, regs, regs_fmt);
+		BPF_WARN_ONCE(1, "oracle caught invalid states in oracle_map[id:%d]: %s\n",
+			      oracle_states->id, regs_fmt);
+	}
+}
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index f8e70e9c3998..afe7adf6a6f5 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -167,6 +167,11 @@ bool tnum_overlap(struct tnum a, struct tnum b)
 	return (a.value & mu) == (b.value & mu);
 }
 
+bool tnum_match(struct tnum a, u64 b)
+{
+	return (a.value & ~a.mask) == (b & ~a.mask);
+}
+
 /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
  * a 'known 0' - this will return a 'known 1' for that bit.
  */
-- 
2.43.0


