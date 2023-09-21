Return-Path: <bpf+bounces-10518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422FE7A92DA
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 10:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1FD281803
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173268F63;
	Thu, 21 Sep 2023 08:53:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F38F55
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 08:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A28C2BCFE
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695286409;
	bh=yWOM98GrJUSl/51rD4fzrw/49rcFITI86C4+kaaw8lA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HswWjIdiL0FJ2BzSTQcfNhVEUsrZxCUmCJWXTl1y418/TWIWZEDnurJOSv7Q2F+ZH
	 vNvW7yK6lOjwgi/zeB5ggItUhhvva1jMthuTwjvD9Q4LTwUyidx3ZCpIgqVQDLGWM9
	 oPjfufdXRo+mRPXvXCmAPcF/mvIUSWIJo0PnI5crbeduzaReDECxJOVLkGPJDCjLwE
	 p+LvE7wOub5NIdbds03ZtRqZUx4j7jmolgkjwNjfBG8LbI3FB2F8fjYF3iZ5ms1rP6
	 Tc2JvYSVq3a9lwA/khojl4+Gep5vlYxKcAcGPPCtn5k/E/S7vQJLp1Lhyn2mGxWlJM
	 8EM+4xaCU0mbA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-530ce262ab2so682632a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:53:29 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8d1Zaaqlyb9n3oKj0wDsdzBUC4jTbwz7GHtnYo9DwXIpP8M24
	yRrgkCti4QEIhcLWbYLlYX63dxGSpoB7hKwghSrfWw==
X-Google-Smtp-Source: AGHT+IFODSX0/bLsjx987uQ54fAeDFKQvhKE55UvUQ0zcQvqwsDaNR5e0PTrcMAcc47n1yRlUIq3R8O5zVXOKtRTgQo=
X-Received: by 2002:aa7:c547:0:b0:522:31d5:ee8e with SMTP id
 s7-20020aa7c547000000b0052231d5ee8emr4474297edr.8.1695286407631; Thu, 21 Sep
 2023 01:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-6-kpsingh@kernel.org>
 <202309200840.722352CCB@keescook>
In-Reply-To: <202309200840.722352CCB@keescook>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 21 Sep 2023 10:53:16 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7H=3g01T75mV8Ni+9+WrPbFzj1H9zsNhmUGvvuD0JY4A@mail.gmail.com>
Message-ID: <CACYkzJ7H=3g01T75mV8Ni+9+WrPbFzj1H9zsNhmUGvvuD0JY4A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> > +config SECURITY_HOOK_LIKELY
> > +     bool "LSM hooks are likely to be initialized"
> > +     depends on SECURITY
> > +     default y
> > +     help
> > +       This controls the behaviour of the static keys that guard LSM hooks.
> > +       If LSM hooks are likely to be initialized by LSMs, then one gets
> > +       better performance by enabling this option. However, if the system is
> > +       using an LSM where hooks are much likely to be disabled, one gets
> > +       better performance by disabling this config.
>
> Since you described the situations where it's a net benefit, this could
> be captured in the Kconfig too. How about this, which tracks the "major"
> LSMs as in the DEFAULT_SECURITY choice:
>
>         depends on SECURITY && EXPERT
>         default BPF_LSM || SECURITY_SELINUX || SECURITY_SMACK || SECURITY_TOMOYO || SECURITY_APPARMOR\

I think for BPF_LSM the option would not be y. But yeah I like this suggestion.

>
>
> --
> Kees Cook

