Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA319A200
	for <lists+bpf@lfdr.de>; Wed,  1 Apr 2020 00:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgCaWk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 18:40:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38299 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 18:40:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id c7so2211272wrx.5
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2020 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jY5b0DeIGw0kq+dmH/vJgCrU2SOoRk0fZBuTs/xmVo0=;
        b=VDiCMTXyKUNt4iheUBH8m+6xsiIx/rgJTGicdZ/BWJF7GmTfsrCY7g+447EMzve3aq
         Y+ldUezP4BlAWoR5IQfLpc6iFnWWr1G6v9bb02zEQLrKSg4qsJ4HrBuw7+exNKd9bAfU
         jdqJY5s8D3nIc5Tz5vqTofy5j8BNQJ7duYeCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jY5b0DeIGw0kq+dmH/vJgCrU2SOoRk0fZBuTs/xmVo0=;
        b=FjIi5hLooHjzde1apG7kkKyaoWYvfFuCHVTnjrr2NcESBRX1cxNqirpX8zcodMs0oE
         SE7WYk6HLj7aglvMNl6T+IJIDAgrP/5irvKz3PGw7QjCfKJL7kMF/Grwp3kw/t8Y8lgQ
         x4lFESiTcnhpvp7A3nJCWaIdDsCEjnFqBLdDu969fdOGfzzTrS6modb8aowLs4TVOUMU
         SwA6/RaCKfImIXNy04D7EdsbKrNZgTWtetKs+um/lLn8J5w9wgg4pxkSLa0ZLe5aGIrM
         MU4Wdup4bJ+vyOHHcfVBPZVCfYceyP5ee3NaxnV6Gs28Tu3LWfXgawIxWVsNhRZo+HFu
         rwkw==
X-Gm-Message-State: AGi0PuZY654Ka0B5qlY7nquniu0yc0zoHZwsOu2m4xqlIAEpxC2OrHHK
        uS87dB36Tyeka5n0g9Xy7wBZyQ==
X-Google-Smtp-Source: APiQypLOGvUileQhr35EVvXv/b90kFXVu0uzau9TlILC3ZUR48htnauWq/BaHsz4upygp1gntHv0QA==
X-Received: by 2002:adf:fe52:: with SMTP id m18mr976140wrs.162.1585694424872;
        Tue, 31 Mar 2020 15:40:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id 138sm79981wmb.21.2020.03.31.15.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:40:24 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 1 Apr 2020 00:40:22 +0200
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     andriin@fb.com, keescook@chromium.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, jannh@google.com,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        kernel-hardening@lists.openwall.com,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Message-ID: <20200331224022.GA23586@google.com>
References: <20200331215536.34162-1-slava@bacher09.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331215536.34162-1-slava@bacher09.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01-Apr 00:55, Slava Bacherikov wrote:
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

I can say that I also got invalid BTF when I tried using
DEBUG_INFO_REDUCED.

So here's a first one from of these from me :)

Acked-by: KP Singh <kpsingh@google.com>

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
> -- 
> 2.24.1
> 
