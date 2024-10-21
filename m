Return-Path: <bpf+bounces-42568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E39A5938
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 05:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E7BB21B22
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229C51CF7B6;
	Mon, 21 Oct 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6ITgOPk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693E1CF5E0;
	Mon, 21 Oct 2024 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729480958; cv=none; b=bq2aX0S6vS20fACB08ItSw7EbAp/XPjfUoy68QirFrwZyM2Jg//VoIj8teUSgZfsX7V5oFvYYXxMFLq1rFoj5Q3q1TuwckxRpGQSD/dTV3GGVEEa0bUiUctFzu0p1R3qzZxdIwMNlvEvM/jDsBU1AoJ8ZSURES8C5wLNIwlZLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729480958; c=relaxed/simple;
	bh=ksP8LwGpFAYFgR4P37p0bBobqzhHdq7kH4//H6xtfho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDjjfyOff9Z99rD9jdQJwQkY3y03l7g93mLoK8qmGdKbWvTJ3em9rZby/5tKsBUhKGvu4J6KWPcPXEbjMNFSUmVzakPTtzseC2HxwrFtaTBLOhdY4LQat7iSGe7FQHDAM5gx1+adiaEPIn45vptje0HYazxMmrTpl7vzc+gXcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6ITgOPk; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3bd422b52so13834035ab.0;
        Sun, 20 Oct 2024 20:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729480956; x=1730085756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GuM11PwJFYp0ljBakV+Tj0eSAn8rxi3H1x32Gubpbk=;
        b=d6ITgOPk0VVS6jr/F3ZQSwXmkyHnDQMGpmtdpBh/0Ocr+xlArq/QSWLdG6PdnyF1yb
         yjBKmXStwwTACAYnDUVewQIF2k9t+isNQQ9z2DuJ1+qdQy2+ZG9HOJlkbJjVDBsuXa57
         IiT4Kdv9TUaqFXVvVpDrh8GvGOqAduFlMc4Z3/HQF59pLtfIV3ugPyWp3Uo4p/rISdUf
         xzvfdZWTcMeNH2eguZEYXJmtAW7nDlH1rdyrn2ZsjaRPCZcEyYZPij8oOxXJVz+dwsDw
         4xDLQrv2IzIF5Cm0Z2yEujfHydbI8MLhxaOLdEK/xV4IXMgJ1cbIC/vLR3GcCUUbmHl+
         TJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729480956; x=1730085756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GuM11PwJFYp0ljBakV+Tj0eSAn8rxi3H1x32Gubpbk=;
        b=BNVnJLhO8CUweFhqLzsr7M+GH6yv8xdPov94miR/VXnVaA9QYuN3rE4hE37iip9kot
         zr6doz0vBh9w+VAdNzWdtvDLBCNl19pNf989WlfrSTQ+V9hn/tGBbMejIHStkkacCs5V
         XsqKZIlJgK4BVBKMai++I7ljP072MInai/TJQBJZ9uQAyYrwag7V1BsvgEybhP7i65xH
         wRkDjRQ0xkqa0UrJy9jVcF7OsRJpIC1vAFpkZJO5oLZaJScqGPA0xmjyeNNUUBA/9BvI
         WPLkIhy9oQbpA3ElWvZAWyCHefPkl73rFLfW51FjaOfqadLI6HnOT89D+531mivOjBgc
         /gBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8BXZHZEUM+Cres2UqaYfTnCwBJ++HevSH5WlD97mjlUczKSyYReOKMqSM60Jgy4b4doQ=@vger.kernel.org, AJvYcCVq0pcRtS+NTvhcZnAX7XedLBYKqsjauYGKSQvkFr7QsMtiuadPO+8BFbu0GcEQMsbM1wEuZLPT@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGH6Ibo9kmPIL2xpDTwJcX1QGkXUsJxqmPPrGmjDaBXkUS2GX
	Y79TLTFtUzrrB7Fs4MLAmB6q2h6uLo++EU5V6BtNDAdMkjmf3GXttQ5ELwYWxazXcTcISmSOysI
	Q3e4bGMQAJQEFzIUNLZr0UC8buz0=
X-Google-Smtp-Source: AGHT+IFCEOVV1BGi3VsUnXApu9R+NXubrEyX+1dEbr5WLZGmZEtxHMBaqNRidpxCn6UBNSDzyFH5Xavh5PxC45vmUWM=
X-Received: by 2002:a05:6e02:160a:b0:3a3:da4f:79f8 with SMTP id
 e9e14a558f8ab-3a3f4050885mr87056575ab.5.1729480955550; Sun, 20 Oct 2024
 20:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
In-Reply-To: <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Oct 2024 11:21:59 +0800
Message-ID: <CAL+tcoD5TiaRZgW10tt8jc9srQTbaszs_o2z=Yf-bzO0Kp-vLA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 5:52=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Willem suggested that we use a static key to control. The advantage
> > is that we will not affect the existing applications at all if we
> > don't load BPF program.
> >
> > In this patch, except the static key, I also add one logic that is
> > used to test if the socket has enabled its tsflags in order to
> > support bpf logic to allow both cases to happen at the same time.
> > Or else, the skb carring related timestamp flag doesn't know which
> > way of printing is desirable.
> >
> > One thing important is this patch allows print from both applications
> > and bpf program at the same time. Now we have three kinds of print:
> > 1) only BPF program prints
> > 2) only application program prints
> > 3) both can print without side effect
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> Getting back to this thread. It is long, instead of responding to
> multiple messages, let me combine them in a single response.

Thank you so much!

>
>
> * On future extensions:
>
> +1 that the UDP case, and datagrams more broadly, must have a clear
> development path, before we can merge TCP.
>
> Similarly, hardware timestamps need not be supported from the start,
> but must clearly be supportable.

Agreed. Using the standalone sk_tsflags_bpf and tskey_bpf and removing
the TCP bpf test logic(say, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)
could work well for both protos. Let me give it a try first.

>
>
> * On queueing packets to userspace:
>
> > > the current behavior is to just queue to the sk_error_queue as long
> > > as there is "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it
> > > is regardless of the sk_tsflags. "
>
> > Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
> > SOF_TIMESTAMPING_TX_* are generation flags. Without former, users can
> > read the skb from the errqueue but are not able to parse the
> > timestamps

Above is what I tried to explain how the application timestamping
feature works, not what I tried to implement for the BPF extension.

>
> Before queuing a packet to userspace on the error queue, the relevant
> reporting flag is always tested. sock_recv_timestamp has:
>
>         /*
>          * generate control messages if
>          * - receive time stamping in software requested
>          * - software time stamp available and wanted
>          * - hardware time stamps available and wanted
>          */
>         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
>             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
>             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
>             (hwtstamps->hwtstamp &&
>              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
>                 __sock_recv_timestamp(msg, sk, skb);
>
> Otherwise applications could get error messages queued, and
> epoll/poll/select would unexpectedly behave differently.

Right. And I have no intention to use the SOF_TIMESTAMPING_SOFTWARE
flag for BPF.

>
> > SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPING
> > features including cmsg mode. But it will not be used in bpf mode.
>
> For simplicity, the two uses of the API are best kept identical. If
> there is a technical reason why BPF has to diverge from established
> behavior, this needs to be explicitly called out in the commit
> message.
>
> Also, if you want to extend the API for BPF in the future, good to
> call this out now and ideally extensions will apply to both, to
> maintain a uniform API.

As you said, I also agree on "two uses of the API are best kept identical".

>
>
> * On extra measurement points, at sendmsg or tcp_write_xmit:
>
> The first is interesting. For application timestamping, this was
> never needed, as the application can just call clock_gettime before
> sendmsg.

Yes, we could add it after we finish the current series. I'm going to
write it down on my todo list.

>
> In general, additional measurement points are not only useful if the
> interval between is not constant. So far, we have seen no need for
> any additional points.

Taking a snapshot of tcp_write_xmit() could be useful especially when
the skb is not transmitted due to nagle algorithm.

>
>
> * On skb state:
>
> > > For now, is there thing we can explore to share in the skb_shared_inf=
o?
>
> skb_shinfo space is at a premium. I don't think we can justify two
> extra fields just for this use case.
>
> > My initial thought is just to reuse these fields in skb. It can work
> > without interfering one another.
>
> I'm skeptical that two methods can work at the same time. If they are
> started at different times, their sk_tskey will be different, for one.

Right, sk_tskey is the only special one that I will take care of.
Others like tx_flags or txstamp_ack from struct tcp_skb_cb can be
reused.

>
> There may be workarounds. Maybe BPF can store its state in some BPF
> specific field, indeed. Or perhaps it can store per-sk shadow state
> that resolves the conflict. For instance, the offset between sk_tskey
> and bpf_tskey.

Things could get complicated in the future if we want to unified the
final tskey value for all the cases. Since 1) the value of
shinfo->tskey depends on skb seq and len, 2) the final tskey output is
the diff between sk_tskey and shinfo->tskey, can I add a bpf_tskey in
struct sock and related output logic for bpf without caring if it's
the same as sk_tskey.

That said, the outputs from two methods differ. Do you think it is
acceptable? It could be simpler and easier if we keep them identical.

Again, thanks for your long conclusion and every review.

Thanks,
Jason

