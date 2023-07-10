Return-Path: <bpf+bounces-4614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1967974DC19
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 19:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D5E1C20B28
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAED13AFC;
	Mon, 10 Jul 2023 17:18:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA0107B4
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 17:18:25 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E5F120
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:18:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b89f6463deso78241815ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689009503; x=1691601503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fd/jFas9/ddzumuFsCZwyFQrGgcdAN+2PgNZn7yYwbs=;
        b=HZHn1KNnwtlwZlFd6Ii4kJHwRN+NGBxoXT1n1dT81haL6YarEviPWZbKtjhzZSnjN7
         erHlPXj+HCaoPSzrPsj9vsQMctRr4jEIpDf1CjgVEwXsX5fwNiH2UBQohG3NM8PEZBqh
         EHEJMv9zTh0sOz9A7pTORVZx/Alp3jGIFoH22wRA33EKvfXSlBWCWxL5RIR4el5h/PFV
         l3C+nQO67xAIUmEj9H4JuCm4LRw284EI70aORw3vvNVoQZmRSGjIZkkWXCsQ2HyZyZRn
         bpO+jJxinv3Ud4CMSG4Dc90Prq4l81iqk1l5SNrtNghxI2KD8ORmcWFHjBUB/pKToEwM
         XfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009503; x=1691601503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fd/jFas9/ddzumuFsCZwyFQrGgcdAN+2PgNZn7yYwbs=;
        b=hOhnh2QQLV7FVypJV4uxyCUqxQqRfRaSDz0MjjO0GtnysOahNT0PJIV+YaOprYiEF/
         jWTKAGtFE7wpQ4GHEtelhkKUGwqq/EUjSzYLviDvvkgHlBnu3G2hRzBIxeuDSb1EEFpd
         w3OIi/GOdzpR55kF/N1HkhSUUMIEelNmAWgr6nuE/F+q43R9K1loKzqNHuSNIdLPk7nn
         x4GYhSaFJrdcfrc2dFk47TRdu1lEZMOx+Awp/FtnrtA6AjFUy1cWk7NjrKJDtqdQm+vi
         zM2imZVZZ6d7NfVXtKw+HZFcn4z44zTMRGUP8uMlhPLpBvt8r1iaa34V4Eun5OL/t+Ji
         UK5Q==
X-Gm-Message-State: ABy/qLaFfXge6VVwvi4iLBHNp69px4ojRaCa7fXtcrT0vDtbLa12+57p
	nX3B7sCNk+TMLkC95iwvcq2kuaA=
X-Google-Smtp-Source: APBJJlHvVrDz1g2oRDm9FKijVnJKD+Wp8/adNeEDp2lT19t1t4+ySQ4RmAmWW2rMUH0hpqVW5eLRl4Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e9d4:b0:1a2:3436:4119 with SMTP id
 20-20020a170902e9d400b001a234364119mr12697223plk.8.1689009503485; Mon, 10 Jul
 2023 10:18:23 -0700 (PDT)
Date: Mon, 10 Jul 2023 10:18:21 -0700
In-Reply-To: <2b48be65-5f63-4658-38cb-03c00c10fdf3@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com>
 <ZKcDdIYOUQuPP5Px@google.com> <51aa1dd7-86d0-ed08-1142-f229513ad316@gmail.com>
 <ZKhC9G5ouGOviSOG@google.com> <2b48be65-5f63-4658-38cb-03c00c10fdf3@gmail.com>
Message-ID: <ZKw9XQGOza6qGDLf@google.com>
Subject: Re: [PATCH v1] samples/bpf: Fix build out of source tree
From: Stanislav Fomichev <sdf@google.com>
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/09, Anh Tuan Phan wrote:
> I updated the patch to reflect your suggestion. Thank you!

In the future, can you please post a new one with v+1 instead of replying
to the old one? Thx!

> On 7/7/23 23:53, Stanislav Fomichev wrote:
> > On 07/07, Anh Tuan Phan wrote:
> >>
> >>
> >> On 7/7/23 01:09, Stanislav Fomichev wrote:
> >>> On 07/06, Anh Tuan Phan wrote:
> >>>> This commit fixes a few compilation issues when building out of source
> >>>> tree. The command that I used to build samples/bpf:
> >>>>
> >>>> export KBUILD_OUTPUT=/tmp
> >>>> make V=1 M=samples/bpf
> >>>>
> >>>> The compilation failed since it tried to find the header files in the
> >>>> wrong places between output directory and source tree directory
> >>>>
> >>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> >>>> ---
> >>>>  samples/bpf/Makefile        | 8 ++++----
> >>>>  samples/bpf/Makefile.target | 2 +-
> >>>>  2 files changed, 5 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >>>> index 615f24ebc49c..32469aaa82d5 100644
> >>>> --- a/samples/bpf/Makefile
> >>>> +++ b/samples/bpf/Makefile
> >>>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
> >>>>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
> >>>>  # TPROGS_CFLAGS causes conflicts
> >>>>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
> >>>> -		     -I$(src)/../../tools/include \
> >>>> +		     -I$(srctree)/tools/include \
> >>>
> >>> [..]
> >>>
> >>>>  		     -I$(src)/../../tools/include/uapi \
> >>>
> >>> Does this $(src) need to be changed as well?
> >>
> >> I think this line doesn't affect the build. I removed it and it still
> >> compiles (after "make -C samples/bpf clean"). I guess xdp_sample_user.c
> >> doesn't include any file in tools/include/uapi. Am I missing something
> >> or should I remove this line?
> > 
> > You might have these headers installed on your system already if
> > it compiles without this part. So I'd keep this part but do
> > s/src/srctree/ (and remove ../..).
> > 
> >>>
> >>>
> >>>>  		     -I$(LIBBPF_INCLUDE) \
> >>>> -		     -I$(src)/../../tools/testing/selftests/bpf
> >>>> +		     -I$(srctree)/tools/testing/selftests/bpf
> >>>>
> >>>>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
> >>>>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
> >>>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
> >>>>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
> >>>> $(src)/xdp_sample_shared.h
> >>>>  	@echo "  CLANG-BPF " $@
> >>>>  	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
> >>>> -		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
> >>>> +		-Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
> >>>>  		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
> >>>>  		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
> >>>>  		-c $(filter %.bpf.c,$^) -o $@
> >>>> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o
> >>>> xdp_sample.bpf.o
> >>>>
> >>>>  LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach
> >>>> skel,$(LINKED_SKELS),$($(skel)-deps)))
> >>>>
> >>>> -BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
> >>>> +BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
> >>>>  BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
> >>>>  BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
> >>>>
> >>>> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
> >>>> index 7621f55e2947..86a454cfb080 100644
> >>>> --- a/samples/bpf/Makefile.target
> >>>> +++ b/samples/bpf/Makefile.target
> >>>> @@ -41,7 +41,7 @@ _tprogc_flags   = $(TPROGS_CFLAGS) \
> >>>>                   $(TPROGCFLAGS_$(basetarget).o)
> >>>>
> >>>>  # $(objtree)/$(obj) for including generated headers from checkin source
> >>>> files
> >>>
> >>> [..]
> >>>
> >>>> -ifeq ($(KBUILD_EXTMOD),)
> >>>> +ifneq ($(KBUILD_EXTMOD),)
> >>>
> >>> This parts seems to be copy-pasted all over the place in its 'ifeq'
> >>> form. What is it doing and why is it needed?
> >>>
> >>>>  ifdef building_out_of_srctree
> >>>>  _tprogc_flags   += -I $(objtree)/$(obj)
> >>>>  endif
> >>>> -- 
> >>>> 2.34.1
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
> 
> Change from the original patch
> 
> - Change "-I$(src)/../../tools/include/uapi" to
> "-I$(srctree)/tools/include/uapi"
> 
>  samples/bpf/Makefile        | 10 +++++-----
>  samples/bpf/Makefile.target |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 615f24ebc49c..cfc960b3713a 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
>  # TPROGS_CFLAGS causes conflicts
>  XDP_SAMPLE_CFLAGS += -Wall -O2 \
> -		     -I$(src)/../../tools/include \
> -		     -I$(src)/../../tools/include/uapi \
> +		     -I$(srctree)/tools/include \
> +		     -I$(srctree)/tools/include/uapi \
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
>  ifdef building_out_of_srctree
>  _tprogc_flags   += -I $(objtree)/$(obj)
>  endif

This question left undressed. Can you share more on why this change
is needed? Because it looks like it's actually needed for M='' case.
IOW, maybe we should add $(objtree)/$(obj) somewhere else?

