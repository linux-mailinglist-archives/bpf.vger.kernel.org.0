Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4275EEB6A
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 04:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiI2CFH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 22:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiI2CFF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 22:05:05 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F7BF8F8E
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 19:05:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-324ec5a9e97so973837b3.7
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 19:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=f1mRMNstfp0oU+nmSji3PZ99E2Ko9CadyHhA/0b7ZVY=;
        b=g+vc0etTbJBBLXzFAS8yKeHrBZt851C8B+4az5HoXVLTlk4sxKKM3q6pLNn2ijo8Bq
         gyMxtxcxrpk3AdmGx/O+7qSzAnax03XBstdOlK3kUjIGajONI0cGE/0Nc6jJKzb3T0Pm
         Y6NuoShfgjwLHApLiuv6PwM7d449HUqjV+m1OdsHbeHg6NaV1VF9wdyVXz6+dj1SNPCf
         kkuQPQtTuGawlMZK19wKjZ3u1DQu0r6j4CPWoTDg730Nd13/vfZBpjfinvw6Tt1ZpTSZ
         fkyf60Vfe5urQfOJIhpupuI03mQ3OOpFAqkNSCtLD+wmq9IcweLMdRbhZmwetuKi9EkP
         NtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=f1mRMNstfp0oU+nmSji3PZ99E2Ko9CadyHhA/0b7ZVY=;
        b=gyJKYYEtF7nrtU+p48bnbHR3/FVlGOu3mntoknsW2hINWPLHYuygUpuE5oJqnivpLA
         Hakat7N0ohOI4FrsOxZffgvZS52AwKp+Nd28/cnG/8nHS4Kp/il4QFU4j5WqkG+8ikzx
         4WtB45HLIJ3oBa5FIRJBRSa5d/e1TEgBAy34kMAH4S2MvHrNlBnZKb8IUzUECP3B0lHX
         R794IioJAzJTSwZvQ8Zp72N0yJUqQ7s1ckyZ56mUmji/ulgfmA4EYv11tgL+hAsHidXs
         YeugLmO0/1uCfCqGr4AjIGu7HfxH7eZc4c2rklKRKwHYjRO6ZQqDQD2TitdSIRWF2MJP
         wu1w==
X-Gm-Message-State: ACrzQf01Gd9Jo/OpjpLkdJw518+28dPThgoCK6TzYXLCPeFpgWnFiK/d
        H2R9IzCCOa3xfCMfrLS9SXEWZJp/CZHLmtFV6Wetdz3DQkw=
X-Google-Smtp-Source: AMsMyM7bNzFXGKCHRm7+OuTV+ImkGZi1Zf77Am7XvZsxwJ59F4KFrxldd6nnui+D+2CK+UpwE759F9Tb31L9h9jkMiM=
X-Received: by 2002:a81:4e0d:0:b0:351:99d8:1862 with SMTP id
 c13-20020a814e0d000000b0035199d81862mr930905ywb.278.1664417102609; Wed, 28
 Sep 2022 19:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220923224453.2351753-1-kafai@fb.com> <20220923224518.2353383-1-kafai@fb.com>
In-Reply-To: <20220923224518.2353383-1-kafai@fb.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 28 Sep 2022 19:04:51 -0700
Message-ID: <CANn89iLf+=AmMntTqy0HyOfbv6PASLsT+E4PhXMAX+xU1Zh2Yg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] bpf: tcp: Stop bpf_setsockopt(TCP_CONGESTION)
 in init ops to recur itself
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 23, 2022 at 3:48 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> When a bad bpf prog '.init' calls
> bpf_setsockopt(TCP_CONGESTION, "itself"), it will trigger this loop:
>
> .init => bpf_setsockopt(tcp_cc) => .init => bpf_setsockopt(tcp_cc) ...
> ... => .init => bpf_setsockopt(tcp_cc).
>
> It was prevented by the prog->active counter before but the prog->active
> detection cannot be used in struct_ops as explained in the earlier
> patch of the set.
>
> In this patch, the second bpf_setsockopt(tcp_cc) is not allowed
> in order to break the loop.  This is done by using a bit of
> an existing 1 byte hole in tcp_sock to check if there is
> on-going bpf_setsockopt(TCP_CONGESTION) in this tcp_sock.
>
> Note that this essentially limits only the first '.init' can
> call bpf_setsockopt(TCP_CONGESTION) to pick a fallback cc (eg. peer
> does not support ECN) and the second '.init' cannot fallback to
> another cc.  This applies even the second
> bpf_setsockopt(TCP_CONGESTION) will not cause a loop.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  include/linux/tcp.h |  6 ++++++
>  net/core/filter.c   | 28 +++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index a9fbe22732c3..3bdf687e2fb3 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -388,6 +388,12 @@ struct tcp_sock {
>         u8      bpf_sock_ops_cb_flags;  /* Control calling BPF programs
>                                          * values defined in uapi/linux/tcp.h
>                                          */
> +       u8      bpf_chg_cc_inprogress:1; /* In the middle of
> +                                         * bpf_setsockopt(TCP_CONGESTION),
> +                                         * it is to avoid the bpf_tcp_cc->init()
> +                                         * to recur itself by calling
> +                                         * bpf_setsockopt(TCP_CONGESTION, "itself").
> +                                         */
>  #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags & ARG)
>  #else
>  #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 96f2f7a65e65..ac4c45c02da5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5105,6 +5105,9 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
>  static int sol_tcp_sockopt_congestion(struct sock *sk, char *optval,
>                                       int *optlen, bool getopt)
>  {
> +       struct tcp_sock *tp;
> +       int ret;
> +
>         if (*optlen < 2)
>                 return -EINVAL;
>
> @@ -5125,8 +5128,31 @@ static int sol_tcp_sockopt_congestion(struct sock *sk, char *optval,
>         if (*optlen >= sizeof("cdg") - 1 && !strncmp("cdg", optval, *optlen))
>                 return -ENOTSUPP;
>
> -       return do_tcp_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
> +       /* It stops this looping
> +        *
> +        * .init => bpf_setsockopt(tcp_cc) => .init =>
> +        * bpf_setsockopt(tcp_cc)" => .init => ....
> +        *
> +        * The second bpf_setsockopt(tcp_cc) is not allowed
> +        * in order to break the loop when both .init
> +        * are the same bpf prog.
> +        *
> +        * This applies even the second bpf_setsockopt(tcp_cc)
> +        * does not cause a loop.  This limits only the first
> +        * '.init' can call bpf_setsockopt(TCP_CONGESTION) to
> +        * pick a fallback cc (eg. peer does not support ECN)
> +        * and the second '.init' cannot fallback to
> +        * another.
> +        */
> +       tp = tcp_sk(sk);
> +       if (tp->bpf_chg_cc_inprogress)
> +               return -EBUSY;
> +

Is the socket locked (and owned by current thread) at this point ?
If not, changing bpf_chg_cc_inprogress would be racy.


> +       tp->bpf_chg_cc_inprogress = 1;
> +       ret = do_tcp_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
>                                 KERNEL_SOCKPTR(optval), *optlen);
> +       tp->bpf_chg_cc_inprogress = 0;
> +       return ret;
>  }
>
>  static int sol_tcp_sockopt(struct sock *sk, int optname,
> --
> 2.30.2
>
