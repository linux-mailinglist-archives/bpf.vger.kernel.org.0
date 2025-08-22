Return-Path: <bpf+bounces-66262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34DB30AAC
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 03:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AE85E5600
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 01:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBB619D884;
	Fri, 22 Aug 2025 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+Whe0Go"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F6393DCB;
	Fri, 22 Aug 2025 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825240; cv=none; b=ofKSANfi35hop5FeQyUQ0y5Rays7j4TF5aaKcswaHxhwTaxuGPf7GMHWSfBN6uqmiUWDhRMbAzCGPz2cxnhINeAPVOe12DUIkXi0TdYTZZu/xFBdc2mJIMkRWBNjeQANUWYrw8z9T2f9JZ7exYX+Zv94srZLuix13/xkQ3NMmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825240; c=relaxed/simple;
	bh=PaVFeDP1hw6czVGAetNgRFUG0WKB2PJjADJ+HJM7leo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FX+udXKtJ+6Ml1Xc3iuI1Veabg3ZOfqGzHgTKkWdgssvjPWYEGAdOGxBmWrtmarQF5bQ4tRs4v3YlCxxgoFyyaInMpnOfV0uBX4lN9DJFRSORDAIWpwIqlGIoIlDqDdClWxjbaeuGL0p3KGrqli/YDapg/vcHxmerD30yQgqdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+Whe0Go; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e854d14bdaso9244845ab.1;
        Thu, 21 Aug 2025 18:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755825237; x=1756430037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fhvRPLZC9w5VM84CrrbS51W8cB8e6C1HLANawc+4Io=;
        b=H+Whe0Go/ViXxnv5kwHPmHjjtncMVp2q1PrA19bqR5dF81ZELPrqMS25wBRd9VIC00
         PmmAxKSGEvPdwQbtqLyNAKlJmri7YgnQD12DVja8EJoDbUthGsrXwwN1sT+RfCxWyr05
         7U54nv9dm3ZjUuNY4TqV59CAf4BXyXfwihux6w0oa4lsnRWTr5zR8pO2IN7Gg7yj5ZFf
         HEKFYItFIHpvmJxPfCj4253YyC39NIAI80PRomhEusQwTFnt7aDyB+q5FrqCsQISqArR
         CMUbLvosikGT0fooMFGHYe/jMZUWfAahsfM622CiOyLfpddN7GbIfoCqRJjhWzh8sdie
         Sq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755825237; x=1756430037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fhvRPLZC9w5VM84CrrbS51W8cB8e6C1HLANawc+4Io=;
        b=QPfTUJz6Xkw1bjwGt9r8zLwGaZpxnatq5xVBSFmA6fxg9ZszI2sJlIKgtwxKvBb3lH
         F8ByUmhDCL9hIxoEIMqzfc5rAoQl12RlM1RQedlEf3ezQ7bzvHaykChrsuitxakkqdd8
         PtFMVJbtsAqzTJRyDyQeywhpDnECURsn0Piyebbjt38v+M5Vci//u2Zmr7wGzr8Io0lX
         k/gmWm4dCNTLrVquy/ev8W3XmvpMxr/cyvJSxjaNPMXK3UHD7um1dLRmMi/CtiMJVkuZ
         4wWpDeMv8RS2tpmbxNTe4QgtFAsOuRBmBHc+QhxS4TxuEmhIl102ap2I+jYAhGBGCpRq
         /3RA==
X-Forwarded-Encrypted: i=1; AJvYcCWin9qo3YLMQyDxQk0VjMMMmefslmtiiRz82eDU34XYJEU1JHeZNZCcO2G14dMRasopZT5IfhEr@vger.kernel.org, AJvYcCWtJW3ohH9zHLx0clVLQkmzti8F1IZs7/UIdJ5N7WGLaceO4xu64ySR9OutFpGAQfE503w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2W9E3vNAzkRmh/LJBg7kxT5SfQyhyVhBlaJx/GHR7WfBSbiod
	uQT7Y1xSfkIA6ni/7XtBqcd0rpa4mwCofawvLH0XWY6bq5MWkmdc/qkFcV969Ib3XgRFT9gG/6m
	7eBTcFXqv6bGpdHy9gG/gClj5bEZh2VCVq6al8FI=
X-Gm-Gg: ASbGncudDbrn34ZnNnyJs6l/dLAEQ2qgQ0Zts9dyx/H1tbSjT3KcHIjOiJnppA+On4u
	2Kgz/OMk1P/JK++j/0AhoPm2ni5alZQDzyYfL6DvwBH/6yTGn5ojyoUvutsnHCOaUyi6yifQouZ
	SAqG5jZ7GcgSeAOoerg2rGQWimHyPnPrwA1b0zJFY/tnBK02lYaAHRmB7maJVTE11IuXV1YXbMp
	cRU54TsZA==
X-Google-Smtp-Source: AGHT+IEHIAziIsVH1EQ7JqgmmszkiV0xpEOWhhaepZzVxNIPp6JTsaMlX8ciOOlaBp4QIsDeIsFUA32s0Nuuwweh6N0=
X-Received: by 2002:a05:6e02:2701:b0:3e6:ab3a:f9e with SMTP id
 e9e14a558f8ab-3e922ad56dbmr26412315ab.24.1755825237547; Thu, 21 Aug 2025
 18:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com> <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
 <CAL+tcoBWOUCd8f1Q6BYh+xuKs5=Qgr2oOBb9CLU_6BrasD0vfg@mail.gmail.com> <599598da-5453-4cd9-b19d-ca7935985030@kernel.org>
In-Reply-To: <599598da-5453-4cd9-b19d-ca7935985030@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 22 Aug 2025 09:13:21 +0800
X-Gm-Features: Ac12FXwjiIQL91GfXzzqfBBHPYtaiQhfwN-0ZRmDZDpzdF2imFrx3Ua1q2g1Vlk
Message-ID: <CAL+tcoBvLHFJJuYawJc3wY2aOrn5CQ3s5+sbC2M24_QNLyBHsg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:29=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> I need some help from Cc Magnus or Bj=C3=B6rn, to explain why you changes
> fails in xsk_destruct_skb().

Oh, I mean the reason for using socket level accounting is we need to
make sure of the safety in tx completion period. In xsk, that is,
xsk_destruct_skb needs to fetch the corresponding sk from skb and
manipulate its ring structure. Without accounting, the socket can be
released and destroyed before the driver calls skb->destructor(). Only
with the accounting protection, the socket is still alive because the
following code:
sock_wfree()
    -> if (refcount_sub_and_test(len, &sk->sk_wmem_alloc))
             __sk_free(sk);

It seems no way to rid the accounting feature for now without
refactoring the whole logic.

We can probably remove the sk_sndbuf limitation, but I still do more
investigation :)

Thanks,
Jason

>
>
> On 15/08/2025 08.44, Jason Xing wrote:
> > On Tue, Aug 12, 2025 at 10:30=E2=80=AFPM Jesper Dangaard Brouer <hawk@k=
ernel.org> wrote:
> >>
> > ...
> >>
> >> But this also requires changing the SKB alloc function used by
> >> xsk_build_skb(). As a seperate patch, I recommend that you change the
> >> sock_alloc_send_skb() to instead use build_skb (or build_skb_around).
> >> I expect this will be a large performance improvement on it's own.
> >> Can I ask you to benchmark this change before the batch xmit change?
> >>
> >> Opinions needed from other maintainers please (I might be wrong!):
> >> I don't think the socket level accounting done in sock_alloc_send_skb(=
)
> >> is correct/relevant for AF_XDP/XSK, because the "backpressure mechanis=
m"
> >> code comment above.
> >
> > Here I'm bringing back the last test you expected to know :)
> >
> > I use alloc_skb() to replace sock_alloc_send_skb() and introduce other
> > minor changes, say, removing sock_wfree() from xsk_destruct_skb(). It
> > turns out to be a stable 5% performance improvement on i40e driver.
> > slight improvement on virtio_net. That's good news.
> >
> > Bad news is that the above logic has bugs like freeing skb in the napi
> > poll causes accessing skb->sk in xsk_destruct_skb() which triggers a
> > NULL pointer issue. How did I spot this one? I removed the BQL flow
> > control and started two xdpsock on different queues, then I saw a
> > panic[1]... To solve the problem like that, I'm afraid that we still
> > need to charge a certain length value into sk_wmem_alloc so that
> > sock_wfree(skb) can be the last one to free the socket finally.
> >
> > So this socket level accounting mechanism keeps its safety in the above=
 case.
> >
> > IMHO, we can get rid of the limitation of sk_sndbuf but still use
> > skb_set_owner_w() that charges the len of skb. If we stick to removing
> > the whole accounting function, probably we have to adjust the position
> > of xsk_cq_submit_locked(), but I reckon for now it's not practical...
> >
> > Any thoughts on this?
> >
> > [1]
> >   997 [  133.528449] RIP: 0010:xsk_destruct_skb+0x6a/0x90
> >   998 [  133.528920] Code: 8b 6c 02 28 48 8b 43 18 4c 8b a0 68 03 00 00
> > 49 8d 9c 24 e8 00 00 00 48 89 df e8 f1 eb 06 00 48 89 c6 49 8b 84 24
> > 88 00 00 00 <48> 8b 50 10 03 2a 48      8b 40 10 48 89 df 89 28 5b 5d
> > 41 5c e9 6e ec
> >   999 [  133.530526] RSP: 0018:ffffae71c06a0d08 EFLAGS: 00010046
> > 1000 [  133.531005] RAX: 0000000000000000 RBX: ffff9f42c81c49e8 RCX:
> > 00000000000002e7
> > 1001 [  133.531631] RDX: 0000000000000001 RSI: 0000000000000286 RDI:
> > ffff9f42c81c49e8
> > 1002 [  133.532249] RBP: 0000000000000001 R08: 0000000000000008 R09:
> > 00000000000000001003 [  133.532867] R10: ffffffff978080c0 R11:
> > ffffae71c06a0ff8 R12: ffff9f42c81c4900
> > 1004 [  133.533491] R13: ffffae71c06a0d88 R14: ffff9f42e0f1f900 R15:
> > ffff9f42ce850d801005 [  133.534123] FS:  0000000000000000(0000)
> > GS:ffff9f5227655000(0000) knlGS:00000000000000001006 [  133.534831]
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 1007 [  133.535366] CR2: 0000000000000010 CR3: 000000011c820000 CR4:
> > 00000000003506f0
> > 1008 [  133.536014] Call Trace:
> > 1009 [  133.536313]  <IRQ>
> > 1010 [  133.536583]  skb_release_head_state+0x20/0x90
> > 1011 [  133.537021]  napi_consume_skb+0x42/0x120
> > 1012 [  133.537429]  __free_old_xmit+0x76/0x170 [virtio_net]
> > 1013 [  133.537923]  free_old_xmit+0x53/0xc0 [virtio_net]
> > 1014 [  133.538395]  virtnet_poll+0xed/0x5d0 [virtio_net]
> > 1015 [  133.538867]  ? blake2s_compress+0x52/0xa0
> > 1016 [  133.539286]  __napi_poll+0x28/0x200
> > 1017 [  133.539668]  net_rx_action+0x319/0x400
> > 1018 [  133.540068]  ? sched_clock_cpu+0xb/0x190
> > 1019 [  133.540482]  ? __run_timers+0x1d1/0x260
> > 1020 [  133.540906]  ? __pfx_dl_task_timer+0x10/0x10
> > 1021 [  133.541349]  ? lock_timer_base+0x72/0x90
> > 1022 [  133.541767]  handle_softirqs+0xce/0x2e0
> > 1023 [  133.542178]  __irq_exit_rcu+0xc6/0xf0
> > 1024 [  133.542575]  common_interrupt+0x81/0xa0
> >
> > Thanks,
> > Jason
>

