Return-Path: <bpf+bounces-66934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56199B3B1F2
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 06:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A055F1C84262
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFF521CC59;
	Fri, 29 Aug 2025 04:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZL4Xmp1z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D51ADC93
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 04:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440312; cv=none; b=QoLvjl8nlSk4opHw2UHLvO0jgdgb6vNFfA06qdS/t/+8lBcrn4AqA1DboRyRx7HK0SJ2zlIVwNcKhP8rMaVVuA382anhg7GSJFIVEOqNUMzQroEvs/HXYVpeOC09NpRyfm5ICjsnWFqA0fvSh5B2jhCvk0MTanA4m/IrwKcfptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440312; c=relaxed/simple;
	bh=Uk+wvgf9BgduLzP2J8fFsCI5T2cJVEzqoaZNSL38xdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktPODhmcEEmG5FRozckQsDygVJ4/fyvGZZvg116EeX1wyolJ7yyd8jrbjxrCMvL0uB9NG5Gj9maBXXYb8GQ35lEFLLzK01bT/iLMOG9V9JghfRCFn8zZ80qj88EyLRDavVVUV2ecTEkCcZj310bK8bPvFUj6BddJQARxvLHfks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZL4Xmp1z; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c7ba0f6983so1009141f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 21:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756440308; x=1757045108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RN+RpUdVpBL9zPnFxKnD0nRyetpkBjdQmDhIlmBR8q8=;
        b=ZL4Xmp1z2ewbuY7FPWZOi4lzixnWL+pdBEozdxg4hcsIBL18j4p1bEfB5Mleeslo/t
         YLVGRNps8U+ZYKKwNR+jKErFt1Wiso1sKHQKi1Czs4v7bJwNL+nZcdPp1A+2caKefQyy
         EkB4q85PwqNPdb+vxm9OTOziKkQQucWrW7bPEDp2T8X8/4Bg5fZfxJpIQs++8CvvRJAx
         VVOueoncm1cqSonwJVAoGjNs1V8y/bh/J18BKxOXc6jY2/ln+hA+n7tewKtWftlAIrRz
         vjHHbudQ3paeV9HT10jGMVA4LOzfPB2nymVlfynB3oBG6oLoayA+bEh/sSxjM8ji5YGT
         qPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440308; x=1757045108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN+RpUdVpBL9zPnFxKnD0nRyetpkBjdQmDhIlmBR8q8=;
        b=eByL5bx6HD0udqA2I1wR7FyXPqFKkkgGQ0kz8ht7WYk3Yza0C6egk4u4FnV4CoO4pv
         QEERBsO+2/jPH4D5rEXNNvMmRgRYyih+5K3ElC006d6Znyzh2Zl+ctByMfE8N6+yZhPC
         Z4xQhjSi2Oeck5Ewkxpi082nKdcs+zKR7W+cpzG/Z62W3ZMdj6oYEY2ZRG/Xjq0HYkSQ
         DRbevbt+ybMuo6E/RqAkXwYAqpBHn+K3XRknOQ6YlU88DQB/NRp+F6hEA3yO7m3UOAOg
         z2XH48H0qdAUR+o4z/cN3aJBcQ0iwZcMQAcSEbalHlpDXaEdT4BIYjiNZCggSklTbilK
         NTsw==
X-Forwarded-Encrypted: i=1; AJvYcCXK6Oxoii6PFSf1a0X9yOOJnj+gZJ3GAHVtRgivXJIDmZ9SHmsfN8svv8SllNL1OJ1YhmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjjRaV4aTy2rcZtxRSZPpP697Z7gWOnLkCIf9zKh6gdkxK6bN
	/3sKtg1UMU4TzigflmUhGB+etBob3DmGeqBkmw7X267xrCnR2DV9xNlXIzmycM/YuK8=
X-Gm-Gg: ASbGncuwoRoxnFQ++sENiwnWiJySi7ibHoXTOil3VT4A+GDEg40/VZVEFAs9PGGASM5
	0Bv8D9rrjuE8VYWEJUo8T83m4BDegY7Hx78D1Tisk16HEMpY+iwbCtpKrRd8Ch4F3oSo7utGljN
	Le7AEeai5VPd/96CVy9FxODRVgkA8UkazmUZtMapyr35SjGFaHum5hJo99RIesgDdRbdBP+/bhx
	p1/FBO/qK0uLDe1O+6im/dcPx8MBF0KXte3XCLHTsmUiSAC+YsVuLuEwG8ch28tHRw9dVcYMjUw
	ENMRaR01qKMD/1wNci+l54fyUMkCJr/bp4FFyZTaFJP0N6Z5jF5E6uRkBzIgZhimid06isftR45
	EgD7PgGrs0+hWfoFFKQ==
X-Google-Smtp-Source: AGHT+IG0kV2yKug8D7dFQrKgfSCb7NNhITZazp79RwXRia4hMN7CeA5aLWmSgb1G/UITInWEwsEIsQ==
X-Received: by 2002:a05:6000:24c6:b0:3b9:14f2:7edf with SMTP id ffacd0b85a97d-3cbb15c9fd1mr7307989f8f.1.1756440308238;
        Thu, 28 Aug 2025 21:05:08 -0700 (PDT)
Received: from u94a ([2401:e180:8df4:371e:f7b:9003:6912:40c2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d93317f0sm1237274a91.6.2025.08.28.21.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 21:05:07 -0700 (PDT)
Date: Fri, 29 Aug 2025 12:04:58 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, 
	Nandakumar Edamana <nandakumar@nandakumar.co.in>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
Message-ID: <ur7xndqp3zdhd6osal7azz6q2if7djxjajpanqvcjveekzz3oz@tmlh3pxuoeeb>
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
 <87tt24zdy4.fsf@cloudflare.com>
 <7ac103b171a8b5ccfffff08e4cf201152d2134d4.camel@gmail.com>
 <87plcrzn0b.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plcrzn0b.fsf@cloudflare.com>

On Tue, Aug 19, 2025 at 11:20:04AM +0200, Jakub Sitnicki wrote:
> On Mon, Aug 18, 2025 at 03:49 PM -07, Eduard Zingerman wrote:
> > On Mon, 2025-08-18 at 20:23 +0200, Jakub Sitnicki wrote:
> >> On Fri, Aug 15, 2025 at 07:35 PM +0530, Nandakumar Edamana wrote:
[...]
> >> > +struct tnum tnum_union(struct tnum a, struct tnum b)
> >> > +{
> >> > +	u64 v = a.value & b.value;
> >> > +	u64 mu = (a.value ^ b.value) | a.mask | b.mask;
> >> > +
> >> > +	return TNUM(v & ~mu, mu);
> >> > +}
> >> 
> >> Not sure I follow. So if I have two tnums that represent known contants,
> >> say a=(v=0b1010, m=0) and b=(v=0b0101, m=0), then their union is an
> >> unknown u=(v=0b0000, m=0b1111)?
> >
> > Yes, because a and b have no bits in common.
> > As far as I understand, tnum_union() computes a tnum that is a
> > superset of both `a` and `b`. Maybe `union` is not the best name.

Purely bike shedding, now that v6 is merged :)

I find `union` name well fit, because it mimics the union of two sets of
integers. For example, using Python-like syntax and assuming tnumify()
is a magical function that creates the best representation of tnum for
any set of integers.

  tnum(v=0b1010, m=0) = tnumify({ 10 })
  tnum(v=0b0101, m=0) = tnumify({  5 })

Whether you find union of { 5 } and { 10 } first, then come up with the
best representation of tnum

  tnumify(union({ 5 }, { 10 })) = tnumify({ 5, 10 })

Or converting { 5 } and { 10 } to tnum first, then use tnum_union() to
mimic union in the integer world

  tnum_union(tnumify({ 5 }), tnumify({ 10 }))

You will end up with the exact same thing

  tnum(v=0b0000, m=0b1111)

In other words the inability to represent { 5, 10 } is an inherent tnum
constrain, rather than of tnum_union's.

And while saying that the function computes a superset of both `a` and
`b` is correct, it is not as precise, because there could be many
supersets.

E.g. for a=tnum(v=0b0001, b=0) and b=tnum(v=0b0101, b=0) it gives
tnum(v=0b0001, m=0b0100). While that is indeed is a superset of `a`
and `b`, so is something like tnum(v=0b0001, m=0b1110).

> Makes sense if I think about it like that. Thanks.

