Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD896B83C2
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 22:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCMVLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 17:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCMVLU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 17:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC4985B21;
        Mon, 13 Mar 2023 14:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C81E461509;
        Mon, 13 Mar 2023 21:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CDFC433EF;
        Mon, 13 Mar 2023 21:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678741843;
        bh=dxuRLSd8h1FoIH/fxYjwVcYLJFWUAKEsGBCisIu7SeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lB6IeSxnwVjumJTqMUq7yl8tTb66bzrRCuN4mKS9q+u6xdSxxrVeBkpGpV+vIgyT5
         42F5WKSsBeAfZzPdtTP+0s5YodNWn6fCD9sQx5EW6xfxq+WTsP7qi5khbjy2okB3v7
         NImg475O2ZJmUhxxe8pz26DcQzz+4nAyYX6L5JWKrL6NKVr3/n/2IT6L9Z+uiqDssY
         ngi2nxqEvH/+fJs82LH/gsfWxnTP3zOx1PfM5/7+oMkGPLjSKYcRLerWLB2NcYJ6Sy
         4nEJC1SforaVqvrfHPkptJeeH8ea8A3bbGnq20RiL9ItY5/y4xXelb4TvEtkAzue57
         kkCs30vgOYkmA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A10F74049F; Mon, 13 Mar 2023 18:10:40 -0300 (-03)
Date:   Mon, 13 Mar 2023 18:10:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf build: Remove libbpf pre-1.0 feature tests
Message-ID: <ZA+RUCE4vAgBlQRh@kernel.org>
References: <20230116010115.490713-1-irogers@google.com>
 <20230116010115.490713-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116010115.490713-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Jan 15, 2023 at 05:01:14PM -0800, Ian Rogers escreveu:
> The feature tests were necessary for libbpf pre-1.0, but as the libbpf
> implies at least 1.0 we can remove these now.

So I added this:

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 8b0bd3aa018ef166..b715cd4f43f4a014 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -580,7 +580,7 @@ ifndef NO_LIBELF
           EXTLIBS += -lbpf
           $(call detected,CONFIG_LIBBPF_DYNAMIC)
         else
-          dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
+          dummy := $(error Error: No libbpf devel library found or older than v1.0, please install/update libbpf-devel);
         endif
       else
         # Libbpf will be built as a static library from tools/lib/bpf.

To better reflect the failure reason:

⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-libbpf.make.output
test-libbpf.c:5:2: error: #error At least libbpf 1.0 is required for Linux tools.
    5 | #error At least libbpf 1.0 is required for Linux tools.
      |  ^~~~~
⬢[acme@toolbox perf-tools-next]$ rpm -q libbpf-devel
libbpf-devel-0.8.0-2.fc37.x86_64
⬢[acme@toolbox perf-tools-next]$

I'll see if I can make the build test conditional on libbpf being >= 1.0

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/build/feature/Makefile                  |  7 ---
>  .../feature/test-libbpf-bpf_map_create.c      |  8 ----
>  .../test-libbpf-bpf_object__next_map.c        |  8 ----
>  .../test-libbpf-bpf_object__next_program.c    |  8 ----
>  .../build/feature/test-libbpf-bpf_prog_load.c |  9 ----
>  .../test-libbpf-bpf_program__set_insns.c      |  8 ----
>  .../test-libbpf-btf__load_from_kernel_by_id.c |  8 ----
>  .../build/feature/test-libbpf-btf__raw_data.c |  8 ----
>  tools/perf/Makefile.config                    | 48 ++++---------------
>  9 files changed, 10 insertions(+), 102 deletions(-)
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_map_create.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_map.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_program.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_prog_load.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_program__set_insns.c
>  delete mode 100644 tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
>  delete mode 100644 tools/build/feature/test-libbpf-btf__raw_data.c
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 690fe97be190..dc9323e01e42 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -58,13 +58,6 @@ FILES=                                          \
>           test-lzma.bin                          \
>           test-bpf.bin                           \
>           test-libbpf.bin                        \
> -         test-libbpf-btf__load_from_kernel_by_id.bin	\
> -         test-libbpf-bpf_prog_load.bin          \
> -         test-libbpf-bpf_map_create.bin		\
> -         test-libbpf-bpf_object__next_program.bin \
> -         test-libbpf-bpf_object__next_map.bin   \
> -         test-libbpf-bpf_program__set_insns.bin	\
> -         test-libbpf-btf__raw_data.bin          \
>           test-get_cpuid.bin                     \
>           test-sdt.bin                           \
>           test-cxx.bin                           \
> diff --git a/tools/build/feature/test-libbpf-bpf_map_create.c b/tools/build/feature/test-libbpf-bpf_map_create.c
> deleted file mode 100644
> index b9f550e332c8..000000000000
> --- a/tools/build/feature/test-libbpf-bpf_map_create.c
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <bpf/bpf.h>
> -
> -int main(void)
> -{
> -	return bpf_map_create(0 /* map_type */, NULL /* map_name */, 0, /* key_size */,
> -			      0 /* value_size */, 0 /* max_entries */, NULL /* opts */);
> -}
> diff --git a/tools/build/feature/test-libbpf-bpf_object__next_map.c b/tools/build/feature/test-libbpf-bpf_object__next_map.c
> deleted file mode 100644
> index 64adb519e97e..000000000000
> --- a/tools/build/feature/test-libbpf-bpf_object__next_map.c
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <bpf/libbpf.h>
> -
> -int main(void)
> -{
> -	bpf_object__next_map(NULL /* obj */, NULL /* prev */);
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libbpf-bpf_object__next_program.c b/tools/build/feature/test-libbpf-bpf_object__next_program.c
> deleted file mode 100644
> index 8bf4fd26b545..000000000000
> --- a/tools/build/feature/test-libbpf-bpf_object__next_program.c
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <bpf/libbpf.h>
> -
> -int main(void)
> -{
> -	bpf_object__next_program(NULL /* obj */, NULL /* prev */);
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libbpf-bpf_prog_load.c b/tools/build/feature/test-libbpf-bpf_prog_load.c
> deleted file mode 100644
> index 47f516d63ebc..000000000000
> --- a/tools/build/feature/test-libbpf-bpf_prog_load.c
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <bpf/bpf.h>
> -
> -int main(void)
> -{
> -	return bpf_prog_load(0 /* prog_type */, NULL /* prog_name */,
> -			     NULL /* license */, NULL /* insns */,
> -			     0 /* insn_cnt */, NULL /* opts */);
> -}
> diff --git a/tools/build/feature/test-libbpf-bpf_program__set_insns.c b/tools/build/feature/test-libbpf-bpf_program__set_insns.c
> deleted file mode 100644
> index f3b7f18c8f49..000000000000
> --- a/tools/build/feature/test-libbpf-bpf_program__set_insns.c
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <bpf/libbpf.h>
> -
> -int main(void)
> -{
> -	bpf_program__set_insns(NULL /* prog */, NULL /* new_insns */, 0 /* new_insn_cnt */);
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c b/tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
> deleted file mode 100644
> index a17647f7d5a4..000000000000
> --- a/tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <bpf/btf.h>
> -
> -int main(void)
> -{
> -	btf__load_from_kernel_by_id(20151128);
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libbpf-btf__raw_data.c b/tools/build/feature/test-libbpf-btf__raw_data.c
> deleted file mode 100644
> index 57da31dd7581..000000000000
> --- a/tools/build/feature/test-libbpf-btf__raw_data.c
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <bpf/btf.h>
> -
> -int main(void)
> -{
> -	btf__raw_data(NULL /* btf_ro */, NULL /* size */);
> -	return 0;
> -}
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5b8784675903..5ab7cac48c4a 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -565,54 +565,26 @@ ifndef NO_LIBELF
>  
>        # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
>        $(call feature_check,libbpf)
> +
> +      # Feature test requires libbpf 1.0 so we can assume the following:
> +      CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
> +      CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
> +      CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
> +      CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_MAP
> +      CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
> +      CFLAGS += -DHAVE_LIBBPF_BTF__RAW_DATA
> +      CFLAGS += -DHAVE_LIBBPF_BPF_MAP_CREATE
> +
>        ifdef LIBBPF_DYNAMIC
>          ifeq ($(feature-libbpf), 1)
>            EXTLIBS += -lbpf
>            $(call detected,CONFIG_LIBBPF_DYNAMIC)
> -
> -          $(call feature_check,libbpf-btf__load_from_kernel_by_id)
> -          ifeq ($(feature-libbpf-btf__load_from_kernel_by_id), 1)
> -            CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
> -          endif
> -          $(call feature_check,libbpf-bpf_prog_load)
> -          ifeq ($(feature-libbpf-bpf_prog_load), 1)
> -            CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
> -          endif
> -          $(call feature_check,libbpf-bpf_object__next_program)
> -          ifeq ($(feature-libbpf-bpf_object__next_program), 1)
> -            CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
> -          endif
> -          $(call feature_check,libbpf-bpf_object__next_map)
> -          ifeq ($(feature-libbpf-bpf_object__next_map), 1)
> -            CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_MAP
> -          endif
> -          $(call feature_check,libbpf-bpf_program__set_insns)
> -          ifeq ($(feature-libbpf-bpf_program__set_insns), 1)
> -            CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
> -          else
> -            dummy := $(error Error: libbpf devel library needs to be >= 0.8.0 to build with LIBBPF_DYNAMIC, update or build statically with the version that comes with the kernel sources);
> -          endif
> -          $(call feature_check,libbpf-btf__raw_data)
> -          ifeq ($(feature-libbpf-btf__raw_data), 1)
> -            CFLAGS += -DHAVE_LIBBPF_BTF__RAW_DATA
> -          endif
> -          $(call feature_check,libbpf-bpf_map_create)
> -          ifeq ($(feature-libbpf-bpf_map_create), 1)
> -            CFLAGS += -DHAVE_LIBBPF_BPF_MAP_CREATE
> -          endif
>          else
>            dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
>          endif
>        else
>          # Libbpf will be built as a static library from tools/lib/bpf.
>  	LIBBPF_STATIC := 1
> -	CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
> -        CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
> -        CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
> -        CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_MAP
> -        CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
> -        CFLAGS += -DHAVE_LIBBPF_BTF__RAW_DATA
> -        CFLAGS += -DHAVE_LIBBPF_BPF_MAP_CREATE
>        endif
>      endif
>  
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 

- Arnaldo
