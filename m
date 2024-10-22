Return-Path: <bpf+bounces-42765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218309A9D69
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 10:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F722831D3
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8051E14EC4E;
	Tue, 22 Oct 2024 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH+gtNEB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C227735;
	Tue, 22 Oct 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586988; cv=none; b=P/8STgMGl4wOgIDo+lalhVh1Nc5zv63UN+oModqqIhQHiHnTdoZyG2oWNAftJ65Spl4upWoV5yBIm3p1anSHB937/+8baW3UWn4O7cd71dTN+w2kp3MqmtA+upDDajiJXFBR9SvqPhshu11P/B0d7kekkx1bie6upmL+phz8SlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586988; c=relaxed/simple;
	bh=VmBJLc5YwrovcjmjVJSAnkQ1H6CTGhFHDhc1H9J1qnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNse9aV1A0TexPZf/oz3iMiosbon8zuTPy1JWifAE1bGf6g8k/dwYrsHZccZtizKKwcgFAWkd1n2Li9ePgxR/6BdeeWPY9WZ/6xAP95a8tg6bYE2PtfMvcPfRLreMw/6/GG2BqO7fuO4yx9WGsy/g/SS9NsvHi1pRUcfIEJK1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH+gtNEB; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso54618921fa.1;
        Tue, 22 Oct 2024 01:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586985; x=1730191785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pOfCiSieyO3TQ+yRCELl0+ufCyFVvkQ7MbO+0NA5No=;
        b=KH+gtNEB9F/H4FQCBqEL6IqGlNuUtGHYFthtwOh36G3fe8X+kXPB+HkS8V81vEu2tH
         EN6IGmkMcQgC55LnaOkaKV4Fx7Cnc0MzuUtHX8UI6baDB8zAnXbTTZH0ZT0b6pITcHC7
         6zGE3lkQLVifL33X5T1y/iA4UuxVSN1/n6XITI/0q3p4uxFXn6vC5VFlzwGLrQO72PVd
         wkSK2Y3VIi/9Ief1sJA+pIuOYE6Cz20tXDic7PObmXwldKfOqf1HRqJtqfMf8g1scMkj
         nfANKpIlLLrZDbGFOxbxzubnU20iShjowSCFvpbjkunjfO5n1ei9bRu0QGOWihx0VWXD
         NE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586985; x=1730191785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pOfCiSieyO3TQ+yRCELl0+ufCyFVvkQ7MbO+0NA5No=;
        b=L10HK4Grj61ZAC9N9UpNI1jTIS/nUlZZuYTrf7wRE52atsb7B49FEGnLqdKNkMtznb
         +ygZBvZaAr+wm33PJyOf+1i94iKiWfIHqUnZ1lkjHlEQZWITGHpEXw3mYDlMpbXicBJM
         PGvXu+Gd4cNHXjuoIsLeSo3ybW6TELXhkz5pjaA165egM6Vgt8QdBdiwSWEWvVLrTp8C
         OzKUTOtOSgftg/6cXCqJMGtUp4Gi3R0Xx2M5iW7XTeuk/9CV+odNqSnU2HBm3SFFtMrb
         LDCPb2nn4Kb4GuanNacUTHE41mNebDf47kugjTvl+ciFYiDOChnjIT1RLSG2wrmwwLLM
         +/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPR6Xxd54en/oOGZt3EwpJWtoYvmYrqQkCyM/o2zhWKEOHFvp8HyycTsNU71UjOlzz9E2+npoR@vger.kernel.org, AJvYcCUsFyYtIwudtD6eIuWctLziRVMGfWXGQC2sK8dwPUyAaioiiUrn3C8ZR2Om519Vbfi3Y0r/CwMgdT63rfQC15CA@vger.kernel.org, AJvYcCWD7l+gvpC7KtokH1wsBx5xICGMk7Z6g+5Um5/DlJxvfXrf6BQ9DpZW8i6ERImDUs0BuJg=@vger.kernel.org, AJvYcCXEq8CfcL4Uw7N8RvJ0NdnqH8yjkbsbhLifUecHRnBSnTsX9dAwfiEFw+3PX3jP4sDY3OF/6yyLeKXyoEY2@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIS+YJ3kVwBIi0RCQj229MBu0AJmtCAxyFdouF+TDmiE9pOqz
	YGgnPyWwsdOk83fu6N0me/1i5pNb3n5KvWLD4xlJjUzcLNxDCnd7Nv9u5hh2khRKLxJ1TdyWpEX
	SCldNJfw9wLFH2z9ncyfxpFXUeNE=
X-Google-Smtp-Source: AGHT+IFKl3tfsMju7iYF30A7gBpjOZyrqMNthNqd+kPzl1ymRdMCkJ/IFXR1TES+Mv3Jjwg/Hwd37FmQx1Tu4AZ9ptg=
X-Received: by 2002:a2e:be87:0:b0:2fb:55b2:b199 with SMTP id
 38308e7fff4ca-2fb83281b86mr72476071fa.37.1729586982785; Tue, 22 Oct 2024
 01:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-6-dongml2@chinatelecom.cn> <20d9ed5f-abde-43ee-854f-48a9f69e9c04@redhat.com>
In-Reply-To: <20d9ed5f-abde-43ee-854f-48a9f69e9c04@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 22 Oct 2024 16:50:36 +0800
Message-ID: <CADxym3atdr5Rm1CU8_AU1XaczraYN7ihTJWQiqxaStmD4iETog@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/10] net: ip: make ip_route_input_slow()
 return drop reasons
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com, 
	bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:52=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/15/24 16:07, Menglong Dong wrote:
> > @@ -2316,19 +2327,25 @@ static int ip_route_input_slow(struct sk_buff *=
skb, __be32 daddr, __be32 saddr,
> >               err =3D -EHOSTUNREACH;
> >               goto no_route;
> >       }
> > -     if (res->type !=3D RTN_UNICAST)
> > +     if (res->type !=3D RTN_UNICAST) {
> > +             reason =3D SKB_DROP_REASON_IP_INVALID_DEST;
> >               goto martian_destination;
> > +     }
> >
> >  make_route:
> >       err =3D ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, fl=
keys);
> > -out: return err;
> > +     if (!err)
> > +             reason =3D SKB_NOT_DROPPED_YET;
> > +
> > +out: return reason;
>
> Since you are touching this line, please rewrite the code with a more
> natural indentation:
>
> out:
>         return reason;
>

Okay!

> Thanks,
>
> Paolo
>

