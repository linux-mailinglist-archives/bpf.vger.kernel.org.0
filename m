Return-Path: <bpf+bounces-29866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9381B8C7B0C
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 19:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F74528204E
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B6155A43;
	Thu, 16 May 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Bz5QkxYL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C063155A21
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880151; cv=none; b=qru723RA1aPfOl7PrWFouLhTywLYfcLaFWOhJ84uE4RfizNAJplkHKpuWf8vQh4MaQZZFJzNJeuzubbs9sUZqmepCORK4ct+TqA/YZWtkt01p6rPiQX5JXpmuu9qsuSM1YMX4uJ04s6K8fNMpc5yhhyZITTPAg54Oh6bNbcSDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880151; c=relaxed/simple;
	bh=HAUKL+JYIytkSwCm2DOlRIspWB4tp4heky9US31dOOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ROuK0KMjLljJCEn3GJo+ySJkF/lmmHh9HxdNPNEdBnfkht22UtEG1HxIOJY7sp1BdAH+HlxVLLtBlNC/LtcGUSODph62pv2fDYaqeHJ8qx9p/TlA2t9TaGp34bywOTQng4wbtZ6tWPuCZE4dRL7P66MZ+9t9R/lAL/20YT9ksyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Bz5QkxYL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-574ea5184abso4193232a12.3
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715880149; x=1716484949; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HAUKL+JYIytkSwCm2DOlRIspWB4tp4heky9US31dOOQ=;
        b=Bz5QkxYL53tx33bPsa3sO3lEJ15SbCQ5Rb4zORV1aSsSf/xaIxPZgv/1L8K9oGb4eQ
         q0zT1P07Raw9XSyjYIyknK7qc2iy0wG0xan8310a+kzk6MH1qT9VC8GjAIpimCR3z8dm
         QJrr9nfXjNYYiq3pS+27bAiP0ObzRcpBkn3w4ustekgh/03gElMMvEgHoUqZQD3aRlY5
         2HBHK7B46FafJUIS08cRxj3TV8H2X970OfCKAHRMUzSSHRG/q5JAqWDVl9K7twcQW7Nv
         BJDDpSFpoRESkXmfVWdqdodgG7fSPqC6Rz7NokAQ6lGUBDLsLUgmw7gfynG8kEMKE5ol
         skkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715880149; x=1716484949;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAUKL+JYIytkSwCm2DOlRIspWB4tp4heky9US31dOOQ=;
        b=UqdAXjJXliO8Es3X+5z0E8rCgW0r/+8Qe4Hd+Sh712vW2Tbgqa/7MT32kZsWZrjiCB
         zdA87D7MTqX2mpmh7mr7VkoCKb2Zmk9ugNeZi9jf5Yrk+FH5B8KOFWwRsJhZUVDf5ZSD
         1yuWyv+uIjtKb/tJZuDBSSr7eVLykxRHrwogai9CHfn10f6HYjx+GANyocjjAAlHxTYD
         dFFC0KqRkcLhqx0fBu0YBpR4Umx4DqL1vnG/YSAkuCXGjRkTf5mwDUCg+qfwJxijyocs
         xLqWlyk6ySidDCGWToVe3/KiojLxFmTEi7HUTGgjNMICqo1EaUG7waats1oiBXCmWiwC
         JSGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPgaHtG0J+uDVoRIyqSdwOgBpMbz3AN9jNrVcXty/wRKCzgT2GIvvl1ZiZI1iL5TimoOUnSH+THmeXl05cdhSRQhYm
X-Gm-Message-State: AOJu0Yxg+Rd0rT+1J5fs4u5DNyQZAGbHfd8h2Xdpyyx4owZMKOY3T219
	65qU/mjP/tKWhFCLuS/9iqRJ3k3azZfZuDCowccCpHqQqnXAvRbS3W+aasf/tqY=
X-Google-Smtp-Source: AGHT+IGyNgJXE1gh6QOSwbJEe8jOI9clq2LTrHyN9zq+JVSQiF4/sHiwyNAsZaIQmazyzrAjWKqNQg==
X-Received: by 2002:aa7:d1d3:0:b0:574:eb26:74a with SMTP id 4fb4d7f45d1cf-574eb260839mr5431923a12.21.1715880148676;
        Thu, 16 May 2024 10:22:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574ea09b972sm3742247a12.47.2024.05.16.10.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:22:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: edumazet@google.com,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  martin.lau@linux.dev,  eddyz87@gmail.com,
  song@kernel.org,  yonghong.song@linux.dev,  john.fastabend@gmail.com,
  kpsingh@kernel.org,  sdf@google.com,  haoluo@google.com,
  jolsa@kernel.org,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  laoar.shao@gmail.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  yangzhenze@bytedance.com,
  wangdongdong.6@bytedance.com
Subject: Re: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt performance
In-Reply-To: <87wmnty8yd.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Thu, 16 May 2024 19:15:22 +0200")
References: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
	<87seyjwgme.fsf@cloudflare.com>
	<1803b7c0-bc56-46d6-835f-f3802b8b7e00@bytedance.com>
	<87wmnty8yd.fsf@cloudflare.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Thu, 16 May 2024 19:22:27 +0200
Message-ID: <87seyhy8mk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 16, 2024 at 07:15 PM +02, Jakub Sitnicki wrote:
> So in your workload bpf_skops_hdr_opt_len more times that you like.

Oops, I can't type any more at this hour. That should have said:

... bpf_skops_hdr_opt_len *gets called* more times ...

