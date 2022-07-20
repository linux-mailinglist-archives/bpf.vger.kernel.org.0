Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD457BAA3
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiGTPlF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 11:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiGTPlE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 11:41:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8AB54
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 08:41:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bp15so33795585ejb.6
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=p0lRHRqdjzrBFsJBAX2IvF3rVb5j3VLAB3YHRQZcNAM=;
        b=AMVP8qorKVtH9fwUj0riS2VU3OCnmZQb5mm9CeHeSMjgg0DBddoufxIgvWxhGIza+O
         7MCT8Z/OAa4XysrJqi8OEQWmyTc5aU5ZJw2aS2fcAd07kpGXXFAMw40Uwc1z8+M11xFR
         RbFXxnP/fbINFppaltw/XsYUZ48+7lGsKY+pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=p0lRHRqdjzrBFsJBAX2IvF3rVb5j3VLAB3YHRQZcNAM=;
        b=ocAGAfgdQ1CpOUFmhhJd/PczDeQ8mwA97y77TcjGvXwljiwGONp/iS31EJ7q8N0atu
         XMBCVbwtQ8q/0gWWYCBUHxg+qYnl1hcaIVJnA06ywrpT29loclm5vAv2bJqwOand5nF7
         qtSJVLQXQjf8dUgbQjANKeluIST7y7iDtz8erTF4e9/UrSRihhrH7Zboah/daoLnmCVT
         R/0FsdbOMEVFab5O5WN4BUd3ne4aLoRqR9oBaG0Hwup4QxiHwc9udOv2SqeOMYrcpqrO
         zLfadRk7bBfZzVPJdNcnWniUQLc5G4o/IkTt2jFtfbt92F5371wEHVgKEmcv8cPXg0mh
         /WtA==
X-Gm-Message-State: AJIora/Z7RE9k3BkH+85aL6nefPWSJHhmx3kLcuFpQwC4nz6g8Rk2egy
        GipFSER0oN9cqbYMAP6oTQ9iIg==
X-Google-Smtp-Source: AGRyM1uGdF8nP0NctodGXfYfpKgnnbEgr09az+TNbUmNN2D6KOiGZ1Ls1wFQRszWawycJp+J2XXtNQ==
X-Received: by 2002:a17:907:94cf:b0:72f:1c2a:d475 with SMTP id dn15-20020a17090794cf00b0072f1c2ad475mr19634188ejc.237.1658331659631;
        Wed, 20 Jul 2022 08:40:59 -0700 (PDT)
Received: from cloudflare.com (79.184.200.53.ipv4.supernova.orange.pl. [79.184.200.53])
        by smtp.gmail.com with ESMTPSA id f17-20020a056402151100b0043b986751a7sm2846150edw.41.2022.07.20.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:40:59 -0700 (PDT)
References: <20220616055543.3285835-1-andrii@kernel.org>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next] libbpf: fix internal USDT address translation
 logic for shared libraries
Date:   Wed, 20 Jul 2022 17:32:23 +0200
In-reply-to: <20220616055543.3285835-1-andrii@kernel.org>
Message-ID: <87lesnyeph.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On Wed, Jun 15, 2022 at 10:55 PM -07, Andrii Nakryiko wrote:

[...]

> This patch also changes selftests/bpf Makefile to force urand_read and
> liburand_read.so to be built with Clang and LLVM's lld (and explicitly
> request this ELF file size optimization through -znoseparate-code linker
> parameter) to validate libbpf logic and ensure regressions don't happen
> in the future. I've bundled these selftests changes together with libbpf
> changes to keep the above description tied with both libbpf and
> selftests changes.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

[...]

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 8ad7a733a505..e08e8e34e793 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -172,13 +172,15 @@ $(OUTPUT)/%:%.c
>  # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
>  	$(call msg,LIB,,$@)
> -	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS) -fPIC -shared -o $@
> +	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS)   \
> +		     -fuse-ld=lld -Wl,-znoseparate-code -fPIC -shared -o $@
>  
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
>  	$(call msg,BINARY,,$@)
> -	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^)  \
> -		  liburandom_read.so $(LDLIBS)	       			       \
> -		  -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
> +	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
> +		     liburandom_read.so $(LDLIBS)			       \
> +		     -fuse-ld=lld -Wl,-znoseparate-code	       		       \
> +		     -Wl,-rpath=. -Wl,--build-id=sha1 -o $@

[...]

Not sure if this was considered - adding a dependency on Clang for the
target platform makes cross-compiling bpf selftests much harder than it
was.

Maybe we could use $(CLANG) only when not cross-compiling, and execute
$(CC) like before otherwise?
