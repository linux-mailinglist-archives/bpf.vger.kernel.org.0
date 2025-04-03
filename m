Return-Path: <bpf+bounces-55245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F389A7A7E5
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB527A6790
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303B525178D;
	Thu,  3 Apr 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOQJIAwS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651822512F3;
	Thu,  3 Apr 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697460; cv=none; b=rcX/tMKGwGrBdmPoq3qbCj/ciC88iL2fbyAWX8i6gnN7YWaFY2smFssDB1E7JfN0c1N/urYML9lupX8bhVQJZNgE2p/ArW3ycSf2oSHhj7ockvcIuPFGZaqD7sGNeUjX/z96vInwee4gXtTbWED+z26t5HbnEPEk351v09sgnkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697460; c=relaxed/simple;
	bh=w9qi0RaHXu+8dQL+qsiD/76xGd8kW7JvMd9p7IvrQbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD6VIOdEOoEW14riX/5RbYLaPIkK1McpLDL3C8sT05H35I/NxPlyhuYucTxs8+I7hgF/HC2rCazVHfyXdwzBrDAx2QcKMb3ToLX4rFppO4zg1Dt+p+ZswoxklKPkX6zwCqobuBhIOa5IywxChMeSIRGSPDi4vC+/YJZ+d9lOk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOQJIAwS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2254e0b4b79so14024215ad.2;
        Thu, 03 Apr 2025 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743697458; x=1744302258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9qi0RaHXu+8dQL+qsiD/76xGd8kW7JvMd9p7IvrQbI=;
        b=jOQJIAwS2cZZr58OQ0m8Jsr+rwg0X05ieFPxtZbk8A1win3bqJg9HgYrgCjqPOvnuk
         cNh6yx10AkgBLjbaYQV1EzBISCcu3qqsZU+CNnUZoHObA3GefbeU/7KEmHrL6LJmI0F6
         bZmPtY/RJYz7WJkHbC1uR9VqQ1BDiD2iEkX/am7YPs9wuq4TOuFkwZcXpCkrRS7Io4XR
         VYIR60R7+tNgGvkM2QHG6SLlMGttL0X3dYJyaN3xJa73W6ufdIuEKUQVDqoeH++89e2D
         XPjSvR/Qu8zWMslbDkut0uLfmDlV+zhkP2rsKvnR2ft1GCNV1x3kzJxJNSwKOg11Crm5
         hg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743697458; x=1744302258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9qi0RaHXu+8dQL+qsiD/76xGd8kW7JvMd9p7IvrQbI=;
        b=Iq+hTIlRX0TUNX34JSgTEVjtYzmWL3cPaCYVKuMvP8pDD8m/DsH0MxWXQbYwzh0+6n
         /jCHen147WRvmqXAIW7HyugoTJWgNOBxcwzNYiPElDs9EEvzmu+MfTNRkl5XDLfgfxKi
         muRvOWNjosqyzt97uLqHC3ZJVyCJW6aPL1R7+YKhzba4/E2g4gxgzu+hg9ngisnOfAjb
         R88DfJTpsuqMSQlJqKVY2xDW8a5pRo/16Mg1Ygz3w0rnUn5HJKlavSgn3Z1obm0FMEY4
         BTYAuDaphV40/YIv/rE6IrTKkmJ7ekb+Y1m1Uyh4kSS+8fsIFStDFY6Ufujr9zJ01WAx
         8zLA==
X-Forwarded-Encrypted: i=1; AJvYcCUXDc84A7zEvKXVasGFu9Vv7I0HJH5nAZYCYM2FBpx9jZ5yrkhiaa+Cs4cxXyzyIuXAz64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJ5+b05+tLIrQxo6KfYHGLT/5NERoKqSDQ3FS/VjXdWfodBxn
	dPvH7nqGTIeUkSaqRcJ5v+6Z/uidJFHVOw5qcU/nWuQst5JVt3I=
X-Gm-Gg: ASbGnctkNdQS5F7S3DPhfnqQA+E5HyFEr0Hd7R2/rDvidLrSPZuH1wdlxb+vWZjdL+Y
	6h1F7z1dKs7PhOy2Gu1YnZ36EODE+Y/fJVB/W8IAmEz75e+Y8tWUiJNXiLUW20lCAQSy6Hh02mg
	38FH3HpqraLy/3bZR7dBKBN6AWxq01nlovcKBO0vyBeemcEFwjdEjwgBQgoFWhYbMRoRtNo6WwI
	BlNKo3AJHT25/DrU8Rjamy2Mfe89Q9zswRVau1IqXToeVoCKgFph2OzSj5++tRMILOVhEZxT0nO
	L64bnaf8ILv2aO9eepdQZ4ahFfBLVZONSBCRgx4GaQzMd9/aI/vyvZg=
X-Google-Smtp-Source: AGHT+IHed8zBpOcczDTpbkk/eiKF3UxXlzBH6SqqRyMTg+t+QCZvQKUusnMa+JBGUi5a8cMNJUtMkQ==
X-Received: by 2002:a17:903:2acb:b0:220:f87d:9d5b with SMTP id d9443c01a7336-2292f97a130mr367033955ad.24.1743697458541;
        Thu, 03 Apr 2025 09:24:18 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739d97ee2b3sm1693762b3a.46.2025.04.03.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:24:18 -0700 (PDT)
Date: Thu, 3 Apr 2025 09:24:17 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kuniyu@amazon.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
Message-ID: <Z-62MSCyMsqtMW1N@mini-arch>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403083956.13946-1-justin.iurman@uliege.be>

On 04/03, Justin Iurman wrote:
> In lwtunnel_{input|output|xmit}(), dev_xmit_recursion() may be called in
> preemptible scope for PREEMPT kernels. This patch disables preemption
> before calling dev_xmit_recursion(). Preemption is re-enabled only at
> the end, since we must ensure the same CPU is used for both
> dev_xmit_recursion_inc() and dev_xmit_recursion_dec() (and any other
> recursion levels in some cases) in order to maintain valid per-cpu
> counters.

Dummy question: CONFIG_PREEMPT_RT uses current->net_xmit.recursion to
track the recursion. Any reason not to do it in the generic PREEMPT case?

