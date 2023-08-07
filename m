Return-Path: <bpf+bounces-7196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7877300A
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 22:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB9E2814B8
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE80F174E0;
	Mon,  7 Aug 2023 20:00:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FFB15ACD
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 20:00:38 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B77E7F
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 13:00:37 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-796d78b3f68so1330343241.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691438436; x=1692043236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVQdRv1Yvag9pZf4ApwFuqYgv2RsqMJxrynRlvroKKI=;
        b=OfneyUN/2lerRgrz+LIZo4dK4kbguaa6/Vk3KCO8tPslYWmyMT0iw2hGT3DjJhMtPW
         +cXO8gED1UB4/QDs8B+gSQJuG1LuSkgcEaoY/W7Ir/NnGfS2aCUxUhElndRMvxe26+PY
         p+J0HeEO1KC3C7NxI/hNU6L2oH8zZi6exeqbHDfvIaPihhCrnGPQN060l+N9kzB4f+po
         t8XcRQGm1ccOtyq9pheseBUNMDq8R4jUTaVP1VOm3H6wT2OIryggbq/jcM/xZHErj187
         1Bv5P4B/bFGSl3cNjovdYXeuzQVfuoC+abgfQn7/2S4Gce3GZ/C4+6pol3Jq/NzEZE/5
         F9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691438436; x=1692043236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVQdRv1Yvag9pZf4ApwFuqYgv2RsqMJxrynRlvroKKI=;
        b=Ckj5NNfS+npfcaNtI3QUxo9QzraCv4l2TJc460u5Sk46wlcOItZJiu+eL15B0v4FCz
         yglaP4SaWr2vpFauGZATKhscMnpLXS5NGfHkYfkbVutaVh6hFn2UxQtGUm1M4zJk2iw9
         mBe1ra/LQ2MyZ5V8/HeSOSiIyU5xtYUHVwwUueQ0Hfatjp9C9H18W32n+vU/iiDuA4Mv
         A/L7zmI+bPA1Gc+EevDjsRhLE5Y4l0ly90KjcBR8+KHVc9fXZA9qfMShoEcs+5JSxq9o
         WIJ9q+DTaL5StGkO1hf5sRzg4tbz3jbizb7DnAvamSW6bxfDvGG0vT7BgeUecSlBBV0P
         0UOw==
X-Gm-Message-State: AOJu0Yxy/DheuRAOcBxKuIi14xYmnMC7LW2rc2/AH3QawHOTiEp+IbAY
	Y8HO9A8PqURHGKmqFg1bWlyP9iPTZb2xaA/1jasmYA==
X-Google-Smtp-Source: AGHT+IEjizJJCB4nnVxo3w+/QZ+ihPBzKEyUWREcezwYPLVdOJJlDAIz2ug7nc/eYnPsuXNuBnjo8muQh7/Fjn3MnQs=
X-Received: by 2002:a67:e3b7:0:b0:444:eedd:1aea with SMTP id
 j23-20020a67e3b7000000b00444eedd1aeamr4591925vsm.17.1691438436080; Mon, 07
 Aug 2023 13:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230807183308.9015-1-me@manjusaka.me>
In-Reply-To: <20230807183308.9015-1-me@manjusaka.me>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 7 Aug 2023 16:00:18 -0400
Message-ID: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
Subject: Re: [PATCH] tracepoint: add new `tcp:tcp_ca_event_set` trace event
To: Manjusaka <me@manjusaka.me>
Cc: edumazet@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 2:33=E2=80=AFPM Manjusaka <me@manjusaka.me> wrote:
>
> In normal use case, the tcp_ca_event would be changed in high frequency.
>
> It's a good indicator to represent the network quanlity.
>
> So I propose to add a `tcp:tcp_ca_event_set` trace event
> like `tcp:tcp_cong_state_set` to help the people to
> trace the TCP connection status
>
> Signed-off-by: Manjusaka <me@manjusaka.me>
> ---
>  include/net/tcp.h          |  9 ++------
>  include/trace/events/tcp.h | 45 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_cong.c        | 10 +++++++++
>  3 files changed, 57 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0ca972ebd3dd..a68c5b61889c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct s=
ock *sk)
>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>
> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event=
 event)
> -{
> -       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> -
> -       if (icsk->icsk_ca_ops->cwnd_event)
> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
> -}
> +/* from tcp_cong.c */
> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
>
>  /* From tcp_cong.c */
>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index bf06db8d2046..38415c5f1d52 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
>                   __entry->cong_state)
>  );
>
> +TRACE_EVENT(tcp_ca_event_set,

Regarding the proposed name, "tcp_ca_event_set"... including "set" in
the name is confusing, since the tcp_ca_event() function is not really
setting anything. :-)

The trace_tcp_cong_state_set() call you are using as a model has "set"
in the name because the function it is tracing, tcp_set_ca_state(),
has "set" in the name. :-)

Would it work to use something like:
  TRACE_EVENT(tcp_ca_event,

thanks,
neal

