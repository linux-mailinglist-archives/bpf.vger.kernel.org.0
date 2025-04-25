Return-Path: <bpf+bounces-56690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA2A9C9B8
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 14:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AF57B964C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB4251783;
	Fri, 25 Apr 2025 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIfgqukb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E223D2A0
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585970; cv=none; b=u6tsGKE1T0byhpCBPSuVdVSDFuoo9CUFdQYWwXQutliVOhS/fZc9OSirB4THgj6CA+rMJfEdBO2yY41iiHKOgg+CwXxU1f6cL8GWn5Oy0aRArw/V7tktkVtg/FBjdPwIr6cugOa0vlSsW+Tzpox5EsPCYDdA/Pu+YIt/yOCM/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585970; c=relaxed/simple;
	bh=Dsa40l5KZS7KToKryG9VdvRzU9OyYIa2pRh1fhCJrj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebp48WjtBEetgS3WIwDibIkyTp9dS+Vw/i37PTzH/UKKGuQA8N2OaDA2jRGiZfyPtpgt5LCSk/vQWIYMQvptftkpPzcI81fQthQittpoIvMYiMO69tDPH2IQ3hk2m1vpLfc3CnOM4wRljnRdd2lxVaCkXklCJ1Wj86Neq9cC2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIfgqukb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so3507783a12.3
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745585967; x=1746190767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKxZC/LPIkroY+2p8+IVnvwvvWjJzYAfr3egjhHGBfQ=;
        b=jIfgqukbiHHEcskpZga/qLJNwQUVEdct9w6Lums8CVzilte/q2djPVcwzPXHPt0bxw
         ZpjfuYJvGPuimFaVdSmf+mctRCSR1qorW6dBokZW6URZzfA0gSBvfKzESYwGfu5y9pmQ
         iJgOsXI/TRss0o0Z9zd6LqILcMndtteYKAJLgZGknnsPUB2CigZua92LpvoPJ7VYGToq
         K6EXGoKQk8PmaelhMLXCyIIDJIBiTTuPeJkzguT+2y4gpufxtU4VhR7OzRTLGpC+Z7Ft
         Pqw59BFh9YSRdN8x71JpsB4YymUas10bIUdEdjb9NSqAKUJoQTrvuaSUh2v5dvgD6G9S
         fwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585967; x=1746190767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKxZC/LPIkroY+2p8+IVnvwvvWjJzYAfr3egjhHGBfQ=;
        b=U7z/KOS82MeZCE+CUHROa5+1h7fedzwb3GqBR9rBw3pOgvwuo15Pbc7nvlZesDEAlo
         NZy8Bp6BcOZcpmCS17vNxEsxZuj6iuffLyYeQqVpNl5S8dmkSBg2v9PJb88XZNr5TvO9
         azoZvLL4+7JoPz9e7BZAN+zwClzXfde16lfBOrPxXAds/U3fLmL33qzpBJk+3+t7Mbgc
         fr38NUjCYkh9/xMscVcUBytcp86j3TaLLpe4iXxFVJxs3Ri79BmcB6Z/w8hubiIhjbOI
         TArqKWXVmpPjBTp6iW3vv27ZibEhK/LR9IncoxUaPNrTG3bkui0b1QfHD7ua11fXGUdP
         eOLA==
X-Gm-Message-State: AOJu0YzX8Ia8aM8+Fn/W31CiO/M/y5HseUku6BCX6GkiZvIOIo49Lqeo
	maiJOgckwe3FDyMGV2aOJ9yrP+a7XTntElTZR4n79UUWUy+R1ReiJy1mdg==
X-Gm-Gg: ASbGnct7aVZ8/K3sjWAA03WvWRoU9jkiS+CC28MDL+naSPrWtxzWIs+PEZGj2cSdwMn
	gIyHOFMz/Qutan2KEX6+5Cupiek49KIkCI+Mz7QHyK0QgRW3TPObz7cYqArza2xWDTgAQPBkV7W
	I1l0I0TrNq/AEGbgGb0f1HkqY05Znxh0JHhqWtJx8ECMJWqGLLGGTmFQY1o1vY4I8r+ua9bavUp
	2Ev2FHQq5cW6I4XQBfQkNzXDCo5LD2SPRHT4om5XAG8ov1UZ/jF8DEAySviwIgfNDWnZgFBYFEp
	PGPQ4o5VlHX9naAXHtO82l/guyAAGE3rbBbEUFRyuQsK9tn1PWFbOzSnURTFqpM=
X-Google-Smtp-Source: AGHT+IEoF7/96R/KQJjFAzl29pob4yw/i5DrhofZ3IlA8AWyAUpXY2ntXPqkS2A47r/I7arPA7tnIg==
X-Received: by 2002:a05:6402:27d1:b0:5e7:110a:c55 with SMTP id 4fb4d7f45d1cf-5f722b6d3b3mr1985569a12.18.1745585967069;
        Fri, 25 Apr 2025 05:59:27 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:400::5:eb6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f701106bcbsm1224669a12.10.2025.04.25.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:59:26 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 1/4] helpers: make few bpf helpers public
Date: Fri, 25 Apr 2025 13:58:36 +0100
Message-ID: <20250425125839.71346-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
References: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Make bpf_dynptr_slice_rdwr, bpf_dynptr_check_off_len and
__bpf_dynptr_write available outside of the helpers.c by
adding their prototypes into linux/include/bpf.h.
These functions are going to be used from bpf_trace.c in the next
patch of this series.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h  | 7 +++++++
 kernel/bpf/helpers.c | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..14f219921b4c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1349,6 +1349,13 @@ u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
 void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
 bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
+int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset,
+		       void *src, u32 len, u64 flags);
+int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len);
+void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
+			    void *buffer__opt, u32 buffer__szk);
+int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr,
+			     u32 offset, u32 len);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..2aad7c57425b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1713,7 +1713,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 	memset(ptr, 0, sizeof(*ptr));
 }
 
-static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
+int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
 {
 	u32 size = __bpf_dynptr_size(ptr);
 
@@ -1809,8 +1809,8 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-static int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
-			      u32 len, u64 flags)
+int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
+		       u32 len, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
-- 
2.49.0


