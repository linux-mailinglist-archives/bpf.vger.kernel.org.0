Return-Path: <bpf+bounces-73233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D441DC27C5B
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9193BE3A0
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2802F261A;
	Sat,  1 Nov 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOCwEf7y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0802EB85B
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994876; cv=none; b=jYsd1TNU9f/ZUuW5wiMFklM47kyYMnA1IZfrDA/gAChWDtLK5Qb2ctL3/N56h+6tjMYhn5Iaws/9Lhny5XR5yOTRDhPL9C9CCXoOaPsZpc+Kab9uDRtJc4l9XJ0c0VnXiMD+WyMEzpmQtTQIUaSsDIKIXt9vFBmJDzMIzJOoM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994876; c=relaxed/simple;
	bh=xFxeXQqPKAgcFOWf9VOQjhwob5K+AMyyXdaqOi1Ejpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFPFVersWX9S3K+oBoToROki41QFfE93d4J5Jobbz5/i/tktFZ15lkAMRjWO2W+q++X5JW6vayq0AgCcy2FeE1s6w/h6CpFpVuJp15o3sMdWoon+qRhlLKC97m1aA4WrfxxE61nsDRmsFCyw1w8jVTH+vwk72iXuWP3fkUvEGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOCwEf7y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47728f914a4so15382895e9.1
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 04:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994871; x=1762599671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=SOCwEf7ya1SjTQ5iCKrzA1IuvXSRWmgXDOwHhd/aLC+x5QUiRTrneiq0O5EHdxiTv+
         CxZxYCgR+sKHOwW4YNqdId7H4r8fFec/nPk+vjmryjBKhml1ztEft/UU7i3ErWmXcf3J
         v6IwOV0HHHD+VPwWoTKUeDG/PL+h8613LJ+X1fOdxt6SV81/rps7GU3RV21/087kbQK3
         4RpWnO6A7fxjfAeiCvMpZix33/kjUh1zRuZbq2FwQ11d8HlyBpgJcamTpnMxGlVHjMgE
         XiLKtNId4LvIBTcw8bp7hjKoxLEIuVNsSVxzp5lkvBRyqEDAQ1Udq1JoLeV8vM/0P4r3
         mc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994871; x=1762599671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=I72TRuHDzAT1bnofkm1wDViy7o/JvQek8W/De110wd/CswC83svdF9v9Vykia0FXQE
         Udkf+pYx6+fjPOtlmKJITZoYqQtA+eqYHiaEGXD+rDimpG3eNQieoQ4hBAqt0gwk8nqW
         BlpuoW0okOXxTFQMeWEEW2TlQr+u127+3c815K+W7IMjm4y/tgZx1AWIvnMKCK74RFcO
         uwFONEpQis86mIKCk8XK5/ysC395wuvc5fjvE8t5O03y0tEUwiehsUR+fjgmMppBTUR0
         SsoyoH5YD5njOUxlRGTX7XV4xMb45VPHBXJ0sDRkCwV7SxN6oJqtHZbgG4wYlbtHvFFj
         PAYQ==
X-Gm-Message-State: AOJu0YwmqG5EkxyD4yknUayPwW/kwWzzgToB+LJ8My3zN+Aggi7ykbFv
	IdtxRxuE4tdpeFAiqgFubad+YTpuFCAWUfjsvjeCseVeaJGJcoiK1ilk+HskiQ==
X-Gm-Gg: ASbGnctlMmhRtgGaDb+jw48eH1ZhlHTQqUouqlEUuO61OGn+C0zmoEQinbtV6H5Lx30
	67pMljEaWOd28kqSq+SzBH4AmwjV/O7IU8XubmKLH+FXQ2NAHU7T4+pyn7DQXGJXOVxoxxIqVeI
	urrha9cGhfRapNztXeHWcJTAARH+U/tgtZKupLaKISFcEU3bYeY0B4ZgFjEf/TpnzogUHngWDda
	M0CHu4quSUIlZRnZeX9J574pQszYvUQdalj2hnAmgl08hCj8EYTRcoT1MT1drfAvWp2pPFRP8Ya
	TupExoU71nxAzejKFzYunGMPIvsvEaQx8zKa1qs8f2/FF0jMZ98Yj2K/CkFjkfZfiEsSq/esAmv
	BgR5WwfHyqG6cmvQc8h7OIvTIjNphDszDlPsAmqZ/J/zhngbF3Ngrpv15FGDYsSGVSHlBKqp0WK
	tZHXbaM0C3lnrvvbJ3osqiPImLSmUbxw==
X-Google-Smtp-Source: AGHT+IGk3MLDe70zyTgAPx8Baw0m2skVeyNSEDB7GYC/mET7TDwBed4R57iB2nFWr6bjxgn2ocxRFw==
X-Received: by 2002:a05:600c:3489:b0:477:cb6:805e with SMTP id 5b1f17b1804b1-477307e0513mr49193975e9.18.1761994871229;
        Sat, 01 Nov 2025 04:01:11 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm38794005e9.6.2025.11.01.04.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:01:10 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v9 bpf-next 07/11] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Sat,  1 Nov 2025 11:07:13 +0000
Message-Id: <20251101110717.2860949-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for indirect jump instruction.

Example output from bpftool:

   0: (79) r3 = *(u64 *)(r1 +0)
   1: (25) if r3 > 0x4 goto pc+666
   2: (67) r3 <<= 3
   3: (18) r1 = 0xffffbeefspameggs
   5: (0f) r1 += r3
   6: (79) r1 = *(u64 *)(r1 +0)
   7: (0d) gotox r1

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/disasm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 20883c6b1546..f8a3c7eb451e 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -358,6 +358,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JA | BPF_X)) {
+			verbose(cbs->private_data, "(%02x) gotox r%d\n",
+				insn->code, insn->dst_reg);
 		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
 			   insn->src_reg == BPF_MAY_GOTO) {
 			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
-- 
2.34.1


