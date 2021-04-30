Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C473F36FE89
	for <lists+bpf@lfdr.de>; Fri, 30 Apr 2021 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhD3Qcg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Apr 2021 12:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhD3Qcg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Apr 2021 12:32:36 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E920FC06174A;
        Fri, 30 Apr 2021 09:31:47 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x131so2835783ybg.11;
        Fri, 30 Apr 2021 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2mLV6on/AScC+J+olqrHsUjmUN/LKY8yJTmwsZh9o8=;
        b=Ews3etYbRH1SAXxMpCQ3HzT8GqoLm0S6KlnyPkm8GDmGNNs21zoeXWeQB7kVRWCZ78
         asA/wpbZBsb96S8dSuoYFtxvNPGHh42qBysRhMcEGCkpk3buxXUi8dCjr3j63c6AVxKc
         a1quoTAEYQreh7fJuEzUczoZbR4qafpmQTa6bcrGALxjCBsbFYyKQBhx/JYKyAxH5zxl
         l7PRFyl55cDFErDvY5HKP5Z5KdKPp+VFjHDBZQjgDVUjbLhdELiavNRlJt+GKnVD+hr2
         iUX3dZxEMdpmfyHxFrXte61dXoVkPbiKqqCuaIW3LjYQ83+rM4waTff/rm7YBAK0aGxh
         C0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2mLV6on/AScC+J+olqrHsUjmUN/LKY8yJTmwsZh9o8=;
        b=B7UXY8mR1G/+lyqZaCTZeSJJTaHxPAW5XcjtLIBiduRn5xP77vPx2CLMINo7e5qmQQ
         +fPMCTCKmhRIqZH7rBIt7fS2ktKvU+Js8der2TchSO0xXgHlqqsW57U183sYkthcu4eX
         efN8piGGCNEimyHYwQwOpKeap2iR0hQfUURGeP/jeJBS9gXA/6yUo+Atg1i+WTUOi/hk
         QpBh6q2L08DcL2eviwRQ7fR9kJag4Iwh2mt9KI1qP/QUC1wYxyKBH+gTmsuHlwVmkQmt
         eB4q0ql5LhVaRl/V2WA+9WME4kHc3Tc3A91jvfG3cWKJm7af7QfmSGKhAMADKOTTnTmq
         /DMQ==
X-Gm-Message-State: AOAM530X9VsrLMVQQBlWZMwCRy2wGJsUHOhm/nZtLp18+bWV4dApr2Qv
        xK2akNBQTGAT8XHOOPQV0zgi0uKYXahtfga2MKI=
X-Google-Smtp-Source: ABdhPJwJ5e05hCeVD6W/60BrOQQAMF3qO9FZdE9Q20e+qRXpHN/C4dXiihjalWS0c/RSVsM6rZoNHh3JZtCpdBUSPbM=
X-Received: by 2002:a25:7507:: with SMTP id q7mr8303198ybc.27.1619800307186;
 Fri, 30 Apr 2021 09:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210429130510.1621665-1-jackmanb@google.com>
In-Reply-To: <20210429130510.1621665-1-jackmanb@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Apr 2021 09:31:36 -0700
Message-ID: <CAEf4BzY7sx0gW=o5rM8WDzW1J0U_Yep3MMuJScoMg-hBAeBPCg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 29, 2021 at 6:05 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> One of our benchmarks running in (Google-internal) CI pushes data
> through the ringbuf faster htan than userspace is able to consume
> it. In this case it seems we're actually able to get >INT_MAX entries
> in a single ringbuf_buffer__consume call. ASAN detected that cnt
> overflows in this case.
>
> Fix by using 64-bit counter internally and then capping the result to
> INT_MAX before converting to the int return type.
>
> Fixes: bf99c936f947 (libbpf: Add BPF ring buffer support)
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>
> diff v1->v2: Now we don't break the loop at INT_MAX, we just cap the reported
> entry count.
>
> Note: I feel a bit guilty about the fact that this makes the reader
> think about implicit conversions. Nobody likes thinking about that.
>
> But explicit casts don't really help with clarity:
>
>   return (int)min(cnt, (int64_t)INT_MAX); // ugh
>

I'd go with

if (cnt > INT_MAX)
    return INT_MAX;

return cnt;

If you don't mind, I can patch it up while applying?

> shrug..
>
>  tools/lib/bpf/ringbuf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index e7a8d847161f..2e114c2d0047 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -204,7 +204,9 @@ static inline int roundup_len(__u32 len)
>
>  static int ringbuf_process_ring(struct ring* r)
>  {
> -       int *len_ptr, len, err, cnt = 0;
> +       int *len_ptr, len, err;
> +       /* 64-bit to avoid overflow in case of extreme application behavior */
> +       int64_t cnt = 0;
>         unsigned long cons_pos, prod_pos;
>         bool got_new_data;
>         void *sample;
> @@ -240,7 +242,7 @@ static int ringbuf_process_ring(struct ring* r)
>                 }
>         } while (got_new_data);
>  done:
> -       return cnt;
> +       return min(cnt, INT_MAX);
>  }
>
>  /* Consume available ring buffer(s) data without event polling.
> @@ -263,8 +265,8 @@ int ring_buffer__consume(struct ring_buffer *rb)
>  }
>
>  /* Poll for available data and consume records, if any are available.
> - * Returns number of records consumed, or negative number, if any of the
> - * registered callbacks returned error.
> + * Returns number of records consumed (or INT_MAX, whichever is less), or
> + * negative number, if any of the registered callbacks returned error.
>   */
>  int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
>  {
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
