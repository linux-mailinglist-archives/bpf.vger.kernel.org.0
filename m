Return-Path: <bpf+bounces-51663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B1A36F08
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 16:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BC11894B23
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A31DE2A5;
	Sat, 15 Feb 2025 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYMwaUTF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23CF1A23A4;
	Sat, 15 Feb 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632571; cv=none; b=LrZ6XCPfvhhOh2dVkoqSuxT5IOscDnLGWi507rsFYLDlIOxb/BTi0Mgk03eFWD1xPncq/aZb5ia5sBmpnC/Yg7WPcnBSUu1FaopJJJ47qnjbT1pLOYIYvcB4w5/eCnH8nrHTpmf+/tdKYOiCA5woanbYkysiDNfkch1RuTS8FXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632571; c=relaxed/simple;
	bh=/jJ6wIUWLQG2fXvD2qT7otNEwqosPWjsaTNhP/eM4zw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TirdQ9LgXvtWNh4RNxEoWyL78VEwhfh0LGHIjsumLKjYavkjxUur1SrvJ86wo4GNjW+bj6Ujoo7kt/G32v/oAHu8DL5lKWXwtrPrNN0LvDNQjzIn9F0b5X/feBrTHR/Qm9V98zH+Bzuj4zgj+J1h+9vQizBcrnL3WG8vP/R9KOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYMwaUTF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471bc8eaf3fso26258761cf.2;
        Sat, 15 Feb 2025 07:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739632568; x=1740237368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCQx85+CgpyKh7rWon2l13Njv7/1QurANKoAJungb1A=;
        b=iYMwaUTFhncGYbMUpvuw/wao854x3nquPIN/XKNThFbekMRJhZ75gAx1Ep5CijQWSX
         xMacW6IRGKEbQIY4DIYLWDeEqtI8cHQ0U74c/bDPMq8p0A7KXeZLLt2Nj9mdIL0uKzyu
         AmKRKIff0ReQFQACB0ItD0wpliup2mZr4R76Wjk3HvWOBmqDhnTRdatGFwLwjVeCeH8x
         bsCnUs2GNI2YCiDxyG4LGV4Kul4OihqXzD7P/tn5iDQXP1ceajHFurtcRYcNP3HHXr7O
         tGK3Umny9Id5QFwifY0b/nV+oYtpy0zMvtiPZYttvchFR2whKi/VUvycWzKNlmMk34IZ
         TJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739632568; x=1740237368;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uCQx85+CgpyKh7rWon2l13Njv7/1QurANKoAJungb1A=;
        b=RcbtPeB8Fr1vV/twlFOQNjeyq8S+hA0K6XHaJYf3EfI+QZY+9A7lpWSdkVebbl+R2a
         2eUKMjvg693KstpYsoH6ZRYH7oUY4UR/Ahlb+qGMRxBUkD8EIZGN2cclNdF002/MiZZ9
         707VhIHjr2HAG/6meKex35TDYHP+aAl+OuOJZistQLuhSfA395RuMWeMXkYw3tsqFM6N
         FwSJU0dEmZeDnJnDJqHT7mDWzkxNH7CEdEkUC2K5bmRH7OtafGKsizZPTtJhM7kvBMEc
         93t++YDj9i5Ku8SIhjL1YzP/h/CgTfTAC+Ji4kGyDaajLnWPWAupmKXKJ+736ifwoG2T
         VEMw==
X-Forwarded-Encrypted: i=1; AJvYcCUDjfAbUXavToy/ysRs0ZZxFg+Fk6O00gLQXkXJH+9E4/WNqeluocDD87mwes6UDutDEfFOvaki@vger.kernel.org, AJvYcCX/23EUNRbiNGSEHGQiBYLqkifQR2Lf1vt3MK2yBSOuVEoGaSrJHbDQ8hy0yTsIP4/i2SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1QJK9sHU3nyO9OPZtf4WjmY+3+cSpbyBIukXCTWvqQ1c37cI
	Dv/LncySdSgHAoZ/psfb8aT9NMD6RbN0+5eVyRI6+4ZPxFkYziJV
X-Gm-Gg: ASbGncv0iGogip07H6y/1WnsAy7Q1TcbhSi2VFkPWifFKVuxrvJmJ+u7SWnyq+Cn4wm
	TILoePcWe9dwc2DTjSoDXSykFLyFCi2OEcKxI2kzT3p7RhDbpP1iHUyO1B5Abfo/rCQqe+Hlu4j
	DobYOr+TGf0txl1hFb3I7ZO1WPCOnvOhnBe24mzIGPaslEj58PWe+csBF4JZ/nOfy5L6+F2TPDX
	ysHDKBfCDDUSFEg86YmQwmf4ePmFkOssrHFJFazKU7sBb/MsPtkL48uXTvonEqSTEYr/1HxluJz
	xi1Q5xapN++4h8ZbCJh18kBhLrk4/jr1QiSaMFuImbMIC5ghzCNweNfN15v5Mwc=
X-Google-Smtp-Source: AGHT+IE4FRciT74k4uxdbuseR6K9Kjbqyad4iFRHkSz18OQiYABaXR/2Jit9ijM9vjzpxYY5karNQg==
X-Received: by 2002:a05:622a:1a91:b0:471:cc71:da47 with SMTP id d75a77b69052e-471dbe6dc72mr47192721cf.32.1739632568631;
        Sat, 15 Feb 2025 07:16:08 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af37d2sm28204401cf.63.2025.02.15.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:16:08 -0800 (PST)
Date: Sat, 15 Feb 2025 10:16:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67b0afb7b65d1_36e344294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <4ff9b840-9ba1-4217-a332-d5fcd1cf983a@linux.dev>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-10-kerneljasonxing@gmail.com>
 <5f6e9e0b-1a5f-4129-9a88-ad612b6c6e3b@linux.dev>
 <CAL+tcoCYcpaBDG8GRyP1Fk8WYHAo4ic1YNhmazXEysYUWSTqxg@mail.gmail.com>
 <4ff9b840-9ba1-4217-a332-d5fcd1cf983a@linux.dev>
Subject: Re: [PATCH bpf-next v11 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB
 callback
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau wrote:
> On 2/14/25 3:16 PM, Jason Xing wrote:
> > On Sat, Feb 15, 2025 at 4:34=E2=80=AFAM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> >>
> >> On 2/13/25 5:00 PM, Jason Xing wrote:
> >>> diff --git a/net/dsa/user.c b/net/dsa/user.c
> >>> index 291ab1b4acc4..794fe553dd77 100644
> >>> --- a/net/dsa/user.c
> >>> +++ b/net/dsa/user.c
> >>> @@ -897,7 +897,7 @@ static void dsa_skb_tx_timestamp(struct dsa_use=
r_priv *p,
> >>>    {
> >>>        struct dsa_switch *ds =3D p->dp->ds;
> >>>
> >>> -     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> >>> +     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NOBPF))
> >>
> >> This change should be in patch 8.
> >>
> >> [ ... ]
> >>
> >>> diff --git a/net/socket.c b/net/socket.c
> >>> index 262a28b59c7f..517de433d4bb 100644
> >>> --- a/net/socket.c
> >>> +++ b/net/socket.c
> >>> @@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *t=
x_flags)
> >>>        u8 flags =3D *tx_flags;
> >>>
> >>>        if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
> >>> -             flags |=3D SKBTX_HW_TSTAMP;
> >>> +             flags |=3D SKBTX_HW_TSTAMP_NOBPF;
> >>
> >> Same here.
> > =

> > Sure, you're right. If you feel it's necessary to re-spin, I will
> > adjust these two points :)
> =

> That will be good. I would wait a bit to collect Willem's comment first=
.

Depends on answers to my few remaining points. =




