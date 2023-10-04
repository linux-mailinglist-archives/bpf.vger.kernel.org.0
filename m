Return-Path: <bpf+bounces-11351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585B7B7A01
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 10:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 9F6631F21E64
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B6D101FD;
	Wed,  4 Oct 2023 08:27:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801DDDAF
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 08:27:09 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D7B7
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 01:27:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5043a01ee20so2121958e87.0
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696408026; x=1697012826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3VvdahGPN85wSv/vxT287tHUDhupC1MMvvrdli3F1ak=;
        b=O+VocJPBMXol3tTXf/pY+2OgPb9X8O3DRHhG291IPCpkqWdMgcBZFHj/7CFugDpUOW
         TOUAHBw3rksIRDTxJFaN4swzDf3FRW9jtvr2PBAid1UP8rSseC+wwnroKC6CkTQTSylF
         MvGan5V8iKkV1be9H0BVqnIaGFTydolz9o7UQ/TPoCiQ3Me3RCmie10F+P4YXnLKMNHN
         5BPyJ9d4aNhQek3+XaAK6hDWPch7kzl8qpN7EilPFxI4HagbHW8Eg8NT8GerrVK2R0Em
         C0QSeqPiF/C/8BYmeFyy/9zGAXwhIUMSynAC8QFYxsVGagRF4brJy2zuBftl/GcuK73y
         6MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408026; x=1697012826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VvdahGPN85wSv/vxT287tHUDhupC1MMvvrdli3F1ak=;
        b=FaV3Pe+YqfA8FRE5jBmQH57ksC5AXG0lYPmPd6+kfjzVhxgGFRZACl8O4JAWSWz/Ng
         FKsDI0a6l6EHKgBCmiYJ79NOrXF7bro7R2EoP7V5XbL982CNoTUtNw1vOzoR9l9QDIqy
         5lyjGdVkAb93fMf34uJ901mwyfoZdAFj4BheqL5yQtR0cAphrmEKbEsnTsvMgakzjgPj
         D21kCTMx81npID5gHdb/YJaJARndrmJNDi8ko5GHoLHh5EwTa9sElc9EpKtlMgJQCgt3
         an2ATgCEPsV8KD4xaDjGnAT1kN7TJ81/LBqoy/KwahRvIK0KeEnwQGCWVmvTzlPLaVVg
         w5HQ==
X-Gm-Message-State: AOJu0Ywq4DQKihph+YrNk26hoYVxyTaLT/wJUS03OArqN0Z/W1iqE3Le
	2cN/gqyewe5oor7cygMP4E4=
X-Google-Smtp-Source: AGHT+IEf3+8gY5O0jjj9h7lJrngD0UItbHWFomXT4++KRpgxsk3a6qT5+Gx1Oai4BMhnlMpKHKoWPQ==
X-Received: by 2002:a05:6512:2013:b0:4ff:9bd9:f69a with SMTP id a19-20020a056512201300b004ff9bd9f69amr1191856lfb.65.1696408025991;
        Wed, 04 Oct 2023 01:27:05 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc450000000b0040536dcec17sm900073wmi.27.2023.10.04.01.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:27:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Oct 2023 10:27:03 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: support building selftests
 in optimized -O2 mode
Message-ID: <ZR0h12W2AHvquBWv@krava>
References: <20231004001750.2939898-1-andrii@kernel.org>
 <20231004001750.2939898-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004001750.2939898-2-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 05:17:49PM -0700, Andrii Nakryiko wrote:
> Add support for building selftests with -O2 level of optimization, which
> allows more compiler warnings detection (like lots of potentially
> uninitialized usage), but also is useful to have a faster-running test
> for some CPU-intensive tests.
> 
> One can build optimized versions of libbpf and selftests by running:
> 
>   $ make RELEASE=1
> 
> There is a measurable speed up of about 10 seconds for me locally,
> though it's mostly capped by non-parallelized serial tests. User CPU
> time goes down by total 40 seconds, from 1m10s to 0m28s.
> 
> Unoptimized build (-O0)
> =======================
> Summary: 430/3544 PASSED, 25 SKIPPED, 4 FAILED
> 
> real    1m59.937s
> user    1m10.877s
> sys     3m14.880s
> 
> Optimized build (-O2)
> =====================
> Summary: 425/3543 PASSED, 25 SKIPPED, 9 FAILED
> 
> real    1m50.540s
> user    0m28.406s
> sys     3m13.198s

hi,
I get following error when running selftest compiled with RELEASE=1

# ./test_progs -t attach_probe/manual-legacy
test_attach_probe:PASS:skel_open 0 nsec
test_attach_probe:PASS:skel_load 0 nsec
test_attach_probe:PASS:check_bss 0 nsec
test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
test_attach_probe_manual:PASS:skel_kprobe_manual_open_and_load 0 nsec
test_attach_probe_manual:PASS:uprobe_offset 0 nsec
test_attach_probe_manual:PASS:attach_kprobe 0 nsec
test_attach_probe_manual:PASS:attach_kretprobe 0 nsec
test_attach_probe_manual:PASS:attach_uprobe 0 nsec
test_attach_probe_manual:PASS:attach_uretprobe 0 nsec
libbpf: failed to add legacy uprobe event for /proc/self/exe:0x19020: -17
libbpf: prog 'handle_uprobe_byname': failed to create uprobe '/proc/self/exe:0x19020' perf event: File exists
test_attach_probe_manual:FAIL:attach_uprobe_byname unexpected error: -17
#8/2     attach_probe/manual-legacy:FAIL
#8       attach_probe:FAIL


it looks like -O2 can merge some of the trigger functions:

	[root@qemu bpf]# nm test_progs | grep trigger_func
	0000000000558f30 t autoattach_trigger_func.constprop.0
	000000000041d240 t trigger_func
	0000000000419020 t trigger_func
	0000000000420e70 t trigger_func
	0000000000507aa0 t trigger_func
	0000000000419020 t trigger_func2
	0000000000419020 t trigger_func3
	0000000000419030 t trigger_func4
	[root@qemu bpf]# nm test_progs | grep 0000000000419020
	0000000000419020 t trigger_func
	0000000000419020 t trigger_func2
	0000000000419020 t trigger_func3

I got more tests fails, but I suspect it's all for similar
reason like above

jirka


> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index a25e262dbc69..55d1b1848e6c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -27,7 +27,9 @@ endif
>  BPF_GCC		?= $(shell command -v bpf-gcc;)
>  SAN_CFLAGS	?=
>  SAN_LDFLAGS	?= $(SAN_CFLAGS)
> -CFLAGS += -g -O0 -rdynamic						\
> +RELEASE		?=
> +OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
> +CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
>  	  -Wall -Werror 						\
>  	  $(GENFLAGS) $(SAN_CFLAGS)					\
>  	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
> @@ -241,7 +243,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
>  		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
>  		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf			       \
>  		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
> -		    EXTRA_CFLAGS='-g -O0 $(SAN_CFLAGS)'			       \
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
>  		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&			       \
>  		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
>  
> @@ -279,7 +281,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
>  		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
>  	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
>  		    ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" 	       \
> -		    EXTRA_CFLAGS='-g -O0'				       \
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS)'			       \
>  		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
>  		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
>  		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
> @@ -290,7 +292,7 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
>  		    $(BPFOBJ) | $(BUILD_DIR)/bpftool
>  	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
>  		    ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)			\
> -		    EXTRA_CFLAGS='-g -O0'					\
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS)'				\
>  		    OUTPUT=$(BUILD_DIR)/bpftool/				\
>  		    LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/				\
>  		    LIBBPF_DESTDIR=$(SCRATCH_DIR)/				\
> @@ -313,7 +315,7 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
>  	   $(APIDIR)/linux/bpf.h					       \
>  	   | $(BUILD_DIR)/libbpf
>  	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
> -		    EXTRA_CFLAGS='-g -O0 $(SAN_CFLAGS)'			       \
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
>  		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)'			       \
>  		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
>  
> @@ -322,7 +324,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
>  		$(APIDIR)/linux/bpf.h					       \
>  		| $(HOST_BUILD_DIR)/libbpf
>  	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
> -		    EXTRA_CFLAGS='-g -O0' ARCH= CROSS_COMPILE=		       \
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS)' ARCH= CROSS_COMPILE=	       \
>  		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/			       \
>  		    CC="$(HOSTCC)" LD="$(HOSTLD)"			       \
>  		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
> -- 
> 2.34.1
> 
> 

