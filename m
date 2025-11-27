Return-Path: <bpf+bounces-75641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165EC8E6BD
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 14:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A383AC8FD
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D1269AE9;
	Thu, 27 Nov 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7+IgnCf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8B1D63F7
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249569; cv=none; b=M0HUl1JvfBx33OLVx5y4SP18JMBCODSQWxQRbLXfFqRxtw8kRdT7r4sE/XoTldKZTzV75+z4HTb6+iz/SKQ/JX8AVu4+xL0Gvc+9Qh1GjHk23JMJow5c1J/xKOshQNAHv/DEdrfLGQ4foQNrcTrwtCbDbinkWwNYo2ckAlLjuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249569; c=relaxed/simple;
	bh=ED9Iw7nQWKNLvI4J4Zwk2uO1v5iCGTYPUwXUk54PHHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mio9hNfgnXCBvwRztMIUPYC8nMN6xy9viatm6NddBPCk2gAaAz/ZJkg+HZWC8pGf3X7ai8Y82ycMlCJDCwfNQShyPo0QZFFrOR5s2w9/q1tBoF+IEFrCy2Av+x6zkysRZtolKscnpuoNHfDbGu1yJM0ERcqiikDGMiTKeswsB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7+IgnCf; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-433791d45f5so4418575ab.0
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 05:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764249567; x=1764854367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCzBPQmriWwNoC+w7AkUbAJ2/r1P5CTIHfbguhPRxvQ=;
        b=l7+IgnCfYfQmVA0ahf5SJLwobvYpnoQkOcwXSSzYeRsycqvDP7fqxQeebT+MISs8xX
         SnZcoadmhxmFZ0fbPF6NHIqhs61D4Hs76xIdEyjfZt5XyJ6+eTDh+HVwyn/FjcJmddb9
         CmGJ4X8JbmQA1md6DUMLi7B4lMi2eUtGCdeglaUQP/F4j6B3iycfTb/CPYcRXU+qISpG
         /NOFH4vXAzpgTECLeYlw1wQak+FJqGy/hrG7ccBqW513INf4YmjV6f006lBM6Bc2/4ae
         Y1Do9byfisUxR0QEiHko6PC6bXbQochYeG9M1u8U9Rwglpm1OxeywRAcMkJgAZX5jYXV
         9D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764249567; x=1764854367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yCzBPQmriWwNoC+w7AkUbAJ2/r1P5CTIHfbguhPRxvQ=;
        b=YEAIptj3YOGgAVgKez2sG0kd8PeUPX0O+ZN6dr3306HrH1sjN80hb0kWuvxHsAObOj
         YuxJJcLIjBeTbOHclR8+YDV1jVGvJ1PyZwcD6Mgt5yeVM+gn+yBqrKfCv1KCBmXl6h1N
         cmamfu2rWhpDYc7pulGKiwPns5AvHY3UCuyJvfYwDRJBYJHNODu5a+eXowjaYMB/dQ93
         dSmyNiQOnBwiDBpoAbaCUFcwap+9xokc5yl05T3lefc4FIF/jDw3Pcz/bfhs/mpd1rbo
         eYCNqzv9sujPTLFoWNPGAJg79m3B7tVTZy5VX3dpMJRY2kBwCF6IgyF4YJaxtBTVhNQY
         6PAg==
X-Forwarded-Encrypted: i=1; AJvYcCXbQC7Que2X6Utkt/j18zKevNM6yJWY3MolNNBABT1pqorZ6/acrj+t09d1UJF15E+X4IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXOYbCqezoi7hIEC8SWksK1xOc9QXbTPzKVH1GJBIsjnqs+OQ
	ZxHclfDXSndKWhgBIUkc4gopNIiI7fCMTBV5VosjwB4XlOHhrLmgQdLEPhPV7i0BJrPMqhuRf4j
	87XBt44comQRPnTch+0tHR06w1qKX76o=
X-Gm-Gg: ASbGncvXEFMfKWOedatfy9lf+IP7sVhoGZSyPDM0Sf2Ast9bL8ge39Dm5c0ado6JiTe
	OU4Z7sdMVp933nvKafMpZOI6DK0eSrk0qJRbhDPUpiGXFgXzBYC3bqUemAh/Hlc6iPj+e5+bPfW
	eqk/NHhDH9IYwz6jLn9KxZ2O8JWSSDIFaHC8U73FV491NvnWl77ZnMQoJS3WmNXncdROvW5Epvq
	hvbbfHtQ9/ZjV0VZOPYNbq0q4HraDob+nyjeVrJA11XO9aNoejsWUKuhG2yF1TnKVw7bUk=
X-Google-Smtp-Source: AGHT+IE4MPYVosxTC2+EJOGxZIxKrRHl5ytzM1bMPnB4+uDlXJz18MUFbQTwVk2VSGwTUC4TMLDXCCCMKpXrlupsIHw=
X-Received: by 2002:a05:6e02:248f:b0:433:5b75:64d6 with SMTP id
 e9e14a558f8ab-435b98d77f7mr242863045ab.28.1764249566692; Thu, 27 Nov 2025
 05:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
 <20251125085431.4039-4-kerneljasonxing@gmail.com> <4c645223-8c52-40d3-889b-f3cf7fa09f89@redhat.com>
In-Reply-To: <4c645223-8c52-40d3-889b-f3cf7fa09f89@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 27 Nov 2025 21:18:49 +0800
X-Gm-Features: AWmQ_bkKPR_pnFH29-61JqMam70K4G6NNdS95YVbrn36Ae8NT1OjfixQBrvQSp0
Message-ID: <CAL+tcoAQZRNnmwCdaH_TNGSmepx1KO93H-4NmVzoUrNfY7pU6A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] xsk: remove spin lock protection of cached_prod
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 7:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/25/25 9:54 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Remove the spin lock protection along with some functions adjusted.
> >
> > Now cached_prod is fully converted to atomic, which improves the
> > performance by around 5% over different platforms.
>
> I must admit that I'm surprised of the above delta; AFAIK replacing 1to1
> spinlock with atomic should not impact performances measurably, as the
> thread should still see the same contention, and will use the same
> number of atomic operation on the bus.

Interesting point.

>
>
> > @@ -585,11 +574,9 @@ static void xsk_cq_submit_addr_locked(struct xsk_b=
uff_pool *pool,
> >       spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
> >  }
> >
> > -static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > +static void xsk_cq_cached_prod_cancel(struct xsk_buff_pool *pool, u32 =
n)
> >  {
> > -     spin_lock(&pool->cq_cached_prod_lock);
> >       atomic_sub(n, &pool->cq->cached_prod_atomic);
>
> It looks like that the spinlock and the protected data are on different
> structs.
>
> I wild guess/suspect the real gain comes from avoiding touching an
> additional cacheline.
> `struct xsk_queue` size is 48 bytes and such struct is allocated via
> kmalloc. Adding up to 16 bytes there will not change the slub used and
> thus the actual memory usage.
>
> I think that moving the cq_cached* spinlock(s) in xsk_queue should give
> the same gain, with much less code churn. Could you please have a look
> at such option?

I just did some tests and observed the same result as you predicted.
Thanks for the lesson!

Thanks,
Jason

