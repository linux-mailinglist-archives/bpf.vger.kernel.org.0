Return-Path: <bpf+bounces-64263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB80B10BBB
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 15:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556B11898CAC
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285D52D8DAF;
	Thu, 24 Jul 2025 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGSCVPRu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B31386DA
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364529; cv=none; b=f8eK394ypDSlMapMC16B/pQ0n0L/JtdiCdYGFQnadqBN9n3yzvAnvDwUXlZaEXv0bwmztUEuhOFRYeWgDRCRyg6fiG00KWKJHk7zrKyyIDBWmnVgUDvMbXDom3/kXrg1LzutpaB2urnFfO7yzTz6T0MPaX9pv3DpEUG7tX6UcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364529; c=relaxed/simple;
	bh=S0YtPSsFFIeilcoVsVKqhND3i3iGn3HudquMi/jmwco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhlP9GwwFB9n0CjzrjFixVvKFIB6Rihg8mBlYfd2J/FuYDPcWtteHHcd2L3TybJ4+fiiukQ7Q02/knWNTUxhKn6W28jJdBKyvm3IzNRBHBOhnoQTyhiOvfNZIExINyuoq4W2PXtyCh/jnQqAMCTfILO7eA1V9sRbLZaBHLg+4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGSCVPRu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45610582d07so6990325e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753364526; x=1753969326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WGRiSe+7Xiuz1fjV1TvGaT/VVSNOhMJE3qjLuMMa6o=;
        b=gGSCVPRu3QpzYAl6ahTAYg5XeMH5ncNUpObDPo3b+PNOEFYnNoZ8ntlWH6lbxc0dYQ
         YjRjMisxdLUL+f2xz7Q9vQ78cMl0X4+gAVtzastZyWbKk4lpvib+Vy+AeU6tC/b+hp1m
         iQB1qjoYGUSztZGWoiRkEg0MqxaJ419bSfMJId6GEqy3l8cAekfjPGgKHgr+bBuR6MvK
         iHaq/uqDDiu7qw0leaq2wdDck/22/O1yGwVUKwxpAY4fBMG5MxIl4bF366S/CQ2kCak6
         48MEDgcdZj/i4aBw6kEbxqMz5OCCAnJ4nS4PrbICkmggnMklasWbfLZ4YSHjv8tWnzrY
         K3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364526; x=1753969326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WGRiSe+7Xiuz1fjV1TvGaT/VVSNOhMJE3qjLuMMa6o=;
        b=t4vCWRnVheFvEY8e6jhk/FL773BCHnFNOH42Zisf9H9joBb4fIr32TIgqBVmtOFXfZ
         ulFN+Rzj6N50B/8Xg+mzK6xU7UZnELREyY+x5B66FPB0/JvzRLZYSkuYwRb+ID08CI9u
         VAFSTSwmxZEkGHjziQZR/HkNi1WPYM4OnRfNlKBb8zkF3ZPvJwFOiFLMKgXKZVUJ0T7M
         Yq2B+CCs3fRXFNlmi7jBdslFCk897lhB+V3IzfRJrr9VNcJVZVXZfYsOmlu39iubmdO8
         DNZA27wz3rA7WGNVU8C2z0d2FHCLdSy1hvMXYQk/COhBrX5SuxQFyKulKk1BlNYJfhhd
         C7mA==
X-Gm-Message-State: AOJu0YzynxjZoteBr6DJ53SJUGd/1MPeSMvUXCGKA80dJhcOcMsi5XRv
	bHzT01GXdAAOq+eEk5a5FOkAKQeJ/ukSM9bkvyYdoEJLEUF8O08SA5BeNJy3p1Qn
X-Gm-Gg: ASbGncvoZK99ORUAODQqLVJdcJg6kdggDzJ0DcK3PubMXypckMQ3D9L0WvAhtY8kzwG
	ihByhEhSzdoHHWBhYmS8vjTLWmRaEKUtjPcFS7WL/dTS+iJ1q+hwzpIkNgqyFatWE6B31JfeGzt
	8/9OT7vzIeDc8hxTm3xa8rpa5K1n1pMVcPBijIAOLLqBw4JZjGt/Av1e8Qpdwzw4EYBe6rSkAiH
	+H2S0qPUhM/uSjTNxNq8Fa2M0S+anw+yfXeP1Ne/OjBT3moLONy30EBA9dphggyiYjFo8wdA3fZ
	j//eagpUglVJbWVer05uUPIVoZV7Khh9SNVLTBm9EPHFe+j7Mo8UMFalFjuydLQBsk1ro268VVh
	4XyTRyO+m0WD84KOpSX8znHd5kU3SoNZwtJP3bvuUUsc3vyKiYuxdPZUGDGwGQTBI/ymyYHUd8Z
	yEx2KUu3cSX3ylVHkoMOLJ
X-Google-Smtp-Source: AGHT+IEgQWm9+vqGJ+f41BRfbQ5vjNwKAqee3nVe8SoAgqP82ocIMns7IccKM85iuZpxp+tP65bbmw==
X-Received: by 2002:a05:6000:1ac9:b0:3a4:f520:8bfc with SMTP id ffacd0b85a97d-3b768f162a8mr5724333f8f.36.1753364526021;
        Thu, 24 Jul 2025 06:42:06 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00667e58c39c19dc02.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:667e:58c3:9c19:dc02])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b773768440sm495834f8f.24.2025.07.24.06.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:42:05 -0700 (PDT)
Date: Thu, 24 Jul 2025 15:42:03 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 1/4] bpf: Improve bounds when s64 crosses sign
 boundary
Message-ID: <ded8c654d880b97fdd31393220038f2b5d8ce327.1753364265.git.paul.chaignon@gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753364265.git.paul.chaignon@gmail.com>

__reg64_deduce_bounds currently improves the s64 range using the u64
range and vice versa, but only if it doesn't cross the sign boundary.

This patch improves __reg64_deduce_bounds to cover the case where the
s64 range crosses the sign boundary but overlaps with the u64 range on
only one end. In that case, we can improve both ranges. Consider the
following example, with the s64 range crossing the sign boundary:

    0                                                   U64_MAX
    |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
    |----------------------------|----------------------------|
    |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
    0                     S64_MAX S64_MIN                    -1

The u64 range overlaps only with positive portion of the s64 range. We
can thus derive the following new s64 and u64 ranges.

    0                                                   U64_MAX
    |  [xxxxxx u64 range xxxxx]                               |
    |----------------------------|----------------------------|
    |  [xxxxxx s64 range xxxxx]                               |
    0                     S64_MAX S64_MIN                    -1

The same logic can probably apply to the s32/u32 ranges, but this patch
doesn't implement that change.

In addition to the selftests, this change was also tested with Agni,
the formal verification tool for the range analysis [1].

Link: https://github.com/bpfverif/agni [1]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..f0a41f1596b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2523,6 +2523,58 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
 	if ((u64)reg->smin_value <= (u64)reg->smax_value) {
 		reg->umin_value = max_t(u64, reg->smin_value, reg->umin_value);
 		reg->umax_value = min_t(u64, reg->smax_value, reg->umax_value);
+	} else {
+		/* If the s64 range crosses the sign boundary, then it's split
+		 * between the beginning and end of the U64 domain. In that
+		 * case, we can derive new bounds if the u64 range overlaps
+		 * with only one end of the s64 range.
+		 *
+		 * In the following example, the u64 range overlaps only with
+		 * positive portion of the s64 range.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
+		 * |----------------------------|----------------------------|
+		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * We can thus derive the following new s64 and u64 ranges.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxx u64 range xxxxx]                               |
+		 * |----------------------------|----------------------------|
+		 * |  [xxxxxx s64 range xxxxx]                               |
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * If they overlap in two places, we can't derive anything
+		 * because reg_state can't represent two ranges per numeric
+		 * domain.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
+		 * |----------------------------|----------------------------|
+		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * The first condition below corresponds to the first diagram
+		 * above.
+		 */
+		if (reg->umax_value < (u64)reg->smin_value) {
+			reg->smin_value = (s64)reg->umin_value;
+			reg->umax_value = min_t(u64, reg->umax_value, reg->smax_value);
+		} else if ((u64)reg->smax_value < reg->umin_value) {
+			/* This second condition considers the case where the u64 range
+			 * overlaps with the negative portion of the s64 range:
+			 *
+			 * 0                                                   U64_MAX
+	                 * |              [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]  |
+	                 * |----------------------------|----------------------------|
+	                 * |xxxxxxxxx]                       [xxxxxxxxxxxx s64 range |
+	                 * 0                     S64_MAX S64_MIN                    -1
+	                 */
+			reg->smax_value = (s64)reg->umax_value;
+			reg->umin_value = max_t(u64, reg->umin_value, reg->smin_value);
+		}
 	}
 }
 
-- 
2.43.0


