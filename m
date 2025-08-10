Return-Path: <bpf+bounces-65311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E25B1FC0C
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 22:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0DC189431A
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30E219A8D;
	Sun, 10 Aug 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDchgDaD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289091F429C;
	Sun, 10 Aug 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754857228; cv=none; b=Jh4UimaZtzuVwshC+rR9f4+DGoUCPGVAb6c6Pj0PB4IXaFEM3mWfffdbNlysDnPxVnr77PYC1ySNsQoEkn6bALTTYYRv0HQhQ6rRxKUafXoGZQwnAG2t85hlmReehJLhFPe6omSy6HBMDx2du3L23ZqTJl39O//z3YQHXPbDvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754857228; c=relaxed/simple;
	bh=X18dPKykegb5IVOtMVKhJoUQ7LQapb0oeOk+mCzKQeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z88GJaX1lYIFALajDobd9Peo6nq5iITa8i+cRMAMog0bw3R8lbpTXgqWIX4OyJIgdCi0G/B3MzWKZNnUi3dIU1RfFpW8McJpOz8u+kqKNfWRX1bxmo7LxZa4HOjd5u32XxDgAqmKpqFcQBASule96Y+FLOsy49NMXb74ecf7Tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDchgDaD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459e7ea3ebeso13507535e9.0;
        Sun, 10 Aug 2025 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754857225; x=1755462025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l27SIyY6K8c3MGvtKdMZemDVV/kUF03H7mYHi+f0BLw=;
        b=gDchgDaDir3ZeOUg2LYb/hAJjclRQ7L40MdNbqkuzN6av/d3ifKrjoPcHFl7CcU97r
         H6YCb3pY5EMM00nqFDfBZy/j3wuqVJYRyXfHLLWGH0Z7zlHXp8jx2xBeWnmILB2XAR5E
         /Gq5naEj0w7wAMakSXhcCbbcCfqWLQtrEPSndiEFMcLDO+0dyUtsXx1hIHzwJ1TuXJVE
         JgFrOdgpVoWpd2UNYkub0/po+yfrz6QeC1u0AAy9TIYe96eRWVIY8KDottezcnnG8YyQ
         VEbgplScKNVH2RejRCFQvS3kfTY//rGc/HhTkvHwgsF3VV3r2+Rasm1waNQJELMd6x7Y
         J4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754857225; x=1755462025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l27SIyY6K8c3MGvtKdMZemDVV/kUF03H7mYHi+f0BLw=;
        b=LlVauVPbJTq9vAiIXd0VkDdXccQiMWweAHavkBL7V+YZMUjme8xCKMNULYLfEEJvMj
         ezKGI8HKRtmRAAHaxMtpBOjOo/eG3wic2L+p3FPR1gdtlJpsKZijlVFpk1RIfTeqUjHv
         3hGbzTdOWibxyfedT1nPA23L+JIy7yWAhGY5GvD8TJN7fuFbiPDyRmd3hqAnjXw+Ipta
         wy2YldQGYz7MHWMxG6YAC6E8fgFShIk86Wuj+Hf/guhuPP16qLattOJ/SiIPuiKYXzVy
         2KLVXe5iYUnVaGzsjQzMCG1r//AtRYi/B4EWVLaY9slb8C1ZYdRpMz8+PjuYn/dl/bNL
         ypZw==
X-Forwarded-Encrypted: i=1; AJvYcCU90dothLu5rKVlJ2s7KPxzXgx18At6C8vPvb3bQ7fcAtvvKdLbc6m9sLUsBFxaCn/J4OKHGYU1@vger.kernel.org, AJvYcCWJzq9zWAGaZBnSJ1DoKnau37S4MCr42zvVQqTorP8KZkoAYj1PsJad+odRsMEJluMzADRxklMN6vXrOA==@vger.kernel.org, AJvYcCXuaegVPdEz82HmAr/DjuPSfLVnhMjjYR67E34s6l6GASWS42MH3VOYlIFKPd5pZBrvkvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMaMdgSbFwnoSmqYRSnCaKn5n3MKnhzzvZYjYhCR4gLpvAHM4
	dn0W6RnGYhN6HMxLyMn9j4GBiHgiO8WTZT7ATDd284hGs8mmZnb/haa/
X-Gm-Gg: ASbGncvZYaQwhCduIEQ7UJ5YEQM2MwKeM9DQkv3x+YIpa5SxqavniJg//uug+8SaG9h
	1yatJBOIyGviw5qTmQF/yHJbpAsJYzH72M2oXSUEerVYZRUpNa/88CooGLC/jSW5ggizDaiOkVI
	B6F1FWiKi3jSz08PNGUINdBU738sCGoQJgeOMSMBDwD4R4TrQ3p24toMP41uhgu1pP/rY6jzOnW
	75fsBxLB8qUGVeaRidgOspGaEP/ydaSOSCLFWPJ8nPye5BtFuixqe2A/tEUHPQmRTIKPbBPglr2
	fGyVV6folZKrURB+FsE80VlDfsv4/iNCOnkRA55oc0oYYJnk7rEDEt73GMgARwrHspljMxUYix6
	jOE0dJQ2051M7+nvO/dLfK0KTQKXQ3WHpWhes6xYJZA==
X-Google-Smtp-Source: AGHT+IGk7vG3POgXRirhM3QifkV6PKInb2ftoINCwL8L4D+zlXJNfPRwum9XWmerF0tKkLVVBbs8kQ==
X-Received: by 2002:a05:600c:354d:b0:456:173c:8a53 with SMTP id 5b1f17b1804b1-459f4f2e6e4mr81715875e9.2.1754857225254;
        Sun, 10 Aug 2025 13:20:25 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.128.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm224218235e9.12.2025.08.10.13.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 13:20:24 -0700 (PDT)
Message-ID: <757b3268-43ab-41bf-88fa-4730089721f3@gmail.com>
Date: Sun, 10 Aug 2025 21:21:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au
References: <20250729110210.48313-1-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250729110210.48313-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 12:02, Byungchul Park wrote:
> Changes from v2:
> 	1. Rebase on linux-next as of Jul 29.
> 	2. Skip 'niov->pp = NULL' when it's allocated using __GFP_ZERO.
> 	3. Change trivial coding style. (feedbacked by Mina)
> 	4. Add Co-developed-by, Acked-by, and Reviewed-by properly.
> 	   Thanks to all.
> 
> Changes from v1:
> 	1. Rebase on linux-next.
> 	2. Initialize net_iov->pp = NULL when allocating net_iov in
> 	   net_devmem_bind_dmabuf() and io_zcrx_create_area().
> 	3. Use ->pp for net_iov to identify if it's pp rather than
> 	   always consider net_iov as pp.
> 	4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
> 
> ---8<---
>  From 88bcb9907a0cef65a9c0adf35e144f9eb67e0542 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Tue, 29 Jul 2025 19:49:44 +0900
> Subject: [PATCH linux-next v3] mm, page_pool: introduce a new page type for page pool in page type

That will conflict with "netmem: replace __netmem_clear_lsb() with
netmem_to_nmdesc()", it'll need some coordination.

-- 
Pavel Begunkov


