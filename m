Return-Path: <bpf+bounces-58443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B222ABAA78
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED5C4A40EE
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20891200130;
	Sat, 17 May 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ZaMfs4A9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA31EB182
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747489418; cv=none; b=WItZ8EwZtTcrVCSu9Dci8M/vWZq9ugAz5s4C9AIHdHkR8KjZtbyd4jQTsG4H+cfv0ds0rM8Mzti9gPMdze4W7mJlONkKy7gkBoQq8KLnwLXMDcduUGvbWqkAIaBQle3S+Ymf2MjhlEuN++7SaRmuFDfoG+6GTysMxHl6tMFDxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747489418; c=relaxed/simple;
	bh=jr38lzYnByE2JIKY4eeMFPGYmcpnVhynp9NkZCHQnIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwTZ8wUeFg397MhdHT8fvUKukK1cwWuLbKR0WM3cnat5cozY/iZ4QhQRNk+niHqDwhxEGQ5Z2/9I7R8c9plzhgZn+cCTXZ/hBtMKn1TPi7v2AIK9ufRGj0B84G/FKSSZBDqg7njtpPl1FO6tJy8tEn1LN1P9Sk414MzCXSCHJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ZaMfs4A9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4766631a6a4so32588721cf.2
        for <bpf@vger.kernel.org>; Sat, 17 May 2025 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747489414; x=1748094214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gaiJIc0AhDu+gg4V5awjlETP4a9ycGXgcdzSFFKV+/E=;
        b=ZaMfs4A9ehUsRzf1Tpravka9Jh2NA15si+B5tQ4WyqVxMjfhkdpjA+W1ynu26mtZlL
         nASiJGqSdq7upgDK4b9krD+ttQ6KiepYeEmeYTWVeeTXVb0ITgfW2mixBZ2OOpRW9DCS
         zH/CYGhJSpkqgmyo6gtjJqJ5nNnJ29v8PO47kc0oowVxSh8ncBqPbD8cnZSQtwWFz34O
         EHs8ULKNUTeiQbifRfVcFXPgdW0AjALOFNK5pbuWpD+SnRhPm604t3dJBPmil3v9CMLS
         4aMeEnPXT9+3WdzheNFPuLZ+WqL3aBWDQ5d8Q4YJdCtnDQwv0XJj+Y5KVNx+GWvqsiyj
         zQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747489414; x=1748094214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaiJIc0AhDu+gg4V5awjlETP4a9ycGXgcdzSFFKV+/E=;
        b=WT6oiT8/7LNxunLa+P4Lb/TD2GpsQWtKTJTUTsgaFn86Nu0nzoD2eptVTkf7/MD/Wi
         ksQgouF752PxiG4YpI1PzYPVa5wpba9j6zgUUIGENHqtrWM2fN0msKkw+6LngjGtLfoT
         /X5s0BX7nKXYP+ClefEtM2itSmaz5dKkbuCP5A84wI1FvqaDCfCe+jFgzImiQhzOghU6
         MB388EzFoXZ6dFnpg6Xd+KxE7abkVODrKFKpXLE6o36DivoLTjUATVmik+U54kF/JgB5
         oC9nmpoxW3w936fMHawSp0hq3sxUEgbWvSAfBHNdjNblodH4PA+f8TFjrgw/Af0Hr/95
         gXdw==
X-Gm-Message-State: AOJu0Yx+eQlqXmQflPgd51NbeNrAd4SyxPeaGTwRFhESaoYlYyKoQspA
	BS4n8bYhkf899XGCk3pJaTSzIgBwaMnYB2CtViGBHOIA5EkN7ew1dki2ZAkBPvp87ao=
X-Gm-Gg: ASbGncvxSV82jtWZqeI/GUgV+84xnclx65tTPZNtJIvkCURmeMfQRcWvyZiKpryZtOs
	DAO5jM9DkSEWJit0u9PpuflJgc9zeGpoE2oA1sO/WNP0YeRmzrNSnG5B7tZtRZJ07qucrXtS9Uw
	n9IrBlQAo5FsrgjU/cY9GBRPIpI4pUoWple6kojRej0AdwillXO+p5faP/FsSSDFBaJdXEXrdXC
	Mbh1FKm+vMDJy0WfhOBo5eF6iG8UOFl7jRi8uwe5T7vjwTtNhiyIKSA+CONSbVAOojj5frKF6bK
	zYFXdfV619K9LB0DSc6UZlEAPosGcVALxJ8ai5x9hX3hJOzH0w==
X-Google-Smtp-Source: AGHT+IEY8qdVU7n2yJovckwrAweAaBmJ9a3ecpx5s0NF2iyipWR6sQZ0rP1uaIguoVmzsMSxi9XH0g==
X-Received: by 2002:a05:622a:5589:b0:476:8288:9558 with SMTP id d75a77b69052e-494ae434787mr117164191cf.46.1747489414253;
        Sat, 17 May 2025 06:43:34 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:cbb0:8ad0:a429:60f5])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae3f88d1sm24440861cf.19.2025.05.17.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 06:43:33 -0700 (PDT)
Date: Sat, 17 May 2025 09:43:28 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
	bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org,
	rostedt@goodmis.org
Subject: Re: [PATCH] mm: Rename try_alloc_pages() to alloc_pages_nolock()
Message-ID: <20250517134328.GA104729@cmpxchg.org>
References: <20250517003446.60260-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517003446.60260-1-alexei.starovoitov@gmail.com>

On Fri, May 16, 2025 at 05:34:46PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The "try_" prefix is confusing, since it made people believe
> that try_alloc_pages() is analogous to spin_trylock() and
> NULL return means EAGAIN. This is not the case. If it returns
> NULL there is no reason to call it again. It will most likely
> return NULL again. Hence rename it to alloc_pages_nolock()
> to make it symmetrical to free_pages_nolock() and document that
> NULL means ENOMEM.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

