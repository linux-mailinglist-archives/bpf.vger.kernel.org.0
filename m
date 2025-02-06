Return-Path: <bpf+bounces-50675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E737FA2AD99
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 17:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CEC3A2621
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032323F277;
	Thu,  6 Feb 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijZ3wei9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91D236A81;
	Thu,  6 Feb 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858969; cv=none; b=TwGTBjrnnqL6Cn+1EhB4dBZEyJ/Km65HaCLgxJLO4l231jWa39e8I+zYnq4wc4JihUCGNHuk5kMmn+fETdlz0fHC5LOe1803pI+0HaI/a9aJZisfj8CTROP8b/u3v5gf5vmRAz1ibm4Lgm4RMI1f/evn52mSDawpN2pScDx3GYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858969; c=relaxed/simple;
	bh=QKqK14ETo2EpPPyx/AE7saj0V8lg1QElaofn8Mr5pZE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nMCbx+WOi5gDkhEwDEfwNjBRNV5D02SAKZWHWqcLnd6EdWKKkK5cNCIBX+QL8fHZYd4f4M/58CDV6hRtuUJChhZXTA27T0Cdu9dcK3zp9RQ84nA+wBShfiNqG3PlUZIWudFp3unW+racNjZQ4y7rUX/g3vXccrZqJc155ueHuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijZ3wei9; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a6781bc8so8947481cf.2;
        Thu, 06 Feb 2025 08:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738858966; x=1739463766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTs4FlC5g9nDTXfSxXCWnMaRnze4qetLRIXppYT5RsU=;
        b=ijZ3wei9aCWMEW/9lisj+RO4/CMLYp2tXcdx/vd1qJh/o29kSl55gjDe3A5oPeOsDf
         IWBKV5TPrz3zqk3/WrIQIIWPqlRkqGspaAQjeIRCoh19lLF6IRIcQwT3Wfz+kGdagMyd
         ThjaAW0bZuwCVN1UpGYxeo3p5A+N/xMuYsiu55w1l6xc77FV5hxK1JbcCMWEOpNNqHDm
         pdol/MqaibljKDQ3SaF4IctVHCa1yjHo9lmh9YTbSRzBKu4wID7y1egjB/w+Uhfv+qfn
         qRZ+mIjGw6oDhRKRazXWIvLKNeO0wGOV++Gm4I7wyOMjQZCnRf441rQ09QsDjSp/SQ4/
         spCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858966; x=1739463766;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VTs4FlC5g9nDTXfSxXCWnMaRnze4qetLRIXppYT5RsU=;
        b=KpTNuNZQQBu/0VMMVBFa3vnL8uBh7gq7iqcMyIoERyENM5BPiK0vcWWioWsMLJmwwl
         22R4E1UnCOjlU99FghY4eFp/97J+0HabP+g+C5w6XHhQFAiGohbfiIXCRDNZWTrc2DrD
         Kk4PV8lYWtkBQ4hsIkRrWNVZsFtu+XourEgT3g4B/Dqm4EPGLlCMzpjtR9ulZdOvaKRg
         gU8lvJF3rb8CLNm/b36aFLDa/yxjiFrmQDSqDcyqXtYMnb3WeReWkHUBnyvsp+qHmlJE
         JviJwZ2S4+HWGkk2cDBIae8qC25bhFJeESkt7mVlIP4ezG6rhwcgBU/NakxtxGH6JyGX
         Xycw==
X-Forwarded-Encrypted: i=1; AJvYcCWHGDaOM98kyf10mv48sAAbDIZWu7lz7geJT0/2KqaAJuA3STRf9n7MIj9CYHEPRP1CB1tv4UKI@vger.kernel.org, AJvYcCWJewI2Yog8AREb+BuPm/w4qT1aJqlTLG/yIIvkgjCso+yS3FbW910fvkqi0mE4X8X8w7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+67loKKi848/HNNCnaVR+HazWe8vTDBjJ3TUGHzWCob7WWb2
	8hq9Uy/vyvQ2954sVLakYtNlDAv6Xn4j8doWT9wVXOto7qYPKm/A
X-Gm-Gg: ASbGncueGSxq/ch9qMb5ixMADiF86vgNCzVkH9iI/odKXZQjm+Zbl2AWi8qOQO4tKgz
	0ShshdWDmjB20DsNPNcg5BT93aET6xoAzjBqwTLOZddvui+sgtlCB26rtnF6slvaYYJ8oMhzkjh
	z5eRb6oLtQUCzEP577uGyLJuSNl6q8fwWSq2bZ11ZKwF4XC+SVB/OJFSuBVQy6XFpMSJuRJaSkQ
	H9IptANyxR47kofPcx7/3NXmE58BEPtfIAd4Mh5V8T3B2c8Qr6uwslSSvRDF+LLnQ0Ix69fPPSd
	1OjWnjHh00WV2K7/r2gGs/N+jOU0Iw3tZKXRJvp5WoaPkjD7P/DRApflkm1jDjI=
X-Google-Smtp-Source: AGHT+IEyiLGklyxbgfnnKQapVMyeROpD7iRTZMOOsziZYiJu/9hyRVOS3XYBF0jIdmSox9isiNrgTw==
X-Received: by 2002:a05:6214:5096:b0:6d8:8fbf:d1b7 with SMTP id 6a1803df08f44-6e42fc7b5a7mr80511826d6.43.1738858965509;
        Thu, 06 Feb 2025 08:22:45 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43ba36d14sm7194496d6.33.2025.02.06.08.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:22:44 -0800 (PST)
Date: Thu, 06 Feb 2025 11:22:44 -0500
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
Message-ID: <67a4e1d4218c1_20a5e6294d9@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCeCVVe=Uiu9Onr8efA9udqL+1yXyckkWwS7PemyZbhUw@mail.gmail.com>
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
 <67a425b48c434_199430294e6@willemb.c.googlers.com.notmuch>
 <CAL+tcoCeCVVe=Uiu9Onr8efA9udqL+1yXyckkWwS7PemyZbhUw@mail.gmail.com>
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
> On Thu, Feb 6, 2025 at 11:00=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Thu, Feb 6, 2025 at 5:02=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > On Wed, Feb 5, 2025 at 11:20=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jason Xing wrote:
> > > > > > > On Wed, Feb 5, 2025 at 2:09=E2=80=AFAM Jason Xing <kernelja=
sonxing@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Feb 5, 2025 at 1:08=E2=80=AFAM Willem de Bruijn
> > > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Jason Xing wrote:
> > > > > > > > > > On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai L=
au <martin.lau@linux.dev> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > > > > > > > > > Introduce the callback to correlate tcp_sendmsg t=
imestamp with other
> > > > > > > > > > > > points, like SND/SW/ACK. We can let bpf trace the=
 beginning of
> > > > > > > > > > > > tcp_sendmsg_locked() and fetch the socket addr, s=
o that in
> > > > > > > > > > >
> > > > > > > > > > > Instead of "fetch the socket addr...", should be "s=
tore the sendmsg timestamp at
> > > > > > > > > > > the bpf_sk_storage ...".
> > > > > > > > > >
> > > > > > > > > > I will revise it. Thanks.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > tcp_tx_timestamp() we can correlate the tskey wit=
h the socket addr.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > It is accurate since they are under the protect o=
f socket lock.
> > > > > > > > > > > > More details can be found in the selftest.
> > > > > > > > > > >
> > > > > > > > > > > The selftest uses the bpf_sk_storage to store the s=
endmsg timestamp at
> > > > > > > > > > > fentry/tcp_sendmsg_locked and retrieves it back at =
tcp_tx_timestamp (i.e.
> > > > > > > > > > > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.=
com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >   include/uapi/linux/bpf.h       | 7 +++++++
> > > > > > > > > > > >   net/ipv4/tcp.c                 | 1 +
> > > > > > > > > > > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > > > > > > > > > > >   3 files changed, 15 insertions(+)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/include/uapi/linux/bpf.h b/include/u=
api/linux/bpf.h
> > > > > > > > > > > > index 800122a8abe5..accb3b314fff 100644
> > > > > > > > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > > > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > > > > > > > @@ -7052,6 +7052,13 @@ enum {
> > > > > > > > > > > >                                        * when SK_=
BPF_CB_TX_TIMESTAMPING
> > > > > > > > > > > >                                        * feature =
is on.
> > > > > > > > > > > >                                        */
> > > > > > > > > > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called w=
hen every sendmsg syscall
> > > > > > > > > > > > +                                      * is trigg=
ered. For TCP, it stays
> > > > > > > > > > > > +                                      * in the l=
ast send process to
> > > > > > > > > > > > +                                      * correlat=
e with tcp_sendmsg timestamp
> > > > > > > > > > > > +                                      * with oth=
er timestamping callbacks,
> > > > > > > > > > > > +                                      * like SND=
/SW/ACK.
> > > > > > > > > > >
> > > > > > > > > > > Do you have a chance to look at how this will work =
at UDP?
> > > > > > > > > >
> > > > > > > > > > Sure, I feel like it could not be useful for UDP. Wel=
l, things get
> > > > > > > > > > strange because I did write a long paragraph about th=
is thing which
> > > > > > > > > > apparently disappeared...
> > > > > > > > > >
> > > > > > > > > > I manage to find what I wrote:
> > > > > > > > > >     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not s=
uitable because
> > > > > > > > > >     there are two sending process, 1) lockless path, =
2) lock path, which
> > > > > > > > > >     should be handled carefully later. For the former=
, even though it's
> > > > > > > > > >     unlikely multiple threads access the socket to ca=
ll sendmsg at the
> > > > > > > > > >     same time, I think we'd better not correlate it l=
ike what we do to the
> > > > > > > > > >     TCP case because of the lack of sock lock protect=
ion. Considering SND_CB is
> > > > > > > > > >     uapi flag, I think we don't need to forcely add t=
he 'TCP_' prefix in
> > > > > > > > > >     case we need to use it someday.
> > > > > > > > > >
> > > > > > > > > >     And one more thing is I'd like to use the v5[1] m=
ethod in the next round
> > > > > > > > > >     to introduce a new tskey_bpf which is good for UD=
P type. The new field
> > > > > > > > > >     will not conflict with the tskey in shared info w=
hich is generated
> > > > > > > > > >     by sk->sk_tskey in __ip_append_data(). It hardly =
works if both features
> > > > > > > > > >     (so_timestamping and its bpf extension) exists at=
 the same time. Users
> > > > > > > > > >     could get confused because sometimes they fetch t=
he tskey from skb,
> > > > > > > > > >     sometimes they don't, especially when we have cms=
g feature to turn it on/
> > > > > > > > > >     off per sendmsg. A standalone tskey for bpf exten=
sion will be needed.
> > > > > > > > > >     With this tskey_bpf, we can easily correlate the =
timestamp in sendmsg
> > > > > > > > > >     syscall with other tx points(SND/SW/ACK...).
> > > > > > > > > >
> > > > > > > > > >     [1]: https://lore.kernel.org/all/20250112113748.7=
3504-14-kerneljasonxing@gmail.com/
> > > > > > > > > >
> > > > > > > > > >     If possible, we can leave this question until the=
 UDP support series
> > > > > > > > > >     shows up. I will figure out a better solution :)
> > > > > > > > > >
> > > > > > > > > > In conclusion, it probably won't be used by the UDP t=
ype. It's uAPI
> > > > > > > > > > flag so I consider the compatibility reason.
> > > > > > > > >
> > > > > > > > > I don't think this is acceptable. We should aim for an =
API that can
> > > > > > > > > easily be used across protocols, like SO_TIMESTAMPING.
> > > > > > > >
> > > > > > > > After I revisit the UDP SO_TIMESTAMPING again, my thought=
s are
> > > > > > > > adjusted like below:
> > > > > > > >
> > > > > > > > It's hard to provide an absolutely uniform interface or u=
sage to users
> > > > > > > > for TCP and UDP and even more protocols. Cases can be han=
dled one by
> > > > > > > > one.
> > > > > >
> > > > > > We should try hard. SO_TIMESTAMPING is uniform across protoco=
ls.
> > > > > > An interface that is not is just hard to use.
> > > > > >
> > > > > > > > The main obstacle is how we can correlate the timestamp i=
n
> > > > > > > > sendmsg syscall with other sending timestamps. It's worth=
 noticing
> > > > > > > > that for SO_TIMESTAMPING the sendmsg timestamp is collect=
ed in the
> > > > > > > > userspace. For instance, while skb enters the qdisc, we f=
ail to know
> > > > > > > > which skb belongs to which sendmsg.
> > > > > > > >
> > > > > > > > An idea coming up is to introduce BPF_SOCK_OPS_TS_SND_CB =
to correlate
> > > > > > > > the sendmsg timestamp with tskey (in tcp_tx_timestamp()) =
under the
> > > > > > > > protection of socket lock + syscall as the current patch =
does. But for
> > > > > > > > UDP, it can be lockless. IIUC, there is a very special ca=
se where even
> > > > > > > > SO_TIMESTAMPING may get lost: if multiple threads accessi=
ng the same
> > > > > > > > socket send UDP packets in parallel, then users could be =
confused
> > > > > > > > which tskey matches which sendmsg.
> > > > > >
> > > > > > This is a known issue for lockless datagram sockets.
> > > > > >
> > > > > > With SO_TIMESTAMPING, but the use of timestamping and of conc=
urrent
> > > > > > sendmsg calls is under control of the process, so it only sho=
ots
> > > > > > itself in the foot.
> > > > > >
> > > > > > With BPF timestamping, a process may confuse a third party ad=
min, so
> > > > > > the situation is slightly different.
> > > > >
> > > > > Agreed.
> > > > >
> > > > > >
> > > > > > > > IIUC, I will not consider this
> > > > > > > > unlikely case, then the UDP case is quite similar to the =
TCP case.
> > > > > > > >
> > > > > > > > The scenario for the UDP case is:
> > > > > > > > 1) using fentry bpf to hook the udp_sendmsg() to get the =
timestamp
> > > > > > > > like TCP does in this series.
> > > > > > > > 2) insert BPF_SOCK_OPS_TS_SND_CB into __ip_append_data() =
near the
> > > > > > > > SO_TIMESTAMPING code snippets to let bpf program correlat=
e the tskey
> > > > > > > > with timestamp.
> > > > > > > > Note: tskey in UDP will be handled carefully in a differe=
nt way
> > > > > > > > because we should support both modes for socket timestamp=
ing at the
> > > > > > > > same time.
> > > > > > > > It's really similar to TCP regardless of handling tskey.
> > > > > > > >
> > > > > > >
> > > > > > > To be more precise in case you don't have much time to read=
 the above
> > > > > > > long paragraph, BPF_SOCK_OPS_TS_SND_CB is mainly used to co=
rrelate
> > > > > > > sendmsg timestamp with corresponding tskey.
> > > > > > >
> > > > > > > 1. For TCP, we can correlate it in tcp_tx_timestamp() like =
this patch does.
> > > > > > >
> > > > > > > 2. For UDP, we can correlate in __ip_append_data() along wi=
th those
> > > > > > > tskey initialization, assuming there are no multiple thread=
s calling
> > > > > > > locklessly ip_make_skb(). Locked path
> > > > > > > (udp_sendmsg()->ip_append_data()) works like TCP under the =
socket lock
> > > > > > > protection, so it can be easily handled. Lockless path
> > > > > > > (udp_sendmsg()->ip_make_skb()) can be visited by multiple t=
hreads at
> > > > > > > the same time, which should be handled properly.
> > > > > >
> > > > > > Different hook points is fine, as UDP (and RAW) uses __ip_app=
end_data
> > > > >
> > > > > Then this approach (introducing this new flag) is feasible. Sor=
ry that
> > > > > last night I wrote such a long paragraph which buried something=

> > > > > important. Because of that, I rephrase the whole idea about how=
 to let
> > > > > UDP work with this kind of new flag in [patch v8 11/12]. Link i=
s
> > > > > https://lore.kernel.org/all/CAL+tcoCmXcDot-855XYU7PKCiGvJL=3DO3=
CQBGuOTRAs2_=3DYs=3Dgg@mail.gmail.com/
> > > > >
> > > > > > or more importantly ip_send_skb, while TCP uses ip_queue_xmit=
.
> > > > >
> > > > > For TCP, we use tcp_tx_timestamp to finish the map between send=
msg
> > > > > timestamp and tskey.
> > > > >
> > > > > >
> > > > > > As long as the API is the same: the operation (BPF_SOCK_OPS_T=
S_SND_CB)
> > > > > > and the behavior of that operation. Subject to the usual dist=
inction
> > > > > > between protocol behavior (bytestream vs datagram).
> > > > >
> > > > > I see your point.
> > > > >
> > > > > >
> > > > > > > I prefer to implement
> > > > > > > the bpf extension for IPCORK_TS_OPT_ID, which should be ano=
ther topic,
> > > > > > > I think. This might be the only one corner case, IIUC?
> > > > > >
> > > > > > This sounds like an entirely different topic? Not sure what t=
his is.
> > > > >
> > > > > Not really a different topic. I mean let bpf prog take the whol=
e
> > > > > control of setting the tskey, then with this BPF_SOCK_OPS_TS_SN=
D_CB
> > > > > flag we can correlate the sendmsg timestamp with tskey. So It h=
as
> > > > > something to do with the usage of UDP. Please take a look at th=
at link
> > > > > to patch 11/12. For TCP, we don't need to care about the value =
of
> > > > > tskey which has already been taken care of by SO_TIMESTAMPING. =
So it
> > > > > is slightly different. I'm not sure if this kind of usage is
> > > > > acceptable?
> > > >
> > > > Why can TCP rely on SO_TIMESTAMPING to set tskey, but UDP cannot?=

> > >
> > > Because for TCP the shared info tskey is calculated by seqno (in
> > > tcp_tx_timestamp()), so it works for so_timestamping and its bpf
> > > extension and they are the same. However, for UDP, the shared info
> > > tskey can be different, depending on when to call __ip_append_data(=
)
> > > and what the sk->sk_tskey is. It can cause conflicts when two modes=

> > > work at the same time.
> >
> > lockless and locked cannot conflict. (if up->pending then the only
> > option is to append to that.)
> =

> Sorry, I should have described more about this point. I was trying to
> say that if two modes (bpf extension and application timestamping)
> work at the same time, will the tskey get messed up? Because we have
> to check if the application mode is turned on. If on, we fetch the
> existing key generated by the application mode, or else we generate
> one by modifying the sk->sk_tskey or the tskey of skb?

This applies to all protocols that implement both. TCP, UDP,
eventually RAW and maybe others like L2TP, CAN, MPTCP, ..

Which is why it should be handled the same uniformly.
 =

> >
> > > More than that, lockless UDP case is a tough
> > > one since we cannot correlate the sendmsg timestamp in udp_sendmsg(=
)
> > > with the tskey generated in __ip_append_data(),
> >
> > With SO_TIMESTAMPING we do not have this distinction between TCP and
> > UDP, so we don't need it here.
> >
> > It is true that multiple lockless sendmsg calls can race and in that
> > case that correlation is ambiguous. That is also the case for
> > SO_TIMESTAMPING and a known issue.
> >
> > This is unlikely in most workloads in practice.
> =

> Oh, I see.
> =

> > > which is a long gap
> > > without any lock. So reuse the IPCORK_TS_OPT_ID logic for bpf
> > > extension here can work.
> >
> > It is fine to add a solution to work around the ambiguity. But not
> > to make it a precondition and so diverge the API for TCP and UDP.
> =

> There is no divergence in API. BPF always uses SND flag to finish the
> correlation. The only difference is UDP needs to manage the tskey pool
> (allocating which tskey to which sendmsg).

Again, I don't see how this is UDP specific.

> =

> >
> > The same argument to choose a key from BPF can be made for TCP to
> > a certain extent.
> =

> Well...right, but we don't bother to do this for TCP. The TCP case is s=
impler.
> =

> It seems that you object to the idea that let bpf prog control the
> allocating tskey for UDP _as default_.

Correct. All protocols should have the same sensible default behavior.
 =

> I'm not sure if I follow you. Sorry for repeating in case that I miss s=
omething:
> 1) For UDP, do not allocate the tskey from the bpf program, unless
> it's an alternative/workaround to handle the lockless case. So it's a
> backup choice.

And an alterative API should apply equally to all protocols too.

> 2) Use the exact same way like TCP to finish the correlation on the
> basis of socket lock protection _as default_. Because the lockless
> method is seldomly used then we may provide 1) method?
> ?

The opposite: the default for UDP is the lockless fast path.

> Thanks,
> Jason
> =

> >
> > > It's worth to highlight that 1) for TCP the time to generate a send=
msg
> > > timestamp and generate a tskey are under the same lock, 2) for
> > > non-lockless UDP, it works like TCP. But in order to deal with the
> > > lockless part, I choose to implement the IPCORK_TS_OPT_ID idea. Thi=
s
> > > is somehow another topic, but the relevant part is that I tried to
> > > prove BPF_SOCK_OPS_TS_SND_CB can be also used in UDP (but in a
> > > different position compared to TCP protocol).
> > >
> > > >
> > > > BPF will need to set the key for both protocol if SO_TIMESTAMPING=
 is
> > > > not enabled, right?
> > >
> > > For TCP, we will rely on 'shinfo->tskey =3D TCP_SKB_CB(skb)->seq +
> > > skb->len - 1;' in tcp_tx_timestamp() regardless of the status of
> > > SO_TIMESTAMPING, so don't bother to manage the tskey from bpf prog.=

> > > While for UDP, we have to manage the tskey. Of course, it's another=

> > > topic.
> > >
> > > Thanks,
> > > Jason
> >
> >



