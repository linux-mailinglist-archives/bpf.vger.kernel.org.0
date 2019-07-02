Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5649D5D48E
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2019 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGBQrP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jul 2019 12:47:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44357 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBQrP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jul 2019 12:47:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so3292367pgl.11
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2019 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AwqtYCgoVgMFd7zLHFhWGcqejisGWIssWVV7qBN5clA=;
        b=fzB5MVLqWtyuS6TrHWjeVZWCRt7xTFDG2hc/XyaXBc42/GpMFNc0clWc7wyZC3/x9k
         lKWMANDwnbugpxtIihI9PPsv7PZU6CAqFs74AAgSzug0hb03S3WTAXUqkf6OA2TLqj/F
         lAVi3uicaXPR015jxEg0o8Lz9CCKLPKG65XS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AwqtYCgoVgMFd7zLHFhWGcqejisGWIssWVV7qBN5clA=;
        b=RCGI9TC4+BOTesEUqBxAyJfjTvecZGQH6vqNTOGrK9udO0cYJB7OkkU+2OngVKUVTy
         n5IGGjLB65pWnROBSpG4qIGauaGhn0M5psG87YltkaKfJnx0+uU5dYDR6iuUHeGIViUk
         FHfyvPW47+EFnCjvXbawk5UyhCWzJwMyKAdukVvYpcAkTv6VMWgyhR73gG52SPXSIOjh
         7joNIsmgSB/RCjyGphFNLP8L4rGk6s97tV6pOke42AJ8rqTciUcgafD9hJE9ySol9oVr
         KBrimhakXZQV9nLlqoqr/d4uZ/8JecRIycY0FaK4b8Y+DJ1XNOxZ2duVladAl/ZXLnng
         mH7g==
X-Gm-Message-State: APjAAAWe6+gcwD5EQ42WqQE4zMe41HMhgDpPg3O45xxcjSuXqeW+1oXW
        A+gkIG25AUjhw82xVtE3w+7wHQ==
X-Google-Smtp-Source: APXvYqzQ8uHzZ6YNkTzdPuzkj3M5yMySr4CirEds9hca/3caI4D9NArfxglQSOD3nsK4x9A5ZVXEgQ==
X-Received: by 2002:a63:bd0a:: with SMTP id a10mr17207509pgf.55.1562086034555;
        Tue, 02 Jul 2019 09:47:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q1sm20178917pfg.84.2019.07.02.09.47.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 09:47:13 -0700 (PDT)
Date:   Tue, 2 Jul 2019 12:47:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Tony Luck <tony.luck@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        xdp-newbies@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Colin Cross <ccross@android.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 7/7] kbuild: compile-test kernel headers to ensure they
 are self-contained
Message-ID: <20190702164712.GA98338@google.com>
References: <20190701005845.12475-1-yamada.masahiro@socionext.com>
 <20190701005845.12475-8-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701005845.12475-8-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 01, 2019 at 09:58:45AM +0900, Masahiro Yamada wrote:
> The headers in include/ are globally used in the kernel source tree
> to provide common APIs. They are included from external modules, too.
> 
> It will be useful to make as many headers self-contained as possible
> so that we do not have to rely on a specific include order.
> 
> There are more than 4000 headers in include/. In my rough analysis,
> 70% of them are already self-contained. With efforts, most of them
> can be self-contained.
> 
> For now, we must exclude more than 1000 headers just because they
> cannot be compiled as standalone units. I added them to header-test-.
> The blacklist was mostly generated by a script, so the reason of the
> breakage should be checked later.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Jani Nikula <jani.nikula@intel.com>
> ---
> 
> Changes in v4:
>   - Fix vmlinux build error
>   - Exclude more headers for sparc
> 
> Changes in v3:
>   - Exclude more headers
>    (Tested for allnoconfig + CONFIG_HEADER_TEST=y)
> 
> Changes in v2:
>   - Add everything to test coverage, and exclude broken ones
>   - Rename 'Makefile' to 'Kbuild'
>   - Add CONFIG_KERNEL_HEADER_TEST option
> 
>  Makefile       |    1 +
>  include/Kbuild | 1253 ++++++++++++++++++++++++++++++++++++++++++++++++
>  init/Kconfig   |   11 +
>  3 files changed, 1265 insertions(+)
>  create mode 100644 include/Kbuild
[snip
> diff --git a/init/Kconfig b/init/Kconfig
> index 74192de8ada6..e2e99544da8d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -108,6 +108,17 @@ config HEADER_TEST
>  	  If you are a developer or tester and want to ensure the requested
>  	  headers are self-contained, say Y here. Otherwise, choose N.
>  
> +config KERNEL_HEADER_TEST
> +	bool "Compile test kernel headers"
> +	depends on HEADER_TEST
> +	help
> +	  Headers in include/ are used to build external moduls.

Nit:
							 modules.

Otherwise lgtm, thanks for the cc.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

