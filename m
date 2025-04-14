Return-Path: <bpf+bounces-55908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB34CA88FF9
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 01:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7B83AFD85
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 23:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285651F4E37;
	Mon, 14 Apr 2025 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv+NOf4b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3671922E7;
	Mon, 14 Apr 2025 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672402; cv=none; b=Y8V9+FQ2OMaa1l8WTgeqQc8EeEL9wA097R0k5N5SyrR19RfurB5VdScI2JLG7o5rg1rsJcrXP5O3asgNBWmmBZNPZNnmmwA+sIAPKskEuPhVTytgDnbINm+tuEJZhcRYIYN8f6TMySjFRpiSRpSXXjO3QmQp1e5QHMSjYe3pfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672402; c=relaxed/simple;
	bh=s7lYy6Gjwr7+ohU27xkU6KmUU9Hw/CPMrjC9cXo/IVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWCHA+AdSDMNEjmfny3/GkoDdaG4HPJm+30eKCxqI0klpd5orBM8sAIxTrN2Z/AK6HoibZsnRYVzL7x6nd7amMtIGwj6mb8ntkcCsr7GT+v+I4AWis8baxBbzmQZ0kWyEJv1czmZkIWxQKTSG/OHTxeLMiK/uLQIXl08iPjQspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv+NOf4b; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39ac56756f6so4241157f8f.2;
        Mon, 14 Apr 2025 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744672399; x=1745277199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV7ESO7TJMFGqjSzG7njEawZQ/DVEKwwzXitSslkjq8=;
        b=bv+NOf4bBHpB0lyGh7Dx2N73D2+qNFN0IaLvT/ubNxzto/VPhJ/YpctzXYnA/7lsVm
         DzXKEvUi3Io46THvlU+J/R087I7NpjB0QhjvnScdWWhaaT/VCZJteqdOwkozUyN3jHlx
         yGsTJ8END35Fk7RucEQR3GDmE/X7rM5qwWWpbehLMUdqc1RvDR+9Do3AURca269o7Pdz
         nmb0nweoAdKaUjiD1B8RGV6U5g/X6+SdD0a1XXzMywBvefbnLokqVFJYD+c1XJ0ncnVQ
         sI3nCUXzJbwe/V6N1lxL0Xl68QyQ2hgdcVoJMgUkLOHx21dsduJOSldZ/LgfXsaL3g/b
         RFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672399; x=1745277199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV7ESO7TJMFGqjSzG7njEawZQ/DVEKwwzXitSslkjq8=;
        b=mzjwKn8e+bEGGqseyqhbKDMnOqeIgyyi2N+FSh9zsPEOV76qx1foPgJt/HIAllL92C
         Wo8u9OtmVKqaePNz3QE05KRmjO2vvvmaR0SARYv4HbM2H5rK8Sy/1ty0cZGd7+o7vp1i
         GuoualxdDIe42EnMUf3LQKuBOg4DxJv2WIWyBRVfveM254Xw60rxaNWEFCpfUqRmCxcX
         oWE11zerjDGrrDg99Fntsf3GdCNXy4sJUxbAn0kQK6YLNNV8PZ2CfpDIpDmgC8Gd/e7g
         TkfSz/UUPp6XTNM5o8cBSr4nO2arnOu1rOH2/FOHp7YDQKibfQtANpW9cirIuqmEtBLq
         9k4Q==
X-Forwarded-Encrypted: i=1; AJvYcCViG2xokJbOzGaC0UsRuGpXgNcJ5i/rYBf/FBAS1OcQw1amV9WgIdfHIr5jUtSoa3Lx0Zs=@vger.kernel.org, AJvYcCW0y+P1di734Jv5trZt/5v82qeIgt44wBsmK8fDDkYjf9kQxHKG6kxIVNytQCbH7coxBD/D95I5@vger.kernel.org
X-Gm-Message-State: AOJu0YwPiBRnpU0seH34E+DftaznWjaG9ls77pna9G08TLoS5QqSUlnA
	qrIo2Vx1JvtRsJWNZEWX02vz9FTbGWzbra4y7/lcWXt5Rfw3m0YGCCNTiobbBoleg6KXrqIcooc
	1lEmeqWqrAQBUn8rMZR4xMts5JxYLwNY0
X-Gm-Gg: ASbGncu53CgBnhS6/+Yohy8twvHdrv8Ptj302KYRVwqfkI3cuawa40fQW6oR4u6zBA+
	jwwhhpdKtRR26j3HyNdk98hGJqW/GQQJgjXURfUQYx+l9sv8mPyzZPz4g8F6Hb78WamB63U6RV7
	vxRDO5lba2kTBpTxbC7xT/7YNCRoe8R204Q/FQlBLOdY4k5HY/
X-Google-Smtp-Source: AGHT+IHATyOEVtrIA6Rno5VINK0I9Fz97npa8shrxkLXsT0qSY8SOtZw7i7kAAZsAkOqBSqupc3gg5jOkzPlr2b38hE=
X-Received: by 2002:a05:6000:1448:b0:39c:140b:feec with SMTP id
 ffacd0b85a97d-39ea51f4081mr12842961f8f.7.1744672398939; Mon, 14 Apr 2025
 16:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403083956.13946-1-justin.iurman@uliege.be>
 <Z-62MSCyMsqtMW1N@mini-arch> <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
 <CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
 <20250404141955.7Rcvv7nB@linutronix.de> <85eefdd9-ec5d-4113-8a50-5d9ea11c8bf5@uliege.be>
 <CAADnVQK7vNPbMS7T9TUOW7s6HNbfr4H8CWbjPgVXW7xa+ybPsw@mail.gmail.com> <d326726d-7050-4e88-b950-f49cf5901d34@uliege.be>
In-Reply-To: <d326726d-7050-4e88-b950-f49cf5901d34@uliege.be>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Apr 2025 16:13:07 -0700
X-Gm-Features: ATxdqUGOwfu5vm8RFr5a2kuWwGTKTohLd392D86QHISug07sUXQdUf7HVPOQM3M
Message-ID: <CAADnVQ++4Lf0ucHjfyK0OakPYsbN2Q9yX0Ru3ymWo4YtLOi-HA@mail.gmail.com>
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>, 
	Andrea Mayer <andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 11:34=E2=80=AFAM Justin Iurman <justin.iurman@ulieg=
e.be> wrote:
>
> On 4/7/25 19:54, Alexei Starovoitov wrote:
> > On Sun, Apr 6, 2025 at 1:59=E2=80=AFAM Justin Iurman <justin.iurman@uli=
ege.be> wrote:
> >>
> >> On 4/4/25 16:19, Sebastian Sewior wrote:
> >>> Alexei, thank you for the Cc.
> >>>
> >>> On 2025-04-03 13:35:10 [-0700], Alexei Starovoitov wrote:
> >>>> Stating the obvious...
> >>>> Sebastian did a lot of work removing preempt_disable from the networ=
king
> >>>> stack.
> >>>> We're certainly not adding them back.
> >>>> This patch is no go.
> >>>
> >>> While looking through the code, it looks as if lwtunnel_xmit() lacks =
a
> >>> local_bh_disable().
> >>
> >> Thanks Sebastian for the confirmation, as the initial idea was to use
> >> local_bh_disable() as well. Then I thought preempt_disable() would be
> >> enough in this context, but I didn't realize you made efforts to remov=
e
> >> it from the networking stack.
> >>
> >> @Alexei, just to clarify: would you ACK this patch if we do
> >> s/preempt_{disable|enable}()/local_bh_{disable|enable}()/g ?
> >
> > You need to think it through and not sprinkle local_bh_disable in
> > every lwt related function.
> > Like lwtunnel_input should be running with bh disabled already.
>
> Having nested calls to local_bh_{disable|enable}() is fine (i.e.,
> disabling BHs when they're already disabled), but I guess it's cleaner
> to avoid it here as you suggest. And since lwtunnel_input() is indeed
> (always) running with BHs disabled, no changes needed. Thanks for the
> reminder.
>
> > I don't remember the exact conditions where bh is disabled in xmit path=
.
>
> Right. Not sure for lwtunnel_xmit(), but lwtunnel_output() can
> definitely run with or without BHs disabled. So, what I propose is the
> following logic (applied to lwtunnel_xmit() too): if BHs disabled then
> NOP else local_bh_disable(). Thoughts on this new version? (sorry, my
> mailer messes it up, but you got the idea):
>
> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> index e39a459540ec..d44d341683c5 100644
> --- a/net/core/lwtunnel.c
> +++ b/net/core/lwtunnel.c
> @@ -331,8 +331,13 @@ int lwtunnel_output(struct net *net, struct sock
> *sk, struct sk_buff *skb)
>         const struct lwtunnel_encap_ops *ops;
>         struct lwtunnel_state *lwtstate;
>         struct dst_entry *dst;
> +       bool in_softirq;
>         int ret;
>
> +       in_softirq =3D in_softirq();
> +       if (!in_softirq)
> +               local_bh_disable();
> +

This looks like a hack to me.

Instead analyze the typical xmit path. If bh is not disabled
then add local_bh_disable(). It's fine if it happens to be nested
in some cases.

