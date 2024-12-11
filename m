Return-Path: <bpf+bounces-46604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435929EC8C6
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4217167957
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40B1A83E1;
	Wed, 11 Dec 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwiJ88Bv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A672336A5;
	Wed, 11 Dec 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908725; cv=none; b=peQBJRqipo9zy4WvAjEIyz/UpNSlrIbgOtk1JftCNiuh45W8nARnuK9fXpc9XIxTovWEYSaD+JcXIKErxQC4K7eOaPcP29upBU+YXwA0Ksypp7cWhTzHDEchi/Up056I3evo8ERYHLfS7UIcT+v765qV5B6ZSShCNK1ixRdq1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908725; c=relaxed/simple;
	bh=syYvtQvIWI/NyWaqQSaevB2x0xZqIyHVsW+bEjRtUh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqD7Pn5Wp9JaJLA6Qk1zwHWxCHvcFR29QUcfd2hu66dmz9W7iD9gfb8X8vXvSc33IVODDaOpcHy6YftIF8VFG1a4N/g+tTJ82wVon2jiEcBDEjAqUpoq1ELUVW0xYTO9b9gD90wutmYg7Pp4kAp1H4LTpF/UTyIhrndBfVWzZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwiJ88Bv; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8441c1f14c6so17130439f.1;
        Wed, 11 Dec 2024 01:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733908712; x=1734513512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1xQ6KqzMrIXUTQLpJaKG4GYlMajQ8mrtGjZYfhp+t8=;
        b=OwiJ88BvSE/JvleiNeVu7te2PW9rlLrO3egxbl4noJK7gGFUh7dp3uR6ROjOZQZMjR
         l9y6RN5D8POjZSqkjWkSf2I+pzFvw3t+XR23WjSOTdheJ9MV2gn91K/DhXO1utnxGR+p
         ByOkCEEkm7TwgI6SxdTUTNNziCR5DIRpyATz3PSL+s5nHXKErZb6gPqqhu5kUUB61IG8
         0mbzgUv/JXXOvoWPRdFgXfjlyJ68uGGQalhOVX2JyrWzgbbRmICd439EKyfnNoDki4H+
         AAgIaLC5S5kTiUUM+l3ZufHeZFCylCPdWG8aB8VSNwPhrqVovTwvN5ZsDiSqZTn2q0Xc
         JDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908712; x=1734513512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1xQ6KqzMrIXUTQLpJaKG4GYlMajQ8mrtGjZYfhp+t8=;
        b=ZrhcGzk5btxU+M111m32Ga2b01Z8wZ55P6W4eupKlYAXQ8fQ65WZ8c9tm+TUtf6XiA
         nxzLxicWa8Q0AEiaT7jzy8Cqjd3DNA8p4pT79MymT53M1IuE9huWGjjZECJDPVaCutbo
         R5zRyryW/auIT1t6vfuWypUMdNiXhs/CnWg6xMyXgJUSnoN4c4/D5oxdAzvXsrda9X6A
         3Vf5VSinby0I0JtE0MWkwMAdySKcqAcA1m1n7/AZD4RdC8XilFov3XZRasf2A2jMc23s
         5RllufrZvB56hXRRe2avi48x9x1fblaAWdJnbKZeLQlsQrwcyDr1pJ5zg+BeHTti82KH
         VxGw==
X-Forwarded-Encrypted: i=1; AJvYcCUMSPvb+XpuHowwDclaQnd4ZlhatTLvsPrrcw5lyK3VsAn2RONQDJaPm6HaRW0RxjbeBEurqg9e@vger.kernel.org, AJvYcCXlggfMoFFn17FGYdodqPwypE7pM23AWrPOSxb9DuLbkqfYY5aIDHuPeZ1xtICRUaWdJYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIE8tVnpuANcNbTeS13QjkHGIgaL2iWLcYmKEayMO8sa6cfd+5
	mE1sBXlQPXLBvwqiXFO5qn/4hNfGn4rzN4nlclJornsEpGY7AVxGZEeaeQ10G86PGd2DQDKlDdZ
	Q0d5g50I0rHUuhno3n0uQ0ApLtm0=
X-Gm-Gg: ASbGnct/ane7krAhN7L40yR9Zo3r2IqQiNZ/3FcJoy1QBdPyl3vO4uJNUBjYulBKPUY
	DJ2KlH35WneqoeWbIdg26h/I+OMTGgIEK5K8=
X-Google-Smtp-Source: AGHT+IGTun1WzjDhLudB1EUbKnCb0hQVYb/aelz5kMKZI3F8Jyn1+CchgQHEPtHL/CKw4D+dkV5HdWcHpHd6KS2WFCQ=
X-Received: by 2002:a05:6e02:1d0f:b0:3a7:ccb2:e438 with SMTP id
 e9e14a558f8ab-3aa1d983849mr15276395ab.11.1733908712544; Wed, 11 Dec 2024
 01:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-3-kerneljasonxing@gmail.com> <f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.dev>
In-Reply-To: <f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 11 Dec 2024 17:17:55 +0800
Message-ID: <CAL+tcoDGq8Jih9vwsz=-O8byC1S0R1uojShMvUiTZKQvMDnfTQ@mail.gmail.com>
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

On Wed, Dec 11, 2024 at 10:02=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 12/7/24 9:37 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Later, I would introduce three points to report some information
> > to user space based on this.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/net/sock.h |  7 +++++++
> >   net/core/sock.c    | 15 +++++++++++++++
> >   2 files changed, 22 insertions(+)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 0dd464ba9e46..f88a00108a2f 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2920,6 +2920,13 @@ int sock_set_timestamping(struct sock *sk, int o=
ptname,
> >                         struct so_timestamping timestamping);
> >
> >   void sock_enable_timestamps(struct sock *sk);
> > +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op);
> > +#else
> > +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct s=
k_buff *skb, int op)
> > +{
> > +}
> > +#endif
> >   void sock_no_linger(struct sock *sk);
> >   void sock_set_keepalive(struct sock *sk);
> >   void sock_set_priority(struct sock *sk, u32 priority);
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 74729d20cd00..79cb5c74c76c 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -941,6 +941,21 @@ int sock_set_timestamping(struct sock *sk, int opt=
name,
> >       return 0;
> >   }
> >
> > +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op)
> > +{
> > +     struct bpf_sock_ops_kern sock_ops;
> > +
> > +     sock_owned_by_me(sk);
>
> I don't think this can be assumed in the time stamping callback.

I'll remove this.

>
> To remove this assumption for sockops, I believe it needs to stop the bpf=
 prog
> from calling a few bpf helpers. In particular, the bpf_sock_ops_cb_flags_=
set and
> bpf_sock_ops_setsockopt. This should be easy by asking the helpers to che=
ck the
> "u8 op" in "struct bpf_sock_ops_kern *".

Sorry, I don't follow. Could you rephrase your thoughts? Thanks.

>
> I just noticed a trickier one, sockops bpf prog can write to sk->sk_txhas=
h. The
> same should go for reading from sk. Also, sockops prog assumes a fullsock=
 sk is
> a tcp_sock which also won't work for the udp case. A quick thought is to =
do
> something similar to is_fullsock. May be repurpose the is_fullsock someho=
w or a
> new u8 is needed. Take a look at SOCK_OPS_{GET,SET}_FIELD. It avoids
> writing/reading the sk when is_fullsock is false.

Do you mean that if we introduce a new field, then bpf prog can
read/write the socket?

Reading the socket could be very helpful in the long run.

>
> This is a signal that the existing sockops interface has already seen bet=
ter
> days. I hope not too many fixes like these are needed to get tcp/udp
> timestamping to work.
>
> > +
> > +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > +     sock_ops.op =3D op;
> > +     sock_ops.is_fullsock =3D 1;
>
> I don't think we can assume it is always is_fullsock either.

Right, but for now, TCP seems to need this. I can remove this also.

>
> > +     sock_ops.sk =3D sk;
> > +     __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
>
> Same here. sk may not be fullsock. BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops=
) is
> needed.

If we use this helper, we will change when the udp bpf extension needs
to be supported.

>
> [ I will continue the rest of the set later. ]

Thanks a lot :)

>
> > +}
> > +#endif
> > +
> >   void sock_set_keepalive(struct sock *sk)
> >   {
> >       lock_sock(sk);
>

