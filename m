Return-Path: <bpf+bounces-28044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF38B4C79
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A4D1C20F33
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7436F50A;
	Sun, 28 Apr 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZTDbZQ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614B1C2D;
	Sun, 28 Apr 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714319398; cv=none; b=Re8B7K0aHt7KyFO2z/DruYM4LrJb9qh+SKVXq9NxriFT9nKAqDTD3fj7PuyrJTp+7onHb2Ih4MN1QVKgvMctcxAXj6DgMgXzrwNJu8bgaFWM8860t6ge9WPgelziqzsHwYMY3f65/dQiGuvonMgUYkJY0vafth1zvxFuUzmlTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714319398; c=relaxed/simple;
	bh=07TZqXoPnXo6kvi3NcZOLkjhzi/ng8HAmR/yQB8pKds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ib7qHTZIpys6L44N2c3GO7UKLuSdt8nsEVGkbkX0xGmdbvYvDQyDiZ9We2CnHYcy1OQdXSsOcoEj9fXAW3veaZJO/I6DA5LIdk+LqkhX1I/FxThHS8sd7DCt3ecGasANJFlHk94g6Td0JK0ltmALBiYP1jC5FVxCs6PCnXMMsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZTDbZQ+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so36642745ad.1;
        Sun, 28 Apr 2024 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714319396; x=1714924196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6z2sPI3J7JXbse3qp8S6MNg8FiyBd8jGuDwTFMs0lPg=;
        b=lZTDbZQ+wps5usKdMOUmTQmVHCUPVp2fOfQDWbg8qf7S13sNniZzSngwMoEidyMwg9
         V3Zz0AdRBpY1+2Gfi88YB53NJn1nbqq1jOuWRSfMdNV1JrK+EAF5UzzQ9bzlMevxkDmH
         NtUVl5AqI4oqCQP9XD7gcIWjjcKsKp1KxDYsRPDkgzBvWvpXHvrPD/a3RsrKJgiRPSc0
         AZHIkXENNwww+OsXi0JGWAnE9pJiImD7ZfyqfIoXT7Nn9W1bmkQmrBhyrNLNp/c97FjM
         NLbPl16FkIIEDx6peIEN1mK0OPACLowhZuQTZ0CNKR0vAUoD5KFX1yqh8yxdPcEcpfBN
         TWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714319396; x=1714924196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z2sPI3J7JXbse3qp8S6MNg8FiyBd8jGuDwTFMs0lPg=;
        b=VXEY8z3tkGkEKXAfRNcjdn1qLCCDr1+eY7mh/MwRJLP/4QjeLMUOsCbww+jQuTdR0b
         W63SvNTBqBkA0Un/jEYK++rwQRUzEaQGIP8ioM9jSDzfYsA1zQKelAWGzOIF4c4a2jKr
         CNvOv21u3zAb5GtjKrnj4WoPFDZIdryhcfSrYiuXlwnD0kUO/FJPAw3r8B9j9lXlgQr3
         sEzHBxl1M9PAYUwHY5PcDdA+ct3new3zOnJ2O/dq3LmQ0DcfANZVACHtGKW2laRC8GuY
         J9JjnAT0dr3E4XCmvRHKsIz25fe2JESJ8U3KRLwK4Djo2BaWvbFNGOC1zcG3oanlod62
         zc2w==
X-Forwarded-Encrypted: i=1; AJvYcCWTGVM9XYgrfvVH4t9DYqZzGuHP1X5Q2R9IJsTQ2KDGcDexO1kE7XWityefBNoefgujS9CjP7USwQmJq2eLlbwE3Wan+1PlEKEjnd1uhJc5+9rycKd3phfBXyPdHDXwI5q9zAYz+8/Z3Y4VeAVeat5cSD2HeePb7NmpFwIx2efMqST9ZOhyuqfGRmgiGsiWPdIvWiad+A==
X-Gm-Message-State: AOJu0YyadDUhiWFsK3NaiZjsPrLNZ/mmLP5yqk+v5/GKHP0Fy0+9Zf/Y
	Ufh4Y5wZgmO5dhLyvyFXZOSrmj7SmXVV1Dm5f4A2WTGDw5KECgKa
X-Google-Smtp-Source: AGHT+IEjMGzGw4T9qC+hSir5dxMIK2/kRy04CEQiCSlSQWKiQDmLyfZX7FxhwB7vdagjvmCJow6BIQ==
X-Received: by 2002:a17:902:7285:b0:1e7:e7ed:7787 with SMTP id d5-20020a170902728500b001e7e7ed7787mr8145663pll.51.1714319396545;
        Sun, 28 Apr 2024 08:49:56 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:89bd:330c:30be:6758])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001dd578121d4sm18592101plk.204.2024.04.28.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 08:49:55 -0700 (PDT)
Date: Sun, 28 Apr 2024 08:49:54 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v7 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
Message-ID: <Zi5wIrf3nAeJh1u5@pop-os.localdomain>
References: <20240428060738.60843-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428060738.60843-1-guwen@linux.alibaba.com>

On Sun, Apr 28, 2024 at 02:07:27PM +0800, Wen Gu wrote:
> This patch set acts as the second part of the new version of [1] (The first
> part can be referred from [2]), the updated things of this version are listed
> at the end.
> 
> - Background
> 
> SMC-D is now used in IBM z with ISM function to optimize network interconnect
> for intra-CPC communications. Inspired by this, we try to make SMC-D available
> on the non-s390 architecture through a software-implemented Emulated-ISM device,
> that is the loopback-ism device here, to accelerate inter-process or
> inter-containers communication within the same OS instance.

Just FYI:

Cilium has implemented this kind of shortcut with sockmap and sockops.
In fact, for intra-OS case, it is _very_ simple. The core code is less
than 50 lines. Please take a look here:
https://github.com/cilium/cilium/blob/v1.11.4/bpf/sockops/bpf_sockops.c

Like I mentioned in my LSF/MM/BPF proposal, we plan to implement
similiar eBPF things for inter-OS (aka VM) case.

More importantly, even LD_PRELOAD is not needed for this eBPF approach.
:)

Thanks.

