Return-Path: <bpf+bounces-10519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D377A92F7
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60204281800
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FB88F67;
	Thu, 21 Sep 2023 09:13:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18948F55
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 09:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1606AC4AF5D
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695287593;
	bh=fvuvrEMuWsS5n+aGsOLqfaD8qATP5Zo1Pwy194y+UDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VFxR0Xm8lppYnQc2DtCt1zAm5qI6gc/hWD0XRDNpCZAs9ziVTFOyyXXkU+P2VHSyj
	 iwm8MY2+VYo62YZOWN6PWor/JAy+6dMyJRdek7FmicgqySk3NnOSxj05b4e9byWw5S
	 RRhJbKCq6x8QXpV0EuklENVbbc/9drRusGfcLg9Yqz3dAeseDAK+s98oZZCLjrmZxH
	 OIJgt+zR5lkX0wGK+qXf//4XHKZSTCNm+5OU1knD8bK/ZATpSQrk8KBJAlkdruMt0g
	 Obp26Jhtifq2XU1au7UIb4NNC0RgDBHL9z+t29rFlzNz0dLCFFRy5DWquyzbWrKiE7
	 ITE5bZFmY9IIg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-532addba879so1451572a12.0
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 02:13:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx12vRwXeK08Qk1aKznB76Da9oZeIwl72V4JxmIvEE9Yhmq1fuy
	oAXjqe71MO3izr9utKOwMvIY3JKKjj9UIM34Mg6Acg==
X-Google-Smtp-Source: AGHT+IGZs/JgRQZYIsXmekaViv2Yqk40SAdhhYWpZYRBrN/Or5FrzsdIHPGeTx7ga8VqEmC31rT+zYyKvF9U0OGRTnw=
X-Received: by 2002:a05:6402:1205:b0:522:582c:f427 with SMTP id
 c5-20020a056402120500b00522582cf427mr7511577edw.14.1695287591558; Thu, 21 Sep
 2023 02:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-4-kpsingh@kernel.org>
 <202309200848.7099DFF1B@keescook>
In-Reply-To: <202309200848.7099DFF1B@keescook>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 21 Sep 2023 11:13:00 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7RvY7xpF0HjxR0nKFzGmuUyHD1A-Pc1-ChHy94tHbRjw@mail.gmail.com>
Message-ID: <CACYkzJ7RvY7xpF0HjxR0nKFzGmuUyHD1A-Pc1-ChHy94tHbRjw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 5:54=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Sep 18, 2023 at 11:24:57PM +0200, KP Singh wrote:
> > LSM hooks are currently invoked from a linked list as indirect calls
> > which are invoked using retpolines as a mitigation for speculative
> > attacks (Branch History / Target injection) and add extra overhead whic=
h
> > is especially bad in kernel hot paths:
>
> I feel like the performance details in the cover letter should be
> repeated in this patch, since it's the one doing the heavy lifting.

Good point, added the results to the patch as well.

>
> > [...]
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Regardless, this is a nice improvement on execution time and one of the
> more complex cases for static calls.
>
> > -struct security_hook_heads {
> > -     #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> > -     #include "lsm_hook_defs.h"
> > +/*
> > + * @key: static call key as defined by STATIC_CALL_KEY
> > + * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
> > + * @hl: The security_hook_list as initialized by the owning LSM.
> > + * @active: Enabled when the static call has an LSM hook associated.
> > + */
> > +struct lsm_static_call {
> > +     struct static_call_key *key;
> > +     void *trampoline;
> > +     struct security_hook_list *hl;
> > +     /* this needs to be true or false based on what the key defaults =
to */
> > +     struct static_key_false *active;
> > +};
>
> Can this be marked __randomize_layout too?

Yes, done.

>
> Everything else looks good to me. I actually find the result more
> readable that before. But then I do love a good macro. :)

Yay!

>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

