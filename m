Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E753CAEB0
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 23:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGOVnT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 17:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhGOVnR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 17:43:17 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA1C061760
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 14:40:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r135so11522887ybc.0
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1QetJwIGlZUtMvW7mRb7kP22XfUNHvIsgJDu3F1GBs=;
        b=LHifkOl2yd2a9YS6NNk1gT3yD6Cf4G1MfTuw7uLLu7iMbgEcmJEezaWYEIPZLVXujB
         hCMXRez79QbfFH2tGfuDLVfcasJF6SMNiI6z2UH8+QIJDEVixXSqcYcLiK9RVraAvpaS
         4zdRUaLGv0QzAYZ7zp+wKcgEZiUNfisYYdwlyJgJGyLx7SAu92LpxFjYXMhROryEoV6k
         3KuCefKchpbFJ3JwPCYjWTiHZms0lltM6KrDbOsWJ/mMnozZ5Kmo5FVwtyVGygEg7twR
         jXsAP1snHPDOx2llrb9vEyFA81ZzLujxTJWYWTRjS0o8J2kQBYc39/eoOypxbRfFuw5I
         2Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1QetJwIGlZUtMvW7mRb7kP22XfUNHvIsgJDu3F1GBs=;
        b=coXGgJi6mUamEiQWAFT9TJHHbmsDldrvT/jHfH6x1/6eeK0qr2DkzjYNRot87mwfJO
         TgTFGBgPkOSpKstxOtJCTTsmEGtAmbMPa5fV3Csz1ERFEeJWA3e+dHnIEv9Q9QLsqAbp
         MyiamLSc3Ott03WPDpxayjhqKB1/pigPTCdg2sILPqtqhUtHdEhZ/Jf3CmKj40KC9mgr
         sK8Qfa507grCuNHTOR83ckKF7zaQH6LYL/4crjSS1BBILkcArA/l2XqndyErxC20Kx/J
         t8U/qxi5HcOzMbxoeA2JaDxTRnfrK/7YotOpGpjlfCILD/w1qXTkHbRmTYLZ4wJtpSKN
         PZ/w==
X-Gm-Message-State: AOAM5323gBRJNSI7eImZT54A7FvkXA5S3Mo1zQJlEFON+eH+W57nMmR4
        MrFQqzisds5miBhsIm5HDnIEmtZ7tNxY/cK391Y=
X-Google-Smtp-Source: ABdhPJxxY6I7dJLhTxTSEK75e7Rn+cyQdcjZfviZvZXA4r9kzdWEg4fTMgemLVU+95FbhS4TRezdLzwBxKzxESpXkVE=
X-Received: by 2002:a25:b741:: with SMTP id e1mr8393588ybm.347.1626385221925;
 Thu, 15 Jul 2021 14:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
In-Reply-To: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 15 Jul 2021 14:40:06 -0700
Message-ID: <CAEf4BzaMcWGt+eqEqQdpJ_s5Zv80ziCA+vo5fa5HmaZmwBvh6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] tools/lib/bpf: bpf_program__insns allow to
 retrieve insns in libbpf
To:     Lorenzo Fontana <fontanalorenz@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 13, 2021 at 11:34 AM Lorenzo Fontana
<fontanalorenz@gmail.com> wrote:
>
> This allows consumers of libbpf to iterate trough the insns
> of a program without loading it first directly after the ELF parsing.
>
> Being able to do that is useful to create tooling that can show
> the structure of a BPF program using libbpf without having to
> parse the ELF separately.
>

So I wonder how useful is getting raw BPF instructions before libbpf
processed them and resolved map references, subprogram calls, etc?
You'll have lots of zeroes or meaningless constants in ldimm64
instructions, etc. I always felt that being able to get instructions
after libbpf processed them is more useful. The problem is that
currently libbpf frees prog->insns after successful bpf_program__load.
There is one extra (advanced) scenario where having those instructions
preserved after load would be really nice -- cloning BPF program (I
had use case for fentry/fexit). So the question is whether we should
just leave those prog->insns around until the object is closed or not?
And if we do, should bpftool dump instructions before or after load?
Let's see what folks think.

> Usage:
>   struct bpf_insn *insn;
>   insn = bpf_program__insns(prog);
>
> Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 5 +++++
>  tools/lib/bpf/libbpf.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1e04ce724240..67d51531f6b6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8866,6 +8866,11 @@ void *bpf_program__priv(const struct bpf_program *prog)
>         return prog ? prog->priv : libbpf_err_ptr(-EINVAL);
>  }
>
> +struct bpf_insn *bpf_program__insns(const struct bpf_program *prog)

Definitely needs to be const, we don't want anyone accidentally to
modify it (though it's C and they can always force they way, but
that's a separate issue)

> +{
> +       return prog ? prog->insns : libbpf_err_ptr(-EINVAL);
> +}
> +
>  void bpf_program__set_ifindex(struct bpf_program *prog, __u32 ifindex)
>  {
>         prog->prog_ifindex = ifindex;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 6e61342ba56c..e4a1c98ae6d9 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -195,6 +195,7 @@ typedef void (*bpf_program_clear_priv_t)(struct bpf_program *, void *);
>  LIBBPF_API int bpf_program__set_priv(struct bpf_program *prog, void *priv,
>                                      bpf_program_clear_priv_t clear_priv);
>
> +LIBBPF_API struct bpf_insn *bpf_program__insns(const struct bpf_program *prog);

BTW, I find bpf_program__size() is very ambiguous (is it number of
bytes or number of instructions)? I'd also add bpf_program__insn_cnt()
in the same patch.

And as Quentin mentioned, you need to update libbpf.map (and please
keep everything alphabetically sorted).

>  LIBBPF_API void *bpf_program__priv(const struct bpf_program *prog);
>  LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
>                                          __u32 ifindex);
> --
> 2.32.0
>
