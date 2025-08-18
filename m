Return-Path: <bpf+bounces-65916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CB9B2AFAC
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CC53B0714
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18131814C;
	Mon, 18 Aug 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKu+V49W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB539FF3
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539051; cv=none; b=h+YEowWQ5TohMcimJizqrxY2659YhToByLkZmzaXOrVvpBrwiVcQonbG4BleOamQC0F4950kQdK4GSXSI3Bwv09xruBHgsHpoY/PeNPkI/m5HanjQp7bGKtGHvIvYoE2EiMJIC5loPHBNTfbeeDZmt3hU7mOzigI3Y9Lwmw4nVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539051; c=relaxed/simple;
	bh=YcU9uWoerTkl7N/phCpttCSFJwfcJWsJQ+8sb7A3tlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoJkCi8KIsB5RGsX4SnLIXcPyr+fFS0I2fdP98zbgxuta3Bbu+iGgQ8xWmPlMkPnkAenn+nQp/D9e4fbikR2JyhVu35zJXsPsUBy7kTTRw08IKb2J/dsqhFemHAKKTV3II2MtTjKwxHSr1GIaRp54FhZqmG5WjjC1PEY+MUlx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKu+V49W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so25026865e9.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755539048; x=1756143848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/9weczXvIC4ICPvXuJjxayTNR13XtbmapRIU4j82r0=;
        b=eKu+V49W1ewHWS+nlH0mbo9bUNXVLgApMpnA1ncbRlCUUc9uvsWfpR0RrMHeGuT6K7
         /VkcQ+7roY3QzPKJ6ZVlhc3XjIV/V2orvpFs7Ix+nFAPh1kYZ94gyr2kC7YVFHsOgRid
         kHoA2T7JK7Y3eDLwxpiuMvpUuEMxP+0ADBzi8+6rqolFsaMAAh2xi+Y2WKZmAJ+BrGGg
         jqtVAwvPTvIQZQhDkB0WiB2re/aGoS9ra+hsLztfhELPi4xMfxmnEt5K81y5x1J9+ne0
         AhefRoDZWPHdOnM2AxZ13lKe5TpfVJDNEkgeIod2/pHoi4JyyqW0+uF8hn/Adfqhi/k+
         fmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755539048; x=1756143848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/9weczXvIC4ICPvXuJjxayTNR13XtbmapRIU4j82r0=;
        b=DTWRuz7mtVH6Pa7avs0u4LrupV5Hed1Akqby7p2YO7jIQ0dstiQWWg6qrX5rPOHXsm
         j4ePP5x5In01fqvgT6+R/pcz+eVbnLYrtKV5eOgM1VA5neM9zenUU+wFxbBKUcJPhozi
         N1rmDaBxBD17GHsHuD+tvRnopAPtpcKZFhyXZDKaNLP0+5ZSIy6sePxJjOU6Z4qGOLts
         V6ekpXnCiEpxKAWR0K2vNBTuud7hVJLrMIzV5JnmRxMQ8ktPkes7j1ZaYWlXWGZkGnfZ
         uYFs3zg69iPf6xddZqhuvZ7WAmstxv+S9GdK1diIlL6LGG4oyJeLIQMWON0n//jty08t
         dkJQ==
X-Gm-Message-State: AOJu0YzGKQfZiBkZWgajEJ5oAQw9j6FA8H7Vro/VPELAxNYX/djM90Ro
	GjeBPcG9QuXVMSiqVgCQRuOnQ1lSJHSPboR35haxgn/0wvvqRh70CKos
X-Gm-Gg: ASbGncs5BjNITLMx9T/uZ5gAe4RXGRToWU351KIyZ6i37XyraRv45iRGVF/ELZXbjQb
	Po9hhpeR8OomvLIdJoNpowDSy+EeF6CPSdR7Hk4SIVmemtghpG5vR8btz0fk9Q7x0qY2avbXrZP
	s0l1SIt+oSK2irmt007AAvBVI59ucFc+Ri7McjzX3d+IBEBnH16i5Q6swWjKAvP7UMV0oJJiYAC
	TCxCp630Hs1QWH5azMaDReCtu2PtWG5vDgY2awJkxOuaV6xn76lv6b1LlB+n6fb5BT3DhW+O05X
	tcgjhRyHfNFSg8rJCVyDJszWX4i49x7+2BvyAYe6d7jTQlqTuVZd3ZWQD1jOqaPIXlKEoTPdmcI
	qPtXDn20jLcGsjMYUO3dCfXyn8cRs/zxwVE8Wy53MNC080TKmFtKkuB0EZh8ysvkC8KRLfgt/2+
	+8o5pieE7AwJIiFJ9bX5Xxj2hRF+uvtCU=
X-Google-Smtp-Source: AGHT+IFd8Ajc2RBNaDetWFl5D/pPEKai4G9Luv31VdWBrT/9uckoGRA9razGOvgpDEAzCGd/1aNnEw==
X-Received: by 2002:a05:600c:3014:b0:456:15be:d113 with SMTP id 5b1f17b1804b1-45b42e28ce8mr3353115e9.1.1755539048214;
        Mon, 18 Aug 2025 10:44:08 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001b7778068b589144.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1b77:7806:8b58:9144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a85247sm8168705e9.15.2025.08.18.10.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 10:44:07 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:44:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Use tnums for JEQ/JNE is_branch_taken
 logic
Message-ID: <aKNmZZ3L3ws8NUth@mail.gmail.com>
References: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
 <hxshkvnzsyrmnty25ainifbei732oco3ss6y76iez2cdsxa77q@cdnvjuhsp6c2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hxshkvnzsyrmnty25ainifbei732oco3ss6y76iez2cdsxa77q@cdnvjuhsp6c2>

On Thu, Aug 14, 2025 at 08:55:22PM +0800, Shung-Hsi Yu wrote:
> On Wed, Aug 13, 2025 at 05:34:08PM +0200, Paul Chaignon wrote:

Thanks for the review Shung-Hsi!

[...]

> > +bool tnum_agree(struct tnum a, struct tnum b)
> > +{
> > +	u64 mu;
> > +
> > +	mu = ~a.mask & ~b.mask;
> > +	return (a.value & mu) == (b.value & mu);
> > +}
> 
> Nit: I finding the naming a bit unconventional compared to other tnum
> helpers we have, with are either usually named after a BPF instruction
> or set operation. tnum_overlap() would be my choice for the name of such
> new helper.

Agree suggested name is better. Thanks!

> 
> One more comment below.
> 
> >  /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
> >   * a 'known 0' - this will return a 'known 1' for that bit.
> >   */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3a3982fe20d4..fa86833254e3 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15891,6 +15891,8 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
> >  			return 0;
> >  		if (smin1 > smax2 || smax1 < smin2)
> >  			return 0;
> > +		if (!tnum_agree(t1, t2))
> > +			return 0;
> 
> Could we reuse tnum_xor() here instead?
> 
> If xor of two register cannot be 0, then the two can never hold the same
> value. Also we can use the tnum_xor() result in place of tnum_is_const()
> checks.
> 
> case BPF_JEQ:
>     t = tnum_xor(t1, t2);
>     if (!t.mask) /* Equvalent of tnum_is_const(t1) && tnum_is_const(t2) */
>         return t.value == 0;
>     if (umin1 > umax2 || umax1 < umin2)
>         return 0;
>     if (smin1 > smax2 || smax1 < smin2)
>         return 0;
>     if (!t.value) /* Equvalent of !tnum_agree(t1, t2) */
>       return 0;
>     ...
> case BPF_JNE:
>     t = tnum_xor(t1, t2);
>     if (!t.mask) /* Equvalent of tnum_is_const(t1) && tnum_is_const(t2) */
>         return t.value != 0;
>     /* non-overlapping ranges */
>     if (umin1 > umax2 || umax1 < umin2)
>         return 1;
>     if (smin1 > smax2 || smax1 < smin2)
>         return 1;
>     if (!t.value) /* Equvalent of !tnum_agree(t1, t2) */
>         return 1;
> 
> Looks slighly less readable though.

Nice find on the xor-based equivalent version! I lean a bit toward
keeping the slightly more readable version though. The xor version is
probably a bit more efficient, but I'm unsure that matters much for this
piece of code, whereas I think readability matters a lot here. That
said, if others prefer the xor version, I don't mind much :)

