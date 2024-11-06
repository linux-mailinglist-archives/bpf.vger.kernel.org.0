Return-Path: <bpf+bounces-44123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653389BE65E
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 12:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A6EB249DC
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACD31DF27F;
	Wed,  6 Nov 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpOc6x1d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4C1D2784;
	Wed,  6 Nov 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894243; cv=none; b=tbW3Gblx/jYu8DEcUiofSn+X8GQ1a3RwFKeo2UA+B+Q2U5wCdg2lZInFUqGxNib+zZK9Yi0cqCqJWP9dtdeCf8hO+LvAO4h2hFa03gJvMIRJjZ34K8LyQuHz+SsigebHTgMcQybKVNhxHaXcz1dkCxFxjg7ZSO8n7GrJYsg8ExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894243; c=relaxed/simple;
	bh=vyTp09Kt056FuIQHGo/DAlBjwjbN8kCcV3oLDoXZyOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKJJCtaYBN0z+oiFv7Yjk7Dlxcp3lc8UJ9C4AGTJmYrpLnhaSBcvyA5rbxbk4nYm642jF1GS9oIOk3cZQP4G8+ML46lmNptvEO0l7WRUPVZi584h1QQn+ntaRpr7XjlXDO714PQKgLo+Gz1sWhY8F/PWXhfrM6qmvCAXNxVgIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpOc6x1d; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6ea5b97e31cso7692867b3.1;
        Wed, 06 Nov 2024 03:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730894240; x=1731499040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6w3ZCB6zmWm7DPLmF3ULV02jMnZ0BDFI1Mq0GUN2Ks=;
        b=PpOc6x1dMdoQHmVQxUxAwxZyQZHv03L19P/AWiVPC04j8iGfXhKU3PI2qEGB6vxpfs
         1DWgI7JCyQ+hSelVrsRc2xsI7znbL0C/UeaBb/l5GD0v90uYC/BVolcigL3EMWONQifo
         b5IeanHappIM1YH4oFqcNhcYYKkuQHE3GM0UxYZ/gGlxK1clGMrGoeZqtepoh9NWBmnY
         45+4s3hLy2nj0tJS6Te3TIwdObO05yFc+Es+ikHdIYZqEkd6yfPhFQlfMPqZsE8t1fRS
         8Vh8IS/k0Es4rg5vyWNroNYOzDk9MVKrilxW0ZFZwYktUWXh0cZIPARn41Z+bnZ/ylxS
         oGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894240; x=1731499040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6w3ZCB6zmWm7DPLmF3ULV02jMnZ0BDFI1Mq0GUN2Ks=;
        b=nbZj9nPzm7KsqxuLn/HN8J2Omx9ZESp7sdKVuDf/HPQD2FMmwk0Az8h9ZF/u8ulLvj
         UArpYddaK4InYfUy0yw4XrY5fQIa5ArqtU9BnUlB9GyLWfeWPHe4nwjkDIukxOw7erdV
         46Dj0mYQjY8EtebP9Gsi6LEzS+2dRIHdhhkk7moOMkYXITX0NV5EebEvZcnM2nxquuDb
         hDD07YkOxSDkdpfsG9RfAwC/9tTYk6qgF4J/U8PoLWYtr91SR6gHfkgVY7ofdjbQY1jf
         Fl9PhcjPtlzj9TZE5nBviaOsvCRmaWj5Fnwdtkhvk9ve2rRvoLEwJ9u9vItRpuA01pJK
         pE4w==
X-Forwarded-Encrypted: i=1; AJvYcCVdr40w6mzqV/IALEGH/K3RhK+hhBnKuUvuIeFWr7YyLtMjHge5qloqO7koS4OzUwiWUMg=@vger.kernel.org, AJvYcCW2CTAD4chTycmWzmvHfYHKNKpBCfrpR6JAztuYSEPLmBrU3ZwSb6knv84BZiqJ+aLxiieGPxLFFJDoyP04@vger.kernel.org, AJvYcCWQBNKAOeWh1wa97S2L3cedUmPLJr4nGO+6lLCObBTosni9Jt3cp6pftE+zq5HgsI3FyqrjyT6TRWixjZLtLJVG@vger.kernel.org, AJvYcCXymRkLkUwtegPveHRod3YnZfk/M7bDMeYOJH1ErYay64rAh2MS3r4rKZ6rURXXYWc2yxft8KG0@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFiAUU9fh8wMu04OLtrDOZ4uKlyvtRYohMK/bw/uVy/W2sU/A
	RTnpGIT8EyJ6JWburVJcL/yRb/jL86I3njp5wxKNFdaYf+b2o7v3lfEDspxcgIpGaZw6YEr8WBE
	IDWMiF9RhKtQkm7Gl0o7W/O6wfvg=
X-Google-Smtp-Source: AGHT+IEXBfeFoiOB+fEMxTsXACuSVQL2ysa8XWrdoUI8KD1G2wDOAZIO6rXenVvdCBA8S96MOfWzKujBjQG2V8YVs/w=
X-Received: by 2002:a05:690c:64ca:b0:6e2:41fa:9d4 with SMTP id
 00721157ae682-6eabf02be83mr15361397b3.15.1730894240626; Wed, 06 Nov 2024
 03:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-9-dongml2@chinatelecom.cn> <7b8b83b4-f745-4f3b-8cac-2f190937667a@redhat.com>
In-Reply-To: <7b8b83b4-f745-4f3b-8cac-2f190937667a@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 6 Nov 2024 19:58:28 +0800
Message-ID: <CADxym3Z6GdXdFoXcex-h300xxAbCPtbVoxPMRNx9sKaWh7_MHw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v4 8/9] net: ip: make ip_mkroute_input/__mkroute_input
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

On Tue, Nov 5, 2024 at 7:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/30/24 02:41, Menglong Dong wrote:
> > @@ -1820,7 +1822,8 @@ static int __mkroute_input(struct sk_buff *skb, c=
onst struct fib_result *res,
> >                */
> >               if (out_dev =3D=3D in_dev &&
> >                   IN_DEV_PROXY_ARP_PVLAN(in_dev) =3D=3D 0) {
> > -                     err =3D -EINVAL;
> > +                     /* what do we name this situation? */
> > +                     reason =3D SKB_DROP_REASON_ARP_PVLAN_DISABLE;
>
> I don't have a better suggestion :(
>
> Please drop the comment and re-iterate the question in the commit
> message after a '---' separator, so we can merge the patch unmodified if
> nobody suggests a better one.

Okay, I'll move this comment into the commit log, which
I usually place the change logs in.

Thanks!
Menglong Dong

>
> Thanks,
>
> Paolo
>

