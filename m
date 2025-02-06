Return-Path: <bpf+bounces-50602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EA2A29F8B
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 05:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245AD1888D32
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 04:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8296156968;
	Thu,  6 Feb 2025 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajOy3BXZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152746BF;
	Thu,  6 Feb 2025 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738814621; cv=none; b=DANUwDl5KnKMFrKJKks2rPo7tugJGvs3sn4bLXbK/x/WKqSh6uuOCnyWR9iPkBjZs8N4wRbP49gn2ofi17swHfebas9y6FC67WfroXXxznbMPYXYkHGsKCraeHuKNDBTzBxRgptSAqa43sv8ZxIQHzBKbDM1rSjUZPF95G3z97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738814621; c=relaxed/simple;
	bh=8VtmCfm5yctpnnBnu4hJpV7Mhmuo1J96IknfG6VkPPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8Wlnpq5xAmbseBc2QA0qzlb8zGI0JBtKPtqM6Wl7oVwIWcxRpMaT6MicYYLc6phj2TYs8yqqQ9ZHcnRqZ2XD1/9i7fQ2gMdTZvsVVkYVI5x565AM3hqj34UcQJmanY61x25dMJqFnJZBTmwcpp/yXx6iQQzI1ygwWvTNkW16zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajOy3BXZ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so16994139f.2;
        Wed, 05 Feb 2025 20:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738814618; x=1739419418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghYX1JTaBsH06+HfU+LBa7s/LPcyz9GpSmtlPsf/jFk=;
        b=ajOy3BXZbOvoYaTsDx7OyoK6luJum8VkQsdcnF0pdCYkhUMzDg+DnQrc42dWNxrLIn
         B026PL5hWJSfc88GdyguCFYtOM4vRl+WpzAJEAMCW6Y+NbRlXiJWGUO9uTqA9nD9oBN3
         A1FjpRAerzBWGygck5zeTOV+1RpX3OteT14HY/ylPggWjEAl6GnHMw7Q0Zv4psZt9I3x
         fQxY6wzMrUvin68w1QxBMQ150ClcBocXYIthuoCFmcgBiegCt9LeLhlRlDpobhcY/C4f
         UOBGsXaMVgPxeFDoeE63+Bk4gjcpGT8ve+0O7amWpJqy29yLNC9mjRBPP1AUu5/UiA4Z
         4JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738814618; x=1739419418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghYX1JTaBsH06+HfU+LBa7s/LPcyz9GpSmtlPsf/jFk=;
        b=U293ewZKTWWsoezFGJrJqNoc2qx5HSV0xzBxAUNhn0ktUkxrvujLSkZbml3NrwD0q5
         1EskMWPn4Acw85q1AyYAtg34r5P9NyimEKRYanyD82bWxE8WXzpjQPEafF3y8t6MKZoc
         YiYZPnzgn1MDfXPqaFlM1krmhneOIc7HtZUF/pQWu1LmQb/YPLIyd2faOOVmbpTMpPRi
         NB0RllZLKpPlEk0tEa5kmHvEIpp+TBDTIyhdRBHoI4L2IXPB88Hypjy+yxrymU2jjS2Q
         aKVkFySJ0sah/gKqyJxI2WSii5V9HY5hCnPqlMiBucA8rqx49X1VkOtvsiuK1XAlf+ss
         LRBw==
X-Forwarded-Encrypted: i=1; AJvYcCXUA4T7eflVzwokuNS8PUUx4PI9pTZmUXqOw5WqhTiVyNstCWRXY1nL6wn1wDJRjXlHBTOVXglQ@vger.kernel.org, AJvYcCXgGmWbbiKLwesm3uIfaZ0Kb0IksatV+ddKg7AFUDeLb5dsEvLc7KV3O6s8t/d4nlndM+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvG1U3WuC1iV1sSXitqoAbziingVtCd333RNaAoVKgwfxKA5U7
	xZcuzJFUAt/HbICcbAsrYjMzacBxyi9+nlh8JYB5rba0/GJw3aeXmVlo/jYY3alS0Erlhfirxc1
	hkBXz7pnQaBu9bQXy93Ckl+ftFZ4=
X-Gm-Gg: ASbGnctokle6dlSl0O9l/yoHjSBJAwqfcpUs7ohJgNAM1Bvb9fSbKme1rX73CApD7s3
	Y5F5k2IMZ+CDy1qtkJBO7Z5acl8r3rD+2Aai0KkVnvP/i+IMHVXcykTeIIWIl+LepedkYCyOC
X-Google-Smtp-Source: AGHT+IGCK+gVFnFeQBQGZmk0DegbvQrhZuJngbfjrzSL1kz0BBqHsmWR7FNMJSe9EPg8fPmqWf8GH8TMwqkFuN9nlBQ=
X-Received: by 2002:a05:6e02:190b:b0:3d0:1db8:e824 with SMTP id
 e9e14a558f8ab-3d04f44fb53mr47455715ab.10.1738814618303; Wed, 05 Feb 2025
 20:03:38 -0800 (PST)
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
 <CAL+tcoC4E3zn4gB6PC_Kj5jTShNiounu8vjsZbfDCAOn2fNqXw@mail.gmail.com>
 <67a3d1dba6803_170d392948c@willemb.c.googlers.com.notmuch>
 <CAL+tcoBuQYsbfGuL0PUGdvy7UHGKii3rXv8q+GjzbHvK3hKsQw@mail.gmail.com> <67a425b48c434_199430294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a425b48c434_199430294e6@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 12:03:01 +0800
X-Gm-Features: AWEUYZmdJsOxHYGoKj55k07BcKU5rvq-L7357vQB0nHJdMcFkWAVz8Gx02t89mo
Message-ID: <CAL+tcoCeCVVe=Uiu9Onr8efA9udqL+1yXyckkWwS7PemyZbhUw@mail.gmail.com>
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

On Thu, Feb 6, 2025 at 11:00=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Feb 6, 2025 at 5:02=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Wed, Feb 5, 2025 at 11:20=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > On Wed, Feb 5, 2025 at 2:09=E2=80=AFAM Jason Xing <kerneljasonx=
ing@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Feb 5, 2025 at 1:08=E2=80=AFAM Willem de Bruijn
> > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Jason Xing wrote:
> > > > > > > > > On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <=
martin.lau@linux.dev> wrote:
> > > > > > > > > >
> > > > > > > > > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > > > > > > > > Introduce the callback to correlate tcp_sendmsg times=
tamp with other
> > > > > > > > > > > points, like SND/SW/ACK. We can let bpf trace the beg=
inning of
> > > > > > > > > > > tcp_sendmsg_locked() and fetch the socket addr, so th=
at in
> > > > > > > > > >
> > > > > > > > > > Instead of "fetch the socket addr...", should be "store=
 the sendmsg timestamp at
> > > > > > > > > > the bpf_sk_storage ...".
> > > > > > > > >
> > > > > > > > > I will revise it. Thanks.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > tcp_tx_timestamp() we can correlate the tskey with th=
e socket addr.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > It is accurate since they are under the protect of so=
cket lock.
> > > > > > > > > > > More details can be found in the selftest.
> > > > > > > > > >
> > > > > > > > > > The selftest uses the bpf_sk_storage to store the sendm=
sg timestamp at
> > > > > > > > > > fentry/tcp_sendmsg_locked and retrieves it back at tcp_=
tx_timestamp (i.e.
> > > > > > > > > > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > > > > > > ---
> > > > > > > > > > >   include/uapi/linux/bpf.h       | 7 +++++++
> > > > > > > > > > >   net/ipv4/tcp.c                 | 1 +
> > > > > > > > > > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > > > > > > > > > >   3 files changed, 15 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/=
linux/bpf.h
> > > > > > > > > > > index 800122a8abe5..accb3b314fff 100644
> > > > > > > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > > > > > > @@ -7052,6 +7052,13 @@ enum {
> > > > > > > > > > >                                        * when SK_BPF_=
CB_TX_TIMESTAMPING
> > > > > > > > > > >                                        * feature is o=
n.
> > > > > > > > > > >                                        */
> > > > > > > > > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when =
every sendmsg syscall
> > > > > > > > > > > +                                      * is triggered=
. For TCP, it stays
> > > > > > > > > > > +                                      * in the last =
send process to
> > > > > > > > > > > +                                      * correlate wi=
th tcp_sendmsg timestamp
> > > > > > > > > > > +                                      * with other t=
imestamping callbacks,
> > > > > > > > > > > +                                      * like SND/SW/=
ACK.
> > > > > > > > > >
> > > > > > > > > > Do you have a chance to look at how this will work at U=
DP?
> > > > > > > > >
> > > > > > > > > Sure, I feel like it could not be useful for UDP. Well, t=
hings get
> > > > > > > > > strange because I did write a long paragraph about this t=
hing which
> > > > > > > > > apparently disappeared...
> > > > > > > > >
> > > > > > > > > I manage to find what I wrote:
> > > > > > > > >     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suita=
ble because
> > > > > > > > >     there are two sending process, 1) lockless path, 2) l=
ock path, which
> > > > > > > > >     should be handled carefully later. For the former, ev=
en though it's
> > > > > > > > >     unlikely multiple threads access the socket to call s=
endmsg at the
> > > > > > > > >     same time, I think we'd better not correlate it like =
what we do to the
> > > > > > > > >     TCP case because of the lack of sock lock protection.=
 Considering SND_CB is
> > > > > > > > >     uapi flag, I think we don't need to forcely add the '=
TCP_' prefix in
> > > > > > > > >     case we need to use it someday.
> > > > > > > > >
> > > > > > > > >     And one more thing is I'd like to use the v5[1] metho=
d in the next round
> > > > > > > > >     to introduce a new tskey_bpf which is good for UDP ty=
pe. The new field
> > > > > > > > >     will not conflict with the tskey in shared info which=
 is generated
> > > > > > > > >     by sk->sk_tskey in __ip_append_data(). It hardly work=
s if both features
> > > > > > > > >     (so_timestamping and its bpf extension) exists at the=
 same time. Users
> > > > > > > > >     could get confused because sometimes they fetch the t=
skey from skb,
> > > > > > > > >     sometimes they don't, especially when we have cmsg fe=
ature to turn it on/
> > > > > > > > >     off per sendmsg. A standalone tskey for bpf extension=
 will be needed.
> > > > > > > > >     With this tskey_bpf, we can easily correlate the time=
stamp in sendmsg
> > > > > > > > >     syscall with other tx points(SND/SW/ACK...).
> > > > > > > > >
> > > > > > > > >     [1]: https://lore.kernel.org/all/20250112113748.73504=
-14-kerneljasonxing@gmail.com/
> > > > > > > > >
> > > > > > > > >     If possible, we can leave this question until the UDP=
 support series
> > > > > > > > >     shows up. I will figure out a better solution :)
> > > > > > > > >
> > > > > > > > > In conclusion, it probably won't be used by the UDP type.=
 It's uAPI
> > > > > > > > > flag so I consider the compatibility reason.
> > > > > > > >
> > > > > > > > I don't think this is acceptable. We should aim for an API =
that can
> > > > > > > > easily be used across protocols, like SO_TIMESTAMPING.
> > > > > > >
> > > > > > > After I revisit the UDP SO_TIMESTAMPING again, my thoughts ar=
e
> > > > > > > adjusted like below:
> > > > > > >
> > > > > > > It's hard to provide an absolutely uniform interface or usage=
 to users
> > > > > > > for TCP and UDP and even more protocols. Cases can be handled=
 one by
> > > > > > > one.
> > > > >
> > > > > We should try hard. SO_TIMESTAMPING is uniform across protocols.
> > > > > An interface that is not is just hard to use.
> > > > >
> > > > > > > The main obstacle is how we can correlate the timestamp in
> > > > > > > sendmsg syscall with other sending timestamps. It's worth not=
icing
> > > > > > > that for SO_TIMESTAMPING the sendmsg timestamp is collected i=
n the
> > > > > > > userspace. For instance, while skb enters the qdisc, we fail =
to know
> > > > > > > which skb belongs to which sendmsg.
> > > > > > >
> > > > > > > An idea coming up is to introduce BPF_SOCK_OPS_TS_SND_CB to c=
orrelate
> > > > > > > the sendmsg timestamp with tskey (in tcp_tx_timestamp()) unde=
r the
> > > > > > > protection of socket lock + syscall as the current patch does=
. But for
> > > > > > > UDP, it can be lockless. IIUC, there is a very special case w=
here even
> > > > > > > SO_TIMESTAMPING may get lost: if multiple threads accessing t=
he same
> > > > > > > socket send UDP packets in parallel, then users could be conf=
used
> > > > > > > which tskey matches which sendmsg.
> > > > >
> > > > > This is a known issue for lockless datagram sockets.
> > > > >
> > > > > With SO_TIMESTAMPING, but the use of timestamping and of concurre=
nt
> > > > > sendmsg calls is under control of the process, so it only shoots
> > > > > itself in the foot.
> > > > >
> > > > > With BPF timestamping, a process may confuse a third party admin,=
 so
> > > > > the situation is slightly different.
> > > >
> > > > Agreed.
> > > >
> > > > >
> > > > > > > IIUC, I will not consider this
> > > > > > > unlikely case, then the UDP case is quite similar to the TCP =
case.
> > > > > > >
> > > > > > > The scenario for the UDP case is:
> > > > > > > 1) using fentry bpf to hook the udp_sendmsg() to get the time=
stamp
> > > > > > > like TCP does in this series.
> > > > > > > 2) insert BPF_SOCK_OPS_TS_SND_CB into __ip_append_data() near=
 the
> > > > > > > SO_TIMESTAMPING code snippets to let bpf program correlate th=
e tskey
> > > > > > > with timestamp.
> > > > > > > Note: tskey in UDP will be handled carefully in a different w=
ay
> > > > > > > because we should support both modes for socket timestamping =
at the
> > > > > > > same time.
> > > > > > > It's really similar to TCP regardless of handling tskey.
> > > > > > >
> > > > > >
> > > > > > To be more precise in case you don't have much time to read the=
 above
> > > > > > long paragraph, BPF_SOCK_OPS_TS_SND_CB is mainly used to correl=
ate
> > > > > > sendmsg timestamp with corresponding tskey.
> > > > > >
> > > > > > 1. For TCP, we can correlate it in tcp_tx_timestamp() like this=
 patch does.
> > > > > >
> > > > > > 2. For UDP, we can correlate in __ip_append_data() along with t=
hose
> > > > > > tskey initialization, assuming there are no multiple threads ca=
lling
> > > > > > locklessly ip_make_skb(). Locked path
> > > > > > (udp_sendmsg()->ip_append_data()) works like TCP under the sock=
et lock
> > > > > > protection, so it can be easily handled. Lockless path
> > > > > > (udp_sendmsg()->ip_make_skb()) can be visited by multiple threa=
ds at
> > > > > > the same time, which should be handled properly.
> > > > >
> > > > > Different hook points is fine, as UDP (and RAW) uses __ip_append_=
data
> > > >
> > > > Then this approach (introducing this new flag) is feasible. Sorry t=
hat
> > > > last night I wrote such a long paragraph which buried something
> > > > important. Because of that, I rephrase the whole idea about how to =
let
> > > > UDP work with this kind of new flag in [patch v8 11/12]. Link is
> > > > https://lore.kernel.org/all/CAL+tcoCmXcDot-855XYU7PKCiGvJL=3DO3CQBG=
uOTRAs2_=3DYs=3Dgg@mail.gmail.com/
> > > >
> > > > > or more importantly ip_send_skb, while TCP uses ip_queue_xmit.
> > > >
> > > > For TCP, we use tcp_tx_timestamp to finish the map between sendmsg
> > > > timestamp and tskey.
> > > >
> > > > >
> > > > > As long as the API is the same: the operation (BPF_SOCK_OPS_TS_SN=
D_CB)
> > > > > and the behavior of that operation. Subject to the usual distinct=
ion
> > > > > between protocol behavior (bytestream vs datagram).
> > > >
> > > > I see your point.
> > > >
> > > > >
> > > > > > I prefer to implement
> > > > > > the bpf extension for IPCORK_TS_OPT_ID, which should be another=
 topic,
> > > > > > I think. This might be the only one corner case, IIUC?
> > > > >
> > > > > This sounds like an entirely different topic? Not sure what this =
is.
> > > >
> > > > Not really a different topic. I mean let bpf prog take the whole
> > > > control of setting the tskey, then with this BPF_SOCK_OPS_TS_SND_CB
> > > > flag we can correlate the sendmsg timestamp with tskey. So It has
> > > > something to do with the usage of UDP. Please take a look at that l=
ink
> > > > to patch 11/12. For TCP, we don't need to care about the value of
> > > > tskey which has already been taken care of by SO_TIMESTAMPING. So i=
t
> > > > is slightly different. I'm not sure if this kind of usage is
> > > > acceptable?
> > >
> > > Why can TCP rely on SO_TIMESTAMPING to set tskey, but UDP cannot?
> >
> > Because for TCP the shared info tskey is calculated by seqno (in
> > tcp_tx_timestamp()), so it works for so_timestamping and its bpf
> > extension and they are the same. However, for UDP, the shared info
> > tskey can be different, depending on when to call __ip_append_data()
> > and what the sk->sk_tskey is. It can cause conflicts when two modes
> > work at the same time.
>
> lockless and locked cannot conflict. (if up->pending then the only
> option is to append to that.)

Sorry, I should have described more about this point. I was trying to
say that if two modes (bpf extension and application timestamping)
work at the same time, will the tskey get messed up? Because we have
to check if the application mode is turned on. If on, we fetch the
existing key generated by the application mode, or else we generate
one by modifying the sk->sk_tskey or the tskey of skb?

>
> > More than that, lockless UDP case is a tough
> > one since we cannot correlate the sendmsg timestamp in udp_sendmsg()
> > with the tskey generated in __ip_append_data(),
>
> With SO_TIMESTAMPING we do not have this distinction between TCP and
> UDP, so we don't need it here.
>
> It is true that multiple lockless sendmsg calls can race and in that
> case that correlation is ambiguous. That is also the case for
> SO_TIMESTAMPING and a known issue.
>
> This is unlikely in most workloads in practice.

Oh, I see.

> > which is a long gap
> > without any lock. So reuse the IPCORK_TS_OPT_ID logic for bpf
> > extension here can work.
>
> It is fine to add a solution to work around the ambiguity. But not
> to make it a precondition and so diverge the API for TCP and UDP.

There is no divergence in API. BPF always uses SND flag to finish the
correlation. The only difference is UDP needs to manage the tskey pool
(allocating which tskey to which sendmsg).

>
> The same argument to choose a key from BPF can be made for TCP to
> a certain extent.

Well...right, but we don't bother to do this for TCP. The TCP case is simpl=
er.

It seems that you object to the idea that let bpf prog control the
allocating tskey for UDP _as default_.

I'm not sure if I follow you. Sorry for repeating in case that I miss somet=
hing:
1) For UDP, do not allocate the tskey from the bpf program, unless
it's an alternative/workaround to handle the lockless case. So it's a
backup choice.
2) Use the exact same way like TCP to finish the correlation on the
basis of socket lock protection _as default_. Because the lockless
method is seldomly used then we may provide 1) method?
?

Thanks,
Jason

>
> > It's worth to highlight that 1) for TCP the time to generate a sendmsg
> > timestamp and generate a tskey are under the same lock, 2) for
> > non-lockless UDP, it works like TCP. But in order to deal with the
> > lockless part, I choose to implement the IPCORK_TS_OPT_ID idea. This
> > is somehow another topic, but the relevant part is that I tried to
> > prove BPF_SOCK_OPS_TS_SND_CB can be also used in UDP (but in a
> > different position compared to TCP protocol).
> >
> > >
> > > BPF will need to set the key for both protocol if SO_TIMESTAMPING is
> > > not enabled, right?
> >
> > For TCP, we will rely on 'shinfo->tskey =3D TCP_SKB_CB(skb)->seq +
> > skb->len - 1;' in tcp_tx_timestamp() regardless of the status of
> > SO_TIMESTAMPING, so don't bother to manage the tskey from bpf prog.
> > While for UDP, we have to manage the tskey. Of course, it's another
> > topic.
> >
> > Thanks,
> > Jason
>
>

