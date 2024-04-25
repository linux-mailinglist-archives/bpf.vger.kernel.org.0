Return-Path: <bpf+bounces-27789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F24C8B1AF9
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 08:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11081C21151
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 06:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6505458203;
	Thu, 25 Apr 2024 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gibzYghG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46A40851
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026347; cv=none; b=FPQu8UQENQOY3sXimc2vBRiwjOKfnr5BNlH13jHXgMZJckVqS5Kxye/P6lnvu8rosdmEswo3kAXF0Yw2gGPwjMXivnwEh5FHQwoUEHOxbdZMunPJ8PyipGVpbjeqkh6xIYr8X2+CrwLHGCknQmHwFdOIyAZD6/9kkmDi9r5S8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026347; c=relaxed/simple;
	bh=fERmv0h0RJAlvrw4KpCPifAyBafwLvv6KElMBv4MBUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPtcDB6TudWOs7vzR063mOMhuvTCe1CB7tG/1QBQ+uUxhBSh1yBK5MuqAMF/p6UFUshPvEGsWfH5DYgWOG8zWeFKLOTiVJtqpTxCsWPE32CRoLaSlXTfPA/LbokULgO5DZ2LPRuXBDNOMyYWSmYcsm8L1HbU4B4svRJRsglw9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gibzYghG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a428374b9so32385e9.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 23:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714026343; x=1714631143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fERmv0h0RJAlvrw4KpCPifAyBafwLvv6KElMBv4MBUI=;
        b=gibzYghGRZT6jvsBG5q+6lpIOFw3HkYK/haGv4EJzkI8U+qd5vRCpQnXiOZTYsKjlH
         BA1OYDKMfYJmpCznUKkK3zaa1ZLCcE/aKdmIZQW4pg411rjvtZuoIoyn/pcMECS2eVHR
         /1HY5AMqKsEC+ORcKyyZl9cpEkwCHltjFj8VIDAhOLNiD/zglPF7LDVLBDkqeLkRxN1N
         +JcKBCyO4rAc5BNRs8iX9h9sNihXx7KeBWoGzzP8DIbV+AGt1YNy/nLL5IGJBPw4W3XI
         pOYMuP2YKsS5r+jX4xQnJxIn9CiOMUgOgaJfPoRTFXmjbDzHSgVs/KOHI+Mdb8SLcSGQ
         D0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714026343; x=1714631143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fERmv0h0RJAlvrw4KpCPifAyBafwLvv6KElMBv4MBUI=;
        b=UiJ6hzIYzcRTne4Iuez9ibykj63xA2upmw4xcqhAYxozVWEg5UzsraTJ1YWNdQV1K/
         4qu1AUnDvsIS8MpHER2jw9y5H6KsveSLgbWD2fu5fi3hHw8IyOwblWXGv8vgB0LJj0ej
         wnlmTv/SKoUZ92RekyDRwf2lfiI0zpphqODfEd8RVyW2SXOPJb5JFkpk8PW6kVdIc84w
         uuN38As2HTyYdvH1U3ClrNZQ3dQ6vV0tv073V7SAsJrEnQXzp/LDgU7FQbMQKf1WDBs+
         FWH5Wi3MtHSD7cffBmedN+oGN18MrjKnIM+szKskNgAaoweE4xYKWEcwLjCugvz6BfiO
         Yb5w==
X-Forwarded-Encrypted: i=1; AJvYcCXuBE8DBd+KwSf9uzyiM2HBIii5WEUG1fmebM4u4EInXjH8e1xrXU/lLmMb7WyXp0j85bS7L0RtsvT3MSUBLBGY8ckR
X-Gm-Message-State: AOJu0YxeUGKgLR8+nCJsXKAKDsZLrK/JA6DCjoUVfiMVZBrUHqoJhaNM
	WayQVPJ6xywcuUva/SKtVCun+3le/xi8PaDJ9cgHus6WUH+vSCJoJrPI3lOoAf9YEmnWH9Up7DB
	VsFT3KUfoIaCestgE1WVEbqnYeT358rBk9uz3
X-Google-Smtp-Source: AGHT+IF1G3uXYrQJS8plmR3swSNBwsdSuwXomI5kcLCqeYJhHkrTotLf1d0aNtMmNpM6GMfu+gp85O2SKoW2VCGr2HI=
X-Received: by 2002:a05:600c:1ca3:b0:418:cef2:7575 with SMTP id
 k35-20020a05600c1ca300b00418cef27575mr127025wms.0.1714026342462; Wed, 24 Apr
 2024 23:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421042009.28046-1-lulie@linux.alibaba.com> <20240421042009.28046-3-lulie@linux.alibaba.com>
In-Reply-To: <20240421042009.28046-3-lulie@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 08:25:31 +0200
Message-ID: <CANn89iJb2XkPwYfjJnhfU5pvf_jjD-xw5WuzDom8GP+t5nzyMw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: update sacked after tracepoint in __tcp_retransmit_skb
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	xuanzhuo@linux.alibaba.com, fred.cc@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 6:20=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Marking TCP_SKB_CB(skb)->sacked with TCPCB_EVER_RETRANS after the
> traceopint (trace_tcp_retransmit_skb), then we can get the
> retransmission efficiency by counting skbs w/ and w/o TCPCB_EVER_RETRANS
> mark in this tracepoint.
>
> We have discussed to achieve this with BPF_SOCK_OPS in [0], and using
> tracepoint is thought to be a better solution.
>
> [0]
> https://lore.kernel.org/all/20240417124622.35333-1-lulie@linux.alibaba.co=
m/
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

