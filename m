Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC05E4561BE
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 18:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhKRRwv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 12:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhKRRwv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 12:52:51 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1B6C061574;
        Thu, 18 Nov 2021 09:49:51 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id i194so20388765yba.6;
        Thu, 18 Nov 2021 09:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAVs3zgpv4E9J52G61avRGuhhy9CUdDocU62BJiDYXY=;
        b=hnYTaqT6lGY6BlKUHeLRbarpOiPmPQnjbwK2L9sJG3//+DVVjqqcvNmoaCD2HUewr8
         u+UL/6qnGtvX00b4esWovdcf/FaEbRRQhArGSTW5ug/6WXeygwQfPZrUJYum82atCg+l
         7kUvQFFUhfrwq+WeB6z0GPnbUjrX4O6Iwah6F2vl7xuVeq+rGyElXJl2jz6SXJbCqIi3
         MJkv5x0HMFqBq8nLeCWWgPOZSejqj2c+zAjY+1lFqKnWfG64GlRJPVs6dAYWkLG0Fo4B
         Vq0P6LVBg6tGPGPF6OyaoqsbC2E/TsjajSxU+tqKv/59zJPXk7mqQYFLLAsmnCOjHoHL
         CNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAVs3zgpv4E9J52G61avRGuhhy9CUdDocU62BJiDYXY=;
        b=YfYadg3fmOt9OEvzXovQNoOUbVOXc/DYOXbvLPpl5pLRo70uz0mR6w5QGFRCdvkTWd
         Pb7hFmZSz55RGsExDRXD8GcM1+NFK2lwBV2Jkufxp0YZ8NP5sKTy7tPamxVWkBcJFhrw
         BJVp1YOZEK/Wjm53CutIg/8iBnb8uZIxAcxhBVzLbVw37VFsRa6e+zMwYgdtYJ+roN9V
         9E+wiHSoNtqA6EkWXf7ByZ0Z3pBKMu3uib5FPn/PawTNkSymorhCL7KsQ26y+YTYmPoE
         jF+3XWJ64Bgo8FiCa1J2QjyTsFM2cFfrNiNXfUB1Dzh9Wy8c/RIVWRZ8JmbLUa23Ti7w
         +0Tw==
X-Gm-Message-State: AOAM5300qFwkg8SOZ/nlWCp0F5t9mYgobA7wEdzj9x2V/oI/hglFVYAE
        plhR9/9Dj62eRf5+OjccJqZpeGPKgU4k1rewOZjteWEh
X-Google-Smtp-Source: ABdhPJydkEWVxOwpzyohlQikcsLOar03Kh7v8SOLJrk4+j/o912BUd8EoZSeK+rN+mfCxv7B318z7o2dLKK0RBKRvs0=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr27322816ybj.433.1637257790453;
 Thu, 18 Nov 2021 09:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20211118103335.1208372-1-revest@chromium.org>
In-Reply-To: <20211118103335.1208372-1-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Nov 2021 09:49:39 -0800
Message-ID: <CAEf4BzY5JXvWSTdyyPRoTdqupsnxiRf622sGTzsOPhr4WVMNBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add ability to clear per-program load flags
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 2:33 AM Florent Revest <revest@chromium.org> wrote:
>
> Recently, bpf_program__flags and bpf_program__set_extra_flags were
> introduced to the libbpf API but they only allow adding load flags.
>
> We have a use-case where we construct a skeleton with a sleepable
> program and if it fails to load then we want to make it non-sleepable by
> clearing BPF_F_SLEEPABLE.

I'd say the better way to do this is to have two programs (that share
the logic, of course) and pick one or another at runtime:

static int whatever_logic(bool sleepable) { ... }

SEC("fentry.s/whatever")
int BPF_PROG(whatever_sleepable, ...)
{
    return whatever_logic(true);
}

SEC("fentry/whatever")
int BPF_PROG(whatever_nonsleepable, ...)
{
    return whatever_logic(false);
}


Then at runtime you can bpf_program__autoload(..., false) for a
variant you don't want to load.

This clear_flags business seems too low-level and too limited. Next
thing we'll be adding a few more bit manipulation variants (e.g, reset
flags). Let's see how far you can get with the use of existing
features. I'd set_extra_flags() to be almost never used, btw. And they
shouldn't, if can be avoided. So I'm hesitant to keep extending
operations around prog_flags.

But given we just added set_extra_flags() and it's already too
limiting, let's change set_extra flags to just set_flags() that will
override the flags with whatever user provides. Then with
bpf_program__flags() and bpf_program__set_flags() you can express
whatever you want without adding extra APIs. Care to fix that?

>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  tools/lib/bpf/libbpf.c   | 9 +++++++++
>  tools/lib/bpf/libbpf.h   | 1 +
>  tools/lib/bpf/libbpf.map | 1 +
>  3 files changed, 11 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index de7e09a6b5ec..dcb7fced5fd2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8305,6 +8305,15 @@ int bpf_program__set_extra_flags(struct bpf_program *prog, __u32 extra_flags)
>         return 0;
>  }
>
> +int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags)
> +{
> +       if (prog->obj->loaded)
> +               return libbpf_err(-EBUSY);
> +
> +       prog->prog_flags &= ~flags;
> +       return 0;
> +}
> +
>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                       \
>         .sec = sec_pfx,                                                     \
>         .prog_type = BPF_PROG_TYPE_##ptype,                                 \
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 4ec69f224342..08f108e49841 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -495,6 +495,7 @@ bpf_program__set_expected_attach_type(struct bpf_program *prog,
>
>  LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_extra_flags(struct bpf_program *prog, __u32 extra_flags);
> +LIBBPF_API int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags);
>
>  LIBBPF_API int
>  bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 6a59514a48cf..eeff700240dc 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -401,6 +401,7 @@ LIBBPF_0.6.0 {
>                 bpf_program__insn_cnt;
>                 bpf_program__insns;
>                 bpf_program__set_extra_flags;
> +               bpf_program__clear_flags;
>                 btf__add_btf;
>                 btf__add_decl_tag;
>                 btf__add_type_tag;
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
