Return-Path: <bpf+bounces-1441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1902C7161E1
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 15:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469ED2811F6
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093320998;
	Tue, 30 May 2023 13:30:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ADB134C8
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 13:30:23 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1146610D
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 06:29:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so46541545e9.1
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 06:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685453389; x=1688045389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOLaKlfMv8b3NzHGaNYuo06Mb5ZkfICmAdstAhJzeHw=;
        b=kZ7fV3oFixDKP1pxFPzHHa2/S7EcaVJGyv7SuMA0fe7ysRjUw5HiH8i+q1bvgQibeH
         X0RzicCD/MC3YdNIuyrTxcS2uem85mMSz1Sv1MwcU4XY/Ai3OKjK7PwMNxXActtFjVz8
         FJzZZVKhwOQkVtE/6oIXykUY7MphMyckbzUGaLzPjWiZy4BCX5kkXqIbVBfwziMyHTsg
         uSh1+Sjf59RWrRK6uDEGIzlkwblAbk8rp0Pe0XaBOyd3oW9+JjYRZTt/CzTLgCNnm/jl
         OaUnEjgTXKp2/fmpjNWz46ujsf40R2nYWRsjlKO6xQrD1X8eeZtvzzJnGIGp43wG0IXV
         Rwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685453389; x=1688045389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOLaKlfMv8b3NzHGaNYuo06Mb5ZkfICmAdstAhJzeHw=;
        b=IHv6Tvo2HVauxcOD6c6y1RmhH8BNVCnnNOjgxNfU5IqlAZewc0Zh6W8vq3V25Rk2Ov
         bj40eR7cS6qqLBQ/U37SsaRLhzapuEM6IfSzBmuf0uW9joRu7wu/WvJec2arXWUKvAWo
         rRtC6KuX4+mz6mF68PIFDdcdupZS9tmu5+mKpyuziuZVq1HGRD05N0rGTuS8ryq8mo+o
         T+DKsq9DUA0y1lV3RFwcbBlvsxSr9U+LkmsSP6CrNMYMbl4+q8WTqCrRl0qYVvDwnM6R
         exprlUz6+v54oHC9goC83Fk3OrVqzfa1FdEoOvi0piHFWv4VEt0EE246cdN8PpTIO/d0
         Ourg==
X-Gm-Message-State: AC+VfDzfjMR5kFSG8KZ6XKzTL3Jz5dcPrm5aHe7vqcDS5mUMjPrjVTHu
	w/ZCTUf6Hj337iDjuChCYBk=
X-Google-Smtp-Source: ACHHUZ7W8JDJ25z8G9ygX7IDzpRTebiCePdc75ViEjdQgpzSHjAM6jH1vUe+AVes59CjSTKqnHKsUg==
X-Received: by 2002:a1c:4b12:0:b0:3f6:e42:8f9b with SMTP id y18-20020a1c4b12000000b003f60e428f9bmr2031912wma.27.1685453389277;
        Tue, 30 May 2023 06:29:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bcc10000000b003f60fb2addbsm21405691wmh.44.2023.05.30.06.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:29:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 30 May 2023 15:29:46 +0200
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
	Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: fix setting HOSTCFLAGS
Message-ID: <ZHX6SuWQHkm3hJl+@krava>
References: <20230530123352.1308488-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530123352.1308488-1-vmalik@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 30, 2023 at 02:33:52PM +0200, Viktor Malik wrote:
> Building BPF selftests with custom HOSTCFLAGS yields an error:
> 
>     # make HOSTCFLAGS="-O2"
>     [...]
>       HOSTCC  ./tools/testing/selftests/bpf/tools/build/resolve_btfids/main.o
>     main.c:73:10: fatal error: linux/rbtree.h: No such file or directory
>        73 | #include <linux/rbtree.h>
>           |          ^~~~~~~~~~~~~~~~
> 
> The reason is that tools/bpf/resolve_btfids/Makefile passes header
> include paths by extending HOSTCFLAGS which is overridden by setting
> HOSTCFLAGS in the make command (because of Makefile rules [1]).
> 
> This patch fixes the above problem by passing the include paths via
> `HOSTCFLAGS_resolve_btfids` which is used by tools/build/Build.include
> and can be combined with overridding HOSTCFLAGS.
> 
> [1] https://www.gnu.org/software/make/manual/html_node/Overriding.html
> 
> Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/bpf/resolve_btfids/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index ac548a7baa73..4b8079f294f6 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -67,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>  
> -HOSTCFLAGS += -g \
> +HOSTCFLAGS_resolve_btfids += -g \
>            -I$(srctree)/tools/include \
>            -I$(srctree)/tools/include/uapi \
>            -I$(LIBBPF_INCLUDE) \
> @@ -76,7 +76,7 @@ HOSTCFLAGS += -g \
>  
>  LIBS = $(LIBELF_LIBS) -lz
>  
> -export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> +export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR

hum, AFAICS this way the spacified HOSTCFLAGS="-O2" won't be pushed
to the libbpf and libsubcmd dependencies, right?

how about we add the EXTRA_CFLAGS variable like we do in libbpf,
libsubcmd or perf

with the change below you'd need to run:

  $ make EXTRA_CFLAGS="-O2"

I'll dig up the cross build scenarious we broke last time we
touched this stuff, perhaps Ian might remember as well ;-)

jirka


---
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index ac548a7baa73..58cfedc9c2db 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -18,8 +18,8 @@ else
 endif
 
 # Overrides for the prepare step libraries.
-HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
+HOST_OVERRIDES = AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
+		  CROSS_COMPILE=""
 
 RM      ?= rm
 HOSTCC  ?= gcc
@@ -67,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
-HOSTCFLAGS += -g \
+HOSTCFLAGS += $(EXTRA_CFLAGS) -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
@@ -76,7 +76,7 @@ HOSTCFLAGS += -g \
 
 LIBS = $(LIBELF_LIBS) -lz
 
-export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
+export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR EXTRA_CFLAGS
 include $(srctree)/tools/build/Makefile.include
 
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)

