Return-Path: <bpf+bounces-9113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8E678FE1E
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 15:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391AF1C20B30
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE0BE53;
	Fri,  1 Sep 2023 13:12:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A74BE4D
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 13:12:23 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6EE10D2
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 06:12:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c0cb7285fso224342866b.0
        for <bpf@vger.kernel.org>; Fri, 01 Sep 2023 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693573939; x=1694178739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNiF3pA+0+qY0qK3ASasuqwlcdJADBiCgPi55U0202M=;
        b=N9sQFp5sKjW6S4nSO39pmIzf4XX+JZeRy388wijulvmFYMbKjUR74l0F3SoBOXiwOX
         CNUjrPMB0CojXqRdCpqtQ7EskjW0fg6aMCg/xHTKB44ANRlxsa529giGW3CaBKiNEpHB
         d/UhhUaw0jTJ0Ny6cem++sHaqrCMFDS+EBOfaGbprEhK3MJWpPhlLtoxj7XgVdoCbdMn
         nl3nNj6Q0XT6WgurIZGmdYQYY6tjMBvz/YBvFH2b/J/MOk2djeG/5nAozekggCA4jmjc
         ssK+Ue8W3WmUT+XFAz9z3Z67joe8mATZCZtO8Pivzgm9o7Dggp8TdVFVpQ7V/lKk4j0w
         67mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573939; x=1694178739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNiF3pA+0+qY0qK3ASasuqwlcdJADBiCgPi55U0202M=;
        b=F3qhgBTXwTYgGkgrF7E+GJ2RKdzv/7jWCkdqDxQ6SgU9QtPNIme12U1eMv0RZXmSaz
         znW/1CRp++5o+y5WWytrsQEnc7KtETStsmYFDZkZ+p1Yuganf+oJ8xwnRygaUU3HgjDJ
         tVRm6s/VRJAx0fdPte82eaab/pbBrb8Mo+ljr68a3qWPr/bLWlNmfobaogBV1te+JYJK
         pEYEJpFtuS1BQhWhLe9apGtlWdAKKDaYEZTcctEbFy6vfC8pDOyctN5IloWL8+5PTUeJ
         Vi2MLkhYIHqvPxzm0Zxvw39nptIT1gJO23p7Y5S5p/MnzQ2n7L5748lQtzHZnJ+ZRWyA
         gvDQ==
X-Gm-Message-State: AOJu0YwRhU6+FrKQqetPZ8EF95AZ25KYjXlX2D+3sqerpIVTb4uYhDhG
	yhOxwbQK7UMxvgECsfdoc90=
X-Google-Smtp-Source: AGHT+IGBQefsc7mJ4WnIhLdDlaxxRG/fob8+UmUxMBM2RG53ysTTi1uKNka3ybt2ZfLqJ4gLIrPEZA==
X-Received: by 2002:a17:906:9bca:b0:9a1:db2e:9dbb with SMTP id de10-20020a1709069bca00b009a1db2e9dbbmr1851739ejc.0.1693573938850;
        Fri, 01 Sep 2023 06:12:18 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906529900b0099b42c90830sm1964239ejm.36.2023.09.01.06.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:12:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Sep 2023 15:12:16 +0200
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf] docs/bpf: Fix "file doesn't exist" warnings in
 {llvm_reloc,btf}.rst
Message-ID: <ZPHjMLpkRjY3BniQ@krava>
References: <20230901125935.487972-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901125935.487972-1-eddyz87@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 01, 2023 at 03:59:35PM +0300, Eduard Zingerman wrote:
> scripts/documentation-file-ref-check reports warnings for (valid)
> cross-links of form:
> 
>   :ref:`Documentation/bpf/btf <BTF_Ext_Section>`
> 
> Adding extension to the file name helps to avoid the warning, e.g:
> 
>   :ref:`Documentation/bpf/btf.rst <BTF_Ext_Section>`
> 
> Fixes: be4033d36070 ("docs/bpf: Add description for CO-RE relocations")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309010804.G3MpXo59-lkp@intel.com/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  Documentation/bpf/btf.rst        | 2 +-
>  Documentation/bpf/llvm_reloc.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index ffc11afee569..e43c2fdafcd7 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -803,7 +803,7 @@ structure when .BTF.ext is generated. All ``bpf_core_relo`` structures
>  within a single ``btf_ext_info_sec`` describe relocations applied to
>  section named by ``btf_ext_info_sec->sec_name_off``.
>  
> -See :ref:`Documentation/bpf/llvm_reloc <btf-co-re-relocations>`
> +See :ref:`Documentation/bpf/llvm_reloc.rst <btf-co-re-relocations>`
>  for more information on CO-RE relocations.
>  
>  4.2 .BTF_ids section
> diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
> index 73bf805000f2..44188e219d32 100644
> --- a/Documentation/bpf/llvm_reloc.rst
> +++ b/Documentation/bpf/llvm_reloc.rst
> @@ -250,7 +250,7 @@ CO-RE Relocations
>  From object file point of view CO-RE mechanism is implemented as a set
>  of CO-RE specific relocation records. These relocation records are not
>  related to ELF relocations and are encoded in .BTF.ext section.
> -See :ref:`Documentation/bpf/btf <BTF_Ext_Section>` for more
> +See :ref:`Documentation/bpf/btf.rst <BTF_Ext_Section>` for more
>  information on .BTF.ext structure.
>  
>  CO-RE relocations are applied to BPF instructions to update immediate
> -- 
> 2.41.0
> 
> 

