Return-Path: <bpf+bounces-71106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0807BE2C1B
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB7F5E0956
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 10:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEAE111A8;
	Thu, 16 Oct 2025 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W0MCR+wf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4E32861D
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609311; cv=none; b=QslC5Rs6QtN36x7JOfXiGVDRqfR40c3P02RpyHwVg5ZSDaQr47pncAIg+mUD4sSKJ2JsuypbYeA8hGFHQsiwmFodjc9b26BBMSCU/sBL7NdljGl02LZsOLRQVuqptH10OHziy6yGQueJEAxIueTDxaxJ6V4TNsKiaw65fnf+4ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609311; c=relaxed/simple;
	bh=iAG+Qsr3wjzsEn7xPqBjjdvU8mNrEK01RZVMASCmXJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k+KqVJFq3yXR38YD+QNwsn03pXkYW2ewCl8826bGPnZRpGh47RUifNR27042BmqDB7AmXcL6aWs7mEXwbAEdM8JlV6wS6Ml+r2JwvEoiBa4679mcZEZs3TEr3qVXLIYhaiLlF+J6MLyoSQjrn7aGuMPm84UcxbtCaeRY3Ik7dZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W0MCR+wf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b472842981fso70738966b.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760609308; x=1761214108; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAG+Qsr3wjzsEn7xPqBjjdvU8mNrEK01RZVMASCmXJQ=;
        b=W0MCR+wfDbMXdyyRrMKTp1cyLb/OBvi58u0nN3mGGm3x1GsjgovaaeHohmH2fe674L
         suOJEuM/oEB9t/cakVEC66cRGxVwJ+ewZ2Ccoch5BiQUXe1xXdPXGmDTfJZaK1VvFsDX
         tFyXidXglcCFOS3M85JwbUzAeb8MOdm6c3bFauV76tVsI3yhD3mHVIX6GiaFyxaYja37
         6b8ig5ZP2iNRYRhZjArjhMTq6hADzsGnLUx2k+mZrC43gFhj2AklD3w3nd1s7bvjivda
         9ZJP+fYDylEwa7dDYLnGtGNJx7mLO4hBdpMicRjzD3ClnGFwQDfr0vngUg5z5PgMaDAp
         0Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760609308; x=1761214108;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAG+Qsr3wjzsEn7xPqBjjdvU8mNrEK01RZVMASCmXJQ=;
        b=Cn9rU2sXTKxa0go7ItkVLdrkyvI9GZeSsEzwk6uX/jdZ5SOmy3pqzfm9RUWwgTOUxH
         kyVmV9KlKZPDAJkPLyA5RnwT0nTLY/04ho5Pwsp9iua4rBn+ytLGAA7Z2bt076vyZ/Gk
         ngVVR2jhMUB6RKqKr3/URnGEgc33BnaurClLNtdj5kTQ0brTd9fqVvnjIrQtjDRPnLXj
         vk9NCAwEdFg4dkzG4kNDbhpxdgYv7dN1o/CiVhFEkxterHtaK2BXQEv/U8Cry89dct+U
         g6a24ziU1a5Zr/XqeGxd3UR32WykgH2EALIZIwBD22rDZcM9LwxLWyQ1T+Lrddt5LKVf
         5ZdA==
X-Forwarded-Encrypted: i=1; AJvYcCUIfwnZhez8Qno7vJyPfUS/Yjuhho8HaBGpLvIS8/LMyA25yd2l8YxGI/jwKTO77rm9wO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xssAjOAHJCM24z7I94obOU0hGpR2iQ+QwH8wGapFDbD9bNyR
	lux2n6PcKRk3JNceANqluMT7uiWCeGsuKxYidVT5dq32r9c7Ad8t7d8X89cYOyHWy78=
X-Gm-Gg: ASbGncvogJIiVnBZuKe/9q4b17PnFZsHITNxtodS5bOJN6pblTK/5nvLDG6t0B7MqUu
	s39YQPYBazhCK7lkLXJWqJHcLj0nluDJepZcKF00bX9htRzwwoahiQji4PPf2+SyPlG4SG/2xzs
	+ORMFkcf3eiCqDE6PNvtHBIuO7Ah7qqejJ+pnPdrls/8hmwMmBzDb5Q3sJrol8b4CkYTw21BEED
	+RZQ3y79Rh5dodSIaE7LZE+MwykDZEDCrs3W3I47A0eTW+v67qcsZWvGJ/T6eIGmwPBRvBVZDT2
	2W3P2U1bvGYbL2WCJSBfjETU+XhaEsDNFGg6zdbT3OZx7r+My3wfiKu7da/nD/0/T9udvkoK2uf
	g8ThPSWDqDUNahQYxj+E/Wpsm2KsmN/IyvqGvlwMqu5KqZGYluu4exj/CVA1ZLMrVxPKkPMLms/
	YZCkA=
X-Google-Smtp-Source: AGHT+IGVd98H8dpafuklugEXTVi3BFcPl1nZR56txXlgYEVW9BZqLRUhorikH3U8n7kBYnhkg7YyKw==
X-Received: by 2002:a17:907:7b99:b0:b3e:c7d5:4cb5 with SMTP id a640c23a62f3a-b50ac2cf67cmr3476075966b.31.1760609308113;
        Thu, 16 Oct 2025 03:08:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ca4ec65f9sm471635366b.0.2025.10.16.03.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:08:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com,  edumazet@google.com,  linux-doc@vger.kernel.org,
  corbet@lwn.net,  horms@kernel.org,  dsahern@kernel.org,
  kuniyu@amazon.com,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  dave.taht@gmail.com,  jhs@mojatatu.com,  kuba@kernel.org,
  stephen@networkplumber.org,  xiyou.wangcong@gmail.com,  jiri@resnulli.us,
  davem@davemloft.net,  andrew+netdev@lunn.ch,  donald.hunter@gmail.com,
  ast@fiberby.net,  liuhangbin@gmail.com,  shuah@kernel.org,
  linux-kselftest@vger.kernel.org,  ij@kernel.org,  ncardwell@google.com,
  koen.de_schepper@nokia-bell-labs.com,  g.white@cablelabs.com,
  ingemar.s.johansson@ericsson.com,  mirja.kuehlewind@ericsson.com,
  cheshire@apple.com,  rs.ietf@gmx.at,  Jason_Livingood@comcast.com,
  vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 00/13] AccECN protocol case handling series
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
	(chia-yu chang's message of "Mon, 13 Oct 2025 19:03:18 +0200")
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
Date: Thu, 16 Oct 2025 12:08:26 +0200
Message-ID: <87ldlbw44l.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 13, 2025 at 07:03 PM +02, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Plesae find the v4 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.

The latest draft is here, if anyone else is looking for it:

https://datatracker.ietf.org/doc/draft-ietf-tcpm-accurate-ecn/

