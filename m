Return-Path: <bpf+bounces-53195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D64A4E444
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2358F422473
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B8A278115;
	Tue,  4 Mar 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEfylcch"
X-Original-To: bpf@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3392780F3
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102325; cv=fail; b=TjjV1fbuHL0bRHZKEKBuvb0v72OYwxf3JwSPFA4JvC9siuEh3exr5l0RENWIKAxh2Y3SGFu0B/G0COSR3HrtNWhMMqP0wyJII0kt0+GqjCCj3n6Dlvb2YEjrZV+9rk/0gT5DZaBWqITKZOIuKpvvQLq/fnR+ORTNEg8mbVXZzlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102325; c=relaxed/simple;
	bh=xeeY3qHmkkgHuAK0Xah+SIncTNKAzWFk2oK/8a0t94Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NE7caYOoWYfe7ghzJZmZTyximvxC9IbQKkphXQty5By+t3bWWEHBiE7JEFts6tACr8YJYKYFSoyP1uPQ7ERgzn3ZTN/TLEZ8wIkrtXsheiPfHv1lHJYxGqAKMl943XbMl7qj/fLJXGebi9m8J1gh9BvbRJ6qEGR0Q9cczPzzn6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEfylcch reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.196; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id C97C840CF661
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 18:32:01 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SEfylcch
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6flv2P0FzG0Sy
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 18:31:07 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9DE1A4273C; Tue,  4 Mar 2025 18:30:53 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEfylcch
X-Envelope-From: <linux-kernel+bounces-541814-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEfylcch
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 78D20423D1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:32:35 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 103A53063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:32:34 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E123AC164
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B908213E6F;
	Mon,  3 Mar 2025 13:30:43 +0000 (UTC)
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D609212FBD;
	Mon,  3 Mar 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008639; cv=none; b=AWSbMRKrTqaYwk1ZZeN4fRlGNZExpuz31IBj34SUxAl2k/gfCAG7ABDA0IlrgmRudQPC/E2tfqnftQM2GBLvMU24mHGzAtMTUuxRsZGVuBxEs7d6xVik2zUyqv5XEvFYn8t/Bo6RBb7JdS88Ec8gA+AYMaFDV5WPwypmFoAtWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008639; c=relaxed/simple;
	bh=Jrm+7746S7K9yWA40dUMBKTAN0ud8hVu4FIcLZVjvE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0Ds2jrVdx7L4s4xMmai1nt9ue5+X3d3E1LHowYJcThCCfw5RAm03/hKZuEiwuo/SJJfMEuTU91onreXP0ezh2ZthIZXx4uUR4jUoxn2S/VDjXYzyUnO5Tx9HloaoyNZjdabmSH70BztHKNYA6mBo407gboZd36EocwVOZlmq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEfylcch; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-22382657540so32195485ad.2;
        Mon, 03 Mar 2025 05:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741008637; x=1741613437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HoYAW6D8hO+aaE9DpE+f5d9KWUfqlQeSUmUL0RBP80=;
        b=SEfylcchyw/AsFqZ/ZmtJOBYtRr/sV0ONWVuUVJBVI/pgrL2ixQJhqZnpZCCkmf+4T
         gvWRtbCsLcRH7cVRshFHmkDyxGDJyfGg42kAlri0S4Sk2NfVTOUMNu4qKaLG58f12xr5
         LfUQwMdFNyIKo7rnCglKXOwqD60X9Jp7cFvlhMEIMxtvDM2txe9GVbMEPr4TDnhy+jn0
         ZHfoKKyyp7AgoIo/i1ALr9iUJgD1hgczPiq6aihl0rSmsVXCkwwuxTNw1TA2Z+cV/tjI
         CueFCepWMLyEqGa2VH0doLyJkAbK2IgS3Cl5f9yiKbj0W+RbeTHxNPlJe8frFU4v7Hu9
         XLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008637; x=1741613437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HoYAW6D8hO+aaE9DpE+f5d9KWUfqlQeSUmUL0RBP80=;
        b=sudlHx5ktu+ipwUF/WPODvPa6CaoPDRUJNVyRO3EwL6858EM7IHdmMeeh61MJnTTA9
         GZdv4sxLwnT5l7FtjZApusG2MbXgxiC9Tltvjm4LlX2MJG1V36nug6Rtolj+dHTtnvG1
         hBf86auTXDhPpzAPRnao0B2RPN6DL5H41APueC0fe/NRXe3qB5Hjx3D43IvnN6VprKJB
         K/F4QOoJ9wyiDV48EkW/ugw4/42HtcUiXH8VIIuyX45n19wQ/zp8E+FAzH6SPp3SZKTz
         +ZMb1Kai9wJlG9ZFJQXWCMQPKZRjW0xrwRx19ukuely4EaGLKsrOQtuAz6m/xnpqfTmk
         g2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU/z4xUdFZi9xKRQRV4oiWwD6sUW1RSMcIrYxVNiT9M5pc9rlB/OPIpOg22QIZWUe+5BBDBcAOa1xfGGhMaowP7BCZc@vger.kernel.org, AJvYcCVLVqflwQEpe24hWK1lbOmzbh1qJK7+tn4ra0yBvwpjWbFX7EyOl5ynzl6UPBrAawqK9GMtUztef0g1kx8I@vger.kernel.org, AJvYcCVsRfQMiMuPj7KNaiIGVq3t7asm1TmRHYTEedHUAAi0edCg1HZAuJvtuQ1Vpf047klUzZ30MarC@vger.kernel.org, AJvYcCWYVf1VzNkN1SodqqE0quIJXy7DFDAobGTvniBZz4kWncoxU9h9r46aDx84rqZLGdKRF20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkq7Q2dZsz1ZoJ1dJ+LfoBlRXM0EKfcrSr/chvP0q501E7ay6
	G6VhabWKOJq7N2ozW8UigveyxXFaJCOoQxFuna5XacYRbsdSzFm8
X-Gm-Gg: ASbGncvY0ivwP4Hr6FZqHcg4npdetYn4hjMk3V7cU+1dO/LYFUW2+hz+Qd1w1/B3jEb
	z1y4/8USATTXocQNLZ4aqrLrxwczmpVRfDANqMbBR3k3sSSuzF1ewdaTMbLyGUDN4ykfbzM5Z8M
	8kRoxnKglk/IlJ9LzPEB624zbASbnhiRsQs3zlRJYIgJNJ/4Af3V0PD6q5Xcq4ybQNJFF5RHfAh
	OiNgTuBuTD5y5mHamwQwzgM9hOHQGjEPJp/MLREJVSoFyjYlOoT1MB2NvWGaQJl5RzuFtvP29Fb
	+8KXSSRXStCUKHyCEGep/R+CZiNgIXBxYjVFwZh2HFuO0xTk62FjAhjoIfFKUQ==
X-Google-Smtp-Source: AGHT+IGA2mWJTfvekJWlfyFWg7JZnBJRMEmVPtYCpiX/IyOQcjy5rGPgwuYYTPg+xM28+Vd56S613A==
X-Received: by 2002:a17:903:230c:b0:223:7006:4db2 with SMTP id d9443c01a7336-22370064ea3mr156649035ad.31.1741008636600;
        Mon, 03 Mar 2025 05:30:36 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505359b8sm77297035ad.253.2025.03.03.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:30:36 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	rostedt@goodmis.org,
	mark.rutland@arm.com,
	alexei.starovoitov@gmail.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mhiramat@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	mathieu.desnoyers@efficios.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	samitolvanen@google.com,
	kees@kernel.org,
	dongml2@chinatelecom.cn,
	akpm@linux-foundation.org,
	riel@surriel.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
Date: Mon,  3 Mar 2025 21:28:34 +0800
Message-Id: <20250303132837.498938-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303132837.498938-1-dongml2@chinatelecom.cn>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6flv2P0FzG0Sy
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707069.40471@zNDxeN94Df3sbc6WPoZV8A
X-ITU-MailScanner-SpamCheck: not spam

For now, the layout of cfi and fineibt is hard coded, and the padding is
fixed on 16 bytes.

Factor out FINEIBT_INSN_OFFSET and CFI_INSN_OFFSET. CFI_INSN_OFFSET is
the offset of cfi, which is the same as FUNCTION_ALIGNMENT when
CALL_PADDING is enabled. And FINEIBT_INSN_OFFSET is the offset where we
put the fineibt preamble on, which is 16 for now.

When the FUNCTION_ALIGNMENT is bigger than 16, we place the fineibt
preamble on the last 16 bytes of the padding for better performance, whic=
h
means the fineibt preamble don't use the space that cfi uses.

The FINEIBT_INSN_OFFSET is not used in fineibt_caller_start and
fineibt_paranoid_start, as it is always "0x10". Note that we need to
update the offset in fineibt_caller_start and fineibt_paranoid_start if
FINEIBT_INSN_OFFSET changes.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- rebase to the newest tip/x86/core, the fineibt has some updating
---
 arch/x86/include/asm/cfi.h    | 13 +++++++++----
 arch/x86/kernel/alternative.c | 18 +++++++++++-------
 arch/x86/net/bpf_jit_comp.c   | 22 +++++++++++-----------
 3 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 2f6a01f098b5..04525f2f6bf2 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -108,6 +108,14 @@ extern bhi_thunk __bhi_args_end[];
=20
 struct pt_regs;
=20
+#ifdef CONFIG_CALL_PADDING
+#define FINEIBT_INSN_OFFSET	16
+#define CFI_INSN_OFFSET		CONFIG_FUNCTION_ALIGNMENT
+#else
+#define FINEIBT_INSN_OFFSET	0
+#define CFI_INSN_OFFSET		5
+#endif
+
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #define __bpfcall
@@ -118,11 +126,8 @@ static inline int cfi_get_offset(void)
 {
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
-		return 16;
 	case CFI_KCFI:
-		if (IS_ENABLED(CONFIG_CALL_PADDING))
-			return 16;
-		return 5;
+		return CFI_INSN_OFFSET;
 	default:
 		return 0;
 	}
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index 32e4b801db99..0088d2313f33 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -917,7 +917,7 @@ void __init_or_module noinline apply_seal_endbr(s32 *=
start, s32 *end)
=20
 		poison_endbr(addr);
 		if (IS_ENABLED(CONFIG_FINEIBT))
-			poison_cfi(addr - 16);
+			poison_cfi(addr);
 	}
 }
=20
@@ -980,12 +980,13 @@ u32 cfi_get_func_hash(void *func)
 {
 	u32 hash;
=20
-	func -=3D cfi_get_offset();
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
+		func -=3D FINEIBT_INSN_OFFSET;
 		func +=3D 7;
 		break;
 	case CFI_KCFI:
+		func -=3D CFI_INSN_OFFSET;
 		func +=3D 1;
 		break;
 	default:
@@ -1372,7 +1373,7 @@ static int cfi_rewrite_preamble(s32 *start, s32 *en=
d)
 		 * have determined there are no indirect calls to it and we
 		 * don't need no CFI either.
 		 */
-		if (!is_endbr(addr + 16))
+		if (!is_endbr(addr + CFI_INSN_OFFSET))
 			continue;
=20
 		hash =3D decode_preamble_hash(addr, &arity);
@@ -1380,6 +1381,7 @@ static int cfi_rewrite_preamble(s32 *start, s32 *en=
d)
 			 addr, addr, 5, addr))
 			return -EINVAL;
=20
+		addr +=3D (CFI_INSN_OFFSET - FINEIBT_INSN_OFFSET);
 		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) !=3D 0x12345678);
 		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
@@ -1402,10 +1404,10 @@ static void cfi_rewrite_endbr(s32 *start, s32 *en=
d)
 	for (s =3D start; s < end; s++) {
 		void *addr =3D (void *)s + *s;
=20
-		if (!exact_endbr(addr + 16))
+		if (!exact_endbr(addr + CFI_INSN_OFFSET))
 			continue;
=20
-		poison_endbr(addr + 16);
+		poison_endbr(addr + CFI_INSN_OFFSET);
 	}
 }
=20
@@ -1543,12 +1545,12 @@ static void __apply_fineibt(s32 *start_retpoline,=
 s32 *end_retpoline,
 		return;
=20
 	case CFI_FINEIBT:
-		/* place the FineIBT preamble at func()-16 */
+		/* place the FineIBT preamble at func()-FINEIBT_INSN_OFFSET */
 		ret =3D cfi_rewrite_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
=20
-		/* rewrite the callers to target func()-16 */
+		/* rewrite the callers to target func()-FINEIBT_INSN_OFFSET */
 		ret =3D cfi_rewrite_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
@@ -1588,6 +1590,7 @@ static void poison_cfi(void *addr)
 	 */
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
+		addr -=3D FINEIBT_INSN_OFFSET;
 		/*
 		 * FineIBT prefix should start with an ENDBR.
 		 */
@@ -1607,6 +1610,7 @@ static void poison_cfi(void *addr)
 		break;
=20
 	case CFI_KCFI:
+		addr -=3D CFI_INSN_OFFSET;
 		/*
 		 * kCFI prefix should start with a valid hash.
 		 */
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 72776dcb75aa..ee86a5df5ffb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -415,6 +415,12 @@ static int emit_call(u8 **prog, void *func, void *ip=
);
 static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, int arity)
 {
 	u8 *prog =3D *pprog;
+#ifdef CONFIG_CALL_PADDING
+	int i;
+
+	for (i =3D 0; i < CFI_INSN_OFFSET - 16; i++)
+		EMIT1(0x90);
+#endif
=20
 	EMIT_ENDBR();
 	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
@@ -432,20 +438,14 @@ static void emit_fineibt(u8 **pprog, u8 *ip, u32 ha=
sh, int arity)
 static void emit_kcfi(u8 **pprog, u32 hash)
 {
 	u8 *prog =3D *pprog;
+#ifdef CONFIG_CALL_PADDING
+	int i;
+#endif
=20
 	EMIT1_off32(0xb8, hash);			/* movl $hash, %eax	*/
 #ifdef CONFIG_CALL_PADDING
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
+	for (i =3D 0; i < CFI_INSN_OFFSET - 5; i++)
+		EMIT1(0x90);
 #endif
 	EMIT_ENDBR();
=20
--=20
2.39.5



