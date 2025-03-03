Return-Path: <bpf+bounces-53221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E45A4EA55
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3B13BFC76
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6E02BD5A2;
	Tue,  4 Mar 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnKdpCGb"
X-Original-To: bpf@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9A29C32C
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109803; cv=fail; b=Z1/unPtZF/0sAwrewAFznlD04W+yK5oN9/ox7xgIpugcpNlVJ6Xq0HJqqI5i9/wX4Ve4DxBbgOEwzeK197XaqmFIJ5S8xXCJduSqt9qQZX8iCPrSzuZdbqktZJcANt/hlnvjhSUBaJXf9kTeiEl/UCs9MkPRyoBKBjm7kWf3Mqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109803; c=relaxed/simple;
	bh=fg3CQhVdElqIrM2J8jHcyv94WBhkx0k9IskFN1gs5hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kee3NlwkvlbYSYIIMLzID/MrHDap3d/6fHeWLSKulK3AaofG/hvwsJrL1AitF3N4Krms1jYAYi4Zla0gR0ydII9TWeR7H9WLP02J9OtAi/JE0GX39VEUsusl0dGX4dLImiFnvyc4XCMvDS6Koq1tMSh3ZG+4eSxi3hcrq5EJP9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnKdpCGb reason="signature verification failed"; arc=none smtp.client-ip=209.85.216.67; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id DBACF40D0507
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 20:36:39 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GnKdpCGb
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h8B1jN0zG3bS
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 19:33:46 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8614642744; Tue,  4 Mar 2025 19:33:31 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnKdpCGb
X-Envelope-From: <linux-kernel+bounces-541065-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnKdpCGb
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id DCDBC41A37
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:56:31 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id C0F5D305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:56:31 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEF2189055C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 06:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56451EA7DA;
	Mon,  3 Mar 2025 06:55:55 +0000 (UTC)
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8D1E5701;
	Mon,  3 Mar 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740984951; cv=none; b=iFa9oz+pwwBC1TS5k3Lu3wAqSYk0i2koQVPc56iQLw6N/BogVffip6WtXo5vv5IsJoZU9w7TtGE5Fj2KxOGSmqu0NXYtlfxMTPthD6HJz+W0q97xUAQhuPhQtrE5vRyMArrueyla75CcQ7uoKZI1/Z2nUav7JRLo6oOzfaSxxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740984951; c=relaxed/simple;
	bh=9vFV77ptSTYnHR9rUq3KbjSFw+gNvMMZmZ5zUhVxqcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5ZhuCYFnlHNxmsA3cGDRM24bFf8prfBB5ujPX1zriUrWometQpbUtsVkwiY19H+VMRJXnedAfP9Yu43W6JkN6hcFnhr+2Lx4ID3ad821+qdlkofqwRcIa+xgF56pFa8L3dhb/jd3XOLk4fD9GUF223VkBsXUAZAipA3tQAeg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnKdpCGb; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2fea78afde5so5195243a91.2;
        Sun, 02 Mar 2025 22:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740984949; x=1741589749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nymZZudf34hrdxusEHfgJt6WkWUJ+6WT6FOvsBZVSeI=;
        b=GnKdpCGbLa3irmdF8wxLOlW+kbSXY3o2Xg4FqmyS52Bkz7wo+sc5f3jddbW/ww0kQX
         v7wib+oo8kgkRDRbvHK1ToNc065/DB/aCcDOVVLQ3ZkJ4+RGKflastoIaz0yettdAPAL
         Voft/DuCgHHC0LIuWE8ySVI+JiCY07DRmZG7tX6KzlpY38994MLuhSmYe+TKAVoUg/rm
         T1Tfo+pcrWAVhJi4ZqkbWgyprzTIdywqThRWVVOG7gpkdIbvfj/CxKvJyMzff9oNfBDR
         0jcoeYfcKS9AM/5qL3KMdQGKLMIasW0njahTipRC1FMxH98co50fcBhhrQWfvTlqGtWV
         Nnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740984949; x=1741589749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nymZZudf34hrdxusEHfgJt6WkWUJ+6WT6FOvsBZVSeI=;
        b=VFgxUcvMl824ulcfxJqXUN/iPgjQYeHEfN0RW57mD4yCdj52B9ttplAZLn+yOcuvz4
         PMXtnf2BqswU5gxoDY4Akqoyrv6W+brsdz+WUlg+hwgxDZyzgTKEdLNR91fEbtevswJp
         SpzgaeCvudYFKmY1mdTzvv0NB9IYlNUyEeHnCEuA3udgZ60OHbFSrm6jwZO3QK4o/G96
         6pW6y83+2jJF9ibB5Ohqy5XbkPqbcXiDkNR6IHlri3KxjKlWfXlLrMMooBpnUPJHwnvU
         5OgxF8e1SRl0wi9wKcuNAkmjxmFIFFFRDmCrsb+EiBxTMysIrMOMpso3pkmN2U4nfDL9
         VnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGW1Q1IY95E6fJtRC+HI7zXrj6FaPhtb2gxS4CzzU2qMoUQJtBXa4uhbHEVHNhBJULuiCjSRG/@vger.kernel.org, AJvYcCVfwBDJYcsMhIoBHfa9u+f1OWIqDY78yfqGtg47SLXIEbLDs08q6JDBJEXx4G9D/NRw6JOTnrehH6767/nMjyUkPmiw@vger.kernel.org, AJvYcCX+cvmcyXFMJutJwqKYLbR7Vledgoy2PV4WECxVY4p3WO6l39lANFsGdvoW6zmVrt5mgO4=@vger.kernel.org, AJvYcCXZzjizTjImnTiP8wxrpEAkPA1qnw7cCdVn+np1AVpGzlrRt041Mtlx5Jzi/i2AfmFobetjkTM7ztqaaqxU@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGhnTmQEmyjQ444X8M4uLRvvSLWakl91YDmAmZBFHRTSmRYWi
	K9cB0LjHN6L1G8xxhX/9VmHJ6Dt1JBwyXkh+yV+AIqTZT2DSIbF7
X-Gm-Gg: ASbGnctWLcTNW4oj2+9uRN3ryCAq2onQx2Pd66WF9EmPOl1WREGvdvciBsM4uFSLfqy
	DOuEnkfVdPSvHQqmEXj2U0dEy25Vz0/kScfFC3/nbkyJHmjWmjFtPbv/BatHQXqOEg9SY/VJoag
	g6z3YuTyuHWr6+HRFEAzVLtwfSxiOw65gfWhYDDAEar2blhuvKOQFwLNaXriMqip10n98TkxTWA
	oSargGnd47ve+P/iR9IlAMS1UTFEts0UGtGprEcSrMusfhtcj9SYO8zxSgCh6sgQrPpeReVZkRK
	B2m5dptv8Baeon/cTpHNFVFnIwk5tu9CRxLZwpewJp30jwkZfR3KEEuEHTbZjw==
X-Google-Smtp-Source: AGHT+IGSoY6DTXHZdCGzW7B6A82lurvA8twdiEOcJq7108bwjigQWB9/CnfNiFNnV2PDUqTyIKthyQ==
X-Received: by 2002:a17:90b:2f8d:b0:2ee:48bf:7dc3 with SMTP id 98e67ed59e1d1-2febab7862fmr19657613a91.15.1740984949306;
        Sun, 02 Mar 2025 22:55:49 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6769ad2sm8139575a91.11.2025.03.02.22.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 22:55:48 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/4] x86/ibt: factor out cfi and fineibt offset
Date: Mon,  3 Mar 2025 14:53:42 +0800
Message-Id: <20250303065345.229298-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303065345.229298-1-dongml2@chinatelecom.cn>
References: <20250303065345.229298-1-dongml2@chinatelecom.cn>
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h8B1jN0zG3bS
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714498.40132@Nbgn32XvONrzY88bHesAdw
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

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/include/asm/cfi.h    | 12 ++++++++----
 arch/x86/kernel/alternative.c | 27 ++++++++++++++++++++-------
 arch/x86/net/bpf_jit_comp.c   | 22 +++++++++++-----------
 3 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 31d19c815f99..ab51fa0ef6af 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -109,15 +109,19 @@ enum bug_trap_type handle_cfi_failure(struct pt_reg=
s *regs);
 extern u32 cfi_bpf_hash;
 extern u32 cfi_bpf_subprog_hash;
=20
+#ifdef CONFIG_CALL_PADDING
+#define FINEIBT_INSN_OFFSET	16
+#define CFI_INSN_OFFSET		CONFIG_FUNCTION_ALIGNMENT
+#else
+#define CFI_INSN_OFFSET		5
+#endif
+
 static inline int cfi_get_offset(void)
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
index c71b575bf229..ad050d09cb2b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -908,7 +908,7 @@ void __init_or_module noinline apply_seal_endbr(s32 *=
start, s32 *end, struct mod
=20
 		poison_endbr(addr, wr_addr, true);
 		if (IS_ENABLED(CONFIG_FINEIBT))
-			poison_cfi(addr - 16, wr_addr - 16);
+			poison_cfi(addr, wr_addr);
 	}
 }
=20
@@ -974,12 +974,15 @@ u32 cfi_get_func_hash(void *func)
 {
 	u32 hash;
=20
-	func -=3D cfi_get_offset();
 	switch (cfi_mode) {
+#ifdef CONFIG_FINEIBT
 	case CFI_FINEIBT:
+		func -=3D FINEIBT_INSN_OFFSET;
 		func +=3D 7;
 		break;
+#endif
 	case CFI_KCFI:
+		func -=3D CFI_INSN_OFFSET;
 		func +=3D 1;
 		break;
 	default:
@@ -1068,7 +1071,7 @@ early_param("cfi", cfi_parse_cmdline);
  *
  * caller:					caller:
  *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%r10d	// 6
- *	addl	$-15(%r11),%r10d	 // 4	     sub    $16,%r11		// 4
+ *	addl	$-15(%r11),%r10d	 // 4	     sub    $FINEIBT_INSN_OFFSET,%r11 // =
4
  *	je	1f			 // 2	     nop4			// 4
  *	ud2				 // 2
  * 1:	call	__x86_indirect_thunk_r11 // 5	     call   *%r11; nop2;	// 5
@@ -1092,10 +1095,14 @@ extern u8 fineibt_preamble_end[];
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_s=
tart)
 #define fineibt_preamble_hash 7
=20
+#define ___OFFSET_STR(x)	#x
+#define __OFFSET_STR(x)		___OFFSET_STR(x)
+#define OFFSET_STR		__OFFSET_STR(FINEIBT_INSN_OFFSET)
+
 asm(	".pushsection .rodata			\n"
 	"fineibt_caller_start:			\n"
 	"	movl	$0x12345678, %r10d	\n"
-	"	sub	$16, %r11		\n"
+	"	sub	$"OFFSET_STR", %r11	\n"
 	ASM_NOP4
 	"fineibt_caller_end:			\n"
 	".popsection				\n"
@@ -1225,6 +1232,7 @@ static int cfi_rewrite_preamble(s32 *start, s32 *en=
d, struct module *mod)
 			 addr, addr, 5, addr))
 			return -EINVAL;
=20
+		wr_addr +=3D (CFI_INSN_OFFSET - FINEIBT_INSN_OFFSET);
 		text_poke_early(wr_addr, fineibt_preamble_start, fineibt_preamble_size=
);
 		WARN_ON(*(u32 *)(wr_addr + fineibt_preamble_hash) !=3D 0x12345678);
 		text_poke_early(wr_addr + fineibt_preamble_hash, &hash, 4);
@@ -1241,7 +1249,8 @@ static void cfi_rewrite_endbr(s32 *start, s32 *end,=
 struct module *mod)
 		void *addr =3D (void *)s + *s;
 		void *wr_addr =3D module_writable_address(mod, addr);
=20
-		poison_endbr(addr + 16, wr_addr + 16, false);
+		poison_endbr(addr + CFI_INSN_OFFSET, wr_addr + CFI_INSN_OFFSET,
+			     false);
 	}
 }
=20
@@ -1347,12 +1356,12 @@ static void __apply_fineibt(s32 *start_retpoline,=
 s32 *end_retpoline,
 		return;
=20
 	case CFI_FINEIBT:
-		/* place the FineIBT preamble at func()-16 */
+		/* place the FineIBT preamble at func()-FINEIBT_INSN_OFFSET */
 		ret =3D cfi_rewrite_preamble(start_cfi, end_cfi, mod);
 		if (ret)
 			goto err;
=20
-		/* rewrite the callers to target func()-16 */
+		/* rewrite the callers to target func()-FINEIBT_INSN_OFFSET */
 		ret =3D cfi_rewrite_callers(start_retpoline, end_retpoline, mod);
 		if (ret)
 			goto err;
@@ -1381,6 +1390,8 @@ static void poison_cfi(void *addr, void *wr_addr)
 {
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
+		addr -=3D FINEIBT_INSN_OFFSET;
+		wr_addr -=3D FINEIBT_INSN_OFFSET;
 		/*
 		 * __cfi_\func:
 		 *	osp nopl (%rax)
@@ -1394,6 +1405,8 @@ static void poison_cfi(void *addr, void *wr_addr)
 		break;
=20
 	case CFI_KCFI:
+		addr -=3D CFI_INSN_OFFSET;
+		wr_addr -=3D CFI_INSN_OFFSET;
 		/*
 		 * __cfi_\func:
 		 *	movl	$0, %eax
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a43fc5af973d..e0ddb0fd28e2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -414,6 +414,12 @@ static void emit_nops(u8 **pprog, int len)
 static void emit_fineibt(u8 **pprog, u32 hash)
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
@@ -428,20 +434,14 @@ static void emit_fineibt(u8 **pprog, u32 hash)
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



