Return-Path: <bpf+bounces-41948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841399DC58
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 04:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8171C21207
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208CA167D83;
	Tue, 15 Oct 2024 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sttlx3Ci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BEC8F0;
	Tue, 15 Oct 2024 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728959905; cv=none; b=YlHMrV4tecZjdvigef9ASgtLuGsh2l+HvzTiAWMmX4D4jUpkSwcoJ3mpW9TcPf38r+hPrJswGZRs+iOhmBM34e15qurPDqKI192++q4gjDLKQSdDhklVaBVTBiarMgfd99zQtlqdUJM6iimUVLYQqjr85y6TCP9BTl+SqULQ6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728959905; c=relaxed/simple;
	bh=6C6IM+RW8wwbfibMXqkz2gxzIr+hGTMv6ZRy6hxoyS0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AAPQo6x67ou3IIswYTnJzrIoth3yNeGSxnq0KIu4/4Jji19GhPH8YlD7Dkcyrg9DsHBxnSDikn4tu6iIsbpu2WmsA7PZaGwacy68IsMEkKDYfYcpQNyB9Hme+0qOy5dClDl9gv/0AtPbWKqrtaSKIIdpM7WOkEdyNvUgHBEmsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sttlx3Ci; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b115d0d7f8so346955285a.0;
        Mon, 14 Oct 2024 19:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728959903; x=1729564703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyjHosH3KY/nzvTBJZqWUQIOB3R+PsigqRcPfYmQsKA=;
        b=Sttlx3CiewYL2ioT7ld3mYtZNskkFTXZ9XqOAKjHxu8pE6lG+JD6DaBIeYCmsg0AUB
         mWiY1VaCkFyGTB2zNpN9jJalQYCxB6APp5xNqlHvbEjiPEBrvcy8nMYEqypD61hWWEeX
         sPw8QPvczJzRVVgXgnHemtLDVe6cj8c96sXg2tRraSDpxj46HyU5TQIqhcljjzDqTR4V
         yUzVFh9bCnynqqjUJaEg5JIfSwa2de8mk6+74sr9o0a/y852CzcQ0fQhU1RBqT+2wxah
         h+amB9RrmUh28SYM14buQr/lij8LE6fyt+NvWq8hyEJYRG9IT+OC91nYN1UdPA4Lu3qf
         /9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728959903; x=1729564703;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gyjHosH3KY/nzvTBJZqWUQIOB3R+PsigqRcPfYmQsKA=;
        b=ZKpo8fOEhyOC4I45UPF5mpSYcltZUbFX6WHOx1qoRg17IhXR7v0auo56rM4B1Dfb3P
         a8TjKVl8pryonqD7LB4Y3VOAaRxkkPzOoSe9TuODzoRsVViJOnl4PvZOeXRQOC7WB/1s
         zJEebh8WTUjEoYjVzf0c/f7X/UxTRTp0x5zk6MP6BlaOFoDFRNOA5kB/47cD6/TCGQc8
         9CVssHZjp2Q1r5ErQiSq1bxZOjr28b7GjKMZ35azz/t2eLfMetCn4VrqHYj52hqz6T6M
         bh4KJx71hNt2FX+yBnbV3NqAtErrutFKrPryUmqOcUV5lOjboFhmBXvu40qR6mmszdgA
         esYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSKLqwpckwvqiQFb66iGyqnJvV+2VcjUzUn5ByIlOsCl6+QN7anMV//pCswUBC1HknF2FMgcLK@vger.kernel.org, AJvYcCXU6CLUQk7mi72G8czH6r+4S8JWZaOJ4QhDmkxNvM34gxtzpCkyMwyPEnQ3U1sLOvTTa54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7oFbOIwbipDsSV+sV6yNA+xwaSnrDBvTasebc5aBfAx1U6MZZ
	8Ad1gQNfgSx0c6gLHx7m3TrwGs/YOKEcwetDNJjZUVu436pfgpst
X-Google-Smtp-Source: AGHT+IFGPMEMXZqWmVySzqTPQbV8qsvpna+bfw61qLwwma0qpnFoWW8avMRY0IWLgIeH0C6zjnAu1w==
X-Received: by 2002:a05:620a:408b:b0:7a9:b3db:bf32 with SMTP id af79cd13be357-7b11a3e7ef7mr2281723585a.33.1728959902935;
        Mon, 14 Oct 2024 19:38:22 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136166547sm16661385a.24.2024.10.14.19.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 19:38:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 22:38:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670dd59de9a73_2e58fb29464@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDAGLXsqRb4c-hbtE3a38KQHz9jh-p1tKMkWPMKferQ6g@mail.gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-10-kerneljasonxing@gmail.com>
 <670dc78cf28c1_2e17422947f@willemb.c.googlers.com.notmuch>
 <CAL+tcoDAGLXsqRb4c-hbtE3a38KQHz9jh-p1tKMkWPMKferQ6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/12] net-timestamp: add tx OPT_ID_TCP
 support for bpf case
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
> On Tue, Oct 15, 2024 at 9:38=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
> > > from each sendmsg. We only set the socket once like how we use
> > > setsockopt() with OPT_ID|OPT_ID_TCP flags.
> > >
> > > Note: we will check if non-bpf _and_ bpf sk_tsflags have OPT_ID
> > > flag. If either of them has been set before, we will not initialize=

> > > the key any more,
> >
> > Where and how is this achieved?
> =

> Please see this patch and you will find the following codes.
> +       tsflags |=3D (sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] |
> +                   sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);

I saw that, but it's not a condition that stops reinitializing. Which
I think is the intent, based on "If either of them has been set
before, we will not initialize the key anymore"?

Reinitialization is actually supported behavior.

                if (val & SOF_TIMESTAMPING_OPT_ID &&
                    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {

But the sk_tsflags bit may be repeatedly set and cleared.

Anyway, the current patch sets it if either requests it?

+	tsflags |=3D (sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] |
+		    sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);
 	if (val & SOF_TIMESTAMPING_OPT_ID &&
-	    !(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] & SOF_TIMESTAMPING_OPT_ID)=
) {
+	    !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {

 =

> But the difference/problem is that the non-bpf feature only init it
> when connect() is done, but the bpf feature could do it at the
> beginning of connect(). If running txtimestamp -l 1000, the former
> will generate 999 for turkey while the latter 1000.



