Return-Path: <bpf+bounces-50485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE42A2824C
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 04:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD02D3A63F5
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 03:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D600213220;
	Wed,  5 Feb 2025 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAjC3WAU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9D2F46;
	Wed,  5 Feb 2025 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738724779; cv=none; b=UakzNvTL9eKRNqBA0JFTu9cb7OABP3s4l6/xhWWm9KzW5AS1+su3SSumm2X/Eq9ANgrzKg6gmy3qsNiQNd5SMNLhsAEFcnwzgj4MHd5loggKLWIBEpzvgY6EMcJvEGfvqOIHFslGTZlIbEa1I7bPMJAIk2AZRiBqyHuwBmGpBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738724779; c=relaxed/simple;
	bh=+2WSom+zFp9xMS1ku6+1uC4AH8DPo+gNckTrmC6MLAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7tAfXMLWzzMJN/ZFP19dRqU3yF8UhuKD5TRAZsiLDBpYqXTWZN/iAqLbCuR8tgUJ8Y7YqKqxURnGjKKyDMCIuf14rUArp5IAJfdUCXfbZMYC9FzgfROm0Q/nsbDDTFqbs8G9dp/7yWigB9xG2heI+/oM/CqeIWl8DIQEL82EyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAjC3WAU; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-84cdacbc373so167097439f.1;
        Tue, 04 Feb 2025 19:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738724777; x=1739329577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+6KI/9WmqVasEIUTIcd2lk32hRS2lZDYJj0NeDPdso=;
        b=TAjC3WAU6bFroTOP+h8EOwyrzgMROK1cF59S6sB5YfdaNjGKkepq6Oiy+whxCYBeoY
         HY13L1cJErCh2vjsJhrB6DZR6zkL5yNUadZbC6jgt7zx9WaVsaM50vthtZ+9nyiSqcZI
         bXL/L5eqAXVdkkKVQT0842QxkOtmlvAE1mK9u1dHZMORrMfpPSxW9ATX6vN6L9P0lVFQ
         OJ4y3YPHZ3+f53XGbFhre7LuE12ElhQ7YDLOnLjT3VwsduLgs6b8+CSJcHIr/RE62xlX
         NO9DEEWNiN/wIINSd7AKJwkSNAQj3YbgfGByjYbwKfHgSrCUje4vMPCd82jh97PVqiXh
         OOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738724777; x=1739329577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+6KI/9WmqVasEIUTIcd2lk32hRS2lZDYJj0NeDPdso=;
        b=oCgd1BN6Fr8Mn/73yTbMekES6Bh6CBs2Wij+CBMqb41pulkfcmHkDvhgRUHI/QfYk2
         tCxhP1XcSB60gyxtn2T4A9AaQ67MlYrYB4CYAUuoHfBuSRC0trt19saIqWW/JkNwT1w4
         4Z3bv/nw5YqpD1rs6/GPatWHR74nKuGespsUC5YUHywdugID4LWqC/g235FumLk7CaKP
         FFdWrcffI0014LsCHdCgAYpBIIf9S93kj+I9sRXOuWvYwvyojOwocHUS6MWKFtYRXNhx
         t9Gzs7T42P3zb1GgwGSSMKST6XADP6Oxp/kq3IRejsRRkT+gPw0aOlp70UQ5xYJPb1Ok
         hAUw==
X-Forwarded-Encrypted: i=1; AJvYcCWbazHEG6r/RjNIaBGQQnW7/A1bQQf7rtqr6ayJ3CvuCTpHe1o5IGZ6w38x2vjTf/BZdvRBgXP6@vger.kernel.org, AJvYcCXBp5ZWj4h0Ak3AVduMT1vvg3QkHGsObBjgGuayYD+kizKTTb4PTeBIdQMk+fO7GHfDzHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDLR5vpF0W+K2tMk7DX2YOXMlBK5U33irEj9z2kiVJDVnm5Te
	3a3C+8QNWyCFv11oZq3dNOC5Z3wivdEUJE9JJqRjlgAB1fvCRdfWF7MKhnvK/2w5k2xPWypPqjP
	lJk0QQHNCv3aarEA44nODoxeUPxM=
X-Gm-Gg: ASbGncsBIJbKOvrortC6j4EEdhw3mLPm1acKz8Ijt16F4ek6UY0OOzT2K/BltDfC4RX
	ENGftZRO6NU9MCZvCcANqWwU4J2YfGezbxsorS/E8420xugrKvW/UvISs52TmSLPU8yE/PjE=
X-Google-Smtp-Source: AGHT+IHBRiin6nir8yHqZz/DBuino8+/Jb19GIucVaLMjMY6MjlcT5TSeMiElupvoB4g0J6ytRPTP93/h+nHkstU7DQ=
X-Received: by 2002:a05:6e02:b4d:b0:3cf:f8de:7662 with SMTP id
 e9e14a558f8ab-3d04f8f6c8dmr12497805ab.18.1738724776838; Tue, 04 Feb 2025
 19:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-12-kerneljasonxing@gmail.com> <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
 <CAL+tcoDZXc56BsO9tYvb1EFDdMHhv3OcBsPwY3ctJ85rvb+OHA@mail.gmail.com>
 <67a24989d7202_bb56629425@willemb.c.googlers.com.notmuch> <CAL+tcoA7Efzxg9c-CBn3S0JEQZLUHBaCA+dL=mgWbVh26SukgA@mail.gmail.com>
In-Reply-To: <CAL+tcoA7Efzxg9c-CBn3S0JEQZLUHBaCA+dL=mgWbVh26SukgA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 11:05:40 +0800
X-Gm-Features: AWEUYZlQ1MiWn159ghBwBLx007vI2XECdtBIb6NMBrxoWScDSt13d5IQ43nMMeI
Message-ID: <CAL+tcoAeBJ=F8cZ9qYwGF6jmc+DwA2byrrzAZjcpNYzrjT541g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 11/13] net-timestamp: add a new callback in tcp_tx_timestamp()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 2:09=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Feb 5, 2025 at 1:08=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> > > >
> > > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > > Introduce the callback to correlate tcp_sendmsg timestamp with ot=
her
> > > > > points, like SND/SW/ACK. We can let bpf trace the beginning of
> > > > > tcp_sendmsg_locked() and fetch the socket addr, so that in
> > > >
> > > > Instead of "fetch the socket addr...", should be "store the sendmsg=
 timestamp at
> > > > the bpf_sk_storage ...".
> > >
> > > I will revise it. Thanks.
> > >
> > > >
> > > > > tcp_tx_timestamp() we can correlate the tskey with the socket add=
r.
> > > >
> > > >
> > > > > It is accurate since they are under the protect of socket lock.
> > > > > More details can be found in the selftest.
> > > >
> > > > The selftest uses the bpf_sk_storage to store the sendmsg timestamp=
 at
> > > > fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_timestamp=
 (i.e.
> > > > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> > > >
> > > > >
> > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > ---
> > > > >   include/uapi/linux/bpf.h       | 7 +++++++
> > > > >   net/ipv4/tcp.c                 | 1 +
> > > > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > > > >   3 files changed, 15 insertions(+)
> > > > >
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > index 800122a8abe5..accb3b314fff 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -7052,6 +7052,13 @@ enum {
> > > > >                                        * when SK_BPF_CB_TX_TIMEST=
AMPING
> > > > >                                        * feature is on.
> > > > >                                        */
> > > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendms=
g syscall
> > > > > +                                      * is triggered. For TCP, i=
t stays
> > > > > +                                      * in the last send process=
 to
> > > > > +                                      * correlate with tcp_sendm=
sg timestamp
> > > > > +                                      * with other timestamping =
callbacks,
> > > > > +                                      * like SND/SW/ACK.
> > > >
> > > > Do you have a chance to look at how this will work at UDP?
> > >
> > > Sure, I feel like it could not be useful for UDP. Well, things get
> > > strange because I did write a long paragraph about this thing which
> > > apparently disappeared...
> > >
> > > I manage to find what I wrote:
> > >     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suitable because
> > >     there are two sending process, 1) lockless path, 2) lock path, wh=
ich
> > >     should be handled carefully later. For the former, even though it=
's
> > >     unlikely multiple threads access the socket to call sendmsg at th=
e
> > >     same time, I think we'd better not correlate it like what we do t=
o the
> > >     TCP case because of the lack of sock lock protection. Considering=
 SND_CB is
> > >     uapi flag, I think we don't need to forcely add the 'TCP_' prefix=
 in
> > >     case we need to use it someday.
> > >
> > >     And one more thing is I'd like to use the v5[1] method in the nex=
t round
> > >     to introduce a new tskey_bpf which is good for UDP type. The new =
field
> > >     will not conflict with the tskey in shared info which is generate=
d
> > >     by sk->sk_tskey in __ip_append_data(). It hardly works if both fe=
atures
> > >     (so_timestamping and its bpf extension) exists at the same time. =
Users
> > >     could get confused because sometimes they fetch the tskey from sk=
b,
> > >     sometimes they don't, especially when we have cmsg feature to tur=
n it on/
> > >     off per sendmsg. A standalone tskey for bpf extension will be nee=
ded.
> > >     With this tskey_bpf, we can easily correlate the timestamp in sen=
dmsg
> > >     syscall with other tx points(SND/SW/ACK...).
> > >
> > >     [1]: https://lore.kernel.org/all/20250112113748.73504-14-kernelja=
sonxing@gmail.com/
> > >
> > >     If possible, we can leave this question until the UDP support ser=
ies
> > >     shows up. I will figure out a better solution :)
> > >
> > > In conclusion, it probably won't be used by the UDP type. It's uAPI
> > > flag so I consider the compatibility reason.
> >
> > I don't think this is acceptable. We should aim for an API that can
> > easily be used across protocols, like SO_TIMESTAMPING.
>
> After I revisit the UDP SO_TIMESTAMPING again, my thoughts are
> adjusted like below:
>
> It's hard to provide an absolutely uniform interface or usage to users
> for TCP and UDP and even more protocols. Cases can be handled one by
> one. The main obstacle is how we can correlate the timestamp in
> sendmsg syscall with other sending timestamps. It's worth noticing
> that for SO_TIMESTAMPING the sendmsg timestamp is collected in the
> userspace. For instance, while skb enters the qdisc, we fail to know
> which skb belongs to which sendmsg.
>
> An idea coming up is to introduce BPF_SOCK_OPS_TS_SND_CB to correlate
> the sendmsg timestamp with tskey (in tcp_tx_timestamp()) under the
> protection of socket lock + syscall as the current patch does. But for
> UDP, it can be lockless. IIUC, there is a very special case where even
> SO_TIMESTAMPING may get lost: if multiple threads accessing the same
> socket send UDP packets in parallel, then users could be confused
> which tskey matches which sendmsg. IIUC, I will not consider this
> unlikely case, then the UDP case is quite similar to the TCP case.
>
> The scenario for the UDP case is:
> 1) using fentry bpf to hook the udp_sendmsg() to get the timestamp
> like TCP does in this series.
> 2) insert BPF_SOCK_OPS_TS_SND_CB into __ip_append_data() near the
> SO_TIMESTAMPING code snippets to let bpf program correlate the tskey
> with timestamp.
> Note: tskey in UDP will be handled carefully in a different way
> because we should support both modes for socket timestamping at the
> same time.
> It's really similar to TCP regardless of handling tskey.
>

To be more precise in case you don't have much time to read the above
long paragraph, BPF_SOCK_OPS_TS_SND_CB is mainly used to correlate
sendmsg timestamp with corresponding tskey.

1. For TCP, we can correlate it in tcp_tx_timestamp() like this patch does.

2. For UDP, we can correlate in __ip_append_data() along with those
tskey initialization, assuming there are no multiple threads calling
locklessly ip_make_skb(). Locked path
(udp_sendmsg()->ip_append_data()) works like TCP under the socket lock
protection, so it can be easily handled. Lockless path
(udp_sendmsg()->ip_make_skb()) can be visited by multiple threads at
the same time, which should be handled properly. I prefer to implement
the bpf extension for IPCORK_TS_OPT_ID, which should be another topic,
I think. This might be the only one corner case, IIUC?

Overall I think BPF_SOCK_OPS_TS_SND_CB can work across protocols to do
the correlation job.

To be on the safe side, I can change the name BPF_SOCK_OPS_TS_SND_CB
to BPF_SOCK_OPS_TS_TCP_SND_CB just in case this approach is not the
best one. What do you think about this?

[1]
commit 4aecca4c76808f3736056d18ff510df80424bc9f
Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Date:   Tue Oct 1 05:57:14 2024 -0700

    net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message

    SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
    timestamps and packets sent via socket. Unfortunately, there is no way
    to reliably predict socket timestamp ID value in case of error returned
    by sendmsg. For UDP sockets it's impossible because of lockless
    nature of UDP transmit, several threads may send packets in parallel. I=
n
    case of RAW sockets MSG_MORE option makes things complicated. More
    details are in the conversation [1].
    This patch adds new control message type to give user-space
    software an opportunity to control the mapping between packets and
    values by providing ID with each sendmsg for UDP sockets.
    The documentation is also added in this patch.

    [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_=
B9Eaa9aDPfgHdtA@mail.gmail.com/

Thanks,
Jason

