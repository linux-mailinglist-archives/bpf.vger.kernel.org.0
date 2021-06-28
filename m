Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706663B65DE
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhF1PlP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbhF1PlF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 11:41:05 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCAC08ED8E
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 07:52:54 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c8so18999052ybq.1
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYLutEvMYIfZinEiWGKyAJ7H0pxGUzBzdhu6yQBXQiU=;
        b=NNF8m9YHL731PTEUPT9jRJ1Q0bYi8Dyl/M7BYPqCO+0H3vFGAs5Hqvl3J3EJnfOsso
         6bkDsTJuI/EWf8udfG+br3cHu4MejupGkv2/7O7skXXp01Ey8kfO40Tb0It515+isBNq
         4/T7/n5TxteHuz4zEqJTGEbWr0Dpma+7TvlX7WtGfIJU729OKb/9K5qv4QQILEDaIwPb
         fkzRkLrChufF4zO+J5QEHdba2lT9gLTcuk+Q4TfD+58vXL0BchXwE+pRy3T0K+bv/EFf
         8Wh/3EnR8QnO3x/LCM31UoPK1WHlacIn7QoUiKnv49U5D2wn3z3Eg3t+YSSsWOQVOeUC
         bAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYLutEvMYIfZinEiWGKyAJ7H0pxGUzBzdhu6yQBXQiU=;
        b=EohMqf/MJylD6y/6rTN8SH/Lh+vW7IPo344rmh6DR/BwpnLEnLf7cWqYFq+PD2+Itf
         /pUANjFq9z8V1ZTHd3zL7O09iOdAQ3CCHLpAI4fShQZ3q2CS5PUHrB8XtS7WqptHDWiN
         u4skur+ujOEh7TI/YJT4j96lmWzmE+GV22zeVxbHMaaltUKqci0LRl27quI+KMmDRTZy
         KqaozfdwZ5C1SgYNYxzuhXHuUVmKIlQ1dtsz+Uvna+Z13JqmXET03azcmZO4GJkPKuHe
         G/UnNH8zG7Iwk1Pkpe0hAxp7lCGeBHaSyp1ON6ZVd7f5bAvSCC4KwFGEHnleo6Q5zBt4
         SimA==
X-Gm-Message-State: AOAM533jP7NsU4/8iFMAcZNJTs+mi7Vxob7sVnpn+IG8uVwU536V6W7d
        jGl+RHCMrAY0wA7Us4bnL5YdfUL2GVH5nErRAU147w==
X-Google-Smtp-Source: ABdhPJwfm4cGKBTTeOHl72F6wYi6baCmzltv8WAuECamcwIZ0w//hv+00frei2DspO51IU3sskbzVXzu42YbZD6/7ks=
X-Received: by 2002:a25:8081:: with SMTP id n1mr34237963ybk.253.1624891973002;
 Mon, 28 Jun 2021 07:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210628144908.881499-1-phind.uet@gmail.com>
In-Reply-To: <20210628144908.881499-1-phind.uet@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 28 Jun 2021 16:52:41 +0200
Message-ID: <CANn89iJ6M2WFS3B+sSOysekScUFmO9q5YHxgHGsbozbvkW9ivg@mail.gmail.com>
Subject: Re: [PATCH] tcp: Do not reset the icsk_ca_initialized in tcp_init_transfer.
To:     Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, kpsingh@kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f1e24a0594d4e3a895d3@syzkaller.appspotmail.com,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 28, 2021 at 4:49 PM Nguyen Dinh Phi <phind.uet@gmail.com> wrote:
>
> icsk_ca_initialized be always set to zero before we examine it in if
> block, this makes the congestion control module's initialization be
> called even if the CC module was initialized already.
> In case the CC module allocates and setups its dynamically allocated
> private data in its init() function, e.g, CDG, the memory leak may occur.
>
> Reported-by: syzbot+f1e24a0594d4e3a895d3@syzkaller.appspotmail.com
>
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7d5e59f688de..855ada2be25e 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5922,7 +5922,6 @@ void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb)
>                 tp->snd_cwnd = tcp_init_cwnd(tp, __sk_dst_get(sk));
>         tp->snd_cwnd_stamp = tcp_jiffies32;
>
> -       icsk->icsk_ca_initialized = 0;

Unfortunately this patch might break things.

We keep changing this CC switching, with eBPF being mixed in the equation.

I would suggest you find a Fixes: tag first, so that we can continue
the discussion.

Thank you.

>         bpf_skops_established(sk, bpf_op, skb);
>         if (!icsk->icsk_ca_initialized)
>                 tcp_init_congestion_control(sk);
> --
> 2.25.1
>
