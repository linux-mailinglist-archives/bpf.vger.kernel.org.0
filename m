Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF985147034
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 18:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAWR7t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 12:59:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgAWR7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 12:59:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so4109152wrm.11
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 09:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iR3jr3L61KPYRB1VPXCrOLzc7KLrPfoT5IhUgDxXQ34=;
        b=lPJ+8BtHsdYnwKpSbc/mDntsZlU+WGUXk7nZZyQV3XxeGLntofMWOckXOUGSybSYFA
         MLnZ08HTwdnVPd1+0rdlQSOu0GwSL6GGfIe2QWHLh08YH58O7K8ccLzaj9YWjji/oKm+
         eiGhb+7BJGEP78a6SlpKW8Bq1YDBKgN2RCp7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iR3jr3L61KPYRB1VPXCrOLzc7KLrPfoT5IhUgDxXQ34=;
        b=MXohIV/K0AHb33x6+GwDyLQ2u7lFe06Aph1DlqDU7wkv2xLRNjYcP1qSSerzypaUq8
         mmtLODpkGSfbYP+RkDhnEu/tJZ77MxXP/9w+YsxDO8IpIJJKbhmBHIsez6WKosTqce27
         8coDTezn4DNgQp4IvOSKxdIqbbWFgz7xNVBnoD8uLk6Dt3f/NNkxe/Z0qYx00qxNj1pn
         aIKx0e1vhRrNcug68fmwq2SV/PQMkC3ZYsFwgraqZ+nxIXH12Gs5loXNMIRcjZLm52dM
         3SlfYSg2Mgt11TRG8VGmxr+mqUyXwuAKp9/1XNx1ay3x2WOjfoy8X3oPK4OosfIVVoDw
         tTDg==
X-Gm-Message-State: APjAAAXyY9bhQdm315Xaly9vAy83+Si22qBFYY1kOE18GI2u/ltwn2+L
        LISQObU75WLiT3qOvSJ5Djmnzg==
X-Google-Smtp-Source: APXvYqyC3aaTCy/sFh2lsm+1ppLBehSwgqiWTfMK4nw3Kxn1CKcUTZqGmjeqy4tLyDhHYPnaSRFCrg==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr19078835wro.352.1579802384594;
        Thu, 23 Jan 2020 09:59:44 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id m7sm3950205wrr.40.2020.01.23.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 09:59:44 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 23 Jan 2020 18:59:42 +0100
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
Message-ID: <20200123175942.GA131348@google.com>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <29157a88-7049-906e-fe92-b7a1e2183c6b@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29157a88-7049-906e-fe92-b7a1e2183c6b@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23-Jan 09:03, Casey Schaufler wrote:
> On 1/23/2020 7:24 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > - The list of hooks registered by an LSM is currently immutable as they
> >   are declared with __lsm_ro_after_init and they are attached to a
> >   security_hook_heads struct.
> > - For the BPF LSM we need to de/register the hooks at runtime. Making
> >   the existing security_hook_heads mutable broadens an
> >   attack vector, so a separate security_hook_heads is added for only
> >   those that ~must~ be mutable.
> > - These mutable hooks are run only after all the static hooks have
> >   successfully executed.
> >
> > This is based on the ideas discussed in:
> >
> >   https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal
> >
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  MAINTAINERS             |  1 +
> >  include/linux/bpf_lsm.h | 72 +++++++++++++++++++++++++++++++++++++++++
> >  security/bpf/Kconfig    |  1 +
> >  security/bpf/Makefile   |  2 +-
> >  security/bpf/hooks.c    | 20 ++++++++++++
> >  security/bpf/lsm.c      |  7 ++++
> >  security/security.c     | 25 +++++++-------
> >  7 files changed, 116 insertions(+), 12 deletions(-)
> >  create mode 100644 include/linux/bpf_lsm.h
> >  create mode 100644 security/bpf/hooks.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e2b7f76a1a70..c606b3d89992 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3209,6 +3209,7 @@ L:	linux-security-module@vger.kernel.org
> >  L:	bpf@vger.kernel.org
> >  S:	Maintained
> >  F:	security/bpf/
> > +F:	include/linux/bpf_lsm.h
> >  
> >  BROADCOM B44 10/100 ETHERNET DRIVER
> >  M:	Michael Chan <michael.chan@broadcom.com>
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > new file mode 100644
> > index 000000000000..57c20b2cd2f4
> > --- /dev/null
> > +++ b/include/linux/bpf_lsm.h
> > @@ -0,0 +1,72 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright 2019 Google LLC.
> > + */
> > +
> > +#ifndef _LINUX_BPF_LSM_H
> > +#define _LINUX_BPF_LSM_H
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/lsm_hooks.h>
> > +
> > +#ifdef CONFIG_SECURITY_BPF
> > +
> > +/* Mutable hooks defined at runtime and executed after all the statically
> > + * defined LSM hooks.
> > + */
> > +extern struct security_hook_heads bpf_lsm_hook_heads;
> > +
> > +int bpf_lsm_srcu_read_lock(void);
> > +void bpf_lsm_srcu_read_unlock(int idx);
> > +
> > +#define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
> > +	do {							\
> > +		struct security_hook_list *P;			\
> > +		int _idx;					\
> > +								\
> > +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
> > +			break;					\
> > +								\
> > +		_idx = bpf_lsm_srcu_read_lock();		\
> > +		hlist_for_each_entry(P, &bpf_lsm_hook_heads.FUNC, list) \
> > +			P->hook.FUNC(__VA_ARGS__);		\
> > +		bpf_lsm_srcu_read_unlock(_idx);			\
> > +	} while (0)
> > +
> > +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) ({			\
> > +	int _ret = 0;						\
> > +	do {							\
> > +		struct security_hook_list *P;			\
> > +		int _idx;					\
> > +								\
> > +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
> > +			break;					\
> > +								\
> > +		_idx = bpf_lsm_srcu_read_lock();		\
> > +								\
> > +		hlist_for_each_entry(P,				\
> > +			&bpf_lsm_hook_heads.FUNC, list) {	\
> > +			_ret = P->hook.FUNC(__VA_ARGS__);		\
> > +			if (_ret && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
> > +				break;				\
> > +		}						\
> > +		bpf_lsm_srcu_read_unlock(_idx);			\
> > +	} while (0);						\
> > +	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? _ret : 0;	\
> > +})
> > +
> > +#else /* !CONFIG_SECURITY_BPF */
> > +
> > +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) (0)
> > +#define CALL_BPF_LSM_VOID_HOOKS(...)
> > +
> > +static inline int bpf_lsm_srcu_read_lock(void)
> > +{
> > +	return 0;
> > +}
> > +static inline void bpf_lsm_srcu_read_unlock(int idx) {}
> > +
> > +#endif /* CONFIG_SECURITY_BPF */
> > +
> > +#endif /* _LINUX_BPF_LSM_H */
> > diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
> > index a5f6c67ae526..595e4ad597ae 100644
> > --- a/security/bpf/Kconfig
> > +++ b/security/bpf/Kconfig
> > @@ -6,6 +6,7 @@ config SECURITY_BPF
> >  	bool "BPF-based MAC and audit policy"
> >  	depends on SECURITY
> >  	depends on BPF_SYSCALL
> > +	depends on SRCU
> >  	help
> >  	  This enables instrumentation of the security hooks with
> >  	  eBPF programs.
> > diff --git a/security/bpf/Makefile b/security/bpf/Makefile
> > index c78a8a056e7e..c526927c337d 100644
> > --- a/security/bpf/Makefile
> > +++ b/security/bpf/Makefile
> > @@ -2,4 +2,4 @@
> >  #
> >  # Copyright 2019 Google LLC.
> >  
> > -obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o
> > +obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o hooks.o
> > diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> > new file mode 100644
> > index 000000000000..b123d9cb4cd4
> > --- /dev/null
> > +++ b/security/bpf/hooks.c
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2019 Google LLC.
> > + */
> > +
> > +#include <linux/bpf_lsm.h>
> > +#include <linux/srcu.h>
> > +
> > +DEFINE_STATIC_SRCU(security_hook_srcu);
> > +
> > +int bpf_lsm_srcu_read_lock(void)
> > +{
> > +	return srcu_read_lock(&security_hook_srcu);
> > +}
> > +
> > +void bpf_lsm_srcu_read_unlock(int idx)
> > +{
> > +	return srcu_read_unlock(&security_hook_srcu, idx);
> > +}
> > diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
> > index dc9ac03c7aa0..a25a068e1781 100644
> > --- a/security/bpf/lsm.c
> > +++ b/security/bpf/lsm.c
> > @@ -4,6 +4,7 @@
> >   * Copyright 2019 Google LLC.
> >   */
> >  
> > +#include <linux/bpf_lsm.h>
> >  #include <linux/lsm_hooks.h>
> >  
> >  /* This is only for internal hooks, always statically shipped as part of the
> > @@ -12,6 +13,12 @@
> >   */
> >  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {};
> >  
> > +/* Security hooks registered dynamically by the BPF LSM and must be accessed
> > + * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock. The mutable
> > + * hooks dynamically allocated by the BPF LSM are appeneded here.
> > + */
> > +struct security_hook_heads bpf_lsm_hook_heads;
> > +
> >  static int __init bpf_lsm_init(void)
> >  {
> >  	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
> > diff --git a/security/security.c b/security/security.c
> > index 30a8aa700557..95a46ca25dcd 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/backing-dev.h>
> >  #include <linux/string.h>
> >  #include <linux/msg.h>
> > +#include <linux/bpf_lsm.h>
> >  #include <net/flow.h>
> >  
> >  #define MAX_LSM_EVM_XATTR	2
> > @@ -657,20 +658,22 @@ static void __init lsm_early_task(struct task_struct *task)
> >  								\
> >  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> >  			P->hook.FUNC(__VA_ARGS__);		\
> > +		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
> 
> I'm sorry if I wasn't clear on the v2 review.
> This does not belong in the infrastructure. You should be
> doing all the bpf_lsm hook processing in you module.
> bpf_lsm_task_alloc() should loop though all the bpf
> task_alloc hooks if they have to be handled differently
> from "normal" LSM hooks.

The BPF LSM does not define static hooks (the ones registered to
security_hook_heads in security.c with __lsm_ro_after_init) for each
LSM hook. If it tries to do that one ends with what was in v1:

  https://lore.kernel.org/bpf/20191220154208.15895-7-kpsingh@chromium.org

This gets quite ugly (security/bpf/hooks.h from v1) and was noted by
the BPF maintainers:

  https://lore.kernel.org/bpf/20191222012722.gdqhppxpfmqfqbld@ast-mbp.dhcp.thefacebook.com/

As I mentioned, some of the ideas we used here are based on:

  https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal

Which gave each LSM the ability to add mutable hooks at runtime. If
you prefer we can make this generic and allow the LSMs to register
mutable hooks with the BPF LSM be the only LSM that uses it (and
enforce it with a whitelist).

Would this generic approach be something you would consider better
than just calling the BPF mutable hooks directly?

- KP

> 
> >  	} while (0)
> >  
> > -#define call_int_hook(FUNC, IRC, ...) ({			\
> > -	int RC = IRC;						\
> > -	do {							\
> > -		struct security_hook_list *P;			\
> > -								\
> > +#define call_int_hook(FUNC, IRC, ...) ({				\
> > +	int RC = IRC;							\
> > +	do {								\
> > +		struct security_hook_list *P;				\
> >  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> > -			RC = P->hook.FUNC(__VA_ARGS__);		\
> > -			if (RC != 0)				\
> > -				break;				\
> > -		}						\
> > -	} while (0);						\
> > -	RC;							\
> > +			RC = P->hook.FUNC(__VA_ARGS__);			\
> > +			if (RC != 0)					\
> > +				break;					\
> > +		}							\
> > +		if (RC == 0)						\
> > +			RC = CALL_BPF_LSM_INT_HOOKS(FUNC, __VA_ARGS__);	\
> > +	} while (0);							\
> > +	RC;								\
> >  })
> >  
> >  /* Security operations */
