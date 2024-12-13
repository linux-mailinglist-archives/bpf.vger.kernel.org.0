Return-Path: <bpf+bounces-46855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2A9F0F6C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BB21650BB
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB041E2307;
	Fri, 13 Dec 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIPUrGn2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926151E1A28;
	Fri, 13 Dec 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100987; cv=none; b=Vd6Qj2LdOoD5mzie7ZXo8mZPcfnG8izKBtoMPjkIt6PSsUd1fRpMcXS27quzk4XbaNtOWqn9Bv2Qe/GobhsUH6yH65jp/CRggCQe+OhOmIjF6sWl1wZOUMf+bZnqtk+DJFL26x9sNUjKDPcBKiM8IBdYFz/ONkrhBZIu64vrNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100987; c=relaxed/simple;
	bh=cTPwO0gX0/VZ4zJUFjKfAQJ5iEW0GAYe162Z99mQJSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TX0fEp266tsM7nNVT0+nVmXwJZ1+dKMLTF+Q5BPZWN8ObsqzhyrQ265v+XNQEL08a4INw0vzJYhREp8TCgQXMigIychmKdXi5twDiDBvmgQiFcWZdSGeNsYVQj89FNHheiSzSnl5EPyzwjxn7O2SH1Sngje4PL9g0gaLoGSXuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIPUrGn2; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ab37d98dd4so6024635ab.3;
        Fri, 13 Dec 2024 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734100984; x=1734705784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w/+qmndvRgYF+YcIzg69AQ9YUrB6pkxNgda5MjAYQ0=;
        b=VIPUrGn2IpjzxdGRoCXLbgqsIOh8Nd/gCasW8HayDiJ0/iIMbkeLvaeTDQZSGk/mtu
         LGLwrRly1xpFndvVTfo8I1ocPIiffOWxE2s7PC6AY3aX/QDZNDNnAf7ypcrhHkwQkCib
         f13IrkJX2dT1cr91ihTEKO9RAYmTi66d+W0hmZZ4HtGIn1OCj+krLXskzP065WiwOxGH
         GNdwiiWec1WRFWit/jdpFImEB/My2dCp+jflV5VX6IeBtVmvKS9NcTYNVCknKbHD6k37
         7MbMm12t/mSBXRzNoOYt3RlTATFhTKYjYzVl6/O42Lha80f9BCrkQBxY2LS5Z12NCrDH
         33vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100984; x=1734705784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w/+qmndvRgYF+YcIzg69AQ9YUrB6pkxNgda5MjAYQ0=;
        b=XbK8hOaKR9aOVn6VL5ZgfNtxFOm/GxoIefQ+igPkRLJf0UJsOr2lZWQaHBzml36atO
         apYc7wuy5chn14fI1/df9/8fFhpyGxu+9fkelEbKFyqTUgPe4n0hMQ92dpqaZaGT6Md9
         FlIlXI2OOkN6x+bl8jy7ujfQOBxKEtZAd0l3DwH154rF/ios47rmopPR61VKS17aNGZ/
         pR4PCPoEbWRRPmeWV5NCw3aYtdPnYu9KhX3EIr2mw+8BnAaZlaEA78Q0+i5oCNnIZPMJ
         L1K6qZ02rf/vpMZCQmc7edQvuD8Y1DHQY+8TqB187TgUTsAJZ62kJ+PGREss/saJ7iHx
         LCsg==
X-Forwarded-Encrypted: i=1; AJvYcCVMr1LOtsQEq5+JI0X9prTFvZL7sEJK9M289YqO14Fn43v/Q+4K0fPT2XA8iu72Gidpg6Y=@vger.kernel.org, AJvYcCXr42OX9cAhhLgHEfd4UYI5yPaMOYzaHjd65bUxjKfwwaUfQ1mEXFn3p/vQWfdO4gX+/5VYI+IV@vger.kernel.org
X-Gm-Message-State: AOJu0YxeVDdFzbrSDgReFC7qc1iofBIdOyqu+bhy2CNS8+CILSFn7/tA
	Ljua/GjXaWvS4/raFikE1jde0ePsRy84FGy5DPxfLjNOO/K7KWDmuIDvoY4DlpHo108qLU4Yeao
	v2QA+e4zJ11cK6PBaFJTUqw6xYIk=
X-Gm-Gg: ASbGncuC2W7/YHsdLcOJG1IkN2BtwuxryeqHxD0UBCMeQX+iLjsadbzCm3IqRXKSyej
	5G167KIF3zhwc+2ATXUmV5dvAM98FPecx4mPd8w==
X-Google-Smtp-Source: AGHT+IG4JFzFLWbkyq90sTL9xfyjhjsI0yzqk2UFyiVneRk7pijXVyZrkjA7nL9QaFow1Guj6vzBgATR3wgZf/7tdHQ=
X-Received: by 2002:a05:6e02:1c4d:b0:3a7:7a68:44e2 with SMTP id
 e9e14a558f8ab-3aff243f5acmr31304325ab.15.1734100984624; Fri, 13 Dec 2024
 06:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-3-kerneljasonxing@gmail.com> <f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.dev>
 <CAL+tcoDGq8Jih9vwsz=-O8byC1S0R1uojShMvUiTZKQvMDnfTQ@mail.gmail.com> <996cbe46-e2cd-44b6-a53a-13fd6ebfc4c0@linux.dev>
In-Reply-To: <996cbe46-e2cd-44b6-a53a-13fd6ebfc4c0@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 13 Dec 2024 22:42:28 +0800
Message-ID: <CAL+tcoAxmHj9_d5PUqvSHswavKFspd_D5tOt81fon-UtEf_OMA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/11] net-timestamp: prepare for bpf prog use
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:41=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/11/24 1:17 AM, Jason Xing wrote:
> > On Wed, Dec 11, 2024 at 10:02=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>
> >> On 12/7/24 9:37 AM, Jason Xing wrote:
> >>> From: Jason Xing <kernelxing@tencent.com>
> >>>
> >>> Later, I would introduce three points to report some information
> >>> to user space based on this.
> >>>
> >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>> ---
> >>>    include/net/sock.h |  7 +++++++
> >>>    net/core/sock.c    | 15 +++++++++++++++
> >>>    2 files changed, 22 insertions(+)
> >>>
> >>> diff --git a/include/net/sock.h b/include/net/sock.h
> >>> index 0dd464ba9e46..f88a00108a2f 100644
> >>> --- a/include/net/sock.h
> >>> +++ b/include/net/sock.h
> >>> @@ -2920,6 +2920,13 @@ int sock_set_timestamping(struct sock *sk, int=
 optname,
> >>>                          struct so_timestamping timestamping);
> >>>
> >>>    void sock_enable_timestamps(struct sock *sk);
> >>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> >>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb,=
 int op);
> >>> +#else
> >>> +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct=
 sk_buff *skb, int op)
> >>> +{
> >>> +}
> >>> +#endif
> >>>    void sock_no_linger(struct sock *sk);
> >>>    void sock_set_keepalive(struct sock *sk);
> >>>    void sock_set_priority(struct sock *sk, u32 priority);
> >>> diff --git a/net/core/sock.c b/net/core/sock.c
> >>> index 74729d20cd00..79cb5c74c76c 100644
> >>> --- a/net/core/sock.c
> >>> +++ b/net/core/sock.c
> >>> @@ -941,6 +941,21 @@ int sock_set_timestamping(struct sock *sk, int o=
ptname,
> >>>        return 0;
> >>>    }
> >>>
> >>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> >>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb,=
 int op)
> >>> +{
> >>> +     struct bpf_sock_ops_kern sock_ops;
> >>> +
> >>> +     sock_owned_by_me(sk);
> >>
> >> I don't think this can be assumed in the time stamping callback.
> >
> > I'll remove this.
> >
> >>
> >> To remove this assumption for sockops, I believe it needs to stop the =
bpf prog
> >> from calling a few bpf helpers. In particular, the bpf_sock_ops_cb_fla=
gs_set and
> >> bpf_sock_ops_setsockopt. This should be easy by asking the helpers to =
check the
> >> "u8 op" in "struct bpf_sock_ops_kern *".
> >
> > Sorry, I don't follow. Could you rephrase your thoughts? Thanks.
>
> Take a look at bpf_sock_ops_setsockopt in filter.c. To change a sk, it ne=
eds to
> hold the sk_lock. If you drill down bpf_sock_ops_setsockopt,
> sock_owned_by_me(sk) is checked somewhere.

Thanks, now I totally follow.

>
> The sk_lock held assumption is true so far for the existing sockops callb=
acks.
> The new timestamping sockops callback does not necessary have the sk_lock=
 held,

Well, for TCP only, there are three new callbacks that I think own the
sk_lock already, say, the tcp_sendmsg() will call the lock_sock(). For
other types, like you said, maybe not.

> so it will break the bpf_sock_ops_setsockopt() assumption on the sk_lock.

Agreed, at least for the writer accessing the sk is not allowed actually.

>
> >
> >>
> >> I just noticed a trickier one, sockops bpf prog can write to sk->sk_tx=
hash. The
> >> same should go for reading from sk. Also, sockops prog assumes a fulls=
ock sk is
> >> a tcp_sock which also won't work for the udp case. A quick thought is =
to do
> >> something similar to is_fullsock. May be repurpose the is_fullsock som=
ehow or a
> >> new u8 is needed. Take a look at SOCK_OPS_{GET,SET}_FIELD. It avoids
> >> writing/reading the sk when is_fullsock is false.
> >
> > Do you mean that if we introduce a new field, then bpf prog can
> > read/write the socket?
>
> The same goes for writing the sk, e.g. writing the sk->sk_txhash. It need=
s the
> sk_lock held. Reading may be ok-ish. The bpf prog can read it anyway by
> bpf_probe_read...etc.
>
> When adding udp timestamp callback later, it needs to stop reading the tc=
p_sock
> through skops from the udp callback for sure. Do take a look at
> SOCK_OPS_GET_TCP_SOCK_FIELD. I think we need to ensure the udp timestamp
> callback won't break here before moving forward.

Agreed. Removing the "sock_ops.sk =3D sk;" is simple, but I still want
the bpf prog to be able to read some fields from the socket under
those new callbacks.

Let me figure out a feasible solution this weekend if everything goes well.

>
> >
> > Reading the socket could be very helpful in the long run.
> >
> >>
> >> This is a signal that the existing sockops interface has already seen =
better
> >> days. I hope not too many fixes like these are needed to get tcp/udp
> >> timestamping to work.
> >>
> >>> +
> >>> +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> >>> +     sock_ops.op =3D op;
> >>> +     sock_ops.is_fullsock =3D 1;
> >>
> >> I don't think we can assume it is always is_fullsock either.
> >
> > Right, but for now, TCP seems to need this. I can remove this also.
>
> I take this back. After reading the existing __skb_tstamp_tx, I think sk =
is
> always fullsock here.

Got it.

>
> >
> >>
> >>> +     sock_ops.sk =3D sk;
> >>> +     __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS=
);
> >>
> >> Same here. sk may not be fullsock. BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_=
ops) is
> >> needed.
> >
> > If we use this helper, we will change when the udp bpf extension needs
> > to be supported.
> >
> >>
> >> [ I will continue the rest of the set later. ]
> >
> > Thanks a lot :)
> >
> >>
> >>> +}
> >>> +#endif
> >>> +
> >>>    void sock_set_keepalive(struct sock *sk)
> >>>    {
> >>>        lock_sock(sk);
> >>
>

