Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BA75A8835
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 23:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiHaVjL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 17:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiHaVjK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 17:39:10 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A559D7CF8
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 14:39:09 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTVQQ-000Csh-D9; Wed, 31 Aug 2022 23:39:06 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTVQQ-0006Fw-57; Wed, 31 Aug 2022 23:39:06 +0200
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Store BPF object files with
 .bpf.o extension
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        kafai@fb.com, kernel-team@fb.com
References: <20220830175550.3838206-1-deso@posteo.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <767e3600-c709-071e-c3f9-3ccf0bdcd478@iogearbox.net>
Date:   Wed, 31 Aug 2022 23:39:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220830175550.3838206-1-deso@posteo.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26644/Wed Aug 31 09:53:02 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/30/22 7:55 PM, Daniel Müller wrote:
[...]
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index eecad9..787631 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
[...]
>   
> -LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
> +LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
>   
>   # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
>   # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
> @@ -386,7 +386,7 @@ TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
>   TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
>   TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
>   TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
> -TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS))
> +TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.bpf.o, $$(TRUNNER_BPF_SRCS))
>   TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
>   				 $$(filter-out $(SKEL_BLACKLIST) $(LINKED_BPF_SRCS),\
>   					       $$(TRUNNER_BPF_SRCS)))
> @@ -416,7 +416,7 @@ endif
>   # input/output directory combination
>   ifeq ($($(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs),)
>   $(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs := y
> -$(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
> +$(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
>   		     $(TRUNNER_BPF_PROGS_DIR)/%.c			\
>   		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
>   		     $$(INCLUDE_DIR)/vmlinux.h				\
> @@ -426,22 +426,22 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
>   	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
>   					  $(TRUNNER_BPF_CFLAGS))
>   
> -$(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> +$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>   	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
>   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$<
>   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o)
>   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o)
>   	$(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
> -	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$@
> -	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$(@:.skel.h=.subskel.h)
> +	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@
> +	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h)
>   
> -$(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> +$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>   	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
>   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
>   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
>   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
>   	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
> -	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.o=_lskel)) > $$@
> +	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
>   
>   $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
>   	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.o))

Should this one also be converted to .bpf.o ?

> @@ -500,7 +500,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
>   			     | $(TRUNNER_BINARY)-extras
>   	$$(call msg,BINARY,,$$@)
>   	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> -	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
> +	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
>   	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool $(if $2,$2/)bpftool
>   
>   endef
