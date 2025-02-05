Return-Path: <bpf+bounces-50544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2932A296E8
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 18:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF9D7A3AA3
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE72D1DC185;
	Wed,  5 Feb 2025 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dK4ckO4q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3925F507
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774837; cv=none; b=N5uAUZJMQ2jNITwGgdjOwFAH43EsjTZXjO10a1sZZO/GeoQaRFX0X6E0kfGbEqQ/L86xqYPKuYnOsyBvIqjcsMAfvLbNtrVTOjy1O2cHOJ9rTkYuljn798uFuw1cFMWZkEX1hvBXHU+8kFF7sChMi/nB3fadBpN0InmCiO8IpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774837; c=relaxed/simple;
	bh=2+YV96VhFviIQxzbBjVOuCEMP1emXkBdxr37C6ZGyyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdY+GG/2ZYg6xW9vGaxbXgzaQgvRFh5aQ0TVpkmmMWq4xZz4N4YTRREYASlvfBLa19vn/pGDmLXiEWl6gU0TZBSceGq/MBnwk8mhpVAEAsaXJihwurVF2p5T/wGdrfYR2eIA4CVYqXeNV01oeSpG/PnyAR8p5DQI3dUkl2j9eS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dK4ckO4q; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46fa7678ef3so239451cf.1
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 09:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738774834; x=1739379634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=si7q7DGOb8a4Svubvvry2zE7Bnfsr+WP2mk8N56IP7E=;
        b=dK4ckO4qLhC7J092mupus9qUg0X5pKy3mLTOhV+FzQ9Q7/pPahHENDGXRCrCYk8z1c
         jNxhW3MYuJR/hil1ejNWYqNlgNscD+mvU2KANgMPGQecEJ+/fle2fSumzRkKfRxfMB7C
         Kb2t3l7Lxe4T1m5rD94ahHotgky6PLiEWozdfHdxv911fqdq7WI7bCdObAAKWzv9FSYR
         FmbCK3sqENmjIgp9/38EiZQvYI4txOA7YeBqvhnqpeQjbMLA6diCMdwLsNbgHdg/V/ny
         RVFgCHvcRKI3P6zfGJuzAW33pw0z/6c2BHz83sZGScIYk8iX+Xa9LJ7L+aWWFMFbMOWp
         1vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738774834; x=1739379634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=si7q7DGOb8a4Svubvvry2zE7Bnfsr+WP2mk8N56IP7E=;
        b=f9rCMuabA6Pk05e7Lr2aJD0a6VHhroaCF3RUX4QoCwCMJ+Yh0xnssFLENzAsWH/MTD
         mPz3BIklGtCusPBrHoan8ERAC089rRDpc/9GryJ974ZijWmvSFTCS0uea7EJTW6K117O
         tmAWp9bvJ6RoNJfoowNgWabBPi7MQ5utMWsmbw0Ghivql0v0i9Qiff4OJh/uPreylefd
         S+qy04FhUE1xqehuGFJHOLldekeXMX/qEsY2byt3BK0dUx7eltkFJFnY+banzkdyzcNs
         +GKHFN8l7L8hJ42YmZ/AA1yMvsjicRIEw9DIKQ0NmRD2zGFBQK4HAHW1rhflFO8g87Hz
         8CZA==
X-Forwarded-Encrypted: i=1; AJvYcCUCcWVPTF2EDpAZNW0ALggqSdz4ZfvgcVApSbLKueZvespOiuqRRsW9wdNFISFwccVEHIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQOaecxkJChBV8va8kWeJRjpjVohMsqiFvnjBwE7CMzKkTWZr
	QKZO5oEIQCNkUOFci3lJt3auUztBZfAp6/zTlj3K30GuSLXazIYyMBmzfB/hniFZOYxB10qmb2w
	o
X-Gm-Gg: ASbGncvGBN9GTHmxC+rgPy9HcIAetHxjFpboTEufmgsDmo5rfb0RhAfd79rgabtMTVu
	yiwz/m3QIo9N+tkVnfmKGBp0vBtfueYx4v2eGautVYOnNuIVb/+iW2hqHBv/fb2OiD0po+7XWe7
	he/DMRUsyRtb74wYaIl9cnZFlOMr+Ti55z5OsBvD8cDwBF4LTN9EuTCA9sQSa8ywJg0S5lm7lWf
	WhPIWbk9ldSX8Lq4hV09pwjC7eZx29ZBAYHVz6GC6Ljejq7j58BuJaZsjnvWA64wDZeyC5TxO7s
	nyQ=
X-Google-Smtp-Source: AGHT+IF5Nf+jR38tdn3gYOBzTRA5S1TvOo16sL+R+AJwqMPlqJxDRYXJnGw7iouZ5JvkXoAwBN6T6w==
X-Received: by 2002:ac8:5dc9:0:b0:467:5454:57b4 with SMTP id d75a77b69052e-47028303782mr52575611cf.49.1738774834381;
        Wed, 05 Feb 2025 09:00:34 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0e0bfdsm74068981cf.41.2025.02.05.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:00:33 -0800 (PST)
Date: Wed, 5 Feb 2025 09:00:31 -0800
From: Yan Zhai <yan@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: handling EINTR from bpf_map_lookup_batch
Message-ID: <Z6OZL4C12Dy1f+73@debian.debian>
References: <Z6JXtA1M5jAZx8xD@debian.debian>
 <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
 <CAADnVQLNSUOz7kSwMr0dfgT1gk02S1wNgJOhk-5h_d01AM2RbA@mail.gmail.com>
 <CAO3-Pbqbj_pi3BrA7h3qtRsrcm_wJVLnJwyKwuuNLYg==_QvRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-Pbqbj_pi3BrA7h3qtRsrcm_wJVLnJwyKwuuNLYg==_QvRA@mail.gmail.com>

On Wed, Feb 05, 2025 at 10:27:25AM -0600, Yan Zhai wrote:
> On Wed, Feb 5, 2025 at 3:56 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Let's not invent new magic return values.
> >
> > But stepping back... why do we have this EINTR case at all?
> > Can we always goto next_key for all map types?
> > The command returns and a set of (key, value) pairs.
> > It's always better to skip then get stuck in EINTR,
> > since EINTR implies that the user space should retry and it
> > might be successful next time.
> > While here it's not the case.
> > I don't see any selftests for EINTR, so I suspect it was added
> > as escape path in case retry count exceeds 3 and author assumed
> > that it should never happen in practice, so EINTR was expected
> > to be 'never happens'. Clearly that's not the case.
> 
> It makes more sense to me if we just goto the next key for all types.
> At least for current users of generic batch lookup, arrays and
> lpm_trie, I didn't notice in any case retry would help.
> 

I opened a patch here:
https://lore.kernel.org/bpf/Z6OYbS4WqQnmzi2z@debian.debian/

Yan

