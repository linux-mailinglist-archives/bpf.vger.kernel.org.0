Return-Path: <bpf+bounces-45916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17BC9DFC0A
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 09:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A0CFB210B3
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDB1F9EDB;
	Mon,  2 Dec 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvfrJDsY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544F1F943F
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128701; cv=none; b=XoKZ+rj1KTNi+JrJ03Heq68TEbAiCdke8PDgpUnPX4CAPG3twKfc9Tp5y/4HKHf+6pylzKWrS6u7XSlAX7tWZ4UokImx2oknZlb0OZ/Vx2cIO9bpJ1P3UFy2K4P2LHT7McF5OlIzTkcxEJ/X2+9JaXGmHXKc5RvSIW+U7diYo/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128701; c=relaxed/simple;
	bh=8QKwIiBntZD2MzUZUX1nWX5FpBk+OIRS/kwzNTQf9wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaqnyukK4luOvDsewK95/HrGD7yEHLpICYaZZnPbNi7oMcJEYi1tDvYTqw3OqGUhSU9syOvKhdGhumt87nIJl44HSA2IANTMrrIblCfHaarD/8HrG8EFc46QDiqgGSWoUebxreEwGHN0cGrGzxx6eN5+3Y2xn+wVtfX5VmRdjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvfrJDsY; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-385dbf79881so1680738f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 00:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733128697; x=1733733497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTJj6emno+kv5jH3LmKF38jEkbL2R9ATn6RutiqDWEA=;
        b=UvfrJDsYQdkJATaMTM83N+bG/KA9teQoo9EIT50o0iLB/ComGxQ6X4lT2lLEw/P1fc
         kjXNZIJTLOtjPqnsKf3lpDbq8DQ/fp3AaI5oozeJsK+lV/xpFhlPUDq6YahyqZb9fg43
         +emTUoOxAw/hnlBvmGtVT0xVx74QQIPsfhLwMT1+LP3P7kAuxZy/NFh1JYGNqjx0QHcP
         DMt0OD6Uu5zd6/Yb+aiM6Hgn2KrzJ3LmZQtsa3amsNdNs9iHxhupQeo8jNiA6OHNX7zT
         OiN6fFGutw38uxnGAnGXIggWr5CTNVrWFDxgxYi0fjRSyqp8vy77Dx2xxc6S9nMZwSIB
         Ixvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128697; x=1733733497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTJj6emno+kv5jH3LmKF38jEkbL2R9ATn6RutiqDWEA=;
        b=Vmxv6QdF3q0i6kdNtHIvlhMUaWO6mYIJ8w45+HGLBA7OP1fY16GOifilvD/FofGw6y
         lIWwa+XW1k8/NRdelguNog/EOvPyPHFbCBMFKx237/54zMpsLOiAAxgNSYPUsDLlS3PE
         U8woXiuW2xKGAepKX9EMAWrn5KrVndAEiPq7+fAxJAKPhkX8esln44JibdtaUD7LKlWJ
         iiDPcpqnjv7+BpBwZHBaqAJK7MrVNscOozjjov7dIqXOXNQCl8VS/UV/Maa81dTcDwQF
         qyC3OYFTpwgPFhuRV5P9aOFBX4JEQhmYBlcVDLml1XTm9yvmsCyfZNfb4iOWW4aahhWl
         EKfA==
X-Gm-Message-State: AOJu0YyhYWoI1jLn8pF1RHuM50wrNu/SFPuynL7RuWMjZygA5T1VPYsh
	tbGO8RityNRv55ViZY2FASPZh0Ptwdoq+4/9YfihMj5qfO9uAe/bnLbIA1Ozrfc=
X-Gm-Gg: ASbGnctEwV7UZ47crZCt1Cbv3VlKOGupRcFtgccAiAQZcI5fhVqQmX7EdPsWvvYFKke
	Lq+yV6eP9uoBCZ0fMq6YmjVpN6+fuvvIoqIvzNgjhTK2ejEotWlK+bV0fMiBEVQs1m93SBbQYot
	491qHZS7mvietW5xKewTgCX/H5qsiQqxIOHQm2L+lOdqa5HPDGOIz84QT3hrUi4IVQgt2VQfQbb
	iF0C6vpUoVUgrAgdgpXg14HcbF+/PNQWSKpSo3hy8G053WiharPtzeCXTKoSE5ShHTxU+RVj9EI
	hA==
X-Google-Smtp-Source: AGHT+IEEiSoyOxP2/lryT3g+9bffFA+uO6NkJLTnH8S1XHRmNnoCeWLxU/YsP+gFxtlN4ZPsvHAsMw==
X-Received: by 2002:a5d:47a8:0:b0:385:e9c0:85d9 with SMTP id ffacd0b85a97d-385e9c0880cmr5107439f8f.16.1733128697150;
        Mon, 02 Dec 2024 00:38:17 -0800 (PST)
Received: from localhost (fwdproxy-cln-028.fbsv.net. [2a03:2880:31ff:1c::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f8448d32sm371743f8f.96.2024.12.02.00.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:38:16 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v3 1/5] bpf: Don't mark STACK_INVALID as STACK_MISC in mark_stack_slot_misc
Date: Mon,  2 Dec 2024 00:38:10 -0800
Message-ID: <20241202083814.1888784-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241202083814.1888784-1-memxor@gmail.com>
References: <20241202083814.1888784-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; h=from:subject; bh=8QKwIiBntZD2MzUZUX1nWX5FpBk+OIRS/kwzNTQf9wE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnTXG0rd01yTqMYIa9RVy7O4XJknp/0sE3CZO69g3J Eo2oQguJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ01xtAAKCRBM4MiGSL8RykyuD/ 4w67fkFqlM7TioC/+AVwJmrTGJaihO4CAzJIYZsPdI2s2vGKfunN3Xhcbx05BP1rfpY88zf4B0YxkE EiJWs3v/ohE3h/53hmAAaprRdRocFWNu/HX2UhuHxh5z6JoX5KW+OKbgRKU/OymEPi/xgfhmpXkUAy f4q5qI5//wZJedPNQPVHTbHo94zMwEPY+1I6xlu1/BZ0y9PwFivPHKbnurPtYK40K1lZFoaB5K0+At mog1nwVzRmUOE7YNH9oxmIZQJPmylqvekgVMzcqW7IHzlDQrpJgI8hTMY6a7JoBXi4Wq73t5nKyZog u3vQzSYuuyK2lvgL1QGkN0158Ioi8eO/KDNxG56Tu03LILHvdTJvR+JX+P+Fv3LPdMkMsaLedB17dz tbMazIAmY5qPTdGobRV+uIcYjERAsLN2HljrUoQuiUEt89xbujGIUbitz+nkYLkvP6EyzcaJ7g6Ji2 G0pq2zratlVaeqsDJr4Zy1oor4ePDCO1wijRpEerbHFMLD9K8RxpQKEFw46ORSwcNDjeAyTcDuSS10 EO7s4N3HYi5BD/ecJUwweBPfRyI5GdCNsTi0lvGcOoqlH30SV+e5f6/dMVNQwffVTd8Ffds7QBT1wq Ig4vIyiBgUAp8PUhW+gojZ1G4cQjaE8aqi+ilG9lBlt3KS4w/ctaZitgFcLg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Inside mark_stack_slot_misc, we should not upgrade STACK_INVALID to
STACK_MISC when allow_ptr_leaks is false, since invalid contents
shouldn't be read unless the program has the relevant capabilities.
The relaxation only makes sense when env->allow_ptr_leaks is true.

However, such conversion in privileged mode becomes unnecessary, as
invalid slots can be read without being upgraded to STACK_MISC.

Currently, the condition is inverted (i.e. checking for true instead of
false), simply remove it to restore correct behavior.

Fixes: eaf18febd6eb ("bpf: preserve STACK_ZERO slots on partial reg spills")
Reported-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..c6a5c431495c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1202,14 +1202,17 @@ static bool is_spilled_scalar_reg64(const struct bpf_stack_state *stack)
 /* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID, in which
  * case they are equivalent, or it's STACK_ZERO, in which case we preserve
  * more precise STACK_ZERO.
- * Note, in uprivileged mode leaving STACK_INVALID is wrong, so we take
- * env->allow_ptr_leaks into account and force STACK_MISC, if necessary.
+ * Regardless of allow_ptr_leaks setting (i.e., privileged or unprivileged
+ * mode), we won't promote STACK_INVALID to STACK_MISC. In privileged case it is
+ * unnecessary as both are considered equivalent when loading data and pruning,
+ * in case of unprivileged mode it will be incorrect to allow reads of invalid
+ * slots.
  */
 static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype)
 {
 	if (*stype == STACK_ZERO)
 		return;
-	if (env->allow_ptr_leaks && *stype == STACK_INVALID)
+	if (*stype == STACK_INVALID)
 		return;
 	*stype = STACK_MISC;
 }
-- 
2.43.5


