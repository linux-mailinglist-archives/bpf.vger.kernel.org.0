Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7B1A3C4A
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 00:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDIWSE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Apr 2020 18:18:04 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50388 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgDIWSE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Apr 2020 18:18:04 -0400
Received: by mail-pj1-f65.google.com with SMTP id b7so66951pju.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2020 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id;
        bh=d7I79Px6oW+xidqJy+si2tmnAYd369ZVNNbYLDl32gU=;
        b=W9vJOxKo91GTrNMNOMDe+CcYIVgw/SOaLir7ekED0M2QDlKPHJMg0FkVS8aK5M4xUT
         wKcgwDjPlpAbpIDBkQwzvxwo3aVhwKRbg73R/ocWLnP1YHT83chblwRCKlYUk3f3QcHv
         X6rglaZaHPq7Yu0iL3vU0s8SY7n3uOxzM0y4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d7I79Px6oW+xidqJy+si2tmnAYd369ZVNNbYLDl32gU=;
        b=fEgduDvRICyU3GG3Qx0x5A5TolOkFE5lt2ZmMR9KIwXrLI0BGRS0SwYSMwQhJMBP1F
         NPBCGsAMd3ijcdy1xsrqznvCY05/+/e30ABWmN/gNs/u7oEGIP1eV2LN0mMdqCfXRcKg
         RahNFrgHvZiilfqssKa65bRLxR5i/2sv5h5YcsVYAi1HoJNahNiNWViNLiKU0DcmBdKO
         DvAqSdunOK10BFbgxfJL/yRG5rgi5Rx6lBKNGWMG6yl3ppQFVtM1DtcegwVl8BpMZaff
         iO2vlLHAm7D2tjEOYL/kCaqywPsNoU0FIAQI24NfFemG57HPIQfyVu2vfvi1NibcU0mE
         Eklg==
X-Gm-Message-State: AGi0PubsnUMvgRVq23ipfPrTJOcFwMTyaEGQSVRH74lf591+7aSgQGgN
        PSik5oKklViJyhcCMxuBX9IN2rcMzH2s7A==
X-Google-Smtp-Source: APiQypLfv8Wd0dMcbnojJcRFpZ7fPcaUoNxEFntuU+I+4oPJFPCqFySEK9Ta/6QO6xIo+tI8+FNSxA==
X-Received: by 2002:a17:90a:94c8:: with SMTP id j8mr1817350pjw.155.1586470682925;
        Thu, 09 Apr 2020 15:18:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id w29sm111547pge.25.2020.04.09.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 15:18:02 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf] arm, bpf: Fix offset overflow for BPF_MEM BPF_DW
Date:   Thu,  9 Apr 2020 15:17:52 -0700
Message-Id: <20200409221752.28448-1-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch fixes an incorrect check in how immediate memory offsets are
computed for BPF_DW on arm.

For BPF_LDX/ST/STX + BPF_DW, the 32-bit arm JIT breaks down an 8-byte
access into two separate 4-byte accesses using off+0 and off+4. If off
fits in imm12, the JIT emits a ldr/str instruction with the immediate
and avoids the use of a temporary register. While the current check off
<= 0xfff ensures that the first immediate off+0 doesn't overflow imm12,
it's not sufficient for the second immediate off+4, which may cause the
second access of BPF_DW to read/write the wrong address.

This patch fixes the problem by changing the check to
off <= 0xfff - 4 for BPF_DW, ensuring off+4 will never overflow.

A side effect of simplifying the check is that it now allows using
negative immediate offsets in ldr/str. This means that small negative
offsets can also avoid the use of a temporary register.

This patch introduces no new failures in test_verifier or test_bpf.c.

Fixes: c5eae692571d6 ("ARM: net: bpf: improve 64-bit store implementation")
Fixes: ec19e02b343db ("ARM: net: bpf: fix LDX instructions")
Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 40 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index d124f78e20ac..bf85d6db4931 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1000,21 +1000,35 @@ static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[],
 	arm_bpf_put_reg32(dst_hi, rd[0], ctx);
 }
 
+static bool is_ldst_imm(s16 off, const u8 size)
+{
+	s16 off_max = 0;
+
+	switch (size) {
+	case BPF_B:
+	case BPF_W:
+		off_max = 0xfff;
+		break;
+	case BPF_H:
+		off_max = 0xff;
+		break;
+	case BPF_DW:
+		/* Need to make sure off+4 does not overflow. */
+		off_max = 0xfff - 4;
+		break;
+	}
+	return -off_max <= off && off <= off_max;
+}
+
 /* *(size *)(dst + off) = src */
 static inline void emit_str_r(const s8 dst, const s8 src[],
-			      s32 off, struct jit_ctx *ctx, const u8 sz){
+			      s16 off, struct jit_ctx *ctx, const u8 sz){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s32 off_max;
 	s8 rd;
 
 	rd = arm_bpf_get_reg32(dst, tmp[1], ctx);
 
-	if (sz == BPF_H)
-		off_max = 0xff;
-	else
-		off_max = 0xfff;
-
-	if (off < 0 || off > off_max) {
+	if (!is_ldst_imm(off, sz)) {
 		emit_a32_mov_i(tmp[0], off, ctx);
 		emit(ARM_ADD_R(tmp[0], tmp[0], rd), ctx);
 		rd = tmp[0];
@@ -1043,18 +1057,12 @@ static inline void emit_str_r(const s8 dst, const s8 src[],
 
 /* dst = *(size*)(src + off) */
 static inline void emit_ldx_r(const s8 dst[], const s8 src,
-			      s32 off, struct jit_ctx *ctx, const u8 sz){
+			      s16 off, struct jit_ctx *ctx, const u8 sz){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *rd = is_stacked(dst_lo) ? tmp : dst;
 	s8 rm = src;
-	s32 off_max;
-
-	if (sz == BPF_H)
-		off_max = 0xff;
-	else
-		off_max = 0xfff;
 
-	if (off < 0 || off > off_max) {
+	if (!is_ldst_imm(off, sz)) {
 		emit_a32_mov_i(tmp[0], off, ctx);
 		emit(ARM_ADD_R(tmp[0], tmp[0], src), ctx);
 		rm = tmp[0];
-- 
2.17.1

