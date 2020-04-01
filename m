Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB75019AF06
	for <lists+bpf@lfdr.de>; Wed,  1 Apr 2020 17:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgDAPt0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Apr 2020 11:49:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38064 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732966AbgDAPt0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 11:49:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so37818plz.5
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2020 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ySKX8LJGChHC8c8x0OQmrTxCx//5fIDMajpHfT6ERsw=;
        b=fYGIqS4w9FpClJWxf/snstu/bTH/DlaBxQ+pEq2Y/GNnZQYhfDgue/9Lz65NoujHM9
         LSxifCvxnIYPKf2GWZY90VOJwTSLJWpwxgDs7Js/2+jdx5gWGXq3ir2iVZK7zD365h/N
         P8618F8gyRMfSa+q7hWsIqDVOexwB7konfVek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ySKX8LJGChHC8c8x0OQmrTxCx//5fIDMajpHfT6ERsw=;
        b=IvZGFffM4BM0Dy3dPVirFoPbgh8/NG4bABrJCnGlg1341tokv2G5Iotwk1aLkCbKWj
         OHYSWTmiz+OQcnqzaMTl6NbI38A1zw0eAw2YgdHyd+VOUe6+nw5oNeGOwVzeS/4mrWPA
         yGShCKUnEq4DWZNuxAqqD5FrjCI4qMxk/J4UEqy475AXjwetSJjYhmgSFPhH6pFHPdmH
         nQhfDGptZ3ojhGJovMQ8O+MuwzIEt9W4sJCAY1CEZ6K+bUJgAN/3Qi9xoK6ThSt/N1m+
         2iBj/5El4hy+nWgNwVel9ZlnGIoGa2Cfo8ZXX7N1zo5XIg8ufTnznE9XbtuagqkAiFfQ
         BzXA==
X-Gm-Message-State: AGi0PuYpYDCJOw/yUMaRayMBGnhMmyWJZD56HS3rIGpLFLeX46XdmVsl
        jqD8xUpiruUutd2HT5u3hVhAhw==
X-Google-Smtp-Source: APiQypKdrU/NsWejH1n/G3BfA3vTkH3qucG2TO6GKLDMoF3lPyJQdaiJTFZ4/arwCmTtqjxfFpIr1Q==
X-Received: by 2002:a17:90b:110f:: with SMTP id gi15mr5488512pjb.184.1585756165084;
        Wed, 01 Apr 2020 08:49:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3sm1837199pfp.167.2020.04.01.08.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:49:23 -0700 (PDT)
Date:   Wed, 1 Apr 2020 08:49:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     andriin@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        jannh@google.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, kernel-hardening@lists.openwall.com,
        liuyd.fnst@cn.fujitsu.com, KP Singh <kpsingh@google.com>
Subject: Re: [PATCH v3 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Message-ID: <202004010849.CC7E9412@keescook>
References: <202004010033.A1523890@keescook>
 <20200401142057.453892-1-slava@bacher09.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401142057.453892-1-slava@bacher09.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 01, 2020 at 05:20:58PM +0300, Slava Bacherikov wrote:
> Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> enabled will produce invalid btf file, since gen_btf function in
> link-vmlinux.sh script doesn't handle *.dwo files.
> 
> Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
> using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.
> 
> Signed-off-by: Slava Bacherikov <slava@bacher09.org>

Very cool; thanks! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Reported-by: Jann Horn <jannh@google.com>
> Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> Acked-by: KP Singh <kpsingh@google.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
> ---
>  lib/Kconfig.debug | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f61d834e02fe..b94227be2d62 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -222,7 +222,9 @@ config DEBUG_INFO_DWARF4
>  
>  config DEBUG_INFO_BTF
>  	bool "Generate BTF typeinfo"
> -	depends on DEBUG_INFO
> +	depends on DEBUG_INFO || COMPILE_TEST
> +	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
> +	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>  	help
>  	  Generate deduplicated BTF type information from DWARF debug info.
>  	  Turning this on expects presence of pahole tool, which will convert

-- 
Kees Cook
