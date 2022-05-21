Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A652F73B
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 03:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347006AbiEUBBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 21:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350544AbiEUBBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 21:01:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61354515A7;
        Fri, 20 May 2022 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4pzvRwoVdtYoVcWFyyAnPE0HISlku86yFUDDkjyuoZg=; b=C/vAXd2A8NSnWf9Ia9CxZQ7HWd
        eC1jdZIkoq35cFPNjQB8DPs6mJdeEt29TIQKDtnkgjTYYrqS5utyu2EdsBEetVG2MYF9g3veZ6QWT
        WUt6QyMaT+/NTh9CEbnVWqefeoZ1ZnVkPcl/PO6MzUPEkKQgLStT20xPGZ8aCDlbE/stjtP0o3iUY
        FwCP/FbIfiRlr3xi5bOCpBew9Yh/5vgQsIHxVpMh3X4TrkWSNGpxpWZcOY+O0xoPid/aRQckcFURd
        J1liBHgnehV8y9wgUXvJiGLzAgbrRWalq0pKefjdnhl6e0XK6iJRFCeZrjRYi2iz6PtNz9au59awl
        O3qVzKrA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsDUH-00F5i2-1l; Sat, 21 May 2022 01:00:57 +0000
Date:   Fri, 20 May 2022 18:00:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-mm@kvack.org, ast@kernel.org, daniel@iogearbox.net,
        peterz@infradead.org, torvalds@linux-foundation.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Message-ID: <Yog5yXqAQZAmpgCD@bombadil.infradead.org>
References: <20220520031548.338934-1-song@kernel.org>
 <20220520031548.338934-6-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520031548.338934-6-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 19, 2022 at 08:15:45PM -0700, Song Liu wrote:
> Also, remove set_vm_flush_reset_perms() from alloc_new_pack() and use
> set_memory_[nx|rw] in bpf_prog_pack_free(). This is because
> VM_FLUSH_RESET_PERMS does not work with huge pages yet. [1]
> 
> [1] https://lore.kernel.org/bpf/aeeeaf0b7ec63fdba55d4834d2f524d8bf05b71b.camel@intel.com/
> Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Song Liu <song@kernel.org>
> ---

Rick,

although VM_FLUSH_RESET_PERMS is rather new my concern here is we're
essentially enabling sloppy users to grow without also addressing
what if we have to take the leash back to support VM_FLUSH_RESET_PERMS
properly? If the hack to support this on other architectures other than
x86 is as simple as the one you in vm_remove_mappings() today:

	if (flush_reset && !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
		set_memory_nx(addr, area->nr_pages);
		set_memory_rw(addr, area->nr_pages);
	}

then I suppose this isn't a big deal. I'm just concerned here this being
a slippery slope of sloppiness leading to something which we will
regret later.

My intution tells me this shouldn't be a big issue, but I just want to
confirm.

  Luis

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index cacd8684c3c4..b64d91fcb0ba 100644
> @@ -949,6 +947,8 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
>  
>  	mutex_lock(&pack_mutex);
>  	if (hdr->size > bpf_prog_pack_size) {
> +		set_memory_nx((unsigned long)hdr, hdr->size / PAGE_SIZE);
> +		set_memory_rw((unsigned long)hdr, hdr->size / PAGE_SIZE);
>  		module_memfree(hdr);
>  		goto out;
>  	}
> @@ -975,6 +975,8 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
>  	if (bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
>  				       bpf_prog_chunk_count(), 0) == 0) {
>  		list_del(&pack->list);
> +		set_memory_nx((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
> +		set_memory_rw((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
>  		module_memfree(pack->ptr);
>  		kfree(pack);
>  	}
> -- 
> 2.30.2
> 
