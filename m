Return-Path: <bpf+bounces-28297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA02F8B815D
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159EA1C22F4B
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312C1A0AE0;
	Tue, 30 Apr 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOpSz+E5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949718412A;
	Tue, 30 Apr 2024 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508819; cv=none; b=iiZzPlguf5vp5u/S1UVGYO6GHxRc5jUmx5xemPJERDlcICmNTR+d2Zqwe3X51N38cIg1OrrQrznTrtDktgGof5W2D0rvS87R+Vt1fqOmbPFd/ERNQBuFpZdjBZoNNyi2r8rvbjiIvfm54XEgdZOcaQCwJhWIOGJPJg0YIfeQO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508819; c=relaxed/simple;
	bh=E47vfWHhgdEa6VDSww86DfgZL2xl0Ve2ZRdE0ayf/uI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Y+Jee6/x30iBRf3mw748NtvsKJZo1k20zQn7cqnBaCwDFbc64b4gEWIYXJw2HQnoFgPiDD8/6GBrz5TCDARli2F4hVxC2DORu0BYaFt64YOFyzLSU6WJ5NrE2E/HeRmqcEvxP1CAekx6so/72m5sd3YJCFzvFsNJ6NxLm1mzvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOpSz+E5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b5ece41dfso25776326d6.2;
        Tue, 30 Apr 2024 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714508816; x=1715113616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E47vfWHhgdEa6VDSww86DfgZL2xl0Ve2ZRdE0ayf/uI=;
        b=dOpSz+E51HvmqeLOwgnXEBW9XEOb8gutuM+CaM3P9T9NOWbfHvIq2l/H08svS8tVNX
         X0oJjyEcmoFfwJPdHtHO2ZNtKBNC539rMTyMLI3rvoRRw49fq0vEnNTvYNLl6ErPAp5R
         MYk8o2WMA7S/q1zejb1/zs1rTSKVQhnPPVODRS1Aaxk3BuWZbdwpGnZ+bexhKa3H3QHk
         kH1a+F51b1cBOO1PVtPzLrBqtmQKYalzzOmmTPcoTf+n0qYTCAr1muhdPp1rKoJ4tMtM
         qbpZUSLuUq32wvQW2ZBnGZ7gaqEfY4p+cE2ndha+mFsl33B80sGWdE7CN7bnuzB8JOVD
         9g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714508816; x=1715113616;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E47vfWHhgdEa6VDSww86DfgZL2xl0Ve2ZRdE0ayf/uI=;
        b=jtgXstx2Vx9PdEakWD/qMnXaP7szHWTfJCGUq4OS7iGtAzFOM7uqYZhoUmXoqVkzFl
         3Vz/L3d0O2b0NL+evurqJxJK01EHs1f/5QPM+0X4gYZAii7SrGWP29VllgSkZBVPozk2
         erX1NlQJd38wsv85YkEU9BSByqlYZd3PjM/XbKSfEdVuUhGacTuxFW1Btk+V3I5egToU
         acfpkXZBh5oEXqoj4WqGZJQZy0bgU8ns9HMRUvO8eKSiB4WoBi2NFyADnIDHgpwyXGpL
         qCsv0OdLdjlPoDFO1sxjbBT7CisypMzgf1JTjv3OHv4GRpEoxUKky8oLs4lSKxiCdLOL
         Ci9w==
X-Forwarded-Encrypted: i=1; AJvYcCVS1Ic96gFtj+cV8EOzhpqTnSyuZpJUeO/+ok+MLak653m/kuZQuIz9T6xM8ndqgAWWC9g625g25V6tGHqm8IglXKUioLOZouKlksw6eq0lYJ+lWWDVjI+dlZl+kIJ8R6IzMDFmrz8CWfUV36uMNXAQqO3+qjyLm7Zq
X-Gm-Message-State: AOJu0Ywjf6gmHogJxxkzxahItAdMenDzQwAqS3pdV8v3mKrKG29QwfKZ
	3tOCnA/nSDOawM52Y8fRznJuOPG9d3SINA94tmff8xZHJ4UKjzqh
X-Google-Smtp-Source: AGHT+IH5xPp90KMXlMcTQ6n4sKv4HMLPSgkmdoyvuageJ8UukZuwiF/Rzto7QPz/r7BeQYjF7sv9Rg==
X-Received: by 2002:a05:6214:2628:b0:69b:5d39:f556 with SMTP id gv8-20020a056214262800b0069b5d39f556mr487369qvb.1.1714508816411;
        Tue, 30 Apr 2024 13:26:56 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id l19-20020ad44453000000b006a0ef060a2esm28974qvt.53.2024.04.30.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:26:41 -0700 (PDT)
Date: Tue, 30 Apr 2024 16:26:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>, 
 kernel@quicinc.com
Message-ID: <663153f92a297_33210f29423@willemb.c.googlers.com.notmuch>
In-Reply-To: <6eb5b283-a9bd-4081-8bce-a60d72af430c@quicinc.com>
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
 <2b2c3eb1-df87-40fe-b871-b52812c8ecd0@linux.dev>
 <e761e1de-0e11-4541-a4db-a1b793a60674@quicinc.com>
 <379558fe-a6e2-444b-a6a7-ef233efa8311@linux.dev>
 <6eb5b283-a9bd-4081-8bce-a60d72af430c@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support
 clockid_t timestamp type
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Abhishek Chauhan (ABC) wrote:
> =

> =

> On 4/26/2024 4:50 PM, Martin KaFai Lau wrote:
> > On 4/26/24 11:46 AM, Abhishek Chauhan (ABC) wrote:
> >>>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> >>>> index 591226dcde26..f195b31d6e75 100644
> >>>> --- a/net/ipv4/ip_output.c
> >>>> +++ b/net/ipv4/ip_output.c
> >>>> @@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *s=
k,
> >>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->priority =3D (cor=
k->tos !=3D -1) ? cork->priority: READ_ONCE(sk->sk_priority);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->mark =3D cork->mark;
> >>>> -=C2=A0=C2=A0=C2=A0 skb->tstamp =3D cork->transmit_time;
> >>>> +=C2=A0=C2=A0=C2=A0 skb_set_tstamp_type_frm_clkid(skb, cork->trans=
mit_time, sk->sk_clockid);
> >>> hmm... I think this will break for tcp. This sequence in particular=
:

Good catch, thanks!

> >>>
> >>> tcp_v4_timewait_ack()
> >>> =C2=A0=C2=A0 tcp_v4_send_ack()
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 ip_send_unicast_reply()
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ip_push_pending_frames()
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ip_finish_skb()
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ip_m=
ake_skb()
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* sk_clockid is REAL but cork->transmit_time should be in mono */
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clocki=
d);;
> >>>
> >>> I think I hit it from time to time when running the test in this pa=
tch set.
> >>>
> >> do you think i need to check for protocol type here . since tcp uses=
 Mono and the rest according to the new design is based on
> >> sk->sk_clockid
> >> if (iph->protocol =3D=3D IPPROTO_TCP)
> >> =C2=A0=C2=A0=C2=A0=C2=A0skb_set_tstamp_type_frm_clkid(skb, cork->tra=
nsmit_time, CLOCK_MONOTONIC);
> >> else
> >> =C2=A0=C2=A0=C2=A0=C2=A0skb_set_tstamp_type_frm_clkid(skb, cork->tra=
nsmit_time, sk->sk_clockid);
> > =

> > Looks ok. iph->protocol is from sk->sk_protocol. I would defer to Wil=
lem input here.
> > =

> > There is at least one more place that needs this protocol check, __ip=
6_make_skb().
> =

> Sounds good. I will wait for Willem to comment here. =


This would be sk_is_tcp(sk).

I think we want to avoid special casing if we can. Note the if.

If TCP always uses monotonic, we could consider initializing
sk_clockid to CLOCK_MONONOTIC in tcp_init_sock.

I guess TCP logic currently entirely ignores sk_clockid. If we are to
start using this, then setsocktop SO_TXTIME must explicitly fail or
ignore for TCP sockets, or silently skip the write.

All of that is more complexity. Than is maybe warranted for this one
case. So no objections from me to special casing using sk_is_tcp(sk)
either.





