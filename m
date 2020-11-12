Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE58A2B0795
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 15:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKLOg3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 09:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOg2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 09:36:28 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8321BC0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 06:36:28 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id e17so5433808ili.5
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D775VSGHzGZnF3mzAt4aR6+9Q/vNy6mqX+JZCbFLDs4=;
        b=AecpO+aB9tI/64YOMsY+REOw9uNE794a0bHqjzjbcfLbaWpYXFv0J1jYrzwpbLcbpF
         qDMFKnjnstg2BSjbyS9Y16vkZjd/5iiuNdP+hZPfJpbRzqe3iW9ZKREBZhnVxjBUoJ4r
         RtE/M+VpuICs5O6RObs20oq7Um7k+Q4E3XqfbjAHzjUCiQ/FAXgTsWy6jlfHCdQT+RBf
         Wu+WPt3/mbk6yY1mm41Xb+lziw+ik1nO91HgPU1zuflN+LpRtNX8eLJekZuqrXri/5yl
         qGjIuXELUnmHQwGh0Ivai0CaGZV/oIAD5jr5gY63xiYQKNwm6QdUjUQCX5RoQuih+02d
         w/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D775VSGHzGZnF3mzAt4aR6+9Q/vNy6mqX+JZCbFLDs4=;
        b=fnaarjhAHuZX6oDhPcVT6tWjfsCVjY2feNm8j5TO6V/m6AF8rh3noWRSOTKKd6RVEX
         YXHpQ44NjpvnSdKWaPUOUJCsG0mqm6D5CxmED5ErfHFKqjTLVvHr+Ls2MLyx3rU9eL7a
         XXpHRHlB8r3VXVr7qvemYseMV+yqT/sOO0uqgr61Ro6Cv6b+UqonkxO5Uch1OWl8YWjl
         HBtHZNDwL8hfXD6wC8o0C46Ww5fiuaLxDEGVQ8Sbj/wOHoagWMLFkKPFCeaMGQ/VQbdQ
         HYmQjY3AkkJsPBBBK57DvWsOaQIENosATcgqARI6QN/IMLGTUBB06jbOM4GpIuh5anCe
         AL2w==
X-Gm-Message-State: AOAM533L0Ba7x/F6kduR6+q0j5CIVhkIKCfH4ROUaatx+iJ6gWOtR3SU
        p8X1wyvNQhLemw4jE/7qCvhJ/FE+STlceAL+WxwYqg==
X-Google-Smtp-Source: ABdhPJwUuhwoEaH5qEnZJINwmS7fiL9ZTq9nNdszXM50hjGdKL4PmkTX/P9jCN3tWT/poyAeP3lTG8yGmo3AKWZOKSs=
X-Received: by 2002:a05:6e02:14c9:: with SMTP id o9mr24222949ilk.137.1605191787425;
 Thu, 12 Nov 2020 06:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20201112114041.131998-1-bjorn.topel@gmail.com> <20201112114041.131998-3-bjorn.topel@gmail.com>
In-Reply-To: <20201112114041.131998-3-bjorn.topel@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 12 Nov 2020 15:36:16 +0100
Message-ID: <CANn89i+Zumgn+phZEYPb9yCQRrJ7UYh1wY7SBio6ykg2noYz2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/9] net: add SO_BUSY_POLL_BUDGET socket option
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
> This option lets a user set a per socket NAPI budget for
> busy-polling. If the options is not set, it will use the default of 8.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> ---
>

...

>  #else /* CONFIG_NET_RX_BUSY_POLL */
>  static inline unsigned long net_busy_loop_on(void)
> @@ -106,7 +108,8 @@ static inline void sk_busy_loop(struct sock *sk, int =
nonblock)
>
>         if (napi_id >=3D MIN_NAPI_ID)
>                 napi_busy_loop(napi_id, nonblock ? NULL : sk_busy_loop_en=
d, sk,
> -                              READ_ONCE(sk->sk_prefer_busy_poll));
> +                              READ_ONCE(sk->sk_prefer_busy_poll),
> +                              sk->sk_busy_poll_budget ?: BUSY_POLL_BUDGE=
T);

Please use :

       READ_ONCE(sk->sk_busy_poll_budget) ?: BUSY_POLL_BUDGET

Because sk_busy_loop() is usually called without socket lock being held.

This will prevent yet another KCSAN report.

>  #endif
>  }
>

...

> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1165,6 +1165,16 @@ int sock_setsockopt(struct socket *sock, int level=
, int optname,
>                 else
>                         sk->sk_prefer_busy_poll =3D valbool;
>                 break;
> +       case SO_BUSY_POLL_BUDGET:
> +               if (val > sk->sk_busy_poll_budget && !capable(CAP_NET_ADM=
IN)) {
> +                       ret =3D -EPERM;
> +               } else {
> +                       if (val < 0)

               if (val < 0 || val > (u16)~0)

> +                               ret =3D -EINVAL;
> +                       else
> +                               sk->sk_busy_poll_budget =3D val;


                               WRITE_ONCE(sk->sk_busy_poll_budget, val);

> +               }
> +               break;
>  #endif
>
>         case SO_MAX_PACING_RATE:
> --
> 2.27.0
>
