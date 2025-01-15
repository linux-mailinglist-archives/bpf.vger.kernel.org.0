Return-Path: <bpf+bounces-49000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BAA12F4F
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678641887F3B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310971DC9B7;
	Wed, 15 Jan 2025 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1N13wv9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709A24A7CC;
	Wed, 15 Jan 2025 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983975; cv=none; b=JDwh+Mi3BfT2PgCq/DYvVk0nKzKasAc67qrY4SovHG0kB2ZkBzKwGQXteFHHq+26x7wb3NUfTy9nnjTZOsOZkKfwB1mshARy6wQwPUJk6TApwpENAICRmSXycv6uAOG3UKTVuYKTLAA0LQkCJZ3Idj0a6uzEcoJ0Rre+Us4LtdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983975; c=relaxed/simple;
	bh=uDut7qKyGonHrrBJhYW5/Lp4uLQcdhQY1HJMQ9YhzS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXw3cRSjSF9ml4/qVRnUcriQ9v4EefBug6dOA7ExLl3U1iyIh4shrLkakVKQqyUTbiPwvvPP7HVawrB9hiF7P8QPUXjN29UwhipJDxVKmUOs2AWwTMBa+q49vJCGjquwwJgIQ9/najkoC6F0XD3xptVNrKwIhdZqUOVuQN2sBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1N13wv9; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so2312835ab.0;
        Wed, 15 Jan 2025 15:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736983973; x=1737588773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSS0lFIwN2tkFRw6QTSmYAoXLfz+kLpozTZYRCNeB9E=;
        b=S1N13wv9Zm5SVfddp8HX9ZqjQ12oxeD2fJAqute5zMAkzby0vp9Nu4x7mlOqZ10yV+
         7rxfQCc1nkBAwMQU/cAXzgEB1TkMno4dKdwetQCV8l+XTtzR9dtL9rmF9qZtLj/o1Zum
         UwlLpO9SF04IH9mMdfkUkxQIj3G+fLFejAjiRvSmu6EMBgH3U79Kw0dGi56UoDkNqmIh
         nmtQFwqu+f1b1TwUkbBRw4xC/9YoUv6Q6ExdqUb2G9qxvZKFFl2zECb5X/9ONnLQeXLL
         FHj+HHq7hMEJMJeBiLUQGSWhbfSTNNq0Jf9xoREaxllobcSe4dcR6BXogzgHdZpXyeo7
         Vmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736983973; x=1737588773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSS0lFIwN2tkFRw6QTSmYAoXLfz+kLpozTZYRCNeB9E=;
        b=H5vMGFHL17QoBbJy2Ua8Z9cG4PoaBqWXInB4pVKrdk8+qxR0Cfa8KJZlu4dNvnsPxa
         AFa3Z0rx6jmovWKVYDaX4yH/lDJX5wVHeIvVM0KozUdwuJOkee2xTr4jCRoylck+LQ/x
         bkuugA6UweuqarZEvgCw2C4RmqqOawHsV5awYfIAwEurlwXFdir1RcEgV+OhWQcr7QKM
         mjF4VhklQlF9d6gozw4syvs4smDKCaf+IvX/sDx6biUsOajCgdkPZaXwJ6FrjoqKpdkP
         IRx3uauwdFgVlO4HkW1Iftvrr9NUJ+SivF3yQ1qVWeRVYRF6dquGER6yKEPWh57+kODk
         gpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV75lSRLUseEu766QqENi+cCQ/HrthTviUi6EoZR0bDgG9rpxBQ6pAEJnGJ+sxZuI5THGQ=@vger.kernel.org, AJvYcCWPPwIaOWYLHaX9AMhO9DXhB5/d5Ww5pogT1IKijBpgH1yFC1V9+Yw2haUeJrJuFKJwDgXwZOt4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+8wWWQbxUUgoD1607CHHTWiJ8DHHtf9u+gufZ/9lcC1rfJIf
	yGIi3qUhIB6Kmv19f9wfcpYOOd/Y8nFK8S+UVvjKonDXJtuTbx5mvIe1rumuVEitkC/WzV6/Lug
	9Lq8wTZBe7Wq3O+HEE/RAs6ppEeE=
X-Gm-Gg: ASbGncvUe8whlulHhScWgSJL9H6jy+N9uY9t1EKUyh1dcClkRO+U5wNdeaOI+dRGGCE
	381MwqUe8NzE4C7mNzlu28lHMgW0gY+nbb+7Z
X-Google-Smtp-Source: AGHT+IHqIt/aau8e0bbrXSuATXW1l8QSkPpsXrJqlvTe6QUBiUZb/jzXVUjY4mIAivgbnNE0/3Yv0JUXnw7GrXCb7kQ=
X-Received: by 2002:a05:6e02:1fe3:b0:3ce:7d8f:3d73 with SMTP id
 e9e14a558f8ab-3ce7d8f3f50mr83749705ab.1.1736983973194; Wed, 15 Jan 2025
 15:32:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-6-kerneljasonxing@gmail.com> <ca852e76-2627-4e07-8005-34168271bf12@linux.dev>
In-Reply-To: <ca852e76-2627-4e07-8005-34168271bf12@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 07:32:16 +0800
X-Gm-Features: AbW1kvaHrSFFAdKH8gJOIbn818k2aptJZRmGYbsTAIwm7Ba20X5H_fy6BqWxq9g
Message-ID: <CAL+tcoAY9jeOmZjVqG=7=FxOdXevvOXroTosaE8QpG2bYbFE_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 05/15] net-timestamp: add strict check in some
 BPF calls
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:48=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> > In the next round, we will support the UDP proto for SO_TIMESTAMPING
> > bpf extension, so we need to ensure there is no safety problem.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   net/core/filter.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 0e915268db5f..517f09aabc92 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5571,7 +5571,7 @@ static int __bpf_getsockopt(struct sock *sk, int =
level, int optname,
> >   static int _bpf_getsockopt(struct sock *sk, int level, int optname,
> >                          char *optval, int optlen)
> >   {
> > -     if (sk_fullsock(sk))
> > +     if (sk_fullsock(sk) && optname !=3D SK_BPF_CB_FLAGS)
> >               sock_owned_by_me(sk);
> >       return __bpf_getsockopt(sk, level, optname, optval, optlen);
> >   }
> > @@ -5776,6 +5776,7 @@ BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_so=
ck_ops_kern *, bpf_sock,
> >          int, level, int, optname, char *, optval, int, optlen)
> >   {
> >       if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&
> > +         bpf_sock->sk->sk_protocol =3D=3D IPPROTO_TCP &&
> >           optname >=3D TCP_BPF_SYN && optname <=3D TCP_BPF_SYN_MAC) {
> >               int ret, copy_len =3D 0;
> >               const u8 *start;
> > @@ -5817,7 +5818,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       struct sock *sk =3D bpf_sock->sk;
> >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> >
> > -     if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> > +     if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk) ||
> > +         sk->sk_protocol !=3D IPPROTO_TCP)
> >               return -EINVAL;
> >
> >       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > @@ -7626,6 +7628,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       u8 search_kind, search_len, copy_len, magic_len;
> >       int ret;
> >
> > +     if (bpf_sock->op !=3D SK_BPF_CB_FLAGS)
>
> SK_BPF_CB_FLAGS is not an op enum, so the check is incorrect. It does bre=
ak the
> existing test.
>
> ./test_progs -t tcp_hdr_options
> WARNING! Selftests relying on bpf_testmod.ko will be skipped.
> #402/1   tcp_hdr_options/simple_estab:FAIL
> #402/2   tcp_hdr_options/no_exprm_estab:FAIL
> #402/3   tcp_hdr_options/syncookie_estab:FAIL
> #402/4   tcp_hdr_options/fastopen_estab:FAIL
> #402/5   tcp_hdr_options/fin:FAIL
> #402/6   tcp_hdr_options/misc:FAIL
> #402     tcp_hdr_options:FAIL
> #402/1   tcp_hdr_options/simple_estab:FAIL
> #402/2   tcp_hdr_options/no_exprm_estab:FAIL
> #402/3   tcp_hdr_options/syncookie_estab:FAIL
> #402/4   tcp_hdr_options/fastopen_estab:FAIL
> #402/5   tcp_hdr_options/fin:FAIL
> #402/6   tcp_hdr_options/misc:FAIL
> #402     tcp_hdr_options:FAIL
>

Right, kernel test robot also discovered this one.

>
> Many changes of this set is in bpf and the newly added selftest is also a=
 bpf
> prog, all bpf selftests should be run before posting.
> (Documentation/bpf/bpf_devel_QA.rst)
>
> The bpf CI can automatically pick it up and get an auto email on breakage=
 like
> this if the set is tagged to bpf-next. We can figure out where to land th=
e set
> later (bpf-next/net or net-next/main) when it is ready.
>
> All these changes also need a test in selftests/bpf. For example, I expec=
t there
> is a test to ensure calling these bpf helpers from the new tstamp callbac=
k will
> get a negative errno value.
>
> For patch 4 and patch 5, I would suggest keeping it simple to only check =
for
> bpf_sock->op for the helpers that make tcp_sock and/or locked sk assumpti=
on.
> Something like this on top of your patch. Untested:
>
> diff --git i/net/core/filter.c w/net/core/filter.c
> index 517f09aabc92..ccb13b61c528 100644
> --- i/net/core/filter.c
> +++ w/net/core/filter.c
> @@ -7620,6 +7620,11 @@ static const u8 *bpf_search_tcp_opt(const u8 *op, =
const
> u8 *opend,
>         return ERR_PTR(-ENOMSG);
>   }
>
> +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
> +{
> +       return bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB;

I wonder if I can use the code snippets in the previous reply in this
thread, only checking if we are in the timestamping callback?
+#define BPF_SOCK_OPTS_TS               (BPF_SOCK_OPS_TS_SCHED_OPT_CB | \
+                                        BPF_SOCK_OPS_TS_SW_OPT_CB | \
+                                        BPF_SOCK_OPS_TS_ACK_OPT_CB | \
+                                        BPF_SOCK_OPS_TS_TCP_SND_CB)

Then other developers won't worry too much whether they will cause
some safety problems. If not, they will/must add callbacks earlier
than BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

> +}
> +
>   BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_s=
ock,
>            void *, search_res, u32, len, u64, flags)
>   {
> @@ -7628,8 +7633,8 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct
> bpf_sock_ops_kern *, bpf_sock,
>         u8 search_kind, search_len, copy_len, magic_len;
>         int ret;
>
> -       if (bpf_sock->op !=3D SK_BPF_CB_FLAGS)
> -               return -EINVAL;
> +       if (!is_locked_tcp_sock_ops(bpf_sock))
> +               return -EOPNOTSUPP;

Right, thanks, I will do that.

>
>         /* 2 byte is the minimal option len except TCPOPT_NOP and
>          * TCPOPT_EOL which are useless for the bpf prog to learn
>
>
> > +             return -EINVAL;
> > +
> >       /* 2 byte is the minimal option len except TCPOPT_NOP and
> >        * TCPOPT_EOL which are useless for the bpf prog to learn
> >        * and this helper disallow loading them also.
>

