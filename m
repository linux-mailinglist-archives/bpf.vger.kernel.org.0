Return-Path: <bpf+bounces-77966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE1CF8FF5
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 16:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92FAE300A9B3
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6415ADB4;
	Tue,  6 Jan 2026 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1uIwl43"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2956922A1D5
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712445; cv=none; b=eYBOCr1A2NLvrUbgcR3dx7q502w0QYmddF7O21dehZys7pIkc0TN7zpkKwmVLNxYKB/wvF9WJIc44gPycjtpZm55J9wCH2BT55C5jn5Y4HK27FuyldzBf2eKFMipDc9VmUP+atQdzLQHIRKTntS4DeFaweZ3gw9TW70D/GR9JOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712445; c=relaxed/simple;
	bh=uCh39lELCZD3ykKYeblQxs0BjY8Mv990pLsUcyMALY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=disQlAzi38HJC72JuArCnzj+hYyFV16NSmyeLdUz2uXahwTEPTiLx5tcgpsbyXCVzIty1SNnEdSrgBPJvXAHB7+2+L7ArDu5SRwa2T8wkAmJoHONLOnrKkfiK8/sEzZTpaVrDnNmxkuU8o9haHUQx2PKVgbFj94sHI60lZX7c+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1uIwl43; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so630492f8f.3
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 07:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767712441; x=1768317241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCh39lELCZD3ykKYeblQxs0BjY8Mv990pLsUcyMALY0=;
        b=L1uIwl43QGuBNEaljjgfgjRYfPf/ieYyE6MeKCX0SMI6WJ7brQkgEZQVh9pxb4smYG
         ftmmVp/Z7tZDZwA2yfzNcYxHz/LnKsQTImytxobwfhd/TX/CVMtRFbk+agFNc5hOK2lD
         3qWUFFoN9z6ZP4nwR+gQKxUe1msCJwMg+NkHdaddtW5W+IJO8+mITMB36CFCF+ZQCshY
         kHY8uvDlqQJA67tPchPFZB/PS4GX2dgX7VfZOWllz2jDVkao5DLRUqqPhF1T1gNt2pb+
         t9Sy7KDxPejXKwguxZ341WKZzBKQbnKG+3oD9JtrFtsqddVY71Xs0N7TBaaxntd7PwBa
         eSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712441; x=1768317241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCh39lELCZD3ykKYeblQxs0BjY8Mv990pLsUcyMALY0=;
        b=DLI2bOVvmtsyMxqimYtpIQzpukwyAxEDXPUKTAXzA2xlmIVW2rVsdJXcoF9AajfMvE
         k45ZCrlamHaazG9FKfdMuQgC/EBuAtxMgsJ8aqHtSijGEWLFGgXCBuqzOPntRTJHR/Pl
         yepacqNhTsZct1D+40jd8d7fzdWghFENBnviTtryxaf7/PbTSxCwpzzviy0cd/Ny0NQZ
         3gS98wfqPsfY+mvaHOTtEtsZlTRLLOXfVfvrvPmpgE/mOa4qwvUI2PAvt2xhwvGp1TCR
         Yfv/kQPljBQLYxqv5nr43EW1y0oSJVCWBhJTO9Yt54X3Mh4hWl2NhbSblr8B3D1j6m2q
         ZApg==
X-Forwarded-Encrypted: i=1; AJvYcCWzXb31RssfEEDwLnYL5xGvegDa/04rOZUPWdvxbnDamOL2EsXqekvYPHEWnkrKftu1lvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ypA5ADJTBXsWQvpy+CvpnxwcaYvV6smEN0oPxP1cc2O4jLCe
	sIN/8bPXizFhl8wbrJj1B7NodetHsqE/fbUO1xCTCG270VJziMA2XR4j1AE/wXpmJZH2NmJqOus
	g7lZF7cLv+3h3Kb6dZPg8Qh+9HO+4mMg=
X-Gm-Gg: AY/fxX6g1V6t9oKeH7isFSbJ0SoZ/fwnqgz+0JyMM3UaMjE79ow6EkXC5J0EtgO3nNJ
	7DIi+3QcqHL4xnuZYW9m2I/V3AE9iW/xQR+UK34zWShsvJI0zvNA9Ch4wDhzdCfE8Bm91v/QNsF
	0T2wVXX3/u9DANyBhQeiI+czWCGnZJ9D60YiKA4NPPe7AZ3qm3WN7FWNP4oFXRhvldYmvllyjve
	2eYlSrS6tF/dn5HlRTJxji8mZfEvS2uOTlLnjPE3B0v6NsNm1Z6kBAkJt2IY7Sfc2dtCz7nYmXA
	YaZIllAMbsanjXabjX+JPd4h4qpz
X-Google-Smtp-Source: AGHT+IEuDSk+uHO37kfw+1KlRWo86Tj0U4wD3OG+qF+cUYxLCnvs8i0ykjdYVfeOvoUjITKDQXbaPZgs6cojh2n4umM=
X-Received: by 2002:a05:6000:240c:b0:431:7a0:dbc3 with SMTP id
 ffacd0b85a97d-432bc9efea0mr4747718f8f.29.1767712440581; Tue, 06 Jan 2026
 07:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
 <20251223044156.208250-4-roman.gushchin@linux.dev> <aVQ1zvBE9csQYffT@google.com>
 <7ia4ms2zwuqb.fsf@castle.c.googlers.com> <aVTTxjwgNgWMF-9Q@google.com>
 <CAADnVQLNiMTG5=BCMHQZcPC-+=owFvRW+DDNdSKFdF8RPHGrqQ@mail.gmail.com>
 <aVts9hQyy-yAjlIK@google.com> <CAADnVQJr0WqmqA2fQeC0=Jn5F-ujWmUkL-GfT6Jbv8jiQwCAMw@mail.gmail.com>
 <aVwnUUXmgE1uOOj4@google.com>
In-Reply-To: <aVwnUUXmgE1uOOj4@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 6 Jan 2026 16:13:24 +0100
X-Gm-Features: AQt7F2rALTpWBryWGjQiLYrXRReZq_KM9PVniA_IEDb7aQ0ryO8-rDy8cUAcUVE
Message-ID: <CAP01T75ATFb_gjy5_fSwt6=QMxt7kGSS+12SJN9rz9SfJQ7Qyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/6] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Jan 2026 at 22:04, Matt Bobrowski <mattbobrowski@google.com> wrot=
e:
>
> On Mon, Jan 05, 2026 at 08:05:54AM -0800, Alexei Starovoitov wrote:
> > On Sun, Jan 4, 2026 at 11:49=E2=80=AFPM Matt Bobrowski <mattbobrowski@g=
oogle.com> wrote:
> > >
> > > >
> > > > No need for a new KF flag. Any struct returned by kfunc should be
> > > > trusted or trusted_or_null if KF_RET_NULL was specified.
> > > > I don't remember off the top of my head, but this behavior
> > > > is already implemented or we discussed making it this way.
> > >
> > > Hm, I do not see any evidence of this kind of semantic currently
> > > implemented, so perhaps it was only discussed at some point. Would yo=
u
> > > like me to put forward a patch that introduces this kind of implicit
> > > trust semantic for BPF kfuncs returning pointer to struct types?
> >
> > Hmm. What about these:
> > BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
> > BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_RET_NULL)
> > BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_RCU_PROTECTED)
> >
> > I thought they're returning a trusted pointer without acquiring it.
> > iirc the last one returns trusted in RCU CS,
> > but the first two return just a legacy ptr_to_btf_id ?
> > This is something to fix asap then.
>
> No, AFAIU they do not. These simply return a regular pointer to BTF ID
> (PTR_TO_BTF_ID), rather than a formally "trusted" pointer (which would
> carry the PTR_TRUSTED flag or a ref_obj_id). scx_bpf_cpu_curr returns
> a MEM_RCU pointer (via KF_RCU_PROTECTED), which is somewhat considered
> to be trusted within a RCU read-side critical section *ONLY*.
>
> Kumar/Tejun,

Yeah, they don't return a trusted pointer. I think it would make sense
to change the behavior here by default.
A non-trusted pointer cannot be passed to kfuncs taking trusted
arguments, so hopefully it will only make things more permissive and
doesn't break anything.

>
> Please keep me honest here.

