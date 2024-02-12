Return-Path: <bpf+bounces-21748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA1851BAB
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 18:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA2F1F21AE9
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227F63D55F;
	Mon, 12 Feb 2024 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tODpd2/y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3820D3EA77
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759414; cv=none; b=IIz1RrDvpiWYiMQakyjrBXOfS2/ZFd6af5h5Wy7p65cKeJm7jGiSP2BGQT4A2ywj2gRxPLOqdUJEt/WG7pB/B8AQw1qVHVgZwGi2cA0dc6J24tlgfOyrTZHOa8UhOEAc7B7+OvSjvR/qvpmp5SZubjjsUKk83y4jOwgCw99NO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759414; c=relaxed/simple;
	bh=AzLfHd5gq4jV4l6j9ge9ogGcVUobHjPxb9FTVnSTj1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+OQJF+ToRAqVG5E6kO0oUBvKy+v031Qngq5WZ289HSLwcKXiDzI7r9xunVhmzA0p3rb9oG9L7D2nfzyP0Wgq4+iyL2tNfbySmfykJsdeQJ4/K/c2/AtXg4vVNjz0biDHX+VENAFN6AqDIyoe2i4ZK97xqVT8EEhr+uxlay4iaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tODpd2/y; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783f553fdabso241802085a.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707759412; x=1708364212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92v+u3mzExHhKbb5vQvEaRbdxm1C8+uQ73xmvxKl9t8=;
        b=tODpd2/yJgZ3qlY3NO80UudrKV/Bgs0wFCCsXcJUHIJWIQkPYxE09YGrYE2pKyR29f
         HNunwcZ9uVp2EB14xKzmmJOl0DkgLvkzlZRGLKqPTMQ2saudq4NedZ0V7bBkl4NzT8HP
         xzV/Y/ZHGwsnFRicdGTwMjCIhoFNDZImu19PXYTSZY65lxwnJmUUPBsoR+OYvaRo5TUd
         kosM/FXw67NQFxcE/pOuh1vXL9/GmqqPdb4KsJb4lWCYl80FyBmOZzEJhoa7eOlzkMUs
         glWDFVF6mx1NbG82SB+9ta8W0ztE1RgsrH0/FVsQi74kntAoGOZV1AQXOo+HiNArVsGX
         4sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759412; x=1708364212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92v+u3mzExHhKbb5vQvEaRbdxm1C8+uQ73xmvxKl9t8=;
        b=fjqCi33gIb5Aq1Xyl7/fbxm/P69V9TAf0fBQdpsNiDs0DXlr6l34OJtGI60M5zKvz/
         DQXpiag2kPUOTvkvtiopbtlIYH2bhR+jFPaokzr7UKkWul5xQ1jphpoZ1Dl2OaddJ0gR
         EFnzcSo57dNds8GGnGl6yOa1b51tZwUehIEnqw6wxbotBe7BPDlUBo/zUIO6eJEyzAyd
         muZY4TKBlOaCHM8D7SDYnwYblZJrzrTqN5s9hUobGxaHVj+A2rY7Tf8nKKllhwyZvf8h
         LJkN+XgNbx+aHw8b5K+ZiNG/auKyYwLm7YC0KzD6yJM7KM2AsK3wjqZJbzdglBDjb4U4
         iVpQ==
X-Gm-Message-State: AOJu0Yw682m3bPtnQ7bQYe5elTc5vgi9lLSkaHx/eXzb91faZxVrf3Aq
	6BLHmb8QcEjikd+vuIPG9f9dPPaD0u83AUeOL2xAxKXmP/fmUHSn3nqaWSd0wiO1IIukUIXYnmH
	x2DL48+0=
X-Google-Smtp-Source: AGHT+IH1mHBmkxv29If4/T4Nu6zNWYBDt03eLvNV2rJw01Oh0BAKyWG4tGMV3FQEp1f8h6IAa4bqDw==
X-Received: by 2002:a05:620a:28c4:b0:785:d986:4a44 with SMTP id l4-20020a05620a28c400b00785d9864a44mr394110qkp.8.1707759411947;
        Mon, 12 Feb 2024 09:36:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8P/wKeHSCVxqDUrOlyHSOhwWtPzveebFEBUX4/en7WAQ0bL2Ixvko7Ema8+rSBdCxD6DFDwSRpJAmLRn9R9VCmIWAu56dfM6nQM82hGghkcTses2S3s107wyqVTQd/FTc4J++zkbX4KY0kMNd5owF+ryo4n5M4u0PsG5GVeGERUBeezEKNq4X1dAhjS9ktmEyzLRzth6IUDGMV6TEDAmzK9Ak5bHd1COeK72OXUtNvX5UOFVMkq6ZccQrfh3hYn9FSAcfQbqMyg6oiNPegs6ZQbqcNxpz6bghtnIaZTYfbF9zoW4iNQMPWooqIC/1nGI0U59qfV8P0qud8fzHLwDPzTjp970CoJyWXkXt0dETzfNxmreG6tBhUJD9
Received: from [192.168.1.31] (d-24-233-113-151.nh.cpe.atlanticbb.net. [24.233.113.151])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a24c400b00785bdc9d08esm2217670qkn.32.2024.02.12.09.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:36:51 -0800 (PST)
Message-ID: <fad75720-1f73-4f4a-8221-f502f96067f5@google.com>
Date: Mon, 12 Feb 2024 12:36:49 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 00/20] bpf: Introduce BPF arena.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, hannes@cmpxchg.org,
 lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
 hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 23:05, Alexei Starovoitov wrote:
> The work on bpf_arena was inspired by Barret's work:
> https://github.com/google/ghost-userspace/blob/main/lib/queue.bpf.h
> that implements queues, lists and AVL trees completely as bpf programs
> using giant bpf array map and integer indices instead of pointers.
> bpf_arena is a sparse array that allows to use normal C pointers to
> build such data structures. Last few patches implement page_frag
> allocator, link list and hash table as bpf programs.

thanks for the shout-out.  FWIW, i'm really looking forward to the BPF 
arena.  it'll be a little work to switch from array maps to the arena, 
but in the long run, it'll vastly simplify our scheduler code.

additionally, the ability to map in pages on demand, instead of 
preallocating a potentially large array map, will both save memory as 
well as allow me to remove some artificial limitations on what our 
scheduler can handle.  (e.g. don't limit ourselves to 64k threads).

thanks,

barret



