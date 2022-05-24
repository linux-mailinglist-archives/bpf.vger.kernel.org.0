Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BDE5323F6
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 09:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiEXHWN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiEXHWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 03:22:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F9868305;
        Tue, 24 May 2022 00:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DDA061554;
        Tue, 24 May 2022 07:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF89C385AA;
        Tue, 24 May 2022 07:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653376929;
        bh=JuLXRJsUYyT+aAnxt3kzSeplRAxtuhdEB5InII5VG+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9+iy9pjSipFy99mAL8Ub74cT+tARNvauwU80QfyDRYFLsQvvXqX72q4+4PgnUop7
         Gn7054YAJwJkdHwVFpf0NajqVMbfDH7rE4VZGQkWraOoum9ubMDA5FVFgeT4/Ege6P
         R7SeyTGvGACGt1JSVVMFHLtE7D/h8rhgaCaGzW9riIHWUF7/i9nVZ4UVhb29PaS491
         Q8Nkh4fYOCr/PyIlTBiJDbrekoKAoHS9eomuO4XuhzpoHuBfRg1bLD/IUZQMQznfft
         kQ+eRUzK8Fknhko3h7+XDoRC5hbXB2X2tKzb5fqaoQRsxz0NQaCRKVF/8A4q3PoFFX
         Gv/iHmakUfPPA==
Date:   Tue, 24 May 2022 10:22:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-mm@kvack.org, ast@kernel.org, daniel@iogearbox.net,
        peterz@infradead.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org, rick.p.edgecombe@intel.com,
        kernel-team@fb.com
Subject: Re: [PATCH v4 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Message-ID: <YoyHmGoEN7kQSw3N@kernel.org>
References: <20220520235758.1858153-1-song@kernel.org>
 <20220520235758.1858153-6-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520235758.1858153-6-song@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 20, 2022 at 04:57:55PM -0700, Song Liu wrote:
> Use module_alloc_huge for bpf_prog_pack so that BPF programs sit on
> PMD_SIZE pages. This benefits system performance by reducing iTLB miss
> rate. Benchmark of a real web service workload shows this change gives
> another ~0.2% performance boost on top of PAGE_SIZE bpf_prog_pack
> (which improve system throughput by ~0.5%).
> 
> Also, remove set_vm_flush_reset_perms() from alloc_new_pack() and use
> set_memory_[nx|rw] in bpf_prog_pack_free(). This is because
> VM_FLUSH_RESET_PERMS does not work with huge pages yet. [1]
> 
> [1] https://lore.kernel.org/bpf/aeeeaf0b7ec63fdba55d4834d2f524d8bf05b71b.camel@intel.com/
> Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index cacd8684c3c4..b64d91fcb0ba 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -857,7 +857,7 @@ static size_t select_bpf_prog_pack_size(void)
>  	void *ptr;
>  
>  	size = BPF_HPAGE_SIZE * num_online_nodes();
> -	ptr = module_alloc(size);
> +	ptr = module_alloc_huge(size);
>  
>  	/* Test whether we can get huge pages. If not just use PAGE_SIZE
>  	 * packs.
> @@ -881,7 +881,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
>  		       GFP_KERNEL);
>  	if (!pack)
>  		return NULL;
> -	pack->ptr = module_alloc(bpf_prog_pack_size);
> +	pack->ptr = module_alloc_huge(bpf_prog_pack_size);
>  	if (!pack->ptr) {
>  		kfree(pack);
>  		return NULL;
> @@ -890,7 +890,6 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
>  	bitmap_zero(pack->bitmap, bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE);
>  	list_add_tail(&pack->list, &pack_list);
>  
> -	set_vm_flush_reset_perms(pack->ptr);
>  	set_memory_ro((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
>  	set_memory_x((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
>  	return pack;
> @@ -909,10 +908,9 @@ static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insn
>  
>  	if (size > bpf_prog_pack_size) {
>  		size = round_up(size, PAGE_SIZE);
> -		ptr = module_alloc(size);
> +		ptr = module_alloc_huge(size);
>  		if (ptr) {
>  			bpf_fill_ill_insns(ptr, size);
> -			set_vm_flush_reset_perms(ptr);
>  			set_memory_ro((unsigned long)ptr, size / PAGE_SIZE);
>  			set_memory_x((unsigned long)ptr, size / PAGE_SIZE);
>  		}
> @@ -949,6 +947,8 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
>  
>  	mutex_lock(&pack_mutex);
>  	if (hdr->size > bpf_prog_pack_size) {
> +		set_memory_nx((unsigned long)hdr, hdr->size / PAGE_SIZE);
> +		set_memory_rw((unsigned long)hdr, hdr->size / PAGE_SIZE);

set_memory_{nx,rw} can fail. Please take care of error handling.

>  		module_memfree(hdr);
>  		goto out;
>  	}
> @@ -975,6 +975,8 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
>  	if (bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
>  				       bpf_prog_chunk_count(), 0) == 0) {
>  		list_del(&pack->list);
> +		set_memory_nx((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
> +		set_memory_rw((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);

ditto.

>  		module_memfree(pack->ptr);
>  		kfree(pack);
>  	}
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
