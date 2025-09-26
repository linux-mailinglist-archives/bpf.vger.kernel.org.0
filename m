Return-Path: <bpf+bounces-69846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C57CBA44D4
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 16:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41352740136
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610B71E47B7;
	Fri, 26 Sep 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+HWnP4T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B3199FBA
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898497; cv=none; b=AmJXPyObkHZxxfKh0+kCA24nmVK2/Hing2onDWygK16Uj2OEydi8fs4G91ZHRIh5T7f4P7qf/+e1wnp6IjQF2bjahmklGhg3Kxo88ZKHa33JM7/8TMlQD1DdoMxrI/+rb3dIN7mOX/SL4xtSUZL1YlN1Z4Al9nVWMRMrC5g9f8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898497; c=relaxed/simple;
	bh=rJ4vWF2I9u61rArQ5Dfe472q6LLKDmCPOmpVjXV2tl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPpenWkq0MGJIHCzDeylMuKTRBjcQx2vuSFRFtgtPjx4tzAWoS9lj3gdZFxV/62mKZCrlvI/d4Bk7D5a4sAeZN2s5xkFrX2FsFMqlFJ1JId3taMzPku7AfKTFXQFkFsNeWu2zAZKhyWY/byngObU2VQ/TuuIC4p74IzMFFzeLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+HWnP4T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e1cc6299cso22143005e9.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758898494; x=1759503294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BY05iPvOa2qw1XDOJIPHyncKPIyxi1vtKF/LrunZtR4=;
        b=Q+HWnP4TqimxGrg5UJ9weoSuOJhYG/cB5FuD8kkPvMfr7WKY/Q8QAJ7WNojEGvyMHN
         90zURz7aS+ivth3s5DUi8HCjVFL2xcBi58zxWfYpNzfPwoyi9J4NvPn6HBJARXxC7pT1
         J4wmqH1ZsVAgPLJmqQ6CtQipQyqvjKJpTg3VmiPfHBUgpxSYhvrsC6HlmEAlkWqn8XK+
         uTyvLMb1y7dmreIqYzXOqXny/5JQ47o/IjAVlg4uVEDjRSunxAXR+Lu+5g46Y/VPuc5d
         c09bAMl1aJJ8z/BVl//bVr7z8VuR8FRW6pmApcR8INgAt6GjXfyJknnjGQ1CxI8M2f97
         8XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898494; x=1759503294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BY05iPvOa2qw1XDOJIPHyncKPIyxi1vtKF/LrunZtR4=;
        b=wq9tGTTFCbrAjM4iPXMBce5OUFWcjR32yT+ENJZec8GlQbDXUEkykBbOczfhWf4ERA
         TJ9NnJdhutuss3au6VitGV6BX9N4lw9VNC1PV7mIgHNEirSri7usI62UZ8iXu35nMMKi
         WDWkjTGylFJcpQdgUljr2CP2h27UICnN3Vpktj8Pb1wGjfdKWARRcz1dTPwhkxGli6Hk
         f+oDLG+1WN9eRrIwsLyPTGXzHpBpQqrjMAJEqTLc/EOjn4YVqp+/ku4UomUqVq/WFzaZ
         eEJJRqf3Zj2PHgo4gjVWUnxzxtVFkyZFKD0GqdFVYOXX0Iuwhy8l/EYS3XU/z+y+p8cz
         ocFA==
X-Gm-Message-State: AOJu0YxAq8VFvZX20h+MmuV4k1S8gsedRXA6zse8SzDJTp4ZAb+l5SXq
	FH3nyS9c1WGTgK74HbQEWnyFu3bMOI4cy3KWytg9tCA0C/LSfh3YzrC0
X-Gm-Gg: ASbGnct93VRsXmG5TQN4pPkxFHz05v+DiPRLhTMFR9g0hazeNEGG801q81mb1VUHzsq
	JqWgEkuh2/S7Opzv71mzdKV/kpIhDgbs9XTOZH0w2rGR8Sipr2ddDwGbXXvSrSuoIDWVOqfVtEw
	hosxyWtLNIV28GNermMCSj6svuRFOvoD6Hfg2HgwhCI8ws1mkANI19iZZc32INJNTq1w8QORHmm
	xZmD3/CIMKrRXVq5Z5IVugjw+6VDNL4znYzTouI1Ckn7CSmDAtre4kVY8Vh0EYOw31NGXV7veHw
	3xdKIiyS0uYcghdeCsaMgd2Gp6wu4NKb9UxyOIYSkfP3Dwukqh35Z7brcBCtHS9njHHRNXs8v8G
	Vgig7A4h4QKIQD7A1xeAxhUuQlI1S7hvZtifbmc1MSpHNoLE2h6mvO5oXXNVH7xXRT7Ms7hR9tk
	tOIFJlXqETSn4oZIc1AMAtuCw3WWsW1BWsIQ==
X-Google-Smtp-Source: AGHT+IH6XAUFoxCMg08arme1K9l+Tyhl3fwi9t5NToKIciERmlCjEeowzXgbzR1NtvHV+IE4Iod1mg==
X-Received: by 2002:a05:600c:3b10:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-46e3299a5aamr71003245e9.7.1758898494406;
        Fri, 26 Sep 2025 07:54:54 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f1dsm119224235e9.13.2025.09.26.07.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 07:54:53 -0700 (PDT)
Message-ID: <4b8817a4-5b17-4fa1-bc07-1808b495b8b8@gmail.com>
Date: Fri, 26 Sep 2025 15:54:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mm-new 03/12] mm: thp: remove vm_flags parameter from
 thp_vma_allowable_order()
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com,
 shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926093343.1000-1-laoar.shao@gmail.com>
 <20250926093343.1000-4-laoar.shao@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250926093343.1000-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/09/2025 10:33, Yafang Shao wrote:
> Because all calls to thp_vma_allowable_order() pass vma->vm_flags as the
> vma_flags argument, we can remove the parameter and have the function
> access vma->vm_flags directly.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/proc/task_mmu.c      |  3 +--
>  include/linux/huge_mm.h | 16 ++++++++--------
>  mm/huge_memory.c        |  4 ++--
>  mm/khugepaged.c         | 10 +++++-----
>  mm/memory.c             | 11 +++++------
>  mm/shmem.c              |  2 +-
>  6 files changed, 22 insertions(+), 24 deletions(-)
> 

Acked-by: Usama Arif <usamaarif642@gmail.com>

