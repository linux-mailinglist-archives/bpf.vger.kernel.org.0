Return-Path: <bpf+bounces-64409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E90B12496
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 21:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1272E1CC0E31
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF4257451;
	Fri, 25 Jul 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA9Dw65H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0013595D
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470428; cv=none; b=u6xuIf5ufmZEkkF1cIbBWS14LFTigWYje02DF/G7teSJiHNd2ky8D4WW2peHbBLj4DFtZObkHK0bbSPGv0BGBeV+K7xQ51a3BRNqfoZzSDGFSXyp70ffcPk4GdHqZzmOTXjhGDmcnfNcHKFnbr0LUMR4s7Uu92AEUQ1Bd52wU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470428; c=relaxed/simple;
	bh=RBmw6XD7fmeRexE03x9LzQmEjO7qnkh4vP1tPZ7BWpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onoc43lH+sAMKQeD+nSYZj8QFKFdUgNAVUjzsW2jv91ftOMHvgoL9qBgsvI6uFNf2YTa278RmrFBQwyBF3M03N7pjGA5+qWveo/7kY1PYeay8ekiRSZW0k7snsysw5cXpUxIYRT91E2Fzu13THv8nU1vGS6XsBRUez5zYhxKOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA9Dw65H; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b775b04b63so976979f8f.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470425; x=1754075225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XX+jN+4nSsLCbhXG9v9UL60b+q9mVgM7FVpH3JiXq44=;
        b=PA9Dw65HpyUXtcYCWd+Wib+iXopYt3ssNDzdtIS+iwnL5ai8qjtM/17FI5IWN0Ugy9
         i48XvJ/LluetcY7WUxDwcXD16gjnqnarFlZkfBAgPO3K6rSTaO9Hht/PWua2LyiRvp3A
         l6PZUfB5YUou4GZitTWqxKwXy4bmsbEOjyHTs3oDxI09l4MUaY9YqsEnI1c2d5yZoZs+
         8FYBnM1ctjdY65tYFYUiXvYY3lpbkI02cy1VOE6Kc0AtoEMWZvZ+k8sw2jpT9Uk1tz6H
         MBxRQ9EoriJTSNFQ1SKN55rmqp8+bGgnstZ8gdgt30Qe0R8vyPGyLIWj3wWluMakt2e/
         qWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470425; x=1754075225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX+jN+4nSsLCbhXG9v9UL60b+q9mVgM7FVpH3JiXq44=;
        b=P61lZp3rQM7kj5+vt1oN5ZwtrmujMMcyva9UNo8PX0ygZbBqhznM9Hi3zwM/Yvh4Tj
         vrXwiSJ8aHHesvTcLOrH+NyAHLwp2QwINaTBGc45g8Yh7/dq9pc7zOwFZAOP7fK8QNG9
         swmFNwdIOfJyE5ErWn+DEICuHg/Y0eRnpqLaMCftoRZTNUXxh2YeC+LGsl6++CTenYWS
         DjWwL93iqd7jEcmpKwU3tQCGaTEPqvKW9vDjs9T4cdlaaSJG49ttrpz4ZnDgbwWTrIjS
         WJ+2yUGwia99aTmEdirQtIEIaEo26QSm2jpC8Ny7cDUN3Jug49LreF4RvWpqjrhNdzTz
         4kjg==
X-Gm-Message-State: AOJu0YwxqErQ/N6XfIJGA9U5UX1NsrHkFh98u9qgKvRowlLZ2ACQsESi
	ZaHIOzGhLvA+f051xBOPmeVo5j4N4FMlgmoyfJ+UQVA1MJ7wXhQdNrgzQLkpLaJ6
X-Gm-Gg: ASbGnct/jimnSs4KelbrkBukAaiZOCyNrRI1hdHZdoFepqNLuHOLMLud0p6D/dEzcqg
	oh6ptqZa2vVJYOklbybz9wE+bspMOw/wwH/L0BbeDNf4Y5HiWThqITojWHGX+/yg3NXo215EpuE
	YkKI3RkrXsF5szsDPZZMX+x4NL+2tqZhW+Fj1kMj7JDTxLuC1l7zyujByhaPLkKX8vxg6iLkSPI
	E6qsj6A8qdsdYkoW3R+J5FUxo6VuSGKuksuiqwmrqiZJJGAKTVZ8sjUy3iZnqwjXvpFLaQD8ReB
	kfb2nbYtZ59BFDnoprR0iPsGO4O7FcmR5ZPT8WF7ry5DhGxqVrd9CPAq4xyS0czwM8BaO04qncC
	I8kihzoT1lBtbmvFuZ34OK1ShONGdizeTwCUCJIQKfhzoBSAXCsH+cABCB5cBlb3r3wMNYNXrBZ
	izZxYGsxto/XuPTE9Mynn4R834tpJU+QA=
X-Google-Smtp-Source: AGHT+IEAItHEAR14pcC2VfpBaHglJKMho6P3u2YYV2RdAml058yGqD1TMLHj1z5Rd3Am3goaE3Ry7g==
X-Received: by 2002:adf:a292:0:b0:3b7:7680:35d3 with SMTP id ffacd0b85a97d-3b77680375emr1724705f8f.37.1753470424548;
        Fri, 25 Jul 2025 12:07:04 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008dd2b4234fb07c80.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8dd2:b423:4fb0:7c80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec79441sm47111085e9.2.2025.07.25.12.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:07:04 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:07:02 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 1/5] bpf: Improve bounds when s64 crosses sign
 boundary
Message-ID: <3f0403710c323e9c3f469784a9089b18e3ffa3b4.1753468667.git.paul.chaignon@gmail.com>
References: <cover.1753468667.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753468667.git.paul.chaignon@gmail.com>

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
index e2fcea860755..2de429f69ef4 100644
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


