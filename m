Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1962265370E
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 20:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiLUTeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 14:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiLUTeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 14:34:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A99240B4
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:33:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v195-20020a252fcc000000b007125383fe0dso18874117ybv.23
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBUkWAxyk2/y7UUHggB/nDL8+b+dKQlVLMxsOSz+sjI=;
        b=hAs85z66ba8HRHIiOitUJ7AkF+UsdYTFUNb5mqWXMiKtSzOut8L87gCOnaxCdwQvkL
         5UhRiJ5MiTje+RmazJWDQvOIg0j/MaEuo91OgFm5WgM/5EMScqbd/jFzHAVrvMGqhJZO
         58KjRRsWbc6j6/l+DiEy9w6je3y3sciBaYhWLRdj9w16qr7mNta3G4J54IciSCAKwhQS
         6Anod8xYrMsqwepWNjpSDHYCYJyIwySC5f0C4XUH3h8yXXv5pag6PFt55CTyPuP3B9/1
         EiDqwHBJmo2Ag0huqZiHGgF7AK3Vi1+HI+dZjoQRsHF7ArD1/N+7LlB5tODePbx/EWHW
         Cj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBUkWAxyk2/y7UUHggB/nDL8+b+dKQlVLMxsOSz+sjI=;
        b=i8KP4tx8RgBNI4gcjW8K2pSJbwDs6m6C/WLQnuuetWewsncL4ulhw/SGz9tuv0uGit
         iRKdb2OK5XjYNuCExppTuu7fqJJmg0ufRLLd/Y78Ky5D6euOcY2DMHBCuUnifyg/dihQ
         zzKTlvGMUBiBOuc7rocrTDdYII82R736wchezfHwaz27DG8+W19FDi6o/gSrM9Qj2KKK
         z0pizkfKM+J2H5vucS6l4HH42dlAEcM4ygWiT49uW0ntf1TAQ1GeRSw+oiCD2klWmUcq
         xGz/G1E3YrILyXf0I+nTrfPs3j3UzvmAE1pu6EMrfTWcSWEgL16bFxfElSeKOV8XpqUF
         l0tg==
X-Gm-Message-State: AFqh2kpLohcBV+vBDoh5BgyuD7gY4CMCqbSyBfRX5sMFWhmil+K0VKqq
        3oYGJ6zvjzvIuuWRG64zzfgFT0w=
X-Google-Smtp-Source: AMrXdXsbD5ESoOdEWUoqSPIAJVsMe3fQ09rB43Os2QYH49SlTYRaGOFHjuDMSrstYlG7jRpL3vz1hKQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:8b03:0:b0:6df:1529:6ba with SMTP id
 i3-20020a258b03000000b006df152906bamr168904ybl.145.1671651238962; Wed, 21 Dec
 2022 11:33:58 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:33:57 -0800
In-Reply-To: <20221221103007.1311799-1-aspsk@isovalent.com>
Mime-Version: 1.0
References: <20221221103007.1311799-1-aspsk@isovalent.com>
Message-ID: <Y6NfpU8zo6t3dEhC@google.com>
Subject: Re: [PATCH bpf-next] bpftool: fix linkage with statically built libllvm
From:   sdf@google.com
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/21, Anton Protopopov wrote:
> Since the eb9d1acf634b commit ("bpftool: Add LLVM as default library for
> disassembling JIT-ed programs") we might link the bpftool program with the
> libllvm library.  This works fine when a dynamically built libllvm  
> available,
> but fails if we want to link bpftool with a statically built llvm:

>      /usr/bin/ld:  
> /usr/local/lib/libLLVMSupport.a(CrashRecoveryContext.cpp.o): in function  
> `llvm::CrashRecoveryContextCleanup::~CrashRecoveryContextCleanup()':
>       
> CrashRecoveryContext.cpp:(.text._ZN4llvm27CrashRecoveryContextCleanupD0Ev+0x17):  
> undefined reference to `operator delete(void*, unsigned long)'
>      /usr/bin/ld:  
> /usr/local/lib/libLLVMSupport.a(CrashRecoveryContext.cpp.o): in function  
> `llvm::CrashRecoveryContext::~CrashRecoveryContext()':
>       
> CrashRecoveryContext.cpp:(.text._ZN4llvm20CrashRecoveryContextD2Ev+0xc8):  
> undefined reference to `operator delete(void*, unsigned long)'
>      ...

> To fix this we need to explicitly link bpftool with required libraries,  
> namely,
> libstdc++ and those provided by `llvm-config --system-libs`.  This patch
> doesn't change the build with a dynamically built libllvm, as the  
> `llvm-config
> --system-libs` list is empty in this case, and the bpftool is linked with  
> the
> libstdc++ in any case as this is a dynamic dependency of libLLVM.so.

> eb9d1acf634b commit ("bpftool: Add LLVM as default library for  
> disassembling JIT-ed programs")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>   tools/bpf/bpftool/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 787b857d3fb5..e4c15095eac7 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -144,7 +144,7 @@ ifeq ($(feature-llvm),1)
>     CFLAGS  += -DHAVE_LLVM_SUPPORT
>     LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>     CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs  
> $(LLVM_CONFIG_LIB_COMPONENTS))
> -  LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> +  LIBS    += $(shell $(LLVM_CONFIG) --libs --system-libs  
> $(LLVM_CONFIG_LIB_COMPONENTS)) -lstdc++


Why not do separate lines? We can then maybe do a bit safer approach?

LIBS += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
ifeq ($(USE_STATIC_COMPONENTS), static)
LIBS += $(shell $(LLVM_CONFIG) --system-libs))
LIBS += -lstdc++
endif

Can we use `llvm-config --shared-mode` to get USE_STATIC_COMPONENTS?

>     LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
>   else
>     # Fall back on libbfd
> --
> 2.34.1

