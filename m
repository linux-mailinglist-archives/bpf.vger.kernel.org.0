Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661F735E99B
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 01:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348029AbhDMXTR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 19:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMXTR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 19:19:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FEC061574;
        Tue, 13 Apr 2021 16:18:56 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g38so20011500ybi.12;
        Tue, 13 Apr 2021 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pep/+hcmyuLdTj9CUNJitGsKJD4qWq/ioQPFT+KHavI=;
        b=aAWloC7zk6lBeRUE7tU/a7hPn6cgTPrkg1CeuQ0DKWb+gW80oaS6GwzGbN7C1oa6G8
         rrvvi5ALWqkpA1qHDtfSN7Tia6EALkX1UPC0RKG5oIP0duhlP788XRtHTpg1EDd7oYQY
         j+hsyqlsjy9dj1YusThJgpRwGfKdRCJaXK1V5dClnqCjxmRDlS9ii9NjJMEE8o+uBjmp
         x/kXnK4ZMagpP6MGoGkB9PBegC+YAN/AhUV83WpEhRvkebI5hxH9qaNNF/8DDBk7TwfU
         jDOp3Sj7bVh41wM3r937kVB/nk8syER2sRSgK4A8fo8TAgLTen0QdK2q7z9yAzLxJ7Dj
         iTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pep/+hcmyuLdTj9CUNJitGsKJD4qWq/ioQPFT+KHavI=;
        b=oej0Wq8lLqQEJUsZcafgAfSy02SJXmgl60tPp4SahfOyAFpk2wOcaXGRS+9NMTgMGv
         WXB6TJAZUGkyUWAsrcKgXL+ZB50HCedgqz61p57XOksxsRlmI3O7o5UB9p7dt9x5D9UX
         or8cUzmyaxtMjp524rsYgQ9/ZiMEZdvZn+1LDkITaFlMSXVgmMdkjhVJBbfVqSglmo6n
         ATP9mpj/ShIdPjn6f/A/NNwuAqVbUT4wfTAy7ZIb3AauMgXJTZWPbdxwelubWSD8SyFW
         Mtvu5se+41PCE+ustHt4P0hzB85tPUKvG3GNv91ccHbzdd9jPp3Bld3SsPd4dPVV6QfB
         o58Q==
X-Gm-Message-State: AOAM533Bc5B1t/AHtu0bW1fRcjVFlrfaw89wXrXXAPAQmKalY2AH3f3X
        1FuVZz/yuQGu1daZgZKbnA4K9bKzP2KoRcakoGk=
X-Google-Smtp-Source: ABdhPJyouC3gU8BPcRxQMXWeFruXGBLGuhZ/iNdV0nsW8AY+XRG7mYAxXIjD8iURO1h5/9XWK/Q07tNEH7TrLH2ggrE=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr47480130ybf.425.1618355935988;
 Tue, 13 Apr 2021 16:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-6-revest@chromium.org>
In-Reply-To: <20210412153754.235500-6-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 16:18:45 -0700
Message-ID: <CAEf4Bzb-wSXzyaRfcHQT6Q2bMn-WZsz6aX8V=PtTpia6i6eQNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] libbpf: Introduce a BPF_SNPRINTF helper macro
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

On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
>
> Similarly to BPF_SEQ_PRINTF, this macro turns variadic arguments into an
> array of u64, making it more natural to call the bpf_snprintf helper.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---

Nice!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/bpf_tracing.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 1c2e91ee041d..8c954ebc0c7c 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -447,4 +447,22 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>                        ___param, sizeof(___param));             \
>  })
>
> +/*
> + * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
> + * an array of u64.
> + */
> +#define BPF_SNPRINTF(out, out_size, fmt, args...)              \
> +({                                                             \
> +       static const char ___fmt[] = fmt;                       \
> +       unsigned long long ___param[___bpf_narg(args)];         \
> +                                                               \
> +       _Pragma("GCC diagnostic push")                          \
> +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")  \
> +       ___bpf_fill(___param, args);                            \
> +       _Pragma("GCC diagnostic pop")                           \
> +                                                               \
> +       bpf_snprintf(out, out_size, ___fmt,                     \
> +                    ___param, sizeof(___param));               \
> +})
> +
>  #endif
> --
> 2.31.1.295.g9ea45b61b8-goog
>
