Return-Path: <bpf+bounces-78054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49533CFC36F
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37E6130060C0
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95B5287518;
	Wed,  7 Jan 2026 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIQmiXRt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18797283FEA
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768312; cv=none; b=g1SsVuthPBIqUvxtukC6HQqdKpe9z2sRpE89qLwv8xhsoVPdI7U8XSsdHVFi1tO55P0COMHejtgOoBBfNOSABMZJKYwRZCndfDoDtNIY//bL1al0sTywkkIVXLMV3ZxOJsxDf3WaJ5Qj1ULIqo9FKa30/xjQ0P3eeAZqMnkVHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768312; c=relaxed/simple;
	bh=Vk+W6eyr2IUQD5U+QNmcmmn6L3jEBra1Cbetb1uK2cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN5n8sAUYTO34X76vSHCLJShZDdelawV/uc0rHjKenEPG2T56uQzYsyrjTlAbwtRx/ETtMin1EBY7io6m6CQb4scTj52fKUYwBWUN2FyArjnGraGe3V+DY7LrxUJWnlxnidD4w0Otq/BZYQ29++OVUXauJXyAScIzATHJgVhQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIQmiXRt; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-79018a412edso19357977b3.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768310; x=1768373110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=TIQmiXRt2uTt9qqqe24xt1OcPrx8wiEG84T1EMbMUEtrTXTpfEj/TzPel86mdTSS9z
         1E77EK7nDtaGUKoitXHTCjLFrCml/CClfobFAoJvSQxYETzLhhdEfP2TAG2WbD8TjY2/
         wo5tR6Z7UARXkQnDexyRmmyZblhvP/7wAFjt6mIkB3HzknPAyCHEKyjePCzHUe9vW0hq
         C3wHNv5Qb23Ivo0qQofpC82kQTIe2yqhlmyDng8jd6mcDjBxybxh+gIgn/BLGJy+ZnSi
         0tsZNYYo6tvtRYdmAgGAyDyCrAQJnoG9pNofKKuVttQbo3rpYz8CCTCL/M8TgtFGiBAZ
         kbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768310; x=1768373110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=dLgBCsMiwVnN0t+CTDCmZydYr+8VvFjPa2ZC3bm62sjzpuUXAy3wTj56BM9RnHHziD
         qQfOnefXgDu9SuLdF1SMZJ3uL1xFo2mosTLDZuu/7dhelKz+NWTRMMmpn8tPykd7oUZ/
         +UNX9crfJIuUh5X6FcZVnOnGUGqiK6RISPC+yZMfcjXHzzhmBTaM8ywNB3Xf5fFULzN3
         MoLF0yoiTC6KeHNfXucwopNwFHhLRPekp/ge/Fekir4yJfu1ayg7X9qYjKgBMgB3vLP9
         gliKHQ3zlp1oNvCCbi7jJRFD5Y7Zb5oaYC7nM678Z6bN7XN36lnxVhhkaDQHFdlvXdu/
         FtQA==
X-Forwarded-Encrypted: i=1; AJvYcCVf7XWdrN9Tn/L227pGSnfJh/8SQx63tAIkpqLZ9MHUtslzfzdQirvXtIQWVfXWvW/ozJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCn0VAeiNsbZcflr2vSyzP6LZEIz7XLCZQasQ+GV3Frht9OSM
	jgdIYvR1EVlFgg3tz3HGzt2aMy+sIZcs+Y+rnMW5BQiRoBKy6wegYIHx
X-Gm-Gg: AY/fxX7iGmJO9VeKSAH57y/WHCOHK+Sb19Pt/oywRBHZg0QkFnskTgzsIDZkxPrFvJd
	vI9b/6OQHzxy7/2pSsW3apQ2nqC3LCgd0v7iIAYgKskQwA/9ado/POIhZaydxVF1bDiRw81K4bu
	PUp/haDUL0z9ictzkmub/RoPCmaxWmss7Xim3hMCGZ81yEHfpOdhKf651Srn/UOMcr2MmTfC0iz
	b9ms2MG2WMkjdChgz/bkuh+9FyjRBq+z/mdQE25aXkw3G3uKeC+FkFfqvxMwBVpWpaaE2xqsl/i
	RJHoI7KsHyb3eZasDzTbmTfvEH2Z7YzUmKhIpztxez+ojTs9WL6/7EjC/pbh3FWqNCtTRzflMq9
	tIlu17JvhoGlfqkx5UYFUO9MEmZ0Pj0pCYP3pqXCWhpJ51JSEac92Jfdhf/CYLxwYRKZNZbNkO9
	oKf88vnVo=
X-Google-Smtp-Source: AGHT+IEMEpmQuL+oH9KFsNmHO15vbwb5Xx/PixbITk1O1HYp4iN8g0LfMEdYn9psD97qbs1NmY/NYQ==
X-Received: by 2002:a05:690c:3686:b0:788:f56:afa7 with SMTP id 00721157ae682-790b56a5bcbmr14262217b3.40.1767768309834;
        Tue, 06 Jan 2026 22:45:09 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:45:09 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 06/11] bpf,x86: introduce emit_st_r0_imm64() for trampoline
Date: Wed,  7 Jan 2026 14:43:47 +0800
Message-ID: <20260107064352.291069-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the helper emit_st_r0_imm64(), which is used to store a imm64 to
the stack with the help of r0.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..a87304161d45 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_st_r0_imm64(u8 **pprog, u64 value, int off)
+{
+	/* mov rax, value
+	 * mov QWORD PTR [rbp - off], rax
+	 */
+	emit_mov_imm64(pprog, BPF_REG_0, value >> 32, (u32) value);
+	emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -off);
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -3352,16 +3361,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *   mov rax, nr_regs
 	 *   mov QWORD PTR [rbp - nregs_off], rax
 	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
+	emit_st_r0_imm64(&prog, nr_regs, nregs_off);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function:
 		 * movabsq rax, func_addr
 		 * mov QWORD PTR [rbp - ip_off], rax
 		 */
-		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
+		emit_st_r0_imm64(&prog, (long)func_addr, ip_off);
 	}
 
 	save_args(m, &prog, regs_off, false, flags);
-- 
2.52.0


