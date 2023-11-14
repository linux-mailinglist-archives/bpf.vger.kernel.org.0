Return-Path: <bpf+bounces-15059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40DF7EB0AC
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 14:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBAB1F24ACF
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E223FE57;
	Tue, 14 Nov 2023 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFvfMC4D"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860B171A1
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 13:16:05 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D819D
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 05:16:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so13941a12.0
        for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 05:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699967762; x=1700572562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq/5HnuZ3QvsazWocJwJBy4iOEknPYGft9eaTYQ8z3g=;
        b=QFvfMC4DDnsNI+HVmMv8PA+haKJHcnPxLRiqS2Vwxyb5YQd+XdOsegEDuF5wPbb+Kp
         KW1EyLgRHtWrRQp5Fx+B0u8yHW82udKLYgYyQSkaTnGga/E0FG4GST9o9BH/8X9nFIY9
         5TcuY3wX7cZ58p7seUwITFroXC6Nau7xMKLcNjBkm4BQb/ytpDDNI15H3tSkGRpdk56w
         Za+5684esQAZXkyJCEBG76/ooBT/3ojWi+UA/9JTVUzl5O/P3TXib90kQxpLvhYz99Fi
         78Hums6SNrlBb64zB0YLyL6J0tAvQ9WpFPSjHcluqxfApsQVufnYcMxfy22N3LbVOazH
         JOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699967762; x=1700572562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq/5HnuZ3QvsazWocJwJBy4iOEknPYGft9eaTYQ8z3g=;
        b=ODyxXP4Jx1urrxOCLdUVxgl+xoIBcM5HwW7LU3f8U7awdXYTM8tPlZAyJvE5M2p6LL
         lzErcybO9M2fHj45NktY7Dxh0seHvXwrCgYeyPrxBIYrIqLQKy8HXJUqoeNHbUIHvYOd
         NJyePn13o6QFQLkVGKJFfrA5C9PBS/mymt8uBAr0U59zRrgVna6Wzh/wNar1ZQGbhI4r
         Z9pH0F84assnJ3VHbgyOS3FnCw1Mkgh+3pKBMS9NDeIiz6ueYXIbDfk5RakSfTQJVNwS
         MpTKlE7fZ7ylL7NCOw3ZJaBJtBHrZA0qwTVp4XTUh6ZAgPIVtS0w7axBmQJIB7RcCyIC
         SORw==
X-Gm-Message-State: AOJu0YxmlXk/xci7pmW/STttBZCDpAviiNAmHZWu2U1BNinj3qvKayL4
	LpFIrcrdWs5OTabdPER9hc2ifG+QR8gY6f7MksAR1A==
X-Google-Smtp-Source: AGHT+IHcEj6L1nQW0PjXnF+mXXNoOF+yTsDcwGFHKfarxo5KYUPFEmX40ft/ZGySf96R2dFl+Mw9G25h8ugK5kdkgaw=
X-Received: by 2002:a50:fc15:0:b0:544:e2b8:ba6a with SMTP id
 i21-20020a50fc15000000b00544e2b8ba6amr95766edr.3.1699967761816; Tue, 14 Nov
 2023 05:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1699962120-3390-1-git-send-email-yangpc@wangsu.com> <1699962120-3390-2-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1699962120-3390-2-git-send-email-yangpc@wangsu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Nov 2023 14:15:47 +0100
Message-ID: <CANn89iKtjggJnHpXOWEV4V9GCoqpnmr8PBorX6ZM6+1ir_dB4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] skmsg: Calculate the data length in ingress_msg
To: Pengcheng Yang <yangpc@wangsu.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 12:42=E2=80=AFPM Pengcheng Yang <yangpc@wangsu.com>=
 wrote:
>
> Currently we cannot get the data length in ingress_msg,
> we introduce sk_msg_queue_len() to do this.
>
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  include/linux/skmsg.h | 24 ++++++++++++++++++++++--
>  net/core/skmsg.c      |  4 ++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index c1637515a8a4..3023a573859d 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -82,6 +82,7 @@ struct sk_psock {
>         u32                             apply_bytes;
>         u32                             cork_bytes;
>         u32                             eval;
> +       u32                             msg_len;
>         bool                            redir_ingress; /* undefined if sk=
_redir is null */
>         struct sk_msg                   *cork;
>         struct sk_psock_progs           progs;
> @@ -131,6 +132,11 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock =
*psock, struct msghdr *msg,
>                    int len, int flags);
>  bool sk_msg_is_readable(struct sock *sk);
>
> +static inline void sk_msg_queue_consumed(struct sk_psock *psock, u32 len=
)
> +{
> +       psock->msg_len -=3D len;
> +}
> +
>  static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 b=
ytes)
>  {
>         WARN_ON(i =3D=3D msg->sg.end && bytes);
> @@ -311,9 +317,10 @@ static inline void sk_psock_queue_msg(struct sk_psoc=
k *psock,
>                                       struct sk_msg *msg)
>  {
>         spin_lock_bh(&psock->ingress_lock);
> -       if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
> +       if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>                 list_add_tail(&msg->list, &psock->ingress_msg);
> -       else {
> +               psock->msg_len +=3D msg->sg.size;
> +       } else {
>                 sk_msg_free(psock->sk, msg);
>                 kfree(msg);
>         }
> @@ -368,6 +375,19 @@ static inline void kfree_sk_msg(struct sk_msg *msg)
>         kfree(msg);
>  }
>
> +static inline u32 sk_msg_queue_len(struct sock *sk)

const struct sock *sk;

> +{
> +       struct sk_psock *psock;
> +       u32 len =3D 0;
> +
> +       rcu_read_lock();
> +       psock =3D sk_psock(sk);
> +       if (psock)
> +               len =3D psock->msg_len;

This is racy against writers.

You must use READ_ONCE() here, and WRITE_ONCE() on write sides.

> +       rcu_read_unlock();
> +       return len;
> +}
> +
>  static inline void sk_psock_report_error(struct sk_psock *psock, int err=
)
>  {
>         struct sock *sk =3D psock->sk;
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 6c31eefbd777..b3de17e99b67 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -481,6 +481,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *=
psock, struct msghdr *msg,
>                 msg_rx =3D sk_psock_peek_msg(psock);
>         }
>  out:
> +       if (likely(!peek) && copied > 0)
> +               sk_msg_queue_consumed(psock, copied);
>         return copied;
>  }
>  EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
> @@ -771,9 +773,11 @@ static void __sk_psock_purge_ingress_msg(struct sk_p=
sock *psock)
>
>         list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
>                 list_del(&msg->list);
> +               sk_msg_queue_consumed(psock, msg->sg.size);
>                 sk_msg_free(psock->sk, msg);
>                 kfree(msg);
>         }
> +       WARN_ON_ONCE(psock->msg_len !=3D 0);
>  }
>
>  static void __sk_psock_zap_ingress(struct sk_psock *psock)
> --
> 2.38.1
>

