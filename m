Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1844E573FFA
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 01:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiGMXRr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 19:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGMXRq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 19:17:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0F632451
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:17:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g12-20020a05690203cc00b0066e232409c9so148893ybs.22
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rVBXEgcJyPNtIzeWoZOofbubx+ikWZFbFKPmtN9quhk=;
        b=XTz7ScsoqZydtyr9fJyedQs1/TgNaIKqOsN7c6PgPaUjbSTd4NRmqCtcFI8JwgtXIq
         c/Sr8w/aL6StagN9RO66yfL2IzI9d4ySUBWEi8b7BpOySL9SzYbpQXojyoaH5pD6bnwA
         z1ILVXmHYWh04td1p1iQaHFhUh86urq9qvSU5vELvJZJ9VZtAx7n07d/4tJHTKYHLHTw
         yhjXaKsgFhYUjsnpQjEEEzouwsYP5gM2N84zcRqbmh/f6EtpyTTjk8vcuSsHZxCyUTkf
         42FWiwm6BF24j6RnkMklPirEfNlYN6jd3GFBN4dB5vntdmHl4jj934JKT6s/7nVRaLfe
         TRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rVBXEgcJyPNtIzeWoZOofbubx+ikWZFbFKPmtN9quhk=;
        b=vjly+KPN+jXolw9b21ZA2t5Fck9qXroDT9X1M6zqLL1NEPOEHHYkOQx/jjgdwBQ5Uf
         F9pfP66SrJ5ujTBWSxZbow/BhQE8hhQbLavaYe5NCp1Mrjq0ctanHFi86Cmy1zf3k+/0
         ZH7HjMvXQiGU3mazQcyT5dv/BUHb7LcEa15w/6oqC8S+oIT10oGRl42ALXt43vZfLhKz
         b/OeiOWbkYKphEZQCglXfQgp1tlT0X3JxNhYT/lIeJCA4BcEw07hZcvP3lCj/V8m21Da
         yU04OeZYLJl7Jh1DXvkdXLIa11dBt/Ad6iMTGgFygahKDyQCE27Qa22D8CjU23opbhQP
         miQg==
X-Gm-Message-State: AJIora9dulrypwGOUYC9oCUf2x1/7At8OIRzBif3lOdg/1SeUiECDq+1
        XmkFonGpF5Rp80zldOcWqdFTIms=
X-Google-Smtp-Source: AGRyM1uyNWw2Ge7teZY/U41fxYG85kBytOguDHJw5fiZTJFxkZIpCtxeIDee9i5ECMxgpOw3G9bk01w=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:f282:0:b0:31d:a18d:adb7 with SMTP id
 b124-20020a0df282000000b0031da18dadb7mr6806351ywf.364.1657754264555; Wed, 13
 Jul 2022 16:17:44 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:17:43 -0700
In-Reply-To: <20220713204950.3015201-1-song@kernel.org>
Message-Id: <Ys9Sl6g/lUdtj1+V@google.com>
Mime-Version: 1.0
References: <20220713204950.3015201-1-song@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: simplify bpf_prog_pack_[size|mask]
From:   sdf@google.com
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        ast@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/13, Song Liu wrote:
> Simplify the logic that selects bpf_prog_pack_size, and always use
> (PMD_SIZE * num_possible_nodes()). This is a good tradeoff, as most of the
> performance benefit observed is from less direct map fragmentation [1].

> Also, module_alloc(4MB) may not allocate 4MB aligned memory. Therefore, we
> cannot use (ptr & bpf_prog_pack_mask) to find the correct address of
> bpf_prog_pack. Fix this by checking the header address falls in the range
> of pack->ptr and (pack->ptr + bpf_prog_pack_size).

> [1] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/
> Signed-off-by: Song Liu <song@kernel.org>

Reviewed-by: Stanislav Fomichev <sdf@google.com>

(purely from comparing before/after, ignoring larger context)

> ---
>   kernel/bpf/core.c | 71 ++++++++++++-----------------------------------
>   1 file changed, 17 insertions(+), 54 deletions(-)

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index cfb8a50a9f12..72d0721318e1 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -825,15 +825,6 @@ struct bpf_prog_pack {

>   #define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size,  
> BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)

> -static size_t bpf_prog_pack_size = -1;
> -static size_t bpf_prog_pack_mask = -1;
> -
> -static int bpf_prog_chunk_count(void)
> -{
> -	WARN_ON_ONCE(bpf_prog_pack_size == -1);
> -	return bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE;
> -}
> -
>   static DEFINE_MUTEX(pack_mutex);
>   static LIST_HEAD(pack_list);

> @@ -841,55 +832,33 @@ static LIST_HEAD(pack_list);
>    * CONFIG_MMU=n. Use PAGE_SIZE in these cases.
>    */
>   #ifdef PMD_SIZE
> -#define BPF_HPAGE_SIZE PMD_SIZE
> -#define BPF_HPAGE_MASK PMD_MASK
> +#define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
>   #else
> -#define BPF_HPAGE_SIZE PAGE_SIZE
> -#define BPF_HPAGE_MASK PAGE_MASK
> +#define BPF_PROG_PACK_SIZE PAGE_SIZE
>   #endif

> -static size_t select_bpf_prog_pack_size(void)
> -{
> -	size_t size;
> -	void *ptr;
> -
> -	size = BPF_HPAGE_SIZE * num_online_nodes();
> -	ptr = module_alloc(size);
> -
> -	/* Test whether we can get huge pages. If not just use PAGE_SIZE
> -	 * packs.
> -	 */
> -	if (!ptr || !is_vm_area_hugepages(ptr)) {
> -		size = PAGE_SIZE;
> -		bpf_prog_pack_mask = PAGE_MASK;
> -	} else {
> -		bpf_prog_pack_mask = BPF_HPAGE_MASK;
> -	}
> -
> -	vfree(ptr);
> -	return size;
> -}
> +#define BPF_PROG_CHUNK_COUNT (BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE)

>   static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t  
> bpf_fill_ill_insns)
>   {
>   	struct bpf_prog_pack *pack;

> -	pack = kzalloc(struct_size(pack, bitmap,  
> BITS_TO_LONGS(bpf_prog_chunk_count())),
> +	pack = kzalloc(struct_size(pack, bitmap,  
> BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)),
>   		       GFP_KERNEL);
>   	if (!pack)
>   		return NULL;
> -	pack->ptr = module_alloc(bpf_prog_pack_size);
> +	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
>   	if (!pack->ptr) {
>   		kfree(pack);
>   		return NULL;
>   	}
> -	bpf_fill_ill_insns(pack->ptr, bpf_prog_pack_size);
> -	bitmap_zero(pack->bitmap, bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE);
> +	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
> +	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
>   	list_add_tail(&pack->list, &pack_list);

>   	set_vm_flush_reset_perms(pack->ptr);
> -	set_memory_ro((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
> -	set_memory_x((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
> +	set_memory_ro((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
> +	set_memory_x((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
>   	return pack;
>   }

> @@ -901,10 +870,7 @@ static void *bpf_prog_pack_alloc(u32 size,  
> bpf_jit_fill_hole_t bpf_fill_ill_insn
>   	void *ptr = NULL;

>   	mutex_lock(&pack_mutex);
> -	if (bpf_prog_pack_size == -1)
> -		bpf_prog_pack_size = select_bpf_prog_pack_size();
> -
> -	if (size > bpf_prog_pack_size) {
> +	if (size > BPF_PROG_PACK_SIZE) {
>   		size = round_up(size, PAGE_SIZE);
>   		ptr = module_alloc(size);
>   		if (ptr) {
> @@ -916,9 +882,9 @@ static void *bpf_prog_pack_alloc(u32 size,  
> bpf_jit_fill_hole_t bpf_fill_ill_insn
>   		goto out;
>   	}
>   	list_for_each_entry(pack, &pack_list, list) {
> -		pos = bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(),  
> 0,
> +		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
>   						 nbits, 0);
> -		if (pos < bpf_prog_chunk_count())
> +		if (pos < BPF_PROG_CHUNK_COUNT)
>   			goto found_free_area;
>   	}

> @@ -942,18 +908,15 @@ static void bpf_prog_pack_free(struct  
> bpf_binary_header *hdr)
>   	struct bpf_prog_pack *pack = NULL, *tmp;
>   	unsigned int nbits;
>   	unsigned long pos;
> -	void *pack_ptr;

>   	mutex_lock(&pack_mutex);
> -	if (hdr->size > bpf_prog_pack_size) {
> +	if (hdr->size > BPF_PROG_PACK_SIZE) {
>   		module_memfree(hdr);
>   		goto out;
>   	}

> -	pack_ptr = (void *)((unsigned long)hdr & bpf_prog_pack_mask);
> -
>   	list_for_each_entry(tmp, &pack_list, list) {
> -		if (tmp->ptr == pack_ptr) {
> +		if ((void *)hdr >= tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > (void  
> *)hdr) {
>   			pack = tmp;
>   			break;
>   		}
> @@ -963,14 +926,14 @@ static void bpf_prog_pack_free(struct  
> bpf_binary_header *hdr)
>   		goto out;

>   	nbits = BPF_PROG_SIZE_TO_NBITS(hdr->size);
> -	pos = ((unsigned long)hdr - (unsigned long)pack_ptr) >>  
> BPF_PROG_CHUNK_SHIFT;
> +	pos = ((unsigned long)hdr - (unsigned long)pack->ptr) >>  
> BPF_PROG_CHUNK_SHIFT;

>   	WARN_ONCE(bpf_arch_text_invalidate(hdr, hdr->size),
>   		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");

>   	bitmap_clear(pack->bitmap, pos, nbits);
> -	if (bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
> -				       bpf_prog_chunk_count(), 0) == 0) {
> +	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
> +				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
>   		list_del(&pack->list);
>   		module_memfree(pack->ptr);
>   		kfree(pack);
> --
> 2.30.2

