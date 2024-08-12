Return-Path: <bpf+bounces-36959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEAE94FA63
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F6DB21C94
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB9319AA43;
	Mon, 12 Aug 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBwKL/tC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10DA19A28B
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506253; cv=none; b=R3Gg4+YPgoOaea+vwSniUwFOKKj4lZ/ksyAhbP40VtyOZgQvtGI/ER9Qk9QtUmJbqpj04+CyOlE2FmmroF5r7fIaOOzdWECRzZ5/uLhP7DdapKKBM/SVVBYBimopP51JeMW9b1BhSsgVEDgGPlYEUm9zpA+TAyHm9Oo7C3SXGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506253; c=relaxed/simple;
	bh=4IDVYdqpBffz1vG803z5Tv+fMjhmHRIASOkgttZe5/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBezQyiCmPVLhSyLlAUNYPI0RVUaPrMCp0nDQxaucAGjP3k4jAoLlil0bWx15uMJk5EWQLyeK4nlFkB+gFvPWzVM5cCUCy+iqn74wiUnTt74xr05tr30C1rruWNDI7X+N7zeXuzMEJ21YD96aYs3kjY137Dys/ErgQd1LSCeoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBwKL/tC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a263f6439eso3023256a12.3
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723506251; x=1724111051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpBGMMu6occiZChHOxP7rE/Knegzcmxp8hIdYJ1YBVo=;
        b=jBwKL/tCjnOZGJ7DNbgix7Z1QiXFihcLzzN9op4hY1oIJfQcgYaQM4Iifx676SqXbT
         jEMrKbGFOQ9mNkkOWw8TCtOByOvemeAcbMh+Rq4guCbnRhmK1XVyX0qNnSdaO6xB1lof
         7hJ0HmRQ95xnPMvZfz6RKueUUhqvm7wSbYt9a+cpgmUlega+V/w3x2IiQ/WjdrBAmRxg
         WJ5ceE3BtMmWa2c6rDw0KSdYRVTzg/djy0pJi9e1LefoUeJ7DHWViUbGXB6em7syS9Yd
         p9nXOPR7AIDY89phZnybDXsdkXlQge9/twO1GTjvXVwbm8DSEJIdiw6IdfkLJeXLfbtn
         treg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723506251; x=1724111051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpBGMMu6occiZChHOxP7rE/Knegzcmxp8hIdYJ1YBVo=;
        b=O8ljU6QRdDwpx+lZcBXT0F0QS6NNSjgsu8DNaGvHAUgkJEqiFiru6bBf7i7f9Gjetw
         g2QXbTjCaSPbjBHQa6s/E+5HueUNoF5pUQGU2ognO2p6bG7hQ3PZsbbnqAZRH5yyW+WW
         QCo4GjJv7DEMnS2We1E2XYudD9Ac4+FXKlNvNpShUMZn5JtcbJC8kkaYIICcnZEX0VGd
         bXfV3BHGp3scOKYLWl7rJWcj9hKYCo7KDslEbCWm2L4wSWsvBHvxjqquVZnkQhIUvHaO
         ue80SGf3e1tNAY2vZrn8SEAu3/69wEH/2RP79uF7o2DeST7/RcBn12rKfofnt7Un/1DL
         XtJQ==
X-Gm-Message-State: AOJu0YyElHWZb+Gk96USi8sZE3YpvzFLGXkokl0Z27ZbbKHeoFxiBIys
	E0kKTwnKCaXAhToTO61nmQQs0hss73w+JfPT2kZ5hHSFpDJIRRldlSOTDQwxtLo=
X-Google-Smtp-Source: AGHT+IF9BD4SNZat18CocrzBToFJw40oy8Vtyyksd6IL01W52JbCSNwu9JYf/gKnxy9fDvIkav9AJQ==
X-Received: by 2002:a17:90b:3752:b0:2c9:6f8d:7270 with SMTP id 98e67ed59e1d1-2d3926ac225mr1892401a91.42.1723506251038;
        Mon, 12 Aug 2024 16:44:11 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcfe3c1asm5688538a91.39.2024.08.12.16.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 16:44:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/3] bpf: mark bpf_cast_to_kern_ctx and bpf_rdonly_cast as KF_NOCSR
Date: Mon, 12 Aug 2024 16:43:55 -0700
Message-ID: <20240812234356.2089263-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812234356.2089263-1-eddyz87@gmail.com>
References: <20240812234356.2089263-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_misc_fixups() relaces bpf_cast_to_kern_ctx() and bpf_rdonly_cast()
by a single instruction "r0 = r1". This clearly follows nocsr contract.
Mark these two functions as KF_NOCSR, in order to use them in
selftests checking KF_NOCSR behaviour for kfuncs.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c  | 4 ++--
 kernel/bpf/verifier.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..cda3c326eeb1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2987,8 +2987,8 @@ BTF_ID(func, bpf_cgroup_release_dtor)
 #endif
 
 BTF_KFUNCS_START(common_btf_ids)
-BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
-BTF_ID_FLAGS(func, bpf_rdonly_cast)
+BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_NOCSR)
+BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_NOCSR)
 BTF_ID_FLAGS(func, bpf_rcu_read_lock)
 BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
 BTF_ID_FLAGS(func, bpf_dynptr_slice, KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c579f74be3f9..88e583a37296 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16159,7 +16159,8 @@ static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
 /* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
 static bool verifier_inlines_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return false;
+	return meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	       meta->func_id == special_kfunc_list[KF_bpf_rdonly_cast];
 }
 
 /* GCC and LLVM define a no_caller_saved_registers function attribute.
-- 
2.45.2


