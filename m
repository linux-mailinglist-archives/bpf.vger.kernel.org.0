Return-Path: <bpf+bounces-50673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5600FA2AD67
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 17:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964733A2DA3
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01522F161;
	Thu,  6 Feb 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5rqAuKw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10FE1E5B9F;
	Thu,  6 Feb 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858441; cv=none; b=NLhg/OtnGlMx1m4+WpGDDKllflFY5uEFgvWsIP1Q5nzq0xfyAzCW0Yg+zXhJEuGA+qRjJKyqoBzuDZUELMmjDR/9UIivJd2BRx+lwPpO3almiQBf0XcWB9P6y7KvpjrB+H7mNFvKxmo9STiZsIVDPSGNI22AP3DyuuJ8dAUqxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858441; c=relaxed/simple;
	bh=vL2+Jf4Z4cTl6fF86Jebh1NMaI1ua2SlvlcWed7oCoA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oqm+YqpPV5J33ko4qa/+DScBxUSwGJvd0RfqOuygiCZUYjq4Bng3zU7ZtWPfHczAdAOmWRlHbqSbULluGkd7WuJbPwx52N9MVrddoT/fud9zx0S+4F6EXvq8bDH+EC6Rx3rAeCukTrCdMpJuPcpy58lnGdSI6v7IrsJkJxtehpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5rqAuKw; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46b1d40abbdso9348691cf.2;
        Thu, 06 Feb 2025 08:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738858439; x=1739463239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vL2+Jf4Z4cTl6fF86Jebh1NMaI1ua2SlvlcWed7oCoA=;
        b=T5rqAuKwfTNZUi4ynYSYdSTR35k/2TmjpAnfsMNuzsKxNw5dyte7puf6XBHYxI5/sE
         5uUUtW95N8ZJWVwcvTchsVy0FGaAZGfQ3Zzkc2L2yWvQqJECxX0Rs4UkLjkwnQPUNbWk
         rkJ3h9FnSXq/+VHC4bVm0G/ynWUT5S1+6sVgec4oAhxcOFD3ba69S7QbpU/vkuiVPbQO
         Osu0JFmFapTwthR6NkVWFfu3Ix23MDRotRsGaMwiV9JfygXTVmfVojtvTlQCPSvkI/KF
         lBvcam2ooLRK27PrJbze0bILkzamjLC21NwJ59rbTXeFL2AqDLolgwOwgkDGP0cUn/kh
         0xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858439; x=1739463239;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vL2+Jf4Z4cTl6fF86Jebh1NMaI1ua2SlvlcWed7oCoA=;
        b=BX9Oo+jOrPg+nAmDswzedC1dv3Df0eBC3MpBJ5gGdkihceUtjtMZO6XDnQgiBiWRjU
         Xa/KSwSAPpMC0qyyjCo7vNtkLYbZWeSR+VfSRawjGhcW9p/ffvvIJEc57hi8tN2cx7+P
         6xyEcjL+y7HtXP3D9rlN2SvCzB1OtEeFVbf/4qAOQNgxuh/MG/i68++e4OR9+ALL8d0y
         hCrUdwcrITKQuSRPRuZNrlmuYqHx9d6q5vL+CxbiPUYymVUGNFjBxvy51Tla8e9ouDgL
         Enxa/P77uaxuBTuNBYZ0EqMWsR8KzjvZn81JY/oS7FRXeWDpe7ZbL/BX+pWBDjMXd3j8
         diMA==
X-Forwarded-Encrypted: i=1; AJvYcCVLmsLeS21ecaZRA5+izz6KyG0ePzYr9oEBNw8AjLhNXcbLhmFISmOATRlcKnYr5QfJ4oA=@vger.kernel.org, AJvYcCWTpo8wj/J8bQ+weRTQmZKn7aYBXxWp0ytiP6sgLTfjGyWnYWYTVrXgECN3s+Dx0LZZkzpKv0Yu@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7bg1rn0BxUB1ekT4OMAOHu1lIgCdwwk/gq0yee4aE4mFyzXb
	dwuXRijgUMzF5XESRBAV4a9MyklO/ywOm+LscyFoq/4xLMf5o/CZ
X-Gm-Gg: ASbGnctlLdpZEdygW7B+O5yA49+b3L+6cgxR0xSuP3jBtXZ3C/AtanMo+a7WhRPz+8C
	rcg/aEKkx0AcHm23hUQdesTvn/zqCNeoIxHUwW4fTW6zWaelpeExQ5P7Mp/EPLqYhUXfRVWxCP+
	lQSB8gc49mveCt75fHg372t+KA4KOxOJfbhsL1rRQIPHIC+EuTb+z5FyXDOvhVlbz8U42gcVRXY
	vNvvd2sVD37gwRIkpZ14EHJQiElfDqvqQs4GTbW+59jEQE8ELekLjwJA/TckcKKANaPL9T3FesV
	X0PjsdV4xpFlPXQKh2KrHckzXmx3eg2CjJT47j0Hrx2ncT+5P8ifwVgIBJOGfVo=
X-Google-Smtp-Source: AGHT+IEzfTP6e7BsDbgjYLelJWpkbHSyLs7zxIwYTkHXIUUbF/bu5X7J+NQEzw4zK4jrH+2arL3qOA==
X-Received: by 2002:a05:622a:510c:b0:467:75c3:89a8 with SMTP id d75a77b69052e-470281901c5mr110461901cf.14.1738858438688;
        Thu, 06 Feb 2025 08:13:58 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492a8ab2sm6692281cf.32.2025.02.06.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:13:57 -0800 (PST)
Date: Thu, 06 Feb 2025 11:13:57 -0500
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
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67a4dfc57da27_206444294ab@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDvCrfE+Xs3ywTA35pvR_NyFyXLihyAuFFZBA4aHmiZBg@mail.gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-6-kerneljasonxing@gmail.com>
 <67a384ea2d547_14e0832942c@willemb.c.googlers.com.notmuch>
 <CAL+tcoDvCrfE+Xs3ywTA35pvR_NyFyXLihyAuFFZBA4aHmiZBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
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
> On Wed, Feb 5, 2025 at 11:34=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > No functional changes here, only add skb_enable_app_tstamp() to tes=
t
> > > if the orig_skb matches the usage of application SO_TIMESTAMPING
> > > or its bpf extension. And it's good to support two modes in
> > > parallel later in this series.
> > >
> > > Also, this patch deliberately distinguish the software and
> > > hardware SCM_TSTAMP_SND timestamp by passing 'sw' parameter in orde=
r
> > > to avoid such a case where hardware may go wrong and pass a NULL
> > > hwstamps, which is even though unlikely to happen. If it really
> > > happens, bpf prog will finally consider it as a software timestamp.=

> > > It will be hardly recognized. Let's make the timestamping part
> > > more robust.
> >
> > Disagree. Don't add a crutch that has not shown to be necessary for
> > all this time.
> >
> > Just infer hw from hwtstamps !=3D NULL.
> =

> I can surely modify this part as you said, but may I ask why? I cannot
> find a good reason to absolutely trust the hardware behaviour. If that
> corner case happens, it would be very hard to trace the root cause...

A NULL pointer exception is easy to find.

It's not a hardware bug, but a driver bug. Given the small number of
drivers implementing this API, it could even be found through code
inspection.

As a general rule of thumb we don't add protection mechanisms to paper
over bugs elsewhere in the kernel. But detect and fix the bugs. An
exception to the general rule is when buggy code is hard to find. That
is not the case here.

