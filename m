Return-Path: <bpf+bounces-22870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DC86B0B1
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F628C4F0
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 13:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F114CAC3;
	Wed, 28 Feb 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W48iyThQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9D73508
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127938; cv=none; b=WZWporj6iugVBm0EHTG4N+OpaNrpT+o1LzaEBe41i1l9d3ddA63MBR92nNCBQUGWMa5H0xhFflmu2G68iy0kOC/f0RtWQ5f7XpfsQlcZtBd5nyvqXXGoVWPXjbt3umU+EZxKYUzbjo2Lm1Zf1HwgHHx1LbaMZAjHf5xUwalA6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127938; c=relaxed/simple;
	bh=G9Fy+A863ejkKPrl0P8fUjyEghnPOY8sVmU8rGd4vXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GTRGNFvBE8J5e0C+LWh1ol3tzVCuk6pNgEpvzi67rQvBlhvIpHNu/0lhEixTkCSwqtudji1VNZecCHGSH9X03q6hBdELPL59fkx2iXppJKGRDxqTmTsQqcuAFEl43RS8kRGWzTmc6hSaC0k5NBdeffbymvpAlDyI7gaPKAjtvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W48iyThQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512aafb3ca8so5507967e87.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 05:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709127935; x=1709732735; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tQfHJBmx76SvCgaks1mhQmioyNO6ktFYtDpDYZnPSlk=;
        b=W48iyThQUyrv3loOq3NH7NFaPpjNgcajKC4QeBasbCE/SgYhWfNVSaYAszhRqd+qqa
         QXiVeuZhdKqllIh8JUWrTWWTbkSIu8BNR1RCKkGNZ07sj2nY6CwE9hXB90BUThx+Y7u8
         A3ThiDgiPv1HRriRTKf8BMdSpR8qqmmFge9dBa6iw0m4JxR9FZgm4YgaAo60MMmauHTF
         u1arsoMyCxxczS/WvmohIRrr3aC+uSr9/UV8Iz45njUiPV7KaiF4IWoWyjJfUnwAu7Qv
         VUWFEzYSj9BGZ12mRKqPHvfe/SbiJbWxrQ2LMitUJfQ5BqsJx47JMqRI2lQ4j9ZBcyZS
         3UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709127935; x=1709732735;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQfHJBmx76SvCgaks1mhQmioyNO6ktFYtDpDYZnPSlk=;
        b=RYJ0QaEvp4i4QLHlKg+V7JyuuPcLujoTW8thLAcVzb89uJl+enSqzb8T8mWSAm+EFj
         pcXsIkfpiwHCPya5ztdSW6gcO1nG/NwnPXGWQUICl1S8WvyyTX4Km7M79HeWknkLwipR
         mGA3qRJ/ewsZX2dpETeu2ApOzGE76BU9LTQVEHbKK+VgXxYVwLJt559YDsyuMU8wLhw/
         zltw1GHyhwjO9vi+L31CD2PuOZ8HgJirtsITmVQhU7NiEN6Mmp7FpYAIVf2N1ffONdMJ
         Z9hopfiAfK0RX8jbgA5f1injv0AjhZ8HogNXTF1G7KyFGnlnuEJpZrId2IZzYPc8jWkG
         lzMQ==
X-Gm-Message-State: AOJu0YzMiAS4airjPQAUlQ5XKYCnl1oq6NXRi/3rAstwAYjyh1Bn5BXM
	j7bmigYsEbYzavl+mPG9Wxfc/mDyuR+pWR36UjfLqpFScgm9T/Y8DxCzhRXlF4Y=
X-Google-Smtp-Source: AGHT+IEBQSJy7ZUdUnxXUcoc7nhSJzBKKVFWVtt+ov8tpU817HGMtuJVcG2QkaI894fBkxthJfZwYA==
X-Received: by 2002:a05:6512:3091:b0:513:1b42:b204 with SMTP id z17-20020a056512309100b005131b42b204mr1479561lfd.29.1709127934703;
        Wed, 28 Feb 2024 05:45:34 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b2-20020a196442000000b005129cc0b2e1sm1601779lfj.71.2024.02.28.05.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:45:34 -0800 (PST)
Message-ID: <3adabe7a7e45404bc7ac2778b6a00e13631094f2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_can_loop() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@fb.com>
Date: Wed, 28 Feb 2024 15:45:32 +0200
In-Reply-To: <CAADnVQLd7MaY4r8EauhnbKS6vxTRv97cXj7+jUtXwQxLdqNK-g@mail.gmail.com>
References: <20240222063324.46468-1-alexei.starovoitov@gmail.com>
	 <53cc7e1fea7efb557cd4d65fdff5642c0047f255.camel@gmail.com>
	 <CAADnVQLu0xzEuxfJ=6HU5yGv02Gf0Vud3X9LEOvK6AMzx3vAuQ@mail.gmail.com>
	 <971cbc8e82a3bcf93e4f30d5368a293017f3fa83.camel@gmail.com>
	 <CAADnVQJDuFn4R1TTsgcom5Dos7criW9ZD3qpAp4zga1m7tNHGg@mail.gmail.com>
	 <CAADnVQLd7MaY4r8EauhnbKS6vxTRv97cXj7+jUtXwQxLdqNK-g@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 22:30 -0800, Alexei Starovoitov wrote:
[...]

> > > I meant that this helper can peek spi from R1 just like code in
> > > is_state_visited() does currently. Forgoing the 'meta' completely.
> >=20
> > I see.
> > You mean removing:
> >                 meta->iter.spi =3D spi;
> >                 meta->iter.frameno =3D reg->frameno;
> > from process_iter_arg() and
> > 'meta' arg from process_iter_next_call() as well then ?
>=20
> Ed,
>=20
> That was a bad idea.
> I tried what you suggested with
> static struct bpf_reg_state *get_iter_reg(struct bpf_verifier_env *env,
>                                           struct bpf_verifier_state
> *st, int insn_idx)
>=20
> and implemented in v2.
> It's buggy as can be seen in CI (I sloppy tested it before sending it
> yesterday).
> I'm going to go back to v1 approach.
> process_iter_next_call() _has_ to use meta,
> since caller saved regs already cleared by the time it's called.
> And doing fake 'meta' in is_state_visited() is not a good idea.
> It took me a few hours to debug this :(

Well, that is unfortunate, sorry about that.

