Return-Path: <bpf+bounces-1420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54908715583
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 08:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC88D1C20B9E
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE69946F;
	Tue, 30 May 2023 06:30:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D69111AD
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 06:30:56 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8ADC
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 23:30:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f606e111d3so88635e9.1
        for <bpf@vger.kernel.org>; Mon, 29 May 2023 23:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685428253; x=1688020253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRx2HMn0OgK8Wf4NKopm1Q8CsykoOI54UVBh2xPJbys=;
        b=1dV04U1c/5p0i2Fy8TQCj/tjWnQXfsVCE8Q9XjMgRDYYOndRM0ksnvG6CUi+LaWNf4
         onPiD0BnVC2UxwOtBZ1fuIX8zB3R4apua2G7Vw8Eu17XhdYlWwVYPE6LqmBJYaOiaMfQ
         5qPywpdNn1N++mKYG/7EsI1nkoqBEJnOdLKmWicIwWQ7aSueh96FGOaXsXB6qUVrNSyV
         EKOQ/k4TtkR7u+RdctKYAfWicEGk8+aflA/uTxdZm4YK5vAjI76fwLVVXnnmc5OUfIiB
         Fwb7lTPNvzFHmu+dnVcqcoax16rc5tcF4ohMzoCyOR3UL1QJEO7YuE6qX/zhbfRbdRQc
         gQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685428253; x=1688020253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRx2HMn0OgK8Wf4NKopm1Q8CsykoOI54UVBh2xPJbys=;
        b=bY1WmCv6U1xr2QrbQEVpOXHuHUVeY9bzEDWMLBw0AC1HzNqITDSue1I13IRpgaCFJj
         cs3tzXNpbXI5VpBr34xbj5eoXqcF9dWCmbeDCZBqRn3dbkHjwvoMngFvUhNTdmbRA4+C
         DI663PYSo8XsOzLIv4TxEl51J+O+Vs2GBaiwVIbV8hLIzM/WRo0nD7HokEB2iW0H0gqF
         qjcZeyv651aBysg86FoKCJUwYz13bGP2TxtzuKSnUjX53JeDcySAoym10VdBDsDOK6Nd
         zUPAmptMrSYBqd+pP+XxeSLf7P+lqWXS+gc8RyYj0trENt/xb92T65MVde+w/yTYVNyX
         wgxw==
X-Gm-Message-State: AC+VfDzzNSBG0letu0skVfGoXpNWen6l9GYd4hN0Qt7+i1Oxz+/7HE2T
	T3bB50Ytcy13XOwshwbbVUKKt+OpDMov8jVR8sbrBg==
X-Google-Smtp-Source: ACHHUZ7VY+T+ZwVCYF/3KBe7kwgfzlXyswhs3kjSmdCDzkurrXYnzPRkG3KJ4/nEiXi3nafSJ9SkA0Mxoq5VcFPA8yY=
X-Received: by 2002:a05:600c:35cb:b0:3f6:f4b:d4a6 with SMTP id
 r11-20020a05600c35cb00b003f60f4bd4a6mr57055wmq.7.1685428252928; Mon, 29 May
 2023 23:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230523025618.113937-1-john.fastabend@gmail.com> <20230523025618.113937-8-john.fastabend@gmail.com>
In-Reply-To: <20230523025618.113937-8-john.fastabend@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 May 2023 08:30:41 +0200
Message-ID: <CANn89iLNWH2=LvNdfyhBFCte5ZTsws13YBE4N263nzVStxccdQ@mail.gmail.com>
Subject: Re: [PATCH bpf v10 07/14] bpf: sockmap, wake up polling after data copy
To: John Fastabend <john.fastabend@gmail.com>
Cc: jakub@cloudflare.com, daniel@iogearbox.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org, will@isovalent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023 at 4:56=E2=80=AFAM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> When TCP stack has data ready to read sk_data_ready() is called. Sockmap
> overwrites this with its own handler to call into BPF verdict program.
> But, the original TCP socket had sock_def_readable that would additionall=
y
> wake up any user space waiters with sk_wake_async().
>
> Sockmap saved the callback when the socket was created so call the saved
> data ready callback and then we can wake up any epoll() logic waiting
> on the read.
>
> Note we call on 'copied >=3D 0' to account for returning 0 when a FIN is
> received because we need to wake up user for this as well so they
> can do the recvmsg() -> 0 and detect the shutdown.
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/core/skmsg.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index bcd45a99a3db..08be5f409fb8 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1199,12 +1199,21 @@ static int sk_psock_verdict_recv(struct sock *sk,=
 struct sk_buff *skb)
>  static void sk_psock_verdict_data_ready(struct sock *sk)
>  {
>         struct socket *sock =3D sk->sk_socket;
> +       int copied;
>
>         trace_sk_data_ready(sk);
>
>         if (unlikely(!sock || !sock->ops || !sock->ops->read_skb))
>                 return;
> -       sock->ops->read_skb(sk, sk_psock_verdict_recv);
> +       copied =3D sock->ops->read_skb(sk, sk_psock_verdict_recv);
> +       if (copied >=3D 0) {
> +               struct sk_psock *psock;
> +
> +               rcu_read_lock();
> +               psock =3D sk_psock(sk);
> +               psock->saved_data_ready(sk);
> +               rcu_read_unlock();
> +       }
>  }
>
>  void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
> --
> 2.33.0
>

It seems psock could be NULL here, right ?

What do you think if I submit the following fix ?

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a9060e1f0e4378fa47cfd375b4729b5b0a9f54ec..a29508e1ff3568583263b9307f7=
b1a0e814ba76d
100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1210,7 +1210,8 @@ static void sk_psock_verdict_data_ready(struct sock *=
sk)

                rcu_read_lock();
                psock =3D sk_psock(sk);
-               psock->saved_data_ready(sk);
+               if (psock)
+                       psock->saved_data_ready(sk);
                rcu_read_unlock();
        }
 }

