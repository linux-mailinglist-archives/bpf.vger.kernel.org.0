Return-Path: <bpf+bounces-64110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBE0B0E558
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 23:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A6C547BCA
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316BD2857FA;
	Tue, 22 Jul 2025 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W05DaPU3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119186F06B
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219240; cv=none; b=XKRKjDeH071VKtVEKmqZyX3vYgNcB2XxClbcjDn8UJ6DLW0xg4CycuPpa8vL1PNKN2tbFdizrsQ/f/H3XnULsQQ0EeOYPqbj7lFAKcckBP32uMPfPk9rsPwd/DHqO4vvcw8LXdCAKerIigc5jNIfqL/cTsxoPYQNiuI82kx230E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219240; c=relaxed/simple;
	bh=ayMnzEoSRxinxWDgDEpgF6xNGPngSmZWn3+Qqq9TimY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNMw2BJZPiRHnUANUQ2MbZMrtxq3te8tn1jo4sKr4RlmeWs2NDu0adjbximy8h/gzbmexuU3EDYRW22+n0i1j97BUNnPSAp+97lu8VIT4OIBF9TJb07GOz2unUcqouu/6Gie+dOD2iRthRsaK9G/YgDQwOs8E6sFrwhHMiF7SJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W05DaPU3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso5402367f8f.3
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219237; x=1753824037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xU1Y8NWOMBWhO2WtV1DJVv/sQK4pu2kHpcaeIz4hnE=;
        b=W05DaPU3+3aZUgFwRWWZIhi4PIpXMMIYeo+723FnDS1bFgLQPWdhifG/65/ctEyQHA
         kp2RZ5FOns3oCrcxi0uAJ56pnSTuqgPkUJ6LKTGBgEYTx1IjGTJymZxVCCeZ10tyvrHn
         KrYmt10ymQM27Fx18SkbMsRbyBsNZnYrewimnI6KmNc7I1JRLzndyXJtL9lRgNgbHWIv
         bqmFztyn8hCP9Lka/1rImdOopHR+5yG718YFoxIyirD9zSkRTHAsHT4R85zRRZygzsob
         P8TW9KQOtfB0vhYVNm7K+cgqFtzbdATGeYcyokj5lEgLucGxug8NpkdSdhJ0ae2rMLJl
         kdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219237; x=1753824037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xU1Y8NWOMBWhO2WtV1DJVv/sQK4pu2kHpcaeIz4hnE=;
        b=Hl2F3ksskfkFJff8VZjMBK4SaiJW1cHekGTnk9+/HXv+juEkMSOqk3v/HfNLHOrMRn
         UgrHIDikHrPgWIywUalLm4BoFsULJgLEHPvaI262JzMCjCzGFkq+uae2YdgQFS372ywD
         dhUDw8Mvz7W8CUhVkBetbo4O4l52gdzT61Cebm23pk//qYipvYE+hqGtQAHDKKFvFY5F
         9E4JlBmuLwD/9fHMihvgUWVY9je5Vmbrlrebvu0eKzPf8MX/PYXEx7sFjZzX5pHkomtD
         9VjBeK8yoGm2d843cvIwwhA6w//4mO+TPA+/4MXn8cnch+CpqgAOQLdP9kik+uo/ja+V
         n/Sg==
X-Gm-Message-State: AOJu0Yyz33vHBn/v7sMiAzIkNdUwt1wFrRXUh+AlQ0Ei5vZyMuGUREMn
	rR0jmZ8YjJMZZaroAa5u51b/0Smud+Wc2jkTFcm+EU+GQH+d3b+J+E2GAJ6gy/+a
X-Gm-Gg: ASbGncutqJOdLGBjZOqzBf67h7wGN44156X5QE1aDsQFwMscBsM/5G6sJKQUgOa0aAt
	XQ6nCiAsspvyIP54gwIv9H3VUn0C5s/Oz0SFsSJG3LXgt6k/V6AZMTdqNoUCMWMv77iOkQi9AJI
	nyPDkE4Fqc4d4W600cZK/yrDfm43Gn48+A9TaWZWhFSl3Nko29r7/TDOcgAgbVy8bWXpDuT6VbK
	bEa/ZcrTVmFz25OXFjgxdhwhPFxBZ9kErVEeDokFr+pDxukNyQMIycQPGoQelnwetFYfSgtt3No
	wrF2DjsxCoz20e5jCwlO79wnvfLkslV6IA0KHONTibZuqiLWEcm/SEkQK7YBoIznC1xSsLLeoWl
	oKVuNiAwH/3JtOEEQVORroiy7Ezkm43X3VsZVLbU4ixhgyVJesZ/+enpfk9kBhPQvCpcrjabYFg
	YgXDdJKE2Qah7WobGskjsP5Y1hZFzRUkk=
X-Google-Smtp-Source: AGHT+IGeIt4rT335yX7cG0vr/BHqpNU+9eKgJhKH3luSL7i2Ttzs1R8Lsa3FSeRmD3kP1V/gLpbbRw==
X-Received: by 2002:a05:6000:4382:b0:3b7:5985:51f with SMTP id ffacd0b85a97d-3b768f060d3mr539019f8f.44.1753219237044;
        Tue, 22 Jul 2025 14:20:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e007ae7318c9eecf7c3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7ae7:318c:9eec:f7c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45863a13f23sm24166625e9.1.2025.07.22.14.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:20:36 -0700 (PDT)
Date: Tue, 22 Jul 2025 23:20:34 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Update reg_bound range
 refinement logic
Message-ID: <aIAAooxj5uS8BHed@mail.gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
 <4636f494d90da3627e955d62e54a7927c6b2b92e.1752934170.git.paul.chaignon@gmail.com>
 <8dc4b79af360bb6121c6b96a2c351bd060bfca29.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc4b79af360bb6121c6b96a2c351bd060bfca29.camel@gmail.com>

On Mon, Jul 21, 2025 at 02:29:47PM -0700, Eduard Zingerman wrote:
> On Sat, 2025-07-19 at 16:22 +0200, Paul Chaignon wrote:
> > This patch updates the range refinement logic in the reg_bound test to
> > match the new logic from the previous commit. Without this change, tests
> > would fail because we end with more precise ranges than the tests
> > expect.
> > 
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks for the review!

> 
> >  .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > index 39d42271cc46..e261b0e872db 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > @@ -465,6 +465,20 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
> >  		return range_improve(x_t, x, x_swap);
> >  	}
> >  
> > +	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t != y_t) {
> 
> Nit: I'd swap x and y if necessary, to avoid a second branch.

That works, but we'd have to swap them back before we hit range_improve
below. Something like:

    if (x_t != S64)
        swap(x, y);
    if (x.a > x.b) {
        if (x.b < y.a && x.a <= y.b)
            return range(x_t, x.a, y.b);
        if (x.a > y.b && x.b >= y.a)
            return range(x_t, y.a, x.b);
    }
    if (x_t != S64)
        swap(x, y);

I'm not sure it's better.

> 
> > +		if (x_t == S64 && x.a > x.b) {
> > +			if (x.b < y.a && x.a <= y.b)
> > +				return range(x_t, x.a, y.b);
> > +			if (x.a > y.b && x.b >= y.a)
> > +				return range(x_t, y.a, x.b);
> > +		} else if (x_t == U64 && y.a > y.b) {
> > +			if (y.b < x.a && y.a <= x.b)
> > +				return range(x_t, y.a, x.b);
> > +			if (y.a > x.b && y.b >= x.a)
> > +				return range(x_t, x.a, y.b);
> 
> Nit: here returned type us U64, while above it is S64, I don't think
>      it matters but having same type in both branches would be less
>      confusing.

What do you mean? We have to return x's original type as we're refining
the x range by using the y range.

> 
> > +		}
> > +	}
> > +
> >  	/* otherwise, plain range cast and intersection works */
> >  	return range_improve(x_t, x, y_cast);
> >  }
> 

