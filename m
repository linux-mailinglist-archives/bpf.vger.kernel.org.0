Return-Path: <bpf+bounces-26876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0548A5CDE
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 23:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B301C21777
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138E9156F33;
	Mon, 15 Apr 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIRAVJFr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E6823CE;
	Mon, 15 Apr 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216142; cv=none; b=SjP4kStnOuycC/8Dfo85uX5OmCGUJGhgs2YpAlEHC8aZb3bBZnuLW2mZ7WMjo7/ustnGfhGaeedjB1jIhjscVlzK5EeJLqk7KDAG00KfQgQjxwqg9YgEMovQ+qonHLHOiZpqx6b6peObas2AlM8WgY5KCDY7VBTuLCKtuRfGOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216142; c=relaxed/simple;
	bh=EREZQb+u2szcZMx5S4Ie0IWruozZBPGORbAKizIkkjU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RF6ou+d/eCBYuxphbDizVqRRgLZa7hpq3aB8o4Mfk5yEZM+d98JryOowCGMZDNMwRBZDGeo6aDPNmvR4CCnkCq1PZeMx0gMlcvzoHrwMIIlgkNha2scSKuPQEuHhnQXxdfAeReACrq8BkJRFqguruPctfaqZnC7dLc5WxhhYXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIRAVJFr; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6eb8ea5ac95so127761a34.2;
        Mon, 15 Apr 2024 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713216140; x=1713820940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hW7xHZ+4MaleahcyQ0/yF2Di1GH718P8fg7DUap22k=;
        b=EIRAVJFrovQZPKG9hPUC9gBqKE5kg+4yfd1ruaZWhSthhPj6sMTXaxm8TLCFsIX0Yb
         3VQafB552iM6EFxfkg0XWK38sOIgQlfzqfWe1187uz5K++vgKeyoXKF42SkLqR+EQqTx
         UkTf/2EdlfSnC8+amDORMprdZnuiDkWarIzAffOVzoSM3yWQINDVTU9MQwOt5EvP8xch
         GIU9K4Odq5BIMZ27jyczKUPup4mhozG3tlYZD+g73q6JgbAML5KFtURyLalbHothuRac
         mzjOTMMjtLGYowXWNBkPbqXD1xd2pJkG83prnbj7YEo3h9K+UeQ0vrmTY8+2K1LlSiOx
         q8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216140; x=1713820940;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9hW7xHZ+4MaleahcyQ0/yF2Di1GH718P8fg7DUap22k=;
        b=WZiAvcBzr5vcfB1aZv+bDZqoiJPJ4YdhQDtUeY5czGF8tGelJgspHwQlP3dPhq0oEp
         JoEI7ej/K6IRu2aZ7YU7diSS1Vvl4QrScG8devUQUceAoWMDaRWMj7aTwhbI3hSIqNfQ
         uGxrPghhcFKrWHsUZSo0ZLIT6g0odpkVpMWz8ryy64nNpXXafNtqtdsdlBMkppi2eOR/
         wsOvS3wowkkb1/DpGLpWMNeP6dB5YHbxWZoSmEWSdoipJpOWghGTMC3waxV0poNN/6zT
         3RduRR2xpv/2izGrV843IQfaOfY3k5xhhsZN/bzxC9YIqZJ+37oHa1VSlkRs5rbBqSiJ
         6YpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGt99hKD5kmRuJuwjyycVxz7XbmvbSK3I6arkLeXaNB9wCat1VZtj/sWpOXfyQ94yvojuogGIIAJUaW4fmls17zvSVBQBDNFtCmSlwRAuSzsLFbkvSS+dmM23qkM4Vmx6rG/+8Ar6ZnXSZM6S2LZ8c7B+lYoeSXCSp
X-Gm-Message-State: AOJu0YwlKk5vg7PTOQO6zTKvGqrVzCt+wjXVbavKzxxainzuob/kwt2o
	jKdgU5NTMCDt7RVUHRheZGIkw4eCVtUhgoYgnw9Rr9YGmC4ONlOo
X-Google-Smtp-Source: AGHT+IF8u69eFhS3xy24WXWrPQyIFW+czruOl0/HOjx8mzpgYL8Nbbiw+coZaPpf4n68k/ghNFrXoQ==
X-Received: by 2002:a05:6830:2648:b0:6eb:79fe:893 with SMTP id f8-20020a056830264800b006eb79fe0893mr5410416otu.2.1713216140472;
        Mon, 15 Apr 2024 14:22:20 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b0078d69b5d671sm6824189qkp.100.2024.04.15.14.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:22:20 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:22:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <661d9a8bb862c_314dd2942c@willemb.c.googlers.com.notmuch>
In-Reply-To: <6bfee126-36f4-4595-950e-058d93303362@quicinc.com>
References: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
 <20240412210125.1780574-2-quic_abchauha@quicinc.com>
 <661ad4f0e3766_3be9a7294a1@willemb.c.googlers.com.notmuch>
 <c992e03b-eee5-471a-9002-f35bdfa1be2d@quicinc.com>
 <661d92391de45_30101294f2@willemb.c.googlers.com.notmuch>
 <6bfee126-36f4-4595-950e-058d93303362@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] net: Rename mono_delivery_time to
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

> >>>>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> >>>> -					 bool mono)
> >>>> +					  u8 tstamp_type)
> >>>>  {
> >>>>  	skb->tstamp = kt;
> >>>> -	skb->mono_delivery_time = kt && mono;
> >>>> +
> >>>> +	switch (tstamp_type) {
> >>>> +	case CLOCK_REAL:
> >>>> +		skb->tstamp_type = CLOCK_REAL;
> >>>> +		break;
> >>>> +	case CLOCK_MONO:
> >>>> +		skb->tstamp_type = kt && tstamp_type;
> >>>> +		break;
> >>>> +	}
> >>>
> >>> Technically this leaves the tstamp_type undefined if (skb, 0, CLOCK_REAL)
> >> Do you think i should be checking for valid value of tstamp before setting the tstamp_type ? Only then set it. 
> > 
> > A kt of 0 is interpreted as resetting the type. That should probably
> > be maintained.
> > 
> > For SO_TIMESTAMPING, a mono delivery time of 0 does have some meaning.
> > In __sock_recv_timestamp:
> > 
> >         /* Race occurred between timestamp enabling and packet
> >            receiving.  Fill in the current time for now. */
> >         if (need_software_tstamp && skb->tstamp == 0) {
> >                 __net_timestamp(skb);
> >                 false_tstamp = 1;
> >         }
> 
> Well in that case the above logic still resets the tstamp and sets the tstamp_type to CLOCK_REAL(value 0). 
> Anyway the tstamp_type will be 0 to begin with. 
> The logic is still inline with previous implementation, because previously if kt was 0 then kt && mono sets the tstamp_type (previously called as mono_delivery_time) to 0 (i.e SKB_CLOCK_REAL). 

Sorry, I got my defaults confused. If we maintain that a zero tstamp
resets the type, then here should be no case with skb->tstamp 0 and
skb->tstamp_type SKB_CLOCK_REAL (or SKB_CLOCK_TAI or whatever). I
think it's preferable to make that obvious in the
skb_set_delivery_time implementation, rather than depend on knowledge
of its callers.

