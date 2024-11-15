Return-Path: <bpf+bounces-44903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DEC9CD4AF
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B851F22CEA
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B26921106;
	Fri, 15 Nov 2024 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keuZGJIm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729263B9
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631135; cv=none; b=gebLnF42TK/pmllF9oQDSq9ibtfRA6f+gFN5fBjKoT7/x1p4OIqWurgA7W4ZbgBb5Pn2iq6pCweSs6SxTt296GI8PFNaN3z9ElPAWYZpatnFFFviSNmMwLb7dA9ldIhsiYPt86PI4u2cypAEFfHYK+Mv46dAefK4hIdI5+9DJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631135; c=relaxed/simple;
	bh=rTiGGLwgJyDk7GIMXGKQJ5HCCpi9O1lNedYzfFHogEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1V9rPeQKAEBKRklzI0u0cSDO1plV4OUe3QbCDIzJtwtJsxx4gj7uUuTNlYTnusOxHk7Sn8dvSsYeeRMo5EaPCknJLPwwv8tuj7TfXDTUN5v5aSwc+8J/dIZxOjeF04cQEg2gf8WVX54kQVzPJorgFb1wZ+px5kWy4F4ZXGnb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keuZGJIm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3822429c615so328943f8f.1
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731631132; x=1732235932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ9c29Ov1ciJOuurrUkorc8mqDeT4MDqFi86PLpeh4w=;
        b=keuZGJImJZI2l4xubppk2TTRrkzOe+gmYkIZoVdntMicA5z3DGFksfjOR1N0F750hu
         Dfg9VW392hOIs+oWZXWj4/kyYE4RLqJnlq7PCuH2740erD8/cCOoXn5VSXHKYa5/0Qu1
         eEXtJwQ7OWP9m4KkKUs20EkLrezDAVzD17JIGTH1l2uSPbr27/Paj8eumWAm/h20q1am
         HmM7dWRyK27FAIC4OXCOKkkVxVptKN6i/OB1VXl563rjnNyQ+iq6srdv8czchhiMfZPF
         oIrLe3l1jnunOMDRHDOYdEC8OZW2J0qnRgnh53RFhksDjnkxeNYc+jwBMUW6yWJ/GdhX
         vxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631132; x=1732235932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ9c29Ov1ciJOuurrUkorc8mqDeT4MDqFi86PLpeh4w=;
        b=LY3Ga1vompaYmqQbaVat4TuC1l0kLj7omDdtIOVDllg4wC2cE5+gnXzara6BgGSj89
         aUMnEHIWQLU2MUZfnmN9kzPfMBPjqiXp5lKEl4He8OLDvC/KigMKRDEQJmSQWT3WQeJy
         vHReXCVomFVXa8Y8dIWrk3+K2WdQd60bEgat2xalV/uoCoBhnkyrhN6/tqQTeKN0W6d1
         XgVlrJpgPosDTRFKSReDuNEZoT0LaYRVVf6SI//QevF6e43gpD+oDszalGsgcKQ4evZb
         7dTR/FZc5QXBbGArNmUhAp98oHVniUOwIm73GPOdlw/bCCQa1Bku2eIQQR8zMS3ttgrb
         FPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHMsYomRj5tBAcCvBAvh33+qHU1AgBqLAOLkmIQ0nIbVABGVoblIlJZs8t/GImbtgah9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzpP54ZbQT7flXL/9VcNZCteGdOC2nJBj3MmcDBWvwgUAabnK
	8Onuk4M2PNi/khVX8hqS9fA2B9eq9en746i/oH8eTRlH1EW/aroNtt+8yUI8QqIRM6ojaWGe2rA
	OrnishoKnt2NZuNrHVHqGmGIvaUc=
X-Google-Smtp-Source: AGHT+IHBG4zwYNW0L7/Nhm25Yt57LnkAOikC8iqXAB6TCvclLfh5o0csjEO0RG77cJW6HfQIVLW3K3lmJF4RVtoMGO0=
X-Received: by 2002:a5d:598f:0:b0:382:14b5:89c9 with SMTP id
 ffacd0b85a97d-38225ac72f8mr507863f8f.58.1731631132145; Thu, 14 Nov 2024
 16:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107175040.1659341-1-eddyz87@gmail.com> <20241107175040.1659341-2-eddyz87@gmail.com>
 <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
 <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
 <d34cbd7bf86d01ecccd70220078a7279756c8ec6.camel@gmail.com>
 <CAADnVQJoRiZXRgzJt6pMFKqsCh93caARjA0hGQ_-V-B0VZ-+-w@mail.gmail.com> <595a43d159bec96fd774c63024038006e8be2722.camel@gmail.com>
In-Reply-To: <595a43d159bec96fd774c63024038006e8be2722.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Nov 2024 16:38:41 -0800
Message-ID: <CAADnVQJ0mPBaVDpLHmHHrV3N3u_7M4D12MiOPv6=-fVSSC=o8g@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in opt_hard_wire_dead_code_branches()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 4:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-11-14 at 16:27 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > Well, I asked whether it makes a difference.
> > And looks like your numbers show that this optimization adds 101m to 11=
6m ?
>
> No, it does not make a difference for dynptr_slice:

Then let's not do it. If there is no observable performance
difference there is no need to do it just to make selftests shorter.

> > > - The patches #1,2 with opt_hard_wire_dead_code_branches() changes ar=
e
> > >   not necessary for dynptr_slice kfunc inlining / branch removal.
> > >  I will drop these patches and adjust test cases.
>
> The 101m -> 116m is for inlining w/o known branch removal -> inlining wit=
h branch removal.
> (With 76m being no inlining at all).

Not following. Which patch # does branch removal then?

