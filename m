Return-Path: <bpf+bounces-40271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 182AD984C8B
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 23:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F031F24658
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB20313BC3F;
	Tue, 24 Sep 2024 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceoFdkcZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C691BC3F
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212144; cv=none; b=AbOaJDal635XYpPts2uLxcv5Mj+Ci4kpIL6KntEn51kTYv8/C1HvHy9YZXI4cXduUiGxmIEphogI5cGwaZ27zzizO1j1x+hl9cqwtZjCZYu008JDtQwkefnn36gEp0/DofI+E43kcUWyB05H/3yMO2Kca/OKdNLOLdkQEXMS8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212144; c=relaxed/simple;
	bh=k6LOtwomAOdIGaAy9yl9roiEFLsa7312idbkxYuE2ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDFXd0L85gCF3X7+kcLpffjQ/faSkE1gwxjsLbkRVALSTf3tFGf3MUi6MPVDg19wqmloH7ODYDiCvs02lQ4+JLGU3gf7/eq/sKDLN05eLtcPMp4AGE4r/Vir1hYAp+fWFBMJLdiantXLfUVBkvR74WfUjiXY9ee8non5JfOsMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceoFdkcZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db12af2f31so4958471a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727212142; x=1727816942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WIXefra3KwrqSpHEXnFHdf5fnmFO2uqlvT3ppWM2CQ=;
        b=ceoFdkcZAYECQ3mLhUtp2GKdziLqQ/Hoya7Idw+kI0EAp6yfrz5BLnnQwjWpE45EBA
         9KX9zBefdV8rnXX54TkNzrotodGtej/xBAgQMU4dB0T1g3C/6mKSoOMsDLkZ1mehSiJM
         aUd36gjGlSWn4nRIdJOqAnSLUDv40l3EBKiHDBMLcx9Ox8v2CK+/FVdobE7tUZ/4IfBp
         hfXQz6dldwnQjug/1XtW74nIJDyS+vwsQl8MVIGWlgsU4BAI46IegHiAgsYMX+Ooq12F
         4wpQTd7sB1v+r1eSniiQ8Mq0NQ83FBCB4l6OsKGWKTwm/AWA7s+MU186XMaUJAuVA96h
         dCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212142; x=1727816942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WIXefra3KwrqSpHEXnFHdf5fnmFO2uqlvT3ppWM2CQ=;
        b=PUtabGqz7gfoDcdPsiQ1Y1MAfR20++tz2AVn4jMwPYJBSMNpbSplbfUcGw6GepODEN
         fWkOGPi80LWb7A2bu6+uPgrH17vqM3aLRDVxN3Qlb/ctqH0rd77Gm6aem8VD9g+YbEu/
         7etMGqwPj9Ugh+ufZGdC6YDc6By9HydE9PryUxjGfJqY6s5zxOHx2/mgbvIEl1psZTc+
         jMPWK1VVEgE5tDf+VsqTuM0pkjGdOvtbGJcMDx6JACOOn00Jf564rhf+2rvdROOOovMx
         ONPJEhNVYhXz9SbhAOGfvyqSanSwCpspoyxrhvea5VoGJdCTKOJecS8lRHmG+/k22tKW
         Am5g==
X-Gm-Message-State: AOJu0YxE4KJKdvUSNJgZfFRYAf8yyi2EBwX+/hHFyZdyZzbpFIFvPZbh
	SPmzlzhcmaiaA6zD/HuLB4FNp/SmrQ2rOURxjB+v7uONkevVWzRkuRKSWDwo
X-Google-Smtp-Source: AGHT+IFBD30yWIPdbmQwADt0Dylg2TXUhH6XaeFNm+6w1GvTa2Je6U4RCFtaZb9dD0B3Yukogi8DkA==
X-Received: by 2002:a05:6a20:43a8:b0:1d3:1924:3ea4 with SMTP id adf61e73a8af0-1d4c6f307d8mr644550637.3.1727212141943;
        Tue, 24 Sep 2024 14:09:01 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc846dbfsm1567628b3a.80.2024.09.24.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:09:01 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Lonial Con <kongln9170@gmail.com>
Subject: [PATCH bpf v1 1/2] bpf: sync_linked_regs() must preserve subreg_def
Date: Tue, 24 Sep 2024 14:08:43 -0700
Message-ID: <20240924210844.1758441-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Range propagation must not affect subreg_def marks, otherwise the
following example is rewritten by verifier incorrectly when
BPF_F_TEST_RND_HI32 flag is set:

  0: call bpf_ktime_get_ns                   call bpf_ktime_get_ns
  1: r0 &= 0x7fffffff       after verifier   r0 &= 0x7fffffff
  2: w1 = w0                rewrites         w1 = w0
  3: if w0 < 10 goto +0     -------------->  r11 = 0x2f5674a6     (r)
  4: r1 >>= 32                               r11 <<= 32           (r)
  5: r0 = r1                                 r1 |= r11            (r)
  6: exit;                                   if w0 < 0xa goto pc+0
                                             r1 >>= 32
                                             r0 = r1
                                             exit

(or zero extension of w1 at (2) is missing for architectures that
 require zero extension for upper register half).

The following happens w/o this patch:
- r0 is marked as not a subreg at (0);
- w1 is marked as subreg at (2);
- w1 subreg_def is overridden at (3) by copy_register_state();
- w1 is read at (5) but mark_insn_zext() does not mark (2)
  for zero extension, because w1 subreg_def is not set;
- because of BPF_F_TEST_RND_HI32 flag verifier inserts random
  value for hi32 bits of (2) (marked (r));
- this random value is read at (5).

Reported-by: Lonial Con <kongln9170@gmail.com>
Closes: https://lore.kernel.org/bpf/7e2aa30a62d740db182c170fdd8f81c596df280d.camel@gmail.com/
Signed-off-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd86282ccaa4..1aa0c6360a55 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15326,8 +15326,12 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
 			continue;
 		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
 		    reg->off == known_reg->off) {
+			s32 saved_subreg_def = reg->subreg_def;
+
 			copy_register_state(reg, known_reg);
+			reg->subreg_def = saved_subreg_def;
 		} else {
+			s32 saved_subreg_def = reg->subreg_def;
 			s32 saved_off = reg->off;
 
 			fake_reg.type = SCALAR_VALUE;
@@ -15340,6 +15344,7 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
 			 * otherwise another sync_linked_regs() will be incorrect.
 			 */
 			reg->off = saved_off;
+			reg->subreg_def = saved_subreg_def;
 
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
-- 
2.46.0


