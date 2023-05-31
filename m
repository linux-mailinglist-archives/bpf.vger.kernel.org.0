Return-Path: <bpf+bounces-1494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70353717A26
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29206281451
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EDA46AD;
	Wed, 31 May 2023 08:34:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA787E1
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 08:34:52 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C73107
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 01:34:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f9cfa7eddso933460366b.2
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685522088; x=1688114088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4B5ipqjtU8mGgDCcsLLVQBin26t+C2NjH8eRNM7qLE=;
        b=ZeqX7QQGrcGh61XUQe3kZVDoc6xvNHqxSoczUP3XYa7xd4IsQj3yuqVPU7bGv1EgKE
         Inxq4ANZMkyzOV2NPDrUSvxU/juYiFnzLX+SbYuAMkQu2JX5aMNerM/Wy5gPcR3M82Oy
         PnbQVYFJVCq/dM7MHTR7VrKfmg30z4Kxw1hQuLDfkNJG2++l2/npYf2ARVyWeh+ds+Np
         /1Owinw/MftBoBWaxFrC3qiOOT3sp5FLSupyvxBpEyOoKIMiG7tBUpLY2XXYVWWAjsrt
         /aWG7BM4ajYcsXAky/IrgDpqHD87KJ2CG06RP4LtbuDC0GKe1KcdHp8nvIp/N1g/BU+q
         lgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685522088; x=1688114088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4B5ipqjtU8mGgDCcsLLVQBin26t+C2NjH8eRNM7qLE=;
        b=Rgk9I4SMhAZr8RlFEKbjTq9uJI2tPMb4+FuvaevS11cRGvR7aTsuHWBk4oP6TxXbYr
         5H601l2MZxccXLuMARKDDbGIPvJn66x6MKjVv5C/gMrGDgablr7QUZaCHfChzj2dt1ek
         r6gRLYv6dVHbwqVthsp1RZKHMcgzWvwuQi7+jfCfNs2nf/hIxkZbzLO+eJ5TxGqplQ8f
         S0Df6tW5vkg+eAY+ggdxAU/HkeGDhL9SaFzwxHWG/E71MPzjpm6MIlKTyMUgP5kn9m+L
         m667GfhrUfVkV9h6p+dVN7YUN0L1Mp7OKwFe9TGseV4fqVu1MHBvMGUtRAhOq6bWV0By
         j0aQ==
X-Gm-Message-State: AC+VfDychtxI0fq6pwm5w8oqSev+iCKUOvXJIW8e9U2aNBHzSqlKPUKF
	RiSrp4eTAuRlYn+ECa4d5Dg=
X-Google-Smtp-Source: ACHHUZ5kUgxfDXhGdTTNiKBJo2KiPTfdD1mXMRQFoLtwDwA0PGZnEONfFWi9NzXNGNnJzJW9zZrH+Q==
X-Received: by 2002:a17:907:c0c:b0:93b:5f2:36c with SMTP id ga12-20020a1709070c0c00b0093b05f2036cmr5166864ejc.61.1685522088163;
        Wed, 31 May 2023 01:34:48 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906494700b0095807ab4b57sm8733691ejt.178.2023.05.31.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 01:34:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 31 May 2023 10:34:45 +0200
To: Viktor Malik <vmalik@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
	Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: fix setting HOSTCFLAGS
Message-ID: <ZHcGpUbEX5vBFrON@krava>
References: <20230530123352.1308488-1-vmalik@redhat.com>
 <ZHX6SuWQHkm3hJl+@krava>
 <d565f28f-dbb3-f9bf-8635-c57a2a218b88@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d565f28f-dbb3-f9bf-8635-c57a2a218b88@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 09:20:44AM +0200, Viktor Malik wrote:
> On 5/30/23 15:29, Jiri Olsa wrote:
> > On Tue, May 30, 2023 at 02:33:52PM +0200, Viktor Malik wrote:
> >> Building BPF selftests with custom HOSTCFLAGS yields an error:
> >>
> >>     # make HOSTCFLAGS="-O2"
> >>     [...]
> >>       HOSTCC  ./tools/testing/selftests/bpf/tools/build/resolve_btfids/main.o
> >>     main.c:73:10: fatal error: linux/rbtree.h: No such file or directory
> >>        73 | #include <linux/rbtree.h>
> >>           |          ^~~~~~~~~~~~~~~~
> >>
> >> The reason is that tools/bpf/resolve_btfids/Makefile passes header
> >> include paths by extending HOSTCFLAGS which is overridden by setting
> >> HOSTCFLAGS in the make command (because of Makefile rules [1]).
> >>
> >> This patch fixes the above problem by passing the include paths via
> >> `HOSTCFLAGS_resolve_btfids` which is used by tools/build/Build.include
> >> and can be combined with overridding HOSTCFLAGS.
> >>
> >> [1] https://www.gnu.org/software/make/manual/html_node/Overriding.html
> >>
> >> Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
> >> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> >> ---
> >>  tools/bpf/resolve_btfids/Makefile | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> >> index ac548a7baa73..4b8079f294f6 100644
> >> --- a/tools/bpf/resolve_btfids/Makefile
> >> +++ b/tools/bpf/resolve_btfids/Makefile
> >> @@ -67,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> >>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> >>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> >>  
> >> -HOSTCFLAGS += -g \
> >> +HOSTCFLAGS_resolve_btfids += -g \
> >>            -I$(srctree)/tools/include \
> >>            -I$(srctree)/tools/include/uapi \
> >>            -I$(LIBBPF_INCLUDE) \
> >> @@ -76,7 +76,7 @@ HOSTCFLAGS += -g \
> >>  
> >>  LIBS = $(LIBELF_LIBS) -lz
> >>  
> >> -export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> >> +export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
> > 
> > hum, AFAICS this way the spacified HOSTCFLAGS="-O2" won't be pushed
> > to the libbpf and libsubcmd dependencies, right?
> 
> IIUC, it will, b/c we're doing:
> 
>     HOST_OVERRIDES := ... EXTRA_CFLAGS="$(HOSTCFLAGS)"
> 
> and then pass HOST_OVERRIDES to libbpf and libsubcmd builds, which will
> then pick EXTRA_CFLAGS as a part of their build.
> 
> Confirmed for libsubcmd:
> 
>     $ make HOSTCFLAGS="-O2" V=1 | grep libsubcmd | grep O2 | wc -l
>     14
>     $ make V=1 | grep libsubcmd | grep O2 | wc -l
>     0
> 
> Interestingly, I couldn't do the same for libbpf. It looks like libbpf
> is not rebuilt for resolve_btfids b/c resolve_btfids/Makefile uses
> $(BPFOBJ) as the libbpf target and selftests/bpf/Makefile passes
> BPFOBJ=$(HOST_BPFOBJ) to the resolve_btfids build. So, an already built
> libbpf is reused and that one hasn't picked HOSTCFLAGS.
> 
> > how about we add the EXTRA_CFLAGS variable like we do in libbpf,
> > libsubcmd or perf
> > 
> > with the change below you'd need to run:
> > 
> >   $ make EXTRA_CFLAGS="-O2"
> > 
> 
> I'd like to avoid that b/c then, we would need to issue a different make
> command for the BPF selftests than for the rest of the kernel to pass
> custom flags to host-built programs.

ok

> 
> > I'll dig up the cross build scenarious we broke last time we
> > touched this stuff, perhaps Ian might remember as well ;-)
> 
> That will be useful, thanks :-)

there's test described by Nathan in here:

https://lore.kernel.org/bpf/Y9mFVNEi5wAINARY@dev-arch.thelio-3990X/

jirka

> 
> Viktor
> 
> > 
> > jirka
> > 
> > 
> > ---
> > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > index ac548a7baa73..58cfedc9c2db 100644
> > --- a/tools/bpf/resolve_btfids/Makefile
> > +++ b/tools/bpf/resolve_btfids/Makefile
> > @@ -18,8 +18,8 @@ else
> >  endif
> >  
> >  # Overrides for the prepare step libraries.
> > -HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> > -		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
> > +HOST_OVERRIDES = AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> > +		  CROSS_COMPILE=""
> >  
> >  RM      ?= rm
> >  HOSTCC  ?= gcc
> > @@ -67,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> >  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> >  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> >  
> > -HOSTCFLAGS += -g \
> > +HOSTCFLAGS += $(EXTRA_CFLAGS) -g \
> >            -I$(srctree)/tools/include \
> >            -I$(srctree)/tools/include/uapi \
> >            -I$(LIBBPF_INCLUDE) \
> > @@ -76,7 +76,7 @@ HOSTCFLAGS += -g \
> >  
> >  LIBS = $(LIBELF_LIBS) -lz
> >  
> > -export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> > +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR EXTRA_CFLAGS
> >  include $(srctree)/tools/build/Makefile.include
> >  
> >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > 
> 

