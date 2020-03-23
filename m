Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E018FDF0
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgCWTom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 15:44:42 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55598 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCWTom (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 15:44:42 -0400
Received: by mail-pj1-f66.google.com with SMTP id mj6so326987pjb.5
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ls4G6lKYt71Y0XHFWkt5nDqXPlvj9q0Xq6iH0HNGuqM=;
        b=WG07lqEpeapNlf+q9UhkvXekq1R2/kM+rxpL4XAMpxJf2QVYMEOFaDgJ1BJTHpgRZC
         jDaKZB9+DGrG33wwzu19a0mx0kiWNijGGl1pUTqq0ljioxipjy03c4VFZPRELVCP0Dg0
         4/bW4JhFRbWml+M7I0FBl9RebdX2ykFPTxQi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ls4G6lKYt71Y0XHFWkt5nDqXPlvj9q0Xq6iH0HNGuqM=;
        b=fhz3ZfE1B5zVQjBgd+XNMGe9SbmT5maNaI67koViO8121qrVFkjCRSluENOVK8ohTN
         V9iqyEkiFAzFihiqq8QcisKDii9jMd+53mq4/9wfHyKzHpw2PdbRc+yq3IB0fvfHfXtj
         2c3FAeVrsrcF8hnhU6se1Iuedp4nrIY0IwxrrY6TGuU/DmOjWrCtEE5ZMWlR8K+HRcTf
         JQAefoXXMTMm78Qnx1LA3OVuDkVCpJiOMybA4P6tJ6hEdanHCygd8JVAOrMa8UWFNR5Z
         khpL+LCZduJzvdhvSM5yh5mReM19SM9ip1Tqqs7Ssb9jmhy2MGT4Xgx165YwnHFwDcU6
         ndQw==
X-Gm-Message-State: ANhLgQ0d+5MFJ9SRWZktwW2mDGE27BqRcMv6ls5NDfxzZNDk2f8gcaHq
        qU3NqJdGkignQi4i1TyzhXskTg==
X-Google-Smtp-Source: ADFU+vsjYREv0zb7uF0J3MSz4K/B3zotCbcEm7avZsPU6eUphxOcsAxXrRXR9QeoPK6hPks76WA6aw==
X-Received: by 2002:a17:902:8648:: with SMTP id y8mr22771881plt.153.1584992680710;
        Mon, 23 Mar 2020 12:44:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19sm13145800pgx.63.2020.03.23.12.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:44:39 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:44:38 -0700
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
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <202003231237.F654B379@keescook>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323164415.12943-6-kpsingh@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 05:44:13PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The bpf_lsm_ nops are initialized into the LSM framework like any other
> LSM.  Some LSM hooks do not have 0 as their default return value. The
> __weak symbol for these hooks is overridden by a corresponding
> definition in security/bpf/hooks.c
> 
> The LSM can be enabled / disabled with CONFIG_LSM.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Nice! This is super clean on the LSM side of things. :)

One note below...

> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  security/Kconfig      | 10 ++++----
>  security/Makefile     |  2 ++
>  security/bpf/Makefile |  5 ++++
>  security/bpf/hooks.c  | 55 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+), 5 deletions(-)
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
> index 000000000000..68e5824868f9
> --- /dev/null
> +++ b/security/bpf/hooks.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +#include <linux/lsm_hooks.h>
> +#include <linux/bpf_lsm.h>
> +
> +/* Some LSM hooks do not have 0 as their default return values. Override the
> + * __weak definitons generated by default for these hooks

If you wanted to avoid this, couldn't you make the default return value
part of lsm_hooks.h?

e.g.:

LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct inode *inode,
	 const char *name, void **buffer, bool alloc)

...

#define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
	LSM_HOOK_##RET(NAME, DEFAULT, __VA_ARGS__)
...
#define LSM_HOOK_int(NAME, DEFAULT, ...)	\
noinline int bpf_lsm_##NAME(__VA_ARGS__)	\
{						\
	return (DEFAULT);			\
}

Then all the __weak stuff is gone, and the following 4 functions don't
need to be written out, and the information is available to the macros
if anyone else might ever want it.

-Kees

> + */
> +noinline int bpf_lsm_inode_getsecurity(struct inode *inode, const char *name,
> +				       void **buffer, bool alloc)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +noinline int bpf_lsm_inode_setsecurity(struct inode *inode, const char *name,
> +				       const void *value, size_t size,
> +				       int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +noinline int bpf_lsm_task_prctl(int option, unsigned long arg2,
> +				unsigned long arg3, unsigned long arg4,
> +				unsigned long arg5)
> +{
> +	return -ENOSYS;
> +}
> +
> +noinline int bpf_lsm_xfrm_state_pol_flow_match(struct xfrm_state *x,
> +					       struct xfrm_policy *xp,
> +					       const struct flowi *fl)
> +{
> +	return 1;
> +}
> +
> +static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
> +	#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> +	#include <linux/lsm_hook_names.h>
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
