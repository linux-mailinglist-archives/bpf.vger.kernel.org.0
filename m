Return-Path: <bpf+bounces-55430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C836AA7F11E
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 01:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14871782EF
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 23:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCE522A7F1;
	Mon,  7 Apr 2025 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="oeEvrwgi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00F1547C9
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069179; cv=none; b=QR9XFQ92uVFogzO77Uqbx4We9FvYjbmqDobMZEEpCgtmuw4JEbT89TwF88q5ipBT2M1D95tZ3M87YqSAuhTikmuhS3YVztj/rdKbGezuG398/Xu6AYTvhEId3BmVuZjecScQmlTvLcJ/6SRYeXk9WuEjvMevTmX9u1yiF89RZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069179; c=relaxed/simple;
	bh=3UH7Z7Dq8GEREWQ6P+Sm1ZE59Mnz1DfU7JXq75pFA78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhhiVN7Xhj22SzsdbwUpBf993Q7kf5TFvLSj/7mQtCY3DAyquLKB94nab1QxJqnhQHBsRYRNT1lgDxcMB9FcyOl0bskDyG7mIYI+BxpbfEH+fMIwGzaxzm0ERPwwsKi/Y+gBlnr5ktxHRyXO0nj2y75NWuz6p7nSKKyfX6L2dlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=oeEvrwgi; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f6756513so4390156d6.3
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744069177; x=1744673977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3UH7Z7Dq8GEREWQ6P+Sm1ZE59Mnz1DfU7JXq75pFA78=;
        b=oeEvrwgi59Ho8A6y8nD67HJS+7fjlVyHR8W5RdVNr5cEY9zPHUcQYwntJCSyy+GFhd
         8eF2xpEGzgJiWnoJCMVdBA4sdn8RU2oOX9giCUQtX/sK/5wEr0a5y9tWHtlgJXpJdSYR
         1K25zYDTc5JYd2UzIf+sQF11ZbVoyv/Q+A5gAVp2ToxGwxQ2UPUs+KZDt2jtZrMPrMa3
         PpJadHCCm4zH7bJ7K/WXCo2Op4M0pkWxiyrhQ6M8iRR1RMj0P685Cq9pP5aeaPNqUk/5
         WDm51Ea0aOg2lio7qBXf++yiSsQnDzLXgAjLFXbJvSl2KK+IDjXRNv2+IWWRCqyTCD68
         pCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069177; x=1744673977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UH7Z7Dq8GEREWQ6P+Sm1ZE59Mnz1DfU7JXq75pFA78=;
        b=YDHx82ehdnnVAciwhR3ePM56mBG4Im3jicV2BtCYUz0qLJSR7aVCEu5CkkCSXVKUFg
         n/6Nn4fM4sr/UPm8AUbm4rTR3vQERLer3w3uOvZK1YqlJqzDRHpnr4RPY/lUZel6zv+C
         g4cn9ABBpCngmaGt3TuCmfh+rkj7URXHV2/o4YyhF20jLjM2TSBPATKHL/QYpdAPLndn
         ckS0+FbGH9SJFlIWlcxtxUp3Cj+uZfTv1hL8csHcmPFpw4Ha6kn51QSvNeupn3ZK8kQp
         hKvX0cdGaBW2XWuiAMiSVovFSc8gq/utLKf4T+JMgUWFvl9h6pHtACn4ZSrJMwG+P9xm
         kb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcSrRMU6dp1jlhFd3ONrwF8JCgQ2a12Da/PQiueXO7BMdaQQ3RzrRpzTCsUcmky22JYfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxud5UlzEaEWvByB4V8KdD69sfkR/7Lq3Py29t9hGCRYPL/EO/9
	vvMZ+fs6ZOPP6q4pM1e9F01gYu3VuOAENUDnk94LQqQObA+seH/RO3YrLLbjAIPlaXCwaZJqECJ
	opXzc41euMt9bE9FZB25zXgiS6sUxjOPnTZGmSg==
X-Gm-Gg: ASbGnctcKgDNA0LdG+6SPNtZ6phzYF0PQ1XwYhz1ENOyGjPkhmTJATWUmhrFK/+b+ke
	GorsrzmECdxFAhuvRxEGRQDReKrg6od6J1WagABFnHFEjLjgKLljdW+sLplGG+8C/YXNYmz5ofg
	B+TPZbgW2390+Fwb+zEcKqY4WwXzl3pjiIszOeLWVB0+ldOkTtFiMVHoK4lQ==
X-Google-Smtp-Source: AGHT+IHc42AQVEkUwmZmXJGyXnkAedrIOrsc4+/x3i8NlRUwiXXfJffVYHjAOYvbfVZebfi+P4uO9GfeMWy1QYlRqng=
X-Received: by 2002:a05:620a:444e:b0:7c5:ac1b:83a7 with SMTP id
 af79cd13be357-7c774dc30eemr752344585a.12.1744069176967; Mon, 07 Apr 2025
 16:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404220221.1665428-1-jordan@jrife.io> <20250404220221.1665428-3-jordan@jrife.io>
 <58bfc722-5dc4-4119-9c5c-49fb6b3da6cd@linux.dev>
In-Reply-To: <58bfc722-5dc4-4119-9c5c-49fb6b3da6cd@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Mon, 7 Apr 2025 16:39:25 -0700
X-Gm-Features: ATxdqUF9MoPCdK8Xa8UMGrgTqCHK5hhzVuewwPy99zP09jIB_-XAntGwFXLlzCw
Message-ID: <CABi4-oiXH+H=6=LaajcQK5faqDn20tUQ86cTJXF0Om-zcxNSUQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> nit. It is to get the first entry? May be directly do
> hlist_entry_safe(hslot2->head.first, ... ) instead.

Sure, I can change this and drop the RFC tag for the next iteration of
this series.

> My understanding is that it may or may not batch something newer than the last
> stop(). This behavior should be similar to the current offset approach also. I
> think it is fine. The similar situation is true for the next bucket anyway.

Assuming it's rare that the first unvisited socket disappears between
stop and start, which seems like a reasonable assumption, you should
generally only need to scan through the list once to find that socket
(similar amount of work to offset). Worst case is if every socket from
last time is no longer there. Then you'd end up scanning through the
full list end_cookie - find_cookie times. And yeah, I think the
iterator shouldn't really care if new sockets are seen or not as long
as you see all sockets that were there when you started iterating.

-Jordan

