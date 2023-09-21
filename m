Return-Path: <bpf+bounces-10589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E77AA183
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4AF1F2177A
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646D719461;
	Thu, 21 Sep 2023 21:03:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6F19455
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 21:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669BEC433BC;
	Thu, 21 Sep 2023 21:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695330189;
	bh=r/TuVwhFEKZ1B76rwCgQnAm3JwMxBYE1VXH5aaXkqaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j9r2z+QcoMDPv2JPJG8Fzt7R4YK/AHv8eHhE9U1uCEKOA+WlTlBfI+3cNV9iuI51n
	 nbi9rTZJMF+l1hbc6q1lisjrNtRsekNMsGamJPa19TsAd9sk8jODwv6N5GKpihqi3Z
	 mlJn+czW6dDCX4efC1t/Lxcr0F1Dn5u+2PpuXrIjQ3v1RNRKd8tR4wAbZG6P/JiK7X
	 dieubIWZusR0G4IuuMjWBD53PYdB+QMwhd8wedw3cVsPlW8KTlz3l/9YSYHSqvaTrL
	 zOTNTBVNxDP07IsraayrEiPjkN5jOKvQZ9UBRodkijgLZymLHS5qsXL54jVw93nZpo
	 DqX4had54i+zg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5041cc983f9so2357997e87.3;
        Thu, 21 Sep 2023 14:03:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz77iOlJd+4HI9AJtrxOCnqQP8sVXj5wwuptZmHb1YMMp4Isywr
	rm8Z82jbUK6mKXM6BWqllS8TOFlmdF8I85Gav0o=
X-Google-Smtp-Source: AGHT+IHz8CheoTemwEiDYUng4ktMyrjZOWh9lP8YGpmkHUyyPvZ6qX/GPpvEFNGg4XNKgJseNBFPDQysQfspMYoSNKA=
X-Received: by 2002:a05:6512:4002:b0:4fe:25bc:71f5 with SMTP id
 br2-20020a056512400200b004fe25bc71f5mr7334207lfb.11.1695330187609; Thu, 21
 Sep 2023 14:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-4-kpsingh@kernel.org>
In-Reply-To: <20230918212459.1937798-4-kpsingh@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 21 Sep 2023 14:02:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6R=h=BZr8ROTYifrG4errZ6KNLiJV0885-a8_r=+ni-g@mail.gmail.com>
Message-ID: <CAPhsuW6R=h=BZr8ROTYifrG4errZ6KNLiJV0885-a8_r=+ni-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 2:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
[...]
>
> While this patch uses static_branch_unlikely indicating that an LSM hook
> is likely to be not present, a subsequent makes it configurable. In most
> cases this is still a better choice as even when an LSM with one hook is
> added, empty slots are created for all LSM hooks (especially when many
> LSMs that do not initialize most hooks are present on the system).
>
> There are some hooks that don't use the call_int_hook and
> call_void_hook. These hooks are updated to use a new macro called
> security_for_each_hook where the lsm_callback is directly invoked as an
> indirect call. Currently, there are no performance sensitive hooks that
> use the security_for_each_hook macro. However, if, some performance
> sensitive hooks are discovered, these can be updated to use static calls
> with loop unrolling as well using a custom macro.
>
> [1] https://lore.kernel.org/linux-security-module/20220609234601.2026362-=
1-kpsingh@kernel.org/
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
[...]

