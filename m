Return-Path: <bpf+bounces-42727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0F69A9642
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 04:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE01DB21EA0
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE628139590;
	Tue, 22 Oct 2024 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEymChJE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7ED33DF;
	Tue, 22 Oct 2024 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564282; cv=none; b=ZYu4kxmrCgPHoppvthIDeUq0z562OhhfCkn5QQ6hArxFPWJs7eO7/x0rob4/Rs9d1naXkZWfKrJG9F+I2ux5eVS/U9NRX4yokUz8sse2sx7N4TmsXav1IkOuuH4kjYjkI6HmwXVNESn3euQNrtGlFD53K9Ev/PWIBRL+NHVA7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564282; c=relaxed/simple;
	bh=O8oTjqKMhm2QHG7+eUTitujGRHoo5iIdb6R/ca3J+Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riTRceJMKB+7dX1T3Ut7GK9evIEBrljBUD3FWsoApYcJCC8KrzFkXE789OMmDn7rW/AhZp9C4HFmQrWGrHadDmOwg8AczuVO/F83XZKa34JB8IO0PxDnOSOOJ0FHJVLIHCuKBARPjuKoG1Lq8LPlS6+LdZ1Sahi0w//yjUrAt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEymChJE; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3a6abcbf1so20433025ab.2;
        Mon, 21 Oct 2024 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729564279; x=1730169079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLUuwv+RQpJkyGiZIdoqTSdsnPX9bCf98MBgsgFSlXE=;
        b=CEymChJEtp5d/ihLECtlUjqTLOi/jzH409w/XVD9PcSgdlBjwhYnRRseV6FZGrqPSQ
         /f9PtwSwEzLVyb6xQg+jCZB/p9U7C1+15w5MkEfLB9SbCQVFgkFGk5eVXUm/Gn+0TJ4A
         3ZDhy6WkqW2EQ/44Uf4asKdQopP7RgaPQReXLRyoWFiGl94AZMiyJKLFXR+whJv2Ur9R
         GQ0QDElU9pAhaguM6snLyMTkwe6ZSVW6TVKNWzfV0D6suCwayL0PRa9neCGZMjMeT9+6
         YeYV5dI35TeeGS/BqvzbeJLVeUhu9YvGzO/WDSiuzJB3PUzkW16hufFJ4wvi7SCF9GD4
         BgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729564279; x=1730169079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLUuwv+RQpJkyGiZIdoqTSdsnPX9bCf98MBgsgFSlXE=;
        b=GU5LPc7k5X4wIAHWddDBDB102LfHd/fXNwelViCv8mM4ryt58C223anJx7ICs1i5KP
         N2ii7PQxr1Jl7EP8mq8MXCpwQUyVHYY5Sp7++pahWiLkbqdJcXXiQwKCiCZ24DohFtpm
         X13W5zr+Q5IcSks9E1/8XimlXUGZsaN9E0gvxZCXjb9vP2mtp4DSs4GI83myF6QGz1dz
         8YlGWvCuMiueP7MBMpOcW3pGdPuDRILPMv6NhhfhimoAL9xG/NPl8rWT+3WSESW+tHMn
         xRDkFuBZ+OfQMv8Tfw78+UfXieusC7FotPo7J7aa5J4HtMTUAxyNPrN2wUvXXvHIc4Z/
         c3xA==
X-Forwarded-Encrypted: i=1; AJvYcCVOwSo1GAZj2rJ3ifwD39yglqVtHKSyzrWS3TmaUoBhuk958ep7zO//f1Y3b39V4u+9u8U=@vger.kernel.org, AJvYcCXM+J8c1U+TdeM/PAYxCQgvyvH1bZtCRfWNWFOX7TZisdWdhtsF5cvSvfqeaw1l0KAHexFiiQJy@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5ZunuuFMlNcwyUQSP0JZ6VX31YqPwdspxQjIvgpuMBe0nNmv
	P3imBpZK/1AelZL6srhGvhg3+7TJD0inCSo5Vnfd9qd6jrDq265P6OoXueIENMSwAQw6+x7/+Kp
	Gjqpfko3QHdWyK2nsx4OWZq6VQpY=
X-Google-Smtp-Source: AGHT+IHjQSUWlZ00PTbPaB56jwI7F/rkEGf3ngpo8tlHQvc9dk0q66xVL19vBidgM4AEJ3H+36sf+KbBJ9NwTmj5uxw=
X-Received: by 2002:a05:6e02:160c:b0:3a0:8d8a:47c with SMTP id
 e9e14a558f8ab-3a4cb39c68amr22713845ab.14.1729564279446; Mon, 21 Oct 2024
 19:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
 <8a5f7f86-0784-4da3-a1b0-c2d88f3572d0@linux.dev>
In-Reply-To: <8a5f7f86-0784-4da3-a1b0-c2d88f3572d0@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Oct 2024 10:30:42 +0800
Message-ID: <CAL+tcoAiave2+S6O+6pNvSL2fjnjjmRX2XZQPan-ACTGYz2r=w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 8:53=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/20/24 2:51 PM, Willem de Bruijn wrote:
> > Jason Xing wrote:
> >> From: Jason Xing <kernelxing@tencent.com>
> >>
> >> Willem suggested that we use a static key to control. The advantage
> >> is that we will not affect the existing applications at all if we
> >> don't load BPF program.
> >>
> >> In this patch, except the static key, I also add one logic that is
> >> used to test if the socket has enabled its tsflags in order to
> >> support bpf logic to allow both cases to happen at the same time.
> >> Or else, the skb carring related timestamp flag doesn't know which
> >> way of printing is desirable.
> >>
> >> One thing important is this patch allows print from both applications
> >> and bpf program at the same time. Now we have three kinds of print:
> >> 1) only BPF program prints
> >> 2) only application program prints
> >> 3) both can print without side effect
> >>
> >> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > Getting back to this thread. It is long, instead of responding to
> > multiple messages, let me combine them in a single response.
> >
> >
> > * On future extensions:
> >
> > +1 that the UDP case, and datagrams more broadly, must have a clear
> > development path, before we can merge TCP.
> >
> > Similarly, hardware timestamps need not be supported from the start,
> > but must clearly be supportable.
> >
> >
> > * On queueing packets to userspace:
> >
> >>> the current behavior is to just queue to the sk_error_queue as long
> >>> as there is "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it
> >>> is regardless of the sk_tsflags. "
> >
> >> Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
> >> SOF_TIMESTAMPING_TX_* are generation flags. Without former, users can
> >> read the skb from the errqueue but are not able to parse the
> >> timestamps
> >
> > Before queuing a packet to userspace on the error queue, the relevant
> > reporting flag is always tested. sock_recv_timestamp has:
> >
> >          /*
> >           * generate control messages if
> >           * - receive time stamping in software requested
> >           * - software time stamp available and wanted
> >           * - hardware time stamps available and wanted
> >           */
> >          if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> >              (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> >              (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> >              (hwtstamps->hwtstamp &&
> >               (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> >                  __sock_recv_timestamp(msg, sk, skb);
> >
> > Otherwise applications could get error messages queued, and
> > epoll/poll/select would unexpectedly behave differently.
>
> I just tried the following diff to remove setsockopt from txtimestamp.c a=
nd run
> "./txtimestamp -6 -c 1 -C -N -L ::1". It is getting the skb from the erro=
r queue
> with only cmsg flag. I did a printk in __skb_tstamp_tx to ensure the
> sk->sk_tsflags is empty also.
>
> diff --git i/tools/testing/selftests/net/txtimestamp.c
> w/tools/testing/selftests/net/txtimestamp.c
> index dae91eb97d69..5d9d2773b076 100644
> --- i/tools/testing/selftests/net/txtimestamp.c
> +++ w/tools/testing/selftests/net/txtimestamp.c
> @@ -319,6 +319,8 @@ static void __recv_errmsg_cmsg(struct msghdr *msg, in=
t
> payload_len)
>         for (cm =3D CMSG_FIRSTHDR(msg);
>              cm && cm->cmsg_len;
>              cm =3D CMSG_NXTHDR(msg, cm)) {
> +               printf("cm->cmsg_level %d cm->cmsg_type %d\n",
> +                      cm->cmsg_level, cm->cmsg_type);
>                 if (cm->cmsg_level =3D=3D SOL_SOCKET &&
>                     cm->cmsg_type =3D=3D SCM_TIMESTAMPING) {
>                         tss =3D (void *) CMSG_DATA(cm);
> @@ -362,7 +364,7 @@ static void __recv_errmsg_cmsg(struct msghdr *msg, in=
t
> payload_len)
>         if (batch > 1) {
>                 fprintf(stderr, "batched %d timestamps\n", batch);
>         } else if (!batch) {
> -               fprintf(stderr, "Failed to report timestamps\n");
> +               fprintf(stderr, "Failed to report timestamps. payload_len=
 %d\n", payload_len);
>                 test_failed =3D true;
>         }
>   }
> @@ -578,9 +580,12 @@ static void do_test(int family, unsigned int report_=
opt)
>         if (cfg_loop_nodata)
>                 sock_opt |=3D SOF_TIMESTAMPING_OPT_TSONLY;
>
> +       (void)sock_opt;
> +/*
>         if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
>                        (char *) &sock_opt, sizeof(sock_opt)))
>                 error(1, 0, "setsockopt timestamping");
> +*/
>
>         for (i =3D 0; i < cfg_num_pkts; i++) {
>                 memset(&msg, 0, sizeof(msg));
> >
> >> SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPING
> >> features including cmsg mode. But it will not be used in bpf mode.
> >
> > For simplicity, the two uses of the API are best kept identical. If
> > there is a technical reason why BPF has to diverge from established
> > behavior, this needs to be explicitly called out in the commit
> > message.
>
> SOF_TIMESTAMPING_OPT_TSONLY will not be supported. The orig_skb can alway=
s be
> passed directly to the bpf if needed without extra cost. The same probabl=
y goes
> for SOF_TIMESTAMPING_OPT_PKTINFO.

Right, they will not be supported.

> SOF_TIMESTAMPING_SOFTWARE does not seem to be
> useful either. I think only a subset of SOF_* will be supported, probably=
 only

I had a discussion with Willem on this point yesterday. If I
understand what Willem was thinking correctly, he doesn't expect
users' behaviors to change too much.

As I said previously, I have no strong preference. Whether keeping
this report flag or not doesn't affect the core logic for BPF
extension.

> the TX_* and RX_* ones.
>
> >
> > Also, if you want to extend the API for BPF in the future, good to
> > call this out now and ideally extensions will apply to both, to
> > maintain a uniform API.
> >
> >
> > * On extra measurement points, at sendmsg or tcp_write_xmit:
> >
> > The first is interesting. For application timestamping, this was
> > never needed, as the application can just call clock_gettime before
> > sendmsg.
> >
> > In general, additional measurement points are not only useful if the
> > interval between is not constant. So far, we have seen no need for
> > any additional points.
> >
> >
> > * On skb state:
> >
> >>> For now, is there thing we can explore to share in the skb_shared_inf=
o?
> >
> > skb_shinfo space is at a premium. I don't think we can justify two
> > extra fields just for this use case.
> >
> >> My initial thought is just to reuse these fields in skb. It can work
> >> without interfering one another.
> >
> > I'm skeptical that two methods can work at the same time. If they are
> > started at different times, their sk_tskey will be different, for one.
>
> For the skb's tx_flags, Jason seems to be able to figure out by only usin=
g the
> new sk_tsflags_bpf. In the worst case, it seems there is still one bit le=
ft in
> tx_flags.

Let me try, then we'll see if it works.

>
> I am also not very positive on the skb's tskey for now.

For TCP, the final output of tskey that is reflected to users is the
result of this calculation "shinfo->tskey - $KEY". $KEY is the base
which could be either sk->sk_tskey or sk->sk_tskey_bpf. They are
initialized at different points.

You can see the calculation in __skb_complete_tx_timestamp():
serr->ee.ee_data =3D skb_shinfo(skb)->tskey;
serr->ee.ee_data -=3D atomic_read(&sk->sk_tskey);

With that said, we will keep two different $KEY to let each feature
(bpf SO_TIMESTAMPING or application SO_TIMESTAMPING) work
respectively, which also means, we probably will see two different
tskeys when two methods work parallely. It's fine because as long as
we can make sure the final tskeys are consistent in each feature.
tskey is used to identify which sendmsg() the skb should belong to.

It also works for UDP proto.

>
> Willem, I recalled I had tried to reuse the tx_flags and hwtstamp when ke=
eping
> the delivery time in skb->tstamp for a skb redirecting from egress to ing=
ress. I
> think that approach was stalled because the tx_flags could be changed by =
the
> netdevice like "skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS". How ab=
out the
> skb_shinfo(skb)->hwtstamps? At least for the TX path, it should not be ch=
anged
> until the netdevice calling skb_tstamp_tx() to report the hwtstamp? or th=
e clone
> in the tcp stack will still break things if the hwtstamps is reused for o=
ther
> purpose?
>
> >
> > There may be workarounds. Maybe BPF can store its state in some BPF
> > specific field, indeed. Or perhaps it can store per-sk shadow state
> > that resolves the conflict. For instance, the offset between sk_tskey
> > and bpf_tskey.
>
> I have also been proposing to explore other way for the key since bpf has=
 direct
> access to the skb (also the sk, bpf prog can store data in the sk).
>
> The bpf prog can learn what is the seq_no of the egress-ing skb. When the=
 ack
> comes back, it can also learn the ack seq no. Does it help? It will be ha=
rder to
> use because it probably needs to store this info in the bpf map (or in th=
e bpf
> sk storage). However, if it needs to learn the timestamp at the
> tcp_sendmsg/tcp_transmit_skb/tcp_write_xmit, this timestamp has to be sto=
red
> somewhere also. Either in a bpf map or in a bpf sk storage.

Thanks for the idea. But please see the above comment, we could keep
the logic as simple as it is :)

>
> SEC("cgroup/setsockopt") prog can also enforce the user space setsockopt.=
 e.g.
> it can add SOF_TIMESTAMPING_OPT_ID_TCP when user space only use
> SOF_TIMESTAMPING_OPT_ID.

Interesting.

Thanks,
Jason

