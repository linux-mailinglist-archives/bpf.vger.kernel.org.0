Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A91254C5B
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 19:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0Rog (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 13:44:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:22087 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgH0Rof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 13:44:35 -0400
IronPort-SDR: rAcp7JkpB1QTGfjz3J7+3HmdsrwW7e6oyptYtPi9Tmuva4g2DD8a6JndtrTktI3+rOBzJMmFGi
 0Pgr422O3kmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="154089656"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="154089656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 10:44:33 -0700
IronPort-SDR: 8ExoDBvszRY/YbkRUjQAJF0Fjz03PuadL/Uf8TtAVQmpSjJ1u0TdQz3VVAqtC6xGU8+FUmeVO8
 t+UlRXXDeN3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="475318598"
Received: from wricherx-mobl1.ger.corp.intel.com (HELO [10.249.140.235]) ([10.249.140.235])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2020 10:44:24 -0700
Subject: Re: [PATCH bpf-next 1/6] tools: Factor HOSTCC, HOSTLD, HOSTAR
 definitions
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
References: <20200827153629.3820891-1-jean-philippe@linaro.org>
 <20200827153629.3820891-2-jean-philippe@linaro.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <58fc65fd-9675-0126-f575-d64008ba8057@intel.com>
Date:   Thu, 27 Aug 2020 19:44:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200827153629.3820891-2-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/27/2020 5:36 PM, Jean-Philippe Brucker wrote:
> Several Makefiles in tools/ need to define the host toolchain variables.
> Move their definition to tools/scripts/Makefile.include
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Erik Kaneda <erik.kaneda@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: devel@acpica.org

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI part.


> ---
>   tools/bpf/resolve_btfids/Makefile |  9 ---------
>   tools/build/Makefile              |  4 ----
>   tools/objtool/Makefile            |  9 ---------
>   tools/perf/Makefile.perf          |  4 ----
>   tools/power/acpi/Makefile.config  |  1 -
>   tools/scripts/Makefile.include    | 10 ++++++++++
>   6 files changed, 10 insertions(+), 27 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index a88cd4426398..b06935578a96 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -17,15 +17,6 @@ else
>   endif
>   
>   # always use the host compiler
> -ifneq ($(LLVM),)
> -HOSTAR  ?= llvm-ar
> -HOSTCC  ?= clang
> -HOSTLD  ?= ld.lld
> -else
> -HOSTAR  ?= ar
> -HOSTCC  ?= gcc
> -HOSTLD  ?= ld
> -endif
>   AR       = $(HOSTAR)
>   CC       = $(HOSTCC)
>   LD       = $(HOSTLD)
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 727050c40f09..8a55378e8b7c 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -15,10 +15,6 @@ endef
>   $(call allow-override,CC,$(CROSS_COMPILE)gcc)
>   $(call allow-override,LD,$(CROSS_COMPILE)ld)
>   
> -HOSTCC ?= gcc
> -HOSTLD ?= ld
> -HOSTAR ?= ar
> -
>   export HOSTCC HOSTLD HOSTAR
>   
>   ifeq ($(V),1)
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 7770edcda3a0..b7cb4f26ccde 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -3,15 +3,6 @@ include ../scripts/Makefile.include
>   include ../scripts/Makefile.arch
>   
>   # always use the host compiler
> -ifneq ($(LLVM),)
> -HOSTAR	?= llvm-ar
> -HOSTCC	?= clang
> -HOSTLD	?= ld.lld
> -else
> -HOSTAR	?= ar
> -HOSTCC	?= gcc
> -HOSTLD	?= ld
> -endif
>   AR	 = $(HOSTAR)
>   CC	 = $(HOSTCC)
>   LD	 = $(HOSTLD)
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 6031167939ae..43e90334a54e 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -175,10 +175,6 @@ endef
>   
>   LD += $(EXTRA_LDFLAGS)
>   
> -HOSTCC  ?= gcc
> -HOSTLD  ?= ld
> -HOSTAR  ?= ar
> -
>   PKG_CONFIG = $(CROSS_COMPILE)pkg-config
>   LLVM_CONFIG ?= llvm-config
>   
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
> index 54a2857c2510..331f6d30f472 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -54,7 +54,6 @@ INSTALL_SCRIPT = ${INSTALL_PROGRAM}
>   CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
>   CROSS_COMPILE ?= $(CROSS)
>   LD = $(CC)
> -HOSTCC = gcc
>   
>   # check if compiler option is supported
>   cc-supports = ${shell if $(CC) ${1} -S -o /dev/null -x c /dev/null > /dev/null 2>&1; then echo "$(1)"; fi;}
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index a7974638561c..1358e89cdf7d 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -59,6 +59,16 @@ $(call allow-override,LD,$(CROSS_COMPILE)ld)
>   $(call allow-override,CXX,$(CROSS_COMPILE)g++)
>   $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
>   
> +ifneq ($(LLVM),)
> +HOSTAR  ?= llvm-ar
> +HOSTCC  ?= clang
> +HOSTLD  ?= ld.lld
> +else
> +HOSTAR  ?= ar
> +HOSTCC  ?= gcc
> +HOSTLD  ?= ld
> +endif
> +
>   ifeq ($(CC_NO_CLANG), 1)
>   EXTRA_WARNINGS += -Wstrict-aliasing=3
>   endif


