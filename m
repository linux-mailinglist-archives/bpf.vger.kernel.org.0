Return-Path: <bpf+bounces-70652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24BBC950A
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 15:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F1A1A61E13
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857418DB02;
	Thu,  9 Oct 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhw4caAc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23035972
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016763; cv=none; b=EzEsahV62rbYEyon9U4Nc1K9bwKnD+iezQXqPi0OUhhJFIa2GETZ8Z15rfc93LNHRLuASXWcoStdiIIgwDyjjdQ9k1EmiOEdY3Dufk7FBaErpK4Nf5vVPB6C7XQvNiwtO74HLLyODRct/3d9bWdi6SGSVxXKp5p4P/nn/PBHnAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016763; c=relaxed/simple;
	bh=hU9D5X0mb+W3rGXXcN+qR+DfQaf+oed9t3W6lBdSmW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTfRHCt7FsgnniuFpYsdS3vbUK2h88P8HSCC9TdjOpBlsIuDRG17h7uErY4B1b6GI3s1q+cru3n6NoDYWQhub3/laEEcYLcS+ICEr7yRqINosF4bVzkV1mPvs5V00tTHbKSDcqBaQ14GWsCRBQpstvYmmlS4d1r+8XQlZUeNxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lhw4caAc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so9564685e9.3
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760016760; x=1760621560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c42Kf9dqQNjFWIVnRSfSN8HMZ0VariaH4v0vaZVkstA=;
        b=Lhw4caAcKaQvY/gpFtUseqdUzO/spbevFBXOAHQW7GNyPzN2wgsPQdPGxRw0wQFdWI
         /Qv8XAkuyAosuUqexVsTNkYkJIALprsL/G7PMXgQgPblxjcIBZWqw4i9J4IuOcPcBP4s
         OIs3hBqPHBXnt3C1yJqpvxM3P11GQ3ohFzJCH+pJI9KxyOVp/cjqhiEb3hyxYNDrRXAE
         JxPDQtICuBXQ5iRPe7DEo+BR/DA76P48IW9XNKmSEEPkB581M0HA6/bQQKGcrt6C35IR
         8yI1qSB2F59p+ZDp1twNgZVXXI3Lk9vX3TPtOdcLI9YEgvziV8Wtqjs++6U+gcbYE2iw
         hiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016760; x=1760621560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c42Kf9dqQNjFWIVnRSfSN8HMZ0VariaH4v0vaZVkstA=;
        b=R3QPX//qMK1UBg8Djba2l12wycFbX+tkSGFIL+aZzJ9doV+QuIYn+gn/sIHYkcz9bV
         HybPGCY6c6yKiMZIAG8TijK1RsVoUMmMQxiC1f8a7ILgdXB5o7Q6KW86aACWjE1KNzqh
         rM3RzYGSIg+FFt6mYZSxZfbcWUAxFZRsoR1jvvM+E3sMy9tiMbc8z61zn+TsLpKpQ4az
         Mm8t+63FiqyD9sDHKPhzf/qyACa1E2KiUYM7Rft73mh+wmHVTOGW+YRHwk6GeCxyfBl6
         lQ/MH0bLovvE4Mbsxvg2WFiLhs7/dGFaSolUN+ufyiIjHWg7EbFtkoUrz9Qteu1gOJ/a
         YKYQ==
X-Gm-Message-State: AOJu0YzjXiJanW9jVFmW3/afHtMURuWaw1b1Z1P1yrI4/hkKIQrz7ybr
	FpmCupcGcyB2Saar598rE5hEgjfba6SeGMw9l/jTrmB57OedP+1W4hUp
X-Gm-Gg: ASbGncsaHBTfmwlKspZ6qIOKPPwD5DjafjFVHb4WMNmYMjZAG0hVwjYftgU6mxQG06F
	arYfgik1njnrrwTKQMMuta+NW7u40Qg7qgkJ3i/0PYafD6prjBLw2Qn4/Hg46wsg8arkST+O+qW
	Rv5/JwstnisdcO2W5nhRrEgecRHw8xg7xw2ngJFczkK7oih1j2MWePIWNEoR81is9PUYfXsO6xX
	Ue7ctTSdGVUPMpTNARu/sSoZ+bMeQ9CPCCMCxQ8pylwS32mtNTTC8FkSqybo/wIbkgns1OSo0UO
	yUJuJE3Sts1BfC7LDryiQM6wskUKcGOMNPMr4HqGa/KaxIWIonMP6pFH8zPOKQOBgk/NfhFQnXd
	Qv/AejSD9y0tzs2REEiasC/VjLcj4M4MN/bZ91gfX8E5LrGp4LYIxDtQBLFs4OOIFSKRlpvgiII
	SHVwU9rRUQcEQPSsthouIC7Jwb09fwJ/rIHQ1h4FRkaCsQvsbgCP5jOAah
X-Google-Smtp-Source: AGHT+IHVCsVEpFDobAp7lxur3EvRia7ufMKAtHj2mZEr1jayTgtnnovYjvxZ+5o6lLxv8EhzWt/hpQ==
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-46fa9af8595mr59640855e9.19.1760016760197;
        Thu, 09 Oct 2025 06:32:40 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e960asm34482917f8f.37.2025.10.09.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:32:39 -0700 (PDT)
Date: Thu, 9 Oct 2025 15:32:37 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <aOe5dZ4cYjz6B02o@mail.gmail.com>
References: <cover.1759843268.git.paul.chaignon@gmail.com>
 <8347068dc4ee9030be13e886c05d59d3ef1ce949.1759843268.git.paul.chaignon@gmail.com>
 <a7a12dcc-4fc4-4c1a-aceb-bb4ce2815a36@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a12dcc-4fc4-4c1a-aceb-bb4ce2815a36@linux.dev>

On Tue, Oct 07, 2025 at 10:59:32AM -0700, Martin KaFai Lau wrote:
> On 10/7/25 6:38 AM, Paul Chaignon wrote:
> > This patch adds support for crafting non-linear skbs in BPF test runs
> > for tc programs. The size of the linear area is given by ctx->data_end,
> > with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
> > ctx->data_end are null, a linear skb is used.
> > 
> > This is particularly useful to test support for non-linear skbs in large
> > codebases such as Cilium. We've had multiple bugs in the past few years
> > where we were missing calls to bpf_skb_pull_data(). This support in
> > BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
> > BPF tests.
> > 
> > In addition to the selftests introduced later in the series, this patch
> > was tested by setting enabling non-linear skbs for all tc selftests
> > programs and checking test failures were expected.
> > 

[...]

> >   	skb->sk = sk;
> >   	data = NULL; /* data released via kfree_skb */
> >   	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
> > -	__skb_put(skb, size);
> > +	__skb_put(skb, linear_sz);
> > +
> > +	if (unlikely(kattr->test.data_size_in > linear_sz)) {
> > +		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
> > +		struct skb_shared_info *sinfo = skb_shinfo(skb);
> > +
> > +		size = linear_sz;
> 
> nit. I find the "size" variable confusing to follow. The "size" is
> overloaded with different meanings in this function.
> 
> Define a "u32 copied = linear_sz;" for this purpose (number of bytes copied
> so far) here.

Thanks for the review! I implemented this and all above suggestions.

[...]

> > -	/* bpf program can never convert linear skb to non-linear */
> > -	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> > +	if (skb_is_nonlinear(skb)) {
> > +		/* bpf program can never convert linear skb to non-linear */
> > +		WARN_ON_ONCE(linear_sz == size);
> I don't think I understand this WARN. Do you mean "WARN_ON_ONCE(linear_sz ==
> kattr->test.data_size_in)" instead?

Yes. At that point in the code, size should be equal to
kattr->test.data_size_in, but using kattr->test.data_size_in directly is
clearer.

[...]

> > +	}
> >   	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
> 
> What does it take to have bpf_test_finish support the skb's shinfo instead
> of passing NULL?

Not much actually. I've implemented it in the next iteration.

[...]


