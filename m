Return-Path: <bpf+bounces-50597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28551A29F15
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 04:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9F81888E86
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E473615FD13;
	Thu,  6 Feb 2025 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjnOEVSP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334714A4DF;
	Thu,  6 Feb 2025 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810809; cv=none; b=QoLWUB6DXQR2ouYVhF0JSMWQxw+k4Yhaj9w1w/8dBreb7Hs5cP4IG7ge+hWcowuiNuiFPWSfXsIlczv/bsD0e9/2e3BQuPgstvjF6k4chJleFxzwNQoFih5nOPLaEzG10R4CDtLWQF9uxL58pzmyeHTJar7KIwC2mHAqBAemXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810809; c=relaxed/simple;
	bh=5OwKW/pRi3vx5eKpvVZIfX5IMV+MgPxR5Pc7JzbibME=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S68L7f0kbzOpWqdWmKdhIGRDhBOrpaiFOCuNalXNy6cQ2QGmrrsgIv+RzlXvTuy1VjkY778wggjz5M0FFme9Ccbj5IRzJoq7udQeARo636T5FPQlqqahC1I7MoJFgLLMZMBDtMd8v0QWu2WH9bnL48FRF8Lf/sOxvUD8qG92OSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjnOEVSP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e1b11859a7so3538396d6.1;
        Wed, 05 Feb 2025 19:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738810806; x=1739415606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OK26cAkjqHjr/GCZ5SFBaJA1n8+8mEwQhHfK+ROppXk=;
        b=jjnOEVSPUW7tAGuwXX21hZkT4ZJHNMqmuNGjh7dN0E+PrRUzWnysnHJyq3WRFus34P
         +ThVfZoliijbtKAWAlptwKMAUeeDbsgs8bVnRwVZ3TlzN4YPCP2YzEp1cKTls1+1zAF4
         4SEWu+0WOYaGZId1NmQmo4eFnOaFyA1buZYAi8+WUtoFIUzejXo7RVyzwnQ20IyWUX3+
         iZCnrlbNetjZIUzVb6VIKUg90NS1x3Bm6BCiO9zPFB8GUTzlrJ6Krwb1lB4Add0TksQ8
         xZuI7QaiWNeSPgUyuzBh9hjWCqWXnAsD45PMGq3OfUR2IZADiWSW7gdSTc35YB4g+NXh
         qwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738810806; x=1739415606;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OK26cAkjqHjr/GCZ5SFBaJA1n8+8mEwQhHfK+ROppXk=;
        b=ZbQ7i8IEHPFSwy8q2Gi2VewJ08leXn6xaXBr1uJR69Nn//7w+43LscVDJCrzd7WeB0
         OZipvjESkWgV3W2uGRZe/yEW5q4mmSx6/729lIi/QtHm0Sr0mV11a6CnDo/21gNQj6at
         SwVMbPjuzuW9vHclq8VGiX/EctDToRkEDePC4BRnhP3RkmEme/GsipcG0ZD+7M2xP4+l
         oy+TdNa9SU7FFOditt3q/7jaxQ4+SEudN2ja/sgHQit5CxXyb1t3Qr0fogjBySTj0B0T
         n5ttfU5TOelUTVgIPFgt3ds+9kl6HKNPcpsNSBvFFcEWbew1W7uxD3ditBJjrhqEce+e
         dLAA==
X-Forwarded-Encrypted: i=1; AJvYcCWY4MZIOYJTSL/FgUkTVyFMbksg4GUGUM0/ksiDDmwXiKmvnP4NnaasG6W2fC8piPxy+Qh3FfmJ@vger.kernel.org, AJvYcCX4Fl2wKpP4GUJpyAAzFK+7zhcSthtc7/6mTPmijF+phkTv87VJ82tMxBTECVKOT9NUZds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWYHXgV4hcxw+BxknuDo6z3TH+pP9ks+l9tNdujHqi7kxXHWy
	ve6D73JRU0fXwnnG3btKRXnWIFoN8RN2cWDCKq+6mTGr/FlLzXwT
X-Gm-Gg: ASbGncvPOST2WnGS60ZxNRExuTabEZx9IZt19bmzcikq6qIQkcD5AzKJE5SpO4XoBvV
	DvjkYCygEUE/hqkzYovnddOpHw7eXMeZaJCscByhDV0ge9usErcthZoSrMvqO8ndU6OhOnOBO4w
	6htd33Z2l82R3RaIV22sbk3i1QiCgLczXpnagTYQp9CulKTzgO3d3e/y+KHWmRdiVV3kYWXjP+d
	CSnKJyrINwG7oJlc6/eQdPCg+X3HvSyxUEs1P4V/a69+Y2JKyKbSTuV1AGypL5y9MnS2b2oyR7+
	6Flxr0XaF7XUy8lb1e29hLCS4bavYKcZKm6D3y652XbhKx7mcPYUkgEUTg+vsDY=
X-Google-Smtp-Source: AGHT+IGI9uLxobJKu/qMOzRD29ChYGlhj9H6LybqghnSTtcCZ/NsUayoRaBOFrG52TLwEDcZKSpHRg==
X-Received: by 2002:a05:6214:20c4:b0:6e2:55b5:91d1 with SMTP id 6a1803df08f44-6e42f91242fmr92836256d6.0.1738810805570;
        Wed, 05 Feb 2025 19:00:05 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43ba2c09bsm1737926d6.12.2025.02.05.19.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 19:00:04 -0800 (PST)
Date: Wed, 05 Feb 2025 22:00:04 -0500
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
Message-ID: <67a425b48c434_199430294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBuQYsbfGuL0PUGdvy7UHGKii3rXv8q+GjzbHvK3hKsQw@mail.gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-12-kerneljasonxing@gmail.com>
 <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
 <CAL+tcoDZXc56BsO9tYvb1EFDdMHhv3OcBsPwY3ctJ85rvb+OHA@mail.gmail.com>
 <67a24989d7202_bb56629425@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Efzxg9c-CBn3S0JEQZLUHBaCA+dL=mgWbVh26SukgA@mail.gmail.com>
 <CAL+tcoAeBJ=F8cZ9qYwGF6jmc+DwA2byrrzAZjcpNYzrjT541g@mail.gmail.com>
 <67a381a6bef0b_14e08329474@willemb.c.googlers.com.notmuch>
 <CAL+tcoC4E3zn4gB6PC_Kj5jTShNiounu8vjsZbfDCAOn2fNqXw@mail.gmail.com>
 <67a3d1dba6803_170d392948c@willemb.c.googlers.com.notmuch>
 <CAL+tcoBuQYsbfGuL0PUGdvy7UHGKii3rXv8q+GjzbHvK3hKsQw@mail.gmail.com>
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
> On Thu, Feb 6, 2025 at 5:02=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Wed, Feb 5, 2025 at 11:20=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > On Wed, Feb 5, 2025 at 2:09=E2=80=AFAM Jason Xing <kerneljasonx=
ing@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 5, 2025 at 1:08=E2=80=AFAM Willem de Bruijn
> > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > >
> > > > > > > Jason Xing wrote:
> > > > > > > > On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <=
martin.lau@linux.dev> wrote:
> > > > > > > > >
> > > > > > > > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > > > > > > > Introduce the callback to correlate tcp_sendmsg times=
tamp with other
> > > > > > > > > > points, like SND/SW/ACK. We can let bpf trace the beg=
inning of
> > > > > > > > > > tcp_sendmsg_locked() and fetch the socket addr, so th=
at in
> > > > > > > > >
> > > > > > > > > Instead of "fetch the socket addr...", should be "store=
 the sendmsg timestamp at
> > > > > > > > > the bpf_sk_storage ...".
> > > > > > > >
> > > > > > > > I will revise it. Thanks.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > tcp_tx_timestamp() we can correlate the tskey with th=
e socket addr.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > It is accurate since they are under the protect of so=
cket lock.
> > > > > > > > > > More details can be found in the selftest.
> > > > > > > > >
> > > > > > > > > The selftest uses the bpf_sk_storage to store the sendm=
sg timestamp at
> > > > > > > > > fentry/tcp_sendmsg_locked and retrieves it back at tcp_=
tx_timestamp (i.e.
> > > > > > > > > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>=

> > > > > > > > > > ---
> > > > > > > > > >   include/uapi/linux/bpf.h       | 7 +++++++
> > > > > > > > > >   net/ipv4/tcp.c                 | 1 +
> > > > > > > > > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > > > > > > > > >   3 files changed, 15 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/=
linux/bpf.h
> > > > > > > > > > index 800122a8abe5..accb3b314fff 100644
> > > > > > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > > > > > @@ -7052,6 +7052,13 @@ enum {
> > > > > > > > > >                                        * when SK_BPF_=
CB_TX_TIMESTAMPING
> > > > > > > > > >                                        * feature is o=
n.
> > > > > > > > > >                                        */
> > > > > > > > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when =
every sendmsg syscall
> > > > > > > > > > +                                      * is triggered=
. For TCP, it stays
> > > > > > > > > > +                                      * in the last =
send process to
> > > > > > > > > > +                                      * correlate wi=
th tcp_sendmsg timestamp
> > > > > > > > > > +                                      * with other t=
imestamping callbacks,
> > > > > > > > > > +                                      * like SND/SW/=
ACK.
> > > > > > > > >
> > > > > > > > > Do you have a chance to look at how this will work at U=
DP?
> > > > > > > >
> > > > > > > > Sure, I feel like it could not be useful for UDP. Well, t=
hings get
> > > > > > > > strange because I did write a long paragraph about this t=
hing which
> > > > > > > > apparently disappeared...
> > > > > > > >
> > > > > > > > I manage to find what I wrote:
> > > > > > > >     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suita=
ble because
> > > > > > > >     there are two sending process, 1) lockless path, 2) l=
ock path, which
> > > > > > > >     should be handled carefully later. For the former, ev=
en though it's
> > > > > > > >     unlikely multiple threads access the socket to call s=
endmsg at the
> > > > > > > >     same time, I think we'd better not correlate it like =
what we do to the
> > > > > > > >     TCP case because of the lack of sock lock protection.=
 Considering SND_CB is
> > > > > > > >     uapi flag, I think we don't need to forcely add the '=
TCP_' prefix in
> > > > > > > >     case we need to use it someday.
> > > > > > > >
> > > > > > > >     And one more thing is I'd like to use the v5[1] metho=
d in the next round
> > > > > > > >     to introduce a new tskey_bpf which is good for UDP ty=
pe. The new field
> > > > > > > >     will not conflict with the tskey in shared info which=
 is generated
> > > > > > > >     by sk->sk_tskey in __ip_append_data(). It hardly work=
s if both features
> > > > > > > >     (so_timestamping and its bpf extension) exists at the=
 same time. Users
> > > > > > > >     could get confused because sometimes they fetch the t=
skey from skb,
> > > > > > > >     sometimes they don't, especially when we have cmsg fe=
ature to turn it on/
> > > > > > > >     off per sendmsg. A standalone tskey for bpf extension=
 will be needed.
> > > > > > > >     With this tskey_bpf, we can easily correlate the time=
stamp in sendmsg
> > > > > > > >     syscall with other tx points(SND/SW/ACK...).
> > > > > > > >
> > > > > > > >     [1]: https://lore.kernel.org/all/20250112113748.73504=
-14-kerneljasonxing@gmail.com/
> > > > > > > >
> > > > > > > >     If possible, we can leave this question until the UDP=
 support series
> > > > > > > >     shows up. I will figure out a better solution :)
> > > > > > > >
> > > > > > > > In conclusion, it probably won't be used by the UDP type.=
 It's uAPI
> > > > > > > > flag so I consider the compatibility reason.
> > > > > > >
> > > > > > > I don't think this is acceptable. We should aim for an API =
that can
> > > > > > > easily be used across protocols, like SO_TIMESTAMPING.
> > > > > >
> > > > > > After I revisit the UDP SO_TIMESTAMPING again, my thoughts ar=
e
> > > > > > adjusted like below:
> > > > > >
> > > > > > It's hard to provide an absolutely uniform interface or usage=
 to users
> > > > > > for TCP and UDP and even more protocols. Cases can be handled=
 one by
> > > > > > one.
> > > >
> > > > We should try hard. SO_TIMESTAMPING is uniform across protocols.
> > > > An interface that is not is just hard to use.
> > > >
> > > > > > The main obstacle is how we can correlate the timestamp in
> > > > > > sendmsg syscall with other sending timestamps. It's worth not=
icing
> > > > > > that for SO_TIMESTAMPING the sendmsg timestamp is collected i=
n the
> > > > > > userspace. For instance, while skb enters the qdisc, we fail =
to know
> > > > > > which skb belongs to which sendmsg.
> > > > > >
> > > > > > An idea coming up is to introduce BPF_SOCK_OPS_TS_SND_CB to c=
orrelate
> > > > > > the sendmsg timestamp with tskey (in tcp_tx_timestamp()) unde=
r the
> > > > > > protection of socket lock + syscall as the current patch does=
. But for
> > > > > > UDP, it can be lockless. IIUC, there is a very special case w=
here even
> > > > > > SO_TIMESTAMPING may get lost: if multiple threads accessing t=
he same
> > > > > > socket send UDP packets in parallel, then users could be conf=
used
> > > > > > which tskey matches which sendmsg.
> > > >
> > > > This is a known issue for lockless datagram sockets.
> > > >
> > > > With SO_TIMESTAMPING, but the use of timestamping and of concurre=
nt
> > > > sendmsg calls is under control of the process, so it only shoots
> > > > itself in the foot.
> > > >
> > > > With BPF timestamping, a process may confuse a third party admin,=
 so
> > > > the situation is slightly different.
> > >
> > > Agreed.
> > >
> > > >
> > > > > > IIUC, I will not consider this
> > > > > > unlikely case, then the UDP case is quite similar to the TCP =
case.
> > > > > >
> > > > > > The scenario for the UDP case is:
> > > > > > 1) using fentry bpf to hook the udp_sendmsg() to get the time=
stamp
> > > > > > like TCP does in this series.
> > > > > > 2) insert BPF_SOCK_OPS_TS_SND_CB into __ip_append_data() near=
 the
> > > > > > SO_TIMESTAMPING code snippets to let bpf program correlate th=
e tskey
> > > > > > with timestamp.
> > > > > > Note: tskey in UDP will be handled carefully in a different w=
ay
> > > > > > because we should support both modes for socket timestamping =
at the
> > > > > > same time.
> > > > > > It's really similar to TCP regardless of handling tskey.
> > > > > >
> > > > >
> > > > > To be more precise in case you don't have much time to read the=
 above
> > > > > long paragraph, BPF_SOCK_OPS_TS_SND_CB is mainly used to correl=
ate
> > > > > sendmsg timestamp with corresponding tskey.
> > > > >
> > > > > 1. For TCP, we can correlate it in tcp_tx_timestamp() like this=
 patch does.
> > > > >
> > > > > 2. For UDP, we can correlate in __ip_append_data() along with t=
hose
> > > > > tskey initialization, assuming there are no multiple threads ca=
lling
> > > > > locklessly ip_make_skb(). Locked path
> > > > > (udp_sendmsg()->ip_append_data()) works like TCP under the sock=
et lock
> > > > > protection, so it can be easily handled. Lockless path
> > > > > (udp_sendmsg()->ip_make_skb()) can be visited by multiple threa=
ds at
> > > > > the same time, which should be handled properly.
> > > >
> > > > Different hook points is fine, as UDP (and RAW) uses __ip_append_=
data
> > >
> > > Then this approach (introducing this new flag) is feasible. Sorry t=
hat
> > > last night I wrote such a long paragraph which buried something
> > > important. Because of that, I rephrase the whole idea about how to =
let
> > > UDP work with this kind of new flag in [patch v8 11/12]. Link is
> > > https://lore.kernel.org/all/CAL+tcoCmXcDot-855XYU7PKCiGvJL=3DO3CQBG=
uOTRAs2_=3DYs=3Dgg@mail.gmail.com/
> > >
> > > > or more importantly ip_send_skb, while TCP uses ip_queue_xmit.
> > >
> > > For TCP, we use tcp_tx_timestamp to finish the map between sendmsg
> > > timestamp and tskey.
> > >
> > > >
> > > > As long as the API is the same: the operation (BPF_SOCK_OPS_TS_SN=
D_CB)
> > > > and the behavior of that operation. Subject to the usual distinct=
ion
> > > > between protocol behavior (bytestream vs datagram).
> > >
> > > I see your point.
> > >
> > > >
> > > > > I prefer to implement
> > > > > the bpf extension for IPCORK_TS_OPT_ID, which should be another=
 topic,
> > > > > I think. This might be the only one corner case, IIUC?
> > > >
> > > > This sounds like an entirely different topic? Not sure what this =
is.
> > >
> > > Not really a different topic. I mean let bpf prog take the whole
> > > control of setting the tskey, then with this BPF_SOCK_OPS_TS_SND_CB=

> > > flag we can correlate the sendmsg timestamp with tskey. So It has
> > > something to do with the usage of UDP. Please take a look at that l=
ink
> > > to patch 11/12. For TCP, we don't need to care about the value of
> > > tskey which has already been taken care of by SO_TIMESTAMPING. So i=
t
> > > is slightly different. I'm not sure if this kind of usage is
> > > acceptable?
> >
> > Why can TCP rely on SO_TIMESTAMPING to set tskey, but UDP cannot?
> =

> Because for TCP the shared info tskey is calculated by seqno (in
> tcp_tx_timestamp()), so it works for so_timestamping and its bpf
> extension and they are the same. However, for UDP, the shared info
> tskey can be different, depending on when to call __ip_append_data()
> and what the sk->sk_tskey is. It can cause conflicts when two modes
> work at the same time. =


lockless and locked cannot conflict. (if up->pending then the only
option is to append to that.)

> More than that, lockless UDP case is a tough
> one since we cannot correlate the sendmsg timestamp in udp_sendmsg()
> with the tskey generated in __ip_append_data(), =


With SO_TIMESTAMPING we do not have this distinction between TCP and
UDP, so we don't need it here.

It is true that multiple lockless sendmsg calls can race and in that
case that correlation is ambiguous. That is also the case for
SO_TIMESTAMPING and a known issue.

This is unlikely in most workloads in practice.

> which is a long gap
> without any lock. So reuse the IPCORK_TS_OPT_ID logic for bpf
> extension here can work.

It is fine to add a solution to work around the ambiguity. But not
to make it a precondition and so diverge the API for TCP and UDP.

The same argument to choose a key from BPF can be made for TCP to
a certain extent.

> It's worth to highlight that 1) for TCP the time to generate a sendmsg
> timestamp and generate a tskey are under the same lock, 2) for
> non-lockless UDP, it works like TCP. But in order to deal with the
> lockless part, I choose to implement the IPCORK_TS_OPT_ID idea. This
> is somehow another topic, but the relevant part is that I tried to
> prove BPF_SOCK_OPS_TS_SND_CB can be also used in UDP (but in a
> different position compared to TCP protocol).
> =

> >
> > BPF will need to set the key for both protocol if SO_TIMESTAMPING is
> > not enabled, right?
> =

> For TCP, we will rely on 'shinfo->tskey =3D TCP_SKB_CB(skb)->seq +
> skb->len - 1;' in tcp_tx_timestamp() regardless of the status of
> SO_TIMESTAMPING, so don't bother to manage the tskey from bpf prog.
> While for UDP, we have to manage the tskey. Of course, it's another
> topic.
> =

> Thanks,
> Jason



