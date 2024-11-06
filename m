Return-Path: <bpf+bounces-44117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1FC9BE2D4
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 10:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E66B20F3C
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B1B1DC194;
	Wed,  6 Nov 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB3QrXhO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B01D27BA;
	Wed,  6 Nov 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885951; cv=none; b=sZuiTz1E6JP6t5zJi1zGpaEyvo/lSSL5G5xY7vkUW7SMn/bWy4iQnjDhKD6VuXOkOX9n6Po4caeigC+d+5TBM8do2nobAItKEjxMjnGRugebnUiWLahTwVVtfJRS4x+2dloHFXeiMklbl93k1kYCJ0H+waJuTWx6uN9l8WWYgZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885951; c=relaxed/simple;
	bh=xFq6H5Gss2PaZCwqeYcPrMJ1Mp9+Lm1NpbULI16e1Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jir7OxL5Q2ZqOzvhxMBl4wSJ7d8mjyhr5EE2EGdl/DSEu8NlhKUACxn23k36MB8SuN2a3N5onzt31cn/n0TDuV9EitPYUGPIuo8koN4tl1Vf+fXg4LOzC93NnQONyVBi6ores8AsM/UEGvnajV3/mLwa0ltjdaZOgwYZFPopDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB3QrXhO; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6e9ed5e57a7so51155167b3.1;
        Wed, 06 Nov 2024 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730885949; x=1731490749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oinRG9+NhYdFlC3tEh227zzGakOwtuLOqwW6sGXxLbc=;
        b=QB3QrXhOgkAC2cRPZrG5sYF/qNjvbnr/4+1SIoPxb3uwbh3nRhqrMziWafMCMPSvJg
         umx4M7GqQuF+CvXTAAl3bWL65jbOVbnhW8fvjbqmIrLhsDnxEYdnmfnUPnspneeNkZI6
         NcqvaujujOi6TZo45GPKXDzUOkDj/+PvS8YPeRXaQCDGb/szr/1CYP9yPSzfB6UO28ac
         AbXV0LrfOx6/KuVAQUwzQceWPBoH+GlyO28Q6umK/uH9KEX35BQtLve5AgCCqifOdMWv
         HzR7nKIHGZvk/2R9N6nkoRM93d0ZCJE6FnXf7cTN8FxaUo8v3ssSV4GH556VVHzuNWOV
         gRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885949; x=1731490749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oinRG9+NhYdFlC3tEh227zzGakOwtuLOqwW6sGXxLbc=;
        b=rKgCjKEuUNGMaWy5Qe1EF6UoTNeCJ5t0GQutmVLroG8Ph9Vl6l3OOouNf9kTdaN4PQ
         2mnINb1Q8q+tP9k35q5BygMsGANouup1X41PFBxa5LAtHomEPLRsT++miVHKojJ9dp6k
         lO0reDTUYQqcXCqmkyVpNcVPI3ouhsmPPetXyaBANm4T6uE4FXE1wKLpyvo185oAfgsW
         tJcBLJ9htlWY6uJgjLlI7giZjPQQBlHAgHetSVGE89lOa4UP1W6ugJ8nmFPeTN+WxcDm
         CgE6UcYWOmIywFyMnRfr4Zj3ydGHysYHIYvrrhJ5Ti8p2TVg2VUNV3puCVgNWETaPiBJ
         K9IA==
X-Forwarded-Encrypted: i=1; AJvYcCUz+Y1P5H946S3Iv5dXySFGTRzAH6M4/EeIp8AZjk/+cJKSHlCA6KN5d6Em18eFfPFXCa0=@vger.kernel.org, AJvYcCVCbYmsDKTR3i9D+FVcTVfyvapLzmCThxaccu1WbQYk/5P/VgrnTV4vuFfq+HJX6RP4yjomm2UpF47e5KWI@vger.kernel.org, AJvYcCX8Aps4ajDdlR2Z3xfFAPWTiRQHGvl0QNiN4TuNcsmgzHAQ0ZM+9cYzAzCUoW37q5haFFKtIB+7Jx5lV0BlcX9h@vger.kernel.org, AJvYcCXuMFj4e2FAUoF0eN3M5rKGs201i+d7k/816ixtGvx2lVBaiUhXMykzrO8LGxu05MufRN9/E7gD@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUm/IhjzT7RUA2gvlwQDpUNeRx5BCsv5uHRv5gUp+PDPX2WH+
	Sen71CD1PXtEL9Aj3sEi3hRxmEeQJ+IavmQKLMuD5BJF3qMJYZS81MywiWMAO7NaMblVVSHRbrO
	08PYlacwc6+gTxQROH3P0cBiFx9Zf+bas
X-Google-Smtp-Source: AGHT+IG/bK8cqy34pOh5Zq5wDFPLa4wQ66r575ctEahwLJo1FJD3pLmUhRA44FtaVQRpsttX0rv0AKr6C/8eLs3MBlw=
X-Received: by 2002:a05:690c:dd2:b0:6dd:d5b7:f35d with SMTP id
 00721157ae682-6ea52525cebmr213814677b3.30.1730885948671; Wed, 06 Nov 2024
 01:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-7-dongml2@chinatelecom.cn> <62773e8f-884c-4bfe-b412-97ad976f9cb8@redhat.com>
In-Reply-To: <62773e8f-884c-4bfe-b412-97ad976f9cb8@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 6 Nov 2024 17:40:16 +0800
Message-ID: <CADxym3adJA1rEHc1GVCmA0_CvuBvMyEF8GOJjm_69uvXhgu9GQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v4 6/9] net: ip: make ip_route_input_noref()
 return drop reasons
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org, 
	gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org, idosch@nvidia.com, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 7:22=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi,
>
> On 10/30/24 02:41, Menglong Dong wrote:
> > @@ -175,10 +175,12 @@ static void ip_expire(struct timer_list *t)
> >
> >       /* skb has no dst, perform route lookup again */
> >       iph =3D ip_hdr(head);
> > -     err =3D ip_route_input_noref(head, iph->daddr, iph->saddr, ip4h_d=
scp(iph),
> > -                                head->dev);
> > -     if (err)
> > +     reason =3D ip_route_input_noref(head, iph->daddr, iph->saddr,
> > +                                   ip4h_dscp(iph), head->dev);
> > +     if (reason)
> >               goto out;
> > +     else
> > +             reason =3D SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
>
> I think the else branch above is confusing - and unneeded.

Yeah, that makes sense.

> Please move the assignment after the comment below, so it's clear why we
> get a TIMEOUT drop reason.

Okay!

Thanks!
Menglong Dong

>
> Thanks,
>
> Paolo
>

