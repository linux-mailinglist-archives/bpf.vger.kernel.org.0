Return-Path: <bpf+bounces-16358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94DE8006CC
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734462818E4
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466B1D52A;
	Fri,  1 Dec 2023 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrTrde4t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFC210FA
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 01:25:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so8566a12.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 01:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701422707; x=1702027507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpuHkvYIHjfaj/7wkuIRYM/5cAduhtZwoG9XtdjUr3E=;
        b=GrTrde4t+GxAfF6RwGhlLm0/BMkAelaRyOC8F/SREsnaNffTb6QMeGZrQ8YO7pHpib
         WDZcizWsjJG2uvzEtn5WV41bYM3WedM9LLv6Zc/xEx7PrcGUD8zH49Jhd1r4TX324Uzk
         hnwYWsNXJU9BqQxKlXREOs0dkmeARcNqAqHkDgy5Fylb7mM/tQTQO6M6OkO0y2Jq6XXU
         ihGlgeKjDiphCAZdDlem8MyuiU/eyl0np5JDMTxmdRq3oSr1EhF3b6XUX5vF30YgLyuI
         kflobAQ1Tj6yVv3Sg+JsP8D43cyCJ4s9t1ThDvCClVkQ92viiNDRxBBuRlO5Jj+cO12D
         jvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701422707; x=1702027507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpuHkvYIHjfaj/7wkuIRYM/5cAduhtZwoG9XtdjUr3E=;
        b=VzNr8rIHeKZ7vl2Aevre5jHBGElhL/1TF1tvxtUCK1ylXDDnSZAtnZyGNPJaXtbMSM
         Zy6cxTgJN/qjT3trQru/iscWRXqmnp6fSjpwqHbpYGzvTW3cD1aK6U7egT+O9sWJztzr
         Tl4WuNG6nfovYyM5Wz3+qyofcJQjx7caNuVeUI3NhFcbfXR/5cBR+vEXvkKd4rkhTElI
         wpyuMWFPNQ3T1z1dsi/wn0tLPT3I8fteN7wtD88yVb98yPoHxPikdbfoiNwtemT1HabD
         1OYIhyolOlT77GoWmtH02EkI53cHvmksFfFyS8WGSEu8Yc45hnM2DCvJWflWRZfpMKHR
         OEWw==
X-Gm-Message-State: AOJu0YyfvEeXA7Oir8v2O44o6EQu/+D5xXrB+8wLGY2Xof/Xf924FH/g
	omsGVfLBlBU2p2b0qtoMnklsCzjOi8jfBp9UizB+rg==
X-Google-Smtp-Source: AGHT+IFg3+uQ3wCnfg5unmv42aiK8scgSNkfK+GcyeojlSOSE5Gca1udFD5HqBbv+gD7abSS4R4lI5Pb/m23JlUxqAs=
X-Received: by 2002:a50:bb48:0:b0:54b:bf08:a95f with SMTP id
 y66-20020a50bb48000000b0054bbf08a95fmr118186ede.6.1701422706962; Fri, 01 Dec
 2023 01:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201032316.183845-1-john.fastabend@gmail.com> <20231201032316.183845-2-john.fastabend@gmail.com>
In-Reply-To: <20231201032316.183845-2-john.fastabend@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Dec 2023 10:24:53 +0100
Message-ID: <CANn89iJahyHqkMsUMPoz0xPCKE9miy0AC-P_cBYKGnLWEWX3zw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: syzkaller found null ptr deref in unix_bpf
 proto add
To: John Fastabend <john.fastabend@gmail.com>
Cc: kuniyu@amazon.com, jakub@cloudflare.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 4:23=E2=80=AFAM John Fastabend <john.fastabend@gmail=
.com> wrote:
>
> I added logic to track the sock pair for stream_unix sockets so that we
> ensure lifetime of the sock matches the time a sockmap could reference
> the sock (see fixes tag). I forgot though that we allow af_unix unconnect=
ed
> sockets into a sock{map|hash} map.
>
> This is problematic because previous fixed expected sk_pair() to exist
> and did not NULL check it. Because unconnected sockets have a NULL
> sk_pair this resulted in the NULL ptr dereference found by syzkaller.
>
> BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x430 net=
/unix/unix_bpf.c:171
> Write of size 4 at addr 0000000000000080 by task syz-executor360/5073
> Call Trace:
>  <TASK>
>  ...
>  sock_hold include/net/sock.h:777 [inline]
>  unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
>  sock_map_init_proto net/core/sock_map.c:190 [inline]
>  sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
>  sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
>  sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
>  bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167
>
> We considered just checking for the null ptr and skipping taking a ref
> on the NULL peer sock. But, if the socket is then connected() after
> being added to the sockmap we can cause the original issue again. So
> instead this patch blocks adding af_unix sockets that are not in the
> ESTABLISHED state.


This (and the name chosen for sk_is_unix() helper) is a bit confusing ?

When you say "af_unix sockets" you seem to imply STREAM sockets.


>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot+e8030702aefd3444fb9e@syzkaller.appspotmail.com
> Fixes: 8866730aed51 ("bpf, sockmap: af_unix stream sockets need to hold r=
ef for pair sock")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  include/net/sock.h  | 5 +++++
>  net/core/sock_map.c | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 1d6931caf0c3..ea1155d68f0b 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2799,6 +2799,11 @@ static inline bool sk_is_tcp(const struct sock *sk=
)
>         return sk->sk_type =3D=3D SOCK_STREAM && sk->sk_protocol =3D=3D I=
PPROTO_TCP;
>  }
>
> +static inline bool sk_is_unix(const struct sock *sk)

Maybe sk_is_stream_unix() ?

> +{
> +       return sk->sk_family =3D=3D AF_UNIX && sk->sk_type =3D=3D SOCK_ST=
REAM;
> +}
> +
>  /**
>   * sk_eat_skb - Release a skb if it is no longer needed
>   * @sk: socket to eat this skb from
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 4292c2ed1828..448aea066942 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -536,6 +536,8 @@ static bool sock_map_sk_state_allowed(const struct so=
ck *sk)
>  {
>         if (sk_is_tcp(sk))
>                 return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LIS=
TEN);
> +       if (sk_is_unix(sk))
> +               return (1 << sk->sk_state) & TCPF_ESTABLISHED;
>         return true;
>  }
>
> --
> 2.33.0
>

