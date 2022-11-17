Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2B62E18C
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbiKQQYR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbiKQQXy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:23:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B721087551;
        Thu, 17 Nov 2022 08:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56D90B82107;
        Thu, 17 Nov 2022 16:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA21BC433D6;
        Thu, 17 Nov 2022 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702091;
        bh=n/NygUzBhqd3ZFxs/8CYZcGgEnlZ8O9Ef6l1bU7dJ0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2xV2OBD+Sb6EAp+o9CKPmmt1dZkPU38ljg9ZiKtG/LsmKrdlt+FKCypGpDJWL82a
         IuHfZWrPFyjdYFSCjRvuVCh72To4YVtuUFzh3W+Jo521nobqjCnika+/HthJxjFaX8
         rZoDwsLu7AluvlD1cStNMqgEnpuN+k9bye8qaK2N7qyKbzvE1RCbUyU5T0cgSuYjFD
         8AzEKwApCWHuGqbFx4acJjx9vXawB//c81zdFKGKZ5Rk3hsAWLk+GriALwxHK76uuV
         uDgwEpWBxh1GrV/K9MwVUK37X7J5wSxn8fX9BE88TLIKuBjnSQgu6KPIEhARyesHHw
         IxJQ6ZL0dO4xQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FA884034E; Thu, 17 Nov 2022 13:21:28 -0300 (-03)
Date:   Thu, 17 Nov 2022 13:21:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf build: Fix LIBTRACEEVENT_DYNAMIC
Message-ID: <Y3ZfiGFJ+EKIahsW@kernel.org>
References: <20221116224631.207631-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116224631.207631-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 16, 2022 at 02:46:31PM -0800, Ian Rogers escreveu:
> The tools/lib includes fixes break LIBTRACEVENT_DYNAMIC as the
> makefile erroneously had depdendencies on building libtraceevent even
> when not linking with it. This change fixes the issues with
> LIBTRACEEVENT_DYNAMIC by making the built files optional.

I had noticed this but didn't come around to fix it, thanks!

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf | 25 ++++++++++++++++++++++---
>  tools/perf/util/setup.py |  3 ++-
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index dd096aba4430..59c4e8f9b014 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -242,8 +242,10 @@ sub-make: fixdep
>  else # force_fixdep
>  
>  LIBAPI_DIR      = $(srctree)/tools/lib/api/
> +ifndef LIBTRACEEVENT_DYNAMIC
>  LIBTRACEEVENT_DIR = $(srctree)/tools/lib/traceevent/
>  LIBTRACEEVENT_PLUGINS_DIR = $(LIBTRACEEVENT_DIR)/plugins
> +endif
>  LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
>  LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
>  LIBSYMBOL_DIR   = $(srctree)/tools/lib/symbol/
> @@ -293,6 +295,7 @@ SCRIPT_SH += perf-iostat.sh
>  grep-libs = $(filter -l%,$(1))
>  strip-libs = $(filter-out -l%,$(1))
>  
> +ifndef LIBTRACEEVENT_DYNAMIC
>  ifneq ($(OUTPUT),)
>    LIBTRACEEVENT_OUTPUT = $(abspath $(OUTPUT))/libtraceevent
>  else
> @@ -306,13 +309,16 @@ LIBTRACEEVENT = $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
>  export LIBTRACEEVENT
>  LIBTRACEEVENT_DYNAMIC_LIST = $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtraceevent-dynamic-list
>  CFLAGS += -I$(LIBTRACEEVENT_OUTPUT)/include
> -
>  #
>  # The static build has no dynsym table, so this does not work for
>  # static build. Looks like linker starts to scream about that now
>  # (in Fedora 26) so we need to switch it off for static build.
>  DYNAMIC_LIST_LDFLAGS               = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
>  LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = $(if $(findstring -static,$(LDFLAGS)),,$(DYNAMIC_LIST_LDFLAGS))
> +else
> +LIBTRACEEVENT_DYNAMIC_LIST =
> +LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS =
> +endif
>  
>  ifneq ($(OUTPUT),)
>    LIBAPI_OUTPUT = $(abspath $(OUTPUT))/libapi
> @@ -375,7 +381,11 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>  python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
>  
>  PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
> +ifndef LIBTRACEEVENT_DYNAMIC
>  PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBTRACEEVENT) $(LIBAPI)
> +else
> +PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
> +endif
>  
>  SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
>  
> @@ -785,9 +795,12 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
>  	$(LIBPERF) \
>  	$(LIBSUBCMD) \
>  	$(LIBSYMBOL) \
> -	$(LIBTRACEEVENT) \
>  	bpf-skel
>  
> +ifndef LIBTRACEEVENT_DYNAMIC
> +prepare: $(LIBTRACEEVENT)
> +endif
> +
>  $(OUTPUT)%.o: %.c prepare FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
>  
> @@ -843,6 +856,7 @@ endif
>  
>  $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
>  
> +ifndef LIBTRACEEVENT_DYNAMIC
>  LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(filter-out -static,$(LDFLAGS))'
>  
>  $(LIBTRACEEVENT): FORCE | $(LIBTRACEEVENT_OUTPUT)
> @@ -872,6 +886,7 @@ install-traceevent-plugins: libtraceevent_plugins
>  	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
>  		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
>  		$(LIBTRACEEVENT_FLAGS) install
> +endif
>  
>  $(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
>  	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
> @@ -1152,7 +1167,7 @@ endif # BUILD_BPF_SKEL
>  bpf-skel-clean:
>  	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>  
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean libtraceevent_plugins-clean
> +clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
>  	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>  	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>  	$(Q)$(RM) $(OUTPUT).config-detected
> @@ -1192,6 +1207,10 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
>  	$(call QUIET_CLEAN, Documentation) \
>  	$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
>  
> +ifndef LIBTRACEEVENT_DYNAMIC
> +clean:: $(LIBTRACEEVENT)-clean libtraceevent_plugins-clean
> +endif
> +
>  #
>  # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
>  # file if defined, with no further action.
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 5b1e6468d5e8..43e7ca40b2ec 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -77,7 +77,8 @@ perf = Extension('perf',
>  		  include_dirs = ['util/include'],
>  		  libraries = extra_libraries,
>  		  extra_compile_args = cflags,
> -		  extra_objects = [libtraceevent, libapikfs, libperf],
> +		  extra_objects = [ x for x in [libtraceevent, libapikfs, libperf]
> +                                    if x is not None],
>                   )
>  
>  setup(name='perf',
> -- 
> 2.38.1.431.g37b22c650d-goog

-- 

- Arnaldo
