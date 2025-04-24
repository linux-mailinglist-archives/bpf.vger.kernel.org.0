Return-Path: <bpf+bounces-56623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E765A9B3D4
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F121927BCF
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BBB280CCE;
	Thu, 24 Apr 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDfwp4+f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B65BAF0;
	Thu, 24 Apr 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511768; cv=none; b=s35JWcWRCJPnE4pDH4uKmOZxMw9xItpuNe7TT9pKi3CLOqbkgKUkPoeQZMaZsO2JiGfL0oJ+XhSLxQFrJitxHCdU/KRUavu+rohoazZ+VEyfhpR+ZR+TYmL1fJXQtpBAWFYugmCrEPTi0kUwejJOMrQZrDvecj1GNfpyopL2rvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511768; c=relaxed/simple;
	bh=3+XlnP4ZIi0Boi78IxKkmV6330u4OI8yZ6DyTgI7uHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txoMiwLFewHiRa7GRHdQuCd/Q2DHvOumG/VKnZ8No1mmwAAL503ZhJSsXSr9YozJ6VGtBXznXQTn3BaRZ7kfAf2B69WaO7fwM3xdu74z58ZYpuac4O1K6mFy1ClNCRw3L0uS9VY01DaXe5rQB4nY78zW+1RFam8HdIur8G2LSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDfwp4+f; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so1016193f8f.0;
        Thu, 24 Apr 2025 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745511765; x=1746116565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PbFB/8kHDMc/YDyWse6m4570g+LrAowPtrzkDrTWHs=;
        b=FDfwp4+fs54lCARsgn1a4FDwZiHHVPgOn3C5vi0xyxIH2AAWGI9pKBt5PneafLe53U
         x1lMmThOi/gxbPZ1lQOPXBQz//95mUB31DPDGh17X4e1sHMqsDrTF0Eqh4BbF7aczCSf
         FwpcMXkdpcFHNXbJe0HXuqRrD1zmvd2LIEAUlRtLyP3UqNBSq3wIGn6oQFnPC8iuXMzj
         l8JA+tzreT2oGan4m98bBS3HT81M79IInUrsTi5oWTR0ajEtOeFvbr1E3TEIn6fXfK4g
         ccuw/n2vlVElCyAtTrUs3pjrK4soEV9VortdQ53UHut8bxiFRQfJu9Jc73OkqTWQCgDL
         E6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511765; x=1746116565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PbFB/8kHDMc/YDyWse6m4570g+LrAowPtrzkDrTWHs=;
        b=aiUr2atSCo8EA4eWGUxx8I9i1MOgoUAYElZcVDoY4i7GRRtDeZQK46Na/6W36Ic+FE
         fVIW4P8bZ/IaqfKhn2FeB7tKWBTiLEaMMv63062F9KcEseILsISnsazsJ6fjXsRA/owz
         DifOsuhGKJ8Pv7+O6eZNutDKzLVC6SONKXRVd8BbxT2AbcjRXzgFeRaUyHBg/NFcOFTl
         dvQyCdDSvrQbcVz33UfhG+XQqp8f5OHbDti5Jop+joi+B0WdaUU6VSg7b5q+86nUxojw
         g/HtUiaJAvjyO15aI3/18AWYmCWTW4Oj5gqpj0zubNm4qZ2LV9ABhPrO9dyxnOmyYGFO
         TjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm3Whk3LTpagf73kg7VaUhgcu2iDvU85luPB75qFY/G7Ldp7uC7frTCid6EJFq7q5aWwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxs2pbhvZWRuurkGr/10CqwgHLH3K0bWpNVVhZL/wmPoTmAfZE
	W37/S2zf359z/L1dwZIkOFQ19cM/4EMtAJLxzcPgpLY7QtlpnTCBJaJ1Kr1BqZTJb22tsO4BrW6
	kzgO8hUFqhbItiqObmn0RM7aGBicmhc08
X-Gm-Gg: ASbGncucw9uoeGHY9SEBRTO7bF/qLcEf9Ix4cezB4OfUPdvidQbdP2yJepYyK4gIoIH
	ISmwttvgZJQMsbxMvSJd1Nq+V6O0sbKtoWgSzjJcyIkBTOkni4iOA8a3nO6IyJdAAoPvyNiu44H
	bA+1hDUO96+hX7QTqk6+ujYdjK5H12fsOQKg1t
X-Google-Smtp-Source: AGHT+IEr1mhHZBCot2ejOcsZr6AkUBB/HZj2xFv0yZmzfkUOd7Atd/lALT3z/e/21t+W+XVjt0ylOtRKVInNH9+d2Ko=
X-Received: by 2002:a05:6000:40dd:b0:391:2306:5131 with SMTP id
 ffacd0b85a97d-3a06cfabc65mr2991636f8f.45.1745511765231; Thu, 24 Apr 2025
 09:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Apr 2025 09:22:34 -0700
X-Gm-Features: ATxdqUGXdA4oEz7RfZMlL5RnjRHgxfi2G7Ns2b9ewWC096LVtjY6w-vRRdwCjxg
Message-ID: <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for packet metadata
To: Arthur Fabre <arthur@arthurfabre.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>, 
	jbrandeburg@cloudflare.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <thoiland@redhat.com>, 
	lbiancon@redhat.com, Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthurfabre.co=
m> wrote:
>
> +/**
> + * trait_set() - Set a trait key.
> + * @traits: Start of trait store area.
> + * @hard_end: Hard limit the trait store can currently grow up against.
> + * @key: The key to set.
> + * @val: The value to set.
> + * @len: The length of the value.
> + * @flags: Unused for now. Should be 0.
> + *
> + * Return:
> + * * %0       - Success.
> + * * %-EINVAL - Key or length invalid.
> + * * %-EBUSY  - Key previously set with different length.
> + * * %-ENOSPC - Not enough room left to store value.
> + */
> +static __always_inline
> +int trait_set(void *traits, void *hard_end, u64 key, const void *val, u6=
4 len, u64 flags)
> +{
> +       if (!__trait_valid_key(key) || !__trait_valid_len(len))
> +               return -EINVAL;
> +
> +       struct __trait_hdr *h =3D (struct __trait_hdr *)traits;
> +
> +       /* Offset of value of this key. */
> +       int off =3D __trait_offset(*h, key);
> +
> +       if ((h->high & (1ull << key)) || (h->low & (1ull << key))) {
> +               /* Key is already set, but with a different length */
> +               if (__trait_total_length(__trait_and(*h, (1ull << key))) =
!=3D len)
> +                       return -EBUSY;
> +       } else {
> +               /* Figure out if we have enough room left: total length o=
f everything now. */
> +               if (traits + sizeof(struct __trait_hdr) + __trait_total_l=
ength(*h) + len > hard_end)
> +                       return -ENOSPC;

I'm still not excited about having two metadata-s
in front of the packet.
Why cannot traits use the same metadata space ?

For trait_set() you already pass hard_end and have to check it
at run-time.
If you add the same hard_end to trait_get/del the kfuncs will deal
with possible corruption of metadata by the program.
Transition from xdp to skb will be automatic. The code won't care that trai=
ts
are there. It will just copy all metadata from xdp to skb. Corrupted or not=
.
bpf progs in xdp and skb might even use the same kfuncs
(or two different sets if the verifier is not smart enough right now).

Ideally we add hweight64 as new bpf instructions then maybe
we won't need any kernel changes at all.
bpf side will do:
bpf_xdp_adjust_meta(xdp, -max_offset_for_largest_key);
and then
trait_set(xdp->data_meta /* pointer to trait header */, xdp->data /*
hard end */, ...);
can be implemented as bpf prog.

Same thing for skb progs.
netfilter/iptable can use another bpf prog to make decisions.

