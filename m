Return-Path: <bpf+bounces-50512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F331DA294D0
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A333B2FA5
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531618D649;
	Wed,  5 Feb 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWX5SCEm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD087189905;
	Wed,  5 Feb 2025 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768811; cv=none; b=T79LCBBaOfgV7fpsOaTCvpEmmRE0tRPPfC+Kkt1f9qt6+lwvgOiocaC44bJzPlc3fh9DbKH9M3l8WElTeIoQFNdSS6ZXGNx4f2JBx/B2y/517SnkUd6YQaC72lI8ZkQOdep/ByqRA6Sgoejj8/M1RVqE5TdomS42r/wZa/dbqW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768811; c=relaxed/simple;
	bh=oHWWE5QnUmmAfgvtkxwGj+c/hs7McXrWahmntz3jFfc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uO4i7A38+WmtqjMV9QalV4ra3vsJcqHlsHI0OqWBN92Eh+HEcQ0Jkea9txWa6puGWyUs1zQtmJQovW8XFXeOnj03WFbC2mWbN7d0UWcPutkIGqb/h7btDzXv9/QSec/XNN1JhcHLmsjm7Cr4PNKkOFtS1rWbnzbpDByNhEJVDUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWX5SCEm; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5174d53437eso4134369e0c.2;
        Wed, 05 Feb 2025 07:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738768808; x=1739373608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKlVyiDG+pQ8W35WsnE24vXzkFHQZjjzY5ga/WBayCQ=;
        b=FWX5SCEmtGLSYvVdzWwF3LCTUFleHG7TCIUtm76kEbxH/7yAUcU/Lqug/Tzs4ji5Vu
         4XCeYPRoeKq7BV5zGJo2DiI9x5w5GeVz91Lhcd0EQfY1L3zjfmox55dHTH/hZ+1NrLTX
         s/FJaqM4L6bMHdrXtX8EDmenlzpb5Qlb4qZ9A7hQK5ohTxcr2qh1Z62FrRAo5x9nAiLf
         O7e8BIITxQNbcMYRKvDlZg0k0igd63LfShe00TAO3txhfjqgVMNSmjlbKodt7EEbGWvs
         4S5rsmaMcT6+k4b87CMYa90NAJKB+iRgy5+IyxLNrL7LQdzQQyuH92a1aeBmmKvYjeUT
         0h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738768808; x=1739373608;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iKlVyiDG+pQ8W35WsnE24vXzkFHQZjjzY5ga/WBayCQ=;
        b=MBaF1gqNfUyG5LEqz7IvSpWeEPfTc3cw/9YlTHBxThBQ+ICyYdvGkYjHWfoo6mSgl4
         nYeRXy4RCtJHiDTQF5j3Op0/BpGA5NOLz2BgoauoUL85s+xSe8RdmUNr76YHrMJobWU/
         TlMs61s7oJSkl+OFcXsNVNMvtNzKQCiFjkMay61lCa2cwQI+lq6jo6oGksoDBD77PQM5
         1DGsZizRW3aGziKGk5SMX/GPNW74C41VaQ2YlJ9mXxxtIPftos3TMjXuGSKDzmWbByQG
         m9iOW2iEPXJXx1EKH0WLIXcX2snq/Ty5lenpKmiaZVds+pLU3MGv6aDfLMceoFikHS9H
         yGRA==
X-Forwarded-Encrypted: i=1; AJvYcCWDLSgpz2vYSvoqt/nYUN4bfUYEXokTP456dZBf0yL+tgMa6a+LQUn7lVCo7barq1HGJgunoiXQ@vger.kernel.org, AJvYcCXc/XlteyxtZD0oWVZTUMUCG0uFdhPZUXSc+Tmcpt3km/3ymMDh1kHhtU9+D3qetLTx9L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4dtuR+VXn5Qz6FSAghqP9PKaAtsieXgygB9KpA+6c0TlAXQJG
	Q4tWUu8buiBkh2AbGlTNn7itGTFxvlJ/f4ineC4bbt9BEy3P0cF9
X-Gm-Gg: ASbGnctt3D5L+mpwSyomjinMoiXCpXUUAJGY0WpULKsst56L7cia4au2g1uObMjwkKz
	nfdmoVdYqfbmRi+sdjqNhDxG9Nq4TereBlvw6nEw0zASP8RZoddXzaamQtbsfDi2NkIZMEAsu54
	AxPjDTTIJSDSES0agRvekiGxere6T53ubBJBq8GHCDAw7qt7GpyD9gOdDozbs2VfIcQjKG9UmCD
	6E3dIoSOQKrbWrTdkYHrD6EdTFmgA/L3q5GVWnFLE9aNUHajVhnTSQY1hC1kmG/g8pjOBCl92tb
	DeNCu1BeMigVFvwZKq541s0ZxR4HK1duANosla18Tij9PRWAYgR/g9Oz5pqGS9g=
X-Google-Smtp-Source: AGHT+IEHd/tIGQrFOj0rnt56xaQ5a4w5PJvkQWIAozyuogHsw6+z4cYcv3Y/Shz6zbjEykDaTdafBw==
X-Received: by 2002:a05:6122:1906:b0:518:89d9:dd99 with SMTP id 71dfb90a1353d-51f0c38405emr2201897e0c.3.1738768808128;
        Wed, 05 Feb 2025 07:20:08 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1be84f7sm1837214e0c.8.2025.02.05.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:20:07 -0800 (PST)
Date: Wed, 05 Feb 2025 10:20:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67a381a6bef0b_14e08329474@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAeBJ=F8cZ9qYwGF6jmc+DwA2byrrzAZjcpNYzrjT541g@mail.gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-12-kerneljasonxing@gmail.com>
 <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
 <CAL+tcoDZXc56BsO9tYvb1EFDdMHhv3OcBsPwY3ctJ85rvb+OHA@mail.gmail.com>
 <67a24989d7202_bb56629425@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Efzxg9c-CBn3S0JEQZLUHBaCA+dL=mgWbVh26SukgA@mail.gmail.com>
 <CAL+tcoAeBJ=F8cZ9qYwGF6jmc+DwA2byrrzAZjcpNYzrjT541g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 11/13] net-timestamp: add a new callback in
 tcp_tx_timestamp()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Feb 5, 2025 at 2:09=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Wed, Feb 5, 2025 at 1:08=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <martin.l=
au@linux.dev> wrote:
> > > > >
> > > > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > > > Introduce the callback to correlate tcp_sendmsg timestamp wit=
h other
> > > > > > points, like SND/SW/ACK. We can let bpf trace the beginning o=
f
> > > > > > tcp_sendmsg_locked() and fetch the socket addr, so that in
> > > > >
> > > > > Instead of "fetch the socket addr...", should be "store the sen=
dmsg timestamp at
> > > > > the bpf_sk_storage ...".
> > > >
> > > > I will revise it. Thanks.
> > > >
> > > > >
> > > > > > tcp_tx_timestamp() we can correlate the tskey with the socket=
 addr.
> > > > >
> > > > >
> > > > > > It is accurate since they are under the protect of socket loc=
k.
> > > > > > More details can be found in the selftest.
> > > > >
> > > > > The selftest uses the bpf_sk_storage to store the sendmsg times=
tamp at
> > > > > fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_times=
tamp (i.e.
> > > > > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> > > > >
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > ---
> > > > > >   include/uapi/linux/bpf.h       | 7 +++++++
> > > > > >   net/ipv4/tcp.c                 | 1 +
> > > > > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > > > > >   3 files changed, 15 insertions(+)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bp=
f.h
> > > > > > index 800122a8abe5..accb3b314fff 100644
> > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > @@ -7052,6 +7052,13 @@ enum {
> > > > > >                                        * when SK_BPF_CB_TX_TI=
MESTAMPING
> > > > > >                                        * feature is on.
> > > > > >                                        */
> > > > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every se=
ndmsg syscall
> > > > > > +                                      * is triggered. For TC=
P, it stays
> > > > > > +                                      * in the last send pro=
cess to
> > > > > > +                                      * correlate with tcp_s=
endmsg timestamp
> > > > > > +                                      * with other timestamp=
ing callbacks,
> > > > > > +                                      * like SND/SW/ACK.
> > > > >
> > > > > Do you have a chance to look at how this will work at UDP?
> > > >
> > > > Sure, I feel like it could not be useful for UDP. Well, things ge=
t
> > > > strange because I did write a long paragraph about this thing whi=
ch
> > > > apparently disappeared...
> > > >
> > > > I manage to find what I wrote:
> > > >     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suitable beca=
use
> > > >     there are two sending process, 1) lockless path, 2) lock path=
, which
> > > >     should be handled carefully later. For the former, even thoug=
h it's
> > > >     unlikely multiple threads access the socket to call sendmsg a=
t the
> > > >     same time, I think we'd better not correlate it like what we =
do to the
> > > >     TCP case because of the lack of sock lock protection. Conside=
ring SND_CB is
> > > >     uapi flag, I think we don't need to forcely add the 'TCP_' pr=
efix in
> > > >     case we need to use it someday.
> > > >
> > > >     And one more thing is I'd like to use the v5[1] method in the=
 next round
> > > >     to introduce a new tskey_bpf which is good for UDP type. The =
new field
> > > >     will not conflict with the tskey in shared info which is gene=
rated
> > > >     by sk->sk_tskey in __ip_append_data(). It hardly works if bot=
h features
> > > >     (so_timestamping and its bpf extension) exists at the same ti=
me. Users
> > > >     could get confused because sometimes they fetch the tskey fro=
m skb,
> > > >     sometimes they don't, especially when we have cmsg feature to=
 turn it on/
> > > >     off per sendmsg. A standalone tskey for bpf extension will be=
 needed.
> > > >     With this tskey_bpf, we can easily correlate the timestamp in=
 sendmsg
> > > >     syscall with other tx points(SND/SW/ACK...).
> > > >
> > > >     [1]: https://lore.kernel.org/all/20250112113748.73504-14-kern=
eljasonxing@gmail.com/
> > > >
> > > >     If possible, we can leave this question until the UDP support=
 series
> > > >     shows up. I will figure out a better solution :)
> > > >
> > > > In conclusion, it probably won't be used by the UDP type. It's uA=
PI
> > > > flag so I consider the compatibility reason.
> > >
> > > I don't think this is acceptable. We should aim for an API that can=

> > > easily be used across protocols, like SO_TIMESTAMPING.
> >
> > After I revisit the UDP SO_TIMESTAMPING again, my thoughts are
> > adjusted like below:
> >
> > It's hard to provide an absolutely uniform interface or usage to user=
s
> > for TCP and UDP and even more protocols. Cases can be handled one by
> > one. =


We should try hard. SO_TIMESTAMPING is uniform across protocols.
An interface that is not is just hard to use.

> > The main obstacle is how we can correlate the timestamp in
> > sendmsg syscall with other sending timestamps. It's worth noticing
> > that for SO_TIMESTAMPING the sendmsg timestamp is collected in the
> > userspace. For instance, while skb enters the qdisc, we fail to know
> > which skb belongs to which sendmsg.
> >
> > An idea coming up is to introduce BPF_SOCK_OPS_TS_SND_CB to correlate=

> > the sendmsg timestamp with tskey (in tcp_tx_timestamp()) under the
> > protection of socket lock + syscall as the current patch does. But fo=
r
> > UDP, it can be lockless. IIUC, there is a very special case where eve=
n
> > SO_TIMESTAMPING may get lost: if multiple threads accessing the same
> > socket send UDP packets in parallel, then users could be confused
> > which tskey matches which sendmsg.

This is a known issue for lockless datagram sockets.

With SO_TIMESTAMPING, but the use of timestamping and of concurrent
sendmsg calls is under control of the process, so it only shoots
itself in the foot.

With BPF timestamping, a process may confuse a third party admin, so
the situation is slightly different.

> > IIUC, I will not consider this
> > unlikely case, then the UDP case is quite similar to the TCP case.
> >
> > The scenario for the UDP case is:
> > 1) using fentry bpf to hook the udp_sendmsg() to get the timestamp
> > like TCP does in this series.
> > 2) insert BPF_SOCK_OPS_TS_SND_CB into __ip_append_data() near the
> > SO_TIMESTAMPING code snippets to let bpf program correlate the tskey
> > with timestamp.
> > Note: tskey in UDP will be handled carefully in a different way
> > because we should support both modes for socket timestamping at the
> > same time.
> > It's really similar to TCP regardless of handling tskey.
> >
> =

> To be more precise in case you don't have much time to read the above
> long paragraph, BPF_SOCK_OPS_TS_SND_CB is mainly used to correlate
> sendmsg timestamp with corresponding tskey.
> =

> 1. For TCP, we can correlate it in tcp_tx_timestamp() like this patch d=
oes.
> =

> 2. For UDP, we can correlate in __ip_append_data() along with those
> tskey initialization, assuming there are no multiple threads calling
> locklessly ip_make_skb(). Locked path
> (udp_sendmsg()->ip_append_data()) works like TCP under the socket lock
> protection, so it can be easily handled. Lockless path
> (udp_sendmsg()->ip_make_skb()) can be visited by multiple threads at
> the same time, which should be handled properly.

Different hook points is fine, as UDP (and RAW) uses __ip_append_data
or more importantly ip_send_skb, while TCP uses ip_queue_xmit.

As long as the API is the same: the operation (BPF_SOCK_OPS_TS_SND_CB)
and the behavior of that operation. Subject to the usual distinction
between protocol behavior (bytestream vs datagram).

> I prefer to implement
> the bpf extension for IPCORK_TS_OPT_ID, which should be another topic,
> I think. This might be the only one corner case, IIUC?

This sounds like an entirely different topic? Not sure what this is.

> Overall I think BPF_SOCK_OPS_TS_SND_CB can work across protocols to do
> the correlation job.
> =

> To be on the safe side, I can change the name BPF_SOCK_OPS_TS_SND_CB
> to BPF_SOCK_OPS_TS_TCP_SND_CB just in case this approach is not the
> best one. What do you think about this?
> =

> [1]
> commit 4aecca4c76808f3736056d18ff510df80424bc9f
> Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Date:   Tue Oct 1 05:57:14 2024 -0700
> =

>     net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
> =

>     SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate=
 TX
>     timestamps and packets sent via socket. Unfortunately, there is no =
way
>     to reliably predict socket timestamp ID value in case of error retu=
rned
>     by sendmsg. For UDP sockets it's impossible because of lockless
>     nature of UDP transmit, several threads may send packets in paralle=
l. In
>     case of RAW sockets MSG_MORE option makes things complicated. More
>     details are in the conversation [1].
>     This patch adds new control message type to give user-space
>     software an opportunity to control the mapping between packets and
>     values by providing ID with each sendmsg for UDP sockets.
>     The documentation is also added in this patch.
> =

>     [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr=
1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> =

> Thanks,
> Jason



