Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D258795B
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 10:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiHBIwc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 04:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiHBIwa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 04:52:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4163139D;
        Tue,  2 Aug 2022 01:52:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dc19so2032226ejb.12;
        Tue, 02 Aug 2022 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=47uliyErnA8e09JF9HO7R5O/EfooUkx1RpBi+CvBMiE=;
        b=gESk1Z8YO4csPW88/Rem8zWlU9ajVumN1NuZOqjSerOtIkAXrYHQ56cZkR7UgStNo3
         UXsYDEunPb/uP3sFHLlZIBP551F0pHQ6e9R7TtH84bimUs+83hurokCsTGckUcGG+i1F
         Qxpfh/Ag4uliVOneoUqqH2NEKFPVnFG1yE9OxoL01e/CMSwX6zyhoMotKKQ8B1l8H1DL
         riTjB5SyJT6OcgwwZu6aQ53S+eCsj8dx6hriN1rLvjv3OHOLxDxW4VKaAaWHCbS3nvzi
         SwV63szdMEsLfY/I8yu3NF81q7/kTU4xAHAl/qEoXBhsD8y32gGUvN0rlaFgeT+/QriZ
         gi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=47uliyErnA8e09JF9HO7R5O/EfooUkx1RpBi+CvBMiE=;
        b=6daGsIVCFw0dzUjdQBrGtyjkFL+kTjubFTObYHANQRwhEDjo6yIKFRbFLqgL4dGZff
         zAoeg3vGWZVQxGgv7t327EErWmUZRTZV8eh3hEc3DqUZRc7nWsdhiEz2+YFhkiF0/vT0
         nG+U9dQKj/YuMtmUZNl4qs3HBjgZiP+qPhL9roDHukcCEEVwy5QbxzJlGc/AaXtLFLC+
         pSxjpfV8v01fSdB+0oMJNDpFHw/+XOf5/mk6d8JPDume0j99uXkHbFm/qHO0WTxPqhJ+
         PJscur2u+dCI52zP0Kc2OG28AUfz3Y/VsqXvCvdQiay2bSKg/H3p0Jqzjg0yUyLoX2de
         XVQQ==
X-Gm-Message-State: AJIora9byuJ9vHAeffx5OZ+0p58YPXtXylSQ0FkiQWD+ug+Yyue+YzD4
        IeXOYwcAmILGF1bC59+WwZ8=
X-Google-Smtp-Source: AGRyM1smCNL1iF4wy+Op8u1PgSKXaUmky0EFr5tCCngDNbWaVuraIOTO4OFSsjBUoXvfgrpEsPLvmQ==
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id f17-20020a1709063f5100b0071239458c0dmr14894052ejj.302.1659430347780;
        Tue, 02 Aug 2022 01:52:27 -0700 (PDT)
Received: from krava ([83.240.61.12])
        by smtp.gmail.com with ESMTPSA id n16-20020a170906841000b0072aa009aa68sm3201297ejx.36.2022.08.02.01.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 01:52:27 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 2 Aug 2022 10:52:25 +0200
To:     David Faust <david.faust@oracle.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf@vger.kernel.org,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] libbpf: skip empty sections in
 bpf_object__init_global_data_maps
Message-ID: <YujlyZevj6RDoOR6@krava>
References: <20220731232649.4668-1-james.hilliard1@gmail.com>
 <Yug2iYQyd0TNlnHW@krava>
 <2dbffe19-6b28-2ce6-b367-960f2250a12a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dbffe19-6b28-2ce6-b367-960f2250a12a@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 03:21:58PM -0700, David Faust wrote:
> 
> 
> On 8/1/22 13:24, Jiri Olsa wrote:
> > On Sun, Jul 31, 2022 at 05:26:49PM -0600, James Hilliard wrote:
> >> The GNU assembler generates an empty .bss section. This is a well
> >> established behavior in GAS that happens in all supported targets.
> >>
> >> The LLVM assembler doesn't generate an empty .bss section.
> >>
> >> bpftool chokes on the empty .bss section.
> >>
> >> Additionally in bpf_object__elf_collect the sec_desc->data is not
> >> initialized when a section is not recognized. In this case, this
> >> happens with .comment.
> >>
> >> So we must check that sec_desc->data is initialized before checking
> >> if the size is 0.
> > 
> > oops David send same change but I asked him to move the check
> > to bpf_object__elf_collect [1] .. but with your explanation this
> > fix actualy looks fine to me
> 
> FWIW, I only just got back to actually making that change. This
> patch has a much better explanation than the one I sent so +1 from
> me also

thanks, I'm acking this one then

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> David
> 
> > 
> > jirka
> > 
> > 
> > [1] https://lore.kernel.org/bpf/YuKaFiZ+ksB5f0Ye@krava/
> > 
> >>
> >> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >> Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
> >> ---
> >>  tools/lib/bpf/libbpf.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 50d41815f431..77e3797cf75a 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -1642,6 +1642,10 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
> >>  	for (sec_idx = 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
> >>  		sec_desc = &obj->efile.secs[sec_idx];
> >>  
> >> +		/* Skip recognized sections with size 0. */
> >> +		if (sec_desc->data && sec_desc->data->d_size == 0)
> >> +			continue;
> >> +
> >>  		switch (sec_desc->sec_type) {
> >>  		case SEC_DATA:
> >>  			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
> >> -- 
> >> 2.34.1
> >>
