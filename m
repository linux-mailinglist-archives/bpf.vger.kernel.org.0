Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC4E19A64E
	for <lists+bpf@lfdr.de>; Wed,  1 Apr 2020 09:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgDAHe4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Apr 2020 03:34:56 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38302 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgDAHez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 03:34:55 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so2324152pje.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2020 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e9j0gXLS8BiPnG8hg4KhkQMvt4m3nuldxIMCe99NUSM=;
        b=CzwRDrj2h0sa5kX72PUVDeT6L3fY9qudsdi8KkOaBKK9gQI9Rk35RY8a+tf/7T/90X
         Zl5oGkGuBSVb657tgNqL16cqTQjKM3o1b6z/xqQcfhcf5YAqC/8MEoQ6vJl0xnuS4T1p
         bLhOvG+N19w8AdK3xAI90GJXQBJzHg/Idzk0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9j0gXLS8BiPnG8hg4KhkQMvt4m3nuldxIMCe99NUSM=;
        b=p4O0z1XqyVcvOeJ9Q6LyRI1hMgQLQ3veQxS2VI3xpsDJLESbdvx8beB1ocVAaGs7dW
         VS77I7+XaQoSyq9AkDnDeW9A7+5SlUpTq7hsXdsGQ320DSdyelb3gyj63UXIQ+KKu0ll
         JH1B4K17ZRnwzE6nxXUyb5Srz8a0wCsEOxcoV1JEe3+vLzzFNCgt0WKo9SY5Z/jxjBz+
         epSfZC8ZD40aBdECnNO+bPoMbOz3CfGpR2lIA6kUuu+xJjIsJG4IxdHhy3H3QwF9Fwh1
         uy8boE1ToKI8+nDA7Nrgk0OsqQ7/JjEYKXCfHDNCxnmY3k8QOCs1hBpDCWgFZC2/9BeS
         Qu+A==
X-Gm-Message-State: AGi0PuZdfxeOBm1Cj2ELhIzGxvbxKTJ6KXe5M82PpBWFft4EZJS8wOw3
        3S3YSapYEbhdvlUHvJPksWJIhQ==
X-Google-Smtp-Source: APiQypJDNRDZ33Sc9rxPUXsp2xFXUXbugulWQqiDDPonuNaxSEsO5TuU3WlX80cycoM1zufaEYn2wA==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr7180158plt.61.1585726494195;
        Wed, 01 Apr 2020 00:34:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w74sm948693pfd.112.2020.04.01.00.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:34:53 -0700 (PDT)
Date:   Wed, 1 Apr 2020 00:34:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     andriin@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        jannh@google.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, kernel-hardening@lists.openwall.com,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Message-ID: <202004010033.A1523890@keescook>
References: <20200331215536.34162-1-slava@bacher09.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331215536.34162-1-slava@bacher09.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 01, 2020 at 12:55:37AM +0300, Slava Bacherikov wrote:
> Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> enabled will produce invalid btf file, since gen_btf function in
> link-vmlinux.sh script doesn't handle *.dwo files.
> 
> Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
> using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.
> 
> Signed-off-by: Slava Bacherikov <slava@bacher09.org>
> Reported-by: Jann Horn <jannh@google.com>
> Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f61d834e02fe..9ae288e2a6c0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -223,6 +223,7 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_BTF
>  	bool "Generate BTF typeinfo"
>  	depends on DEBUG_INFO
> +	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED && !GCC_PLUGIN_RANDSTRUCT
>  	help
>  	  Generate deduplicated BTF type information from DWARF debug info.
>  	  Turning this on expects presence of pahole tool, which will convert

Please make this:

depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
depends on COMPILE_TEST || !GCC_PLUGIN_RANDSTRUCT

-Kees

-- 
Kees Cook
