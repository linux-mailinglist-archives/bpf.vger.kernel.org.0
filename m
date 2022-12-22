Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCF965457A
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 18:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiLVRGe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 12:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiLVRGd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 12:06:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBFCC772
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 09:06:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3ceb4c331faso26152777b3.2
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 09:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+WLXEiYmrxSGwumNQehGRRmWgXllVKlWEuZq8mHqoE=;
        b=hGbljtyPPDxv1A28yAy9es5a5nhH6GQhb+0dTeD+9P8ix3pA5Gbb/NgEdLgng67UT6
         SdBXpEgY2wC3oc1yzt2NZr0uMOdvh6YckG8aevLzOVVhS2CPzH6WNU0kfGc+wcmRYz90
         APynx0TQRxz6hEcLiFmWDN6JaX4PgBsLY0lg12L4FMGO+4ZFGHqtkZBbBXg49l9iEWvh
         jOVVZe00kd0SI7F1UbZGJ3zn44YkywgovxwySGL5HE3ctvfONTUmTjDYpQxL+T3zMtxz
         tsW8LBSofqrCgzOSvcxnGQIsNLViXyGUJUQYqOj0b8DKEg+BmjfMVxswI3Al0q3KckFq
         Ms/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+WLXEiYmrxSGwumNQehGRRmWgXllVKlWEuZq8mHqoE=;
        b=sJL1aY94ZdrQvk9+TmMSUBNZS75SUdYwHpiVJ7OIqoBJRQT3oj2Jt4dT+tVHLRufqI
         2LHWOdB7eRIUAwKuokAHbMSEoW96zs0ym9mcOBP0K3so1a2pKIH1JBHHUXvv15lHo0La
         h0gVXMfNi9mpVL58tj6fDbkXaGCoOGpgE5d9spBtEFkmWSPSCYRuNVcau6Fs2Tx+dmyE
         4G0RiiHvD9VCvu5zmKb5ER9yLvmvBx2xtA0yeNL3PvEW3B2G/RsnlCkJuKWC9fiP6XQp
         varqqscQ8nOviuHtCwwWnF1MEI1v/gQwCzglSBiNwoNTKPiFcpllyCUNAt7w8Rmn3jcz
         M7BQ==
X-Gm-Message-State: AFqh2krAdILu+/+hG915eyU/oleDYxX90BK9VB08AmriGi9vD6iQ/nFo
        p1EoVFmT5iSXzf5th/jf4wnTgNU=
X-Google-Smtp-Source: AMrXdXv8fUN16PriuczKr3iFc/kjW/WiiLR5QBTmhFvkTRDnY8RDKz1ZC9ngMRlU72d/B8GXZIlyapM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a5b:9cc:0:b0:722:f042:1036 with SMTP id
 y12-20020a5b09cc000000b00722f0421036mr721752ybq.34.1671728786031; Thu, 22 Dec
 2022 09:06:26 -0800 (PST)
Date:   Thu, 22 Dec 2022 09:06:24 -0800
In-Reply-To: <20221222102627.1643709-1-aspsk@isovalent.com>
Mime-Version: 1.0
References: <20221222102627.1643709-1-aspsk@isovalent.com>
Message-ID: <Y6SOkLtwRfF1WTcK@google.com>
Subject: Re: [PATCH bpf-next v2] bpftool: fix linkage with statically built libllvm
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

On 12/22, Anton Protopopov wrote:
> Since the eb9d1acf634b commit ("bpftool: Add LLVM as default library for
> disassembling JIT-ed programs") we might link the bpftool program with the
> libllvm library.  This works fine when a shared libllvm library is  
> available,
> but fails if we want to link bpftool with a statically built LLVM:

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

> So in the case of static libllvm we need to explicitly link bpftool with
> required libraries, namely, libstdc++ and those provided by the  
> `llvm-config
> --system-libs` command.  We can distinguish between the shared and static  
> cases
> by using the `llvm-config --shared-mode` command.

> eb9d1acf634b commit ("bpftool: Add LLVM as default library for  
> disassembling JIT-ed programs")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Thank you!

> ---
> v2:
>    Use llvm-config to distinguish between shared and static modes  
> (Stanislav)

>   tools/bpf/bpftool/Makefile | 4 ++++
>   1 file changed, 4 insertions(+)

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 313fd1b09189..ab20ecc5acce 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -145,6 +145,10 @@ ifeq ($(feature-llvm),1)
>     LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>     CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs  
> $(LLVM_CONFIG_LIB_COMPONENTS))
>     LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> +  ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
> +    LIBS += $(shell $(LLVM_CONFIG) --system-libs  
> $(LLVM_CONFIG_LIB_COMPONENTS))
> +    LIBS += -lstdc++
> +  endif
>     LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
>   else
>     # Fall back on libbfd
> --
> 2.34.1

