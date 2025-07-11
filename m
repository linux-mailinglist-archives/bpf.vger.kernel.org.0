Return-Path: <bpf+bounces-63054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE9B020F9
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355EC7A45AA
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E402EE285;
	Fri, 11 Jul 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG5D6bu7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B0192B84;
	Fri, 11 Jul 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249466; cv=none; b=pbBDqW/h0umcZzvMk8WJY1xvy/bdlpoQngrCrKv3QnMVCDkzHImwvuNtRi73NYHhmvJ+Z4tnikr7bOG2fwf75CykS/YFhly3JJIbBxfskmgLAPyLQ+b6RFIMNa0sJqveuZLwmEuldkIAepa1vHzhOSdYBz/YTfhbrI3dcasdcLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249466; c=relaxed/simple;
	bh=Okt8tEdOcCGAO3dSSE1nDhszQaY4vAFNDy0CcMjV6Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5E8AtvRU7lHpXyQFfSgB4vo2t34FBsQ0Kr9brJdObIWTsrRNtbqL4LfhJzETgvCi8rp+Kf+9N4LFetQTPma9mboPgTBQa5D7Zg6WIiTRWEYOcxm3/2fbwOT3m66sfmgZJtO2WnzwuUFDf5fUPSce6xq/34Rvjcb+gUP1qONf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG5D6bu7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7481600130eso2843645b3a.3;
        Fri, 11 Jul 2025 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752249465; x=1752854265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKy32veQ6OTd1JpS281t0U/Okz95rZZyzINWiClo7xc=;
        b=ZG5D6bu7oWJ2tXR5o9mSMlcf53sIhdYvjUTvljKqgX/FbnW6jVjTylqc2DdxKMinQa
         pu7CVmyjr0k2O39pSzEUfvcSChOVzIGboE8+U/PHaVCNDB5i9Cns+LBYFMm/3mUhRjL7
         X5FZokw+xZDJ2siAPFQ/qjDpqq9aseRxhtyvcYkQnbirWVjWrF1ZW2bMDRon+bfNT/ec
         rev3msrDWrO7KMknKPgyzhHCMJ28wecTWZoGgUshOu3UHSju3Yj5kSezFnSRyiY5z0u/
         /c8+YskwIfWlBj2PRAuBEPrj0mGQsO1zFdPeGY7xUXG/rOeOMyx8LYT1C2+Fkl7/hn8b
         oDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249465; x=1752854265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKy32veQ6OTd1JpS281t0U/Okz95rZZyzINWiClo7xc=;
        b=Qx0XF1kiVzDMcJTu+tWpqCAZl5C6pRVit+HvJU4MdURCBwaqmkjJJH92R2EHhd8y4g
         u1stlzkRdEvpa5ljhAVBPsoXO2CKTMCsEU5Y0EMDogzaArka13iuf6/izGD8hmKlL+/m
         M8iGZYF1FTDLScv/mMQQQgwfNgdzjMLgdpa9fGarAtDCqgB/m5UgE2qVRfC7IqYqe176
         Jj8HAso0jDLuDwLpIkkr/HsecMRMD8Rn58+Bxujwb1FlmUFZmjoHxXodUUusAAbvRVw6
         xGLzShf6VPB4OtnSaf8C3kKt+XpC9ezj5hNDwHayo5m5tji+p4pGXwSrpzGZRlIWtUGO
         eKRg==
X-Forwarded-Encrypted: i=1; AJvYcCVwNoKrLeeePZPRYWSjVXFoHL2SM0UhXUZmur4W+b1Ubqna2AhxHVE1CXjNjRUg3PBBi7Ft+2Ie@vger.kernel.org, AJvYcCXm+SQc+q3hTBCeRrCKxzFB5FwuRkk3P/+zhe+ODCozWtwxq91e0tBtav/vCpQN5paeM2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqM/LWiG4HXHrmeaEv7DVteV0pLxhnPv64DA28cVIcYle7xs35
	1gNfeQo8bk3bwQi1/vB8DUHqojkzflmthKZNa/ZxXgvKW84nsn8YHysA
X-Gm-Gg: ASbGncvzJIiPQ31vSiNNigu3fgjElNrz8YTWW/uf/H9XAjnsKQ2bnWFoed3bF+jPbA4
	d+ZIC3QdpxP3nHhaKvIxD38mkqrw7MC7tx8DbO46aJMGAx+D1YDFBzTfIOPQv8qID0Yp1/4qjWJ
	vjlTBPeneDTjfPnsMv1S/kkBZdXd9422qW/CO+Ng6dgi3HiD2hNCBAO0yNhSLoCHFc4sGGaCfte
	UybkO15Dz/p7tnfon/loiyB/jY03dPQuTftfZTIqIqpQ8gNzdxt5cQ95GfAT5nWDs79pww6Jqq1
	u8BlJ8qg1Pcbz4LKAfaTpBGlWh1Zvp/a4WISpo90wJgFz67MVrmG7Sg/naN16faw71tF2dCp/qE
	6YH6GEDnstJcv0K/aqqrfCuI=
X-Google-Smtp-Source: AGHT+IFpfavtpvBpPQWJzVL+KOt4JJqHeM7tII93XuqpztkKOtV3yth1TBMlugVu3OTOO/2MY0s+lQ==
X-Received: by 2002:a05:6a00:1396:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-74ee284e986mr4588341b3a.13.1752249464442;
        Fri, 11 Jul 2025 08:57:44 -0700 (PDT)
Received: from gmail.com ([98.97.39.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm5762951b3a.72.2025.07.11.08.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:57:43 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:57:27 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: vincent.whitchurch@datadoghq.com
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/5] sockmap: Fix reading with splice(2)
Message-ID: <20250711155727.qjg2zc6r46h5wof2@gmail.com>
References: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>

On 2025-07-09 14:47:56, Vincent Whitchurch via B4 Relay wrote:
> I noticed that if the verdict callback returns SK_PASS, using splice(2)
> to read from a socket in a sockmap does not work since it never sees the
> data queued on to it.  As far as I can see, this is not a regression but
> just something that has never worked, but it does make sockmap unusable
> if you can't guarantee that the programs using the socket will not use
> splice(2).

Correct it was never supported.

> 
> This series attempts to fix it and add a test for it.

Thanks I had this todo on my list, but never got to it.

> 
> ---
> Changes in v3:
> - Rebase on latest bpf-next/master
> - Link to v2: https://lore.kernel.org/r/20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com
> 
> Changes in v2:
> - Rebase on latest bpf-next/master
> - Remove unnecessary change in inet_dgram_ops
> - Remove ->splice_read NULL check in inet_splice_read()
> - Use INDIRECT_CALL_1() in inet_splice_read()
> - Include test case in default test suite in test_sockmap
> - Link to v1: https://lore.kernel.org/r/20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com
> 
> ---
> Vincent Whitchurch (5):
>       net: Add splice_read to prot
>       tcp_bpf: Fix reading with splice(2)
>       selftests/bpf: sockmap: Exit with error on failure
>       selftests/bpf: sockmap: Allow SK_PASS in verdict
>       selftests/bpf: sockmap: Add splice + SK_PASS regression test
> 
>  include/net/inet_common.h                  |  3 +
>  include/net/sock.h                         |  3 +
>  net/ipv4/af_inet.c                         | 13 ++++-
>  net/ipv4/tcp_bpf.c                         |  9 +++
>  net/ipv4/tcp_ipv4.c                        |  1 +
>  net/ipv6/af_inet6.c                        |  2 +-
>  net/ipv6/tcp_ipv6.c                        |  1 +
>  tools/testing/selftests/bpf/test_sockmap.c | 90 +++++++++++++++++++++++++++++-
>  8 files changed, 118 insertions(+), 4 deletions(-)
> ---
> base-commit: ad97cb2ed06a6ba9025fd8bd14fa24369550cbb5
> change-id: 20240606-sockmap-splice-d371ac07d7b4
> 
> Best regards,
> -- 
> Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> 
> 

