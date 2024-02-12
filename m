Return-Path: <bpf+bounces-21733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D48516F1
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 15:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC47B27AD8
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC053C08D;
	Mon, 12 Feb 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbN61dCv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86B3C067
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747290; cv=none; b=kzy/THhdOJYlqEpKu9x4uISajA4vJBmZP9MG+fKRCtPddaq+YmJnF0+iqdzDUrOxKnkFXSgNZBdMGPSiqTgaKurJ/OE7j1iJz2qo/PE5cfqT+/9Proh2udcc/qnkhuEYOHSmp2YI8MZwYuwRWLLdiEcaKcgZPHxeh7nYsc2rT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747290; c=relaxed/simple;
	bh=fRISmESrxAbxOHTNCCrwvcbpWszKTIsnn5b+VWjPkZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgYZI85pfDnpCsnb5Y5trYeXlQZ2JT0J31KEGLBvWoEliTdeLpxQbKfIQa/0A8CU/ZDKUP4Dcge3TGHpuF6Bdh2jfmvqAKeazUISOumvQroxqEBIoED7mGpBTENzx5Kfk1uLsDRZc9bmAhmV2umL9y+LqEcFD22FnQs46+DOhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbN61dCv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707747287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zOgIMnClJmF2dzRNeT9Qru+dnCsO+zRGr4BW7j0ZeqM=;
	b=TbN61dCvfUMaq6+CMns8NeuaQzBlaLv+OF2r6NXCC2nWvi8wLr0ssd8PA4SQ9GMpWnqUE8
	h+J2Iyvvr047v6X7zbUyybkPVEJk/IKvptXO3b8ES9Xcb/Z0Si2bib9VybJuwjXol3Ifim
	zVbN6RsfNa/qUKFnXQCiz4c9uSVYBBs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-Ir0h99jxO2ipC_RH2VdeSw-1; Mon, 12 Feb 2024 09:14:45 -0500
X-MC-Unique: Ir0h99jxO2ipC_RH2VdeSw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51161adad50so2732256e87.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 06:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707747284; x=1708352084;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOgIMnClJmF2dzRNeT9Qru+dnCsO+zRGr4BW7j0ZeqM=;
        b=oNjbUWT2JGo85b3oRgNhpuZoB4TghSqAKT66oUGZAqurVvRyFXBOzmvz6Yiux01d5C
         f6+awAJiRKEagvbWSpVqCGNZnGqfnHmJY9gfGxpg7KoItgylnG2WdXNiQgmgkFqlBsp/
         w3rYZfTV2QsmRo4Ya9UIx3j1bwpcQ53ObCfPgK6HJT6cnA5q2AccXM6735mGoXdgo/gw
         Rt6CRW9qdcIsDdpCRmBf2e7EZzD8oRUmREsMLiL7Pkiw1zXa1G9ILbOqG7J5uzjx7plt
         ROR8WLkMwvnNexDKpzyJbxTOr0R4f3x52jzthH80txtNQn5CfVU4jKhqVsg9Wi/XMXiA
         puSg==
X-Forwarded-Encrypted: i=1; AJvYcCWh5vSbmE7EarJShqolgtgBRG/Iv7iM8A38zBmkWTnQODm7JVQhyXAMt15fsswARKeWWlsQq0J1Woco9pdwMt2y4Yj3
X-Gm-Message-State: AOJu0YxM24fgDxA0qXgH0c8j/A/8BSG+/5mnL6yHr3HTG8TePGm9OPZ0
	nX0VmANKvqpphEWUJ0M2FJsp9vJFFRbPfSDTAR69WkpHmKKTwMSCMjwDgd2CUS/3aqj8KrHguGJ
	gZJiTl5qvKzb9tPuEdxgfyaOLB54jNTB47gHEiHBzp4yvzwwK5GKYHEvMQQ==
X-Received: by 2002:a19:f00d:0:b0:511:8f40:8022 with SMTP id p13-20020a19f00d000000b005118f408022mr1457675lfc.52.1707747284017;
        Mon, 12 Feb 2024 06:14:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAUkqV6iCXoUuVCTQfBLoaRxfKBIWN+6896SLDgZpFsph+qepy3DrtlOvKE8vgsOy72yR9UA==
X-Received: by 2002:a19:f00d:0:b0:511:8f40:8022 with SMTP id p13-20020a19f00d000000b005118f408022mr1457661lfc.52.1707747283603;
        Mon, 12 Feb 2024 06:14:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIqvninRs8vmCp0BG2Jv+tO14k5eAuadCZs3Hc4bs3jHCWiWd6uzvLDGsurx+hlsd1g7J37LBEud9cZkvklMI9YFv1ezP7XPC4kfMkb5lu3BXSMxKLpekSAyztNNevczJ8+YxeB8s45gZ4dA8U48W/6SuBqu2zBE05XB/8RXPnvjwRQtehZtppgLaeiy81jFsIyI2MI4g97bqmO1yely2sPgGQJGNR8gPI7cnGV+ht0RmkMQ2wLWDOSOt0wyAItpLIo5R1njrbyzyUFMP6hLgN/D4rzyP6ZZAq/RssYc591gN9PHqZNfsx0MkEr/gqUOG6Hof41/3eu18wA+hD8wg+QSUUyamKt1f5pKx0R3t1/wl9XZqR4vT1Cm3DCgiZio8b14dERHX5DIrahQ==
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c4fc100b0040ff583e17csm8878047wmq.9.2024.02.12.06.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:14:43 -0800 (PST)
Message-ID: <8dd6d3c0-6b76-480c-8fba-3b0e50fd9040@redhat.com>
Date: Mon, 12 Feb 2024 15:14:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 00/20] bpf: Introduce BPF arena.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org,
 lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
 hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.02.24 05:05, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v1->v2:
> - Improved commit log with reasons for using vmap_pages_range() in bpf_arena.
>    Thanks to Johannes
> - Added support for __arena global variables in bpf programs
> - Fixed race conditions spotted by Barret
> - Fixed wrap32 issue spotted by Barret
> - Fixed bpf_map_mmap_sz() the way Andrii suggested
> 
> The work on bpf_arena was inspired by Barret's work:
> https://github.com/google/ghost-userspace/blob/main/lib/queue.bpf.h
> that implements queues, lists and AVL trees completely as bpf programs
> using giant bpf array map and integer indices instead of pointers.
> bpf_arena is a sparse array that allows to use normal C pointers to
> build such data structures. Last few patches implement page_frag
> allocator, link list and hash table as bpf programs.
> 
> v1:
> bpf programs have multiple options to communicate with user space:
> - Various ring buffers (perf, ftrace, bpf): The data is streamed
>    unidirectionally from bpf to user space.
> - Hash map: The bpf program populates elements, and user space consumes them
>    via bpf syscall.
> - mmap()-ed array map: Libbpf creates an array map that is directly accessed by
>    the bpf program and mmap-ed to user space. It's the fastest way. Its
>    disadvantage is that memory for the whole array is reserved at the start.
> 
> Introduce bpf_arena, which is a sparse shared memory region between the bpf
> program and user space.
> 
> Use cases:
> 1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed anonymous
>     region, like memcached or any key/value storage. The bpf program implements an
>     in-kernel accelerator. XDP prog can search for a key in bpf_arena and return a
>     value without going to user space.

Just so I understand it correctly: this is all backed by unmovable and 
unswappable memory.

Is there any (existing?) way to restrict/cap the memory consumption via 
this interface? How easy is this to access+use by unprivileged userspace?

arena_vm_fault() seems to allocate new pages simply via 
alloc_page(GFP_KERNEL | __GFP_ZERO); No memory accounting, mlock limit 
checks etc.

We certainly don't want each and every application to be able to break 
page compaction, swapping etc, that's why I am asking.

-- 
Cheers,

David / dhildenb


