Return-Path: <bpf+bounces-41060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0179991C7D
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 06:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D055D1C2133D
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 04:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8016B75C;
	Sun,  6 Oct 2024 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/6nv/WU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAEA920;
	Sun,  6 Oct 2024 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728187930; cv=none; b=qmhwrZ7Nkd4hPB805FJzghfSZr9fO0r/yh7c+wuyKoky4LU4qmewPV816Yhmyg5X+M7WS2lnDo3D1yfOKziLw67grIbP/AgeBIksBTUXkmmm29TjuTmNP03wMll4uvDZcTQEPtBhmhNIGDVF69DyEknqmmhqnGBZyVWKXNX8C7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728187930; c=relaxed/simple;
	bh=jBIMzlq2qyemeqFD0zzVCt5CBNb2A07I6HruPWx58pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9HAZrftqHR5LQgFea+g/tU2BOWtRQgCkiQH8TCNIyVSqYGoN0ecsXDlZLQC5HVeKd1BLZlHiPPiUhSfFL56TRP/cEAgOthRKNYK8BFaoMs0hW56TT+wnRUmSQWBixecy57rdI3GUjJ3XLM2HxparASDK+yc1CfoFTVFGew8wb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/6nv/WU; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e03caab48a2so2605731276.1;
        Sat, 05 Oct 2024 21:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728187927; x=1728792727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdL2mRdZWJ/xzhNJcF/wqyuScW2pPe2rVtzAuzvJLks=;
        b=G/6nv/WU5iQVxb1easGVYs+D7pbzmVb29+Y/BDpIII3fMftKcHFzmdqXg3QoLsJw5s
         gVMRcdHxbp5+C+Pz0oFUjNcxIP6K2nLF/XNMdy5tVdJGTJSk7ea9PmoBoVd5R4Y2EV+b
         xF6evYNht3bOPaj409hJA5C3YZOJwlUhmZq+XgQNE73DSXKju34CG57TyYmeQRG+EiLy
         rKpTAizRNnSaDC0WqeyX+ENYppLD3CDSE3POJxqpkGKKKjW42SO2TBF4mIUmfZidNXJC
         Pv7EGqs1lsccRRMjTDHRtPZzpdIOdm8eo9SvUrT8sNtuWtiRuJYPut3YXy6DhZep9+xa
         Ojyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728187927; x=1728792727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdL2mRdZWJ/xzhNJcF/wqyuScW2pPe2rVtzAuzvJLks=;
        b=VeeTtTF8fbKa99mFfj2bQClXgdLZ68EGeColSxa0Q92TPqFVpgNbdw3njBkBWicGAX
         UAPl+yQOvwk/92EQwwm4lRELaeCrwiwVSRbto6b6kdPAB9SWMAg1ayifQH4w/fln3UVG
         uyrBRXTQyreP60SJMy//0xT1ZeJiI9Y1Zpx/LSm5DI8jX0ykf5R0z3H+Ytd9aEHSlEGG
         6eWdefZBhPsdDWh3Icv6e5+3fqCDwsWIoXhGKwe36Yu7u0FKdHYHB3rJFufhevyCrhgF
         T61wuM2+ttJqF9FauRWcgIynoR9kr1aWo+ds9xNydR3M/CtFThs841Pe6rRi3QVNUyiO
         ivDw==
X-Forwarded-Encrypted: i=1; AJvYcCVGEVDJWs978rHhTUEsJSoa7McaHzkFFcmWi8gpyvx86MAYZJkiwv0WLMfUK87abGU7JOX4WCOM8KLEMpLp@vger.kernel.org, AJvYcCWGt9xI8YeCZ/0ImZlQHuSBidiGzGVNIlAoPxpmKOH5P8dOOrQu31Z7dJkM7s8t73UP2UA=@vger.kernel.org, AJvYcCWbf1iErZ9E1HXNElDQm4h3c4njM9bjGaOJj74iLRprmv+FxBC+RZkerlK+CK/NuIZIyvf1jznV@vger.kernel.org
X-Gm-Message-State: AOJu0YxCzrkUnRrX1SCEXs6OTIGLw+41GeuU5gdXsy8/ooFXcQUSI1nR
	R+b2rVj/zz59Fh6JnBB/RNGwhB/ciPYySm5wqYcXRvauEWaH9zJAf8Heuu3WzU9QdWUPTqEzSkl
	ajuYiyrS/kT+iblmuDMAaZrucH7s=
X-Google-Smtp-Source: AGHT+IEd8GiqREKe0zNIg/JSHY51WS9PWnKWmd0jkpb3w/sVz26cK7HAGWIB7ScabXxBBhULIpYDMrM4roLyhg0tEJg=
X-Received: by 2002:a05:6902:124e:b0:e25:d11c:5ef7 with SMTP id
 3f1490d57ef6-e2893059477mr4999358276.18.1728187927644; Sat, 05 Oct 2024
 21:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001060005.418231-1-dongml2@chinatelecom.cn>
 <20241001060005.418231-2-dongml2@chinatelecom.cn> <20241004093641.7f68b889@kernel.org>
 <CANn89iJQbjtWhqv-D_fG4LpKtNK4G5g0JQq+fBrxv4VTY-QHSA@mail.gmail.com>
In-Reply-To: <CANn89iJQbjtWhqv-D_fG4LpKtNK4G5g0JQq+fBrxv4VTY-QHSA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 6 Oct 2024 12:12:01 +0800
Message-ID: <CADxym3bcDiyELqoRjn8RitY5y2TxxSnOBGyEafiDhu0ujELuWQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] net: ip: add drop reason to ip_route_input_noref()
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: atenart@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	dsahern@kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	dongml2@chinatelecom.cn, bigeasy@linutronix.de, toke@redhat.com, 
	idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:54=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Oct 4, 2024 at 6:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > no longer applies, please respin
> >
> > On Tue,  1 Oct 2024 13:59:59 +0800 Menglong Dong wrote:
> > > +     enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_NOT_SPECIF=
IED;
> > >       const struct iphdr *iph =3D ip_hdr(skb);
> > > -     int err, drop_reason;
> > > +     int err;
> > >       struct rtable *rt;
> >
> > reverse xmas tree
> >
> > >
> > > -     drop_reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
> > > -
> > >       if (ip_can_use_hint(skb, iph, hint)) {
> > >               err =3D ip_route_use_hint(skb, iph->daddr, iph->saddr, =
iph->tos,
> > >                                       dev, hint);
> > > @@ -363,7 +362,7 @@ static int ip_rcv_finish_core(struct net *net, st=
ruct sock *sk,
> > >        */
> > >       if (!skb_valid_dst(skb)) {
> > >               err =3D ip_route_input_noref(skb, iph->daddr, iph->sadd=
r,
> > > -                                        iph->tos, dev);
> > > +                                        iph->tos, dev, &drop_reason)=
;
> >
> > I find the extra output argument quite ugly.
> > I can't apply this now to try to suggest something better, perhaps you
> > can come up with a better solution..
>
> Also, passing a local variable by address forces the compiler to emit
> more canary checks in more
> networking core functions.
>

Yeah, passing the address of the drop reasons to a function
looks not nice. The first glance for me is to make
ip_route_input_noref() return drop reasons, but I'm afraid that
the errno it returns is used by the caller.

Let me dig it deeper, and make the functions in this series
return drop reasons, instead of passing a local variable.

Thanks!
Menglong Dong


>
> See :
>
>
> config STACKPROTECTOR_STRONG
> bool "Strong Stack Protector"
> depends on STACKPROTECTOR
> depends on $(cc-option,-fstack-protector-strong)
> default y
> help
>   Functions will have the stack-protector canary logic added in any
>   of the following conditions:
>
>   - local variable's address used as part of the right hand side of an
>     assignment or function argument
>   - local variable is an array (or union containing an array),
>     regardless of array type or length
>   - uses register local variables
>
>   This feature requires gcc version 4.9 or above, or a distribution
>   gcc with the feature backported ("-fstack-protector-strong").
>
>   On an x86 "defconfig" build, this feature adds canary checks to
>   about 20% of all kernel functions, which increases the kernel code
>   size by about 2%.

