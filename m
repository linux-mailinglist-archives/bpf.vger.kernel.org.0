Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC733CCA1
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 05:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhCPEkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 00:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhCPEju (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 00:39:50 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5455C06174A;
        Mon, 15 Mar 2021 21:39:50 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p193so35509531yba.4;
        Mon, 15 Mar 2021 21:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KX/AY7u5IphllqIA2+82MtdhsmX65LsG0L2D/jaM4c=;
        b=Y5+cMc4D1/mYYgzZUGA8M9K5e140WpfszO4qHQVji8NImF0B0hj+14+sOmcpOClQTk
         FajaXclLb3UyDC19PRc83BOed2BWP3caWXHfIjNo7B4ZoSNHk6nOa+2SDwoRUeMlTAO6
         Iu4eW+EDIRKDiruyn0gbfpxganjr7ejvYUnoIm5Hn2gA2j3BL4UPdAgTQZntJuLp19Sr
         vHPzY4FPO76z/AwilzJcEN/8eIvUue9JFVdHiCcuA75U/sPK5iwyvOX4IWGw605XFqUp
         H+eSxdohk3bTcPFyvPu6fyG7h1Wyk8IAN75kLoWhJxLOPTondn7D3WgtvuTFdHu949HM
         nAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KX/AY7u5IphllqIA2+82MtdhsmX65LsG0L2D/jaM4c=;
        b=bs5xi9mTRj1AHUkZjoyjQNiKT9EdxxBtA7QLn06ZMPd5tixDN33BcAHI4w1mnYnOrj
         WbBSSTQjTUj3ys9EDZTFakuRJ5G5kpDEIX4K3KfOvoSyGh4bl97qaAJd8Hx+6XXsSRm8
         UL0HUVM4ITFFDQQ8M8xeAWYOSUrEKpzS/iF15g0ziY99Zpbb1aKUJBmUTETNMosKyEgR
         PYGTSczoAmcAm9f1YqYrKc1zTGu3ENsDJdCrV+95f2osJ59adL8/eqRrFIrjpRuIzKKZ
         pEJtqrNysC6Lh0NBEP2VrT2eGx/MjSbObY8hpAEfNgMRyY2N+LI+dbHqT5Osj0NPKOps
         8hgw==
X-Gm-Message-State: AOAM5302MqL4a/Gr9pjExzFvulKpRoPyRIqtqmJNyA61wFawkY0K03M9
        bnFHK9c1wyBquEznUk1D+/8cBayNUdZULAwRs6A=
X-Google-Smtp-Source: ABdhPJycWeOs6cTD602sY9atLjisjWdRBONvfw/QMshPDOy1nUqWLNhJJhdinXorVuG5F2yzeY9nqE9sGAvO5Hmt7pg=
X-Received: by 2002:a25:d94:: with SMTP id 142mr4122940ybn.230.1615869590047;
 Mon, 15 Mar 2021 21:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-5-revest@chromium.org>
In-Reply-To: <20210310220211.1454516-5-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Mar 2021 21:39:39 -0700
Message-ID: <CAEf4BzZvWnmUm0T4Q5WM9i1TUs=8FumeNwbbO8fhSOM59PU_rA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] libbpf: Introduce a BPF_SNPRINTF helper macro
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

On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
>
> Similarly to BPF_SEQ_PRINTF, this macro turns variadic arguments into an
> array of u64, making it more natural to call the bpf_snprintf helper.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  tools/lib/bpf/bpf_tracing.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index f6a2deb3cd5b..89e82da9b8a0 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -457,4 +457,19 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>                 ___ret;                                                     \
>         })
>
> +/*
> + * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
> + * an array of u64.
> + */
> +#define BPF_SNPRINTF(out, out_size, fmt, args...)                          \
> +       ({                                                                  \
> +               _Pragma("GCC diagnostic push")                              \
> +               _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
> +               ___bpf_build_param(args);                                   \
> +               _Pragma("GCC diagnostic pop")                               \
> +               int ___ret = bpf_snprintf(out, out_size, fmt,               \
> +                                           ___param, sizeof(___param));    \

same problem, mixing variable declarations and code

> +               ___ret;                                                     \
> +       })
> +
>  #endif
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
