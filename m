Return-Path: <bpf+bounces-64005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D44B0D374
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 09:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F97C16B1E8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1434E56A;
	Tue, 22 Jul 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gUhe9jBS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB328BABC
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169532; cv=none; b=uYJR1s85b4+vLg+qIvkce+ZLmvhW5QI5Ix+f9/puPJgIOil6fF+hteermTVwFic8kptr6tt1ZqCX6FIyc2R+/th2oPyey7nZKsipD4QaHPANJwlvlsfgLyBslNfp+VXvDr9S5Dj7JAvKkm7OaSEHr0nPkXwAw2y0hF34RTvh8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169532; c=relaxed/simple;
	bh=U9Qqm/FBYSnHOJ0A/f3rfgvlOTDHGf8ZbNAE3FLHX4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmnFSc9YQDr1BLhKeK4/ms5bsxELj0fjkEd0M/wYbuIGv4+UsEpjyiIeU9EnDXXGLL4jE84NIEvg6IAZ7MGiazFfXN9CEckqHzWWca/ZbcDwy5ybEQ4xi87x/dGbumF10qf+yck68E0ZFiKaV6tmyhah3LgBfOLQFor3SrIsv1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gUhe9jBS; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so4790712f8f.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753169528; x=1753774328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfbmLKKAgP6bdc7+t2M/+KxDFKahLiCPNMvlVbtnqVo=;
        b=gUhe9jBSObk8pJpJHao0sM4giinwjQZgfmxkgj1+A6vBIuaC75k5r+CQNZo+SV/ru/
         8C2fer2fiR2PWbNnx9CzEjOClil1zXRntikEdYuGdrU51PBtOaCFRn8e6/ffsVFdzqsG
         EfUl2UnXrzEWk/Qm0I6FhuuSxJtOQnhFS78YC5bPSWDQ2O46ZeGdcrrFEj8gVv8E9l1z
         Pme7rsVXrmkUjsnwBsWVZQJVsxcVVfQyoGUZhuu3A4kxCfLQHcn8UDBD5PW/IxuIGpcv
         LBEeOxGKyngKu/o9IqaEn2j/DLu/4dZYHgfpA3XW0SjjuICOpeP+6K+R5ZQRhJ/bzZN3
         X9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169528; x=1753774328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfbmLKKAgP6bdc7+t2M/+KxDFKahLiCPNMvlVbtnqVo=;
        b=icRfDCjw5tTcJ64Oro1pqV3yX2+P8T21JylPzDosBWZTSdCXM6RinlTxwaWdQ7i6yh
         3c20fOr1dFTNkoQdYFdkd3/ic/lpmeXXezwDPmufrTHri/nM787QATJQozRuCPn019ks
         L3WhjJ0zdQoG34OuMDj5WNs4whP1WFvtx0R/Eb3qymvhhBC2ZMAf4q4+M/ksvlPKaH42
         HiTb4WkgkjV3SnemUYxnqxMd/tGMuR2QSIaI3I+fXt62H50/h4ICCKCrhozAbRI0Z8Ex
         MzY9g5CLmOi+DUKHI8Oa7UhU7S7nXYf7Dp+eEfsEDycCXaWklPKEetVPvfsMyXFkRvy2
         0bVg==
X-Gm-Message-State: AOJu0YwfM1Y3+0I0T6opzLwywfrrGs4bZ5pnjLYV8FdxOUpdiXluD7Wq
	TRHXXyFR3H8hGxxZ/mwCfypXBsSstrl82fnE56a102A/VsJepPftBeEWtsoql7qMeYU=
X-Gm-Gg: ASbGnctM8+8+hxpn9lBMGe7GmXiH0NBhwM3WPqOMslmHGVhix50jlqvmq2I1XgKWjui
	SWlxYJdzcK0TTeoUuzOGw8hFRSr8v0sQh0sCCAU9kb9RK/6PjC5AZDG825IKgeol9rijLwSp/TE
	8kmTjc7e03xFAml7zdUWclKbHnoHTzo4xrYVV9lhGAqEHyK+IaadVlgs1jCsjYlPVNxRVakhrfW
	2EtY5LO3o7JwGPRoKmvTSxPiOQCsR2W3OHuaz1f2+4fcRnNQH6kuwJkTMIOj5FVc9sE3Pp7dGIc
	D1LCX4MwNAsnvycmqwshm4p3btAN6WETmFaYw/FQdugS1KHML7dU2hOuoQexoTXr9x5kDUSFCd/
	mQ3yn5txIbEPwp2N2UQ==
X-Google-Smtp-Source: AGHT+IGVYjnw3jJNo7Tbo3qkyW/k0I+D5N6xBvqTQe+JelxlIRs3FbwhtdKJjtRxt7RgFgPhSyB9Cg==
X-Received: by 2002:a05:6000:4311:b0:3a5:8d0b:600c with SMTP id ffacd0b85a97d-3b60dd4aaf1mr19422728f8f.3.1753169528287;
        Tue, 22 Jul 2025 00:32:08 -0700 (PDT)
Received: from u94a ([2401:e180:8d51:2aa3:f294:b544:a1b8:fa2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d69csm7054980b3a.102.2025.07.22.00.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:32:07 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:32:03 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/4] bpf: Improve bounds when s64 crosses sign
 boundary
Message-ID: <nlfoz2zdvtrkqlxgkuvltredidcisbkkojxrqdlcnazz2s2yrp@an6hfajlukx5>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
 <d5be66c893ee61f7ceb9ac576fd92a3ecf7d0fa1.1752934170.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5be66c893ee61f7ceb9ac576fd92a3ecf7d0fa1.1752934170.git.paul.chaignon@gmail.com>

On Sat, Jul 19, 2025 at 04:22:05PM +0200, Paul Chaignon wrote:
> __reg64_deduce_bounds currently improves the s64 range using the u64
> range and vice versa, but only if it doesn't cross the sign boundary.
> 
> This patch improves __reg64_deduce_bounds to cover the case where the
> s64 range crosses the sign boundary but overlaps with the u64 range on
> only one end. In that case, we can improve both ranges. Consider the
> following example, with the s64 range crossing the sign boundary:
> 
>     0                                                   U64_MAX
>     |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
>     |----------------------------|----------------------------|
>     |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
>     0                     S64_MAX S64_MIN                    -1
> 
> The u64 range overlaps only with positive portion of the s64 range. We
> can thus derive the following new s64 and u64 ranges.
> 
>     0                                                   U64_MAX
>     |  [xxxxxx u64 range xxxxx]                               |
>     |----------------------------|----------------------------|
>     |  [xxxxxx s64 range xxxxx]                               |
>     0                     S64_MAX S64_MIN                    -1
> 
> The same logic can probably apply to the s32/u32 ranges, but this patch
> doesn't implement that change.
> 
> In addition to the selftests, this change was also tested with Agni,
> the formal verification tool for the range analysis [1].
> 
> Link: https://github.com/bpfverif/agni [1]
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  kernel/bpf/verifier.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e2fcea860755..152b97a71f85 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2523,6 +2523,50 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
>  	if ((u64)reg->smin_value <= (u64)reg->smax_value) {
>  		reg->umin_value = max_t(u64, reg->smin_value, reg->umin_value);
>  		reg->umax_value = min_t(u64, reg->smax_value, reg->umax_value);
> +	} else {
> +		/* If the s64 range crosses the sign boundary, then it's split
> +		 * between the beginning and end of the U64 domain. In that
> +		 * case, we can derive new bounds if the u64 range overlaps
> +		 * with only one end of the s64 range.
> +		 *
> +		 * In the following example, the u64 range overlaps only with
> +		 * positive portion of the s64 range.
> +		 *
> +		 * 0                                                   U64_MAX
> +		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
> +		 * |----------------------------|----------------------------|
> +		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
> +		 * 0                     S64_MAX S64_MIN                    -1
> +		 *
> +		 * We can thus derive the following new s64 and u64 ranges.
> +		 *
> +		 * 0                                                   U64_MAX
> +		 * |  [xxxxxx u64 range xxxxx]                               |
> +		 * |----------------------------|----------------------------|
> +		 * |  [xxxxxx s64 range xxxxx]                               |
> +		 * 0                     S64_MAX S64_MIN                    -1
> +		 *
> +		 * If they overlap in two places, we can't derive anything
> +		 * because reg_state can't represent two ranges per numeric
> +		 * domain.
> +		 *
> +		 * 0                                                   U64_MAX
> +		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
> +		 * |----------------------------|----------------------------|
> +		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
> +		 * 0                     S64_MAX S64_MIN                    -1
> +		 *
> +		 * The first condition below corresponds to the diagram above.
> +		 * The second condition considers the case where the u64 range
> +		 * overlaps with the negative porition of the s64 range.
> +		 */
> +		if (reg->umax_value < (u64)reg->smin_value) {
> +			reg->smin_value = (s64)reg->umin_value;
> +			reg->umax_value = min_t(u64, reg->umax_value, reg->smax_value);

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Just one question/comment: could the u64 and s64 ranges be disjoint? Say

   0                                                   U64_MAX
   |                             [xxx u64 range xxx]         |
   |----------------------------|----------------------------|
   |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
   0                     S64_MAX S64_MIN                    -1

If such case this code still works as the s64 range gets a bit wider at
the smin end (thus still safe), and u64 range stays unchanged.

That said if the u64 and s64 range always overlaps somewhere, it may be
an invariant we want to check in reg_bounds_sanity_check(). I seems to
have some vague memory that with conditionals jumps it may be possible
to produce such disjoint signed & unsigned ranges, but I'm not sure if
that is still true.

> +		} else if ((u64)reg->smax_value < reg->umin_value) {
> +			reg->smax_value = (s64)reg->umax_value;
> +			reg->umin_value = max_t(u64, reg->umin_value, reg->smin_value);
> +		}
>  	}
>  }
>  
> -- 
> 2.43.0
> 

