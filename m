Return-Path: <bpf+bounces-51116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68730A304D8
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C5E3A8D85
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895151EE7B1;
	Tue, 11 Feb 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR6ogcIR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD41D5178;
	Tue, 11 Feb 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260162; cv=none; b=O6w6kCzvt3wu53hn+ZXgoOzfWOHCjEo18WotTNwQ7hZYULVQlcLxP9AWgsxdrikJhxx+ENmNt6PWw1EewamUYBEd9JrLCU21sGi9tVrO1mOHNYpOae6YRMVqGHXOzp/sCi9qXj485i/81dmyxiyyHyhuHVq8kZ5pj5sYmSJnaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260162; c=relaxed/simple;
	bh=CzMDl0RVpoMTxCUxGPNAhgllc4WTXNDnTeYqvLzFiFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecglegQiKQ8tCVShiAuqpNDjdJAhIA3IZ1dN9BNYIx59e4jprTNfANVcEjzWEMWzsdJ6x+7pxLQ5QBo9APF/20VHZhO5/pwtBchg/fJ6QiD2mtk56WcqJkQII+UR4wvFzaRJSU3JbBtHYREg4MUQgR1r4F7wNh0IF59smANyAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR6ogcIR; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8551c57cb8aso60537639f.3;
        Mon, 10 Feb 2025 23:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739260155; x=1739864955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtvqQd48EzdqJ0QQubbcq4pamen5kwx81tt1GO5dwZM=;
        b=KR6ogcIRN0cyjAkrRRfCeVl5lsNoJ0JjHT/s3bEV3q10vGEEk+ZOUeqwx7GuWAuTc4
         /Jq8SLXFm9xabmlN1RwE14HmOv671HC1QhGwpWFeS/qbX1ypRB12HF0f2qZ8zblVpYCL
         mJPzBxUZ67W0gSL2kQ/BdvXQ0+XaS9ZLz0VT1wNnZEPm0A0R5Co7L9BuUcNy/OAzCEZU
         1Lasj0ZI7FbRrVLD/IJJehCB/LU4opp3++sBnqOES3TMVs5ditKSZpdWqDM8zDA7nmlp
         HDgGafrtj0FhuMgULy+hHC86d9rOw4adliAmTbN9ZkzYJZ6H1VJOWsnBb33OpbGZ0jxM
         rkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739260155; x=1739864955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtvqQd48EzdqJ0QQubbcq4pamen5kwx81tt1GO5dwZM=;
        b=t6eoZKUEoPalC2iAusGTvJ4MB7yE240pCjE4biMEoY/yz0H2zJbYr5zwX+q/LL1tQJ
         avEGWf4Dswkcf2YTjrUstG3sxw5nQG4zm4er5VmILqMBp+TQvKRFOB2JkMKkYPsu1Rox
         Al2hEWD06ZbPZg0sONRG4sJfqXPlZJORggKut4gE/V0fcv9n0aaqxLDUZyLBhLXl5cBE
         Wc61V018cRHe8v3k1roHU/3tdKEEkQKRfn+NKUVN4vq3+nhudBkvYqOptKTrvgQ6o4sw
         7TJFzBQGqQFPemZ4sTtQwwh2mEQSCIdoTj/4Z6fME/gtd6Q4Q32lHJjw9cnQAbF+X1la
         VovQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlB8zijHjRGmhK7dOjd4GZMkL6PFzXVXV9eaU74MoLAOcL4eJ05576sKPO5upobtF7nJuKDtu0@vger.kernel.org, AJvYcCWpnxFXYxenfrb7izRAUzn7LdOgpQ390ApY+rU/ZT1B2BjO5C6LLtHIoSWB7wRRIAGiOaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvWHmo18T1tzVTUmKEj3b7t+eazP/uG1oDJQw+mtKIi3aa5qU
	kFupmrZmSBtZiwE+1T4Y9A7nA+TsoIbHWV7P2hgcPcktc9PZIWVYjgF8aTSAqWnjJ3RbeT1rllk
	JqwpfyK763+GvYo50TGvlo9P7maw=
X-Gm-Gg: ASbGncuvCNt937W0hF4P5EDyHO4Oysbk5xSnNP9FbxLzsCqJDxyOZet8GbrvH8C+qrM
	s72lNXHuNxVk6XhnMSc5ydkUCyFoAIV1c6t4uVul+/J6WHg36J+2A8B4mNPvWYXbxMvk2zghp
X-Google-Smtp-Source: AGHT+IF2xy0lh7V6H+BPmK7D403+NTUN+MVrV1a+O9XrLE6oDkhjNO42PDrfA1NzbE5MDfJnC+T8NzZ/55XKAqRd1n0=
X-Received: by 2002:a05:6e02:214a:b0:3d0:124d:99e8 with SMTP id
 e9e14a558f8ab-3d13dd5ebaamr117505175ab.13.1739260154982; Mon, 10 Feb 2025
 23:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-12-kerneljasonxing@gmail.com> <e419521b-c38e-41e0-a4da-93dcbb820486@linux.dev>
In-Reply-To: <e419521b-c38e-41e0-a4da-93dcbb820486@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 15:48:37 +0800
X-Gm-Features: AWEUYZl2x3FgnvNG7lpqH9Qb-JTPBJVh6YnpMLn61ks6VVD_vtzU3U0aTrW48nM
Message-ID: <CAL+tcoBMNBVpjS78syvJKqG2ZgA3FjEXm9HDPNjKXsDeekCEMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 11/12] bpf: support selective sampling for bpf timestamping
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

On Tue, Feb 11, 2025 at 3:41=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/8/25 2:32 AM, Jason Xing wrote:
> > Use __bpf_kfunc feature to allow bpf prog dynamically and selectively
>
> s/Use/Add/
>
> Remove "dynamically". A kfunc can only be called dynamically at runtime.
>
> Like:
>
> "Add the bpf_sock_ops_enable_tx_tstamp kfunc to allow BPF programs to
> selectively enable TX timestamping on a skb during tcp_sendmsg..."

Will adjust it.

>
> > to sample/track the skb. For example, the bpf prog will limit tracking
> > X numbers of packets and then will stop there instead of tracing
> > all the sendmsgs of matched flow all along.
>  > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   kernel/bpf/btf.c  |  1 +
> >   net/core/filter.c | 27 ++++++++++++++++++++++++++-
> >   2 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 8396ce1d0fba..a65e2eeffb88 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -8535,6 +8535,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_p=
rog_type prog_type)
> >       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> >       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> >       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> > +     case BPF_PROG_TYPE_SOCK_OPS:
> >               return BTF_KFUNC_HOOK_CGROUP;
> >       case BPF_PROG_TYPE_SCHED_ACT:
> >               return BTF_KFUNC_HOOK_SCHED_ACT;
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 7f56d0bbeb00..db20a947e757 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12102,6 +12102,21 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct=
 __sk_buff *s, struct sock *sk,
> >   #endif
> >   }
> >
> > +__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern=
 *skops)
>
> I am ok to always enable txstamp_ack here. Please still add a second "u64=
 flags"
> argument such that future disable/enable is still possible.

Ok. Will do it.

>
> > +{
> > +     struct sk_buff *skb;
> > +
> > +     if (skops->op !=3D BPF_SOCK_OPS_TS_SND_CB)
>  > +            return -EOPNOTSUPP;> +
> > +     skb =3D skops->skb;
> > +     TCP_SKB_CB(skb)->txstamp_ack =3D 2;
>
> Willem (thanks!) has already mentioned there is a bug.
>
> This also brought up that a test is missing: the bpf timestamping and use=
r
> space's SO_TIMESTAMPING can work without interfering others. The current =
test
> only has SK_BPF_CB_TX_TIMESTAMPING on. A test is needed when both
> SK_BPF_CB_TX_TIMESTAMPING and the user space's SO_TIMESTAMPING are on. Th=
e
> expectation is both of them will work together.

Yeah, I did miss this particular test. Let me figure out how to test
it in a proper way.

Thanks,
Jason

>
> > +     skb_shinfo(skb)->tx_flags |=3D SKBTX_BPF;
> > +     skb_shinfo(skb)->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> > +
> > +     return 0;
> > +}
> > +
> >   __bpf_kfunc_end_defs();
> >
> >   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> > @@ -12135,6 +12150,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk=
)
> >   BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
> >   BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
> >
> > +BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
> > +BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
> > +BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
> > +
> >   static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
> >       .owner =3D THIS_MODULE,
> >       .set =3D &bpf_kfunc_check_set_skb,
> > @@ -12155,6 +12174,11 @@ static const struct btf_kfunc_id_set bpf_kfunc=
_set_tcp_reqsk =3D {
> >       .set =3D &bpf_kfunc_check_set_tcp_reqsk,
> >   };
> >
> > +static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .set =3D &bpf_kfunc_check_set_sock_ops,
> > +};
> > +
> >   static int __init bpf_kfunc_init(void)
> >   {
> >       int ret;
> > @@ -12173,7 +12197,8 @@ static int __init bpf_kfunc_init(void)
> >       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_=
kfunc_set_xdp);
> >       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K_ADDR,
> >                                              &bpf_kfunc_set_sock_addr);
> > -     return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, =
&bpf_kfunc_set_tcp_reqsk);
> > +     ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,=
 &bpf_kfunc_set_tcp_reqsk);
> > +     return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &=
bpf_kfunc_set_sock_ops);
> >   }
> >   late_initcall(bpf_kfunc_init);
> >
>

