Return-Path: <bpf+bounces-4293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E2274A39B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858EC1C20D9D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD8C155;
	Thu,  6 Jul 2023 18:09:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E20BE5C
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:09:59 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D998199F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 11:09:58 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8bbe7a86eso10180905ad.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688666998; x=1691258998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ63wvLyvqO6GZByAZoS5h4tDwkI077edGPkoK9X3Oc=;
        b=AGeirDjqFk8O+u8PU5EwhSx2Itp97lyqlROfCcRt953Ngx1fi5BtSYytJJIvNTkP0r
         V4ypYaYMZLBVaop+oEL2HPYpenbRjGzqNz3aZasx2PS8JVNFALKdQDUqTK0rw18AMN5X
         IUw8EMIo5ok//JOtI9bsou1K9FGES64kuDFptXOn8UTIwtOT8AO3Qqmnd64FJHUCTyWf
         Weo8wCGCBLGxEql/J9D0ywmCny+JVcuECXJhhJy3mtX4sUKIY8NQMf6jdY23UVfSygPS
         3ZDSn2vzjRWXBeCvsCGBymRp77MBNcwiQBrp+b2dzCcaCPyylt+GfoqcRcRbasTlYlXz
         To2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666998; x=1691258998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ63wvLyvqO6GZByAZoS5h4tDwkI077edGPkoK9X3Oc=;
        b=Xw1s7TCRFo+1R28tGZhCLtS2U4qyNQIxhF30dpheJxQ5Xo9lAEmSg6iNpxssT8+/yi
         OTm1waN4m/GwcrvWNiF9E46LGx2r33EYuJxl7UVeDmOcxoGJZJkds7JKKA7kkalv+Nr+
         6sVIhkWHhvGVoCHpVjsD6Kh+5CMF70i4md1/0TfC1z/DwfpsjVNXCr/CDQzZIZe/HgQJ
         ZZH6equO43d7lUqxOfoUCv6xhMd2PyU7Odaq0CtgPYeHXuPANqdWsBXk85oBIiZeG+8l
         fiOakuSJsXQAQsMgpD63DijIhX/LooSo/fClKGgQlik1EbegJFHma08ktccs9sEGiR0j
         127g==
X-Gm-Message-State: ABy/qLbY5aeJknh0IjAlE3AO1dwLh8roIX/+C3SEuTXuxHauFx/nARAs
	3ql6Nxop5Wrv8TSsDM3fc8hANBM=
X-Google-Smtp-Source: APBJJlG5TTlBvKSRC8RZNPmvckDrPxmKqvij30wDaGD63GSrkjyJwvvLwQylLUlY68hy0EITKPOtssY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:d2cd:b0:1b8:929f:1990 with SMTP id
 n13-20020a170902d2cd00b001b8929f1990mr2319922plc.6.1688666997851; Thu, 06 Jul
 2023 11:09:57 -0700 (PDT)
Date: Thu, 6 Jul 2023 11:09:56 -0700
In-Reply-To: <67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com>
Message-ID: <ZKcDdIYOUQuPP5Px@google.com>
Subject: Re: [PATCH v1] samples/bpf: Fix build out of source tree
From: Stanislav Fomichev <sdf@google.com>
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/06, Anh Tuan Phan wrote:
> This commit fixes a few compilation issues when building out of source
> tree. The command that I used to build samples/bpf:
> 
> export KBUILD_OUTPUT=/tmp
> make V=1 M=samples/bpf
> 
> The compilation failed since it tried to find the header files in the
> wrong places between output directory and source tree directory
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
>  samples/bpf/Makefile        | 8 ++++----
>  samples/bpf/Makefile.target | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 615f24ebc49c..32469aaa82d5 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
>  # TPROGS_CFLAGS causes conflicts
>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
> -		     -I$(src)/../../tools/include \
> +		     -I$(srctree)/tools/include \

[..]

>  		     -I$(src)/../../tools/include/uapi \

Does this $(src) need to be changed as well?


>  		     -I$(LIBBPF_INCLUDE) \
> -		     -I$(src)/../../tools/testing/selftests/bpf
> +		     -I$(srctree)/tools/testing/selftests/bpf
> 
>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
> $(src)/xdp_sample_shared.h
>  	@echo "  CLANG-BPF " $@
>  	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
> -		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
> +		-Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
>  		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
>  		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>  		-c $(filter %.bpf.c,$^) -o $@
> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o
> xdp_sample.bpf.o
> 
>  LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach
> skel,$(LINKED_SKELS),$($(skel)-deps)))
> 
> -BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
> +BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
>  BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
>  BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
> 
> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
> index 7621f55e2947..86a454cfb080 100644
> --- a/samples/bpf/Makefile.target
> +++ b/samples/bpf/Makefile.target
> @@ -41,7 +41,7 @@ _tprogc_flags   = $(TPROGS_CFLAGS) \
>                   $(TPROGCFLAGS_$(basetarget).o)
> 
>  # $(objtree)/$(obj) for including generated headers from checkin source
> files

[..]

> -ifeq ($(KBUILD_EXTMOD),)
> +ifneq ($(KBUILD_EXTMOD),)

This parts seems to be copy-pasted all over the place in its 'ifeq'
form. What is it doing and why is it needed?

>  ifdef building_out_of_srctree
>  _tprogc_flags   += -I $(objtree)/$(obj)
>  endif
> -- 
> 2.34.1

