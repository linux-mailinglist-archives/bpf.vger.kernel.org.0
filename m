Return-Path: <bpf+bounces-64497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598CB1386B
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B86B4E1622
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6570821B199;
	Mon, 28 Jul 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET60zzJI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369B61EB9F2
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696259; cv=none; b=gS0dwW8WH0spZVlWNcV8OyFQ9DqfNOLiq/UDJmUDkNFfU0pK1pC/mM76tflTmHOhBb1f5eKsjwSVl5RQyQzBy9SisUK1mmoyVXKiH9Yv5dqs+3F9+KSN6XQw4zQzo8K/Feg9q9aaTk/0GEaTkIAU8szHDtDYfGu5vXADAaazKV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696259; c=relaxed/simple;
	bh=NglSfpVpig8qw9KP+VL3sJk7QJ87tJk2Y1demdsu/e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlSJDn8WMWxh/FngcvJH6z5o+d7LskKh9S04VRuOIo7pF0MitfiJbh0WM8kpv4wnc+eOoIS3T7ZegzxTzKWGbSnCEFT1rO6w2kImIyyziPHvjxakdaaqaNBJbgvCQYelhtdoodbakf09h+3qKzJwkcrVD1jK4CePkenjQ+9SgQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET60zzJI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7886bee77so813968f8f.0
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753696255; x=1754301055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWceArD6wLi9eVUvOYFHWoA8V6X2uiBbwkuMQLqGWpM=;
        b=ET60zzJIjuFDaCr3lbuiLJ8qb3Q2C22m4pyL9k1TIY9br5olYp7E5fsvFhZmDPcBZr
         DYYXsNfO6Q0oRIo6YwGuM/kY0O26GbONCsVMi9ubOLcPjceUMiqy7dazIElRo9nNtHsA
         IEvWysF1HITHiIvR+1rEVY6/UgzlPrfu35b/ooRCFw8g5nXBbpQysBq1m47qdSDH3MHc
         foTW+LwDytbkEvdGCJuzAEFtidZuWkRW2qmyD/qFF5AtXqtE9Cki7jwc2VfKwBNYEUk3
         RLs/n1raiUx0xfHqbd7eDCelGDGVJE59U0fqH+lSdkyetPQqkupPNS0MfOjiES9v8boE
         D6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753696255; x=1754301055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWceArD6wLi9eVUvOYFHWoA8V6X2uiBbwkuMQLqGWpM=;
        b=DjAs4d86eBVOXjLtWjoJODzGhwAx3yxevqs+dvGik2r6iwHnktInHRP3wDKnv4ZDhL
         HLpUsTI0ZQBDZmGQhZHOyFa3LcBnCV0ihV6Z2Pb7HtCDTNa6FjRK9CuO8zEpJA/B5B69
         8ATIqTSdJju7j8/DY54EBuPsLWXm6zdyRIIQqp1nHUCdkot+qtt9vAMN69qfTh6krDJE
         6rWLmUR5qbGTGg+lKrLrD3XWubRluAhqeKqOmBIlUJbz+qUUfhi9DTIpkzfmLBHSJzbs
         4csk+2TvR7cIxphs2RN7p5CTzejYwbgDnp/+uIOD4L2YfylJfvSSyliiav/se5YKUvz4
         uwGA==
X-Gm-Message-State: AOJu0YysW0PrXzCBgRAThI2mhPA5Kv1cGjYdqkzdVMruv0Kq5X+A994U
	mS2ZNPalGAYVxz4Hxn3Iz2u97WoQRjKNMco2jfUffiGfcJX5akP+uepgFaxx57HK
X-Gm-Gg: ASbGncuu1SbQdGmBl7Cth6ALwqSG22r8QA4SnjHDZW7KKwyMlCM19gxrMwhf1HBHSzt
	AZJ/i8QMxsWPNG9hDy7POoDdgBJsw0Brc4heTeXZ7umVdEyMh4zJJmidRg5rma3VXUnkxiTMMQk
	nq8sQCOpxZwAIkxazMMlDYf50N8y502hhQFXNi8j6OYyhI5eKtCXZu2yN6S6fOjCLjkj8SG3uPE
	LcKVTZvd53NswVowPP9H5+EJAeFOeXWQ9975RuJBBD+snjkYoH5etZAbxNVaUYRvpiOCxxVmeCl
	MAzQ3+NW9PMeiloHSJuFXkGTAIW0I2Vw6/PiSqOUhzj+FKmEbeSXP44YxtCyC7TH0SLgrVPx8Rj
	+Imk1bdje2H81R7glQg0G2oAhiymBmHX/td9pGqf0uiHlKdPCqqCjzqHVCAiDMCcNJcpM+5u848
	lj1zcAarZGWmS37I/uo21zW58nmwVeUg==
X-Google-Smtp-Source: AGHT+IF6jaRsW3qelbOyhjHhYHxcb7hTJ7EsOwUt6e22GO0NZLYIRT95RYaLK5rh1r/1WqJ9WHq8/w==
X-Received: by 2002:a05:6000:144d:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3b776601aa0mr8004458f8f.26.1753696255256;
        Mon, 28 Jul 2025 02:50:55 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00616c0b53953fa0e3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:616c:b53:953f:a0e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7842a3e59sm4814844f8f.44.2025.07.28.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:50:54 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:50:53 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 1/5] bpf: Improve bounds when s64 crosses sign
 boundary
Message-ID: <933bd9ce1f36ded5559f92fdc09e5dbc823fa245.1753695655.git.paul.chaignon@gmail.com>
References: <cover.1753695655.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753695655.git.paul.chaignon@gmail.com>

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

In addition to the selftests, the __reg64_deduce_bounds change was
also tested with Agni, the formal verification tool for the range
analysis [1].

Link: https://github.com/bpfverif/agni [1]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d218516c3b33..251e06dc07eb 100644
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
+			 * |              [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]  |
+			 * |----------------------------|----------------------------|
+			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s64 range |
+			 * 0                     S64_MAX S64_MIN                    -1
+			 */
+			reg->smax_value = (s64)reg->umax_value;
+			reg->umin_value = max_t(u64, reg->umin_value, reg->smin_value);
+		}
 	}
 }
 
-- 
2.43.0


