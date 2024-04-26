Return-Path: <bpf+bounces-27933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CCC8B3BA4
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92491F231D1
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1E514BFA2;
	Fri, 26 Apr 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2p1+m/33"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16207149C73
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145594; cv=none; b=iqZYL1eU8EwuBbaHndvzdYGpxzTDPAP5b9mxY9cAZlBlv5/RxLP/9+gPu66D7DZJbQUXl6Ay/VWwfWJRuhJXJgD1vOHcC/QhpAAPNnfn0C4KWZAGvpKAH3bJ44aRTdt/sXXL4r4PaUpqKxb0++LFH8fvjIYGSqaKPw0+h+xowAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145594; c=relaxed/simple;
	bh=a+x+9QJcOjAjsTEqVdunD6qiMm7jqBNR+SHC13THGg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9T8iEblBG6Y/r9yEVbgcsf2WFGW6zal9jzNZva+dK/VpftYm/t4oZjnBTjNu0OHqC+2IZk2bEbGCZXicUTNjwxtIZooe73MZd3QhTo7SthbRKjimPUGfeGIb2rFwmGa5pkfgF/y5oOhbJhm3kz63Cc9amwycQEWN4lEzYxYOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2p1+m/33; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so14091a12.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714145591; x=1714750391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQAKSfeSiNMwx23jPVYzccmGjENnrcaTmn472bWM+dw=;
        b=2p1+m/33Ca229cGyj8MM8xvQ+TcRFoJ5xMFZZC4LEEYy5EM0ZGUdWs1cOe92gh1e0y
         JgoHocZlnSAN8Uj3vgLz0qJfUFhaScjKB3VJK53KAOhuiJDfYdNDDqqW624fng+DW54+
         Lv3xFHGsu/kK8XBY2VG84oLE7lg9vmFVzoxghp+b9ZEiRDU/yU6BftsY1PUt+qn5tYHw
         LG/hSeeCa/jzquXS+FURC9pnA+7fRnoi9ZIYsTpxKZNbW/vtROvlZ40vKA7Qi1+Nk6z1
         MLUNKpBhqRWA6cpytWhwrbEPR4kP2wsC3XOkkukKVvTTyYJo2GVvkkmQSgEBHwC7Ql3f
         dXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145591; x=1714750391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQAKSfeSiNMwx23jPVYzccmGjENnrcaTmn472bWM+dw=;
        b=fLHHqDd30e737T8355B0RLmlmCDqycVfCVUF0U+nQS+/GWwnDCSF6EDRjGtybpBrop
         SToIQ3grIOl6NSDNvnfcIdBsL8UTxmf5j1NObug8IL1G1X8uRUGI+XY27sBfTJfzl5y9
         sd0GqdVIULnIeiKEnQ5WdVgk9vK033XKC6yC3PZ/gd/a6eW9TRPxvo5SNDfun+cHrnZD
         g4F0SvK0mpx1yxwMZQuTlx7b+mP1ZkYNhEIvxNptLm24AGzSBc4DUGySA0+gAxGgxOoR
         UydiLZuYZDgHiLAvpsT/pXemGhpF8JnGfXXb4dzRMFbx8AxxZOEhgZWaDclqiburuLUX
         w2kw==
X-Forwarded-Encrypted: i=1; AJvYcCWSBNVUr3jozRARUPjQLfcw2jWTCpJVX7iVbwQvhOmaY6DJdImpuuBYyndj/YhEJbTtlZW5DlAMvD7crk25WVi6Aglx
X-Gm-Message-State: AOJu0YzGzcA3xQMOIWlandx8vFAJTjW6EfUtPGlmXaDIZvXGBafFAHv4
	fmEs91oFKFK67jVgTVuf8fuWN/RdBWpsW6gFxceIj/FSVtsFPmX+MxtZKXuBuXoPCwBxhWi3o7x
	fYe30gALhtmOs/wC9bfNuvr6prw8DHgytWz99
X-Google-Smtp-Source: AGHT+IGFBkaX99SfmSYIhlRZCqbmREadhrxpgL9UrFo0Boe2aUlXFOiVrXsSsyd0ZAOJCYWvbdHlbxWVGOxfkpsUpkE=
X-Received: by 2002:aa7:d497:0:b0:572:25e4:26eb with SMTP id
 b23-20020aa7d497000000b0057225e426ebmr146199edr.7.1714145591147; Fri, 26 Apr
 2024 08:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426152011.37069-1-richard120310@gmail.com>
In-Reply-To: <20240426152011.37069-1-richard120310@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 17:32:57 +0200
Message-ID: <CANn89iKenW5SxMGm753z8eawg+7drUz7oZcTR06habjcFmdqVg@mail.gmail.com>
Subject: Re: [PATCH] tcp_bbr: replace lambda expression with bitwise operation
 for bit flip
To: I Hsin Cheng <richard120310@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:20=E2=80=AFPM I Hsin Cheng <richard120310@gmail.c=
om> wrote:
>
> In the origin implementation in function bbr_update_ack_aggregation(),
> we utilize a lambda expression to flip the bit value of
> bbr->extra_acked_win_idx. Since the data type of
> bbr->extra_acked_win_idx is simply a single bit, we are actually trying
> to perform a bit flip operation, under the fact we can simply perform a
> bitwise not operation on bbr->extra_acked_win_idx.
>
> This way we can elimate the need of possible branches which generate by
> the lambda function, they could result in branch misses sometimes.
> Perform a bitwise not operation is more straightforward and wouldn't
> generate branches.
>
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  net/ipv4/tcp_bbr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
> index 146792cd2..75068ba25 100644
> --- a/net/ipv4/tcp_bbr.c
> +++ b/net/ipv4/tcp_bbr.c
> @@ -829,8 +829,7 @@ static void bbr_update_ack_aggregation(struct sock *s=
k,
>                                                 bbr->extra_acked_win_rtts=
 + 1);
>                 if (bbr->extra_acked_win_rtts >=3D bbr_extra_acked_win_rt=
ts) {
>                         bbr->extra_acked_win_rtts =3D 0;
> -                       bbr->extra_acked_win_idx =3D bbr->extra_acked_win=
_idx ?
> -                                                  0 : 1;
> +                       bbr->extra_acked_win_idx =3D ~(bbr->extra_acked_w=
in_idx);
>                         bbr->extra_acked[bbr->extra_acked_win_idx] =3D 0;
>                 }
>         }

Or

bbr->extra_acked_win_idx ^=3D 1;

Note that C compilers generate the same code, for the 3 variants.

They do not generate branches for something simple like this.

