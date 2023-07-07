Return-Path: <bpf+bounces-4450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13074B56B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B1B2817CF
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85ED11196;
	Fri,  7 Jul 2023 16:53:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849AD511
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:53:18 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C026A0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:53:11 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-66870a96b89so2750500b3a.3
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688748791; x=1691340791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2q8/qxAfJs780ejd6xqOPrO4yijvMPBYqgkTx/lzTcw=;
        b=O8UmPecXiXz0zygYzf2d4/8hvCqdldGdkXuYbM71gC+Py+Tj+Q35pHzNuJp2azP8cs
         PaRokKXR6ETTiMRJh4F2+AcpFS1MWcP4DKxaTEpBZh3uZMonvmR1HUcDgbGXc+F1dxUy
         sAeMz08iFiVyqOMUgF5Nrf48XPvQ8WXOqanl9levQ43dbkEiG+TlM7zkaYdRAGHzpnXR
         ZIoo22vTYYwzHiRfAsXtLo0OTrzjxF77mSbP2Oygs8dDQuK1osKusCOdgLVspAfjAsgp
         Jpm7VhV3LDGXh5YmAW1IfFh4AJ3WUpmXzm8pbphsqeBbFdIGhIz3Yw1dRWhhxL5iEKTZ
         F11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688748791; x=1691340791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2q8/qxAfJs780ejd6xqOPrO4yijvMPBYqgkTx/lzTcw=;
        b=hWWMAWyTC1x7ztiTmMU1GsmRsgcGmc9ke5dTv9o0i+QTMHLftIRKI/vibb6WSGrJTv
         bRTQvW7hHwFZe26AtjU4bICbkuoST4hkJ1/67vYWHpqGaQHBikR/lE7WlN0Ew7FjHhgO
         +JBhgB38ICs2WCANavB6zwTqVNp9fJ7mlZTEF3Q0f9yCxSqJVyskFpx52aocoWFUNw0V
         bxIKfDDemLNlmx0L+RcqPDCDEdCge5KRHL+ljkhthCGHG+fJCdEXkLJ74sPCGTbhRr/+
         gKSCrkKZVqe5Q0UnrjAd3EQ8hpQnEzEukJ9Fr552VjoW0eqUsPTidXav0SqHGPfFGOUi
         O+cg==
X-Gm-Message-State: ABy/qLa/830xCVhwBLcZvZYOVQqv0T1YYGn/Wkh5EqZ4aVqYKV2Nefhq
	qTj2hrBYj/HEofIVA52CP1RGdmg=
X-Google-Smtp-Source: APBJJlGEz+37vt3/DBhesdBi7M9Pd/WaAD/cNAuzlwzM5JkqIEz2y2g0In7UV55sePaDDVS2ZGXg+DM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:2da0:b0:675:70d7:1eb0 with SMTP id
 fb32-20020a056a002da000b0067570d71eb0mr7563533pfb.6.1688748790731; Fri, 07
 Jul 2023 09:53:10 -0700 (PDT)
Date: Fri, 7 Jul 2023 09:53:08 -0700
In-Reply-To: <51aa1dd7-86d0-ed08-1142-f229513ad316@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com>
 <ZKcDdIYOUQuPP5Px@google.com> <51aa1dd7-86d0-ed08-1142-f229513ad316@gmail.com>
Message-ID: <ZKhC9G5ouGOviSOG@google.com>
Subject: Re: [PATCH v1] samples/bpf: Fix build out of source tree
From: Stanislav Fomichev <sdf@google.com>
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/07, Anh Tuan Phan wrote:
> 
> 
> On 7/7/23 01:09, Stanislav Fomichev wrote:
> > On 07/06, Anh Tuan Phan wrote:
> >> This commit fixes a few compilation issues when building out of source
> >> tree. The command that I used to build samples/bpf:
> >>
> >> export KBUILD_OUTPUT=/tmp
> >> make V=1 M=samples/bpf
> >>
> >> The compilation failed since it tried to find the header files in the
> >> wrong places between output directory and source tree directory
> >>
> >> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> >> ---
> >>  samples/bpf/Makefile        | 8 ++++----
> >>  samples/bpf/Makefile.target | 2 +-
> >>  2 files changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >> index 615f24ebc49c..32469aaa82d5 100644
> >> --- a/samples/bpf/Makefile
> >> +++ b/samples/bpf/Makefile
> >> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
> >>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
> >>  # TPROGS_CFLAGS causes conflicts
> >>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
> >> -		     -I$(src)/../../tools/include \
> >> +		     -I$(srctree)/tools/include \
> > 
> > [..]
> > 
> >>  		     -I$(src)/../../tools/include/uapi \
> > 
> > Does this $(src) need to be changed as well?
> 
> I think this line doesn't affect the build. I removed it and it still
> compiles (after "make -C samples/bpf clean"). I guess xdp_sample_user.c
> doesn't include any file in tools/include/uapi. Am I missing something
> or should I remove this line?

You might have these headers installed on your system already if
it compiles without this part. So I'd keep this part but do
s/src/srctree/ (and remove ../..).

> > 
> > 
> >>  		     -I$(LIBBPF_INCLUDE) \
> >> -		     -I$(src)/../../tools/testing/selftests/bpf
> >> +		     -I$(srctree)/tools/testing/selftests/bpf
> >>
> >>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
> >>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
> >> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
> >>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
> >> $(src)/xdp_sample_shared.h
> >>  	@echo "  CLANG-BPF " $@
> >>  	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
> >> -		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
> >> +		-Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
> >>  		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
> >>  		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
> >>  		-c $(filter %.bpf.c,$^) -o $@
> >> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o
> >> xdp_sample.bpf.o
> >>
> >>  LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach
> >> skel,$(LINKED_SKELS),$($(skel)-deps)))
> >>
> >> -BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
> >> +BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
> >>  BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
> >>  BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
> >>
> >> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
> >> index 7621f55e2947..86a454cfb080 100644
> >> --- a/samples/bpf/Makefile.target
> >> +++ b/samples/bpf/Makefile.target
> >> @@ -41,7 +41,7 @@ _tprogc_flags   = $(TPROGS_CFLAGS) \
> >>                   $(TPROGCFLAGS_$(basetarget).o)
> >>
> >>  # $(objtree)/$(obj) for including generated headers from checkin source
> >> files
> > 
> > [..]
> > 
> >> -ifeq ($(KBUILD_EXTMOD),)
> >> +ifneq ($(KBUILD_EXTMOD),)
> > 
> > This parts seems to be copy-pasted all over the place in its 'ifeq'
> > form. What is it doing and why is it needed?
> > 
> >>  ifdef building_out_of_srctree
> >>  _tprogc_flags   += -I $(objtree)/$(obj)
> >>  endif
> >> -- 
> >> 2.34.1

