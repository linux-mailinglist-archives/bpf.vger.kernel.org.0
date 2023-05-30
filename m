Return-Path: <bpf+bounces-1427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805DC715AEA
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 12:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231361C20BC4
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B8168D2;
	Tue, 30 May 2023 10:01:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794B14264
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:01:13 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A093
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 03:01:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso11389a12.0
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685440869; x=1688032869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfzfeMtirG5QHJLiHd4JBm4644BE/2DpR8F2CXOzA6E=;
        b=qCFFn90BdrsPrk3a85q++FOBXx412EpZvXib9VRrAyNla0ozGWXyQWe0uzw5vclo00
         4wu4kw4bZGVZMPYqXhNbBabc8fLnCSrGrNTWjYFNSYk3F6YLH/NCfJ/VM4dRI7/jJSny
         4wt42UBxMO0y8pRkyqWBcT/CEuNUeOHyW567nAse3OF5RNJCrMy519pAbhX+n6+8y8C0
         9bq5A5vJMOeW6vk+N7FKfrRkChXWft5hD+tnOEUFK1ah4bAql8pMzhjdqlT19g6WzxMx
         M47VXij8bmhGiC8E6MaF/UTdQ3qHemoOfAYqIw4opgNoMV3ePZO13w5OoDe1XZK8PlLO
         NrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440869; x=1688032869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfzfeMtirG5QHJLiHd4JBm4644BE/2DpR8F2CXOzA6E=;
        b=QuBkP/ED8x142uhJFVCc+FYv0VnBvSD7OHsGgsX9rkgqGi06/IOe+U5bfYwaybgBQg
         uJQaUxCoDQmSTG1supBV9OajrUQ6C+Ky559lsHoDlr21yVD1VdQ2TKP0EdwYJvpAUA6Z
         HwFt9OGuxcm+cfgeH5YRilCtExjHDmM+w/n+o0zGnoovItk47Y3HYy/d6jBOdGxEPQwR
         WqVNShTxkVwOXh7wr+WqqNBke9KQ+7p7qn0vIF9pdV7z8CfZorR/SLRn4m/xICx2ZbbZ
         mdOEPsOmSIQijp5qK5bAjdGuTsXIGgacd74+MP9UeHcoNrjfUnRRVCszJUFwTkwblw/Y
         Jz/w==
X-Gm-Message-State: AC+VfDwrE9GinfFvtv2atWJVSE4+5g8w0gcf/cBycVUdd/IT/Z37ucqc
	DAAKWKGf+a2kgPFMyMNz/vuRZYXVKb+VxjHOrn0orw==
X-Google-Smtp-Source: ACHHUZ4Z953gbTjg3G6TgfdpzbYu2dSye2Tm2xqrdJ9ob2GcE94JsTQuL/VIVlz5VhEwqV7mN2jfK8mADZuq1fPU9AU=
X-Received: by 2002:a50:c059:0:b0:506:c207:c979 with SMTP id
 u25-20020a50c059000000b00506c207c979mr75079edd.0.1685440869312; Tue, 30 May
 2023 03:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230529113804.GA20300@didi-ThinkCentre-M920t-N000>
 <CANn89iJw3Ehoj7GfYnc6Xv5N2wULqNuP3zNBwQx97i-YJD5avg@mail.gmail.com> <CAL+tcoCRgpoYgQXdM2Es0gjRtRZj1hCK-5M04WZ1sy3vt_5JjA@mail.gmail.com>
In-Reply-To: <CAL+tcoCRgpoYgQXdM2Es0gjRtRZj1hCK-5M04WZ1sy3vt_5JjA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 May 2023 12:00:57 +0200
Message-ID: <CANn89iKCKTg0ExMRAxXWK200Q6UX2DeuUQzZzbZevt5kST7qQA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: introduce a compack timer handler in sack compression
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: toke@toke.dk, Yuchung Cheng <ycheng@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	zhangweiping <zhangweiping@didiglobal.com>, tiozhang <tiozhang@didiglobal.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 30, 2023 at 9:45=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, May 30, 2023 at 3:12=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, May 29, 2023 at 1:38=E2=80=AFPM fuyuanli <fuyuanli@didiglobal.c=
om> wrote:
> > >
> > > We've got some issues when sending a compressed ack is deferred to
> > > release phrase due to the socket owned by another user:
> > > 1. a compressed ack would not be sent because of lack of ICSK_ACK_TIM=
ER
> > > flag.
> >
> > Are you sure ? Just add it then, your patch will be a one-liner
> > instead of a complex one adding
> > more code in a fast path.
>
> Honestly, at the very beginning, we just added one line[1] to fix
> this. After I digged more into this part, I started to doubt if we
> should reuse the delayed ack logic.
>
> Because in the sack compression logic there is no need to do more
> things as delayed ack does in the tcp_delack_timer_handler() function.
>
> Besides, here are some things extra to be done if we defer to send an
> ack in sack compression:
> 1) decrease tp->compressed_ack. The same as "tp->compressed_ack--;" in
> tcp_compressed_ack_kick().
> 2) initialize icsk->icsk_ack.timeout. Actually we don't need to do
> this because we don't modify the expiration time in the sack
> compression hrtimer.

Yes, we do not need this, see my following comment.

> 3) don't need to count the LINUX_MIB_DELAYEDACKS counter.
> 4) I wonder even if those checks about the ack schedule or ping pong
> mode in tcp_delack_timer_handler() for sack compression? I'm not sure
> about it.
>
> So one line cannot solve it perfectly. That's the reason why we
> introduce a new logic which can be clearer.
>
> I'm wondering if adding one check in the fast path is really that
> unacceptable (it may hurt performance?) because a new logic would be
> clearer for the whole sack compression.

We definitely can solve the minor issue by not polluting the fast path.

We also want simple/localised fixes, not something invasive (and risky).

>
> [1]
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index cc072d2cfcd8..d9e76d761cc6 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5568,6 +5568,7 @@ static void __tcp_ack_snd_check(struct sock *sk,
> int ofo_possible)
>
> READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_comp_sack_delay_ns),
>                       rtt * (NSEC_PER_USEC >> 3)/20);
>         sock_hold(sk);
> +       inet_csk(sk)->icsk_ack.pending |=3D ICSK_ACK_TIMER;

Why not simply use existing storage/variables (tp->compressed_ack),
instead of trying
to reuse something else or add another bit, then complain that this
does not work well ?

Again, just fix tcp_delack_timer_handler(), it already can fetch existing s=
tate.

As a bonus, no need to send one patch for net, and another in net-next,
trying to 'fix' issues that should have been fixed cleanly in a single patc=
h.

Something like:

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index b839c2f91292f7346f33d6dcbf597594473a5aca..16bc4cedceb8a5e88f61f9abc2c=
0a8cc9322676a
100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -290,10 +290,20 @@ static int tcp_write_timeout(struct sock *sk)
 void tcp_delack_timer_handler(struct sock *sk)
 {
        struct inet_connection_sock *icsk =3D inet_csk(sk);
+       struct tcp_sock *tp =3D tcp_sk(sk);

-       if (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-           !(icsk->icsk_ack.pending & ICSK_ACK_TIMER))
+       if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+               return;
+
+       if (!(icsk->icsk_ack.pending & ICSK_ACK_TIMER) &&
+           !tp->compressed_ack)
+               return;
+
+       if (tp->compressed_ack) {
+               tcp_mstamp_refresh(tp);
+               tcp_sack_compress_send_ack(sk);
                return;
+       }

        if (time_after(icsk->icsk_ack.timeout, jiffies)) {
                sk_reset_timer(sk, &icsk->icsk_delack_timer,
icsk->icsk_ack.timeout);
@@ -312,7 +322,7 @@ void tcp_delack_timer_handler(struct sock *sk)
                        inet_csk_exit_pingpong_mode(sk);
                        icsk->icsk_ack.ato      =3D TCP_ATO_MIN;
                }
-               tcp_mstamp_refresh(tcp_sk(sk));
+               tcp_mstamp_refresh(tp);
                tcp_send_ack(sk);
                __NET_INC_STATS(sock_net(sk), LINUX_MIB_DELAYEDACKS);
        }

