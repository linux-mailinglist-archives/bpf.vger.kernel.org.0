Return-Path: <bpf+bounces-36626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EADC94B33B
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 00:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CA3B230D6
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 22:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DA815534E;
	Wed,  7 Aug 2024 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpTHB5Dm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEDB1552E0
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071061; cv=none; b=ZSk0Dg2Old16GwRgwlH/HiaduWpsHEXdbThDbzOKUVMPSkMaxNYg6I9P1KJM34iwwCuPShL1hek00RceROhcA/bADe5niu+Bk2Jd0BX2s8KI/Uood4Dx6yP0w55BvcsYLZkqiKwpehFodYf6WWiRgJOV8ocB0GBcQZUnFL04Z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071061; c=relaxed/simple;
	bh=UtphrBzvqJXXJjIhBcE9p0q9wYiK+RGCp7cJLVdlEJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xc44yJjCwggDrNICyWTto0zYpjyz3A93aVkxMCkNVXg+OPvS4NGrN5gs1C1VYTu8GWwFXH8l4ov/ejoMWcrJQsfxk9rNeYoGVD68cRF0EYZszISf8SR3UjU8m7U+MaeC2Tt+TpG8tGbOrHnPmQ2JjCIk3Cy6VxFkh6lqKicfWlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpTHB5Dm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72E2C4AF14
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 22:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723071060;
	bh=UtphrBzvqJXXJjIhBcE9p0q9wYiK+RGCp7cJLVdlEJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UpTHB5DmB9eA6WhzvKAXVac7qAXmFPyqSguXMZRLCC4O7t3pQCZVtZTbXJFnU6/nK
	 Cm2wm9vThUOgSKnf9n97eP//YT+6wjwLZOKmPp36BN0iG3aY60m131wKNd38f1avJ0
	 xw2qIG4yfalahpoAQMFqE1ylVkjjVdDh22kMtC/h+COgERZCoSqUaBlg3BmLkveb87
	 TC0MvrTWmYZWfVexlB5AFWs52a+eUZgPvaxfw6xAZIxbSZmk9zKwdZlmWRxenCZ+wI
	 Lgdd3Yhi1Oez2P42dGze9N9R8VAl+Q9fZMK/bUbBl8AoJLZxBQ1m3kiw54lY/DIE1o
	 J6BVSL7JW3bow==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so407943a12.3
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 15:51:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9YSx7Z2hvawncR9Hq8dANV88aOIJosJa/nam3AVPRMvO0nSte0BEjfLQQa+P0enKz/ouv7R27Ey16oD6xl1McTEPd
X-Gm-Message-State: AOJu0YxVUd4Q49RKsXeTxf5edkR2OPQZGuUlBexqZtUZGFHJMrnjKCpa
	B0ULxX4A1/cDtOHGlinb1Vl0Dv0KUl/mmwginuC3xthdU64/yVjG7muq26xH6fmxlFYdL8ni3m6
	TwJ7M8PAGYFw6RvYpQy/5mFMylsBnauXwYi/z
X-Google-Smtp-Source: AGHT+IFOAu+VzPCvgFysFohD2qY0UPPjDZhDacNPBybmoSWJ8PdIDqgE+7JswX79ujePBklu0k49RofXBFwMna53qbM=
X-Received: by 2002:a05:6402:90e:b0:59e:65d1:a56b with SMTP id
 4fb4d7f45d1cf-5bbb2350e95mr127350a12.34.1723071059202; Wed, 07 Aug 2024
 15:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com> <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 8 Aug 2024 00:50:48 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4KSokE296UdNmV7D2EzdE4762EOdT48akB2+3+JPTtsQ@mail.gmail.com>
Message-ID: <CACYkzJ4KSokE296UdNmV7D2EzdE4762EOdT48akB2+3+JPTtsQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Paul Moore <paul@paul-moore.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 12:45=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Wed, Aug 7, 2024 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Tue, Aug 6, 2024 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Mon, Aug 5, 2024 at 10:20=E2=80=AFPM Nathan Chancellor <nathan@ker=
nel.org> wrote:
> >
> > ...
> >
> > > > For what it's worth, I have not noticed any issues in my -next test=
ing
> > > > with this patch applied but I only build architectures that build w=
ith
> > > > LLVM due to the nature of my work. If exposure to more architecture=
s is
> > > > desirable, perhaps Guenter Roeck would not mind testing it with his
> > > > matrix?
> > >
> > > Thanks Nathan.
> > >
> > > I think the additional testing would be great, KP can you please work
> > > with Guenter to set this up?
> >
>
> Adding Guenter directly to this thread.
>
> > Is that something you can do KP?  I'm asking because I'm looking at
> > merging some other patches into lsm/dev and I need to make a decision
> > about the static call patches (hold off on merging the other patches
> > until the static call testing is complete, or yank the static call
> > patches until testing is complete and then re-merge).  Understanding
> > your ability to do the additional testing, and a rough idea of how
>
> I have done the best of the testing I could do here. I think we should
> let this run its normal course and see if this breaks anything. I am
> not sure how testing is done before patches are merged and what else
> you expect me to do?
>
>

I am adding the bpf mailing list to trigger the BPF CI. That should be
another signal, that's how the BPF tree does its testing.

https://github.com/kernel-patches/bpf/pulls

> > long it is going to take would be helpful here.
> >
> > --
> > paul-moore.com

