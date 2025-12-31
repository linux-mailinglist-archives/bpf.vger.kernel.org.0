Return-Path: <bpf+bounces-77634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB9CEC7C7
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1743830145B3
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45892D94A1;
	Wed, 31 Dec 2025 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgMbazYD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB9125B2
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767208551; cv=none; b=XvrYJE41Gv36/QKgQSW7R/YmiOUZe8cTF/NJqFrcAn58oxuvNVg+CBagTCks06j9TQahDmncGxNdG8Vzy/KpGCyw2Nfl5pZkXuCzzdUZMjnNzM031YWLvRy6iU4vgMjQbOKTlZp9P8OvKWorfRIHQc5V7sy2q66zMptrBK/6+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767208551; c=relaxed/simple;
	bh=fsIEU7w8UZCgKCluKcbI6AQ8M6KvbQrOWzM8ObPU5hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjc5NZmVtRzF/dTXVRLZ2x9KlEgAMs+JjzE969W028ESu37rpnuKGqH9jScsSz5ODBlFAa0Du41ZFfhZikf1IG3o6na0UbWiPQeU9ilxH+iwcN60nGREzwjsI38ycxLzkbmgF1NQIY2g6hPKYE0f9DH2uCeCtfPd+qPR8yVtwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgMbazYD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b832522b47cso682564266b.0
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767208546; x=1767813346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsIEU7w8UZCgKCluKcbI6AQ8M6KvbQrOWzM8ObPU5hY=;
        b=SgMbazYD1BoX4uc18nmBlTTXIZPbcHTBqAkLs4o4jfZXRnKwVNk0gGQVnbGwAbjV7Z
         JxbhvPvLZYV7tF6PJ92gkLiDUx3Un1S3wBmCb8RSHb1BcvPeQVtw1npBnZeDKg6Hx/hV
         /Tl/8muSb7mXZ5QKhKu8zalf3npMsLyh9XOWZCUWYFJP7Ffc69ROzrz7ww50YL3HfWdk
         ZYOGxymkBZRJmsaHmX2Ph10l/Wc0gqRSGpV3xwuFFMgVOJUZFk2yS1uDVoI4EmuU1b6p
         lbG0cY0lX13Dxl/xIzg65sJzP0+2//UzyxI1UipFBZkumczzAuP9vvdR1YXL0s5cKs5d
         KoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767208546; x=1767813346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fsIEU7w8UZCgKCluKcbI6AQ8M6KvbQrOWzM8ObPU5hY=;
        b=F1UL7FzL6NX5ujjoxNuH/uZfiBuf8lCaH23vh6vmsvO+oWY0NAFVgvuHLM7BesedSL
         jNhIOuEr9hoXNLZF54hwsQ1mvGUnT5sbBTKMzZDKbNcy7GRWxHahnWmIKO3aPQMU3vLb
         z8MslzBmTNXnrCVVYBOsBUbrCpGAX+dsXQFxVf7q4xKo2/IiSTLy1ddwYt/XaZldOpMl
         EVPtjPqDgsNdckp2pGMwI4p1saoSHdugKk+TUO41NOzvPDmwyu6TFZy/kfepZJA/yK3Q
         sXXOU2sd053ijCaQSaVpr0s4xFM6HofWYwxDFeNBsOmJQAdeOD6PxDfWkJ3enuirnm3o
         rnnQ==
X-Gm-Message-State: AOJu0YxoRTAaIt1Ne6FMzmoZOUTKDwZG2K8KFK4B5IAIOF6M/OLresf/
	CEQfwzOwKQYeo3HU3ahetLoG4OaFWGxqsZ5ZyYOjCOYPo78alCjv3cvwCfHnarM6InB3ptRehfh
	FXuvqRCqiItMhCc9xjMSy7phDatf4fBQ=
X-Gm-Gg: AY/fxX4a26x0K8voCT18uFxUI4fqdY7bw7vnK0qhbb1Sq+OcmBXRbuMcNhrvZMegN3/
	wCp1zbKQ2Rz7OvQDXxmad1owfHF6rQAdsUBBcElm08Dx7hmC1N9DqIQwfLlsdaQgedFnym3Rimj
	okIoSp3Bl4Wn3fXh1t7j8kOc0gSKlQ55tJ4vzUGSfOqMQoYUBMAGokBPEDvouPkFuUfvgvkZmgB
	lJNrbEasjkKLOaSGJj5JRPKbA3k1FgqGw1sY0jpNGmDSoDxxrpkwnVZXg2Uba0DoZkZle+JiXD/
	g3rj2weedyA=
X-Google-Smtp-Source: AGHT+IFhlJmEUrFTJiznD+MXkTaxBXgNgslXkglAIxCq9af+/B2QD4GC/QemT+f3oeBD3GiUcgSa5kma52qRNRPDQos=
X-Received: by 2002:a17:907:6d22:b0:b76:5b73:75fb with SMTP id
 a640c23a62f3a-b8036ecdbfcmr3595335166b.9.1767208545958; Wed, 31 Dec 2025
 11:15:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231171118.1174007-1-puranjay@kernel.org> <20251231171118.1174007-2-puranjay@kernel.org>
 <c1204513fe4da235d6b6b45eca9d0260a31e89ec.camel@gmail.com>
 <CANk7y0js_-wvW281NAbr2eaCmvMxBAyCDd0wtdf+7XGKKRxEVw@mail.gmail.com> <49cd9cf5a600e240e2ebea8098e25026688b4cb8.camel@gmail.com>
In-Reply-To: <49cd9cf5a600e240e2ebea8098e25026688b4cb8.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 31 Dec 2025 19:15:34 +0000
X-Gm-Features: AQt7F2pIsLgqGtILWzWMV5gBoqVatno3g7w457LhNGlO-dpe9NB_76nTwupRqsc
Message-ID: <CANk7y0iw4rUnKPgCAirsjHFJZm9TGj_LgFnaCytMBN-Z-xjzyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Make KF_TRUSTED_ARGS the default for
 all kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 7:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-12-31 at 19:00 +0000, Puranjay Mohan wrote:
>
> [...]
>
> > There is another aspect I want your opinion one:
> >
> > Assume a kfunc returns an error when you pass in a NULL pointer for
> > some parameter, it checks for NULL as if it is not valid usage, it
> > returns an error. After this change, this kfunc will not return an
> > error at runtime, rather will be rejected by the verifier itself. This
> > should not be a problem for real programs right?
>
> Yes, makes sense.
>
> > I think we should drop the second patch: "bpf: net: netfilter: Mark
> > kfuncs accurately" because these kfuncs have no real use case with
> > NULL being passed to them, only a self test tries to call them with
> > NULL parameters, I think we should change the self test to detect
> > load failure and leave these kfuncs without __nullable
> > annotation. What do you think?
>
> Actually, I was going to ack that patch :)
> But you are right, each of those kfuncs is a wrapper and functions
> they wrap, like __bpf_nf_ct_alloc_entry, require 'opts' not to be null
> or return an error.

Okay, in the next version I will drop that and fix the self test. But
this will be a change in behaviour of these kfuncs, I just hope no one
is passing NULL to these kfuncs for a weird real use case.

