Return-Path: <bpf+bounces-51142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7F9A30A99
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE30161F62
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB6A236A7C;
	Tue, 11 Feb 2025 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIW3Oxyy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F991FBC84;
	Tue, 11 Feb 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273892; cv=none; b=tNy3wVaHUUaEKH85ANRHXHMFfn90Fqph3AIaQpJx3x4TYsxEH/mIHjYEga6KEn/i+lshzI+wPvA+Th1SExEZO0NQyMM+RRlm1So2tmvJRzPFsgs7boQ6grumcA9sCafHgBNynLISjR4egSuBkOAgfBxkB1ME6fr/++OOvBzxqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273892; c=relaxed/simple;
	bh=PPcldizyd35AmDnse3H/emAMUaN2besl/YaTxtie2KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE8nz4Tj36+kzDtdDVcHZ3mXR8/VFrr6y+E+AuKJgYsrejFnWnUceFYZMkaA30CJvfNMmjGiEu8GlxgwYSKiNFnX4/nGBV7MtSy8MfdQJHhAPltL1fws33LOkDjX0yZfoQ3oEszoSgL0WE1K/JgTmZDIJyn7rK+OAAYBNClCAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIW3Oxyy; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d0558c61f4so16775775ab.0;
        Tue, 11 Feb 2025 03:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739273890; x=1739878690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUPnhzUplifY7NNI2jvDoHQfDVdBEnc0QdotGnoAuww=;
        b=OIW3OxyyQQaGHy/q9z110ORKGJeSSUCqFJZG4Nvyzy+IHKIQY2ArKg3uA1loXBqQRN
         ZsvgBvczOyNBAsDQcdB2pVPbcppbXRw9SC3emFzPX0vcQwdAJ5Nqr3oYA5p8RGWWnB9O
         yzNDrk878wK/pVmM7ZmiCy29GKwpnAIDcywpZcQLDYkRM5RmOtSIFvLO38oKqjIsmC/3
         twWc3RcZXPjsM2Bst2lEWaBdtaeEICbt/ioFxO69M+wKiEASQGJjF1IqKmJoXOPUaAo+
         +rrcrVgDhuAu+4znjgEvB7O0pAz5LJ6U2PD2wPNGZTLTy/Sxs4i7zpS+5zKrxOgoYda+
         MkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739273890; x=1739878690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUPnhzUplifY7NNI2jvDoHQfDVdBEnc0QdotGnoAuww=;
        b=ljigcDOtuoZ7iev49tkUduanR/rIDni0upgO/zV6IXlRGGRXft2roOGrIkBGEwb+B+
         dgwIvaZ40EtKPv4Jyirh5/+xPvUYvHbCzn7enerbiaB8bDE8MLhFJrl73CLbzgpLolyv
         1A/QGJ0ALzvg4qULox7FtW0i8FW10EPoa9z3R/SxvKw4Z39ys/WAhHuxxvVdJe4rKdJG
         jljIJNUKNndOUjv+Y3w5FIEEtPl9hdMf908+BQsoWv7fia6sNrD9P4oLO9qpZsZ5hFQc
         SB3k8eORvpzxXR1M4bumZzhjz8yZEPwaghURgm9jY9/My8rFH0/Vd7BokmyIyVJ+a7Cv
         EUqg==
X-Forwarded-Encrypted: i=1; AJvYcCUk1Xv6Zb9osQZcjq4VHLoh3uOb2jY3jqwdkEVfdBVbQHdjtIQ+BAvwCo/+Pv8rcQZupH8=@vger.kernel.org, AJvYcCXljjgqUvAC5pEn4txwwcGcQN/cMuDrzqpdb4iZZt8JvRrBDp7YMExqABiP4klbG7HtgidOl/2R@vger.kernel.org
X-Gm-Message-State: AOJu0Yym8sYcby7CTVXpaliPC/qTGpwdM9ZBnNvUBYHqdFTmisbfU6nw
	DStqjNzmox5Xd1vk8vu+VfTFwlvN/5Dqhy4DsIVeLnzIimVRa7dvMjmCqrD2Dy6462i7HxzL7MB
	Ox8uAu84toy6HUuhGQOB/P/+Cdw0=
X-Gm-Gg: ASbGncvXQvGHWN87w0vLTw77W3PYXkH0Exj6ezOrWo/O6U+61Asm3459xn4xp++dlyU
	5R10dvMRTB++dfKmRyXG4IRtVTm58m3PWklGTqXAnnAie2Ls9IdeGc3PqZHJvdgJXZfXk3Gvu
X-Google-Smtp-Source: AGHT+IGWbdajTatltzr4oCnQHwIbu5XVyYBmquFfauxVeIMmpGmMciY8nD2dCzSFCuYsVYZXgx7pylZYTrsJzwD9Zxk=
X-Received: by 2002:a05:6e02:1aad:b0:3cf:ba90:6ad9 with SMTP id
 e9e14a558f8ab-3d16f4963bbmr25984895ab.9.1739273889998; Tue, 11 Feb 2025
 03:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-13-kerneljasonxing@gmail.com> <520cad5d-e6ab-49fe-a0f2-daa522805e19@linux.dev>
In-Reply-To: <520cad5d-e6ab-49fe-a0f2-daa522805e19@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 19:37:33 +0800
X-Gm-Features: AWEUYZkwnzBLjnm-olg7VBW7tRkOFnes3s2JkNQiLmA9Dq54SEsDX0Ni9-oMwYs
Message-ID: <CAL+tcoBp4qj-Q3w3tb3U-qHnDpmjhmcJ7xBpDXYj+q-SHcf+Nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
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

On Tue, Feb 11, 2025 at 4:05=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/8/25 2:32 AM, Jason Xing wrote:
> > ---
> >   .../bpf/prog_tests/so_timestamping.c          |  79 +++++
> >   .../selftests/bpf/progs/so_timestamping.c     | 312 +++++++++++++++++=
+
>
> A bike shedding. s/so_timestamping.c/net_timestamping.c/

Will rename them.

>
> > diff --git a/tools/testing/selftests/bpf/progs/so_timestamping.c b/tool=
s/testing/selftests/bpf/progs/so_timestamping.c
> > new file mode 100644
> > index 000000000000..4974552cdecb
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
> > @@ -0,0 +1,312 @@
> > +#include "vmlinux.h"
> > +#include "bpf_tracing_net.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "bpf_misc.h"
> > +#include "bpf_kfuncs.h"
> > +#define BPF_PROG_TEST_TCP_HDR_OPTIONS
> > +#include "test_tcp_hdr_options.h"
> > +#include <errno.h>
> > +
> > +#define SK_BPF_CB_FLAGS 1009
> > +#define SK_BPF_CB_TX_TIMESTAMPING 1
> > +
> > +int nr_active;
> > +int nr_snd;
> > +int nr_passive;
> > +int nr_sched;
> > +int nr_txsw;
> > +int nr_ack;
> > +
> > +struct sockopt_test {
> > +     int opt;
> > +     int new;
> > +};
> > +
> > +static const struct sockopt_test sol_socket_tests[] =3D {
> > +     { .opt =3D SK_BPF_CB_FLAGS, .new =3D SK_BPF_CB_TX_TIMESTAMPING, }=
,
> > +     { .opt =3D 0, },
> > +};
> > +
> > +struct loop_ctx {
> > +     void *ctx;
> > +     const struct sock *sk;
> > +};
> > +
> > +struct sk_stg {
> > +     __u64 sendmsg_ns;       /* record ts when sendmsg is called */
> > +};
> > +
> > +struct sk_tskey {
> > +     u64 cookie;
> > +     u32 tskey;
> > +};
> > +
> > +struct delay_info {
> > +     u64 sendmsg_ns;         /* record ts when sendmsg is called */
> > +     u32 sched_delay;        /* SCHED_OPT_CB - sendmsg_ns */
> > +     u32 sw_snd_delay;       /* SW_OPT_CB - SCHED_OPT_CB */
> > +     u32 ack_delay;          /* ACK_OPT_CB - SW_OPT_CB */
> > +};
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_SK_STORAGE);
> > +     __uint(map_flags, BPF_F_NO_PREALLOC);
> > +     __type(key, int);
> > +     __type(value, struct sk_stg);
> > +} sk_stg_map SEC(".maps");
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __type(key, struct sk_tskey);
> > +     __type(value, struct delay_info);
> > +     __uint(max_entries, 1024);
> > +} time_map SEC(".maps");
> > +
> > +static u64 delay_tolerance_nsec =3D 10000000000; /* 10 second as an ex=
ample */
> > +
> > +extern int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *sko=
ps) __ksym;
> > +
> > +static int bpf_test_sockopt_int(void *ctx, const struct sock *sk,
> > +                             const struct sockopt_test *t,
> > +                             int level)
>
> This should be the only one that is needed even when supporting the futur=
e RX
> timestamping.
>
> TX and RX timestamping need to be tested independently. Looping it will e=
ither
> enabling them together or disabling them together. It cannot test whether=
 RX
> will work by itself.
>
> Thus, the bpf_loop won't help. Lets remove it to simplify the test.

Got it. Will remove it.

>
> > +{
> > +     int new, opt, tmp;
> > +
> > +     opt =3D t->opt;
> > +     new =3D t->new;
> > +
> > +     if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
> > +             return 1;
> > +
> > +     if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
> > +         tmp !=3D new)
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int bpf_test_socket_sockopt(__u32 i, struct loop_ctx *lc)
> > +{
> > +     const struct sockopt_test *t;
> > +
> > +     if (i >=3D ARRAY_SIZE(sol_socket_tests))
> > +             return 1;
> > +
> > +     t =3D &sol_socket_tests[i];
> > +     if (!t->opt)
> > +             return 1;
> > +
> > +     return bpf_test_sockopt_int(lc->ctx, lc->sk, t, SOL_SOCKET);
> > +}
> > +
> > +static int bpf_test_sockopt(void *ctx, const struct sock *sk)
> > +{
> > +     struct loop_ctx lc =3D { .ctx =3D ctx, .sk =3D sk, };
> > +     int n;
> > +
> > +     n =3D bpf_loop(ARRAY_SIZE(sol_socket_tests), bpf_test_socket_sock=
opt, &lc, 0);
> > +     if (n !=3D ARRAY_SIZE(sol_socket_tests))
> > +             return -1;
> > +
> > +     return 0;
> > +}
> > +
> > +static bool bpf_test_access_sockopt(void *ctx)
> > +{
> > +     const struct sockopt_test *t;
> > +     int tmp, ret, i =3D 0;
> > +     int level =3D SOL_SOCKET;
> > +
> > +     t =3D &sol_socket_tests[i];
> > +
> > +     for (; t->opt;) {
>
> It really does not need a loop here. It only needs to test "one" optname =
to
> ensure it is -EOPNOTSUPP.
>
> > +             ret =3D bpf_setsockopt(ctx, level, t->opt, (void *)&t->ne=
w, sizeof(t->new));
> > +             if (ret !=3D -EOPNOTSUPP)
> > +                     return true;
> > +
> > +             ret =3D bpf_getsockopt(ctx, level, t->opt, &tmp, sizeof(t=
mp));
> > +             if (ret !=3D -EOPNOTSUPP)
> > +                     return true;
> > +
> > +             if (++i >=3D ARRAY_SIZE(sol_socket_tests))
> > +                     break;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +/* Adding a simple test to see if we can get an expected value */
> > +static bool bpf_test_access_load_hdr_opt(struct bpf_sock_ops *skops)
> > +{
> > +     struct tcp_opt reg_opt;
>
> Just noticed this one. Use a plain u8 array. Then no need to include the
> "test_tcp_hdr_options.h" from an unrelated test.

Will update it.

Thanks,
Jason

>
> > +     int load_flags =3D 0;
> > +     int ret;
> > +
> > +     reg_opt.kind =3D TCPOPT_EXP;
>
> The kind could be any integer, e.g. 2.
>
> > +     reg_opt.len =3D 0;
> > +     reg_opt.data32 =3D 0;
> > +     ret =3D bpf_load_hdr_opt(skops, &reg_opt, sizeof(reg_opt), load_f=
lags);
> > +     if (ret !=3D -EOPNOTSUPP)
> > +             return true;
> > +
> > +     return false;
> > +}

