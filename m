Return-Path: <bpf+bounces-75485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5CC863FC
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 18:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00F1C3411B6
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3692A32C333;
	Tue, 25 Nov 2025 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MP3eRqnj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E632A3DE
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092298; cv=none; b=oPYfBI5KT8/aaoEsSO1AUIhytUKGC4OYXWkP3JOSdWRxAvDas/qcLgguNTwWOdKLK0Y2YomDRRXZr28j+XmOb4x2tfgipAD2fvkbGbGfKyE+PB2WX1vx3CoAp1Si3uaxaRBH9BCAaEprJiji8L1l2+cBa3LB9GVY/iQ9hq15GS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092298; c=relaxed/simple;
	bh=iPGMl91c7t5RGa6luUsGuLLK2Y4Uq1XKEbahe9phnZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjXmBwE2/wHTj9Vi9Jz0Q7o7ufPxyYpvZBmTfwLjkPa//L6FZh61Zl8PgX0iuvk+x7ppNpgCvklnbAWtcnuY1xNqGODCW+niljpt1w2ZDnCnta+fPFYl0FYsbwHGD6UhTuU3T7OhunlUz6VRs1LBhqPrOdixgGBov6894aB8YPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MP3eRqnj; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-948da744f87so214037939f.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764092296; x=1764697096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/RYkXbjr0Zws5PkDP81koxcOw7wQafJJolXOcPbtL0=;
        b=MP3eRqnjDMu+VfgIgoXsIjZip2LrEx1us53r4meudiB9JGUbZ72aOCwHVqeWpcZFMf
         brjS7X4GVj403fOyNyRKQvVZgImprMv3zy3CchjzM+GyfO9KuAvEZRo5BLVq7yb1JW5q
         SDs7kehGdkBeTBcTdxTsopwd7wvwVVqvy408yKdzW0gEqgdkhuketmjwGMzY7tz/Z1Oo
         RAYaSxGergG2kfyxRGyXiE5ezp35bLfalGIF4hzgKt+PdBqUIvuhfIChYxFmyuaIhCVf
         CD81Odhm44Ln9mP2TZF0/SRi6UX6k8xoOAJQc44N7ZQHA+ovauUoXEg2ucKX0zVJe694
         35EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092296; x=1764697096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/RYkXbjr0Zws5PkDP81koxcOw7wQafJJolXOcPbtL0=;
        b=NITXgEPnMyrZaG9lQsx8bU7Zx7Kz7y9Vj0M3YTEOVDNQGEP0JQDmoiVkyqfAQvP1jG
         TtKU36uO4TrZ6IxlEnkfzSTF6Gm1uEkG4cVtNX+c13+K1RWM4eyC5FZ4NypqWm59nXB3
         WTpmA67ezOnVjW4IuVPANCBBEGfM8aaRgsCKbwdPkqToWNAJ22jClUYUayUZEI6dxdiW
         lbl3UdHDgSrnjO3bafmNym6kWlA9AX1A0vr1m+zrDvqJE3UvF8/tIGzLQw0brZUv5OO4
         8B1Q9u+laxijlGsMjO2FHtGJ5FzsotOyislC34by4e0YHbOrRiiBgE3+nGRKWfxhk9I5
         sbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr2TzZ4Wmw5RW2LP3k2jUkNupo0/TYM87o2WJ0iawpVGCu/3yNxwg0ODADt/9r632nAxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykIE+/a4hd22r8cmjja0IUPi5Nf+xBhfjcic68xTjpriqWyQnP
	sCo/ZOTQEIAUMOzfN2B1+JzDODcv2vQev3X5ssyMGeuUfItU+33vJ6ZdyQwiCQxUPM4=
X-Gm-Gg: ASbGncu+DfvGKAHvoRs7vLH9mESN5LIiMypmPNmyB7iHpXkHB+KZKuS1qNG3JGk23zR
	b2Mk5jFkgEwJoePmltPEjkMzK103Ga7nNtFbHce2jKSWs68U3m6KSkPQ63rQfhUGTmLvdYFWy+7
	Fn4Dfyif0nk9mYjN9C8Z+m7sPXy1qJmhtjt9T0nWBJaDbQcOUuA4E6/6g/QjtPJSBQoMFarrhWu
	yEq57dIVmkOVw2JdAFSaWJc22wofjxzfQDHGczzNQIPZYkBKbYNtC9ceYfE/0aXazLek0QvzXr3
	913h0rQLFm6iUM2ld8kKRKRwAPed5ehWgr1Bs5o2UWFZ5evHwaaNz/+KRb3CZMAx8BxM6fOytm7
	bCH4vBbSnO/KCb9EvKwFyUmoL7muuiKPt1fnwJOlv9p0b91STfKFobu6DuFCVfJbbfp0=
X-Google-Smtp-Source: AGHT+IEIHRk7SwMmVS4xtcTCAS6Qp+OrN5pgC4aYwqKQ9jNrDNwsm/zNssFdQ4CwiXZVR7EmZb+prg==
X-Received: by 2002:a05:6638:c0fb:b0:5ac:cd9a:4c4c with SMTP id 8926c6da1cb9f-5b999555c41mr3179432173.2.1764092295677;
        Tue, 25 Nov 2025 09:38:15 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48bdcsm6970840173.45.2025.11.25.09.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:38:15 -0800 (PST)
Message-ID: <e3f09e0c-63f4-4887-8e3a-1fb24963b627@kernel.dk>
Date: Tue, 25 Nov 2025 10:38:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] block: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
 chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-2-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251124234806.75216-2-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/25 4:48 PM, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error check
> in blkdev_issue_discard() dead code.

Shouldn't it be a void instead then?

-- 
Jens Axboe


