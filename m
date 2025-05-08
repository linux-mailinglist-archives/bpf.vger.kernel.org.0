Return-Path: <bpf+bounces-57758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE8BAAFB56
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEC8B21DA3
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD8F218EA1;
	Thu,  8 May 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXvaLSSO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BE22B5B1;
	Thu,  8 May 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711010; cv=none; b=PWNrP1kVctOamIDlcFmpw9aO/MNWYxkjO1heUR0OmTouBrUUR9Rh55//2vEdC0gjAxoj+ctT4p5J/7DLjPUa0s2Xuq1XrJ6dGpRV9qpgFcZ/FHbSVNWRatBkHjOc7JCsrRe/nMfSssDW7rxCdXAifSw7t2Ja83xA0vJfWXb8uWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711010; c=relaxed/simple;
	bh=WIdYABlOPeMu+DWeul48wLOvFKiMYDmec9SVENPcPBo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=a5Zlme0x0RtllnMlbeMT2IyX+QkhZeTnDkdDQlZWwj1+PYJ2O7IbzRvSfGIPI1afRcM57YD6modl/slSwxFoFH3TGARUAPL9rxewQT2d0YYF+wKZQ6aSD0iv8bDi3wPscu4T5gIhBO2oLgnFu4CPxzCY2MAbrY8yiHaPc9Eytmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXvaLSSO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c9677cd6d7so111986285a.3;
        Thu, 08 May 2025 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746711007; x=1747315807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5N12FBocfutG0F3Mi3MfydrH9BrYroiYk6HH8Y6qHw=;
        b=EXvaLSSOCBRRyk6zOYC9TDUUnsBaBbxoTRVXXO66kV3xt7yQ0wShD8+RZ+tmN95QIs
         OCsdXwwYMW7Z28OX9lj2VjPK4FzVRFelgtkzfLBk4S8Nir30w6RO4JzQ+abJ9FMPTv+i
         VbDEOBvF972ozyUNWUm7hjlpCtTBo0qP07RutxOdLvKYA2gJKQ8JwnhAuTyQeYtrwd1M
         Ef+Pl5wQz/y1M5FXw6qaETWA62zL6x8AkdbznAnsncsUAxsJukGtfKzIURslR0ZDgtE/
         VHb7fEyOfhGsWvRaERkmbCoVqhiNUxZ5XhxZemFmSiR+O13w737bb8GKxOpdrpBZR3ZU
         dDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746711008; x=1747315808;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5N12FBocfutG0F3Mi3MfydrH9BrYroiYk6HH8Y6qHw=;
        b=mVI9sVsQAJ1enxHyrlFnD+mhOOGa3I7vw4EIjifAQuIcLojf8zOqp3BtVJaVIaafxl
         PcbTXGh25yGvHclfwDRRRU71e0i52BtY6WzhNu6B7xGMZUeNk9fctEZu6htHg09Tq3x8
         f0388+YPtObhX0NTlBRnsCjyupr/7niMkVmZXRNE8lXZbgxMm4aZS98rMRTTJ3QsNGkG
         YenJR7KkAOLbSGC6liYk/6/K56u4lnVl04S/w8MUOEh+hCOFixpBGgKCRBzrvvDHd+d4
         GN6oaCLy2cBC7LLumxBp9hR70e1M7/L6LkXSuk4w8E1AYE/ed44Mf3WfxGT9Zyr2mRtn
         S/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXEDZsI5q9tH2jdrLiX2i89tIuYTz0VJq4EwHoiuwvsVNUKEjEq1ykPw2PPooCdK1fb7ozTgKLY@vger.kernel.org, AJvYcCXpv7Jmtuz/cTxLFfXSfzw2o4E2Vr56SBv7M/0BBQ5lom4WlLMa0tliwNlApEQk5HuqiFc=@vger.kernel.org, AJvYcCXr12QJVGiWsTzGn/h6BHYnzXIuBKg4af3rsTqW7UoWhu2lG4C7JpwBMUdQEMR6VCs2jbc9sb7vjuJ0w1vu@vger.kernel.org
X-Gm-Message-State: AOJu0YxJnGxY1A8yqrvfCY6/iRlzyRCM6q/Hzsf9ROWyR7r5MyiZtr42
	1APaBEJs1+ijVHAFFdfeksuNzmbo4U1xJCjm0PFyBh0RzcfJS24u3ie66g==
X-Gm-Gg: ASbGnct5HAq+ZLu7ZlrHg+7dcgrAi3zriQKgOlb7FHKasR2iCI51fXanXHvFyW9LRZ6
	sjAz0kZjvDr0zJW1FNAKToW+KiySuj9py5PVUyvPkDBVkaIlqdtwdQUc1uRsfLxkgxWaQMFSiCz
	IEkqbC4WaINDbF3/TGqdiXeIUdOBJlSq2GJvmz2XqTEP4XvxJu7c3j+sdZptphZ9UJ0hTjdMgxW
	FaVROarsP3XhNO66nv42QMKegY/dnJdVhUXAZLqGnLiVjWlQCiru0EJ5Aat6xHF7xg3P+htTxhn
	bFdVYfuymEG5EzYNitMSm3UlcW4cUeOhSNJ7/aY9efzRGmeU1xsgbmgVA7NZNDHfq6DkjwK8Qo6
	C76dC+GuP8W1+wnpy+k+c
X-Google-Smtp-Source: AGHT+IHr13Zp7M4XJ3c089EOlH5Pw2BnuNtuD6HU8HHp2gxHtaUDJxFlWmZM7iVR0TnRdARP34HZyg==
X-Received: by 2002:a05:6214:1d03:b0:6f4:cbcf:5d46 with SMTP id 6a1803df08f44-6f54c3d0155mr55191826d6.20.1746710996931;
        Thu, 08 May 2025 06:29:56 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f542623ee9sm32993196d6.5.2025.05.08.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:29:56 -0700 (PDT)
Date: Thu, 08 May 2025 09:29:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Message-ID: <681cb1d4cb20_2574d529466@willemb.c.googlers.com.notmuch>
In-Reply-To: <1DDEC6DE-C54A-4267-8F99-462552B41786@nutanix.com>
References: <20250507161912.3271227-1-jon@nutanix.com>
 <681bc8f326126_20e9e6294b1@willemb.c.googlers.com.notmuch>
 <1DDEC6DE-C54A-4267-8F99-462552B41786@nutanix.com>
Subject: Re: [PATCH net-next] tun: use xdp_get_frame_len()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jon Kohler wrote:
> =

> =

> > On May 7, 2025, at 4:56=E2=80=AFPM, Willem de Bruijn <willemdebruijn.=
kernel@gmail.com> wrote:
> > =

> > !-------------------------------------------------------------------|=

> >  CAUTION: External Email
> > =

> > |-------------------------------------------------------------------!=

> > =

> > Jon Kohler wrote:
> >> Use xdp_get_frame_len helper to ensure xdp frame size is calculated
> >> correctly in both single buffer and multi buffer configurations.
> > =

> > Not necessarily opposed, but multi buffer is not actually possible
> > in this code path, right?
> > =

> > tun_put_user_xdp only copies xdp_frame->data, for one.
> > =

> > Else this would also be fix, not net-next material.
> =

> Correct, this is a prep patch for future multi buffer support,
> I=E2=80=99m not aware of any path that can currently do that thru
> this code.
> =

> The reason for pursuing multi-buffer is to allow vhost/net
> batching to work again for large payloads.

I was not aware of that context. I'd add a comment to that in the
commit message, and send it as part of that series.=

