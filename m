Return-Path: <bpf+bounces-12682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35137CF243
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 10:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539CBB21134
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EE414F8E;
	Thu, 19 Oct 2023 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFg6z0d/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E214F6D
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 08:17:35 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D3C10F;
	Thu, 19 Oct 2023 01:17:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so12624780a12.2;
        Thu, 19 Oct 2023 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697703452; x=1698308252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwG2LuDV5TxCH2siLTag2qyW7fA8AfNbKnYJ2f17ZIc=;
        b=PFg6z0d/ayyZxlLtZXEW7Txl96SA9f70inXirnHBqGYg+byvaQGgB6ZFEAJruCX5Ll
         zRQnp3uGBUvGvdSQwxQxgbK+CGehKBp2dl+U/fNWeTTNwtSZh5yCpZl3HP8bVO9CjkUL
         HKtMoF2JIx2viNpHUe4ranmU5+NgDvBW20A0DaMMacXGWh7T6oG7OW7ZWNmdYiVYBg9y
         3dTudorxmH+Kzp3ZKrpsCXnhC90+GrNsnaGM745xBPjEITHEQotn8UJt7LeRg3AUmJ/A
         EWsBMQi/z3uZuDjRFvMFjeA2xRffMiI7agrIMnxXeOl73j5LjhN8KR+CeASOkJVbDzM1
         P0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697703452; x=1698308252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwG2LuDV5TxCH2siLTag2qyW7fA8AfNbKnYJ2f17ZIc=;
        b=PKxJSUs+RvV9gB7cKSm4gWH3mVkOZb+Aw3+23U2G7rul4R/fQfX/1DK9PQCxHFUNb0
         PUK6B/GTQp1HaJSxOt/jlRn+F6ZhSCzygkFiZo3MPyF54kCStGEBuuM6pw3teTkz+DlG
         rQ4iRAia5IfAX+Jg8h8/cQ9yZIYXHJoZIrtTs94eV6Xfu6HPkrlKhMFmWAkNhUHZlRO2
         lFBMAA9F86mPbWIwqfQlO7b4c4fMS7/gjfQ+/WZzwjH6srvNxRZvB11EBIwOAxq7nMLX
         H2QXW8R8LnAYfeju5Zbg0j84NYOvBB4cVPL+drnJB3apCJ0ssBy00HxH4OqlM1kvKDNv
         zT+g==
X-Gm-Message-State: AOJu0YyL3hNAUPYdeGJTXAGCwob3/9XJlKO+JyeMbSG4k/UzkucLoJHB
	s6EM+LjmM09SPmSHOdJMeUM=
X-Google-Smtp-Source: AGHT+IHJHH9M1vfJ2KS28b0YnDYbxTqKOBMQZBv7nbQHPGuP2gR6ZcKNXPf+A3dCUgmyXoJgkhADBg==
X-Received: by 2002:a05:6402:5247:b0:53e:468d:64a9 with SMTP id t7-20020a056402524700b0053e468d64a9mr948974edd.21.1697703451915;
        Thu, 19 Oct 2023 01:17:31 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id b28-20020a50ccdc000000b0053e31113ff7sm904580edj.94.2023.10.19.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:17:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Oct 2023 10:17:29 +0200
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicolas Schier <n.schier@avm.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Subject: Re: [bpf-next PATCH v2 3/4] kbuild: skip module BTF with one-time
 check for vmlinux
Message-ID: <ZTDmGbw/A8noivzX@krava>
References: <20231018151950.205265-1-masahiroy@kernel.org>
 <20231018151950.205265-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018151950.205265-3-masahiroy@kernel.org>

On Thu, Oct 19, 2023 at 12:19:49AM +0900, Masahiro Yamada wrote:
> When CONFIG_DEBUG_INFO_BTF_MODULES is enabled, vmlinux presence is
> checked in every module build, resulting in repetitive warning
> messages if vmlinux is missing.
> 
> Check vmlinux and print a warning just once.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> 
> (no changes since v1)
> 
>  scripts/Makefile.modfinal | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 8568d256d6fb..9fd7a26e4fe9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -14,6 +14,15 @@ include $(srctree)/scripts/Makefile.lib
>  
>  # find all modules listed in modules.order
>  modules := $(call read-file, $(MODORDER))
> +vmlinux :=
> +
> +ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +ifneq ($(wildcard vmlinux),)
> +vmlinux := vmlinux
> +else
> +$(warning Skipping BTF generation due to unavailability of vmlinux)
> +endif
> +endif
>  
>  __modfinal: $(modules:%.o=%.ko)
>  	@:
> @@ -36,12 +45,8 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>  
>  quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko = 							\
> -	if [ ! -f vmlinux ]; then					\
> -		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
> -	else								\
>  		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
> -		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
> -	fi;
> +		$(RESOLVE_BTFIDS) -b vmlinux $@
>  
>  # Same as newer-prereqs, but allows to exclude specified extra dependencies
>  newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
> @@ -52,9 +57,9 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
>  	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
>  
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
> -%.ko: %.o %.mod.o scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
> +%.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
>  	+$(call if_changed_except,ld_ko_o,vmlinux)
> -ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +ifdef vmlinux
>  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
>  endif
>  
> -- 
> 2.40.1
> 
> 

