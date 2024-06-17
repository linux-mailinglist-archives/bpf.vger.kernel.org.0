Return-Path: <bpf+bounces-32311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927890B546
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DA91F253D4
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F080600;
	Mon, 17 Jun 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="poXnxUva"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53477A03
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638452; cv=none; b=JEfMnEe9QnUkcpirX3UkUjPBT56OyjnHxbHKo6k/eZG6THgIQsAW9Hl5TZFbUZPHxeYw8qg9P8iHlwuSz3j2U3i+TYEtmEROxS+TEvBOUhUHEMYNCshfCwNe5CsFQj3BkhWXKA9mmg0JbQEY0OkajVoLPi+TqxQlwYEv9PwVllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638452; c=relaxed/simple;
	bh=7xSjwAXf4h4YIBCAQdNyFKjkv/UsUK+DnTFKK5Cz4W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcStakfyyb/KFjf7Mmu19GQhxZ7LY1937nGFYXfdtKe61o1JObRhmAEbt0AmbG92EVOmB1fiV4O894tDr5hvYBrXgrNZlfiVhxDggL+at2Q5fEABB8tLxN3LQCqmLJ0tHWR0cw1gfnJja15gf1YBKIJeMhwJSB78OdQGIkfEyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=poXnxUva; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-795fb13b256so428339985a.0
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718638450; x=1719243250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1twaKalA1oZJPKXCxiU6zAP1oIacbICpv8HeTOvdeM=;
        b=poXnxUvavL7PycH+gtUYso59vfk+yvrYC+BrOmIe0G/9w96RXkb3gWliJqjB1LYuV7
         dSWED+HvgNyyiS7wGj0q8rrvCpsfmPznH+xGmMke/wAmS/1leRFu8hudHIzzLuqrbE2A
         7fXZYzazj4o16V9oOpvMeEwmENR1kMGYFNACuFsZz+p/heL1iFNdUmqi068bBE0+F6tx
         yR8IcoifJWvNL6+I+4yrVMfFD6MalOmJ9wqjLD+zQ8jS9iLWGqCsrJZElcY2LLh3tj/i
         GXGFdfWhiEHj55TeBwrufoXst3xW4tftL+uLggf0+Pk8tfbMNPpUig28HL8FTv9wtk3i
         abxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718638450; x=1719243250;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1twaKalA1oZJPKXCxiU6zAP1oIacbICpv8HeTOvdeM=;
        b=iFJs799eayWoeIbQLlWuhVYQ33hUiX0p1ZZ5sVKCqMDadBBtjF03lgYZVpnQ/iBOd8
         xoZ1Pelnjq4+2mwIBJ+gGZZmiCOO6yeLW6VCPPPOdVpJuuyV7aSoRE4am2RZFT1xEOps
         ck7WEmLnm6PbMJ1OF+XLaHDnDVZKWYjfkz8INHFPZWD3nDhBEcYDWxXS8oLWkOLAPyrT
         y5Vr7tSoAyXjb2d4eS5G+EexukhQ86IvfhKZY7vwxpY+l4s78bAtLKXYsPb1BVgSjbqH
         10uyaYyfvDpwWBDUVV+06ECVaZ6BLAkztklsbSX80QnpXyv+AnD8JdBtgDQX3cASvQ4W
         80bw==
X-Gm-Message-State: AOJu0YxU36Sqs1YofAaPm/sqrTAcj/T4/rRxpAZeilpFlzZOGUZAr+Mn
	d73FN+mXs1WlWPeeRz2kzcpsZ044t7lKb19JQFyHQKGfb5ItKjhKnuEiQrBrNA==
X-Google-Smtp-Source: AGHT+IHwPdPgFVs7R5QFN5plnNIrO4facu3Z+lFG2qb3yNF7JWJAnH41Ef1wlbVNreOLuEchRhe/jQ==
X-Received: by 2002:a05:620a:2697:b0:795:69d:1948 with SMTP id af79cd13be357-79ba76cdd8amr3175085a.16.1718638450015;
        Mon, 17 Jun 2024 08:34:10 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-147-142.nh.cpe.atlanticbb.net. [65.175.147.142])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc09310sm437612585a.74.2024.06.17.08.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 08:34:09 -0700 (PDT)
Message-ID: <90d6740a-6b7e-474d-a218-50f4e0de343c@google.com>
Date: Mon, 17 Jun 2024 11:34:07 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix remap of arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 pengfei.xu@intel.com, kernel-team@fb.com
References: <20240615181935.76049-1-alexei.starovoitov@gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <20240615181935.76049-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/24 14:19, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The bpf arena logic didn't account for mremap operation. Add a refcnt for
> multiple mmap events to prevent use-after-free in arena_vm_close.
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Closes: https://lore.kernel.org/bpf/Zmuw29IhgyPNKnIM@xpf.sh.intel.com/
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   kernel/bpf/arena.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 583ee4fe48ef..f31fcaf7ee8e 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -48,6 +48,7 @@ struct bpf_arena {
>   	struct maple_tree mt;
>   	struct list_head vma_list;
>   	struct mutex lock;
> +	atomic_t mmap_count;
>   };
>   
>   u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
> @@ -227,12 +228,22 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
>   	return 0;
>   }
>   
> +static void arena_vm_open(struct vm_area_struct *vma)
> +{
> +	struct bpf_map *map = vma->vm_file->private_data;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	atomic_inc(&arena->mmap_count);
> +}
> +
>   static void arena_vm_close(struct vm_area_struct *vma)
>   {
>   	struct bpf_map *map = vma->vm_file->private_data;
>   	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>   	struct vma_list *vml;
>   
> +	if (!atomic_dec_and_test(&arena->mmap_count))
> +		return;
>   	guard(mutex)(&arena->lock);
>   	vml = vma->vm_private_data;
>   	list_del(&vml->head);
> @@ -287,6 +298,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>   }
>   
>   static const struct vm_operations_struct arena_vm_ops = {
> +	.open		= arena_vm_open,
>   	.close		= arena_vm_close,
>   	.fault          = arena_vm_fault,
>   };
> @@ -361,6 +373,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
>   	 */
>   	vm_flags_set(vma, VM_DONTEXPAND);
>   	vma->vm_ops = &arena_vm_ops;
> +	atomic_set(&arena->mmap_count, 1);

i'm not sure, but i have the feeling that this refcnt should be on the 
struct vma_list or something.

what happens if two different processes mmap the same arena?  will the 
second one come in and set the mmap_count = 1, clobbering whatever the 
first process had already done?

what are the rules for a vma's vm_ops?  something like: "there will be a 
close() for the initial mmap and for every open()"?

if that's what it's doing, then this initial refcnt = 1 corresponds to 
the remember_vma() call.  in which case, vm_ops->open ought to lookup 
the remembered vma (struct vma_list) and do the incref there.

barret


