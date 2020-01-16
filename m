Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB313DAA4
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 13:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgAPMxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 07:53:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53581 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPMxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 07:53:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so3646262wmc.3
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 04:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/H5SBeOA2qr3HQ5ZzzppEj9vMjbQsFlElKjOkvtzBfI=;
        b=F/3g7YjNoMDZLgepWCoyoLz6ghznx+zPPsT2GWzhJyZcg4z7dY5dBdhnr7miHMeZrb
         nwaBGnXUkIqItnHEAnPSvb1ucZV6Ce9wk5xuZA4a9xz5rKsUioZHeE4wp1a69hrVRAEa
         PhLnQjwKve3QXjjAf1ZBsBaV3IkzhCHeueQQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/H5SBeOA2qr3HQ5ZzzppEj9vMjbQsFlElKjOkvtzBfI=;
        b=JyocfV6jwgl8BUuuuO3tR0zTIBFNC+cIsoVLhLrEg+K1pbEeAs+MgQh+7rM8dv3l8D
         Nmxcro5rVf6Gxnhl8EhWvNyYZxMQ3WysmcyugnbplOqn1MF/7m8JqwlNltFOQXNguMWX
         RxF2Kf+gLxEr4IGh9ceIWWsJf6hkLKTCy9393G0L14hHu4+SkycO0Y/JhcfeVQSKd3NH
         sO014utoWYZ0p81W//vtgxRtQEDN9RSq6DhFDlj5IpjJVJMVY8EXgT+jmTmYCx4cEPro
         3+kNJqKTidi2n2X0uP4pIvx4QLbpN1kwbtNNdYHyrU355r9DBB3vvxttWgYjqEWeqVte
         ybEg==
X-Gm-Message-State: APjAAAW712GEzrHdob4yWH5nvCFWnHWWowknbRDZ+bEoRgufroWuiiaC
        bP5ET/exW5W6qs+0787tmGgj1A==
X-Google-Smtp-Source: APXvYqxv1iLYD4voaq/Xo7oWnkV8nxhX6RVYqz6A3PmEyTdSkSmfS8+WpyRWjLFCgWrOEamJ58+a5Q==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr5558117wml.156.1579179178700;
        Thu, 16 Jan 2020 04:52:58 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id x11sm181653wmg.46.2020.01.16.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:52:58 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 16 Jan 2020 13:52:56 +0100
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 02/10] bpf: lsm: Add a skeleton and config
 options
Message-ID: <20200116125256.GE240584@google.com>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-3-kpsingh@chromium.org>
 <7b11f92b-259f-f2e1-924c-5c0518f49b3f@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b11f92b-259f-f2e1-924c-5c0518f49b3f@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15-Jan 23:04, Casey Schaufler wrote:
> On 1/15/2020 9:13 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > The LSM can be enabled by CONFIG_SECURITY_BPF.
> > Without CONFIG_SECURITY_BPF_ENFORCE, the LSM will run the
> > attached eBPF programs but not enforce MAC policy based
> > on the return value of the attached programs.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  MAINTAINERS           |  7 +++++++
> >  security/Kconfig      | 11 ++++++-----
> >  security/Makefile     |  2 ++
> >  security/bpf/Kconfig  | 22 ++++++++++++++++++++++
> >  security/bpf/Makefile |  5 +++++
> >  security/bpf/lsm.c    | 25 +++++++++++++++++++++++++
> >  6 files changed, 67 insertions(+), 5 deletions(-)
> >  create mode 100644 security/bpf/Kconfig
> >  create mode 100644 security/bpf/Makefile
> >  create mode 100644 security/bpf/lsm.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 66a2e5e07117..0941f478cfa5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3203,6 +3203,13 @@ S:	Supported
> >  F:	arch/x86/net/
> >  X:	arch/x86/net/bpf_jit_comp32.c
> >  
> > +BPF SECURITY MODULE
> > +M:	KP Singh <kpsingh@chromium.org>
> > +L:	linux-security-module@vger.kernel.org
> > +L:	bpf@vger.kernel.org
> > +S:	Maintained
> > +F:	security/bpf/
> > +
> >  BROADCOM B44 10/100 ETHERNET DRIVER
> >  M:	Michael Chan <michael.chan@broadcom.com>
> >  L:	netdev@vger.kernel.org
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 2a1a2d396228..6f1aab195e7d 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -236,6 +236,7 @@ source "security/tomoyo/Kconfig"
> >  source "security/apparmor/Kconfig"
> >  source "security/loadpin/Kconfig"
> >  source "security/yama/Kconfig"
> > +source "security/bpf/Kconfig"
> >  source "security/safesetid/Kconfig"
> >  source "security/lockdown/Kconfig"
> >  
> > @@ -277,11 +278,11 @@ endchoice
> >  
> >  config LSM
> >  	string "Ordered list of enabled LSMs"
> > -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
> > -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
> > -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
> > -	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
> > -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> > +	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > +	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > +	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> > +	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> > +	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> >  	help
> >  	  A comma-separated list of LSMs, in initialization order.
> >  	  Any LSMs left off this list will be ignored. This can be
> > diff --git a/security/Makefile b/security/Makefile
> > index be1dd9d2cb2f..50e6821dd7b7 100644
> > --- a/security/Makefile
> > +++ b/security/Makefile
> > @@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+= yama
> >  subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
> >  subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
> >  subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
> > +subdir-$(CONFIG_SECURITY_BPF)		+= bpf
> >  
> >  # always enable default capabilities
> >  obj-y					+= commoncap.o
> > @@ -29,6 +30,7 @@ obj-$(CONFIG_SECURITY_YAMA)		+= yama/
> >  obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
> >  obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
> >  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
> > +obj-$(CONFIG_SECURITY_BPF)		+= bpf/
> >  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
> >  
> >  # Object integrity file lists
> > diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
> > new file mode 100644
> > index 000000000000..a5f6c67ae526
> > --- /dev/null
> > +++ b/security/bpf/Kconfig
> > @@ -0,0 +1,22 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright 2019 Google LLC.
> > +
> > +config SECURITY_BPF
> > +	bool "BPF-based MAC and audit policy"
> > +	depends on SECURITY
> > +	depends on BPF_SYSCALL
> > +	help
> > +	  This enables instrumentation of the security hooks with
> > +	  eBPF programs.
> > +
> > +	  If you are unsure how to answer this question, answer N.
> > +
> > +config SECURITY_BPF_ENFORCE
> > +	bool "Deny operations based on the evaluation of the attached programs"
> > +	depends on SECURITY_BPF
> > +	help
> > +	  eBPF programs attached to hooks can be used for both auditing and
> > +	  enforcement. Enabling enforcement implies that the evaluation result
> > +	  from the attached eBPF programs will allow or deny the operation
> > +	  guarded by the security hook.
> > diff --git a/security/bpf/Makefile b/security/bpf/Makefile
> > new file mode 100644
> > index 000000000000..26a0ab6f99b7
> > --- /dev/null
> > +++ b/security/bpf/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright 2019 Google LLC.
> > +
> > +obj-$(CONFIG_SECURITY_BPF) := lsm.o
> > diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
> > new file mode 100644
> > index 000000000000..5c5c14f990ce
> > --- /dev/null
> > +++ b/security/bpf/lsm.c
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2019 Google LLC.
> > + */
> > +
> > +#include <linux/lsm_hooks.h>
> > +
> > +/* This is only for internal hooks, always statically shipped as part of the
> > + * BPF LSM. Statically defined hooks are appeneded to the security_hook_heads
> > + * which is common for LSMs and R/O after init.
> > + */
> > +static struct security_hook_list lsm_hooks[] __lsm_ro_after_init = {};
> 
> s/lsm_hooks/bpf_hooks/
> 
> The lsm prefix is for the infrastructure. The way you have it is massively confusing.

Good point, I changed this to bpf_lsm_hooks as we prefix most types
with bpf_lsm_

> 
> > +
> > +static int __init lsm_init(void)
> 
> s/lsm_init/bpf_init/
> 
> Same reason. When I'm looking at several security modules at once I
> need to be able to tell them apart.

Changed to bpf_lsm_init.

> 
> > +{
> > +	security_add_hooks(lsm_hooks, ARRAY_SIZE(lsm_hooks), "bpf");
> > +	pr_info("eBPF and LSM are friends now.\n");
> 
> Cute message, but not very informative if you haven't read the code.
> "LSM support for eBPF active\n" is more likely to be comprehensible.

Agreed, Updated :)

- KP

> 
> > +	return 0;
> > +}
> > +
> > +DEFINE_LSM(bpf) = {
> > +	.name = "bpf",
> > +	.init = lsm_init,
> > +};
> 
