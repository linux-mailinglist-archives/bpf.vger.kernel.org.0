Return-Path: <bpf+bounces-75681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2666C90F06
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 07:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAFB3ACBCD
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 06:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7062D0622;
	Fri, 28 Nov 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPi0JWYi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FA1168BD
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764311182; cv=none; b=t+5imdZsQdSfEmI4Kx45P8i7NxaOddVioD0gdTbkCuxonySs8+73n1WSSMW0slbm00JLrtmrncMvkfxO+OWu0LMMIvVu0x8s35PD6q8mkc6nIQYkTpfCpz1Nj+7mF+WqOm5CA5uMsRUNURgYKP0eMQgBjgObDJj4bEtzH6rePFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764311182; c=relaxed/simple;
	bh=CRtBOxsvowIsrG9IIZjD+TNQdinAURq5wnzAWd9Dxno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chPnGtIE6YlN8FHuwnGpBE3NBkhrlf2sSL+WTrFULIBk6mk9ScQTaQ7hbrGx0cIeWwvbIVhTwf0UzKC+6sCO09oQrSjYtlQ9j9+90AN4qHkyIu+Pi48/zN+e6BvjE3rmwGepNvz19DhZKXnqvwQLkIgktj/hU3pS3k7EWRQ3zEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPi0JWYi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so8735835e9.3
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 22:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764311178; x=1764915978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB5GYR2Y9gT++pcCe5c3Az2yczxHavHJBHiuIl3EX6M=;
        b=IPi0JWYiSIRNZniMS22ofVTsJGJIGjvCS/XSTHFziTwNqJdWRfTa2DJq3JM9IRixKI
         dgx8yMVEDgBw9lgBIzAmsUm/hfciLWGPWnUOmJjEaa83v3407RJSHdvc5ihuXTiNIdMf
         Ru3hXTUljq5dUgoyNjxib5kJRqgkPKUd3GWstVvwcMCAYB79S5sFgEPvwozFw82hERuf
         YJ7tUSHs7TJMxsksT/nYpQ9VyWp0AS74udJgafLitbfbFNGdlZFzci4I+F1mVs9ZfgK5
         +g1EC1aRP4qZa7ionMoIUEOm8N5I3uXC896Q0DfVerVrlMeMWGsEZTdLVH9TD0K1TQdF
         6Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764311178; x=1764915978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UB5GYR2Y9gT++pcCe5c3Az2yczxHavHJBHiuIl3EX6M=;
        b=BNifrhfRvJYNjAD8xh/UC38uVDHRhpYy/oHv/m3exnLNYzUAaadciidbM4rpy/008c
         vO5vvZn6Yz2ZtRRnxv73vHoRsMGFaYiqfOPI3VteKzgq0Pzb1HI61c0xR4m8KfABn4Sh
         QzEVk/a6EBehblJ4gdbdfM4PWJkLytlLIdanN1LFO/8Vp31hrDmbidJKlhVtjvxwSNeu
         TPNZ3Q3JZ8zMzFvtx4ZgdpLOuMfSxqtIeFy9l8BxTIB0Ukl5ynOApp9Q7908JeWshlQa
         QV+EZJ514p6aRnmUVOnGJiWTKFaLYGGxtg1cJc2MU22Xsgk98CfUU+JgPOIffOa14CBP
         nCvg==
X-Gm-Message-State: AOJu0YyFp7nNXywDTJk+YTxEoTzqQuqrobn7Cxpv2BtBcasKkBuKHK0V
	je9cppJctW68tE51HcjuY6Fv/kWNHkOOH+3o1tHaesmNd0J4PpD6KZsWOQIRgw==
X-Gm-Gg: ASbGncs36rJl3vlm04SxJvoBOqAMwWS/9ADa33PINHzdOqHHdwmLe64HJcczujD6in9
	davrAeaUxWVljFdYQRmatIc1H7da48/NXA8vxHh8JTJOed0MYQqpmexjVSi4derGyM2jY226oSb
	Ebxdn/yr4Hb89POIhoqplkc2hSbd0/j96fyZZIvplTQfPsVMw4nkJ93pfzyCsS58cM82xtzQ/ZO
	fi7t4Ht40/zGfj/w71tbP6pOwmPbyseRc8L4QjFiqlZnmMMbY0gpxQn6J11R3Dwwd0GIeV/AYxP
	RHp7LK5B95MvMvN0XLJ1PJ3Y0cd5Nbzl0G56fujYDxi9kag6NNPcRN4rGN9aH/QGdjgg7LTx413
	vD2AYm9Gnims9bsCBa28QiR3o4lp2z1wA+QbXmZ5jdV/Za6yOTAFeFlvJH1DtEEEE7rfkWNAJpE
	PKcJidjJ6z+gfKEFm0vN3RG0/QtMMJhg==
X-Google-Smtp-Source: AGHT+IGovjaQ5vLsQynusCO5l26JM5kYXgGoeafhKOCj/rk1h9WGdu/NivmV/8bMJEKtUwLBLHPEFg==
X-Received: by 2002:a05:600c:1c85:b0:471:9da:524c with SMTP id 5b1f17b1804b1-477c016eab5mr307279215e9.12.1764311175832;
        Thu, 27 Nov 2025 22:26:15 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb9715sm84784575e9.2.2025.11.27.22.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 22:26:15 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 2/2] bpf: check for insn arrays in check_ptr_alignment
Date: Fri, 28 Nov 2025 06:32:24 +0000
Message-Id: <20251128063224.1305482-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128063224.1305482-1-a.s.protopopov@gmail.com>
References: <20251128063224.1305482-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not abuse the strict_alignment_once flag, and check if the map is
an instruction array inside the check_ptr_alignment() function.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58f99557ba38..ddc68273d29f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6482,6 +6482,8 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
 		break;
 	case PTR_TO_MAP_VALUE:
 		pointer_desc = "value ";
+		if (reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY)
+			strict = true;
 		break;
 	case PTR_TO_CTX:
 		pointer_desc = "context ";
@@ -7529,8 +7531,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
-	bool insn_array = reg->type == PTR_TO_MAP_VALUE &&
-			  reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY;
 	int size, err = 0;
 
 	size = bpf_size_to_bytes(bpf_size);
@@ -7538,7 +7538,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		return size;
 
 	/* alignment checks will add in reg->off themselves */
-	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once || insn_array);
+	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once);
 	if (err)
 		return err;
 
-- 
2.34.1


