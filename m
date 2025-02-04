Return-Path: <bpf+bounces-50424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD11A277FB
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08117A2F88
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399121639D;
	Tue,  4 Feb 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkYsc8pj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B951216384;
	Tue,  4 Feb 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688909; cv=none; b=UHStdGmHhKFU5LneLWaOSfPjyDZECq2FvdY38gtY5xNNzQDvUpboD05vgl+s2ymBceop5+YyyuKDsLR3YPocKOK4hzhKPgM5tMHCmgCfotIGu5nn5WbK+OtM3L5bfwirhRtrFaeP29ztnWE67RsPjSqsQltP9dJD0lAHKoNDUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688909; c=relaxed/simple;
	bh=mCXU03iseYv8M7C7bQlVva2aSYjM4QG5+flT26478ZA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UEmfTb5hFJe5eTONpBro5jFw8aZ5eq65zvz+7Xj+95CZag+F3WpDn/B6sm5Z5NaKQhDK0f4MID+EWknVVgfJRyvV9CHVVS3HCxa6wU8SEIwicObswucEbNwTk3cV8DmNv4fzFC2+7EY8FrmzI6V8HYu21cL9IWxtbQsXHWblv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkYsc8pj; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e42d9c092bso1995126d6.0;
        Tue, 04 Feb 2025 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738688907; x=1739293707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4WApgORazt7kK8MQgMP3MLmRObBjOo78+IkETLy4b8=;
        b=HkYsc8pj2hZjrp0+C0bBzGO6KWfcPCbRbSOaW0fb0Uj3ARA0k92dkRtcBNWm2bijSI
         JJ7+oTq85eOxTD5XkEuQ9tOLPW636bEwEl3/XRKv2HUykCz2COVzekCp34kd3fV+Qq5I
         dIu1HKOG9mGF9PIweZ9c2JFavbkN5urmWX98aXtKZjqiU7lHBSrvmDA1fMzMd8vNxocB
         nS9CeE+xxq5J5xO64YZmuNwQXAyfIP0nOecKIRsa09HrVbEXtqbDc3YlrgqQeNG+toYE
         Qz6/ei8FvD4uhGQUNf1lEtsFpIDt8xi8WN4Vn5iS3Jsh0Yt+/Z9Tt/dYLl31rR1Clvbm
         bkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688907; x=1739293707;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K4WApgORazt7kK8MQgMP3MLmRObBjOo78+IkETLy4b8=;
        b=ktm77FSRdGqPpKmsOBsffTAiN6+QgXHy7sXlOjokTo5E7BuGGXru+plE6Q/PmB8fRs
         iUuLEzXfuAp7gbfH4oZQFSD/qGciY+3F7uLvNVWfvBO/uMdSregwpo313cIl3n7+lAAH
         LcvuergOTQuDEBZItiS0GPgvVw4czYvsiz5h1R7BNrdOET5fH2B5WzKIrAYQ/EbPHNNB
         Z4qHpWuxUTl5426u5HP9Aj4n+eLzXkObYQ+xruzEQ9p9ibm3Iw5zUTR/Czl5xZQuNR+O
         E98upBjtqhK/n4aHjFHSmLazHG3Ro2WxaXm/V3hp6I0JXTtcNMcdtX40WMqfSzZZWtSo
         z0tg==
X-Forwarded-Encrypted: i=1; AJvYcCXHX9/OzXVOOAK6dDVXuxs2JQ/02A89l63ziaG4kh966daOAAtWIpxsxpgj6gqbA/AG2ytDbjFi@vger.kernel.org, AJvYcCXJssRtbqEFwy5zR6Bn6Y+pLezHg5CrMceSse3/goS/Iy2qkZVcXVxsMzBjYgihYzvoEAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ulz02z/H/pazKUoK8qw0YWscFNaw7esc8SLZZCHn7WuMzbdc
	3pfFlugvgySvInYelrruD1p75msVjAfNvoGiO/x8goGjNwDrjmuk
X-Gm-Gg: ASbGnct1u9mE6s0WJ9PgAer0WJIvE3+hkz1vrgVqkajC9rqgqNBUdUqCcCD3sG+bYvZ
	7aSVg6W98srADzRKUILuRlSa54snhMZW3St1i4q41R/tZ/Vrh3kSjQvF7zcaqIjwYglWW4UFl4C
	lLp6f8OhhzhYtEfkjffIkcQ1CXTrncJbmCpITWFOpQcbSWt+/NdYMzJc8wUA8a9Hkpu/V2Zal0I
	cgE8+ePkBKz2+6iZnGSw3/6d7PQ+DpofS80qDFK51ZnruShaiws9tXu/b/cOsMmFhC0g5z3CZWT
	g8L0OkQwTlOoRqI0EjQSrWa8mZMWKIotx86ZWHkO/3OV6Xv1mxAaJr8sdazUZxg=
X-Google-Smtp-Source: AGHT+IGGmQZHXmcvliPQzRC6EZ0r01YA39LiYbd1MMRM34mi94Ys1tTMvD7agRomR8buAKGNkmb4ug==
X-Received: by 2002:a05:6214:e4c:b0:6d8:9660:8877 with SMTP id 6a1803df08f44-6e243bb8e16mr397056416d6.18.1738688906649;
        Tue, 04 Feb 2025 09:08:26 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e421250e3fsm11048946d6.72.2025.02.04.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:08:26 -0800 (PST)
Date: Tue, 04 Feb 2025 12:08:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
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
Message-ID: <67a24989d7202_bb56629425@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDZXc56BsO9tYvb1EFDdMHhv3OcBsPwY3ctJ85rvb+OHA@mail.gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-12-kerneljasonxing@gmail.com>
 <d2605829-d5c2-4ce2-ac27-9f1df0398ccc@linux.dev>
 <CAL+tcoDZXc56BsO9tYvb1EFDdMHhv3OcBsPwY3ctJ85rvb+OHA@mail.gmail.com>
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
> On Tue, Feb 4, 2025 at 9:16=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >
> > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > Introduce the callback to correlate tcp_sendmsg timestamp with othe=
r
> > > points, like SND/SW/ACK. We can let bpf trace the beginning of
> > > tcp_sendmsg_locked() and fetch the socket addr, so that in
> >
> > Instead of "fetch the socket addr...", should be "store the sendmsg t=
imestamp at
> > the bpf_sk_storage ...".
> =

> I will revise it. Thanks.
> =

> >
> > > tcp_tx_timestamp() we can correlate the tskey with the socket addr.=

> >
> >
> > > It is accurate since they are under the protect of socket lock.
> > > More details can be found in the selftest.
> >
> > The selftest uses the bpf_sk_storage to store the sendmsg timestamp a=
t
> > fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_timestamp (=
i.e.
> > BPF_SOCK_OPS_TS_SND_CB added in this patch).
> >
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >   include/uapi/linux/bpf.h       | 7 +++++++
> > >   net/ipv4/tcp.c                 | 1 +
> > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > >   3 files changed, 15 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 800122a8abe5..accb3b314fff 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -7052,6 +7052,13 @@ enum {
> > >                                        * when SK_BPF_CB_TX_TIMESTAM=
PING
> > >                                        * feature is on.
> > >                                        */
> > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendmsg =
syscall
> > > +                                      * is triggered. For TCP, it =
stays
> > > +                                      * in the last send process t=
o
> > > +                                      * correlate with tcp_sendmsg=
 timestamp
> > > +                                      * with other timestamping ca=
llbacks,
> > > +                                      * like SND/SW/ACK.
> >
> > Do you have a chance to look at how this will work at UDP?
> =

> Sure, I feel like it could not be useful for UDP. Well, things get
> strange because I did write a long paragraph about this thing which
> apparently disappeared...
> =

> I manage to find what I wrote:
>     For UDP type, BPF_SOCK_OPS_TS_SND_CB may be not suitable because
>     there are two sending process, 1) lockless path, 2) lock path, whic=
h
>     should be handled carefully later. For the former, even though it's=

>     unlikely multiple threads access the socket to call sendmsg at the
>     same time, I think we'd better not correlate it like what we do to =
the
>     TCP case because of the lack of sock lock protection. Considering S=
ND_CB is
>     uapi flag, I think we don't need to forcely add the 'TCP_' prefix i=
n
>     case we need to use it someday.
> =

>     And one more thing is I'd like to use the v5[1] method in the next =
round
>     to introduce a new tskey_bpf which is good for UDP type. The new fi=
eld
>     will not conflict with the tskey in shared info which is generated
>     by sk->sk_tskey in __ip_append_data(). It hardly works if both feat=
ures
>     (so_timestamping and its bpf extension) exists at the same time. Us=
ers
>     could get confused because sometimes they fetch the tskey from skb,=

>     sometimes they don't, especially when we have cmsg feature to turn =
it on/
>     off per sendmsg. A standalone tskey for bpf extension will be neede=
d.
>     With this tskey_bpf, we can easily correlate the timestamp in sendm=
sg
>     syscall with other tx points(SND/SW/ACK...).
> =

>     [1]: https://lore.kernel.org/all/20250112113748.73504-14-kerneljaso=
nxing@gmail.com/
> =

>     If possible, we can leave this question until the UDP support serie=
s
>     shows up. I will figure out a better solution :)
> =

> In conclusion, it probably won't be used by the UDP type. It's uAPI
> flag so I consider the compatibility reason.

I don't think this is acceptable. We should aim for an API that can
easily be used across protocols, like SO_TIMESTAMPING. Taking a
timestamp at sendmsg entry is a useful property for all such
protocols.

