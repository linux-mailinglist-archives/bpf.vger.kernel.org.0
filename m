Return-Path: <bpf+bounces-46312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8949C9E781F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FC0188622E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7C61D4610;
	Fri,  6 Dec 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdOQDDcf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD88170A11
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509954; cv=none; b=GXkYjOVBGunu849/iQkiXzoNHT2o0pvxbXuOyYTj3N7JNRx4ULEmTZJL0lWIEMq1hRMITpnDr/Ve+SXGFPFRil66BR6uZMqMtwwABMszj0/35IkIuNb1BgZp5/cSua1w/7iXoX7NUrOW+m+LoW054d9Dqq7ijDsyPmBrLc76c68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509954; c=relaxed/simple;
	bh=XGaBwhb6TQberdd+2dbRq4Ee9s58uq4T6ogVSNHCXao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYyvrFHSjhos9wBXDYWNEYcOr3TkcEmS29u9VKDZ7PL9BLncYtueVjMcDMRx763uRpYTP5YYCRITPwe3Fog9743El+P3i9/dUcTFpCUF2YKiFpNX+vO8LYmQpt9bqiTDU3AReMTtqPqOH1sG5gOIaZzJgw6NJ7NJ6+u78vJ9WC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdOQDDcf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862f32a33eso344677f8f.3
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509951; x=1734114751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGaBwhb6TQberdd+2dbRq4Ee9s58uq4T6ogVSNHCXao=;
        b=RdOQDDcfZHCT9Z5oI9eiZ0Z2tCoRCW9go3NFxAMZ9imFQHLyWdWtQUzE2O9wQM+mBk
         Zxwy8AhL4qB1qaZ+tDsflXi6puQv9IVcbEXTT4c1udDom2BmkTwxAzVsCu9Sidv6cUG2
         BKX/iLw75YyXHDJLTVSBvXDuvxIYt1yBd+MyxWe/Sr64yvzF03EiKAv0kffsi7V7N6wa
         j/tyi94yX2dn2k1kKb4+LNDmDaV8UTVFmJ/8pE8zC6dHkCa192JXcu4tR+i4t4elXD2q
         FkUsGfaP/8TTfUrtrANmq9s4NcyfEWa9eksEO1Yhw2o+qVJXHNKBEKEf0o+je9Tu8a0H
         jv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509951; x=1734114751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGaBwhb6TQberdd+2dbRq4Ee9s58uq4T6ogVSNHCXao=;
        b=Wv+AiLzJ//3GqWZ+bGW4V8RfkjzHBrFLw+CjAPeulGbdh8nKTNhGRqPcl4fSn7GdiE
         QQ6E3Lfc+67dS2tpOr6H7RkcZ39KA8vhUaUB/od7E2JDnoER6lTbRTQ2WD8z4gWI3Svi
         6R4parV3h0JVNBaIYWKaTd3mLxTCUbwAAvPHKRe5rEsX+NhtgN7yLj/46h7+yLCaCjj6
         z1vdPXtVT/Stq9p1aXp40NNv0BYhF8JHVYe+XWJhJ7FKtwZwJyY9vMy7iqDy6qtib0Cj
         lj53ZTUgoYnlQAmubtpLT8MXFpyhsJnutB2dnZflrQXoj58A9myTbqrRdyzxGhSH9UTz
         L9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxk2jG1qEakjTbRcwZkKrCq5qt1c2ZFKi5KYN3KTLhvTWYFAsxL6KFayaaSbZWe4WuTHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxENTKE4ZWthjaVnegHQ/qWw6SqYnBBDCARo1+5HhngJBZxtEty
	VztHnbwseDP6ME4/nPHLnuvSJjjio6YtdBuf6Du8bXylYsfj+5nYPMdF/3tuzhsW+sXNYIpnRmr
	uHjpkKwAprFV6xj3EBXo5IrNOUg4=
X-Gm-Gg: ASbGncv4BD8wUMUuvRhTqA8RV33FijSioAXaCaQFWPQagYXP6ani1zNirHj8V0tx/nk
	bYHLEgYKq6E69EKCCcq1Nmq8PCEvh8ShKp4yBCeHo/aAWw/0=
X-Google-Smtp-Source: AGHT+IESOeOJWuq4EQFkgjplCKSneRUlNOesKISd3OmCuPvnj6yPDc/NEyhX4mHj06zDExASh+cpcJlA2eEnu1I6hNo=
X-Received: by 2002:a05:6000:1886:b0:386:3327:bf85 with SMTP id
 ffacd0b85a97d-3863327c06emr573771f8f.53.1733509951442; Fri, 06 Dec 2024
 10:32:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
 <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com>
 <CAADnVQL-0SAvibeS45arBoZcwYjQjVnsrMeny=xzptOdUOwdjQ@mail.gmail.com>
 <CAEf4BzZF3ZrVC0j=s2SpCyRWzfxS8Gcmh1vXomX4X=VS-COxJw@mail.gmail.com>
 <CAADnVQJ-y4G9TH-3kgau56OdijFQ4ua+_JNqv5VYFE7AzL418Q@mail.gmail.com> <CAP01T74hPaBjmbpfaD4=KBu1TRm2+D=bUiLpMqEbXO9=DkX_yw@mail.gmail.com>
In-Reply-To: <CAP01T74hPaBjmbpfaD4=KBu1TRm2+D=bUiLpMqEbXO9=DkX_yw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 10:32:20 -0800
Message-ID: <CAADnVQ+KOkSzEB3UeiyZ_jkx3x1gKrB=rahX8aHfB7yykcmkPA@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:30=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 6 Dec 2024 at 19:26, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 6, 2024 at 9:42=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > >
> > > Or, *importantly*, if user anticipates that "freplace-ment" BPF
> > > program for such subprog might need to invalidate packet pointers, bu=
t
> > > the default subprog implementation doesn't actually call any of those
> > > special helpers, user can just explicitly say that "yes, this subprog
> > > should be treated as such that invalidates pkt pointers". With your
> > > approach there is no way to even express this, unless you hack defaul=
t
> > > subprog implementation to intentionally have reachable
> > > pkt-invalidating helper, but not really call it at runtime.
> >
> > Exactly.
> > This artificial issue can be easily solved without tags.
> > The nop subprog can have an empty call to bpf_skb_pull_data(skb, 0).
> > And it will be much more obvious to anyone reading the C code
> > instead of a magic tag.
>
> Wouldn't it be less obvious? You would still need a fat comment
> explaining why you're doing a dummy bpf_skb_pull_data, because
> normally it wouldn't occur if it is to clear pkt pointers, and you
> will say it's because it tells the verifier that it invalidates the
> packet for the caller.
>
> It would certainly be clear if we had a bpf_skb_clear_pkt_ptrs, which
> would be a verifier built-in and no-op at runtime, but we don't. But
> then that's the same as a tag.

It's not at all the same. It's C vs our special C language extension
that gcc still doesn't support.

