Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA8193128
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgCYTaI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 15:30:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44756 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgCYTaH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 15:30:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so1184586plr.11
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6L4EoCXGl4SVLeZhCWnOV/ZKmujTYSYnek7Jb5npJGM=;
        b=YabBaUbMQjsfrDiMHMNiWG/FA2jbcQt0bT057IUzTqNiMDPKbRfB14T8vgqazbi1P2
         C9luJarJBIu3AkhwHUuYewfmHRFrp5p2Xqtck5S0GXUPowKq53pmk7vlQJxb4n+jAISF
         jsCyTCukefEdL8fXbDg2vVJgsV8IMWRHxhFL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6L4EoCXGl4SVLeZhCWnOV/ZKmujTYSYnek7Jb5npJGM=;
        b=jklZu4Xa8cg+r1LElL+lMiE352cWTA551TMl7t0S48vVKC6FUTJZg6TOYpfjPepObZ
         /zUuGU037ePC+J1nao1eNfJntCAFYpnMFsBNoB57HvflcMhhKjM6eE+ADxK8DX+prgrK
         7hCctz/EJSgI+fBU3yXJN2sy9qf7oPDZWWbkoqYihN6RMzCt+Nt677BMF5+B5V5NI+27
         fIlNYsa0fS/UfipGoqU/iudpNGMvqI6CgwzZz5KAp27aYa4M0QMHQaFfBNW6bzbS/Dhn
         a81+X41MzA1uGy1z65FuUXZmfxqNIa91HluaInPfO9S5mUp6/ASsiyXe9dN2nWY95J+R
         5P/g==
X-Gm-Message-State: ANhLgQ16HY0tF7ykw9yTUWie3cTowObzWskcS+iu/ObkybMiJv00JnGx
        ASC/9A5FSEHWj68w7uUe2VUdeQ==
X-Google-Smtp-Source: ADFU+vs5orbFYF3Rkglvd7lPCdetVTM8pa1syGgcz48eqAAE6vFJ+7X1kruyDJDakVLI9fX3oeD1Og==
X-Received: by 2002:a17:90a:c715:: with SMTP id o21mr5602539pjt.160.1585164606560;
        Wed, 25 Mar 2020 12:30:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm18746616pfn.2.2020.03.25.12.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:30:05 -0700 (PDT)
Date:   Wed, 25 Mar 2020 12:30:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v6 5/8] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <202003251229.C146482793@keescook>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-6-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325152629.6904-6-kpsingh@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 04:26:26PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> * The hooks are initialized using the definitions in
>   include/linux/lsm_hook_defs.h.
> * The LSM can be enabled / disabled with CONFIG_BPF_LSM.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  security/Kconfig      | 10 +++++-----
>  security/Makefile     |  2 ++
>  security/bpf/Makefile |  5 +++++
>  security/bpf/hooks.c  | 26 ++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 5 deletions(-)
>  create mode 100644 security/bpf/Makefile
>  create mode 100644 security/bpf/hooks.c
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 2a1a2d396228..cd3cc7da3a55 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -277,11 +277,11 @@ endchoice
>  
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
> -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
> -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
> -	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
> -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> +	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> +	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> +	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> +	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> +	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be ignored. This can be
> diff --git a/security/Makefile b/security/Makefile
> index 746438499029..22e73a3482bd 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+= yama
>  subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
>  subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
>  subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
> +subdir-$(CONFIG_BPF_LSM)		+= bpf
>  
>  # always enable default capabilities
>  obj-y					+= commoncap.o
> @@ -30,6 +31,7 @@ obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
>  obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
>  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
>  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
> +obj-$(CONFIG_BPF_LSM)			+= bpf/
>  
>  # Object integrity file lists
>  subdir-$(CONFIG_INTEGRITY)		+= integrity
> diff --git a/security/bpf/Makefile b/security/bpf/Makefile
> new file mode 100644
> index 000000000000..c7a89a962084
> --- /dev/null
> +++ b/security/bpf/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020 Google LLC.
> +
> +obj-$(CONFIG_BPF_LSM) := hooks.o
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> new file mode 100644
> index 000000000000..32d32d485451
> --- /dev/null
> +++ b/security/bpf/hooks.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +#include <linux/lsm_hooks.h>
> +#include <linux/bpf_lsm.h>
> +
> +static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
> +	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> +	#include <linux/lsm_hook_defs.h>
> +	#undef LSM_HOOK
> +};
> +
> +static int __init bpf_lsm_init(void)
> +{
> +	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
> +	pr_info("LSM support for eBPF active\n");
> +	return 0;
> +}
> +
> +DEFINE_LSM(bpf) = {
> +	.name = "bpf",
> +	.init = bpf_lsm_init,
> +};
> -- 
> 2.20.1
> 

-- 
Kees Cook
