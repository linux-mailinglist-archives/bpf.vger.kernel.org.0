Return-Path: <bpf+bounces-35068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFDC937519
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD35B221DC
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD447710E;
	Fri, 19 Jul 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ga2Gyc2j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41439ACC
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377976; cv=none; b=UgrHpJcjHFSfKSvoxM6cM9XjWMhSuuwe6TrlOKnh3bN/IZM99pxpIdcRStLcoHo3Wwg7zMwVX0I+wNcYNLE6VJpff74SDhNW/q12u+BWboWRZtV33LcEOo3yVRF+AIv/OMhX/AKoPFmaWVFVYrtvx25Vba+2Z4Q2pqcSfaPffAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377976; c=relaxed/simple;
	bh=tqlljZDqPsjuEPOqij/qbHuHkpYguvm1T3LFUipCdwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWWdzFpBpop9og5WQ1faroNklXgelEdyoKK27rk37pwV/K8gDgkOw+5NPVtiuRE21HgW23RqpyNR3QUcRj1xaM0UYd+2aJP5KpqhX8ZJFOuAdNv0zoV6mvtFaTknRaEDBmptfVki0tjqS/t6cmlxwl5Wi8BaQsFJhqG4Db8ulu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ga2Gyc2j; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eedebccfa4so19272061fa.1
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721377972; x=1721982772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2qzdMCMaBunb3VwzFFRhO7nSvcysVHwnXI6R9cE5vg=;
        b=Ga2Gyc2jndkemMkOkKi58Sq3SL5Uz+0xOzs5bX74Sv4TYilRPzbn4xYArZOgSMNAuX
         9hrIyfgPVxXY2RsCEKd6TcRE4at8wENSQ5WpApao2DrfHwZsX59/Dj10qbpomp9Kolsd
         CzIe+kdr/1jbAGy0TMCYPzoFeAX0wVyaE6GMwBq1gBawe0Ltrc9O9+sbjU+wxiCJY+m4
         Js3YtXs3VGYR91HWe4dFbf7vYprfYHsrtvxkNbDuIDbvPhPtTiUBAKikEewtw5yAY7+e
         Jw9T7M9XURQ1AiKs46W7D5litscSvObom9TeZ86bYIWkzP4OdpWwRxP+aq5z5KH6iiI0
         NblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721377972; x=1721982772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2qzdMCMaBunb3VwzFFRhO7nSvcysVHwnXI6R9cE5vg=;
        b=PdzkRpA3yuJrqoV+lGEirrTFeDAP4NpJJhhKDUAo3RT0u7Uo72xntVrmSUB+TvdtYU
         AJ3c9o/GGPeWyFjhFM/obUb9dm/8UOZ0pDk9kmOxyzQKGIxYCEfA1LBIiqthJUuzAQkL
         i31Guen1zLudIFZhnO0WEPfcWs/wN5fr0tHsU2gWTTulyqGs8GGcW2hdz2SKHh6SeY4/
         zC03nDh4WocSzD9EFMbkqoNEaIWTCiNAZCGJnkmetCO1mCuaBFgczVcrTPfsaQFGmXRq
         ZyI1eW9NbPq7oOtudfmYo/wOn8kc9CCcrYa7kf1yHQSLkXLzArnK7AxmgdgCAsJsJ+oq
         Htjg==
X-Forwarded-Encrypted: i=1; AJvYcCWXTGCx8/eM5hDg82x4W2YPA/IshMHXAIOB8NN+2QFhDliA6XCwvTUIkIQ4cL9dl6poyHLB8b4gYxa8RvQEnerXD8Am
X-Gm-Message-State: AOJu0YxS9fq/QQPKmoM0cOPWlSJLaB5E5WLogijKv261pLXfFYL0KDee
	QbeesKzF82tDLDZaNDVYBpzL1SNMQ9aPQ692gdN48We0svvS+g/okAj3StN6A1I=
X-Google-Smtp-Source: AGHT+IFQQpn7WlmwJwA7hccacgPSMAB3ncmRoqlZoZ6xH4MvZWxO3tnWysZL/tUIg5QhD56G77YWaA==
X-Received: by 2002:a2e:9a87:0:b0:2ee:7a71:6e2d with SMTP id 38308e7fff4ca-2ef05c9e03amr34012691fa.28.1721377972079;
        Fri, 19 Jul 2024 01:32:52 -0700 (PDT)
Received: from u94a ([2401:e180:8852:770b:e576:e894:caae:7245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77353847sm2138101a91.33.2024.07.19.01.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:32:51 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:32:44 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Matan Shachnai <m.shachnai@rutgers.edu>
Subject: Re: [RFC bpf-next] bpf, verifier: improve signed ranges inference
 for BPF_AND
Message-ID: <7iajfyinzgxoxzfnwt4auwaaqqwtsf3n3yjbuvtd3opomvnwxp@tshunnh3w6lk>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
 <20240711113828.3818398-4-xukuohai@huaweicloud.com>
 <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
 <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com>
 <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>
 <be239a5581e5b7d5c6f310c2a4c11282aa5896b5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be239a5581e5b7d5c6f310c2a4c11282aa5896b5.camel@gmail.com>

On Wed, Jul 17, 2024 at 02:10:35PM GMT, Eduard Zingerman wrote:
> On Tue, 2024-07-16 at 22:52 +0800, Shung-Hsi Yu wrote:
> 
> [...]
> 
> > To allow verification of such instruction pattern, update
> > scalar*_min_max_and() to infer signed ranges directly from signed ranges
> > of the operands. With BPF_AND, the resulting value always gains more
> > unset '0' bit, thus it only move towards 0x0000000000000000. The
> > difficulty lies with how to deal with signs. While non-negative
> > (positive and zero) value simply grows smaller, a negative number can
> > grows smaller, but may also underflow and become a larger value.
> > 
> > To better address this situation we split the signed ranges into
> > negative range and non-negative range cases, ignoring the mixed sign
> > cases for now; and only consider how to calculate smax_value.
> > 
> > Since negative range & negative range preserve the sign bit, so we know
> > the result is still a negative value, thus it only move towards S64_MIN,
> > but never underflow, thus a save bet is to use a value in ranges that is
> > closet to 0, thus "max(dst_reg->smax_value, src->smax_value)". For
> > negative range & positive range the sign bit is always cleared, thus we
> > know the resulting is a non-negative, and only moves towards 0, so a
> > safe bet is to use smax_value of the non-negative range. Last but not
> > least, non-negative range & non-negative range is still a non-negative
> > value, and only moves towards 0; however same as the unsigned range
> > case, the maximum is actually capped by the lesser of the two, and thus
> > min(dst_reg->smax_value, src_reg->smax_value);
> > 
> > Listing out the above reasoning as a table (dst_reg abbreviated as dst,
> > src_reg abbreviated as src, smax_value abbrivated as smax) we get:
> > 
> >                         |                         src_reg
> >        smax = ?         +---------------------------+---------------------------
> >                         |        negative           |       non-negative
> > ---------+--------------+---------------------------+---------------------------
> >          | negative     | max(dst->smax, src->smax) |         src->smax
> > dst_reg  +--------------+---------------------------+---------------------------
> >          | non-negative |         dst->smax         | min(dst->smax, src->smax)
> > 
> > However this is quite complicated, luckily it can be simplified given
> > the following observations
> > 
> >     max(dst_reg->smax_value, src_reg->smax_value) >= src_reg->smax_value
> >     max(dst_reg->smax_value, src_reg->smax_value) >= dst_reg->smax_value
> >     max(dst_reg->smax_value, src_reg->smax_value) >= min(dst_reg->smax_value, src_reg->smax_value)
> > 
> > So we could substitute the cells in the table above all with max(...),
> > and arrive at:
> > 
> >                         |                         src_reg
> >       smax' = ?         +---------------------------+---------------------------
> >                         |        negative           |       non-negative
> > ---------+--------------+---------------------------+---------------------------
> >          | negative     | max(dst->smax, src->smax) | max(dst->smax, src->smax)
> > dst_reg  +--------------+---------------------------+---------------------------
> >          | non-negative | max(dst->smax, src->smax) | max(dst->smax, src->smax)
> > 
> > Meaning that simply using
> > 
> >   max(dst_reg->smax_value, src_reg->smax_value)
> > 
> > to calculate the resulting smax_value would work across all sign combinations.
> > 
> > 
> > For smin_value, we know that both non-negative range & non-negative
> > range and negative range & non-negative range both result in a
> > non-negative value, so an easy guess is to use the minimum non-negative
> > value, thus 0.
> > 
> >                         |                         src_reg
> >        smin = ?         +----------------------------+---------------------------
> >                         |          negative          |       non-negative
> > ---------+--------------+----------------------------+---------------------------
> >          | negative     |             ?              |             0
> > dst_reg  +--------------+----------------------------+---------------------------
> >          | non-negative |             0              |             0
> > 
> > This leave the negative range & negative range case to be considered. We
> > know that negative range & negative range always yield a negative value,
> > so a preliminary guess would be S64_MIN. However, that guess is too
> > imprecise to help with the r0 <<= 62, r0 s>>= 63, r0 &= -13 pattern
> > we're trying to deal with here.
> > 
> > This can be further improve with the observation that for negative range
> > & negative range, the smallest possible value must be one that has
> > longest _common_ most-significant set '1' bits sequence, thus we can use
> > min(dst_reg->smin_value, src->smin_value) as the starting point, as the
> > smaller value will be the one with the shorter most-significant set '1'
> > bits sequence. But that alone is not enough, as we do not know whether
> > rest of the bits would be set, so the safest guess would be one that
> > clear alls bits after the most-significant set '1' bits sequence,
> > something akin to bit_floor(), but for rounding to a negative power-of-2
> > instead.
> > 
> >     negative_bit_floor(0xffff000000000003) == 0xffff000000000000
> >     negative_bit_floor(0xf0ff0000ffff0000) == 0xf000000000000000
> >     negative_bit_floor(0xfffffb0000000000) == 0xfffff80000000000
> > 
> > With negative range & negative range solve, we now have:
> > 
> >                         |                         src_reg
> >        smin = ?         +----------------------------+---------------------------
> >                         |        negative            |       non-negative
> > ---------+--------------+----------------------------+---------------------------
> >          |   negative   |negative_bit_floor(         |             0
> >          |              |  min(dst->smin, src->smin))|
> > dst_reg  +--------------+----------------------------+---------------------------
> >          | non-negative |           0                |             0
> > 
> > This can be further simplied since min(dst->smin, src->smin) < 0 when both
> > dst_reg and src_reg have a negative range. Which means using
> > 
> >     negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value)
> > 
> > to calculate the resulting smin_value would work across all sign combinations.
> > 
> > Together these allows us to infer the signed range of the result of BPF_AND
> > operation using the signed range from its operands.
> 
> Hi Shung-Hsi,
> 
> This seems quite elegant.
> As an additional check, I did a simple brute-force for all possible
> ranges of 6-bit integers and bounds are computed safely.

Thanks for looking into this, as well as the complement.

Did took me quite awhile to try come up with a simple solution that
works just well enough without further complication, felt quite proud :)

> [...]

