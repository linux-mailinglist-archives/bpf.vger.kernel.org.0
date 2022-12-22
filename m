Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D922C653E28
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 11:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiLVKUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 05:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiLVKUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 05:20:11 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39D29FDA
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 02:20:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 131-20020a1c0289000000b003d35acb0f9fso3523768wmc.2
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fH86SgBm5zcGvs2uj4siMvnBFuMhqa2lOZN+ZYaoXEw=;
        b=44h1MyChmxH/yAloGSMnKx5ZMcLQfTXZPZ5ZU38FrBhwgb4uNSTfd2mBLF7WKrLpiU
         Ak1x84HyjlEgw99cGv8CdmtKcY81zGpUJhpqFtmVCd4sQG4LOI11SHfvrPgdFxa24sm2
         8iSSoAlswmiFi7oD8Mn5UmM4M8aBzfndaJtQK4dJqHOb/42GKGOE6UNg+nM0I470BJZS
         FbjeTdXOWU5laoZjF7QfeC1BO9Lz2Ix2G0OPnE43yeYO86SRAFhWox990SSSwENrlUlr
         R+cdBA1FbGHV8FLDmv07zZ8z6KFUTJvNbi0W+DAL5bXw6XDs7oOPQ0GL1SoR9C7azDi8
         usVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH86SgBm5zcGvs2uj4siMvnBFuMhqa2lOZN+ZYaoXEw=;
        b=4/POdFmdXnSUp3F3NH1K/TPekCtDCLC7QVzZ8YwOJo1OSW6kkAXdkiTOT+ySvP3Jh1
         pYYwfi4OXd1dRmsVpi7zJEZVtqqSJACeplSPC0oDsbSGklFT0r2l39HpFGx3mirKfiWO
         0FEti4Wn2goyyRytoQMMj1eMJ9muureg1G7P0FfYuS9G6DSrs5EFT3AAk4Ec+ZewJ6/Z
         aYacPsUtHG3GWe4d/TWqMBpYZr2bL8Qsvq5i4bTwPfiXHNac6JNuAtdWeZoVSyNhGlKf
         3Lv3/G7D2wPnjt0HsklIvphWWDoJzJOpy5Q8F4kCaj8veamaqHtz/ov+xiCFIprHKNGp
         lJJA==
X-Gm-Message-State: AFqh2kq5pgvD5772yrkgcNOiYH/ZA3e1wd2T4pdtq4HCuuLzQPfFicM1
        8/T6wXPIpEyM1smf+pMmBj3cSQ==
X-Google-Smtp-Source: AMrXdXtGM5TfVN7eBGXqkClHWm6kF8HE+JkluBDgBLN6TgNMV/PZ1Bt6F4BMU59BLybLETzwKU/c8g==
X-Received: by 2002:a05:600c:3596:b0:3d2:3b8d:21e5 with SMTP id p22-20020a05600c359600b003d23b8d21e5mr3795762wmq.14.1671704408326;
        Thu, 22 Dec 2022 02:20:08 -0800 (PST)
Received: from lavr ([2a02:168:f656:0:8f27:899a:2e48:87f6])
        by smtp.gmail.com with ESMTPSA id k31-20020a05600c1c9f00b003d22528decesm5735492wms.43.2022.12.22.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 02:20:07 -0800 (PST)
Date:   Thu, 22 Dec 2022 11:20:06 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH bpf-next] bpftool: fix linkage with statically built
 libllvm
Message-ID: <Y6QvVuuPvmMbsZPB@lavr>
References: <20221221103007.1311799-1-aspsk@isovalent.com>
 <Y6NfpU8zo6t3dEhC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6NfpU8zo6t3dEhC@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 22/12/21 11:33, sdf@google.com wrote:
> On 12/21, Anton Protopopov wrote:
> >   [...]
> 
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 787b857d3fb5..e4c15095eac7 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -144,7 +144,7 @@ ifeq ($(feature-llvm),1)
> >     CFLAGS  += -DHAVE_LLVM_SUPPORT
> >     LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
> >     CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs
> > $(LLVM_CONFIG_LIB_COMPONENTS))
> > -  LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> > +  LIBS    += $(shell $(LLVM_CONFIG) --libs --system-libs
> > $(LLVM_CONFIG_LIB_COMPONENTS)) -lstdc++
> 
> 
> Why not do separate lines? We can then maybe do a bit safer approach?
> 
> LIBS += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> ifeq ($(USE_STATIC_COMPONENTS), static)
> LIBS += $(shell $(LLVM_CONFIG) --system-libs))
> LIBS += -lstdc++
> endif
> 
> Can we use `llvm-config --shared-mode` to get USE_STATIC_COMPONENTS?

Thanks, I didn't know about the --shared-mode thing. I will send the v2.

> 
> >     LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
> >   else
> >     # Fall back on libbfd
> > --
> > 2.34.1
> 
