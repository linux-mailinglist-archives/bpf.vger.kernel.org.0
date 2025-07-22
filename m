Return-Path: <bpf+bounces-64114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF8B0E618
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A85BAA3D27
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBDE2868AC;
	Tue, 22 Jul 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu0Eedk2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4F2E371F
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222198; cv=none; b=c1WyATrwebcBn38nDP9VRO708kPL4ediH+Ajt1m0Iy3VbGThDR2YiVUNHpkQZbUabqlZ0I6S7yuundQ+qMhCa6JRSghrBDQ9O5Bz4Kg/f0316EwrI7TSJ87EAjroT1pwjtm0UjSW2u3tBsewyX5N48Gb5Uq1XjmOf4+WB93NXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222198; c=relaxed/simple;
	bh=cvIo0ux83P6I5yY/0Ox3M2HtmQCjGMz/el1ErzyHrG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/g7FFmjFreQ5KeENmLjq19ZAUKb3fTTRGhDRaSGv1etTPJ9Nxl9U2UiclieLOSgmCfv/1A51WsgEb20vjU0lwJhHyoRByn0PblRqf/yZ1pbvTo83/g1OqHLu2xn70bbWZP2k9p+3PH2izqCuHehnALEdn7XsFc1QQsBAAm+g7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu0Eedk2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4561607166aso46771225e9.2
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 15:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753222195; x=1753826995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iuhFyCqNq+MKVZE0LwrSYQH7/Da08OTRqGbO8kw6LwU=;
        b=Qu0Eedk2ZFxtjFnaBbgfG+hPBIibwIs3uD647VlGD6DpFAwXS4909J6NrR/dEldX0Z
         GYhDF6B68sr/+ZePtywSuUaHL7TjP682Fb8uSh2Q+NXAiV//uSyek4TZN2QM98J8zYR6
         +N/fVivAGDqtzdqrkzKt2fvB+WtPDMTo4AmnvX/sOhBdsu9w9/D6HN9oyMLJezTvNw0m
         +lg8+bDnzKG3e2Don4WToEELAI4H39B81JEw5Efd6UlsUZ6ACgzmZMoYzXePBzvwl/2O
         8lg5csKM+WWrknoDV926pXbcWmsNT74nXYFU97iTSMYC1hEWXGjKvHIirLFBBte5COQf
         5kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222195; x=1753826995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuhFyCqNq+MKVZE0LwrSYQH7/Da08OTRqGbO8kw6LwU=;
        b=fA1A8Ww/PiZayoXrL8RS1DEuCE05ONc5aTDX02+PDswW0QSyS83QbrZx5/Ik7ROh7h
         Uzw7xYZfsbZXyfPOBATL/mW/TykPID9bcOupyK7/SmrGAn22dSYXWKXnetdJoGQBn7JM
         2m7YgYYVKhYEiRThJFKX8US2jS9GJ3aYLVFBE7roxokNjRO9u8hT5jgc6R2uymvpoGrh
         TlcYmSymJm8x8hVCzCDvqR/6qz8l+ILC8LrbvJKZjclAdIb8yz8TbUPgy2w6OFscbFs0
         uP7eZMuDTQ6NSPvAonTjaeToNTLi9V9S4mhERgyUR8BDj5kcFqh4D5QUoKJsCP4R0zFa
         T6ug==
X-Gm-Message-State: AOJu0Yxf6W2JnUqqvVSvyuoSWdgzjLsoOsbvorRhWl8MjCgnDDu3AEi5
	4HqRbnPBzwD8zQTzY/jbdGm8xNi1Dj6HvJXqPjs0jzSUWeIG/+VlHZsw
X-Gm-Gg: ASbGnctrUoxblfgJBt4hOx/68wG3ZdCJHvs2WwzRJGeEFw2grSrVBN9vNuZadZgI4oj
	qIFL/AqvjK/2/fdDHGb1EN4Ii3yg9F8iZWe+DNCcfq2RiRykgB27ziQ/JFeAAZkUrx++HepkLig
	7Lc6IprDVc0JFI0TFkcXGUvZt0/H8yjo3U637wF7hJys4B7G1SExkDpxOEeXdhLusm3MHbMUfTe
	eHS+JNzWHLB8hA0vsQZubVJ7MqJSGvqL8sU9monn7UlS/FIWkNh///5rKBm088XJv7/j1gi3Ozb
	b6fTb5atEiW0RMj2+Y3fzRN51FOYDi5XH4Fs7ia/X/ORhe6LtBlzxlumLCXJOKEg1gBrODSbk6G
	+dYDh9hWBfHnx08udUeuyAuyCFtfqRgn8nH78uhOpFSXO2GV09279HrL5nl95jEY2okG/8pd6s4
	/QRtczuLYRibICi5xkZA3P/WzSVVRKt5w=
X-Google-Smtp-Source: AGHT+IEAZJKcwofYa0V+dkC1KGTx8d4Tq/ABFgOTl130aCqjk7fjNecG5XUyEP+nLK2Xi6wp6sveFw==
X-Received: by 2002:a05:600c:83cd:b0:456:1904:27f3 with SMTP id 5b1f17b1804b1-45868d4f236mr3292115e9.18.1753222194849;
        Tue, 22 Jul 2025 15:09:54 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e007ae7318c9eecf7c3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7ae7:318c:9eec:f7c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691993d3sm2741755e9.10.2025.07.22.15.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:09:54 -0700 (PDT)
Date: Wed, 23 Jul 2025 00:09:52 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/4] bpf: Improve bounds when s64 crosses sign
 boundary
Message-ID: <aIAMMHJaFG9bWxJC@mail.gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
 <d5be66c893ee61f7ceb9ac576fd92a3ecf7d0fa1.1752934170.git.paul.chaignon@gmail.com>
 <nlfoz2zdvtrkqlxgkuvltredidcisbkkojxrqdlcnazz2s2yrp@an6hfajlukx5>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nlfoz2zdvtrkqlxgkuvltredidcisbkkojxrqdlcnazz2s2yrp@an6hfajlukx5>

On Tue, Jul 22, 2025 at 03:32:03PM +0800, Shung-Hsi Yu wrote:
> On Sat, Jul 19, 2025 at 04:22:05PM +0200, Paul Chaignon wrote:

[...]

> > +		/* If the s64 range crosses the sign boundary, then it's split
> > +		 * between the beginning and end of the U64 domain. In that
> > +		 * case, we can derive new bounds if the u64 range overlaps
> > +		 * with only one end of the s64 range.
> > +		 *
> > +		 * In the following example, the u64 range overlaps only with
> > +		 * positive portion of the s64 range.
> > +		 *
> > +		 * 0                                                   U64_MAX
> > +		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
> > +		 * |----------------------------|----------------------------|
> > +		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
> > +		 * 0                     S64_MAX S64_MIN                    -1
> > +		 *
> > +		 * We can thus derive the following new s64 and u64 ranges.
> > +		 *
> > +		 * 0                                                   U64_MAX
> > +		 * |  [xxxxxx u64 range xxxxx]                               |
> > +		 * |----------------------------|----------------------------|
> > +		 * |  [xxxxxx s64 range xxxxx]                               |
> > +		 * 0                     S64_MAX S64_MIN                    -1
> > +		 *
> > +		 * If they overlap in two places, we can't derive anything
> > +		 * because reg_state can't represent two ranges per numeric
> > +		 * domain.
> > +		 *
> > +		 * 0                                                   U64_MAX
> > +		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
> > +		 * |----------------------------|----------------------------|
> > +		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
> > +		 * 0                     S64_MAX S64_MIN                    -1
> > +		 *
> > +		 * The first condition below corresponds to the diagram above.
> > +		 * The second condition considers the case where the u64 range
> > +		 * overlaps with the negative porition of the s64 range.
> > +		 */
> > +		if (reg->umax_value < (u64)reg->smin_value) {
> > +			reg->smin_value = (s64)reg->umin_value;
> > +			reg->umax_value = min_t(u64, reg->umax_value, reg->smax_value);
> 
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> Just one question/comment: could the u64 and s64 ranges be disjoint? Say
> 
>    0                                                   U64_MAX
>    |                             [xxx u64 range xxx]         |
>    |----------------------------|----------------------------|
>    |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
>    0                     S64_MAX S64_MIN                    -1
> 
> If such case this code still works as the s64 range gets a bit wider at
> the smin end (thus still safe), and u64 range stays unchanged.
> 
> That said if the u64 and s64 range always overlaps somewhere, it may be
> an invariant we want to check in reg_bounds_sanity_check(). I seems to
> have some vague memory that with conditionals jumps it may be possible
> to produce such disjoint signed & unsigned ranges, but I'm not sure if
> that is still true.

My assumption is that the u64 and s64 ranges can't be disjoint or that
would mean the register can't have any value. As you noted, even if that
were to happen, we would only lose some precision, i.e. the refinement
stays sound.

I considered returning an error from __reg64_deduce_bounds if that
invariant doesn't hold, but propagating it gets a bit messy. Adding it
to reg_bounds_sanity_check would likely be cleaner. Though to be
honest, I was hoping to see the impact of the present changes on the
syzbot reports before adding even more opportunities for invariant
violation reports :)

> 
> > +		} else if ((u64)reg->smax_value < reg->umin_value) {
> > +			reg->smax_value = (s64)reg->umax_value;
> > +			reg->umin_value = max_t(u64, reg->umin_value, reg->smin_value);
> > +		}
> >  	}
> >  }
> >  
> > -- 
> > 2.43.0
> > 

