Return-Path: <bpf+bounces-59710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6ABACED9E
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15531896D80
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763A215191;
	Thu,  5 Jun 2025 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atoVG6KX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F61F3BAC;
	Thu,  5 Jun 2025 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119353; cv=none; b=NYVl36XGD55xxea695+pI7XCp2qH8nsh8dCwoNnRHfEZieJkwl14e6EVDpeMPfNeE0R5/mkbBf+KnmWSQO5z8Qst+1/itKLc746xX0QqEBa7urQwEScXzkPkRSf156veCgPe9COjdc0TCe67/8JBDGgI0qzhbdjGwLllWffrufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119353; c=relaxed/simple;
	bh=9EVBFQQcN5lDcIVjfp+dbF4/DeU+U2HrBX+t02xZwGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG/3Ox02Fk9a1ySzOqXf/9Jva2thJec/X0IMNfx/jdt/A5LMD5wa+XndqIg/CPg/WprsoaDLHfLfmribqUTsfAcQXgMwDy/RGdfbF+eDKNN4ZfyUt2UneG954bg2vSpy4964Hun2Og97LbVPcF9JDZKrmTLMLsfM0XNxKpB/tIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atoVG6KX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad89f9bb725so154450866b.2;
        Thu, 05 Jun 2025 03:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119350; x=1749724150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okGpE+wWkCZMA6eCmE9lZtKgPGws8qXKt8I6SS2wxOw=;
        b=atoVG6KXQkuktgzJmEFZ9pClsctQnOzHTCd24vkxn9suFgVqJGOrlc5j/OhAVEOjZv
         NYJQH5+KIimY+i/4Ak1rh6tMUUQ+4cg67WPTHmshYSojPpkNorw6vQFn2HPhwI565RKk
         uNIirNneJOdZyEKRKIvrwyH0i4X4LrYj8QUryyjfC1+YVECR9/ZeBKjLlB1jxJz5wuzV
         Tig5zGdW20DJWpS/affy6d0hDReTq4WzJKN3ZaBZuLipNYEEq2xRPvnEMtnC24HCt5HN
         FULnB4xtBfZpC8jD/NG9P44AgZPOkMZGZ1Sjh1R4XFHtBxV/R/b7PM1irVDrySM3XoVg
         12iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119350; x=1749724150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okGpE+wWkCZMA6eCmE9lZtKgPGws8qXKt8I6SS2wxOw=;
        b=D0lwlIacA2oesuqzuDNdC0aY0giqqiqJzvr0UwqIy8MO4saTjjSOBhJsGP1q3MyXA6
         qlsg5gmUxHq+6M6trLbLVTNDEqYDuyNm8OyS+/mYeQ8eut38vvaHxUWVTp39CmGaDRJ0
         EY0hlpBZ6dkE2Iew6OS/ZUWDFsuaZG6ETYqCj8KWBRlDmrYuoEKcRwJ8/OQmSbU4g0Rf
         AnZtIXAeZ0nWoyUI25vInuPTeAJov4J8nrnJ+pNUEzZhFawdj6IWAr8f8tNY3VuzyI3D
         2puYZbhEH2mfCG+GZMAmpqfFgkmm0ftyKREZOmsS4EeJWe6teqhvejE3Iabk/Q4Alu0M
         ILzA==
X-Forwarded-Encrypted: i=1; AJvYcCUnSrencZMUJZfU+B32Bb36TPU89nh8Zaii2NHMKCq3WnFhLhnUejvU3kFzWuNYichGZD1DPDk+@vger.kernel.org, AJvYcCWPYf2zc0OyzZ8laHWCSAjHPantSWQRLa6lIJ6dLnIs+4sQcXCb757FrhZ0oU/OfnkiMUWycp6yNwkJxA==@vger.kernel.org, AJvYcCXVnJgCDy+tPD0vsd1Is01beyEHAhTmjUmqfR2U19Ug0L+iQZL3AALycE6jg0+01WIagqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPK5tTXmhIyljlFDXbUf79EFRORUPiXI13Dwt6ctXSKzyQ7GX
	5IOREnPNL7NufZKnVdFt0PhMnkAQivcKtARFjeEP0SymvZqJTLe0lbmV
X-Gm-Gg: ASbGncum3pzyQdkA4IRg0CPBcrt1lFo5OfOHq43m0MYbcFJ0xiYkUDgxzZGhxSs+43r
	ZBEMGmO3MXYYgHdW7WEEfV0zLu+IFAmoWhTQJTCtobEFEpdMSsGkSj4gOeUl4dE1aIB7MFNcFmT
	O7hEHdUY0cywvM6se18WbYg12C2XMA4+t7ZNMBwjbrbiUKSK+XUhtFfiZlJYtA3HBlfZLnrs1Y7
	S2IJCC676WVFYi9BUvtV4DF+ItGDsK6/1zTTuNd6zJDKrgoz3rrweARlOyGL8VxNP4Ljd/MOJYk
	F3mBv9hQ9Lbn11NJePAyI0xZ4EgTfu8Jdj1u5ScrYrBbbn658afuOe/Pyj0EW2Vj
X-Google-Smtp-Source: AGHT+IHT6brV05Y5OAGOmfdZtAJIVb6v85wA5aFgZLaNV6j8ac2I58mUZB4g0aXUHIK5FvEkU6cAfw==
X-Received: by 2002:a17:907:3d8d:b0:adb:300a:bcc0 with SMTP id a640c23a62f3a-addf8f9973dmr552533566b.46.1749119349745;
        Thu, 05 Jun 2025 03:29:09 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-addfc8034ddsm211348866b.112.2025.06.05.03.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:29:09 -0700 (PDT)
Message-ID: <eb53ac69-b6a3-4167-8d92-0638ed1d28c8@gmail.com>
Date: Thu, 5 Jun 2025 11:30:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 05/18] page_pool: use netmem alloc/put APIs in
 __page_pool_alloc_pages_slow()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-6-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-6-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> Use netmem alloc/put APIs instead of page alloc/put APIs in
> __page_pool_alloc_pages_slow().
> 
> While at it, improved some comments.

Same comment as with Patch 3

-- 
Pavel Begunkov


