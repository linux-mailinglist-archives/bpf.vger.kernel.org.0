Return-Path: <bpf+bounces-52217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A679DA4027B
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 23:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465CD17D4DE
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED390253F37;
	Fri, 21 Feb 2025 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwKpQ9EC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907620127C
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176051; cv=none; b=qxT6HlwBaomw4a5hW3AToG58n2Z+E7ycUmyrIHxXtnTUbJlYYWM9vvx9i01k2wYY4aIj6kt6a7m2JMpcSpkSo36K9s4SYojR24J07OKNE4Bm5b6s7S5A3xpBOjFcEtiAyKZuwn9w70Blb7+acIjMvo7tvcwJ0BALunqOjs4M1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176051; c=relaxed/simple;
	bh=ed/GGbgXRmxe2+M2D6XTAuZ8n26/pWnO/d07WuuViZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTzn4bgc85HrwskWxn7m67vpWiZS/06uR90w2CimMSmj6Q+LQxWhccRhRGXKomdcikeZ0D8hNcKuFhv77djCgYzJxnceVYKgU1qtl6d6dR4vUH/FNQVe0fO/Uxm/b96JXTrV6n02Q9ZCYnAG7GqVVYovaBkt6CbgXK4J3xOTAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwKpQ9EC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f22fe889aso2212150f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 14:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740176048; x=1740780848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn1BX9y76DZhXdWo5I/TVE3tCtue0TCmEwlwjM7p7HM=;
        b=gwKpQ9ECwb5Mf6tbvTjU4iEP3GLLTHeTklFjjAAFylawciX7g6pgxc3/AUf/VonYX1
         G1VO5AvLNsvPM7hMqXMIC23sGuzJln9FqAH9LfIj5Lgd2YRut5bqmCFN6Hc4MuKkJmQp
         frD3FjMfnGL4dDES3bdhmbRDR+XyPxCMgs/PTUM41uGHRGQzhekuPojFgtif+hKgIgAW
         Q24m3WMth3PdDXB5qfuA7CE3xAGomfR2Idi4luaCbMC8DnoP9Jt9uCD/HfW9N4MqS0S0
         Y+geI8HOOJRcsjykjsPyvz5jj7QwwSTzbItbluj9NsB1hndV+8qfLjnohdanpgzISQJE
         Gx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740176048; x=1740780848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn1BX9y76DZhXdWo5I/TVE3tCtue0TCmEwlwjM7p7HM=;
        b=pfu/6gK+UQ8RuEaalQniijiOFOO3/mY4NnGn82e0U8+SOnnETxB1wgsGKu3mzV+v0v
         +pgZEGVJ7YK9bgvKFP1jU57InjFr8XOWMM6iJFQ2NuqiBXSuenh8hCeMOpgCyVFWIviq
         KcFsUwVTmSYUyp/v2HZBgMc2K8RD/IBFlLt9+UL4YRuEHAbsKNKh7l7pVvlksVma0xkk
         ry7RaDNEhG4NbVhKDYzveAEeInbAqYiUDtz9geF8LFVGqqMDoLWfdeQrNuPNUtiWGxMI
         yyAh289fXt1AWrEvX8eZALTfH6VlkE4lY/aN+0F7K2AwQju+yH35e29Cq380h9az7Bi9
         enAg==
X-Gm-Message-State: AOJu0Yy2KWko4OX+GqivJritwhwzkm1/d2cZgQJoil6BxxRM0GRoriKF
	lsMnvkrWDQEAVIDIZPGAqZ3h6orY63ClqkpzTTGsjij32mCVGrDyNSQPaA==
X-Gm-Gg: ASbGnctd8UKAZAN5PHx/5CzMpw6V7VStuMmCnbRr5IWvC9LCuRohWX6qCbNBzEubclW
	uYBRpUMFFM3b8WSuhA15OsriptLIx0RmL+dwv7HG/nT39bv2BhBOZbPL2qy2c4XBF0Tm8UamijM
	xQHaYkuz0AckRhOBi4tOJe4HleApbEz65T6uMjvEy7pnSNpYpH0YO2PK474xVhaH0m0WQcgGEkS
	ZINwbpAnuG6MmDyj1HNXsP+o0AO3rfW6E8cOfNqAYRc0Wt+XhAzG3SX5cAKh8oUmodQDPfMjuNl
	L8G5HtFOEcPAiRBEvGyPDeQInoSssLczc/csdVfQh7rEQ6IM9xGVwrvYSHFUtsR40c4/BvvCGon
	uRqrr2CRHw2jzehgyTFNOejCPQOtyGM4=
X-Google-Smtp-Source: AGHT+IGvlMRMFvZtG0kwmv2zjh0T8YEoQye3hkvL4aqcgZwtxWFXm9afnlWC9iLioDwyVDP4TNZHxw==
X-Received: by 2002:a5d:4c81:0:b0:38e:48a6:280b with SMTP id ffacd0b85a97d-38f6f096a76mr3031950f8f.34.1740176047817;
        Fri, 21 Feb 2025 14:14:07 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm24070707f8f.86.2025.02.21.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:14:07 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 1/3] bpf/helpers: refactor bpf_dynptr_read and bpf_dynptr_write
Date: Fri, 21 Feb 2025 22:13:58 +0000
Message-ID: <20250221221400.672980-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com>
References: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor bpf_dynptr_read and bpf_dynptr_write helpers: extract code
into the static functions namely __bpf_dynptr_read and
__bpf_dynptr_write, this allows calling these without compiler warnings.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 183298fc11ba..6600aa4492ec 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1759,8 +1759,8 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
 
-BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
-	   u32, offset, u64, flags)
+static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *src,
+			     u32 offset, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -1793,6 +1793,12 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
 	}
 }
 
+BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
+	   u32, offset, u64, flags)
+{
+	return __bpf_dynptr_read(dst, len, src, offset, flags);
+}
+
 static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.func		= bpf_dynptr_read,
 	.gpl_only	= false,
@@ -1804,8 +1810,8 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
-	   u32, len, u64, flags)
+static int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
+			      u32 len, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -1843,6 +1849,12 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
 	}
 }
 
+BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
+	   u32, len, u64, flags)
+{
+	return __bpf_dynptr_write(dst, offset, src, len, flags);
+}
+
 static const struct bpf_func_proto bpf_dynptr_write_proto = {
 	.func		= bpf_dynptr_write,
 	.gpl_only	= false,
-- 
2.48.1


