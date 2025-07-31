Return-Path: <bpf+bounces-64803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB8B1705E
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B886B3AD319
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BBD2C08C4;
	Thu, 31 Jul 2025 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cE9uh/lG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E382BE059
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961328; cv=none; b=Au0DW6wRahTlfG15Mm0167JWFKU3BGrfiPFIe/osXWE4xR+KuK2jfj/G17nRYK/l2vdZ23IcGfl7odWgxfqSoLKdswM/xvQO51nODjjW6xumLP/0VhbMz/OqURhE33ph0NVEwuMJtKFGjGPmQ8Dz+FH6Ym2ej8u4Pv2w0WtKCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961328; c=relaxed/simple;
	bh=DeNrnfxc0yCsmF++d2m59qjNIfz9tjCOKX+Lu1e25hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=slB9caZzZ5zqhwBxwjIz7XjpcJqGFzVOlzJ636LKucqpujlk1mqAup8zai9WREmVn0rMJmq8JWcFNxyorGyB/jtbudC8HLGz2sXKdUJMDv2o6RC6YZumfSGhipvGGRVf7XhUWgcNqTvFEdqdsL9sr8hE5LPqgkcZC5Q4eGL8vu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cE9uh/lG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso396598a12.3
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753961324; x=1754566124; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeNrnfxc0yCsmF++d2m59qjNIfz9tjCOKX+Lu1e25hk=;
        b=cE9uh/lGPvCX3am7h/f8TBbK2bPBfGN2uAYgoe+xrD1kFVgAC2ADAPTYT8BHXfYljo
         0GEY8eKmGAkIHLjnN/Umd4ho8S5B8zZAiua6xStvgYc8q+TCLwTwbanrjtDdfu4+i6En
         X3SIcHnUeq8WTnqk+5GoDkqBzRJ9VbHqkaxV0d3xEeOiLpqjHDGUVMh6Aeo54LanY7G+
         epvg07mvL8F2r1ro/RXJmIh3cldp5ggi5N9is6vjGmFnxO9Sex73eRiA8b6oRtfTXozE
         t+9d1NBHhaahrQv0czPcJe9TU4MVN/eyYc3WrZQN79Sp9VvkTrBsRW+EnNFHN7KH2FDy
         KXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753961324; x=1754566124;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeNrnfxc0yCsmF++d2m59qjNIfz9tjCOKX+Lu1e25hk=;
        b=lm8Kdw4gSsylsyRHM51LqsqC4Y7tGSeMwMfNgR3brlxqiwdBk07XG7fPmf+JaSasmv
         RaOoaLpNVTTXc0Y9zqe3tNR6QaeL2lKDcLlADFTg9Ammk9EHM69cWE2fDRX18eIzLUkO
         VQscSOmnDm9KwLIyJlRLXRRPsk/r48mgHcsD8l93vT5bD3KMIYpCEPtWDwXkBinWX6ZN
         C3DDcCvBYq1H7P4W3h2mUDdk7FY+FluHnXw7xttooGpQd3mBXi/Z56jgtijTTQTnLWxL
         kTmnJE2rG8WEXDl8+YKML86z2sho87q28xQ3eY/m70gaQ/LHdiowfZKS5cW7VQlabOaD
         Ecdg==
X-Gm-Message-State: AOJu0YzmvcEgcbEAJQLmzcYfpUfYAPHxvWRJVBB9+tE75lug5p8Mw8UD
	6btxo/lrYZw5E0/DW+H8YzNDFk9lduFwgkGexfjpcVjk1k0mIuBME4Z94NGLsatF8IomcsEYU1v
	dMlvv
X-Gm-Gg: ASbGncsCTVOTBmZ5XNrCZeG4SiQX6XAkZpJ7uHk53pHjz99LCMSvYl7LaEC0YULalNY
	PtX61dezIPEjxEW6vcGIbc2qC9LPi3tso3LLqhPedpfX2o+/CHTpa3cu/+AIMlCO9NvTvmOBVHG
	2CzFIdDpAPTXjrEEAmAjj/f0zdPn/id0j2VrZsDmTip/IC3BeffO+8Xbw4gRIhB8jN9aGN+zEZR
	CFDUuVbpBQ3mIM80XZ9dPJy2O0JOuVCvkGuRWn8miia8UhXMbmowXpimXzo9YF6xkJ1NYQADqYB
	Fbob0c2r1N2pLxaKPid2y5oo1BJFjJZXcRmRHVNeMwOcdu+kaqFWWSILeckBWz2y5eimlnV5XIX
	HmtzulPnVuAZL1Do=
X-Google-Smtp-Source: AGHT+IFQDPIvu+PSiZ2WNlVaBBJOiPn/OH0Qlv3IiM/FRp6ONy3Sa9MaOxjxQdz3RYKV7wwi2Hrj+w==
X-Received: by 2002:a05:6402:4414:b0:615:5bec:1d5 with SMTP id 4fb4d7f45d1cf-61586ee297emr6880898a12.7.1753961324111;
        Thu, 31 Jul 2025 04:28:44 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm929987a12.25.2025.07.31.04.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:28:43 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>,
  Yan Zhai <yan@cloudflare.com>,  kernel-team@cloudflare.com,
  netdev@vger.kernel.org,  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v5 0/9] Add a dynptr type for skb metadata for
 TC BPF
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
	(Jakub Sitnicki's message of "Thu, 31 Jul 2025 12:28:14 +0200")
References: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
Date: Thu, 31 Jul 2025 13:28:42 +0200
Message-ID: <877bzowqdx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

CI is failing because I forgot to enable NET_ACT_MIRRED in
selftests/bpf/config* for the newly added tests:

https://github.com/kernel-patches/bpf/actions/runs/16646787163

I will wait a bit before respinning.

