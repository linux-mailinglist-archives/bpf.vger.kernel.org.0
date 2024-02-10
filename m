Return-Path: <bpf+bounces-21698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF96E85034F
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008DD1C223B7
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C0288B0;
	Sat, 10 Feb 2024 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idLETbjh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF22B9B7
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707550867; cv=none; b=EYdNU9i2nY4dsbwYpde5t+d70u9cZJRMhaxXzSyV0otNB+Swa5GaLZRJsVdxCyHA1qAoLj+Xazkkis0HldpOobpw4uVXtvgRiB1H4qU9QSjVG1cA3LRbD+4w3rSjn/Z/XNuGohJH3Crj1pxkOcFZxDot/pzawczwDDaQFERSs1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707550867; c=relaxed/simple;
	bh=/EA0A9ClMivjrzgeHT6u7jGp4VTLJt/zJ2i+BQvJZB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5r/pWZNz2mPCWQ0yOpBX0OnRrl4Dgy284iA1J88m3QHblzs4X6POdGMoTUeCxa/l7rj/48HZts1bI9lJZfaknw65kLg0wOvDLkvyEpRcl97Ux0jBlKPKqU8cXVme/sNuMp5ivM/i/VFvfoJS+Q24VTFo35S68Lq5B8lDcBMmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idLETbjh; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a28a6cef709so224386166b.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 23:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707550864; x=1708155664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ+9Cb9F8pQbHqJBfYcNULR1QGntyh+v0wn8qHbrX0E=;
        b=idLETbjhe7DjoIRRNjgY1hv7tWaLnXJtWgwBhsCwSqaX03/tUzTXIuzuv158yApJs+
         7Yjf0jIGHiZxFdY7Zd0CjxRbvMj+3fIxPPhjVNTZj5A4ICV46OsrhX/pdUWuNMldPjQw
         ZGsCGpWy/ce2FdDYF041AdqAVX3dNhRXmbnmcP104+n/cOEjgZQKR65XGYXYRtrMfWzu
         yVuPcASM5lsnvhN//4WzYvGiUo7TgBmXe5A+hX8gQwnsM4v2jrEFbxoKheUGlAN+LKwH
         zib350wQvSqK3KHKiotO7/fy2MNDLY/+pSJwaKypj3GKgZJhs9EiZAEM5sLhWzQ75ToO
         bmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707550864; x=1708155664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZ+9Cb9F8pQbHqJBfYcNULR1QGntyh+v0wn8qHbrX0E=;
        b=enaUN9o4fmXTa6hKBmevI2cVZg6c0xY7kIGu/MtEW3gOrDDiIZrnGjOjv0PRraxxOM
         D/ppxoS8x+1IZdlfZNGsdlHZJlYQnt/XCycY7vm/M+Qk1iJfZFC+gR3WMIaeLOXKNZjI
         MZ7jtrhLA4QafQDbeIBlJQRWxf9YSI6t5HjCTJJRA+vkz7mH2+nv9ZAg0XqiheMMUiux
         P3r2L94IJh3vBbWHLRazuBkj9fo5c740V0Bmc1kElt37jvgHRUbQ2MHbjAJkCF6BQoPa
         9/2YkYc+0wY6Pbo/IbXj63NRA2f/omjo67MeNNXA8k54maDnMlztfDcVgp+dFXnyK3Ba
         Lt4w==
X-Gm-Message-State: AOJu0YzlcVNCMNa6dUS5zTs6drY1rHds9fbp6r00OZLDAK2H7PFKTW2z
	+HyWC7/rdRWxM7WtbOmIIl5Vv22DJEGuWri9g3HaMHnFFvm0SrX1wjMrFJ71CF4euEknXoIZjWE
	EHDSM0o9a0980m4W9EmTtZSwfj7g=
X-Google-Smtp-Source: AGHT+IFPSvgrqpy62N0H+pYl5zgLQmOCd7r8/4cMGj/KOxMM4r6/9U9hpiMmqkhRfoMLoTGLd1J0svoYIyib5dEuztU=
X-Received: by 2002:a17:906:c28e:b0:a38:e747:e893 with SMTP id
 r14-20020a170906c28e00b00a38e747e893mr871547ejz.51.1707550863765; Fri, 09 Feb
 2024 23:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-6-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-6-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 08:40:27 +0100
Message-ID: <CAP01T75y-E8qjMpn_9E-k8H0QpPdjvYx9MMgx6cxGfmdVat+Xw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_arena, which is a sparse shared memory region between the bpf
> program and user space.
>
> Use cases:
> 1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed anonymous
>    region, like memcached or any key/value storage. The bpf program implements an
>    in-kernel accelerator. XDP prog can search for a key in bpf_arena and return a
>    value without going to user space.
> 2. The bpf program builds arbitrary data structures in bpf_arena (hash tables,
>    rb-trees, sparse arrays), while user space consumes it.
> 3. bpf_arena is a "heap" of memory from the bpf program's point of view.
>    The user space may mmap it, but bpf program will not convert pointers
>    to user base at run-time to improve bpf program speed.
>
> Initially, the kernel vm_area and user vma are not populated. User space can
> fault in pages within the range. While servicing a page fault, bpf_arena logic
> will insert a new page into the kernel and user vmas. The bpf program can
> allocate pages from that region via bpf_arena_alloc_pages(). This kernel
> function will insert pages into the kernel vm_area. The subsequent fault-in
> from user space will populate that page into the user vma. The
> BPF_F_SEGV_ON_FAULT flag at arena creation time can be used to prevent fault-in
> from user space. In such a case, if a page is not allocated by the bpf program
> and not present in the kernel vm_area, the user process will segfault. This is
> useful for use cases 2 and 3 above.
>
> bpf_arena_alloc_pages() is similar to user space mmap(). It allocates pages
> either at a specific address within the arena or allocates a range with the
> maple tree. bpf_arena_free_pages() is analogous to munmap(), which frees pages
> and removes the range from the kernel vm_area and from user process vmas.
>
> bpf_arena can be used as a bpf program "heap" of up to 4GB. The speed of bpf
> program is more important than ease of sharing with user space. This is use
> case 3. In such a case, the BPF_F_NO_USER_CONV flag is recommended. It will
> tell the verifier to treat the rX = bpf_arena_cast_user(rY) instruction as a
> 32-bit move wX = wY, which will improve bpf prog performance. Otherwise,
> bpf_arena_cast_user is translated by JIT to conditionally add the upper 32 bits
> of user vm_start (if the pointer is not NULL) to arena pointers before they are
> stored into memory. This way, user space sees them as valid 64-bit pointers.
>
> Diff https://github.com/llvm/llvm-project/pull/79902 taught LLVM BPF backend to
> generate the bpf_cast_kern() instruction before dereference of the arena
> pointer and the bpf_cast_user() instruction when the arena pointer is formed.
> In a typical bpf program there will be very few bpf_cast_user().
>
> From LLVM's point of view, arena pointers are tagged as
> __attribute__((address_space(1))). Hence, clang provides helpful diagnostics
> when pointers cross address space. Libbpf and the kernel support only
> address_space == 1. All other address space identifiers are reserved.
>
> rX = bpf_cast_kern(rY, addr_space) tells the verifier that
> rX->type = PTR_TO_ARENA. Any further operations on PTR_TO_ARENA register have
> to be in the 32-bit domain. The verifier will mark load/store through
> PTR_TO_ARENA with PROBE_MEM32. JIT will generate them as
> kern_vm_start + 32bit_addr memory accesses. The behavior is similar to
> copy_from_kernel_nofault() except that no address checks are necessary. The
> address is guaranteed to be in the 4GB range. If the page is not present, the
> destination register is zeroed on read, and the operation is ignored on write.
>
> rX = bpf_cast_user(rY, addr_space) tells the verifier that
> rX->type = unknown scalar. If arena->map_flags has BPF_F_NO_USER_CONV set, then
> the verifier converts cast_user to mov32. Otherwise, JIT will emit native code
> equivalent to:
> rX = (u32)rY;
> if (rY)
>   rX |= clear_lo32_bits(arena->user_vm_start); /* replace hi32 bits in rX */
>
> After such conversion, the pointer becomes a valid user pointer within
> bpf_arena range. The user process can access data structures created in
> bpf_arena without any additional computations. For example, a linked list built
> by a bpf program can be walked natively by user space.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

A few questions on the patch.

1. Is the expectation that user space would use syscall progs to
manipulate mappings in the arena?

2. I may have missed it, but which memcg are the allocations being
accounted against? Will it be the process that created the map?
When trying to explore bpf_map_alloc_pages, I could not figure out if
the obj_cgroup was being looked up anywhere.
I think it would be nice if it were accounted for against the caller
of bpf_map_alloc_pages, since potentially the arena map can be shared
across multiple processes.
Tying it to bpf_map on bpf_map_alloc may be too coarse for arena maps.

3. A bit tangential, but what would be the path to having huge page
mappings look like (mostly from an interface standpoint)? I gather we
could use the flags argument on the kernel side, and if 1 is true
above, it would mean userspace would do it from inside a syscall
program and then trigger a page fault? Because experience with use
case 1 in the commit log suggests it is desirable to have such memory
be backed by huge pages to reduce TLB misses.

> [...]
>

