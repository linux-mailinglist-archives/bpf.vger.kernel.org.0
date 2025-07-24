Return-Path: <bpf+bounces-64294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963EDB11076
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 19:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A1A1CC179C
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EF2EB5DA;
	Thu, 24 Jul 2025 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPAitIA0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB91DFE0B
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378978; cv=none; b=VpElVhjPOzfthx7Z2Knt1AqEC0cuctAfT8KCNPSk11mNQsovmx1rv2vhWFHKrCzUVC9LmVkZQs1V6fMvjL2hcxHJrypvCD2qGGPz8qNwdHtbEK1efx2Dbt0hzqt01AiyacNULeMLg/2WQGMYnw4eItPBdXP89AA8zOp6csZes6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378978; c=relaxed/simple;
	bh=Efu+HhvHGD3ZjD+Hy9dfkWh59yBhOIjYPuDWKDna93A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BEGWpJHekIecWYmUBbSeeKygaGvXnEvbn9whIKmcVFqscdNAsq9frMX1ETIJZeTTaJfXDha0LB3PO7uBSD72pp60mehKyAL8nesBGnl0uFtU2LHr4W2xy9abcQNbBVk0QfwLNQqtZszOcS8i4ElGBzbqdWPXF96OUUd2fT0pGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPAitIA0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455b00283a5so8256165e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753378975; x=1753983775; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1y3nzDj32YVrSPKFfCZibGXhcw9AqyJc9yveENZaQMM=;
        b=jPAitIA0xC8ZpDIHyr49gea94Kq8kbACanCd6CqB9KvdlSDYhZTx6f+ODiBTykWonv
         SU6CIaV/cmeAbz7AUQpFUPfgwgg+/zy0913n06XoQItL6drn8sr42FQeEEhzzvMrJ0Ks
         DlOhc1SjrvB4OEzAmZPsOnBKXc4t4amSGsCVKzqos+8MXL3gsVH47uyXXaC5YPGSNvPG
         3rpJRWcv1r0sJv7VIyzTNndM/GhEHvyygM0RMv3JujA7k0wXl1e+RtXQQ8Bab3Ppp6r0
         E4DIIayWGIOMyzFi3iTULKz1J4b9ltm6kLzxMus/eJZ+9ID4E4fQuQkp75VjfBlqixLL
         tYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753378975; x=1753983775;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1y3nzDj32YVrSPKFfCZibGXhcw9AqyJc9yveENZaQMM=;
        b=gOERUDvy9Bo4sp1VnB6CAg36QWMHvvbwQ4uflbUFd0JzaZRrUPieZQYNo4LuDDG5es
         ZQfrLAkFD16tmQeX0gOKTwsVW9KfhdvtHapVMJ7Zyzik1C5GAgB/I9ATh7jtLnP+kBCa
         iLz40mNHmKCsX73CvNgNycwpESAOZmPqB4/0jV64O/Uvx0GzenNEz5oQYPLbWsVwV8b0
         Ee1n+7EQJMYcXDlxZCbvPdS/V2pnT5CugORccXgy0T4t0CltiMWhakyy8E1Pauz7SGDa
         O1/G+cRyWBWzFX5Dsnzy7TwUoSDMFsITdib2UslccqRt+Lh5yrluOLe6H5tmhFObCyNw
         4j+Q==
X-Gm-Message-State: AOJu0YxFKB+PLbrW0OJOOr0UyZJnPuyv1pK9HcTLks65wBtVsqOZ4szu
	kCsAhrtEYoOsqtdQnmeIeyW7ZsBXLX5/nUDDEr/IP/RTkCXHdZEG9PGOo/cZmT0A
X-Gm-Gg: ASbGncvqdk2Yx9Ity9LnKjfkKBPI8yvr7ef43q5AUJQPjjKWHr+IraJpF5vpIqsAW36
	o2d3lbqvQ4YaAY+DMUbLhCJTbNTpq8tFIZWp3a9Ot+RCNa2ZyuwvUgKk6X40Mes8/MqV/q5J32T
	c08yy0Pk+6ssQvpp1vFvl8t3IDLXv+i73aBYeZjjT6Scd8cUuhC+hbE90iQ8oQZ7JFl1akYbFax
	5A0PpbXcjxntnRsCM3v7BUur7WuAgcNDh/y0mZcw2e0JkFY8VkLkPY+KbxRZfZWlWXQXkVGg2qr
	bNMtw/qhLgY6sTXuY4mLulC8PeqjJ6LFNpbDqoyk2fRhJ5Wtw8lJXFsq88MP6/5TZKnOnpa2Jb5
	B1k/Nw6TO46ezACRfBVN81vnNeChYKGdnHpL67sREsu0FeUu2oRJrOy/XV7dD97CWL78JXDbFEN
	ao8Le2v94BBtk+mgXB9D6b
X-Google-Smtp-Source: AGHT+IFIRCkaznvUaMBuYHDf3tYWQZDqD+AjEM6GCjuqZ6Js6R8KKYLhB3sTDbh6oxW31qb8Ip8U6Q==
X-Received: by 2002:a05:6000:188e:b0:3b5:dc07:50a4 with SMTP id ffacd0b85a97d-3b768ecf2b8mr6922928f8f.2.1753378974718;
        Thu, 24 Jul 2025 10:42:54 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00667e58c39c19dc02.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:667e:58c3:9c19:dc02])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b77078b1absm2570029f8f.1.2025.07.24.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 10:42:54 -0700 (PDT)
Date: Thu, 24 Jul 2025 19:42:52 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next] bpf: Simplify bounds refinement from s32
Message-ID: <aIJwnFnFyUjNsCNa@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

During the bounds refinement, we improve the precision of various ranges
by looking at other ranges. Among others, we improve the following in
this order (other things happen between 1 and 2):

  1. Improve u32 from s32 in __reg32_deduce_bounds.
  2. Improve s/u64 from u32 in __reg_deduce_mixed_bounds.
  3. Improve s/u64 from s32 in __reg_deduce_mixed_bounds.

In particular, if the s32 range forms a valid u32 range, we will use it
to improve the u32 range in __reg32_deduce_bounds. In
__reg_deduce_mixed_bounds, under the same condition, we will use the s32
range to improve the s/u64 ranges.

If at (1) we were able to learn from s32 to improve u32, we'll then be
able to use that in (2) to improve s/u64. Hence, as (3) happens under
the same precondition as (1), it won't improve s/u64 ranges further than
(1)+(2) did. Thus, we can get rid of (3).

In addition to the extensive suite of selftests for bounds refinement,
this patch was also tested with the Agni formal verification tool [1].

Link: https://github.com/bpfverif/agni [1]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..d218516c3b33 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2554,20 +2554,6 @@ static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
 	reg->smin_value = max_t(s64, reg->smin_value, new_smin);
 	reg->smax_value = min_t(s64, reg->smax_value, new_smax);
 
-	/* if s32 can be treated as valid u32 range, we can use it as well */
-	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
-		/* s32 -> u64 tightening */
-		new_umin = (reg->umin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
-		new_umax = (reg->umax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
-		reg->umin_value = max_t(u64, reg->umin_value, new_umin);
-		reg->umax_value = min_t(u64, reg->umax_value, new_umax);
-		/* s32 -> s64 tightening */
-		new_smin = (reg->smin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
-		new_smax = (reg->smax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
-		reg->smin_value = max_t(s64, reg->smin_value, new_smin);
-		reg->smax_value = min_t(s64, reg->smax_value, new_smax);
-	}
-
 	/* Here we would like to handle a special case after sign extending load,
 	 * when upper bits for a 64-bit range are all 1s or all 0s.
 	 *
-- 
2.43.0


