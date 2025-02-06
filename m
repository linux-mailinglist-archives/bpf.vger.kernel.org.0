Return-Path: <bpf+bounces-50576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F1A29DE5
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C511888E1E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D08C8E0;
	Thu,  6 Feb 2025 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4Ok49Qx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EFC28366;
	Thu,  6 Feb 2025 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802070; cv=none; b=quWk4JPABxx7UPrVbJCjqC7plmlMfwMp3crsl/1dabbnEJ8nlvp6mfRZeXWtzrATj1wunL2xqCO7Zmlzg59zBZTqlMM0iHWUJtMiP4QAgWPYhDEgxvB8iHXUrvqeeGtqgjsnbT0Syt+GV29Wzlxf4YqJGReFFaWL7mkS0LJeSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802070; c=relaxed/simple;
	bh=E+uxlyJPeO1acBfWGC6B7sMwjn24VTp7X1GYaMoFogw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljwFF1hVq0vDKgqAXv8k+82N2X/Eyi+At4puacA97xf46+yBHeccmEoaUi85MVXlk23Yt9KRttEK6wg8GQoKE/hFNfKuoxlAAx22V+44eooEcMayc9p5rfhM+D55289Ro0vGh3RMKq7+SWZsDLebdKPE44w++HmY5B/F1Kr+DNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4Ok49Qx; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844e61f3902so30897139f.0;
        Wed, 05 Feb 2025 16:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738802067; x=1739406867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNe4WHKF9kuKq7UqfQwwDZlTYjaqkudSbb+q19vJZDo=;
        b=c4Ok49Qxqc1EsB/f1sP8RCJY7mvreoA+MJfPGNXiGgoAPjaj3whLU4hHxGP8AHxtDr
         uZ+NHDOPLkh2BhKKpODaxLwEcI8WKeCq5u1Z6BprDGoLpT3IvgWHhy4K2PRX/KTOH9dy
         IfE2pyQmgX74w6oIL0oe3jlIuaDxJDGLZDj80AerqTHwwjRSPTfD2NsxgYDsnS1p9Nv+
         74uajnVngU5ZvnPDxGHzHgedcBOIlub4A5LXU97uS8OCkQ8ObkVsOPfrsfI8ftRpUzEi
         CLHTZGQCC8K1bc+uOklxbqypaBWAF8uw/RUJ7S1MbtleBzfVVJnXoGOhBEDqh5kz+PmW
         7GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738802067; x=1739406867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNe4WHKF9kuKq7UqfQwwDZlTYjaqkudSbb+q19vJZDo=;
        b=aelj9dzljsVxVbi2Dg3bWk9AhGH8CZg3xePMBcPv4RyZXYj4cr39SBBEgLWUVh3rBi
         +jOmAx2uMtZ29EgUR6NRaQOuCfB4qNh6dEvz4ss0eHhcvIkatf1AR2PN2tj7pqQgX3VL
         z8BwZqAXiVewiI1Lzh/Or4DQMevXcov+H6V4sgDkG2tTpwEOsb85YD4MQwCDjiz/AuX8
         vXcwQzdmgXire2yX+OxrWFcTk3CFRJDL4PKGRP96CTFFbvv7IQG/Q496hI56n8uvUfZf
         Pyv+C9yDtOhnu+B7vhXQgVL5DD9MEdJcztk7w8RAYgJLrmbd0e4E1W0cTQ+uYwvWUqZH
         uXtg==
X-Forwarded-Encrypted: i=1; AJvYcCUdA9TUvufAUJxiSPaB67G+sA7qxssUlVjWOmG5uRcHp5vNxHRog/t0zJJ4ah8jAxGMCaE=@vger.kernel.org, AJvYcCVP1ZC7yailyaHIo5maoqslRaNg+3qtfzcf0VO+linBbJi5UVR+eEcMbRHv5GSQwIegUFtGzKas@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSv45h69RzkSzJNtWFHKc3gfdRQC84BYSK+SfYV2AU2O4NRvh
	f08wl7QU5zxgRNntqH4m3/8PbP03r/2DkRMrJGB+SbJpD3rTbMR0+OeF6Q9byLTd5r0lLG7X+j3
	soNoHuXWv487MAXM9+jq0SUXQklQ=
X-Gm-Gg: ASbGncv7Oq7+rQlr2NeLnj6iXd8Vd8nR05r816Ng7IHnynK2r/xMZFzqWFv/uj6/cG3
	rTF/xFlgj35VlW3+sPtLKGV+9+yzoTJATxkMnK7ZYGs2XPc7HYUwc10n0NhoqZxCdsY3fhD4=
X-Google-Smtp-Source: AGHT+IGqSMmqT8WbKq5FsyJmF3tUxnUHQ/F2W8ysiy8LP9sGdw8I6Mfz4Z0wGrwwLAoYxMZVN4/NrKmUwTBYf+MNMnc=
X-Received: by 2002:a05:6e02:1ca3:b0:3cf:b626:66c2 with SMTP id
 e9e14a558f8ab-3d04f97b1b0mr50145575ab.19.1738802067122; Wed, 05 Feb 2025
 16:34:27 -0800 (PST)
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
 <CAL+tcoAeBJ=F8cZ9qYwGF6jmc+DwA2byrrzAZjcpNYzrjT541g@mail.gmail.com>
 <67a381a6bef0b_14e08329474@willemb.c.googlers.com.notmuch>
 <CAL+tcoC4E3zn4gB6PC_Kj5jTShNiounu8vjsZbfDCAOn2fNqXw@mail.gmail.com> <67a3d1dba6803_170d392948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a3d1dba6803_170d392948c@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 08:33:51 +0800
X-Gm-Features: AWEUYZkKcfauhM6AHiDAmnd86MWg9f1mg71cfJPE3Ybu2TNlqgBdyg2KKeEGJfc
Message-ID: <CAL+tcoBuQYsbfGuL0PUGdvy7UHGKii3rXv8q+GjzbHvK3hKsQw@mail.gmail.com>
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

On Thu, Feb 6, 2025 at 5:02=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Feb 5, 2025 at 11:20=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Wed, Feb 5, 2025 at 2:09=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 5, 2025 at 1:08=E2=80=AFAM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jason Xing wrote:
> > > > > > > On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <mart=
in.lau@linux.dev> wrote:
> > > > > > > >
> > > > > > > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > > > > > > Introduce the callback to correlate tcp_sendmsg timestamp=
 with other
> > > > > > > > > points, like SND/SW/ACK. We can let bpf trace the beginni=
ng of
> > > > > > > > > tcp_sendmsg_locked() and fetch the socket addr, so that i=
n
> > > > > > > >
> > > > > > > > Instead of "fetch the socket addr...", should be "store the=
 sendmsg timestamp at
> > > > > > > > the bpf_sk_storage ...".
> > > > > > >
> > > > > > > I will revise it. Thanks.
> > > > > > >
> > > > > > > >
> > > > > > > > > tcp_tx_timestamp() we can correlate the tskey with the so=
cket addr.
> > > > > > > >
> > > > > > > >
> > > > > > > > > It is accurate since they are under the protect of socket=
 lock.
> > > > > > > > > More details can be found in the selftest.
> > > > > > > >
> > > > > > > > The selftest uses the bpf_sk_storage to store the sendmsg t=
imestamp at
> > > > > > > > fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_t=
imestamp (i.e.
> > > > > > > > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > > > > ---
> > > > > > > > >   include/uapi/linux/bpf.h       | 7 +++++++
> > > > > > > > >   net/ipv4/tcp.c                 | 1 +
> > > > > > > > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > > > > > > > >   3 files changed, 15 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linu=
x/bpf.h
> > > > > > > > > index 800122a8abe5..accb3b314fff 100644
> > > > > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > > > > @@ -7052,6 +7052,13 @@ enum {
> > > > > > > > >                                        * when SK_BPF_CB_T=
X_TIMESTAMPING
> > > > > > > > >                                        * feature is on.
> > > > > > > > >                                        */
> > > > > > > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when ever=
y sendmsg syscall
> > > > > > > > > +                                      * is triggered. Fo=
r TCP, it stays
> > > > > > > > > +                                      * in the last send=
 process to
> > > > > > > > > +                                      * correlate with t=
cp_sendmsg timestamp
> > > > > > > > > +                                      * with other times=
tamping callbacks,
> > > > > > > > > +                                      * like SND/SW/ACK.
> > > > > > > >
> > > > > > > > Do you have a chance to look at how this will work at UDP?
> > > > > > >
> > > > > > > Sure, I feel like it could not be useful for UDP. Well, thing=
s get
> > > > > > > strange because I did write a long paragraph about this thing=
 which
> > > > > > > apparently disappeared...
> > > > > > >
> > > > > > > I manage to find what I wrote:
> > > > > > >     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suitable =
because
> > > > > > >     there are two sending process, 1) lockless path, 2) lock =
path, which
> > > > > > >     should be handled carefully later. For the former, even t=
hough it's
> > > > > > >     unlikely multiple threads access the socket to call sendm=
sg at the
> > > > > > >     same time, I think we'd better not correlate it like what=
 we do to the
> > > > > > >     TCP case because of the lack of sock lock protection. Con=
sidering SND_CB is
> > > > > > >     uapi flag, I think we don't need to forcely add the 'TCP_=
' prefix in
> > > > > > >     case we need to use it someday.
> > > > > > >
> > > > > > >     And one more thing is I'd like to use the v5[1] method in=
 the next round
> > > > > > >     to introduce a new tskey_bpf which is good for UDP type. =
The new field
> > > > > > >     will not conflict with the tskey in shared info which is =
generated
> > > > > > >     by sk->sk_tskey in __ip_append_data(). It hardly works if=
 both features
> > > > > > >     (so_timestamping and its bpf extension) exists at the sam=
e time. Users
> > > > > > >     could get confused because sometimes they fetch the tskey=
 from skb,
> > > > > > >     sometimes they don't, especially when we have cmsg featur=
e to turn it on/
> > > > > > >     off per sendmsg. A standalone tskey for bpf extension wil=
l be needed.
> > > > > > >     With this tskey_bpf, we can easily correlate the timestam=
p in sendmsg
> > > > > > >     syscall with other tx points(SND/SW/ACK...).
> > > > > > >
> > > > > > >     [1]: https://lore.kernel.org/all/20250112113748.73504-14-=
kerneljasonxing@gmail.com/
> > > > > > >
> > > > > > >     If possible, we can leave this question until the UDP sup=
port series
> > > > > > >     shows up. I will figure out a better solution :)
> > > > > > >
> > > > > > > In conclusion, it probably won't be used by the UDP type. It'=
s uAPI
> > > > > > > flag so I consider the compatibility reason.
> > > > > >
> > > > > > I don't think this is acceptable. We should aim for an API that=
 can
> > > > > > easily be used across protocols, like SO_TIMESTAMPING.
> > > > >
> > > > > After I revisit the UDP SO_TIMESTAMPING again, my thoughts are
> > > > > adjusted like below:
> > > > >
> > > > > It's hard to provide an absolutely uniform interface or usage to =
users
> > > > > for TCP and UDP and even more protocols. Cases can be handled one=
 by
> > > > > one.
> > >
> > > We should try hard. SO_TIMESTAMPING is uniform across protocols.
> > > An interface that is not is just hard to use.
> > >
> > > > > The main obstacle is how we can correlate the timestamp in
> > > > > sendmsg syscall with other sending timestamps. It's worth noticin=
g
> > > > > that for SO_TIMESTAMPING the sendmsg timestamp is collected in th=
e
> > > > > userspace. For instance, while skb enters the qdisc, we fail to k=
now
> > > > > which skb belongs to which sendmsg.
> > > > >
> > > > > An idea coming up is to introduce BPF_SOCK_OPS_TS_SND_CB to corre=
late
> > > > > the sendmsg timestamp with tskey (in tcp_tx_timestamp()) under th=
e
> > > > > protection of socket lock + syscall as the current patch does. Bu=
t for
> > > > > UDP, it can be lockless. IIUC, there is a very special case where=
 even
> > > > > SO_TIMESTAMPING may get lost: if multiple threads accessing the s=
ame
> > > > > socket send UDP packets in parallel, then users could be confused
> > > > > which tskey matches which sendmsg.
> > >
> > > This is a known issue for lockless datagram sockets.
> > >
> > > With SO_TIMESTAMPING, but the use of timestamping and of concurrent
> > > sendmsg calls is under control of the process, so it only shoots
> > > itself in the foot.
> > >
> > > With BPF timestamping, a process may confuse a third party admin, so
> > > the situation is slightly different.
> >
> > Agreed.
> >
> > >
> > > > > IIUC, I will not consider this
> > > > > unlikely case, then the UDP case is quite similar to the TCP case=
.
> > > > >
> > > > > The scenario for the UDP case is:
> > > > > 1) using fentry bpf to hook the udp_sendmsg() to get the timestam=
p
> > > > > like TCP does in this series.
> > > > > 2) insert BPF_SOCK_OPS_TS_SND_CB into __ip_append_data() near the
> > > > > SO_TIMESTAMPING code snippets to let bpf program correlate the ts=
key
> > > > > with timestamp.
> > > > > Note: tskey in UDP will be handled carefully in a different way
> > > > > because we should support both modes for socket timestamping at t=
he
> > > > > same time.
> > > > > It's really similar to TCP regardless of handling tskey.
> > > > >
> > > >
> > > > To be more precise in case you don't have much time to read the abo=
ve
> > > > long paragraph, BPF_SOCK_OPS_TS_SND_CB is mainly used to correlate
> > > > sendmsg timestamp with corresponding tskey.
> > > >
> > > > 1. For TCP, we can correlate it in tcp_tx_timestamp() like this pat=
ch does.
> > > >
> > > > 2. For UDP, we can correlate in __ip_append_data() along with those
> > > > tskey initialization, assuming there are no multiple threads callin=
g
> > > > locklessly ip_make_skb(). Locked path
> > > > (udp_sendmsg()->ip_append_data()) works like TCP under the socket l=
ock
> > > > protection, so it can be easily handled. Lockless path
> > > > (udp_sendmsg()->ip_make_skb()) can be visited by multiple threads a=
t
> > > > the same time, which should be handled properly.
> > >
> > > Different hook points is fine, as UDP (and RAW) uses __ip_append_data
> >
> > Then this approach (introducing this new flag) is feasible. Sorry that
> > last night I wrote such a long paragraph which buried something
> > important. Because of that, I rephrase the whole idea about how to let
> > UDP work with this kind of new flag in [patch v8 11/12]. Link is
> > https://lore.kernel.org/all/CAL+tcoCmXcDot-855XYU7PKCiGvJL=3DO3CQBGuOTR=
As2_=3DYs=3Dgg@mail.gmail.com/
> >
> > > or more importantly ip_send_skb, while TCP uses ip_queue_xmit.
> >
> > For TCP, we use tcp_tx_timestamp to finish the map between sendmsg
> > timestamp and tskey.
> >
> > >
> > > As long as the API is the same: the operation (BPF_SOCK_OPS_TS_SND_CB=
)
> > > and the behavior of that operation. Subject to the usual distinction
> > > between protocol behavior (bytestream vs datagram).
> >
> > I see your point.
> >
> > >
> > > > I prefer to implement
> > > > the bpf extension for IPCORK_TS_OPT_ID, which should be another top=
ic,
> > > > I think. This might be the only one corner case, IIUC?
> > >
> > > This sounds like an entirely different topic? Not sure what this is.
> >
> > Not really a different topic. I mean let bpf prog take the whole
> > control of setting the tskey, then with this BPF_SOCK_OPS_TS_SND_CB
> > flag we can correlate the sendmsg timestamp with tskey. So It has
> > something to do with the usage of UDP. Please take a look at that link
> > to patch 11/12. For TCP, we don't need to care about the value of
> > tskey which has already been taken care of by SO_TIMESTAMPING. So it
> > is slightly different. I'm not sure if this kind of usage is
> > acceptable?
>
> Why can TCP rely on SO_TIMESTAMPING to set tskey, but UDP cannot?

Because for TCP the shared info tskey is calculated by seqno (in
tcp_tx_timestamp()), so it works for so_timestamping and its bpf
extension and they are the same. However, for UDP, the shared info
tskey can be different, depending on when to call __ip_append_data()
and what the sk->sk_tskey is. It can cause conflicts when two modes
work at the same time. More than that, lockless UDP case is a tough
one since we cannot correlate the sendmsg timestamp in udp_sendmsg()
with the tskey generated in __ip_append_data(), which is a long gap
without any lock. So reuse the IPCORK_TS_OPT_ID logic for bpf
extension here can work.

It's worth to highlight that 1) for TCP the time to generate a sendmsg
timestamp and generate a tskey are under the same lock, 2) for
non-lockless UDP, it works like TCP. But in order to deal with the
lockless part, I choose to implement the IPCORK_TS_OPT_ID idea. This
is somehow another topic, but the relevant part is that I tried to
prove BPF_SOCK_OPS_TS_SND_CB can be also used in UDP (but in a
different position compared to TCP protocol).

>
> BPF will need to set the key for both protocol if SO_TIMESTAMPING is
> not enabled, right?

For TCP, we will rely on 'shinfo->tskey =3D TCP_SKB_CB(skb)->seq +
skb->len - 1;' in tcp_tx_timestamp() regardless of the status of
SO_TIMESTAMPING, so don't bother to manage the tskey from bpf prog.
While for UDP, we have to manage the tskey. Of course, it's another
topic.

Thanks,
Jason

