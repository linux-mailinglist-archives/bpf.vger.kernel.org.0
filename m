Return-Path: <bpf+bounces-41853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13F99C7CA
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 12:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BC62826D3
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD81A4F10;
	Mon, 14 Oct 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="s9b5dgMK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7E19F132
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903364; cv=none; b=bO040N2NUc+vm07nyd2JTs3ml9zxFgHr119c/R88gQL+lwnthJkFV2GdhDVlmJNZJukFYKi/l53kDb8qXk9KUOv+R9+Qd6i8GRUd10BVZIsUsW/1L8/3CAw8skWzZZb/U4DGbgcGkxce1GPi4QeES25T/MnvREkj0n2u6LGVBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903364; c=relaxed/simple;
	bh=oMcjEnoD/IiHKTDHBe1+Sngt6VXkq2qz6K7GU6/jcy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5MW4NEfV/5OWxElQ82e2BcH0n+nF/zBiRmPR3+pdvsZa+cJM15+ZPth52NTAxJ3bntrclZeQDm05vbLG2x1Yyku/nEam7H+iN5e3La9IzqrgzKzo6vra36MjcspRNNoPnovteQfRgZw7y42t5ckLFv3EkYcU4w9zNP3oU834qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=s9b5dgMK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0c40849cso131464666b.3
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1728903360; x=1729508160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tt8tpwQc0EVnwrif57LGDNgk40jiF/k60qMYgD9Xjs=;
        b=s9b5dgMKipeQVE0tt8v8JKywOlaDri04059fW7a8IhpkSAhewrk3fdADhrJzWFZIQX
         znwveePcUj3zgt9OhB67KQSprruY+9Xux9e1NheFRXYeqczEm/B9DoDnnYYdOixv0QsN
         gmIvx0s4PHGVWnj4/e/IvSKe613oq7FhISelE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728903360; x=1729508160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Tt8tpwQc0EVnwrif57LGDNgk40jiF/k60qMYgD9Xjs=;
        b=WjQ755occtKnnoKHvID/Nkm6Kxgam7uNHr5YbD0E2FjPqugVtW+csSeeLJLKcetDS8
         JYZKXUX+SHufYtXPhB2NE2h0Jp0W+Iy9oIRHJJg1Joy72SMI5Pu12DhP2OK6DzV/y5FL
         F3uUUND+Og/KoGIO7M/dtIOldWdOQ9U4ZKIgW+hRpBStKXx2yJ+gyjwimMuMYIX1UWyW
         8E8OnKM8VS2YZtFN0BEVxEs5kaBjaM88cizhF0P39E0jZugg7PBtFlKB1+gEqYZEnLtM
         2ibLVPNrQkvzdv6MmXRe4+X8OWPWLb/Q8M3n7ujKa05IcqwQ4Hj2is7fQ2mFXuiZDt0/
         8xrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDeYxjicmLowCettKV/41Nc8xHo9PulK63ov5NJeopw21BLu8nH2ngbrQ+cURYE+daLKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmIQxVZIpAh9zPrCRlJozrR21CIbJq1d4dvXaDjTtaPIXquD8
	ofCtNKwGKEzlgVT6FmzRdDXBfChATbcIdnjbNPGvG0D/cmYO8PawxERg9ofPNlg=
X-Google-Smtp-Source: AGHT+IHuDrKfDX9RSVqqFq2zvjQKU+rNI1hRsNTehOuiMcfPn6ZDdJ/3Dun/IVckndlV5fBe9mA2ew==
X-Received: by 2002:a17:906:7312:b0:a9a:139:5ef3 with SMTP id a640c23a62f3a-a9a01396165mr444122166b.55.1728903360394;
        Mon, 14 Oct 2024 03:56:00 -0700 (PDT)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0c95c80asm159996866b.144.2024.10.14.03.55.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 03:56:00 -0700 (PDT)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 1/3] bpf: Fix truncation bug in coerce_reg_to_size_sx()
Date: Mon, 14 Oct 2024 13:55:39 +0300
Message-Id: <20241014105541.91184-2-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241014105541.91184-1-dimitar.kanaliev@siteground.com>
References: <20241014105541.91184-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

coerce_reg_to_size_sx() updates the register state after a sign-extension
operation. However, there's a bug in the assignment order of the unsigned
min/max values, leading to incorrect truncation:

  0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
  1: (57) r0 &= 1                       ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  2: (07) r0 += 254                     ; R0_w=scalar(smin=umin=smin32=umin32=254,smax=umax=smax32=umax32=255,var_off=(0xfe; 0x1))
  3: (bf) r0 = (s8)r0                   ; R0_w=scalar(smin=smin32=-2,smax=smax32=-1,umin=umin32=0xfffffffe,umax=0xffffffff,var_off=(0xfffffffffffffffe; 0x1))

In the current implementation, the unsigned 32-bit min/max values
(u32_min_value and u32_max_value) are assigned directly from the 64-bit
signed min/max values (s64_min and s64_max):

  reg->umin_value = reg->u32_min_value = s64_min;
  reg->umax_value = reg->u32_max_value = s64_max;

Due to the chain assigmnent, this is equivalent to:

  reg->u32_min_value = s64_min;  // Unintended truncation
  reg->umin_value = reg->u32_min_value;
  reg->u32_max_value = s64_max;  // Unintended truncation
  reg->umax_value = reg->u32_max_value;

Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Zac Ecob <zacecob@protonmail.com>
Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 kernel/bpf/verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d9b38ffd220..70a0cf0f1569 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6333,10 +6333,10 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 
 	/* both of s64_max/s64_min positive or negative */
 	if ((s64_max >= 0) == (s64_min >= 0)) {
-		reg->smin_value = reg->s32_min_value = s64_min;
-		reg->smax_value = reg->s32_max_value = s64_max;
-		reg->umin_value = reg->u32_min_value = s64_min;
-		reg->umax_value = reg->u32_max_value = s64_max;
+		reg->s32_min_value = reg->smin_value = s64_min;
+		reg->s32_max_value = reg->smax_value = s64_max;
+		reg->u32_min_value = reg->umin_value = s64_min;
+		reg->u32_max_value = reg->umax_value = s64_max;
 		reg->var_off = tnum_range(s64_min, s64_max);
 		return;
 	}
-- 
2.43.0


