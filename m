Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3D62AC326
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 19:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgKISFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 13:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgKISFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 13:05:04 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B927A20665;
        Mon,  9 Nov 2020 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604945102;
        bh=vEGmaXFSAlmlJhVlqTb75fDxhB10+fY7IZE9/egG9DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPgtP1ZsB8NR+BPAzD7xi6srB/zTtM94awqTaDcpB25RQsRNBVHBee1x/PRYxPqbx
         Ki9vvzWKPAWlTwDdCL/6PnKi+EzL4x+VXZXZ29f5zqZPt8PrMuoxn8MCrlJE21911I
         n3wsGdlB5g7diO13GKW94UmIkwZoL6TXKwxynyHg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F286411D1; Mon,  9 Nov 2020 15:05:00 -0300 (-03)
Date:   Mon, 9 Nov 2020 15:05:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 1/3] bpf: Move iterator functions into special init
 section
Message-ID: <20201109180500.GC340169@kernel.org>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <20201106222512.52454-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106222512.52454-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Nov 06, 2020 at 11:25:10PM +0100, Jiri Olsa escreveu:
> With upcoming changes to pahole, that change the way how and
> which kernel functions are stored in BTF data, we need a way
> to recognize iterator functions.
> 
> Iterator functions need to be in BTF data, but have no real
> body and are currently placed in .init.text section, so they
> are freed after kernel init and are filtered out of BTF data
> because of that.
> 
> The solution is to place these functions under new section:
>   .init.bpf.preserve_type
> 
> And add 2 new symbols to mark that area:
>   __init_bpf_preserve_type_begin
>   __init_bpf_preserve_type_end
> 
> The code in pahole responsible for picking up the functions will
> be able to recognize functions from this section and add them to
> the BTF data and filter out all other .init.text functions.

This isn't applying on torvalds/master:

[acme@five linux]$ patch -p1 < /wb/1.patch
patching file include/asm-generic/vmlinux.lds.h
Hunk #2 succeeded at 754 (offset 1 line).
patching file include/linux/bpf.h
Hunk #1 succeeded at 1276 (offset -1 lines).
patching file include/linux/init.h
Hunk #1 FAILED at 52.
1 out of 1 hunk FAILED -- saving rejects to file include/linux/init.h.rej
[acme@five linux]$
[acme@five linux]$ cat include/linux/init.h.rej
--- include/linux/init.h
+++ include/linux/init.h
@@ -52,6 +52,7 @@
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
 #define __exit_call	__used __section(.exitcall.exit)
+#define __init_bpf_preserve_type __section(.init.bpf.preserve_type)

 /*
  * modpost check for section mismatches during the kernel build.
[acme@five linux]$


I'm fixing it up by hand to try together with pahole's patches.

- Arnaldo
 
> Suggested-by: Yonghong Song <yhs@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@redhat.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 16 +++++++++++++++-
>  include/linux/bpf.h               |  8 +++++++-
>  include/linux/init.h              |  1 +
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index cd14444bf600..e18e1030dabf 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -685,8 +685,21 @@
>  	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
>  		*(.BTF_ids)						\
>  	}
> +
> +/*
> + * .init.bpf.preserve_type
> + *
> + * This section store special BPF function and marks them
> + * with begin/end symbols pair for the sake of pahole tool.
> + */
> +#define INIT_BPF_PRESERVE_TYPE						\
> +	__init_bpf_preserve_type_begin = .;                             \
> +	*(.init.bpf.preserve_type)                                      \
> +	__init_bpf_preserve_type_end = .;				\
> +	MEM_DISCARD(init.bpf.preserve_type)
>  #else
>  #define BTF
> +#define INIT_BPF_PRESERVE_TYPE
>  #endif
>  
>  /*
> @@ -740,7 +753,8 @@
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\
>  	*(.text.startup)						\
> -	MEM_DISCARD(init.text*)
> +	MEM_DISCARD(init.text*)						\
> +	INIT_BPF_PRESERVE_TYPE
>  
>  #define EXIT_DATA							\
>  	*(.exit.data .exit.data.*)					\
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 73d5381a5d5c..894f66c7703e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1277,10 +1277,16 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>  int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
>  int bpf_obj_get_user(const char __user *pathname, int flags);
>  
> +#ifdef CONFIG_DEBUG_INFO_BTF
> +#define BPF_INIT __init_bpf_preserve_type
> +#else
> +#define BPF_INIT __init
> +#endif
> +
>  #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
>  #define DEFINE_BPF_ITER_FUNC(target, args...)			\
>  	extern int bpf_iter_ ## target(args);			\
> -	int __init bpf_iter_ ## target(args) { return 0; }
> +	int BPF_INIT bpf_iter_ ## target(args) { return 0; }
>  
>  struct bpf_iter_aux_info {
>  	struct bpf_map *map;
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 212fc9e2f691..133462863711 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -52,6 +52,7 @@
>  #define __initconst	__section(.init.rodata)
>  #define __exitdata	__section(.exit.data)
>  #define __exit_call	__used __section(.exitcall.exit)
> +#define __init_bpf_preserve_type __section(.init.bpf.preserve_type)
>  
>  /*
>   * modpost check for section mismatches during the kernel build.
> -- 
> 2.26.2
> 

-- 

- Arnaldo
