Return-Path: <bpf+bounces-57082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1DFAA5344
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928E41BA5246
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DCF27A45D;
	Wed, 30 Apr 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="0V8jlgag"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B60279917
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036003; cv=none; b=gOpx5bSQgo4l2TXhUnMD8QKdIV7OerHUavd1IXZ7KUVQFi6JrK2kbcv/p5Q9bUaZlch7XERgPtweV9rLPUuJPDksUhf1odQ9DChWPtOZjpBxxoldYoBR26q90oHDRC5cjvjzkqAWbOEx48sPcoCma94RI45iVyJ60uT2xA/aHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036003; c=relaxed/simple;
	bh=L9Lm7lcdVwq/Sm3tHhrfbQdMfIsZ2elP4CeDVijkf8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psuPbyBYn3VlCvlYfPnR+tcjUkAZlUXeDdBH9TKIhv4whofEOn2Nk00UrpeXkiKC10I9F3e5RBPNErvlBPP7qiDlWVKV1Ng8D5AsYyjNgdA/l8tZGduwXGJ40hpUDQbNgax0I9b6btrdo1J/i5QILda8ShqKfxkagYyyId6vI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=0V8jlgag; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-7c0e135e953so8178885a.2
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746035999; x=1746640799; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o7DigF1MP5y41p1RfoBw5UBa0C3ahB9E4ch4BW37e2g=;
        b=0V8jlgagw5ZuR9oy4XSGcgUb7Sh6tEjNSLqWkwEkW+wWNTc2i/vGs5k714/Y6Cu5xE
         2cCjmxYnzzLj4ujxGr+YYfbEHFRNIraOgTKFPWUB9Z+SP9XGan/AiMTajMvLGKXzFEeM
         jbDZT8c8VRkYUWkLmWkoO35sLzs64JJy4iy7VXGt2Iqy3knQG7tcjhqm6wqSrpCuXVCh
         c5ocvmx4mGuO6rO+9384Bbr5QH61rjHkR6HD2bYZx0snSjlhChG39VeyPQYQEu46agZg
         TK5yDp+Ez80MVSUqkgb3wehOiZztcei4LcsjIXW+4WxiQ678cs8nAZHFYQ8gxUVz9nSo
         gHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035999; x=1746640799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7DigF1MP5y41p1RfoBw5UBa0C3ahB9E4ch4BW37e2g=;
        b=PbaXOA0Buv9jRlyE8JWmuYesKqvJ17IprSUimFGt2qyc1IlPkShIu8lVn3UObIm4Q0
         xFRIo3t8ajPzzp8ii3ZIh9BxVgBoXoOc+lS8zM2g81Bec/m8m8q+17Wx2ledckvoeoIN
         EGMVY4lXZ6aHvCGZnChIvKZn9REX86chTinaxGIH2ZklU+ppYwDvISR67n9yY2mzrwfy
         ElhmJpVBDBsckONzLRPXyo3rA5DXo4Nu93HCOcl5WsNZPE0ONUu//tOf1jIRXlZbgeiT
         k13R3mISXK09AG5j1CMKXAzJp4EO21ipoQlzsizaGyoAkl54sozjwMKB7hsMIQqGC00T
         378Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzX2vU+cfU6ars+7ye3ZTpmpCjfRF/qzYtHsISaV5vsIJTFYsl60ARxbY3jM5RXyaGumM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEm2h+CN5CTyVMwxnxXUjLKctbRnEX8sExJzn8DEzHPhz+fQDY
	KJ08Ed7baU9Foqiqz+kHFfr48EJ2k+aGTGefNwc2GeUdNOZPdwpsJKt28H8uEus=
X-Gm-Gg: ASbGncuDupbhIeXo70qzHE79nak+DSj0DFBoPxU8PjR8OzjJtfw5OX1VPDnuKg+Hs9Q
	PHYLuYXThUZ0qkCFBiGt8ziBPVOI+DTsVR+pHDjVTHQobeswPO9PkvZu0ZADGW2B35nfNQRACq8
	T8uAKWSJR/LHK+LXp4EUZ4ru6E/24Wtldt+X7O90D2haRFY970BmDJYmPIY3chLlevZZ0j5KucW
	CojQXWMM+4hzgtXFAx2s/9FSKmlRuoUQznfkJFqp/9Xr+/5iCJMamjuCvaR+vhgzkqOuUWKP9DV
	wekIpg+l+kGGazheLnDuoadVz0eSlEIU3NzUU38=
X-Google-Smtp-Source: AGHT+IG/34lj9qjx4dj8hrxsVFgnxulHwxLpzJWDPoatM8bVPbtUmccKsHqJ140kVlh0/ah9dUCluQ==
X-Received: by 2002:a05:620a:1a21:b0:7c7:5387:c754 with SMTP id af79cd13be357-7cac750a918mr545134585a.24.1746035999039;
        Wed, 30 Apr 2025 10:59:59 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958caec22sm880690585a.28.2025.04.30.10.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 10:59:58 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:59:54 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org,
	David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Message-ID: <20250430175954.GD2020@cmpxchg.org>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
 <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>

On Wed, Apr 30, 2025 at 10:38:10PM +0800, Yafang Shao wrote:
> On Wed, Apr 30, 2025 at 9:19 PM Zi Yan <ziy@nvidia.com> wrote:
> > For task-level control, why not using prctl(PR_SET_THP_DISABLE)?
> 
> You’ll need to modify the user-space code—and again, this likely
> wouldn’t be a concern if you were managing a large fleet of servers.

These flags are propagated along the process tree, so you only need to
tweak the management software that launches the container
workload. Which is presumably the same entity that would tweak cgroup
settings.

> > For service-level control, there was a proposal of adding cgroup based
> > THP control[1]. You might need a strong use case to convince people.
> >
> > [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com/
> 
> Thanks for the reference. I've reviewed the related discussion, and if
> I understand correctly, the proposal was rejected by the maintainers.

Cgroups are for nested trees dividing up resources. They're not a good
fit for arbitrary, non-hierarchical policy settings.

