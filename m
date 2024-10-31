Return-Path: <bpf+bounces-43624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DECD9B7296
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 03:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D25B1F218E9
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 02:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E1912CDBF;
	Thu, 31 Oct 2024 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNuUYz1g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2432C8B;
	Thu, 31 Oct 2024 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342545; cv=none; b=OzN/qHPhl+0ENnhjsHA/RnVMlyXA+wq3gfYKy3+hYpVVDJkFg8WUBqx5M/5f8510/o2vcLh0MN72UYlFreJvq3eu4uzU6LleHnf56Aht/fYwoH7LgY0JSsqiIUO11zGWOrp4esENAT+JkBuVfADWLhSUaqORJHzrNR/j1dNs5BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342545; c=relaxed/simple;
	bh=5cj0vXpsRZDbVNFvN+abraMS+1dbKP+gquDCbJr+joM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2weGsrFYhiK+85HCxiRdVJWOIePpjz3Dc1kRoe4mT37D7Qb6EECs5g+8Z1AfeiC2b5BUUMno+2+0u3g5YAW5yHDzqpkNZK6ftmOasEPtg7x6V4+GbYIZpbei8LZ5H70hU+Lgs5vodzcU9+APypkf9HaR2Y6WHt4ShSBulau3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNuUYz1g; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3f8543f5eso4560015ab.0;
        Wed, 30 Oct 2024 19:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730342542; x=1730947342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUhLa0WlRk4ZQqGc0jp8jnQ/5kR2w1KXzasvguaPdjs=;
        b=kNuUYz1gxSpu94x5YFZlXW1o+nELgQRS4N7/RNDCC3M7jwKATQ0er7Q/WgecpKNp1a
         yQr4+W9lXuXUDCeiSOxQykozAByzRLn8xUsXHaD1QUokO1kQk3E/B8Qc7FAf4+2NrHWr
         gpjV0WYPWWlMtJ3mqxx2mlWKBTOxI8dHDnHjzdpohgZOaA/7vC473n/fPmS/LkMoCMas
         vdsoq1RvFchz6nQMAvuedkJFz51GVWKwKCiETUyh6DmiZ4jnUgkFn0eYbVyZC9F73Msz
         aqia9JgnTChF3VkHpspkCEbY7MEaCx4kWMNtfawhDtKZ3PVX82C7B2arqNyRaTGWjJye
         2uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730342542; x=1730947342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUhLa0WlRk4ZQqGc0jp8jnQ/5kR2w1KXzasvguaPdjs=;
        b=dfPO2Yo078afxAsaMtUuvVTBc+XUh1o0Itv9gYfFpjUNftlSeCiEd+IBCyzD0XHoj+
         ejzK05kxtoqNQqYhJTULcixw8dGSn9TMeIQlcDxNFAN5C6kMWwyrQIYCiihtUkzQ9eWq
         dESnNsNQLkXyRQ9S+dhEUKNLUUE2Afm+KzUIY3h/nbvR1lc4vPG4QVLP6GC6VfHeetlm
         4+8ZeaP7eeONkxlYlXEkQGmeKddO5PvVXktzrS+UNWoSsT0gPXFgzCzyBkrQhXg21Tde
         FGbynf+6dwhlf8tHa4+3DOXvk1klnTq93gveLAYvvjYMjs9Ww+eVPjjZ7YM6BkBIPR6i
         RleA==
X-Forwarded-Encrypted: i=1; AJvYcCVXZeR6dDvKFrtjqxmMH1esxtt6iTvUvLHqjECJavzD/V1u5Rn5lcLKarU1143YHFl1F2M=@vger.kernel.org, AJvYcCXeN6wlUisxwEChDYSSHGXIh/pYmRl9Tl35g1uqAvbi70zT5zTFsuquxeo9FRag7IqV5Y3Jn0/x@vger.kernel.org
X-Gm-Message-State: AOJu0YzFq1LrXSFG18u6jpfXXXRLlZB1CF9pxyvqp2ULYkdBW23sGe05
	tAEJRd2WcEX1KCA7DYhcJbgV1mR6MJAOjfBGBJa0dK8f2QZz08P0SQYO4DGntk0/gii/xt1RbSV
	9yySIXcHhXkLdwv2ccDSdMmaUb5k=
X-Google-Smtp-Source: AGHT+IFEaJiOXvau+SPSuXswXQQhn7Wy4IINTxvObunO6KPWDHK44rjfVGSAD8ct9IOBKsAbz2FDTk/LGhS/AxWq078=
X-Received: by 2002:a05:6e02:3886:b0:3a3:a639:a594 with SMTP id
 e9e14a558f8ab-3a6a94a162dmr6164855ab.4.1730342541663; Wed, 30 Oct 2024
 19:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com> <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
 <CAL+tcoBNiZQr=yk_fb9eoKX1_Nr4LuDaa1kkLGbdnc=8JNKnNg@mail.gmail.com> <e56f78a9-cbda-4b80-8b55-c16b36e4efb1@linux.dev>
In-Reply-To: <e56f78a9-cbda-4b80-8b55-c16b36e4efb1@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 31 Oct 2024 10:41:45 +0800
Message-ID: <CAL+tcoDi86GkJRd8fShGNH8CgdFu3kbfMubWxCLVdo+3O-wnfg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/29/24 11:50 PM, Jason Xing wrote:
> > On Wed, Oct 30, 2024 at 1:42=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 10/28/24 4:05 AM, Jason Xing wrote:
> >>> +/* Used to track the tskey for bpf extension
> >>> + *
> >>> + * @sk_tskey: bpf extension can use it only when no application uses=
.
> >>> + *            Application can use it directly regardless of bpf exte=
nsion.
> >>> + *
> >>> + * There are three strategies:
> >>> + * 1) If we've already set through setsockopt() and here we're going=
 to set
> >>> + *    OPT_ID for bpf use, we will not re-initialize the @sk_tskey an=
d will
> >>> + *    keep the record of delta between the current "key" and previou=
s key.
> >>> + * 2) If we've already set through bpf_setsockopt() and here we're g=
oing to
> >>> + *    set for application use, we will record the delta first and th=
en
> >>> + *    override/initialize the @sk_tskey.
> >>> + * 3) other cases, which means only either of them takes effect, so =
initialize
> >>> + *    everything simplely.
> >>> + */
> >>> +static long int sock_calculate_tskey_offset(struct sock *sk, int val=
, int bpf_type)
> >>> +{
> >>> +     u32 tskey;
> >>> +
> >>> +     if (sk_is_tcp(sk)) {
> >>> +             if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
> >>> +                     return -EINVAL;
> >>> +
> >>> +             if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> >>> +                     tskey =3D tcp_sk(sk)->write_seq;
> >>> +             else
> >>> +                     tskey =3D tcp_sk(sk)->snd_una;
> >>> +     } else {
> >>> +             tskey =3D 0;
> >>> +     }
> >>> +
> >>> +     if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> >>> +             sk->sk_tskey_bpf_offset =3D tskey - atomic_read(&sk->sk=
_tskey);
> >>> +             return 0;
> >>> +     } else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPING_=
OPT_ID)) {
> >>> +             sk->sk_tskey_bpf_offset =3D atomic_read(&sk->sk_tskey) =
- tskey;
> >>> +     } else {
> >>> +             sk->sk_tskey_bpf_offset =3D 0;
> >>> +     }
> >>> +
> >>> +     return tskey;
> >>> +}
> >>
> >> Before diving into this route, the bpf prog can peek into the tcp seq =
no in the
> >> skb. It can also look at the sk->sk_tskey for UDP socket. Can you expl=
ain why
> >> those are not enough information for the bpf prog?
> >
> > Well, it does make sense. It seems we don't need to implement tskey
> > for this bpf feature...
> >
> > Due to lack of enough knowledge of bpf, could you provide more hints
> > that I can follow to write a bpf program to print more information
> > from the skb? Like in the last patch of this series, in
> > tools/testing/selftests/bpf/prog_tests/so_timestamping.c, do we have a
> > feasible way to do that?
>
> The bpf-prog@sendmsg() will be run to capture a timestamp for sendmsg().
> When running the bpf-prog@sendmsg(), the skb can be set to the "struct
> bpf_sock_ops_kern sock_ops;" which is passed to the sockops prog. Take a =
look at
> bpf_skops_write_hdr_opt().

Thanks. I see the skb field in struct bpf_sock_ops_kern.

>
> bpf prog cannot directly access the skops->skb now. It is because the soc=
kops
> prog sees the uapi "struct bpf_sock_ops" instead of "struct
> bpf_sock_ops(_kern)". The conversion is done in sock_ops_convert_ctx_acce=
ss. It
> is an old way before BTF. I don't want to extend the uapi "struct bpf_soc=
k_ops".

Oh, so it seems we cannot use this way, right?

I also noticed a use case that allow users to get the information from one =
skb:
"int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)" in
tools/testing/selftests/bpf/progs/netif_receive_skb.c
But it requires us to add the tracepoint in __skb_tstamp_tx() first.
Two months ago, I was planning to use a tracepoint for some people who
find it difficult to deploy bpf.

>
> Instead, use bpf_cast_to_kern_ctx((struct bpf_sock_ops *)skops_ctx) to ge=
t a
> trusted "struct bpf_sock_ops(_kern) *skops" pointer. Then it can access t=
he
> skops->skb.

Let me spend some time on it. Thanks.

> afaik, the tcb->seq should be available already during sendmsg. it
> should be able to get it from TCP_SKB_CB(skb)->seq with the bpf_core_cast=
. Take
> a look at the existing examples of bpf_core_cast.
>
> The same goes for the skb->data. It can use the bpf_dynptr_from_skb(). It=
 is not
> available to skops program now but should be easy to expose.

I wonder what the use of skb->data is here.

>
> The bpf prog wants to calculate the delay between [sendmsg, SCHED], [SCHE=
D,
> SND], [SND, ACK]. It is why (at least in my mental model) a key is needed=
 to
> co-relate the sendmsg, SCHED, SND, and ACK timestamp. The tcp seqno could=
 be
> served as that key.
>
> All that said, while looking at tcp_tx_timestamp() again, there is always
> "shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;". shinfo->tskey c=
an be
> used directly as-is by the bpf prog. I think now I am missing why the bpf=
 prog
> needs the sk_tskey in the sk?

As you said, tcp seqno could be treated as the key, but it leaks the
information in TCP layer to users. Please see the commit:
commit 4ed2d765dfaccff5ebdac68e2064b59125033a3b
Author: Willem de Bruijn <willemb@google.com>
Date:   Mon Aug 4 22:11:49 2014 -0400

    net-timestamp: TCP timestamping
...
    - To avoid leaking the absolute seqno to userspace, the offset
    returned in ee_data must always be relative. It is an offset between
    an skb and sk field.

It has to be computed in the kernel before reporting to the user space, I t=
hink.

>
> In the bpf prog, when the SCHED/SND/ACK timestamp comes back, it has to f=
ind the
> earlier sendmsg timestamp. One option is to store the earlier sendmsg tim=
estamp
> at the bpf map key-ed by seqno or the shinfo's tskey. Storing in a bpf ma=
p
> key-ed by seqno/tskey is probably what the selftest should do. In the fut=
ure, we
> can consider allowing the rbtree in the bpf sk local storage for searchin=
g
> seqno. There is shinfo's hwtstamp that can be used also if there is a nee=
d.

Thanks for the information! Let me investigate how the bpf map works...

I wonder that for the selftests could it be much simpler if we just
record each timestamp stored in three variables and calculate them at
last since we only send the small packet once instead of using bpf
map. I mean, bpf map is really good as far as I know, but I'm a bit
worried that implementing such a function could cause more extra work
(implementation and review).

