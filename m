Return-Path: <bpf+bounces-1469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D785F7170F7
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 00:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766A91C20D7C
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 22:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7399034CC4;
	Tue, 30 May 2023 22:49:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64228C1D
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 22:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B243FC43445;
	Tue, 30 May 2023 22:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685486945;
	bh=0IuCc4ZXrqDomHpXWfXNUBxYgu4rnYtwWDypsa5wpHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ToGdzQYh7c7TbK+h9+ubtH9qr/elwlZQG/3NYRfX082sGoMBsCwx23XrscWImkWox
	 0H3+IA1U/mz/QipP+b7iDaz+bjF8tvdVSOtqy4gO1r6QLVQDpGrcV95+DyHGp8KCR+
	 g7FE4W91vlKlO4n59v/McfXuWiG71ZnV4kqdB0bDVHX4RU0JMtRJe2oJIejvFszrcB
	 ysymo8H4CDRWrYY0H4O7bbz0PYQaJDwjz0LYpTwXLZLzBTubECx0b1qd1Go65KPzOe
	 QFBWt4tMZACr6TZXIvGAEM4DUkfhTnMtrPIpk8hpsFb216y3P4eKfrcKowMz1HSAOQ
	 5jGbba+laAHOQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f3a873476bso5674739e87.1;
        Tue, 30 May 2023 15:49:05 -0700 (PDT)
X-Gm-Message-State: AC+VfDwpoJGOdxTZ8XA8vlVzBQfijEJ9VNCptQXUCE6jrejVCzNpDoaQ
	h134rD0dAKXwn7A6qMP0dlOnBbBfKIh1jgzQeQQ=
X-Google-Smtp-Source: ACHHUZ4bS0pN0vhbRQKYMialN1rGp+sHGugH3oihIijRD7zIcsyEyoMPZ5BwCJlvbUjzUrKdEXQxN6fKuKVldz1ZhpA=
X-Received: by 2002:ac2:46d8:0:b0:4ea:fabb:4db1 with SMTP id
 p24-20020ac246d8000000b004eafabb4db1mr1442400lfo.1.1685486943732; Tue, 30 May
 2023 15:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230526051529.3387103-1-song@kernel.org> <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com> <ZHTuBdlhSI0mmQGE@moria.home.lan>
In-Reply-To: <ZHTuBdlhSI0mmQGE@moria.home.lan>
From: Song Liu <song@kernel.org>
Date: Tue, 30 May 2023 15:48:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6hqzLuNhvkHFOmKTJdQm8A0JdUna=1iFdRC0y+kKmF4Q@mail.gmail.com>
Message-ID: <CAPhsuW6hqzLuNhvkHFOmKTJdQm8A0JdUna=1iFdRC0y+kKmF4Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Type aware module allocator
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mcgrof@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, x86@kernel.org, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 11:25=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > I don't think we are exposing architecture specific options to users.
> > Some layer need to handle arch specifics. If the new allocator is
> > built on top of module_alloc, module_alloc is handling that. If the new
> > allocator is to replace module_alloc, it needs to handle arch specifics=
.
>
> Ok, I went back and read more thoroughly, I got this part wrong. The
> actual interface is the mod_mem_type enum, not mod_alloc_params or
> vmalloc_params.
>
> So this was my main complaint, but this actually looks ok now.
>
> It would be better to have those structs in a .c file, not the header
> file - it looks like those are the public interface the way you have it.

Thanks for this suggestion. It makes a lot of sense. But I am not quite
sure how we can avoid putting it in the header yet. I will take a closer
look. OTOH, if we plan to use Mike's new allocator to replace vmalloc,
we probably don't need this part.

>
> > > The memory protection interface also needs to go, we've got a better
> > > interface to model after (text_poke(), although that code needs work
> > > too!). And the instruction fill features need a thorough justificatio=
n
> > > if they're to be included.
> >
> > I guess the first step to use text_poke() is to make it available on al=
l
> > archs? That doesn't seem easy to me.
>
> We just need a helper that either calls text_poke() or does the page
> permission dance in a single place.

AFAICT, we don't have a global text_poke() API yet. I can take a look
into it (if it makes sense).

>
> If we do the same thing for other mod_mem_types, we could potentially
> allow them to be shared on hugepages too.

Yeah, that's part of the goal to extend the scope from executable to all
types.

Thanks,
Song

