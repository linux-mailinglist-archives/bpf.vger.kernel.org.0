Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4989B68854A
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 18:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjBBRVb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 12:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjBBRVa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 12:21:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C1712E2
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 09:21:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08E68B82753
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 17:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01064C433D2;
        Thu,  2 Feb 2023 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675358486;
        bh=6MjyncxlCvdr097ZGQfY2kth//DI4BSa1Y9lYv42dMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofTH/IBokEdlgdsVzNwApIZMrStiYi3798nb/zb/IHvktv3/L9NCMFwWxTPOrSxQV
         I5VnQlKpp2kraOyq0DReWLOZ+kdJaTGUyD3gc2/rG8m/ejhyCGI6QlHzMxPbyUALwX
         So0RW2G6Jfa3tRH5SXvJnA9y9q0jj2EFjdtlQtu3x97IOGSjig9vNLQ8A4qG+KDa97
         Wr5kb/dWoMJXDA+ONUwomd0S2WetWiObk5xu1K8/O+SAB4iCCTvEuNqSg1bnhyqn87
         T5js7k7gERmGh1HKPOnR1RRzcli0v2iyA+sAXajCcipahwfOmvHaXT2IGQvWqicchg
         fBDgxINpybpYQ==
Date:   Thu, 2 Feb 2023 10:21:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ian Rogers <irogers@google.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Compile resolve_btfids as
 host program
Message-ID: <Y9vxFLA6Xj/zPjQu@dev-arch.thelio-3990X>
References: <20230202112839.1131892-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202112839.1131892-1-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 12:28:39PM +0100, Jiri Olsa wrote:
> Making resolve_btfids to be compiled as host program so
> we can avoid cross compile issues as reported by Nathan.
> 
> Also we no longer need HOST_OVERRIDES for BINARY target,
> just for 'prepare' targets.
> 
> Cc: Ian Rogers <irogers@google.com>
> Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/bpf/resolve_btfids/Build    | 4 +++-
>  tools/bpf/resolve_btfids/Makefile | 9 ++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
> index ae82da03f9bf..077de3829c72 100644
> --- a/tools/bpf/resolve_btfids/Build
> +++ b/tools/bpf/resolve_btfids/Build
> @@ -1,3 +1,5 @@
> +hostprogs := resolve_btfids
> +
>  resolve_btfids-y += main.o
>  resolve_btfids-y += rbtree.o
>  resolve_btfids-y += zalloc.o
> @@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
>  
>  $(OUTPUT)%.o: ../../lib/%.c FORCE
>  	$(call rule_mkdir)
> -	$(call if_changed_dep,cc_o_c)
> +	$(call if_changed_dep,host_cc_o_c)
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index daed388aa5d7..abdd68ac08f4 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
>  		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
>  
>  RM      ?= rm
> +HOSTCC  ?= gcc
> +HOSTLD  ?= ld
> +HOSTAR  ?= ar
>  CROSS_COMPILE =
>  
>  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> @@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>  
> -CFLAGS += -g \
> +HOSTCFLAGS += -g \
>            -I$(srctree)/tools/include \
>            -I$(srctree)/tools/include/uapi \
>            -I$(LIBBPF_INCLUDE) \
> @@ -73,11 +76,11 @@ CFLAGS += -g \
>  
>  LIBS = $(LIBELF_LIBS) -lz
>  
> -export srctree OUTPUT CFLAGS Q
> +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
>  include $(srctree)/tools/build/Makefile.include
>  
>  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> -	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
> +	$(Q)$(MAKE) $(build)=resolve_btfids
>  
>  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
>  	$(call msg,LINK,$@)
> -- 
> 2.39.1
> 
