Return-Path: <bpf+bounces-50564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51FA29B92
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 22:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9CF18853D1
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 21:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774B2214A6D;
	Wed,  5 Feb 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI5/mNIv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C411DAC81;
	Wed,  5 Feb 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789345; cv=none; b=N9mov9Ih+wWLXedU7ctCNkUXv6O64K6xPzOoYBm7oUHwf7NUohVhdrJdOuGczYAf00Z2M1cx2oWv3cZ1SAsUD4PCrwzhNbiqUzIUziZtF6vFUpNWnR5FWyspzS1b2aY4cC21I1zBdVawiPa0HzIMz/fd0yl1E8L2shAnN00Q2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789345; c=relaxed/simple;
	bh=KMsFijwYbo4VqKigoNROtU/DPdJOYGtLZ4jcjeqAWYc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G5E0DsUHcSTV/5Aw5gJ723K7ZsMJdL79rmbJP1/wcb+PB8IGjo/x4zxynl0bVVASrCftYdImiATC/Xy47hVBFD34pHmwMC7YX1KwSHrC31vEOeJn8it7SOTFufmVNNpgf0pnJ9G7B6DypiBxKRMfaEVdE8tm+bx/ReL7k0/k6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI5/mNIv; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4ba74d1d4a9so20691137.1;
        Wed, 05 Feb 2025 13:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738789342; x=1739394142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLo6yyv17ItF+7v8MCtqCyO0qmPNARVyeU1KW74AAgs=;
        b=bI5/mNIvSU2rRCNlr73KTq5JItqLMzz591wlJ09wpJn+pA3vxeRMp3IQKCAvH/16Ex
         pq0+V/2TIWJWHRObX9Q41Wl8hAn8m/QQgGu1SHBsiBVk1MQP45ypWVKjux/UfQzvEtHE
         iizwocs5cHgLVPEWvwmT8yTFadiK8UceQ2GhJcU22oOx/+NuZ3QkU4BHawD2UfA97m/5
         wmukBQ+aXemqi2W+zNB4XZkfnOjaY5tNvyB9gCm5IV+FmUywOOCWdVPmGoULlha/F4H3
         z8zPpm2QaC6CgImKtpfEX1XQMIsANIlRckCdPGO0VSqjCHSNk1bFOgHSIV5rO4ilZJ5W
         VRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738789342; x=1739394142;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLo6yyv17ItF+7v8MCtqCyO0qmPNARVyeU1KW74AAgs=;
        b=iZW3X7XW+As7meHOlpX56divn+CHT7nRObanKCDelm8UhgjtlPYz3D56u/8/G+nB5/
         Rc5ewOz9tJ0511aGe/yltxJQt1LcVHAGL1skAOG3lHw+gzvjnMBoN1bpZPPaIEqJAZxj
         GruoZBwyV7adQSc/HwU7m066mhsqWDOOemQoZHb4s+WX4oNiWuyIOrCzgXqxIIaMSxPF
         7Suv5S6YE6I6uQsmxXVorF6estzWrgvP8VYvrtpPg7gA/6kNdYzxnR3daAudDOJSNv9k
         k24sBKdpU+xZAlRuqQ2BbKN8yGNnWinUmRnheggRQ/DA/4eW7WX+3BWBpd1f7tYV8HVx
         Erdg==
X-Forwarded-Encrypted: i=1; AJvYcCUSTTMTPessgUAIky0srXpLLmmFPCUeFPdDH3fmXKhLCckZ82BrRM4GiKOGVr2arxS175I=@vger.kernel.org, AJvYcCXwvkLGu5A/8mBIZSaFPaSVN1l9D2NDFYaAQ2c9SXh2t9xVFelXDZbULllH8K1lmmM8oYrINE8X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8oscFw9R//LOacIXi0a2uB8Uivv+T9YBLOxnIIUayiT0Oix8Z
	OU1/Aipj99yy62IqfXjFtnq5KZLACGdiWl/2sx/bP7iM84O4CSON
X-Gm-Gg: ASbGncugAvJeH1hmwpW+mpckuOj+fgpIABaeMCga8KkpbOPSXQuM8ybY0V0oqr5cDQc
	pq1dUHJJ7rKum0LeWE27V5FN899ag8Snpr8lIoJO/EpX2rFmOFSla5Ex5wc9WKEtEbr7bqo4Ujp
	nCwkRSNYI1IznAjQVUGiqaVRXc7gqo6j4AYN1fhWARmv1fg23atcmXHl+yV0Wwhx4GUeHGGwrZW
	iQ3W6Ac7HcopPclK617A2Is6sQdsvDdOzmSFC9/sWgdEcifBmyfkAqVPQ1imCb8rGPCat4dtdMJ
	3Dy5sqj6aG2LsqAXXO0CadArW9jgN/4iLxrMdE53V2JW9atsOugmR617EL6IdIU=
X-Google-Smtp-Source: AGHT+IG8Ajxn+UyTfAOPeS7JkJtr/bYi/YncU0DBwtRCw3v/6Z8UO52WYmQ5u/pB2wxhT/GC7lrQgQ==
X-Received: by 2002:a05:6102:951:b0:4b2:5d63:ff72 with SMTP id ada2fe7eead31-4ba4791df1fmr3177200137.13.1738789341580;
        Wed, 05 Feb 2025 13:02:21 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866f274258dsm188533241.9.2025.02.05.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:02:20 -0800 (PST)
Date: Wed, 05 Feb 2025 16:02:19 -0500
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
Message-ID: <67a3d1dba6803_170d392948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC4E3zn4gB6PC_Kj5jTShNiounu8vjsZbfDCAOn2fNqXw@mail.gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-12-kerneljasonxing@gmail.com>
 <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
 <CAL+tcoDZXc56BsO9tYvb1EFDdMHhv3OcBsPwY3ctJ85rvb+OHA@mail.gmail.com>
 <67a24989d7202_bb56629425@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Efzxg9c-CBn3S0JEQZLUHBaCA+dL=mgWbVh26SukgA@mail.gmail.com>
 <CAL+tcoAeBJ=F8cZ9qYwGF6jmc+DwA2byrrzAZjcpNYzrjT541g@mail.gmail.com>
 <67a381a6bef0b_14e08329474@willemb.c.googlers.com.notmuch>
 <CAL+tcoC4E3zn4gB6PC_Kj5jTShNiounu8vjsZbfDCAOn2fNqXw@mail.gmail.com>
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
> On Wed, Feb 5, 2025 at 11:20=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Wed, Feb 5, 2025 at 2:09=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > On Wed, Feb 5, 2025 at 1:08=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <mart=
in.lau@linux.dev> wrote:
> > > > > > >
> > > > > > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > > > > > Introduce the callback to correlate tcp_sendmsg timestamp=
 with other
> > > > > > > > points, like SND/SW/ACK. We can let bpf trace the beginni=
ng of
> > > > > > > > tcp_sendmsg_locked() and fetch the socket addr, so that i=
n
> > > > > > >
> > > > > > > Instead of "fetch the socket addr...", should be "store the=
 sendmsg timestamp at
> > > > > > > the bpf_sk_storage ...".
> > > > > >
> > > > > > I will revise it. Thanks.
> > > > > >
> > > > > > >
> > > > > > > > tcp_tx_timestamp() we can correlate the tskey with the so=
cket addr.
> > > > > > >
> > > > > > >
> > > > > > > > It is accurate since they are under the protect of socket=
 lock.
> > > > > > > > More details can be found in the selftest.
> > > > > > >
> > > > > > > The selftest uses the bpf_sk_storage to store the sendmsg t=
imestamp at
> > > > > > > fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_t=
imestamp (i.e.
> > > > > > > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> > > > > > >
> > > > > > > >
> > > > > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > > > ---
> > > > > > > >   include/uapi/linux/bpf.h       | 7 +++++++
> > > > > > > >   net/ipv4/tcp.c                 | 1 +
> > > > > > > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > > > > > > >   3 files changed, 15 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linu=
x/bpf.h
> > > > > > > > index 800122a8abe5..accb3b314fff 100644
> > > > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > > > @@ -7052,6 +7052,13 @@ enum {
> > > > > > > >                                        * when SK_BPF_CB_T=
X_TIMESTAMPING
> > > > > > > >                                        * feature is on.
> > > > > > > >                                        */
> > > > > > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when ever=
y sendmsg syscall
> > > > > > > > +                                      * is triggered. Fo=
r TCP, it stays
> > > > > > > > +                                      * in the last send=
 process to
> > > > > > > > +                                      * correlate with t=
cp_sendmsg timestamp
> > > > > > > > +                                      * with other times=
tamping callbacks,
> > > > > > > > +                                      * like SND/SW/ACK.=

> > > > > > >
> > > > > > > Do you have a chance to look at how this will work at UDP?
> > > > > >
> > > > > > Sure, I feel like it could not be useful for UDP. Well, thing=
s get
> > > > > > strange because I did write a long paragraph about this thing=
 which
> > > > > > apparently disappeared...
> > > > > >
> > > > > > I manage to find what I wrote:
> > > > > >     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suitable =
because
> > > > > >     there are two sending process, 1) lockless path, 2) lock =
path, which
> > > > > >     should be handled carefully later. For the former, even t=
hough it's
> > > > > >     unlikely multiple threads access the socket to call sendm=
sg at the
> > > > > >     same time, I think we'd better not correlate it like what=
 we do to the
> > > > > >     TCP case because of the lack of sock lock protection. Con=
sidering SND_CB is
> > > > > >     uapi flag, I think we don't need to forcely add the 'TCP_=
' prefix in
> > > > > >     case we need to use it someday.
> > > > > >
> > > > > >     And one more thing is I'd like to use the v5[1] method in=
 the next round
> > > > > >     to introduce a new tskey_bpf which is good for UDP type. =
The new field
> > > > > >     will not conflict with the tskey in shared info which is =
generated
> > > > > >     by sk->sk_tskey in __ip_append_data(). It hardly works if=
 both features
> > > > > >     (so_timestamping and its bpf extension) exists at the sam=
e time. Users
> > > > > >     could get confused because sometimes they fetch the tskey=
 from skb,
> > > > > >     sometimes they don't, especially when we have cmsg featur=
e to turn it on/
> > > > > >     off per sendmsg. A standalone tskey for bpf extension wil=
l be needed.
> > > > > >     With this tskey_bpf, we can easily correlate the timestam=
p in sendmsg
> > > > > >     syscall with other tx points(SND/SW/ACK...).
> > > > > >
> > > > > >     [1]: https://lore.kernel.org/all/20250112113748.73504-14-=
kerneljasonxing@gmail.com/
> > > > > >
> > > > > >     If possible, we can leave this question until the UDP sup=
port series
> > > > > >     shows up. I will figure out a better solution :)
> > > > > >
> > > > > > In conclusion, it probably won't be used by the UDP type. It'=
s uAPI
> > > > > > flag so I consider the compatibility reason.
> > > > >
> > > > > I don't think this is acceptable. We should aim for an API that=
 can
> > > > > easily be used across protocols, like SO_TIMESTAMPING.
> > > >
> > > > After I revisit the UDP SO_TIMESTAMPING again, my thoughts are
> > > > adjusted like below:
> > > >
> > > > It's hard to provide an absolutely uniform interface or usage to =
users
> > > > for TCP and UDP and even more protocols. Cases can be handled one=
 by
> > > > one.
> >
> > We should try hard. SO_TIMESTAMPING is uniform across protocols.
> > An interface that is not is just hard to use.
> >
> > > > The main obstacle is how we can correlate the timestamp in
> > > > sendmsg syscall with other sending timestamps. It's worth noticin=
g
> > > > that for SO_TIMESTAMPING the sendmsg timestamp is collected in th=
e
> > > > userspace. For instance, while skb enters the qdisc, we fail to k=
now
> > > > which skb belongs to which sendmsg.
> > > >
> > > > An idea coming up is to introduce BPF_SOCK_OPS_TS_SND_CB to corre=
late
> > > > the sendmsg timestamp with tskey (in tcp_tx_timestamp()) under th=
e
> > > > protection of socket lock + syscall as the current patch does. Bu=
t for
> > > > UDP, it can be lockless. IIUC, there is a very special case where=
 even
> > > > SO_TIMESTAMPING may get lost: if multiple threads accessing the s=
ame
> > > > socket send UDP packets in parallel, then users could be confused=

> > > > which tskey matches which sendmsg.
> >
> > This is a known issue for lockless datagram sockets.
> >
> > With SO_TIMESTAMPING, but the use of timestamping and of concurrent
> > sendmsg calls is under control of the process, so it only shoots
> > itself in the foot.
> >
> > With BPF timestamping, a process may confuse a third party admin, so
> > the situation is slightly different.
> =

> Agreed.
> =

> >
> > > > IIUC, I will not consider this
> > > > unlikely case, then the UDP case is quite similar to the TCP case=
.
> > > >
> > > > The scenario for the UDP case is:
> > > > 1) using fentry bpf to hook the udp_sendmsg() to get the timestam=
p
> > > > like TCP does in this series.
> > > > 2) insert BPF_SOCK_OPS_TS_SND_CB into __ip_append_data() near the=

> > > > SO_TIMESTAMPING code snippets to let bpf program correlate the ts=
key
> > > > with timestamp.
> > > > Note: tskey in UDP will be handled carefully in a different way
> > > > because we should support both modes for socket timestamping at t=
he
> > > > same time.
> > > > It's really similar to TCP regardless of handling tskey.
> > > >
> > >
> > > To be more precise in case you don't have much time to read the abo=
ve
> > > long paragraph, BPF_SOCK_OPS_TS_SND_CB is mainly used to correlate
> > > sendmsg timestamp with corresponding tskey.
> > >
> > > 1. For TCP, we can correlate it in tcp_tx_timestamp() like this pat=
ch does.
> > >
> > > 2. For UDP, we can correlate in __ip_append_data() along with those=

> > > tskey initialization, assuming there are no multiple threads callin=
g
> > > locklessly ip_make_skb(). Locked path
> > > (udp_sendmsg()->ip_append_data()) works like TCP under the socket l=
ock
> > > protection, so it can be easily handled. Lockless path
> > > (udp_sendmsg()->ip_make_skb()) can be visited by multiple threads a=
t
> > > the same time, which should be handled properly.
> >
> > Different hook points is fine, as UDP (and RAW) uses __ip_append_data=

> =

> Then this approach (introducing this new flag) is feasible. Sorry that
> last night I wrote such a long paragraph which buried something
> important. Because of that, I rephrase the whole idea about how to let
> UDP work with this kind of new flag in [patch v8 11/12]. Link is
> https://lore.kernel.org/all/CAL+tcoCmXcDot-855XYU7PKCiGvJL=3DO3CQBGuOTR=
As2_=3DYs=3Dgg@mail.gmail.com/
> =

> > or more importantly ip_send_skb, while TCP uses ip_queue_xmit.
> =

> For TCP, we use tcp_tx_timestamp to finish the map between sendmsg
> timestamp and tskey.
> =

> >
> > As long as the API is the same: the operation (BPF_SOCK_OPS_TS_SND_CB=
)
> > and the behavior of that operation. Subject to the usual distinction
> > between protocol behavior (bytestream vs datagram).
> =

> I see your point.
> =

> >
> > > I prefer to implement
> > > the bpf extension for IPCORK_TS_OPT_ID, which should be another top=
ic,
> > > I think. This might be the only one corner case, IIUC?
> >
> > This sounds like an entirely different topic? Not sure what this is.
> =

> Not really a different topic. I mean let bpf prog take the whole
> control of setting the tskey, then with this BPF_SOCK_OPS_TS_SND_CB
> flag we can correlate the sendmsg timestamp with tskey. So It has
> something to do with the usage of UDP. Please take a look at that link
> to patch 11/12. For TCP, we don't need to care about the value of
> tskey which has already been taken care of by SO_TIMESTAMPING. So it
> is slightly different. I'm not sure if this kind of usage is
> acceptable?

Why can TCP rely on SO_TIMESTAMPING to set tskey, but UDP cannot?

BPF will need to set the key for both protocol if SO_TIMESTAMPING is
not enabled, right?=

