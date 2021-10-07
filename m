Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A182425567
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbhJGOaf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242060AbhJGOac (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 10:30:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD043C061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 07:28:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y12so10397339eda.4
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Lo1nKycYD7uQkimgdy9/DmVOAzp2P6GoOZIMhMVMjA=;
        b=GCHIYZKSFwPsdN/O33zzMJPNpASW5ZsY1qcaocBfxmrPsbIYEyFqB/yzlTdzhr3wVg
         j7qmQZM60ZbMGj/al1urLYEHEpHMeSrcUPzmKy8iaTDDjJdKo5ou8927laFMIwGy8Gaq
         MnmFV4jPR3yC0tT/SVrQBAdm7SbOodX6vshurS9+FN/u+j6Z2vL/VNmqP78V2kzzhHy1
         rjLNTd++617GR6fhPeHNQ9aiAVbaThKJ9tErCq+bP36fyyGuUvALA/ldqw+UOIgslXEM
         9MfHb8+9bntyj5X5PzdIlrd0mVswiGzH603Dl7wgZQwSipak51dnE6xvxVZNLXogRQYC
         RxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Lo1nKycYD7uQkimgdy9/DmVOAzp2P6GoOZIMhMVMjA=;
        b=5pNOgjspqoBpAxONZ7C18B2lb9cJNTzo1WRdr9NCDB6OnNxMFKVvcrZ4fPJRw4WGkq
         iV8jFJG0KeQwmpcs+NPB9ToyGiT5u09DKFe/w2N2ItteUI9oGRwEYihrymfqa/11P4PJ
         Dl7pK6qOi/Dqmk9tSz+RtyGVmd/mWlvAMMg+1VzTaxpeAsCD689SdsAcYxtmBoVz2URz
         T5HWby+wIPXVuYAAPSmLOeDs35u6lnhrA6Vp4LSRfPPQknKHFBzgB/KpBrOroBdemhfE
         nSor3qpRjZ7Fo7rpDlIRtRKIqtSLEMz4TA5K2jJEp8nFDNbSJqnkh5l5r61m8QW8elgv
         TL9g==
X-Gm-Message-State: AOAM530awLVA6w2/jJxVV5mL61YywsO/VI+V0JxaGo3sDWtgrVH8+uLi
        fVdGs/1p5UsXG61cPQs2NgHxPg==
X-Google-Smtp-Source: ABdhPJydo9ms0LhqA7fq4EMrDU3Mkle43y/gfGAkq93tDzOzgqwAcwH3NBfoErVI5aOvNpuTU8RqnA==
X-Received: by 2002:a17:906:d107:: with SMTP id b7mr5813302ejz.541.1633616916918;
        Thu, 07 Oct 2021 07:28:36 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id g9sm10313859ejo.60.2021.10.07.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:28:36 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        paulburton@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        tony.ambardar@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next] mips, bpf: Optimize loading of 64-bit constants
Date:   Thu,  7 Oct 2021 16:28:28 +0200
Message-Id: <20211007142828.634182-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch shaves off a few instructions when loading sparse 64-bit
constants to register. The change is covered by additional tests in
lib/test_bpf.c.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 arch/mips/net/bpf_jit_comp64.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 1f1f7b87f213..815ade724227 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -131,19 +131,25 @@ static void emit_mov_i64(struct jit_context *ctx, u8 dst, u64 imm64)
 		emit(ctx, ori, dst, dst, (u16)imm64 & 0xffff);
 	} else {
 		u8 acc = MIPS_R_ZERO;
+		int shift = 0;
 		int k;
 
 		for (k = 0; k < 4; k++) {
 			u16 half = imm64 >> (48 - 16 * k);
 
 			if (acc == dst)
-				emit(ctx, dsll, dst, dst, 16);
+				shift += 16;
 
 			if (half) {
+				if (shift)
+					emit(ctx, dsll_safe, dst, dst, shift);
 				emit(ctx, ori, dst, acc, half);
 				acc = dst;
+				shift = 0;
 			}
 		}
+		if (shift)
+			emit(ctx, dsll_safe, dst, dst, shift);
 	}
 	clobber_reg(ctx, dst);
 }
-- 
2.30.2

