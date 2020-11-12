Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44292B07A4
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgKLOi4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 09:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOi4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 09:38:56 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1396C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 06:38:54 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n12so6263298ioc.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 06:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aRsr8TI5u0jyrJl0DlIj9lK28moq3EMRHQwZQ0D7dVg=;
        b=DOcpr6h4RM69pKwd/0ciOtJYxhLb+Fhek6D9mXsFsxjOxs4Gy9z4O+ptN0VIuprxNO
         P8vnOsqXaTCl7H7OoeIWBQzJqmWWN7+OxBDdGeKHJewCx4qO/WRj0/mrh+PPjiotDTzR
         6nd8uEdSjZpFyVTSVdZN9tP8Juu3Sqa4FIpIFl7RAXcreo+qdxQ8k5c2BxAkEj8/jY/9
         Z1fZSa6QeTeTWnr1gYwJTKou1alvZX+sTUj7dGVL7uv0w1PnRvYFu6jP3MZdP7YoTRa5
         N1PGmPtXwbN5JNWuh524T8jqx/25PeJxvBONj5B+mS5nnFUSlvtgbjmWhivUNQpO1bf1
         LBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aRsr8TI5u0jyrJl0DlIj9lK28moq3EMRHQwZQ0D7dVg=;
        b=Tp5RjIBMQ4lkasVT2mucW7OIXCuue7oEmm3UhMFRMfYfGmPC+a1p6oTnP+UjthThTD
         z1ukY+jdrHBCSAFArbGc8Q8Nvoy0fLwfWsc/TVIoNCqFL8XjPxLUi77c58/zO5aHRfSx
         NDelWrwIUQSUGvUS1JZ1Ay/o1iWoZwYUw2691H2J2mKGo02p9COt4b71QDV4oEVfsoOk
         OWW9rCHhoxOTIgFYzVddlM5YIL1vDYq5YZGUTH2kqYJEQGHCq+ZCNJoFMqnUqjR+O3Yk
         AUaN758D+qgNfHzg4H20xPtljLLfKLUY8ZL3qx51GGhEjg6qA6JSx3TLcOZK7QdykH6k
         Zaxg==
X-Gm-Message-State: AOAM5331KlJm84cqj9NgtDljktHx/q+6W+K5hrvF4fBVlfM6nynzfa13
        kWXTraJq5m3oT+F0c4d/3b0NoOU4TLAE0G6fmL7I8g==
X-Google-Smtp-Source: ABdhPJy7OmOZjOa372ROsn4UTnIERCum5zyFpDlq1LhHmaKoF7rWcKwaxaGXMbNn9EAbQ3FNnV8IU4kNpUpP2fJekIw=
X-Received: by 2002:a05:6638:3d2:: with SMTP id r18mr23337126jaq.99.1605191934093;
 Thu, 12 Nov 2020 06:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20201112114041.131998-1-bjorn.topel@gmail.com> <20201112114041.131998-2-bjorn.topel@gmail.com>
In-Reply-To: <20201112114041.131998-2-bjorn.topel@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 12 Nov 2020 15:38:42 +0100
Message-ID: <CANn89iL=j38rdsKhAm8_4pMbf=vyAZ8SVoUkUgEVUF0GEXRwRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/9] net: introduce preferred busy-polling
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        maciej.fijalkowski@intel.com,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        qi.z.zhang@intel.com, Jakub Kicinski <kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>, maximmi@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 12:41 PM Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.c=
om> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> The existing busy-polling mode, enabled by the SO_BUSY_POLL socket
> option or system-wide using the /proc/sys/net/core/busy_read knob, is
> an opportunistic. That means that if the NAPI context is not
> scheduled, it will poll it. If, after busy-polling, the budget is
> exceeded the busy-polling logic will schedule the NAPI onto the
> regular softirq handling.
>
> One implication of the behavior above is that a busy/heavy loaded NAPI
> context will never enter/allow for busy-polling. Some applications
> prefer that most NAPI processing would be done by busy-polling.
>
> This series adds a new socket option, SO_PREFER_BUSY_POLL, that works
> in concert with the napi_defer_hard_irqs and gro_flush_timeout
> knobs. The napi_defer_hard_irqs and gro_flush_timeout knobs were
> introduced in commit 6f8b12d661d0 ("net: napi: add hard irqs deferral
> feature"), and allows for a user to defer interrupts to be enabled and
> instead schedule the NAPI context from a watchdog timer. When a user
> enables the SO_PREFER_BUSY_POLL, again with the other knobs enabled,
> and the NAPI context is being processed by a softirq, the softirq NAPI
> processing will exit early to allow the busy-polling to be performed.
>
> If the application stops performing busy-polling via a system call,
> the watchdog timer defined by gro_flush_timeout will timeout, and
> regular softirq handling will resume.
>
> In summary; Heavy traffic applications that prefer busy-polling over
> softirq processing should use this option.
>
> Example usage:
>
>   $ echo 2 | sudo tee /sys/class/net/ens785f1/napi_defer_hard_irqs
>   $ echo 200000 | sudo tee /sys/class/net/ens785f1/gro_flush_timeout
>
> Note that the timeout should be larger than the userspace processing
> window, otherwise the watchdog will timeout and fall back to regular
> softirq processing.
>
> Enable the SO_BUSY_POLL/SO_PREFER_BUSY_POLL options on your socket.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

...

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 727ea1cc633c..248f6a763661 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1159,6 +1159,12 @@ int sock_setsockopt(struct socket *sock, int level=
, int optname,
>                                 sk->sk_ll_usec =3D val;
>                 }
>                 break;
> +       case SO_PREFER_BUSY_POLL:
> +               if (valbool && !capable(CAP_NET_ADMIN))
> +                       ret =3D -EPERM;
> +               else
> +                       sk->sk_prefer_busy_poll =3D valbool;

                            WRITE_ONCE(sk->sk_prefer_busy_poll, valbool);

So that KCSAN is happy while readers read this field while socket is not lo=
cked.

> +               break;
>  #endif
>
>
