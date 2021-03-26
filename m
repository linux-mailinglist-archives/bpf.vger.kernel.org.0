Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C757A34B21C
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 23:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCZWYC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 18:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZWXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 18:23:51 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42619C0613AA;
        Fri, 26 Mar 2021 15:23:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i9so7368787ybp.4;
        Fri, 26 Mar 2021 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXu3XAZp2hdY5DI6CxUXj5bqnMVMfuciWYTdWcsesSY=;
        b=DPB8wNPyV8UJUcbxD++4y+WfMPkwnWthrI4Zf1j4/sBoakqgV898gss1K6n8COMP6F
         tvpfCP4Cvy57smOZf3R8BgU2F8qm4/xnyYZETe8ELhYrska7TAyD0Qu2T1B5fITKZyec
         5HYy4iTg0hp9u5120kK0Mvc1IXcF+1eSsyczya+zZ8XzNHsgNxAPvQotquvrcqa55IV2
         hMAlbA1pFdTigsEm6EIXUW4vfdV9jR+w/hQ9bImfjDapbGXoiDQkO26+Nbgly1ZLJJd0
         XhBs7XHNRUvi4Ome/rnJUkdl6d2ZLhi1aoL5UXwWY+Ndcys5c7IGz9eErAcM80EsEeNM
         jd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXu3XAZp2hdY5DI6CxUXj5bqnMVMfuciWYTdWcsesSY=;
        b=huMCQmcH5qJX8yVJsoF1qGGaA3yiZdhdjI9r58mRAmt3UWYUZ+/TF2sVdm3F9weULn
         +kWLFjxEEktKS2StA+GD6nQPJGrwGQAhLA+1yk5plccEbtUNso6FH+pgN/FNMT4I+xbg
         12UIbkjI6S9N7c0/WArrsOIlhKoYhCFIZf3W2IaQk/td2pR7yMSKdQT6TqnhOcZgomgV
         2U/MDOVMK3+izC0CRsmAP4IBuXdQG/SZ1Ad7AMa+X4y/7Vw35hE3ECGivMKCJ8Cw0d8z
         YgViSBVS0u8uq5sue3cEmotKO3VSogL+D1YsSsCNRO+m6TWz3Xh1Q45MxaPgZqFBcrni
         T6gg==
X-Gm-Message-State: AOAM530kkT2Pqhoqk2F/PyqHqIhTDp7sRIKmYlbcrv4HMdx7HNnE/Klv
        jhECeJKnv0GOIWLv5YmD6kF2gKLgTqrNRlGS4Sk=
X-Google-Smtp-Source: ABdhPJwrKCcC0vjC5f6kM7th5l3POwAUCT1aNC2YHRbYmrXqBe1p+Gw2kxxBl5W1d73hn8KXKrzcgSgF7lx4/f7cCCM=
X-Received: by 2002:a25:37c1:: with SMTP id e184mr22626153yba.260.1616797430401;
 Fri, 26 Mar 2021 15:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-3-revest@chromium.org>
In-Reply-To: <20210324022211.1718762-3-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Mar 2021 15:23:39 -0700
Message-ID: <CAEf4BzZEgHyodDqj7exrEo+eBOzHEnsvkc003vxq3dcRVZXE2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
>
> This type provides the guarantee that an argument is going to be a const
> pointer to somewhere in a read-only map value. It also checks that this
> pointer is followed by a zero character before the end of the map value.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/verifier.c | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a25730eaa148..7b5319d75b3e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -308,6 +308,7 @@ enum bpf_arg_type {
>         ARG_PTR_TO_PERCPU_BTF_ID,       /* pointer to in-kernel percpu type */
>         ARG_PTR_TO_FUNC,        /* pointer to a bpf program function */
>         ARG_PTR_TO_STACK_OR_NULL,       /* pointer to stack or NULL */
> +       ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
>         __BPF_ARG_TYPE_MAX,
>  };
>

[...]

> +
> +               map_off = reg->off + reg->var_off.value;
> +               err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> +               if (err)
> +                       return err;
> +
> +               str_ptr = (char *)(long)(map_addr);
> +               if (!strnchr(str_ptr + map_off,
> +                            map->value_size - reg->off - map_off, 0))

you are double subtracting reg->off here. isn't map->value_size -
map_off what you want?

> +                       verbose(env, "string is not zero-terminated\n");

I'd prefer `return -EINVAL;`, but at least set err, otherwise what's the point?

>         }
>
>         return err;
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
