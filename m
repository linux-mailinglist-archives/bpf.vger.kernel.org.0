Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF8F674A79
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 05:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjATEEh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 23:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjATEEg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 23:04:36 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445DF95186
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 20:04:35 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so7917439pjm.1
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 20:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBj1hTB88buCIb9g5Ec7nk6XG77UOnZJW2fpQRKVYn8=;
        b=mLeAK+zhv86Mqcsf+sv/+6Ga3S1MHdVSrxI6wTDV4ToLSXw5slkW55flQ4rNHC7qT0
         NZ8FqCgBqG5OImBmxgpv5eAQK3MNbjmcyUU+9svGtRi0a2wsJhJ3H66AjvDaEr7gBOCL
         NntqoA/Ywm3T7AGpMLpfaujAq8Cbz/s8znjKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBj1hTB88buCIb9g5Ec7nk6XG77UOnZJW2fpQRKVYn8=;
        b=oz6Vpw3nLh+BraSwZgL/DprDeKeY33w+xFnnbOSnGunSITrmtDcSKUKr2h6hQ/V24E
         ns3uO2ikQd3V6nim7aPuUoY+BE9pUgfyiiNZ+nZX4UJV86ne0LKX/TlBWhrWM4kaDcr+
         RXU+DzPqQoaWHo+He71Q5BhPLReKCYHbbjwl6iY5+KJRlbr/F9bH88F2jC9GEJBsGhVr
         FF8paJx+Wf33o8db7YBnJdjcd7LGzOP+Lqr9so9W5HCVKVxIMp2Z5yiZYE7r0q+VRs7c
         c3zithyUKwfi+ds9ApfmzI4iLSNEOZFUedIDZMa4yhTVaW7IKE9NxKYXbtYDC7hTAWKk
         GY/w==
X-Gm-Message-State: AFqh2krmu9L0QGaMlekVqTn09+LyCQn2XhtseW0mVq6RcJVodRRSdcnj
        n2OP1/hgSxKCqofmEEuJ40ocjw==
X-Google-Smtp-Source: AMrXdXvB4TDeS7vazfYH6l7pQg6xOJYb5ED82aw1Lj0RpiNfwrJmHPEdCsBDCsCGjiFW1zTCH30vfg==
X-Received: by 2002:a17:90a:51e4:b0:219:818f:9da3 with SMTP id u91-20020a17090a51e400b00219818f9da3mr14669259pjh.17.1674187474730;
        Thu, 19 Jan 2023 20:04:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id az23-20020a17090b029700b00228e0a8478csm421462pjb.41.2023.01.19.20.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 20:04:34 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:04:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org
Subject: Re: [PATCH RESEND bpf-next 2/4] security: Generate a header with the
 count of enabled LSMs
Message-ID: <202301191949.A4E2DCDA97@keescook>
References: <20230120000818.1324170-1-kpsingh@kernel.org>
 <20230120000818.1324170-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120000818.1324170-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 01:08:16AM +0100, KP Singh wrote:
> The header defines a MAX_LSM_COUNT constant which is used in a
> subsequent patch to generate the static calls for each LSM hook which
> are named using preprocessor token pasting. Since token pasting does not
> work with arithmetic expressions, generate a simple lsm_count.h header
> which represents the subset of LSMs that can be enabled on a given
> kernel based on the config.
> 
> While one can generate static calls for all the possible LSMs that the
> kernel has, this is actually wasteful as most kernels only enable a
> handful of LSMs.

This is a frustrating bit of complexity to deal with it, but it seems
worse to leave each security_... callsite with a huge swath of NOPs.

> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  scripts/Makefile                 |  1 +
>  scripts/security/.gitignore      |  1 +
>  scripts/security/Makefile        |  4 +++
>  scripts/security/gen_lsm_count.c | 57 ++++++++++++++++++++++++++++++++
>  security/Makefile                | 11 ++++++
>  5 files changed, 74 insertions(+)
>  create mode 100644 scripts/security/.gitignore
>  create mode 100644 scripts/security/Makefile
>  create mode 100644 scripts/security/gen_lsm_count.c
> 
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 1575af84d557..9712249c0fb3 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -41,6 +41,7 @@ targets += module.lds
>  subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
>  subdir-$(CONFIG_MODVERSIONS) += genksyms
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
> +subdir-$(CONFIG_SECURITY) += security
>  
>  # Let clean descend into subdirs
>  subdir-	+= basic dtc gdb kconfig mod
> diff --git a/scripts/security/.gitignore b/scripts/security/.gitignore
> new file mode 100644
> index 000000000000..684af16735f1
> --- /dev/null
> +++ b/scripts/security/.gitignore
> @@ -0,0 +1 @@
> +gen_lsm_count
> diff --git a/scripts/security/Makefile b/scripts/security/Makefile
> new file mode 100644
> index 000000000000..05f7e4109052
> --- /dev/null
> +++ b/scripts/security/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +hostprogs-always-y += gen_lsm_count
> +HOST_EXTRACFLAGS += \
> +	-I$(srctree)/include/uapi -I$(srctree)/include
> diff --git a/scripts/security/gen_lsm_count.c b/scripts/security/gen_lsm_count.c
> new file mode 100644
> index 000000000000..a9a227724d84
> --- /dev/null
> +++ b/scripts/security/gen_lsm_count.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* NOTE: we really do want to use the kernel headers here */
> +#define __EXPORTED_HEADERS__
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <ctype.h>
> +
> +#include <linux/kconfig.h>
> +
> +#define GEN_MAX_LSM_COUNT (				\
> +	/* Capabilities */				\
> +	IS_ENABLED(CONFIG_SECURITY) +			\
> +	IS_ENABLED(CONFIG_SECURITY_SELINUX) +		\
> +	IS_ENABLED(CONFIG_SECURITY_SMACK) +		\
> +	IS_ENABLED(CONFIG_SECURITY_TOMOYO) +		\
> +	IS_ENABLED(CONFIG_SECURITY_APPARMOR) +		\
> +	IS_ENABLED(CONFIG_SECURITY_YAMA) +		\
> +	IS_ENABLED(CONFIG_SECURITY_LOADPIN) +		\
> +	IS_ENABLED(CONFIG_SECURITY_SAFESETID) +		\
> +	IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) + 	\
> +	IS_ENABLED(CONFIG_BPF_LSM) + \
> +	IS_ENABLED(CONFIG_SECURITY_LANDLOCK))

I'm bothered that we have another place to collect a list of "all" the
LSMs. The stacking design went out of its way to create DEFINE_LSM() so
there didn't need to be this kind of centralized list.

I don't have a better suggestion, though. Casey has a centralized list
too, so it might make sense (as he mentioned) to use something like
that. It can be arranged to provide a MAX_... macro (that could be
BUILD_BUG_ON checked against a similarly named enum). I'm thinking:

enum lsm_list {
	LSM_SELINUX,
	LSM_SMACK,
	...
	__LSM_MAX,
};

/*
 * We can't use __LSM_MAX directly because we need it for macro
 * concatenation, so just check it against __LSM_MAX at build time.
 */
#define LSM_MAX 15

...
	BUILD_BUG_ON(LSM_MAX != __LSM_MAX);

> +
> +const char *progname;
> +
> +static void usage(void)
> +{
> +	printf("usage: %s lsm_count.h\n", progname);
> +	exit(1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	FILE *fout;
> +
> +	progname = argv[0];
> +
> +	if (argc < 2)
> +		usage();
> +
> +	fout = fopen(argv[1], "w");
> +	if (!fout) {
> +		fprintf(stderr, "Could not open %s for writing:  %s\n",
> +			argv[1], strerror(errno));
> +		exit(2);
> +	}
> +
> +	fprintf(fout, "#ifndef _LSM_COUNT_H_\n#define _LSM_COUNT_H_\n\n");
> +	fprintf(fout, "\n#define MAX_LSM_COUNT %d\n", GEN_MAX_LSM_COUNT);
> +	fprintf(fout, "#endif /* _LSM_COUNT_H_ */\n");
> +	exit(0);
> +}
> diff --git a/security/Makefile b/security/Makefile
> index 18121f8f85cd..7a47174831f4 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the kernel security code
>  #
>  
> +gen := include/generated
>  obj-$(CONFIG_KEYS)			+= keys/
>  
>  # always enable default capabilities
> @@ -27,3 +28,13 @@ obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
>  
>  # Object integrity file lists
>  obj-$(CONFIG_INTEGRITY)			+= integrity/

Or, if the enum/#define doesn't work, it might be possible to just do
this in the Makefile more directly?

${gen}/lsm_count.h: FORCE
	(echo "#ifndef _LSM_COUNT_H_"; \
	 echo "#define _LSM_COUNT_H_"; \
	 echo -n "#define MAX_LSM_COUNT "; \
	 echo	$(CONFIG_SECURITY_SELINUX) \
		$(CONFIG_SECURITY_SMACK) \
		...
		| wc -w; \
	 echo "#endif /* _LSM_COUNT_H_") >$@

> +
> +$(addprefix $(obj)/,$(obj-y)): $(gen)/lsm_count.h
> +
> +quiet_cmd_lsm_count = GEN     ${gen}/lsm_count.h
> +      cmd_lsm_count = scripts/security/gen_lsm_count ${gen}/lsm_count.h
> +
> +targets += lsm_count.h
> +
> +${gen}/lsm_count.h: FORCE
> +	$(call if_changed,lsm_count)
> -- 
> 2.39.0.246.g2a6d74b583-goog
> 

-- 
Kees Cook
