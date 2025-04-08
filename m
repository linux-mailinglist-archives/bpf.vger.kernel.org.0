Return-Path: <bpf+bounces-55434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F026A7F2C0
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 04:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D40169D32
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 02:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B922DF86;
	Tue,  8 Apr 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="PkG2pKQU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203B218AAF
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079997; cv=none; b=SYDvN5TCb9lDd5d2yGJAl9nX5Hz3BfH4LJO3IyLByACGWOeWOsoOa6n9yhYABqt/xG3rxY6VgMLnz2xZEyQUMs4Lni+wXAAw3ZGUYYkaG8aMz1E4rQgymza6bwKWeZHWILE94pEfSvK+Qwp0+m+jJkn4VBvuf7gIq3+q5MGW0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079997; c=relaxed/simple;
	bh=M31VxOzVmZnycXapvIBZosqTUyiTH9P4jML+1afoVLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs7fc5H23coU4KfzMnWdHmllcdjErbmvHbdoXFrlO120c9uYHGKasZ50Pl+/taJSBxmh5dxTtayp/gafO+buRaLXniWDrog+A/Aov1oDG3FbxQ7n7su9TfuLu5HStLgWUXuCBOAlm9I7i0CCW7YIskYos+VG51lsl3lkqJpHC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=PkG2pKQU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8ff1b051dso9002996d6.1
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744079995; x=1744684795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M31VxOzVmZnycXapvIBZosqTUyiTH9P4jML+1afoVLI=;
        b=PkG2pKQUlLCKRprYTfO8R01aYeegvO2ZcukPta9qWRBZvE1xaWz1SnZjJFQlKpdwAN
         VmWb50mWFr4q7XpNpnHJ46ZkPxIP9Au9KG4Ti2OOTwQPteSFndreAgDRO0T7g4QrcktE
         64sdByegSR25hUo0bNEn5lzsUP1GE/CmzpaE0c/1lEU8UnCQMl8qucIaSXg+2OGo9WKm
         FVF4uWLrHtTbLRlFhC4KNV9aB2FpJ77KGRp5oDVpFSfwdQhaWh6xapR1zKVAEZVGX7kn
         OgCDzw/1zP7ExOOhMEw3gKmFmU6o/gKtG9+lbwfRDcJROqpoNEac7fQb3Hgt5GLPTotW
         8MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079995; x=1744684795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M31VxOzVmZnycXapvIBZosqTUyiTH9P4jML+1afoVLI=;
        b=maLW3fAjjv7rW63YMxM4qDod9XTf2fu9Ehpg74A7PUvm3LAu6PhG071CXmtF7fluMj
         uq5Y/IChc2mvszCK0PEoIu2/HRBHExDDwXBxPSvsJ3k9JQ8vBj4N/KGgXrMN2fitopvz
         efocUwCz2biyesm/Vn2+7BM76O09sbXreb8C+gZL81rcvPav3HR7vEtIoO92ZU1H103k
         weQe1W3toA7r4iUvHuhAvH63GI4JHekHaLSYHYb8t/I5PeaeS0Cy3WRqlYx0kBR3yeUG
         w8wHjS9Tq64bqbfIYFVMdufr+61Ww15tCoOB1aEQWRGopMcyhV3h8amX1XDbaGXh5QkW
         bYbg==
X-Forwarded-Encrypted: i=1; AJvYcCVuxvPZaNeBadrL7eUuwnTAdzL8t8hQjafXe5CQz2C7AhAkuJf7RTZzjvWvCEZMfqGBFgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGsEEexdhIDG4q/mXwjyLJphQL94rYRwDPnuLWpCNWaYSriIg
	/Hy9u6WQuZopCe2U8CzUroH9BH8pssyG43DgEZs0tpcGSS7b8QrKC/TucwPC08PhKFXnX44U1rU
	pVo2Y8bIh0FbKWVh8gcE+o1B03NdOezX39Nwq/kYqKwRC1edzGXRPrw==
X-Gm-Gg: ASbGncsrznEYQx+ilFmRb9u1NxlHeTu1l2R0NPoaWXquCwCygRj6p7FtGMZ1v5CmkD1
	zH9bHbcZBYzYoP/YQSK0bd2Lrd5TG+o9LUJfJBB6xysExy1DqUhOYcCSh6EbcsbyyABZqAxNpVK
	2q1jg7Qelf2COJ1uASHbgrjhBcXVfQHL/42BHhgb/LRsw+G7rWUs/1img8aHc=
X-Google-Smtp-Source: AGHT+IHpSLU3oa6SVfByXmuw4k5+J+vcfz1hIimEpRpnPeruT5HxoV3Dp5AbBE5EUCxZstJmeFto1r2adE6kVPlUl0A=
X-Received: by 2002:a05:620a:2706:b0:7c3:cccc:8790 with SMTP id
 af79cd13be357-7c774d259demr885538185a.5.1744079994828; Mon, 07 Apr 2025
 19:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi4-ogLNdQw=gLTRZ4aJ8qiQWiovHaO19sx5uz29Es6du8GKg@mail.gmail.com>
 <20250408001649.5560-1-kuniyu@amazon.com>
In-Reply-To: <20250408001649.5560-1-kuniyu@amazon.com>
From: Jordan Rife <jordan@jrife.io>
Date: Mon, 7 Apr 2025 19:39:44 -0700
X-Gm-Features: ATxdqUGyx7acR0AtEZl7zRjwptuF_xH_VJRTNQaNyV1ofxqMXhsBnJNdNQ_k2cU
Message-ID: <CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

> In the worst case, where vmalloc() fails and the batch does not
> cover full bucket, say the batch size is 16 but the list length
> is 256, if the iterator stops at sk15 and sk16 disappers,
> sk17 ~ sk256 will be skipped in the next iteration.
>
> sk1 -> ... sk15 -> sk16 -> sk17 -> ... -> sk256

Ah yes, this is true. Thank you for clarifying, you bring up a good
point. In case vmalloc() fails, the batch size can't cover the whole
bucket in one go, and none of the saved cookies from last time are in
the bucket, there's currently no great option. You'd need to do one of
the following:

1) Start from the beginning of the list, assuming none of the sockets
had been seen so far. This risks repeating sockets you've already
seen, however.
2) Skip the rest of the sockets to avoid repeating sockets you've
already seen. You might skip sockets that you didn't want to skip.

I actually wonder if a third option might be better in this case though:

3) If vmalloc fails, propagate ENOMEM up to userspace and stop
iteration instead of making the tradeoff of possibly repeating or
skipping sockets. seq_read can already return ENOMEM in some cases, so
IMO this feels more correct. WDYT?

-Jordan

