Return-Path: <bpf+bounces-30783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D5E8D2593
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D87EB29073
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F11327E5;
	Tue, 28 May 2024 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udwr7C96"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E54436E;
	Tue, 28 May 2024 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927305; cv=none; b=qdHw9LKq1w+yrQwrRK+5QW1LkN12sR9BI+ck+aKwmXzffqJqXDwaKmfi/tlbz5eK7fbHDC0bE4pc9UCxxotKS8H4XG9Up46By5Ig93kk7hBq9wgcTZT0Ggri0BC4p9CnrPrgGvXpVUJHG9qYe3hZJMMUeEZKP7jiYg8gvyHuSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927305; c=relaxed/simple;
	bh=Ww63LNVa/9EgcImn2nPJnwWoRot9McIJIb3F+xFHf6Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AK4M3/Pk7J6RnC1/R6P4X+ZuoJu/VKguwgpdTf7wN5sby8xYDypXgngBiGmHyijKbOhS/YQgloo2fAM03qUepZlnA6gnzvAHyjoS/ID9/poyohUz7Cx9jb0WVZsMWt5vgF7FbPwjbhAa3x/QHP7VjITwPSeiVesNHPt6PUI0lwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udwr7C96; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7930531494aso77386485a.0;
        Tue, 28 May 2024 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716927302; x=1717532102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH0wQ9r97BfdF2raB0yjdWqZJVerj3rir1vzaUG1Zw0=;
        b=Udwr7C96D/mwQIX5+6NKMJRD4uEjyGnbgD83Ck1BjGKKFpXlh4reemn8sNeAWvbra9
         nsiqXQ6xCOyUhU/rGmlKC9wMHMAjiRd2879dLrXAPxL+vmKAuzVrI1KsNWdTjvmUOksb
         lr5tNGXORXisJpwFTLLJ4NlBKWzTTYKTLwZFu/eM2Bds4VR/xnKN47YN1jhmKPXj1Dqf
         TFpkRS0OMr28MpJT6Ynd9GX3Xr3FzeC2VhHo5r7JzMAXGvwCeh40ryP9M4t9/l1CLc8g
         YPPi/jaNeTVGbtJNahRJ3TRPCFddEK1rBtQnb+w2TBrzVVcGFnS/t6jjgYMARrNWLSye
         7wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716927302; x=1717532102;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CH0wQ9r97BfdF2raB0yjdWqZJVerj3rir1vzaUG1Zw0=;
        b=mlXrDVh+I1mf2RWlktyA+URcDZFrhFK4t7bSF2nGXe6SB3ad0JNw2ka26TGBwRcqgk
         RFYKeOmxGRdcvD5msu2Q6FTviCOByAyKIRIFeCXUNdaXnDApXGYXssONhh+5SbZykRcZ
         HGhOBN08augGVEd24RjkgFZKs82vT8OtR/kUHSAdnC8pDSwmvlUF7mNOCw4f68lxH3S+
         Lzh+d0dohgXr7NPUyGq44+QxQ/yj21D1nf3PNi5YbVI/iSaLcPhufHjIsuHsP+shwXhn
         h4+1+RL2uiMV3yefMw94edv0JwEEy6PPPkzyJkWbSiV8d6MuDVBe0ZVlf+YyLPBlKYdG
         d6tg==
X-Forwarded-Encrypted: i=1; AJvYcCWcHKLXsjDye6SqB9baJhruhp7CvIdhqn2DFlM/G6gRe+L6lgvG8Xy4GlFuZ97t4SZD4pURSuKJ4FJRGCcmSdqfhr/C6fYl2DGXGS3gPXEiPRcdXDwl3ZMQ0nm5JoMYyDjCu43ifTm2DICPPSrEqtICJZHUtYn9ujWC
X-Gm-Message-State: AOJu0Yxj8kXp0O5uw5L1RvgjF/G00Ph3MDcc8bD/EMolVqQ5wxfUfMYz
	uif+4bT+5q+nnpvq31X7LsftGz+AXo3jjZgIsQbrxKyzZStWm4qB
X-Google-Smtp-Source: AGHT+IHeQanWgf4ig45uY5skreuulB1NOG86mOTKFIcZpBR6Brl5hBeAxPuofmYXZwVvDsMiX9USdw==
X-Received: by 2002:a05:6214:4413:b0:6ad:835f:940c with SMTP id 6a1803df08f44-6ad835f9555mr54075486d6.50.1716927302391;
        Tue, 28 May 2024 13:15:02 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac071048a3sm47017696d6.69.2024.05.28.13.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:15:01 -0700 (PDT)
Date: Tue, 28 May 2024 16:15:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Message-ID: <66563b459e5de_2a7f7e2949d@willemb.c.googlers.com.notmuch>
In-Reply-To: <d1c18889-ef48-4cb8-8b81-474b3b7ddd81@linux.dev>
References: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
 <20240509211834.3235191-2-quic_abchauha@quicinc.com>
 <6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com>
 <665613536e82e_2a1fb929437@willemb.c.googlers.com.notmuch>
 <d1c18889-ef48-4cb8-8b81-474b3b7ddd81@linux.dev>
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

Martin KaFai Lau wrote:
> On 5/28/24 10:24 AM, Willem de Bruijn wrote:
> > Abhishek Chauhan (ABC) wrote:
> > 
> >>> +static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
> >>> +						    ktime_t kt, clockid_t clockid)
> >>> +{
> >>> +	u8 tstamp_type = SKB_CLOCK_REALTIME;
> >>> +
> >>> +	switch (clockid) {
> >>> +	case CLOCK_REALTIME:
> >>> +		break;
> >>> +	case CLOCK_MONOTONIC:
> >>> +		tstamp_type = SKB_CLOCK_MONOTONIC;
> >>> +		break;
> >>> +	default:
> >>
> >> Willem and Martin, I was thinking we should remove this warn_on_once from below line. Some systems also use panic on warn.
> >> So i think this might result in unnecessary crashes.
> >>
> >> Let me know what you think.
> >>
> >> Logs which are complaining.
> >> https://syzkaller.appspot.com/x/log.txt?x=118c3ae8980000
> > 
> > I received reports too. Agreed that we need to fix these reports.
> > 
> > The alternative is to limit sk_clockid to supported ones, by failing
> > setsockopt SO_TXTIME on an unsupported clock.
> > 
> > That changes established ABI behavior. But I don't see how another
> > clock can be used in any realistic way anyway.
> > 
> > Putting it out there as an option. It's riskier, but in the end I
> > believe a better fix than just allowing this state to continue.
> 
> Failing early would be my preference also. The current ABI is arguably at least 
> confusing (if not broken) considering other clockid is silently ignored by the 
> kernel.
>
> > 
> > A third option would be to not fail the system call, but silently
> > fall back to CLOCK_REALTIME. Essentially what happens in the datapath
> > in skb_set_delivery_type_by_clockid now. That is surprising behavior,
> > we should not do that.
> 
> Not sure if it makes sense to go back to this option only after there is 
> breakage report with a legit usage?

Agreed. We cannot break users. But I don't see how there are real
users for the current permissive API.



