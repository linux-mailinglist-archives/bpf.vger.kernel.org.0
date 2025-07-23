Return-Path: <bpf+bounces-64151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCF4B0EC53
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 09:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12CB56281B
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F5277C8A;
	Wed, 23 Jul 2025 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ro1XGU8d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2BE21B9C9
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256980; cv=none; b=FpZzs0iadn2ab/c9Rmc1MoghEK+gVM5UN5us0/tFFX0sIVvRmvupIUGAG1878+tx1HVgAhQLpiuvZci9GwZM8fH+XFEwjQ5OHgNQ3sefCN34ZfwB0rQrr3Gtad9vb099DEEQMtZ4/WKNfy9LVWP6vFqrfvaTWZ2WJmzCG7gPrT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256980; c=relaxed/simple;
	bh=rWXvTxAAj0Q/j54n3E/HhIZMoCjBxB8SNGipjeTofTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huTmlNfBzAUyh4EiTJiTmxOsAeLGoMn8EiTubrq48KC9lxuPNdA20WsPhPsi1EWVr6aE+/tU3DWPJsYDTczkPFLKATgC4j4bcnOnPeZEkL6ogHxACnv+X9rWCfb9AtuOsxDyY7FzngRAQlUrNC54UuOd0jO8SbrMZjP8RNIwX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ro1XGU8d; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso5948625f8f.1
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 00:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753256977; x=1753861777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBg2eK+LCZM08z5BSCoQ6ngGEgepLgpBsn+hhDdNAow=;
        b=Ro1XGU8dAjl6/mAou7slsvDbDc9tA9dzHK7yz/AYcLWXJqkefy/ebGhLoDNhdEK/JE
         LybErpRQuXuuk3d2zxBRS8SuhjtOgxNbyKdvMCxGSaQY2HeOcImZy6ylRzN2EdoF1oD/
         1KLWQ8WdmpurmT7woqnRXO86/a5arLJPukEoI1gYpbVgw6MQeO9W47ClrLNfhSOLS4gf
         ip2JyU11qEMeW5m8p476nfEYNNDKjHV89E+aSb8o0ahFU+D4VS5KXqvxmgCg8bDR5OvD
         nD4A1D3YFYIEP6zcjY0bkALLW4uvqQLtpgbLBhX4U4+AO49fWkPKozIFJQUr1ySwP9nH
         hIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753256977; x=1753861777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBg2eK+LCZM08z5BSCoQ6ngGEgepLgpBsn+hhDdNAow=;
        b=l/aB8zsjlBOJdnsPT4PYV9FJ0mVU0tX0bKQhvmnvr1lM0dDWOSpJ+RlmY5hoyg1JZt
         p6dKt9GA73Ew0PZ+9EejIcMSwbPdrZg30Zss5c9ny8AfxKkOLbIKf2WeFOkQ4nh4lbHR
         BaGW7/caIAI6TCi4r4wboubhqj71CcE/kxMW7koY4b42O1Zni1rdrqypJF/83tl54dUE
         W3lva55XgjdQ4d4GAdayynC3Xk86zJ+LRm3PDoxFZOyJcgOuBk4kzdno5dti7KpJKcR8
         QcCC1VI3xWjBH+I9OlVzPL5LnWhKYWowL131zOjZGlpsqT8h2OsHExDIvx3OYZME1mb2
         c3ng==
X-Gm-Message-State: AOJu0YwbZ8gJktxeYRL3Zp6WuJ4nWKpVCCBB0cK6zCgOrgBLzYqyf1Jb
	iuR3XHAP4mtSvvd+x6LIVQqGBSAkcBiC/GXm19kX3w11PQZN2TEc7WozrsLDpv6/3wE=
X-Gm-Gg: ASbGncv8i/v4B0eG1nm9qje+MOeKA1ctDycpthMMbIcrJHvO7SWtTiZd7oGxj6VMrzW
	BiMcy9K+XXfo3WZ5NPMPrSeWEA7vnOwDu84nPQ17Z2x5TeTJStgY43iN59UgbDGPdwhYCkNAkeQ
	KvqZY17Ex9evCT6IyXKivgmwGi5yK13B5dfp20OVDNTRnq81Kl5xQurhlrJ4Ouzq8PXprZAArh1
	0hjAnQdCLCTfDS9cs1TNfNI8fyPufZebJOvIh79UQUbSXCyYT77Z4iBv54111KvWf/GBQwFVIov
	ePqZK6+wlcBk1YZPRI1T3n6HQPIePmAQMtiKEAhnfgF7hTRlg6Co/VzF5m3wQH0mZq0LOWp6Z+x
	xmRRY7Hy432QugKoDaw==
X-Google-Smtp-Source: AGHT+IHu6MxDzuz5eVMTnO0s4ZXC+Gj/IilYdVW34mUX0DpyWkVsHHy6FQA2VtdU7rSDjXViW/HyIg==
X-Received: by 2002:a05:6000:188b:b0:3a5:8934:4940 with SMTP id ffacd0b85a97d-3b768f2d2e0mr1641700f8f.50.1753256976977;
        Wed, 23 Jul 2025 00:49:36 -0700 (PDT)
Received: from u94a ([2401:e180:8d50:406f:55c6:314e:d27d:eda5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519f4f0fsm1000543a91.10.2025.07.23.00.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 00:49:36 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:49:28 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/4] bpf: Improve bounds when s64 crosses sign
 boundary
Message-ID: <gb6pjrnhdtj7fewfjqjiwc4x7n6mm2ndtfd7og5wwuznea2f5m@ndugzujnhr2w>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
 <d5be66c893ee61f7ceb9ac576fd92a3ecf7d0fa1.1752934170.git.paul.chaignon@gmail.com>
 <nlfoz2zdvtrkqlxgkuvltredidcisbkkojxrqdlcnazz2s2yrp@an6hfajlukx5>
 <aIAMMHJaFG9bWxJC@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIAMMHJaFG9bWxJC@mail.gmail.com>

On Wed, Jul 23, 2025 at 12:09:52AM +0200, Paul Chaignon wrote:
> On Tue, Jul 22, 2025 at 03:32:03PM +0800, Shung-Hsi Yu wrote:
> > On Sat, Jul 19, 2025 at 04:22:05PM +0200, Paul Chaignon wrote:
> [...]
> > > +		/* If the s64 range crosses the sign boundary, then it's split
> > > +		 * between the beginning and end of the U64 domain. In that
> > > +		 * case, we can derive new bounds if the u64 range overlaps
> > > +		 * with only one end of the s64 range.
> > > +		 *
> > > +		 * In the following example, the u64 range overlaps only with
> > > +		 * positive portion of the s64 range.
> > > +		 *
> > > +		 * 0                                                   U64_MAX
> > > +		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
> > > +		 * |----------------------------|----------------------------|
> > > +		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
> > > +		 * 0                     S64_MAX S64_MIN                    -1
> > > +		 *
> > > +		 * We can thus derive the following new s64 and u64 ranges.
> > > +		 *
> > > +		 * 0                                                   U64_MAX
> > > +		 * |  [xxxxxx u64 range xxxxx]                               |
> > > +		 * |----------------------------|----------------------------|
> > > +		 * |  [xxxxxx s64 range xxxxx]                               |
> > > +		 * 0                     S64_MAX S64_MIN                    -1
> > > +		 *
> > > +		 * If they overlap in two places, we can't derive anything
> > > +		 * because reg_state can't represent two ranges per numeric
> > > +		 * domain.
> > > +		 *
> > > +		 * 0                                                   U64_MAX
> > > +		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
> > > +		 * |----------------------------|----------------------------|
> > > +		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
> > > +		 * 0                     S64_MAX S64_MIN                    -1
> > > +		 *
> > > +		 * The first condition below corresponds to the diagram above.
> > > +		 * The second condition considers the case where the u64 range
> > > +		 * overlaps with the negative porition of the s64 range.
> > > +		 */
> > > +		if (reg->umax_value < (u64)reg->smin_value) {
> > > +			reg->smin_value = (s64)reg->umin_value;
> > > +			reg->umax_value = min_t(u64, reg->umax_value, reg->smax_value);
> > 
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > 
> > Just one question/comment: could the u64 and s64 ranges be disjoint? Say
> > 
> >    0                                                   U64_MAX
> >    |                             [xxx u64 range xxx]         |
> >    |----------------------------|----------------------------|
> >    |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
> >    0                     S64_MAX S64_MIN                    -1
> > 
> > If such case this code still works as the s64 range gets a bit wider at
> > the smin end (thus still safe), and u64 range stays unchanged.
> > 
> > That said if the u64 and s64 range always overlaps somewhere, it may be
> > an invariant we want to check in reg_bounds_sanity_check(). I seems to
> > have some vague memory that with conditionals jumps it may be possible
> > to produce such disjoint signed & unsigned ranges, but I'm not sure if
> > that is still true.

> My assumption is that the u64 and s64 ranges can't be disjoint or that
> would mean the register can't have any value. As you noted, even if that
> were to happen, we would only lose some precision, i.e. the refinement
> stays sound.
> 
> I considered returning an error from __reg64_deduce_bounds if that
> invariant doesn't hold, but propagating it gets a bit messy. Adding it
> to reg_bounds_sanity_check would likely be cleaner. Though to be
> honest, I was hoping to see the impact of the present changes on the
> syzbot reports before adding even more opportunities for invariant
> violation reports :)

Make sense, that is the better plan :)

...

