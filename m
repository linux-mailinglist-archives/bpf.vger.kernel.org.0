Return-Path: <bpf+bounces-50436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536CFA27965
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB09118851E7
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E828921764D;
	Tue,  4 Feb 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbImLmyy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798221323A;
	Tue,  4 Feb 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692599; cv=none; b=ZP2Vl8W6KiqGrIk3vmenf2SOemVLFOpOKyZXaFPvqv2ewP8A1KCMO03uataaGPgKtxh0qnBGSQfFaS4GkV0efP+MXtHIJzp0PmzdWk8xYCcMhnzLBCTOHZHx3vSiNyTN54EGQcGJbu2q5uag8NQWRQG6RyDvS+0LI1iV7xVdVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692599; c=relaxed/simple;
	bh=0VYuTThuz5zVy796xUh3eY31X8OxhB+ZLE+jkr+/WME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NogvU1W4DhU5REQ+WlSGvaB4qWJS4dVnWuNx1BYo7p0OM2KfD4ElkRpiN270v3Ohx6DjPKCv9r2XzX1mOc/f1CxZkU+sdcUUW+r8Noel7MNznG075abM4fsXE9QXtXUfY8cCsCAPBTCO4EMnspuSJBXTjFyTMO4YCBvJB20+XaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbImLmyy; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3cffbcd520aso179825ab.0;
        Tue, 04 Feb 2025 10:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738692597; x=1739297397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUpv1US3H6wkuua0EmIn+aTYAX+yw+m8XtTiEkXUEUo=;
        b=TbImLmyyT5akrCfWPnW/G8v9QnvJkp7owTG8XyfsnnNjyQl+P91BWNCWiu449jEcMd
         yK1gzr9jlIHEtGMg4J2mv1wvgE14q/yfOadoOEKgrYZBaVTueu+4LX+oKBf6fN74dJUh
         NYyjwbJyu5bYLdztFmJY1iKh5ZIt4RFpr/UofRGQYaIaAB3nBrk0N2SajIsqEV8GNNqr
         rSR+JDD9R18Drq66MlGNYNCrE/VIKGJwC4PNMalUxtFKDq4j5l5bxiLGKepM2kC6+gp/
         fXG/DKnMRa9GDF6H5mggOWsi5YUeZB2Vt2p49ARxg5uoMZAzHBEnnMhPMVRUYo8rB8za
         mc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692597; x=1739297397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUpv1US3H6wkuua0EmIn+aTYAX+yw+m8XtTiEkXUEUo=;
        b=Baz7JA86utsCbt1+NbyDhQfTIxlTJwRaFtDriRzTi2v8cyn1Fnr32sbbo2mhxkOnQ8
         RcP0alZ2ruc1Zek5YbHfEmfOiFE2ZaPJ1y5tx1wlby+Y9AEYvtUV8fv8DPZ9jTw+2Foj
         Kg489jTxv0/fz28f4cTHNYAQ6b5KYNaA1Cd5wjsiFNeF8uIy9Sr8lWJ0vkqDBa03fv0R
         kgdpnSGPbbApowUMoTMZGKDUy5d05PhKXAGY7px+G44Z9Uu6uA4LAPHcNKxF5JjYRnwP
         EqjzBSD4QjhEXtvajh7lGWJkzqWzKhbNWZQ2rE90pc6FvjWwVjOuDzkslZtlEm6YWEH7
         RcNw==
X-Forwarded-Encrypted: i=1; AJvYcCUb9PwtdZT9GNJkdG5EcaFaMcRN3urTaxDD+iN/cVqLof961L+uiPiBGTS1+Wjxw7xO71jNsh55@vger.kernel.org, AJvYcCVOxwagyb4e3Dz2zYY4fCtPI0mO3Gq0vDzHmluAOv3DrLe+5MkctxopAq6Fg3M5GpWbJX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi54rBXyjnFIIr3avy7WbtWj+O8qdKiyApiQD7SjmGpOMr3nte
	QCV8n7xPpks8NK00ZBikAFMQ+eX+SaAkx/EPDcdyUk1E2rIvCwx3Hkv6ec70GWCp0WiRrRAe2Wg
	MBQ+aoK/hbdJgqFuC82u44J/MlSY=
X-Gm-Gg: ASbGncuebLJeKN+58TWiF9D4ARP4/e4cdnsgEyzigdiZrb8mmpr8PCqVG6V1EC5smBJ
	aziW9VBvPq8CQsG8/Q6GfTrdFeHkdCOZVtDf/+o7sPzHNmHdooGEBTxs1/+QjhlnQZiDfbKg=
X-Google-Smtp-Source: AGHT+IFLTCftmcUsVTLbLkLF0jFyV+ARTqyLnnU8cSQAPrRUP0bfO3ZwQ9Jv0t6+3dJSjk1BsH/NqW1Bac03IE+0sq4=
X-Received: by 2002:a92:ca4a:0:b0:3d0:2be9:4334 with SMTP id
 e9e14a558f8ab-3d03f49dfd3mr39843465ab.2.1738692596749; Tue, 04 Feb 2025
 10:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-12-kerneljasonxing@gmail.com> <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
 <CAL+tcoDZXc56BsO9tYvb1EFDdMHhv3OcBsPwY3ctJ85rvb+OHA@mail.gmail.com> <67a24989d7202_bb56629425@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a24989d7202_bb56629425@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 02:09:20 +0800
X-Gm-Features: AWEUYZl91c6voaOKj6dfvNV0t8XTwWSOpgahj_0ZXtwW9CNKAM8A1H5VpWPNNfM
Message-ID: <CAL+tcoA7Efzxg9c-CBn3S0JEQZLUHBaCA+dL=mgWbVh26SukgA@mail.gmail.com>
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

On Wed, Feb 5, 2025 at 1:08=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> > >
> > > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > > Introduce the callback to correlate tcp_sendmsg timestamp with othe=
r
> > > > points, like SND/SW/ACK. We can let bpf trace the beginning of
> > > > tcp_sendmsg_locked() and fetch the socket addr, so that in
> > >
> > > Instead of "fetch the socket addr...", should be "store the sendmsg t=
imestamp at
> > > the bpf_sk_storage ...".
> >
> > I will revise it. Thanks.
> >
> > >
> > > > tcp_tx_timestamp() we can correlate the tskey with the socket addr.
> > >
> > >
> > > > It is accurate since they are under the protect of socket lock.
> > > > More details can be found in the selftest.
> > >
> > > The selftest uses the bpf_sk_storage to store the sendmsg timestamp a=
t
> > > fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_timestamp (=
i.e.
> > > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> > >
> > > >
> > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > ---
> > > >   include/uapi/linux/bpf.h       | 7 +++++++
> > > >   net/ipv4/tcp.c                 | 1 +
> > > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > > >   3 files changed, 15 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index 800122a8abe5..accb3b314fff 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -7052,6 +7052,13 @@ enum {
> > > >                                        * when SK_BPF_CB_TX_TIMESTAM=
PING
> > > >                                        * feature is on.
> > > >                                        */
> > > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendmsg =
syscall
> > > > +                                      * is triggered. For TCP, it =
stays
> > > > +                                      * in the last send process t=
o
> > > > +                                      * correlate with tcp_sendmsg=
 timestamp
> > > > +                                      * with other timestamping ca=
llbacks,
> > > > +                                      * like SND/SW/ACK.
> > >
> > > Do you have a chance to look at how this will work at UDP?
> >
> > Sure, I feel like it could not be useful for UDP. Well, things get
> > strange because I did write a long paragraph about this thing which
> > apparently disappeared...
> >
> > I manage to find what I wrote:
> >     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suitable because
> >     there are two sending process, 1) lockless path, 2) lock path, whic=
h
> >     should be handled carefully later. For the former, even though it's
> >     unlikely multiple threads access the socket to call sendmsg at the
> >     same time, I think we'd better not correlate it like what we do to =
the
> >     TCP case because of the lack of sock lock protection. Considering S=
ND_CB is
> >     uapi flag, I think we don't need to forcely add the 'TCP_' prefix i=
n
> >     case we need to use it someday.
> >
> >     And one more thing is I'd like to use the v5[1] method in the next =
round
> >     to introduce a new tskey_bpf which is good for UDP type. The new fi=
eld
> >     will not conflict with the tskey in shared info which is generated
> >     by sk->sk_tskey in __ip_append_data(). It hardly works if both feat=
ures
> >     (so_timestamping and its bpf extension) exists at the same time. Us=
ers
> >     could get confused because sometimes they fetch the tskey from skb,
> >     sometimes they don't, especially when we have cmsg feature to turn =
it on/
> >     off per sendmsg. A standalone tskey for bpf extension will be neede=
d.
> >     With this tskey_bpf, we can easily correlate the timestamp in sendm=
sg
> >     syscall with other tx points(SND/SW/ACK...).
> >
> >     [1]: https://lore.kernel.org/all/20250112113748.73504-14-kerneljaso=
nxing@gmail.com/
> >
> >     If possible, we can leave this question until the UDP support serie=
s
> >     shows up. I will figure out a better solution :)
> >
> > In conclusion, it probably won't be used by the UDP type. It's uAPI
> > flag so I consider the compatibility reason.
>
> I don't think this is acceptable. We should aim for an API that can
> easily be used across protocols, like SO_TIMESTAMPING.

After I revisit the UDP SO_TIMESTAMPING again, my thoughts are
adjusted like below:

It's hard to provide an absolutely uniform interface or usage to users
for TCP and UDP and even more protocols. Cases can be handled one by
one. The main obstacle is how we can correlate the timestamp in
sendmsg syscall with other sending timestamps. It's worth noticing
that for SO_TIMESTAMPING the sendmsg timestamp is collected in the
userspace. For instance, while skb enters the qdisc, we fail to know
which skb belongs to which sendmsg.

An idea coming up is to introduce BPF_SOCK_OPS_TS_SND_CB to correlate
the sendmsg timestamp with tskey (in tcp_tx_timestamp()) under the
protection of socket lock + syscall as the current patch does. But for
UDP, it can be lockless. IIUC, there is a very special case where even
SO_TIMESTAMPING may get lost: if multiple threads accessing the same
socket send UDP packets in parallel, then users could be confused
which tskey matches which sendmsg. IIUC, I will not consider this
unlikely case, then the UDP case is quite similar to the TCP case.

The scenario for the UDP case is:
1) using fentry bpf to hook the udp_sendmsg() to get the timestamp
like TCP does in this series.
2) insert BPF_SOCK_OPS_TS_SND_CB into __ip_append_data() near the
SO_TIMESTAMPING code snippets to let bpf program correlate the tskey
with timestamp.
Note: tskey in UDP will be handled carefully in a different way
because we should support both modes for socket timestamping at the
same time.
It's really similar to TCP regardless of handling tskey.

I feel like I have to change back the name to BPF_SOCK_OPS_TS_TCP_SND_CB?

Thanks,
Jason

> Taking a
> timestamp at sendmsg entry is a useful property for all such
> protocols.

