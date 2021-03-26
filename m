Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43AA34B26D
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCZXCt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhCZXCo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 19:02:44 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ACCC0613AA;
        Fri, 26 Mar 2021 16:02:43 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i9so7443700ybp.4;
        Fri, 26 Mar 2021 16:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pethXz1bbMtoDpNBPeNJowiWg9SdyVY/O15JGtuY030=;
        b=Ui2FXERmWjJ/ndwdfugsJ6N7CjdmM7TXBfjrs2umfZIZMy4tUwMD1roJEzKwZg2BZ5
         X6fZou536eelFJk53vnrSjIFUbfAW47RD6TeX3TonV6f9git5Yg213s7vlaz5fHzAf0g
         LgazYDHHhePd493w51pmSFdJgU88UWSTe7zFcePeX0Sa4e2aIotcexLPuh8cG0ZylTPG
         vr45qzej1+AWvPfRk50zWZKWTW16xlToL+09dyUaftpGxk+uk0q9HzcXsocmrceOOv/r
         5ALmGa1gx5tWYTXtyANO0rMmjJhp0ppe1/+632YvDW1VZAROfkoXLk7DDUAUJQtTlGMA
         pA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pethXz1bbMtoDpNBPeNJowiWg9SdyVY/O15JGtuY030=;
        b=rPlyFwaoafuEgSrJ+7knx8BOmL6K77w5ZjxeWv/NQkvm5qPRPS9psW3yHNjPpI0OGB
         myZLSAx7X9lFyrEDr5Ak7t92ULKmMb45QFNSF21vzNpFgNuT6YdVSU+K5wua3Cq+D9xi
         5temBsyDCUbdUnMxODG/ySnC3pHI8yQrCwOM76cT6kJCc9ih4V7kamBEIpjdsRxJy6gH
         UU+jidXD153wnWYryYfrIHdro6YxhbR8J1frDe6vfvphJvIwdE0hozzCNOdZV2l8Y9SI
         P0ZLG1OA/ImTuipwn2vrYWIv+9Fs7XZLrQuMrakjk646p6f3yvEamJcV8hx9kkVNVRaU
         sB1A==
X-Gm-Message-State: AOAM531jqDAyZuVRwNiS30Wz+qWz8mnOvGbdYJSSw6te+7zzeaGUVv7W
        h4aHc/ms2xj+wCVWKCwaQrIUaDDhsRAB+uUJgIg=
X-Google-Smtp-Source: ABdhPJztgXL3i9jNInTKUXr95bpOPabFbdqkFq6UPjx2Ux/QoA9h8O3rQgaGmNtjCrC8tsRNah0B8wOGeb7xDkuhTgM=
X-Received: by 2002:a25:37c1:: with SMTP id e184mr22790071yba.260.1616799763338;
 Fri, 26 Mar 2021 16:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-6-revest@chromium.org>
In-Reply-To: <20210324022211.1718762-6-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Mar 2021 16:02:32 -0700
Message-ID: <CAEf4BzZ-goAfpEWHt83TR_E9OjLXBwC70TX7G_QKd_HGdXGyOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] libbpf: Introduce a BPF_SNPRINTF helper macro
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
> Similarly to BPF_SEQ_PRINTF, this macro turns variadic arguments into an
> array of u64, making it more natural to call the bpf_snprintf helper.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  tools/lib/bpf/bpf_tracing.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index d9a4c3f77ff4..e5c6ede6060b 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -447,4 +447,22 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>                 __ret;                                                      \
>         })
>
> +/*
> + * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
> + * an array of u64.
> + */
> +#define BPF_SNPRINTF(out, out_size, fmt, args...)                          \
> +       ({                                                                  \

Same feedback as the previous patch, but let's also reduce the
nestedness level, those ({ }) can be shifted one tab left, right?
Please do the same for the previous patch as well. Thanks!

> +               _Pragma("GCC diagnostic push")                              \
> +               _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
> +               unsigned long long ___param[___bpf_narg(args)];             \
> +               static const char ___fmt[] = fmt;                           \
> +               int __ret;                                                  \
> +               ___bpf_fill(___param, args);                                \
> +               _Pragma("GCC diagnostic pop")                               \
> +               __ret = bpf_snprintf(out, out_size, ___fmt,                 \
> +                                    ___param, sizeof(___param));           \
> +               __ret;                                                      \
> +       })
> +
>  #endif
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
