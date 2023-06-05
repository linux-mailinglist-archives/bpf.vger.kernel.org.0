Return-Path: <bpf+bounces-1805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC272226E
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 11:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2415628123B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156CC15497;
	Mon,  5 Jun 2023 09:45:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758D134A4
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 09:45:17 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03FDD3
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 02:45:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so39517575e9.2
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685958314; x=1688550314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fw4E1hWQkfl+I5xPZeS/19do6pQ7tptDxnPkr8VM6o4=;
        b=gOfK6b7d1twihZUHxhyxpIVLg9tUQ+YWESbMsHU6bmqdZmaTM5IQQf6A6vP3NRPO9f
         bcOyc5xFmtlo4FVqwRZ1SMuFbZBG7QOBcsA7+e0a8zUZFyWBhNPMsn0IlqWeJyPYeFf0
         xDX6yW3XtPWsZcdqhj1OG7nWhhHVcGQuw9iDWvSYMmFhG7DQJEvOpxgmJiBts/lHZfvZ
         2179entPqHD3w0IktBbi7Q2PtckB2xVMb8HUIKGR8qxCeVq/3ecS3AT7f8orHGzhNIY2
         i3Vqzm7DNCYFI9fGQqkh69ryG+9iFudzZSBR7fSCxgvm4qs5MBS1wZJE5HL3QV25YIEu
         Qubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685958314; x=1688550314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw4E1hWQkfl+I5xPZeS/19do6pQ7tptDxnPkr8VM6o4=;
        b=gUtawrxLGBHDWVZfHbz4L9ul9tpGK2ky9fhj+arlCGty/EoiaE9Y+bZkNiDR5NZWfA
         ItGf3fqPqOeUi00fNpMl2iA+z/x7y2xV8HIP87/onBEvup/gShURmB48Awo7j/4PS7gE
         8Xske4P1/QcPtjoj24dY6OxIumk8kKRmPo+m5s5xGvQk1hVGFcWqNzhL7AYkaZxtRbxT
         wXatF1tDrSiUCNKqdBdxxymocqbPJIXhClEUtuRSn5cBtHw5e9IVUIuzrDYHlQjHf8/E
         dqRvUZQL5N/Dmvg1YEJ5ZTcbDXdOPMjCN29mz6oGvNp2gA6cx0p6CQLJ/6vns+tNhAcx
         w+YA==
X-Gm-Message-State: AC+VfDzKxf/Hiuz8/pOZppc3Uv9mR2ZVLIeBCKdiIepdm9ymtVnki4rQ
	TA4J0Jt3MhHZBNu5VKjYxHo=
X-Google-Smtp-Source: ACHHUZ61odPXzOUzbBAfLIqEwPRBqyXHhW3dtT8hJlfuueiFQ7Jzg9bwN0Ye4cqXVO/tbCEEiprBgQ==
X-Received: by 2002:a7b:c8d9:0:b0:3f7:3a16:a1b3 with SMTP id f25-20020a7bc8d9000000b003f73a16a1b3mr1962112wml.36.1685958314152;
        Mon, 05 Jun 2023 02:45:14 -0700 (PDT)
Received: from krava ([2a00:102a:4002:d0bd:b404:82f8:eedb:87ed])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003f6f6a6e769sm10214002wmc.17.2023.06.05.02.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 02:45:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 5 Jun 2023 11:45:11 +0200
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
Message-ID: <ZH2up0zf7TCVdbPM@krava>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

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
>  include $(srctree)/tools/build/Makefile.include
>  
>  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> -- 
> 2.40.1
> 

