Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5E055FC55
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiF2JlJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 05:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiF2JlE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 05:41:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6033B3FC
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 02:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656495663; x=1688031663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XAoZ4vmWggjhVe0yk9oGxq4flzJ0ZXd/YvuEidieRGg=;
  b=Q/e452j2tcb+Jk5MeJ+h53IUuOoiwYZ4nTzQS/4wZOIb179k3QyKDujn
   yhpalwouCtY9u7F0yWyj3b2KviMxmnJNaM6t6R9If5/ZJ9rD+coHGAIKT
   jwMINQEPBNyUAEk2GRQxMItG80XzB/1w3L0k6lcKMCIb2WjQhA5krm6VY
   oKJsFw60G2xB3QOZVZHIJ+9LnZAwoiafOdgbTmafuK1eF8bMBtSCz46sn
   6/FHs0zjrTLGJomI88Y8Y5RTBZxg4Y/MLJTVDR0cXWmK0a1cSEIXwFCkT
   l3v45KJVExrG/ittmZhvYQURZQZhEdlYXSUWPAltPdb9D25cj/1JG7gZp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280749776"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="280749776"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="588247599"
Received: from boxer.igk.intel.com (HELO boxer) ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 02:41:01 -0700
Date:   Wed, 29 Jun 2022 11:41:00 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/15] libbpf: move xsk.{c,h} into
 selftests/bpf
Message-ID: <YrweLB7omwEe/cR1@boxer>
References: <20220627211527.2245459-1-andrii@kernel.org>
 <20220627211527.2245459-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627211527.2245459-2-andrii@kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 27, 2022 at 02:15:13PM -0700, Andrii Nakryiko wrote:
> Remove deprecated xsk APIs from libbpf. But given we have selftests
> relying on this, move those files (with minimal adjustments to make them
> compilable) under selftests/bpf.
> 
> We also remove all the removed APIs from libbpf.map, while overall
> keeping version inheritance chain, as most APIs are backwards
> compatible so there is no need to reassign them as LIBBPF_1.0.0 versions.

Hey Andrii,

First of all, great that you are moving this over to selftests where we
can use this as the base for our upcoming control path tests. However,
during some of our selftests work we have found a bug in the xsk part of
libbpf that you're moving here. What is the way forward to fixing this
from your perspective? Should we wait once this set lands so that we would
fix this in the xsk.c file in selftests/bpf? Or would you pick the bugfix
before doing the move?

Also, what is the timeline for landing libbpf 1.0?

> 
> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/Build                        |  2 +-
>  tools/lib/bpf/Makefile                     |  2 +-
>  tools/lib/bpf/libbpf.map                   | 12 ----
>  tools/testing/selftests/bpf/Makefile       |  2 +
>  tools/testing/selftests/bpf/xdpxceiver.c   |  2 +-
>  tools/{lib => testing/selftests}/bpf/xsk.c | 76 ++++++++++++----------
>  tools/{lib => testing/selftests}/bpf/xsk.h | 29 ++-------
>  7 files changed, 49 insertions(+), 76 deletions(-)
>  rename tools/{lib => testing/selftests}/bpf/xsk.c (95%)
>  rename tools/{lib => testing/selftests}/bpf/xsk.h (84%)
> 
> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> index 31a1a9015902..5a3dfb56d78f 100644
> --- a/tools/lib/bpf/Build
> +++ b/tools/lib/bpf/Build
> @@ -1,4 +1,4 @@
>  libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
> -	    netlink.o bpf_prog_linfo.o libbpf_probes.o xsk.o hashmap.o \
> +	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
>  	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
>  	    usdt.o
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index a1265b152027..4c904ef0b47e 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -237,7 +237,7 @@ install_lib: all_cmd
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
>  
> -SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h	     \
> +SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h	     \
>  	    bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h	     \
>  	    skel_internal.h libbpf_version.h usdt.bpf.h
>  GEN_HDRS := $(BPF_GENERATED)
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 116a2a8ee7c2..da7a4f928452 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -147,12 +147,6 @@ LIBBPF_0.0.2 {
>  		btf_ext__new;
>  		btf_ext__reloc_func_info;
>  		btf_ext__reloc_line_info;
> -		xsk_umem__create;
> -		xsk_socket__create;
> -		xsk_umem__delete;
> -		xsk_socket__delete;
> -		xsk_umem__fd;
> -		xsk_socket__fd;
>  		bpf_program__get_prog_info_linear;
>  		bpf_program__bpil_addr_to_offs;
>  		bpf_program__bpil_offs_to_addr;
> @@ -183,7 +177,6 @@ LIBBPF_0.0.4 {
>  		perf_buffer__new;
>  		perf_buffer__new_raw;
>  		perf_buffer__poll;
> -		xsk_umem__create;
>  } LIBBPF_0.0.3;
>  
>  LIBBPF_0.0.5 {
> @@ -336,7 +329,6 @@ LIBBPF_0.2.0 {
>  		perf_buffer__buffer_fd;
>  		perf_buffer__epoll_fd;
>  		perf_buffer__consume_buffer;
> -		xsk_socket__create_shared;
>  } LIBBPF_0.1.0;
>  
>  LIBBPF_0.3.0 {
> @@ -348,8 +340,6 @@ LIBBPF_0.3.0 {
>  		btf__new_empty_split;
>  		btf__new_split;
>  		ring_buffer__epoll_fd;
> -		xsk_setup_xdp_prog;
> -		xsk_socket__update_xskmap;
>  } LIBBPF_0.2.0;
>  
>  LIBBPF_0.4.0 {
> @@ -468,6 +458,4 @@ LIBBPF_1.0.0 {
>  		libbpf_bpf_link_type_str;
>  		libbpf_bpf_map_type_str;
>  		libbpf_bpf_prog_type_str;
> -
> -	local: *;
>  };
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 4fbd88a8ed9e..e32a28fe8bc1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -230,6 +230,8 @@ $(OUTPUT)/xdping: $(TESTING_HELPERS)
>  $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
>  $(OUTPUT)/test_maps: $(TESTING_HELPERS)
>  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS)
> +$(OUTPUT)/xsk.o: $(BPFOBJ)
> +$(OUTPUT)/xdpxceiver: $(OUTPUT)/xsk.o
>  
>  BPFTOOL ?= $(DEFAULT_BPFTOOL)
>  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
> diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
> index e5992a6b5e09..019c567b6b4e 100644
> --- a/tools/testing/selftests/bpf/xdpxceiver.c
> +++ b/tools/testing/selftests/bpf/xdpxceiver.c
> @@ -97,7 +97,7 @@
>  #include <time.h>
>  #include <unistd.h>
>  #include <stdatomic.h>
> -#include <bpf/xsk.h>
> +#include "xsk.h"
>  #include "xdpxceiver.h"
>  #include "../kselftest.h"
>  
> diff --git a/tools/lib/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
> similarity index 95%
> rename from tools/lib/bpf/xsk.c
> rename to tools/testing/selftests/bpf/xsk.c
> index af136f73b09d..eb50c3f336f8 100644
> --- a/tools/lib/bpf/xsk.c
> +++ b/tools/testing/selftests/bpf/xsk.c
> @@ -30,16 +30,10 @@
>  #include <sys/types.h>
>  #include <linux/if_link.h>
>  
> -#include "bpf.h"
> -#include "libbpf.h"
> -#include "libbpf_internal.h"
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
>  #include "xsk.h"
>  
> -/* entire xsk.h and xsk.c is going away in libbpf 1.0, so ignore all internal
> - * uses of deprecated APIs
> - */
> -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> -
>  #ifndef SOL_XDP
>   #define SOL_XDP 283
>  #endif
> @@ -52,6 +46,8 @@
>   #define PF_XDP AF_XDP
>  #endif
>  
> +#define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
> +
>  enum xsk_prog {
>  	XSK_PROG_FALLBACK,
>  	XSK_PROG_REDIRECT_FLAGS,
> @@ -286,11 +282,10 @@ static int xsk_create_umem_rings(struct xsk_umem *umem, int fd,
>  	return err;
>  }
>  
> -DEFAULT_VERSION(xsk_umem__create_v0_0_4, xsk_umem__create, LIBBPF_0.0.4)
> -int xsk_umem__create_v0_0_4(struct xsk_umem **umem_ptr, void *umem_area,
> -			    __u64 size, struct xsk_ring_prod *fill,
> -			    struct xsk_ring_cons *comp,
> -			    const struct xsk_umem_config *usr_config)
> +int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area,
> +		     __u64 size, struct xsk_ring_prod *fill,
> +		     struct xsk_ring_cons *comp,
> +		     const struct xsk_umem_config *usr_config)
>  {
>  	struct xdp_umem_reg mr;
>  	struct xsk_umem *umem;
> @@ -351,25 +346,9 @@ struct xsk_umem_config_v1 {
>  	__u32 frame_headroom;
>  };
>  
> -COMPAT_VERSION(xsk_umem__create_v0_0_2, xsk_umem__create, LIBBPF_0.0.2)
> -int xsk_umem__create_v0_0_2(struct xsk_umem **umem_ptr, void *umem_area,
> -			    __u64 size, struct xsk_ring_prod *fill,
> -			    struct xsk_ring_cons *comp,
> -			    const struct xsk_umem_config *usr_config)
> -{
> -	struct xsk_umem_config config;
> -
> -	memcpy(&config, usr_config, sizeof(struct xsk_umem_config_v1));
> -	config.flags = 0;
> -
> -	return xsk_umem__create_v0_0_4(umem_ptr, umem_area, size, fill, comp,
> -					&config);
> -}
> -
>  static enum xsk_prog get_xsk_prog(void)
>  {
>  	enum xsk_prog detected = XSK_PROG_FALLBACK;
> -	__u32 size_out, retval, duration;
>  	char data_in = 0, data_out;
>  	struct bpf_insn insns[] = {
>  		BPF_LD_MAP_FD(BPF_REG_1, 0),
> @@ -378,6 +357,12 @@ static enum xsk_prog get_xsk_prog(void)
>  		BPF_EMIT_CALL(BPF_FUNC_redirect_map),
>  		BPF_EXIT_INSN(),
>  	};
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.data_in = &data_in,
> +		.data_size_in = 1,
> +		.data_out = &data_out,
> +	);
> +
>  	int prog_fd, map_fd, ret, insn_cnt = ARRAY_SIZE(insns);
>  
>  	map_fd = bpf_map_create(BPF_MAP_TYPE_XSKMAP, NULL, sizeof(int), sizeof(int), 1, NULL);
> @@ -392,8 +377,8 @@ static enum xsk_prog get_xsk_prog(void)
>  		return detected;
>  	}
>  
> -	ret = bpf_prog_test_run(prog_fd, 0, &data_in, 1, &data_out, &size_out, &retval, &duration);
> -	if (!ret && retval == XDP_PASS)
> +	ret = bpf_prog_test_run_opts(prog_fd, &opts);
> +	if (!ret && opts.retval == XDP_PASS)
>  		detected = XSK_PROG_REDIRECT_FLAGS;
>  	close(prog_fd);
>  	close(map_fd);
> @@ -510,7 +495,7 @@ static int xsk_create_bpf_link(struct xsk_socket *xsk)
>  	int link_fd;
>  	int err;
>  
> -	err = bpf_get_link_xdp_id(ctx->ifindex, &prog_id, xsk->config.xdp_flags);
> +	err = bpf_xdp_query_id(ctx->ifindex, xsk->config.xdp_flags, &prog_id);
>  	if (err) {
>  		pr_warn("getting XDP prog id failed\n");
>  		return err;
> @@ -536,6 +521,25 @@ static int xsk_create_bpf_link(struct xsk_socket *xsk)
>  	return 0;
>  }
>  
> +/* Copy up to sz - 1 bytes from zero-terminated src string and ensure that dst
> + * is zero-terminated string no matter what (unless sz == 0, in which case
> + * it's a no-op). It's conceptually close to FreeBSD's strlcpy(), but differs
> + * in what is returned. Given this is internal helper, it's trivial to extend
> + * this, when necessary. Use this instead of strncpy inside libbpf source code.
> + */
> +static inline void libbpf_strlcpy(char *dst, const char *src, size_t sz)
> +{
> +        size_t i;
> +
> +        if (sz == 0)
> +                return;
> +
> +        sz--;
> +        for (i = 0; i < sz && src[i]; i++)
> +                dst[i] = src[i];
> +        dst[i] = '\0';
> +}
> +
>  static int xsk_get_max_queues(struct xsk_socket *xsk)
>  {
>  	struct ethtool_channels channels = { .cmd = ETHTOOL_GCHANNELS };
> @@ -792,8 +796,8 @@ static int xsk_init_xdp_res(struct xsk_socket *xsk,
>  	if (ctx->has_bpf_link)
>  		err = xsk_create_bpf_link(xsk);
>  	else
> -		err = bpf_set_link_xdp_fd(xsk->ctx->ifindex, ctx->prog_fd,
> -					  xsk->config.xdp_flags);
> +		err = bpf_xdp_attach(xsk->ctx->ifindex, ctx->prog_fd,
> +				     xsk->config.xdp_flags, NULL);
>  
>  	if (err)
>  		goto err_attach_xdp_prog;
> @@ -811,7 +815,7 @@ static int xsk_init_xdp_res(struct xsk_socket *xsk,
>  	if (ctx->has_bpf_link)
>  		close(ctx->link_fd);
>  	else
> -		bpf_set_link_xdp_fd(ctx->ifindex, -1, 0);
> +		bpf_xdp_detach(ctx->ifindex, 0, NULL);
>  err_attach_xdp_prog:
>  	close(ctx->prog_fd);
>  err_load_xdp_prog:
> @@ -862,7 +866,7 @@ static int __xsk_setup_xdp_prog(struct xsk_socket *_xdp, int *xsks_map_fd)
>  	if (ctx->has_bpf_link)
>  		err = xsk_link_lookup(ctx->ifindex, &prog_id, &ctx->link_fd);
>  	else
> -		err = bpf_get_link_xdp_id(ctx->ifindex, &prog_id, xsk->config.xdp_flags);
> +		err = bpf_xdp_query_id(ctx->ifindex, xsk->config.xdp_flags, &prog_id);
>  
>  	if (err)
>  		return err;
> diff --git a/tools/lib/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
> similarity index 84%
> rename from tools/lib/bpf/xsk.h
> rename to tools/testing/selftests/bpf/xsk.h
> index 64e9c57fd792..915e7135337c 100644
> --- a/tools/lib/bpf/xsk.h
> +++ b/tools/testing/selftests/bpf/xsk.h
> @@ -9,15 +9,15 @@
>   * Author(s): Magnus Karlsson <magnus.karlsson@intel.com>
>   */
>  
> -#ifndef __LIBBPF_XSK_H
> -#define __LIBBPF_XSK_H
> +#ifndef __XSK_H
> +#define __XSK_H
>  
>  #include <stdio.h>
>  #include <stdint.h>
>  #include <stdbool.h>
>  #include <linux/if_xdp.h>
>  
> -#include "libbpf.h"
> +#include <bpf/libbpf.h>
>  
>  #ifdef __cplusplus
>  extern "C" {
> @@ -251,9 +251,7 @@ static inline __u64 xsk_umem__add_offset_to_addr(__u64 addr)
>  	return xsk_umem__extract_addr(addr) + xsk_umem__extract_offset(addr);
>  }
>  
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
>  int xsk_umem__fd(const struct xsk_umem *umem);
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
>  int xsk_socket__fd(const struct xsk_socket *xsk);
>  
>  #define XSK_RING_CONS__DEFAULT_NUM_DESCS      2048
> @@ -271,9 +269,7 @@ struct xsk_umem_config {
>  	__u32 flags;
>  };
>  
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
>  int xsk_setup_xdp_prog(int ifindex, int *xsks_map_fd);
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
>  int xsk_socket__update_xskmap(struct xsk_socket *xsk, int xsks_map_fd);
>  
>  /* Flags for the libbpf_flags field. */
> @@ -288,32 +284,17 @@ struct xsk_socket_config {
>  };
>  
>  /* Set config to NULL to get the default configuration. */
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
>  int xsk_umem__create(struct xsk_umem **umem,
>  		     void *umem_area, __u64 size,
>  		     struct xsk_ring_prod *fill,
>  		     struct xsk_ring_cons *comp,
>  		     const struct xsk_umem_config *config);
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
> -int xsk_umem__create_v0_0_2(struct xsk_umem **umem,
> -			    void *umem_area, __u64 size,
> -			    struct xsk_ring_prod *fill,
> -			    struct xsk_ring_cons *comp,
> -			    const struct xsk_umem_config *config);
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
> -int xsk_umem__create_v0_0_4(struct xsk_umem **umem,
> -			    void *umem_area, __u64 size,
> -			    struct xsk_ring_prod *fill,
> -			    struct xsk_ring_cons *comp,
> -			    const struct xsk_umem_config *config);
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
>  int xsk_socket__create(struct xsk_socket **xsk,
>  		       const char *ifname, __u32 queue_id,
>  		       struct xsk_umem *umem,
>  		       struct xsk_ring_cons *rx,
>  		       struct xsk_ring_prod *tx,
>  		       const struct xsk_socket_config *config);
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
>  int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
>  			      const char *ifname,
>  			      __u32 queue_id, struct xsk_umem *umem,
> @@ -324,13 +305,11 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
>  			      const struct xsk_socket_config *config);
>  
>  /* Returns 0 for success and -EBUSY if the umem is still in use. */
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
>  int xsk_umem__delete(struct xsk_umem *umem);
> -LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "AF_XDP support deprecated and moved to libxdp")
>  void xsk_socket__delete(struct xsk_socket *xsk);
>  
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
>  
> -#endif /* __LIBBPF_XSK_H */
> +#endif /* __XSK_H */
> -- 
> 2.30.2
> 
