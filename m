Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D1422E78
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 18:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhJEQ4Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbhJEQ4P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 12:56:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC5C061755
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 09:54:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l7so1347635edq.3
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZ2i9LKOneWZTwGUW8k+ODLGUWaKyeF1iKdmKQkxUcY=;
        b=uvljRWWYiqcG30l0lni1WZWJwXtPlgAsSxeNlA4riD+lMaOUx3wNFi2M70lVjny81L
         IgJw2wzRaWLSUJryjQoQ9OS/jIMxTpaU0YFO5eaoYsSHlNeOBEqRQHv0v8LvHutY9nkE
         YdZh6VCLUAY1bnf0/U8Y2tqLZoIy2//E4Zr9GC/NThdaGg163up6l9LiBmGDQ2QpK0ta
         AJWn+dniOep1XL6TOJseGcFJw8rZdZW32A6mHniOth9+ZxzbxT4LEMnMYOZ9QSo+8DTS
         X1BxT0C1//jM2Q0Frg8K9TV99aqBdFl/pC62yOJdCDIWq5zXNMZgIWzL2rafexCU0SIh
         5NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZ2i9LKOneWZTwGUW8k+ODLGUWaKyeF1iKdmKQkxUcY=;
        b=B0v5nx+4OUMsv6dqed0m4c9NpOdDtSET6ir/sbWQUkZcpTFxSMO3Gfh8rTb0r5aG+P
         ktQ4QwEvPjhF1Qg1kanhORztpft9Uzy4VCgZJFRHACMuCScJGbg2s1ANukqBOdXbyagT
         NaAPTSfnvAcHzSIu4Izv4YpNVY+dGrXKZdGBf5lYLZJqAJ4rU11DnpFBRXnVihmopE8d
         SaFflTd+SQigcsoRb52TaYo8b/oS2OixsTwmRSlSfSE5NyUN3d1hTUAzlTbQeTm1LiKm
         0tWu8na7ivsY1qAHM7BThL/d7mVEALl/3Lklb8ZN2FOL1nr7/iYiVGIi+ctoZxJJoZFd
         QxDg==
X-Gm-Message-State: AOAM533xy98MVFKLxjIHYtE/1bVSfGhCQGfJHOn2F9x1Gl1ddxUtCEJI
        s5nILVGtxWBPrKJxwMRYmeA8+g==
X-Google-Smtp-Source: ABdhPJy+P25wq2mMVGo5T1iuNK6dt9Z2gDNRZzR59PnR36Dl5XlRiBGjTHbo5UUJHZotNQQHxV1REA==
X-Received: by 2002:a50:9d83:: with SMTP id w3mr27455643ede.305.1633452862987;
        Tue, 05 Oct 2021 09:54:22 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id x16sm3447818ejj.8.2021.10.05.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:54:22 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        paulburton@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        tsbogend@alpha.franken.de, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, yangtiezhu@loongson.cn,
        tony.ambardar@gmail.com, bpf@vger.kernel.org,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Tony Ambardar <Tony.Ambardar@gmail.com>
Subject: [PATCH 1/7] MIPS: uasm: Enable muhu opcode for MIPS R6
Date:   Tue,  5 Oct 2021 18:54:02 +0200
Message-Id: <20211005165408.2305108-2-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005165408.2305108-1-johan.almbladh@anyfinetworks.com>
References: <20211005165408.2305108-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable the 'muhu' instruction, complementing the existing 'mulu', needed
to implement a MIPS32 BPF JIT.

Also fix a typo in the existing definition of 'dmulu'.

Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>

This patch is a dependency for my 32-bit MIPS eBPF JIT.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 arch/mips/include/asm/uasm.h | 1 +
 arch/mips/mm/uasm-mips.c     | 4 +++-
 arch/mips/mm/uasm.c          | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index f7effca791a5..5efa4e2dc9ab 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -145,6 +145,7 @@ Ip_u1(_mtlo);
 Ip_u3u1u2(_mul);
 Ip_u1u2(_multu);
 Ip_u3u1u2(_mulu);
+Ip_u3u1u2(_muhu);
 Ip_u3u1u2(_nor);
 Ip_u3u1u2(_or);
 Ip_u2u1u3(_ori);
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 7154a1d99aad..e15c6700cd08 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -90,7 +90,7 @@ static const struct insn insn_table[insn_invalid] = {
 				RS | RT | RD},
 	[insn_dmtc0]	= {M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
 	[insn_dmultu]	= {M(spec_op, 0, 0, 0, 0, dmultu_op), RS | RT},
-	[insn_dmulu]	= {M(spec_op, 0, 0, 0, dmult_dmul_op, dmultu_op),
+	[insn_dmulu]	= {M(spec_op, 0, 0, 0, dmultu_dmulu_op, dmultu_op),
 				RS | RT | RD},
 	[insn_drotr]	= {M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE},
 	[insn_drotr32]	= {M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE},
@@ -150,6 +150,8 @@ static const struct insn insn_table[insn_invalid] = {
 	[insn_mtlo]	= {M(spec_op, 0, 0, 0, 0, mtlo_op), RS},
 	[insn_mulu]	= {M(spec_op, 0, 0, 0, multu_mulu_op, multu_op),
 				RS | RT | RD},
+	[insn_muhu]	= {M(spec_op, 0, 0, 0, multu_muhu_op, multu_op),
+				RS | RT | RD},
 #ifndef CONFIG_CPU_MIPSR6
 	[insn_mul]	= {M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
 #else
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 81dd226d6b6b..125140979d62 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -59,7 +59,7 @@ enum opcode {
 	insn_lddir, insn_ldpte, insn_ldx, insn_lh, insn_lhu, insn_ll, insn_lld,
 	insn_lui, insn_lw, insn_lwu, insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi,
 	insn_mflo, insn_modu, insn_movn, insn_movz, insn_mtc0, insn_mthc0,
-	insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_mulu, insn_nor,
+	insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_mulu, insn_muhu, insn_nor,
 	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sb, insn_sc,
 	insn_scd, insn_seleqz, insn_selnez, insn_sd, insn_sh, insn_sll,
 	insn_sllv, insn_slt, insn_slti, insn_sltiu, insn_sltu, insn_sra,
@@ -344,6 +344,7 @@ I_u1(_mtlo)
 I_u3u1u2(_mul)
 I_u1u2(_multu)
 I_u3u1u2(_mulu)
+I_u3u1u2(_muhu)
 I_u3u1u2(_nor)
 I_u3u1u2(_or)
 I_u2u1u3(_ori)
-- 
2.30.2

