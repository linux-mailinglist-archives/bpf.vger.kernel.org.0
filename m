Return-Path: <bpf+bounces-30757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763C18D226C
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DFD281AD6
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A542174ED0;
	Tue, 28 May 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mok5sHVq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B97D07D;
	Tue, 28 May 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917079; cv=none; b=maui89gzaBihvKVQ6LZnStWFRMiu83n9P54orIOdWUYsTTH0YKEmSX6l/VC0zqfsieFE6MX/n81L/fjIZGOQbkKSBgAFzAKXycrkCCbqFWqzGmjsjKWBtLnyJ5Jmt72uuQVrmDEXTcOJopF99XdNOK+aBmm1htpdigbDrNHDwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917079; c=relaxed/simple;
	bh=JpfOrfm/RN6ZNydj18l4u8gIZn6ywPDO/Ii8ISAxU9g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JNeIB/LRvk4rimzHQwPK34YoX9IBUPra9/atBWDSAVQ8/6Xh6oKdlz0Qoxu69Ay9r8gK+VdniCwq9v0uZp9mzKsIQ1rfH40AMrvt7AyeYXhMhUq2t22tKXXpW2ZC/93Lc9Gbmd3K5jfpHFkwIVTLSitJ9sBhiZVJtEKSUjr90RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mok5sHVq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43fb094da40so297991cf.0;
        Tue, 28 May 2024 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716917076; x=1717521876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThOVm46gYp9/Cn7ASNZ0mQAfmQpKcIWWQc+98ymb318=;
        b=Mok5sHVqgQRDScxstnDJJladEh+s+Hgi9F7K+UcKsm4+c0CCtlAIvVaB7mlH6MljXl
         GRH7ISpBI6cRao3nrXJWUgPdGuIFjGZgde9OZBMsbsaCFyp7gxvT8Wl7m77Iu4pIxfWS
         5yUnOPJOuQdjnHv99FTPV09R5QBaxMEWPjaSTnPS7blSvmOi/dscHTG7Rfk8w6CGPzle
         sHEqEDXufY09efL5D2AY0PWUJLzl1kohW3AVZE1/TL4cZ8g/1Rw+w8eWDTDpMLdxTPK5
         3v0q1m3XphWnS3oar5UxG74fEMF2ink+suib3w5dURhqJ1cj/1UPfWodF7kbnNaGOi1l
         TVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716917076; x=1717521876;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ThOVm46gYp9/Cn7ASNZ0mQAfmQpKcIWWQc+98ymb318=;
        b=rnku5NdqDYxdA86Eda/FR7n9q2pnN26rW9QbJQfagdF9KUcbi2rYiGw9ITbpjOUp8M
         0x/S3nQAYLSPH2EPzS/ABvvLv5Mk2dQByX0Ov8a9pFjbJgIL85xAAqvSlwtj0nfsJ7aW
         UI6jugaiaSS+tGWSUUmmHEd8HiOywDRI7so/JRfuUEednmS6c42Pgc6S0a1E1RmU4QsR
         dauQZ7mNKCs3XF8L3Rcqbis01/6biri06fnREf9bk+dB68elrcsGqQblWmz498nCzBoj
         EpFUrfRlmnR+DMwk3Up8vZHb/qQR4liS6Mcc4cgLU3htOLy19PHM0ksVPoutdCUImm+V
         g63Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4EQnptR0KGOKDvepvOK0RsvKKbknRtyh1aiMK3ZnL+inlshb1cKu4Ixfg+J+xhuIzUzvCr+DYqYBGP4XuhxAHsjq3kcJ7vQmegjJbFsT8bIYJNBdRC2bxQ7WSuicc4Nw23bv25MQAECm2i2BUaKfs+IrBy4hwgs4q
X-Gm-Message-State: AOJu0YytZaukA/uvgOBVqgptJGCkvrDQp9+VwtpEIgYf4pukgb9v0kgr
	KPlUuLIIzi71aRN6to1XEdXj4wqfLvh2lIAP9BFwbKjiJgyz6nBu
X-Google-Smtp-Source: AGHT+IHmE7KwWW/A6BnWKuk+2M8Ye5aS8UEuzeJBkO8gGRyfB9v09wmMfK5BrpYl8vMuNh2Iux6GXg==
X-Received: by 2002:a05:622a:1346:b0:43c:7755:961c with SMTP id d75a77b69052e-43fa7431750mr305065511cf.5.1716917076577;
        Tue, 28 May 2024 10:24:36 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fd54f4a5dsm11821051cf.97.2024.05.28.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 10:24:35 -0700 (PDT)
Date: Tue, 28 May 2024 13:24:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <665613536e82e_2a1fb929437@willemb.c.googlers.com.notmuch>
In-Reply-To: <6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com>
References: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
 <20240509211834.3235191-2-quic_abchauha@quicinc.com>
 <6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com>
Subject: Re: [PATCH bpf-next v8 1/3] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan (ABC) wrote:

> > +static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
> > +						    ktime_t kt, clockid_t clockid)
> > +{
> > +	u8 tstamp_type = SKB_CLOCK_REALTIME;
> > +
> > +	switch (clockid) {
> > +	case CLOCK_REALTIME:
> > +		break;
> > +	case CLOCK_MONOTONIC:
> > +		tstamp_type = SKB_CLOCK_MONOTONIC;
> > +		break;
> > +	default:
> 
> Willem and Martin, I was thinking we should remove this warn_on_once from below line. Some systems also use panic on warn. 
> So i think this might result in unnecessary crashes. 
> 
> Let me know what you think. 
> 
> Logs which are complaining. 
> https://syzkaller.appspot.com/x/log.txt?x=118c3ae8980000

I received reports too. Agreed that we need to fix these reports.

The alternative is to limit sk_clockid to supported ones, by failing
setsockopt SO_TXTIME on an unsupported clock.

That changes established ABI behavior. But I don't see how another
clock can be used in any realistic way anyway.

Putting it out there as an option. It's riskier, but in the end I
believe a better fix than just allowing this state to continue.

A third option would be to not fail the system call, but silently
fall back to CLOCK_REALTIME. Essentially what happens in the datapath
in skb_set_delivery_type_by_clockid now. That is surprising behavior,
we should not do that.

