Return-Path: <bpf+bounces-41951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9A299DC82
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9039C282749
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59CC170822;
	Tue, 15 Oct 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="comO8PZc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4DF16D9B8;
	Tue, 15 Oct 2024 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728961190; cv=none; b=olTgLPQj569d0cawMdyidC3y9s1UVVplrtixKXk8ZyiC+HZiWLV+rDfy8FTeAUykueHso75hCWZYpBDTJRNhbVs2wDdRQahnk0evr8Li/pTlaM0j3aLSxhwbJFHqzV0cNAxzx2s6OsK8L8SpqiNGdJqecsf8rLUhXmkOJL6yfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728961190; c=relaxed/simple;
	bh=JIRktSi1wenf129rZn4Cpx3GIMjbDkSGAyjUQO2Ow8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqAibuR0/u3hgHfG1xJfgS0UgWRjA8fntnD3LRQwfV3TgJ86AD3v65/ICXu2sIpu8mBHHdRZYYqb49H5iRHLnc3EfTQc+wSfE6H7WUeRIfP2AWWpCoLImA/26joYjPrjUrYvZrULAtLtN8AzZeLUIUtyvng1l2q6k+X39qh+wDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=comO8PZc; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-836f1b47cdfso234111239f.0;
        Mon, 14 Oct 2024 19:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728961188; x=1729565988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlDuMaX6asclzSXbxmK+YasdoLKhj5Cnjwj3mRx4sC0=;
        b=comO8PZcTZGVXAuDVtNpkhEN7sJilLQqNpqPAZvOvoqL5Mc+339PApi9vMZZqH8DzQ
         XvAXD8n3KZuz1kEDaC5TUdUG4r95PcignYVckx6Yghb/thc6fvmN67ukxJA89VEDHJ04
         iP2s/lXU5EcnmCN9nZp/hyz7FggH0Ts7qvP8+4hajGSTCo1JsNEacmAAv0vr71V2SjCi
         pcl0VQzENpEQN0/QkWIa+eHjVL5DefGe+kg5nbzOwxQk5iYIcIFJtWZTx3QYcnq1Zzdh
         3w4dvik8c+HtwseKnTV/FDh915XsFroug6SdQEVDMjjsiS2WA76Z0LOpL5BCddfcUA0V
         0e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728961188; x=1729565988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlDuMaX6asclzSXbxmK+YasdoLKhj5Cnjwj3mRx4sC0=;
        b=aFiPMHyiYc4X1pEcqoJT6R5ID5/+0e4H5Sh3kF+SgxQtJDA8VPjMcm0btfDjHSZkvl
         tpgFfKKaFW8NyJuDOxFqsutOPLaY2rQ5fZoXiCqfdFVqfEEdpO118uqHKtQeSTAJq7G+
         WQOC1v0Vuh+xfXMcnQhLAiQ9G66uaLyQrP2yob67oreRYZi5hQm4t+D5fC/E/sZjABIQ
         LKEaasnjZamhN5MtyX+OvXSUQJpUHKhgpxfdd6x9dCCWwGb0KKtlk00jQ9crrL73Eh2B
         jHo4soGjiiYTRmzilm7XNJREmuIEhNHiW4MUm5ImgMV4j4kmn6XfY7NXUTpGhLQjAEPl
         RQFg==
X-Forwarded-Encrypted: i=1; AJvYcCWliOy5R+78dEUq111r6GkJKOOWKduuTAknHB651GX5pfhDcapePfUV0RJVMa8V5hm1vAs=@vger.kernel.org, AJvYcCWstuQF8hwK5rBc6wQfk1sgPlRtIoMa5Msoz2FUiSDxLPc8czwpHx/dpqIqFDwU/TJ6qB6J3W/6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuv/zyKIAlmcvb8saUXcVNCFxQzz0nDcilckFOauk3bhKwRbhV
	0vy1mlyoRI2IK4NswihjSkCfnl+akgqa6wpswv/3hdFNvcbClFbl6sDM9I8ETzClfqkT8i2XAdk
	cGXGKqEm08hEDPNV43Pgt76x5bzY=
X-Google-Smtp-Source: AGHT+IEjZ9MYshfLSJfbPZmzDx0nsxgBUoM0EHBrBZNGTR8Cgn0pPsyrKndAJbpjROOIvdoX5v7KVxE3GAuUDopL+94=
X-Received: by 2002:a05:6e02:188e:b0:3a3:afa3:5155 with SMTP id
 e9e14a558f8ab-3a3b6050e70mr118275095ab.25.1728961187852; Mon, 14 Oct 2024
 19:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-10-kerneljasonxing@gmail.com> <670dc78cf28c1_2e17422947f@willemb.c.googlers.com.notmuch>
 <CAL+tcoDAGLXsqRb4c-hbtE3a38KQHz9jh-p1tKMkWPMKferQ6g@mail.gmail.com> <670dd59de9a73_2e58fb29464@willemb.c.googlers.com.notmuch>
In-Reply-To: <670dd59de9a73_2e58fb29464@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Oct 2024 10:59:11 +0800
Message-ID: <CAL+tcoC0uswOYnprNzUK7AN8frC7qReNs3ADkE4ctpySQRrmkA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/12] net-timestamp: add tx OPT_ID_TCP
 support for bpf case
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 10:38=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Oct 15, 2024 at 9:38=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
> > > > from each sendmsg. We only set the socket once like how we use
> > > > setsockopt() with OPT_ID|OPT_ID_TCP flags.
> > > >
> > > > Note: we will check if non-bpf _and_ bpf sk_tsflags have OPT_ID
> > > > flag. If either of them has been set before, we will not initialize
> > > > the key any more,
> > >
> > > Where and how is this achieved?
> >
> > Please see this patch and you will find the following codes.
> > +       tsflags |=3D (sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] |
> > +                   sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);
>
> I saw that, but it's not a condition that stops reinitializing. Which
> I think is the intent, based on "If either of them has been set
> before, we will not initialize the key anymore"?

Yep, based on that sentence. If we find sk_tsflags is initialized,
then we will not do the same thing to sk_tskey again when we use bpf
method.

>
> Reinitialization is actually supported behavior.
>
>                 if (val & SOF_TIMESTAMPING_OPT_ID &&
>                     !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
>
> But the sk_tsflags bit may be repeatedly set and cleared.

This line "!(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {" was removed
and replaced in the new function sock_set_tskey(). So it could avoid
re-initialization.

>
> Anyway, the current patch sets it if either requests it?

Yep, either of the ways (bpf and non-bpf) can init it.

