Return-Path: <bpf+bounces-55422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5FA7E922
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 19:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0364816B87F
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5451217679;
	Mon,  7 Apr 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYNIzgXN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363329B0;
	Mon,  7 Apr 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048514; cv=none; b=kHElpm7rOz/toR+AkGwLGVdW33CpqjB34kc5/hL83dx0xxV2PaS2V/nwySKjnGkiMcZFFOMUtGnLGxTCaNpHhi8f3E/3rXd620YyBcGwEHqLfc5ZuBzuYzbQp/lO8hOF6PYICA9HF51hBznz37AwCnoyV2XDcTZ04C1TWwyEn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048514; c=relaxed/simple;
	bh=IokFVuqboAi7jAfZA/uYxeQSxzosfAkLF9EZNJBrUic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY93hhjOMIvOCRHhYv336x+yp41YlsNNSV9U1tFt5qYKdfc5pCNtEZYBBVQ+z8/qnuYSCIiUM5fqRt5fBWxmBaQCb4mJRj7S2RW6ummoHrMteWWAwDq6AXmYkDgwzc3JWbzlYP13rGSxGbhcMLktipzwMe7ORdfCo4hIdkGUP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYNIzgXN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3996af42857so3684522f8f.0;
        Mon, 07 Apr 2025 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744048511; x=1744653311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IokFVuqboAi7jAfZA/uYxeQSxzosfAkLF9EZNJBrUic=;
        b=OYNIzgXNcuR1HwpeonP7UWTJTzEuRDxxtRvlBSutgFI4vX94m4sbjfWrXihKGgG2gv
         iz6/3ZPPBVMSxVnaBlYdBZVZSxHredQ9vyfBWS1U+YnW4WeI5xcUyoJ5Jg2EwEWwXS+X
         k/nvpnCy/zplpLHuHEtf3XYQAKkINYJ7DMUpsqCUYJ/hXgC2Wlbp2xsvDoGEmOOmCrzH
         IW9eLPgvMk5LeH5918DXJmutzHkYLJKOJ1OkUkO+5H8m/39bQobRE2mXRtxquMQxSdf9
         o17/sBAJS9TXnnlKZYpzF20Zv04BsDATVBEKK4ZVcDWVtsk6sVsAej0WJYefwITbx98O
         CUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744048511; x=1744653311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IokFVuqboAi7jAfZA/uYxeQSxzosfAkLF9EZNJBrUic=;
        b=GJVaFZTl9Pt8n6t/pFXsWqQUYpYGl/YoUFEW9ilEuw4OpmLxbbU2QJfUfbrePn6fzY
         egeP8tCp31l9bg0oLaBWipHAL6zZznui3rtEJGGEZW4F8X6Mj+s+oALnO/2zoF/0gpsw
         Z7uJlFRpgJt/1phy4bZMBF4Z/yDA7dx23V/YYN+fy1hl92GAQksinXevS7bGCnX5u84r
         yOBECoEZFyKDp1w+GVgum1bY0CU+T/pQplhtGfYUlRFnzbuItnwlSdY5C9kUc//oobKy
         JvN+z0E9xi8U44MmfLZp03Oih1x8QTiL3RCnCiHZfpzdDfO3Cut0v5QGALjX5KJ6mzki
         c6nw==
X-Forwarded-Encrypted: i=1; AJvYcCVJMphEJIGaX5dbYA3YBmZQXfzNbHhorVnCiYlIXzgBVtaxagpiXpbl6LKgelAgDnTMKnw=@vger.kernel.org, AJvYcCWvN0gy1HhSmyAfhxduwp2phaWvgUiEP9lczE/BGar4qU2nU6OPVssmLbCfsM8sxx3IXGH3H1cW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywki1LBsr3MiZXaH++CqEH26LSAnGJHPJh+bmHRxJ7CaSEkp4mi
	0VjjUxnZ1+pmmOE0jgClmCwQy3/WXn9NHbq8P/w6C7qmcc54rsQyKXgrN4nJzkHqQ52UVzTgXQi
	BYDByeH8vMPmW3JzdKXpqzYnkbSg=
X-Gm-Gg: ASbGncuTdnb3Bc/h1P1JNzNsOrvqeGU0hw1Rg0/JaV0Bw/+wRae+IBrLnaZ5SM5KH6s
	iBxgez7e48OatZ8/7DVS7OMJH+z7HUktBF2Usmsrd75XGGf6aSTeH5sGxjl9Smmyjay242Ja4zp
	5f2AYmT23cRoiIhYcRuIUYJ4l6qNHsJWtl9PFKrsrDYg==
X-Google-Smtp-Source: AGHT+IFyjR64noMyvGGKK2TuLftbzKzawJ0Tir4/Sb2cX6TKI7J4QmPAOW4gWadkYc7QvfHSSKOd29x+2p0wi4Tmf04=
X-Received: by 2002:a05:6000:250c:b0:39c:2673:4f10 with SMTP id
 ffacd0b85a97d-39d820f7cedmr315386f8f.23.1744048510787; Mon, 07 Apr 2025
 10:55:10 -0700 (PDT)
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
In-Reply-To: <85eefdd9-ec5d-4113-8a50-5d9ea11c8bf5@uliege.be>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Apr 2025 10:54:59 -0700
X-Gm-Features: ATxdqUEMaopkjv57wxPJua31mzrRIGRtGNjt-a65BpIWjmluWqQvBwYYHnFSwEo
Message-ID: <CAADnVQK7vNPbMS7T9TUOW7s6HNbfr4H8CWbjPgVXW7xa+ybPsw@mail.gmail.com>
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 1:59=E2=80=AFAM Justin Iurman <justin.iurman@uliege.=
be> wrote:
>
> On 4/4/25 16:19, Sebastian Sewior wrote:
> > Alexei, thank you for the Cc.
> >
> > On 2025-04-03 13:35:10 [-0700], Alexei Starovoitov wrote:
> >> Stating the obvious...
> >> Sebastian did a lot of work removing preempt_disable from the networki=
ng
> >> stack.
> >> We're certainly not adding them back.
> >> This patch is no go.
> >
> > While looking through the code, it looks as if lwtunnel_xmit() lacks a
> > local_bh_disable().
>
> Thanks Sebastian for the confirmation, as the initial idea was to use
> local_bh_disable() as well. Then I thought preempt_disable() would be
> enough in this context, but I didn't realize you made efforts to remove
> it from the networking stack.
>
> @Alexei, just to clarify: would you ACK this patch if we do
> s/preempt_{disable|enable}()/local_bh_{disable|enable}()/g ?

You need to think it through and not sprinkle local_bh_disable in
every lwt related function.
Like lwtunnel_input should be running with bh disabled already.

I don't remember the exact conditions where bh is disabled in xmit path.

