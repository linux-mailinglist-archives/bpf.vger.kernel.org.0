Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB84A60E9
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 17:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbiBAQB6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 11:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbiBAQB6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 11:01:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15615C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 08:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C32D616FD
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 16:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B85C340EB;
        Tue,  1 Feb 2022 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643731317;
        bh=hGfZZ9bBYY+bCNNU83upYdVCO5KAqgPJ2wkt7zm1oNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBk75CJldupzxQ2UDc7nl+vwG8ynrxmAVKQGCLo/HQp8A2T0sG10v7zuNr2DBRGdE
         HySQq2yjeeHF6OuMd+zj3k9TZ1cGOOzOuGM6c+KV9x7f0AaAjgMdyJn8cCUWkZXcOP
         BbX0VHCc9BR7GrtAdkhYefwrLh+ttA0M7c2B99VxmRj1DRBduYUR7evdHyQgu+mrOs
         mL/LJ3ypu/8Bete+/xMckuFWLAMGR/96dBXiBqsOqK15IkmijEstrJjpKLG1YZfnYQ
         Jrew3ot986hSFgsZV6AtCBPbQtv+q8jjwn53hqGtJMaIoSkqGbVnXvPmvda1PMlN+e
         rQ1P6saoJGuMA==
Date:   Tue, 1 Feb 2022 09:01:52 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ndesaulniers@google.com, llvm@lists.linux.dev, bpf@vger.kernel.org,
        andrii@kernel.org, quentin@isovalent.com
Subject: Re: [PATCH] tools: Ignore errors from `which' when searching a GCC
 toolchain
Message-ID: <YflZcEjaPoN8G84c@dev-arch.archlinux-ax161>
References: <20220201093119.1713207-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201093119.1713207-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 01, 2022 at 09:31:20AM +0000, Jean-Philippe Brucker wrote:
> When cross-building tools with clang, we run `which $(CROSS_COMPILE)gcc`
> to detect whether a GCC toolchain provides the standard libraries. It is
> only a helper because some distros put libraries where LLVM does not
> automatically find them. On other systems, LLVM detects the libc
> automatically and does not need this. There, it is completely fine not
> to have a GCC at all, but some versions of `which' display an error when
> the command is not found:
> 
> 	which: no aarch64-linux-gnu-gcc in ($PATH)
> 
> Since the error can safely be ignored, throw it to /dev/null.
> 
> Fixes: cebdb7374577 ("tools: Help cross-building with clang")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thanks a lot for the quick fix!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

It would be nice if this could go in via bpf, as cebdb7374577 was merged
in 5.17-rc1.

> ---
>  tools/scripts/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index b0be5f40a3f1..79d102304470 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -90,7 +90,7 @@ EXTRA_WARNINGS += -Wstrict-aliasing=3
>  
>  else ifneq ($(CROSS_COMPILE),)
>  CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
> -GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc))
> +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/null))
>  ifneq ($(GCC_TOOLCHAIN_DIR),)
>  CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
>  CLANG_CROSS_FLAGS += --sysroot=$(shell $(CROSS_COMPILE)gcc -print-sysroot)
> -- 
> 2.34.1
> 
> 
