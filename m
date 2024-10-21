Return-Path: <bpf+bounces-42578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F059A5D1B
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 09:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B7528347C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 07:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60DD1D27A8;
	Mon, 21 Oct 2024 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/2zJMd9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1B1E0B9B
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495856; cv=none; b=oWnlHvIPRxfK5UMdkzTFcfKWSaQUpp9EmyxEXf6zFWIlLb3dFUGVGZMvihZKR4NrVOPxSBg4QNDJcLQI8xXYUUNtBJPGLu7yEgUi81P6PEQhmLdZ182zi3xA7dtdp6tTBdFvnrjjGvgfnVz+KWwDgvA218MAH703hcdJn9s49Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495856; c=relaxed/simple;
	bh=pKabmXbh0fDqFzaq3v5Af1/5lXMhjDm1qogGZMwPj7g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHAzAVqBi+ww/865a7gmuKURKS7y80bTbauRH5V/EjqeGWUdgj2Gv9/FL/U8vy7euBv9hD1Z1gf0sL+k179stmfMJ1uwka5w40/gE4CdxJEHvQLS9AGob5yhvHSJnr+8adFPA+J6/v1FXU7vhoat16ucRw6WltLhJUtCrBRC6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/2zJMd9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso561211066b.2
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 00:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729495852; x=1730100652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p1GPqh/HeC/dRxQMbvgKPFuK452Py8SS0M+4ucqe3xs=;
        b=Q/2zJMd9dtoCo+xWUQtp6I/eKiwLOUyo+KDGkh7CqNRPQ2RDcZSLZopN4KWvljab3u
         FmmuMnXex+Lm54pmDLTRE4yUckaxc+PwIeh0jKJ3kOo7gwt31INqcQ49CSfvgVVulmy1
         eLMeCHedhWtjx9iYWLYpoWArkSbNpPPszWcbBY1X2Ileyfwr1JpksnEisjAv6QoBE7/y
         K0yLMKMEdsXZu/LK/mBGDhbFyTK4cDhHs/yX8vbXxE2o55UZ+Iyn19MD0qx5finUwlGb
         MhaO+HGG9xKYSvvTd8XwDWcz3RDmvMlRib6imGa1OkKzy05368ioFon0Y4iq1tgwIMCl
         d66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495852; x=1730100652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1GPqh/HeC/dRxQMbvgKPFuK452Py8SS0M+4ucqe3xs=;
        b=AnNF4Vy4DEWlhvp5pfFNCoxLej0TG2RI0eJ5D1vpO9uzX+U4VzcwciLe0JcnI7hjTT
         a/H1PKCPukSapbp9NYeCHPvflf5JAyIjUGFRxNnLo3k+8EOgQ8sw09nAtSkURFl6dVT+
         xVgz3Er36L5s1P3uaibPjpT++jiYCe5DmSE5vh4rsQWK5oVpbGMMTFhitnVnzoea53B+
         Olb5qWsisNeULz3XcvIt5N7VkbxiwIx/B/J1wuku4pZXskK/wEEP5CX8I2fopoZz0vUC
         vSs9nvTLJU1o+Caoq0ZO08SUXu5YgeUmMeVuemF0+zv2c1U3lts/CgvwQRTTcJJRD5X4
         OeTw==
X-Gm-Message-State: AOJu0Yw/NitcvLgho3DTg/w4Etx/+U9/zgAA5lbJQAOsFd53tCUEq3yW
	bnazrho2/MJJFHbmVFTI97X4V5CdJgwgPj2Em2ht2REHn/ZG/Wjd
X-Google-Smtp-Source: AGHT+IF8MFXKkWKMXsEhOd8FTRgVJzLGLx4vgD8ZcnbGwdqfsizFy3oBKRks0qeKS5CqAu71M3+I4w==
X-Received: by 2002:a17:907:94d4:b0:a99:f56e:ce40 with SMTP id a640c23a62f3a-a9a69c9e9c1mr1273974366b.47.1729495851941;
        Mon, 21 Oct 2024 00:30:51 -0700 (PDT)
Received: from krava (85-193-35-184.rib.o2.cz. [85.193.35.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913704d2sm170165866b.119.2024.10.21.00.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:30:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 09:30:49 +0200
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Allow building with extra
 flags
Message-ID: <ZxYDKXBv3GR6QFAG@krava>
References: <cover.1729233447.git.vmalik@redhat.com>
 <e2ec5f8c7ee79e18161a359dfa19f80a90fdc3fc.1729233447.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ec5f8c7ee79e18161a359dfa19f80a90fdc3fc.1729233447.git.vmalik@redhat.com>

On Fri, Oct 18, 2024 at 08:48:59AM +0200, Viktor Malik wrote:
> In order to specify extra compilation or linking flags to BPF selftests,
> it is possible to set EXTRA_CFLAGS and EXTRA_LDFLAGS from the command
> line. The problem is that they are not propagated to sub-make calls
> (runqslower, bpftool, libbpf) and in the better case are not applied, in
> the worse case cause the entire build fail.
> 
> Propagate EXTRA_CFLAGS and EXTRA_LDFLAGS to the sub-makes.
> 
> This, for instance, allows to build selftests as PIE with
> 
>     $ make EXTRA_CFLAGS='-fPIE' EXTRA_LDFLAGS='-pie'
> 
> Without this change, the command would fail because libbpf.a would not
> be built with -fPIE and other PIE binaries would not link against it.
> 
> The only problem is that we have to explicitly provide empty
> EXTRA_CFLAGS='' and EXTRA_LDFLAGS='' to the builds of kernel modules
> (bpf_testmod and bpf_test_no_cfi) as we don't want to build modules with
> flags used for userspace (the above example would fail as kernel doesn't
> support PIE).
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/Makefile | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 28a76baa854d..1fc7c38e56b5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -294,13 +294,17 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
>  $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
>  	$(call msg,MOD,,$@)
>  	$(Q)$(RM) bpf_testmod/bpf_testmod.ko # force re-compilation
> -	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_testmod
> +	$(Q)$(MAKE) $(submake_extras) -C bpf_testmod \
> +		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)     \
> +		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
>  	$(Q)cp bpf_testmod/bpf_testmod.ko $@
>  
>  $(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_no_cfi/Makefile bpf_test_no_cfi/*.[ch])
>  	$(call msg,MOD,,$@)
>  	$(Q)$(RM) bpf_test_no_cfi/bpf_test_no_cfi.ko # force re-compilation
> -	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_no_cfi
> +	$(Q)$(MAKE) $(submake_extras) -C bpf_test_no_cfi \
> +		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	 \
> +		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
>  	$(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
>  
>  DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
> @@ -319,8 +323,8 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
>  		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
>  		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
>  		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
> -		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
> -		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&			       \
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
> +		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' &&	       \
>  		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
>  
>  TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)
> @@ -354,7 +358,8 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
>  		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
>  	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
>  		    ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" 	       \
> -		    EXTRA_CFLAGS='-g $(OPT_FLAGS)'			       \
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'	       \
> +		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'			       \
>  		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
>  		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
>  		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
> @@ -365,7 +370,8 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
>  		    $(BPFOBJ) | $(BUILD_DIR)/bpftool
>  	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
>  		    ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)			\
> -		    EXTRA_CFLAGS='-g $(OPT_FLAGS)'				\
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'		\
> +		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'				\
>  		    OUTPUT=$(BUILD_DIR)/bpftool/				\
>  		    LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/				\
>  		    LIBBPF_DESTDIR=$(SCRATCH_DIR)/				\
> @@ -388,8 +394,8 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
>  	   $(APIDIR)/linux/bpf.h					       \
>  	   | $(BUILD_DIR)/libbpf
>  	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
> -		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
> -		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)'			       \
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
> +		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)'	       \
>  		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
>  
>  ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
> @@ -397,7 +403,9 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
>  		$(APIDIR)/linux/bpf.h					       \
>  		| $(HOST_BUILD_DIR)/libbpf
>  	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
> -		    EXTRA_CFLAGS='-g $(OPT_FLAGS)' ARCH= CROSS_COMPILE=	       \
> +		    ARCH= CROSS_COMPILE=				       \
> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'	       \
> +		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'			       \
>  		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/			       \
>  		    CC="$(HOSTCC)" LD="$(HOSTLD)"			       \
>  		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
> -- 
> 2.47.0
> 

