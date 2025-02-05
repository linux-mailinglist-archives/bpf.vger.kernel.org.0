Return-Path: <bpf+bounces-50492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A794A283B1
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 06:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B411887604
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 05:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18F21D5AB;
	Wed,  5 Feb 2025 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKYVB7wz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16DD215175;
	Wed,  5 Feb 2025 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733375; cv=none; b=Rgpmj5g62e3p+9YOCQsHleCVlBrG+foH2qhzxiDQHug7smegnYQNXsdALeeJyBv4yR6re+xZNngGMtTyyQN05v/hCIkqxGo9Vm9jsW9u8tCj44wAZcZceSj3S7qjCNu8lItAMLFi0wPl2Cv03rn0mAl3tAyJ+PAazb0h5WWL59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733375; c=relaxed/simple;
	bh=Iw3ZqYkAInzv/YtkuUTeED6Mt5mLGRiWR39/xFZzkGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbTBQ0CpsmPWQxvNBCC2cpZovVuE52MSvWK/sRwGfCkVAwEPkvZPAZH3GZ3G63ZLTr2NlI9P3fxv+wpbmHaYkh2zRfcQUi/CLqqYCzGxzQ5mNkc+3n/HtYOxb+MLgwjLRxwuYe9jTU6acoFu8z+2Oj8bvZFcAEM52UOk3aVronM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKYVB7wz; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so16563665ab.2;
        Tue, 04 Feb 2025 21:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738733373; x=1739338173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xCAtFthzUILMlk/nBinSbXdAsksty0ic3+RdeNqlvc=;
        b=NKYVB7wzuEhG+jGyGDwiw5BJZ/JS0bAmrBi2NkHylHfHHyw+GOBIksRh66teSO8ewJ
         4sDkgULkE0cQAqVfxu3yQf1sZ1Jw6KLmQbjR+A2lQQ6IKIj7uqQgQc5YyS7eruUHW/xY
         GAn4BTQvu/T7iIeXFBaE6qcnH/5u9TfWpD9jEYDd6E1sBiu0dK56Ed9RZsID6gKRRpuA
         mnVq7FhuaAifEhREZqFw+ZjHN1vuN2enWb7nbyMxTJgrU7VwkFjWHCGdtZFxAHK7W1h1
         6G6+2kLTsQf+U5tR+CeUAWtQcKc3C1MBLw07ikQA+BAN8vi6Wo5RZ2/3UkXKn4nURaL3
         pNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738733373; x=1739338173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xCAtFthzUILMlk/nBinSbXdAsksty0ic3+RdeNqlvc=;
        b=SuK2OKgjFEl2QFbZ/l25xCpuyplOYjQBwIXwtBGsUzJly2BN6E/L8TbVJawHgndtJd
         wLnv97BA3Q9PEfyqang3QxFjmQwZbf3zWBVOuQOXgd7f3mMAoZzitOpJAeytSL/HGDag
         SjwzB2b3kNQxI29X5qC8pmF2zKRoWzVCtvnEOZm5nB/Tdw1KdQgHC7zYXSbcgBhideLT
         hni+VqJ1zqirfw9I69WOgIdJeWrfN410nxlyFs3mi2r8uvUdDV/X7KFmlm8meCgvDbqJ
         a+2ojcAaq9MJ2dfgytFo6zZHsJZE8wAft6p8YWiXPhqMJcIh4IkV5Ze7EmHSuacWRQSg
         3f5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCwEF5JzU9ccnu2ep8AMQdakSPgpo7U7dul4zydd5ANUnmp3pc8qISTDPahZvHhn/kciBvGUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLQz6KgD3ddhAmn1zWPHynmdquU7knwDXnYgYla8IR5KB0UKd
	4VD1pIo85ONcuRLgUjlhfc0soplvB2DSF2HV7+RqItlgW3wIDI6w1BMnjvpTJ3WaHgeHdo85NK+
	vqP/iidGWMhnqjqQ5j21lCcApJcQ=
X-Gm-Gg: ASbGncvUEydHuksg2NfnyfcaRQCjHdcr5l0hyE7hLBDYsm7PLVjzt1B0XFGVHXiwRjf
	wjrImqsRxPa+dUEEXcdETNhOaahKZrHWGXnq81fvh1fl/1NZ6apLYYXhgpNZbC7vu0FJr+GRy
X-Google-Smtp-Source: AGHT+IHqg4rDuY6UhhQM6VJrr3ELdp0t1sngVP8iIkRlqbHryp800M7/eVfa5URyoiePfXnA0O46a9FMWrLuuluDm3o=
X-Received: by 2002:a05:6e02:b2c:b0:3d0:10a6:99b9 with SMTP id
 e9e14a558f8ab-3d04f403739mr15033115ab.3.1738733372813; Tue, 04 Feb 2025
 21:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com> <20250204183024.87508-12-kerneljasonxing@gmail.com>
In-Reply-To: <20250204183024.87508-12-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 13:28:56 +0800
X-Gm-Features: AWEUYZk_J81XzHsX0m1EILv7L01_T2tFYdbI3uTcLZKcUladNhocpfGSG8tG2dE
Message-ID: <CAL+tcoCmXcDot-855XYU7PKCiGvJL=O3CQBGuOTRAs2_=Ys=gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 11/12] bpf: add a new callback in tcp_tx_timestamp()
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 2:31=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Introduce the callback to correlate tcp_sendmsg timestamp with other
> points, like SND/SW/ACK. let bpf prog trace the beginning of
> tcp_sendmsg_locked() and then store the sendmsg timestamp at
> the bpf_sk_storage, so that in tcp_tx_timestamp() we can correlate
> the timestamp with tskey which can be found in other sending points.
>
> More details can be found in the selftest:
> The selftest uses the bpf_sk_storage to store the sendmsg timestamp at
> fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_timestamp
> (i.e. BPF_SOCK_OPS_TS_SND_CB added in this patch).
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 7 +++++++
>  net/ipv4/tcp.c                 | 1 +
>  tools/include/uapi/linux/bpf.h | 7 +++++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 800122a8abe5..accb3b314fff 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7052,6 +7052,13 @@ enum {
>                                          * when SK_BPF_CB_TX_TIMESTAMPING
>                                          * feature is on.
>                                          */
> +       BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendmsg sysc=
all
> +                                        * is triggered. For TCP, it stay=
s
> +                                        * in the last send process to
> +                                        * correlate with tcp_sendmsg tim=
estamp
> +                                        * with other timestamping callba=
cks,
> +                                        * like SND/SW/ACK.
> +                                        */
>  };

In case the use of the new flag is buried in many threads, I decide to
rephrase here to manifest how UDP would use it:
1. introduce a field ts_opt_id_bpf which works like ts_opt_id[1] to allow
the bpf program to fully take control of the management of tskey.
2. use fentry hook udp_sendmsg(), and introduce a callback function
like BPF_SOCK_OPS_TIMEOUT_INIT in kernel to initialize the
ts_opt_id_bpf with tskey that bpf prog generates. We can directly use
BPF_SOCK_OPS_TS_SND_CB.
3. modify the SCM_TS_OPT_ID logic to support bpf extension so that the
newly added field ts_opt_id_bpf can be passed to the
skb_shinfo(skb)->tskey in __ip_append_data().

In this way, this approach can also be extended for other protocols.

[1]
commit 4aecca4c76808f3736056d18ff510df80424bc9f
Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Date:   Tue Oct 1 05:57:14 2024 -0700

    net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message

    SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
    timestamps and packets sent via socket. Unfortunately, there is no way
    to reliably predict socket timestamp ID value in case of error returned
    by sendmsg. For UDP sockets it's impossible because of lockless
    nature of UDP transmit, several threads may send packets in parallel. I=
n
    case of RAW sockets MSG_MORE option makes things complicated. More
    details are in the conversation [1].
    This patch adds new control message type to give user-space
    software an opportunity to control the mapping between packets and
    values by providing ID with each sendmsg for UDP sockets.
    The documentation is also added in this patch.

    [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_=
B9Eaa9aDPfgHdtA@mail.gmail.com/

Thanks,
Jason

>
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detec=
t
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 3df802410ebf..a2ac57543b6d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -501,6 +501,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct =
sockcm_cookie *sockc)
>                 tcb->txstamp_ack_bpf =3D 1;
>                 shinfo->tx_flags |=3D SKBTX_BPF;
>                 shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> +               bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_CB=
);
>         }
>  }
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 06e68d772989..384502996cdd 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7045,6 +7045,13 @@ enum {
>                                          * when SK_BPF_CB_TX_TIMESTAMPING
>                                          * feature is on.
>                                          */
> +       BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendmsg sysc=
all
> +                                        * is triggered. For TCP, it stay=
s
> +                                        * in the last send process to
> +                                        * correlate with tcp_sendmsg tim=
estamp
> +                                        * with other timestamping callba=
cks,
> +                                        * like SND/SW/ACK.
> +                                        */
>  };
>
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detec=
t
> --
> 2.43.5
>

