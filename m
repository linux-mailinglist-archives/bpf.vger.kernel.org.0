Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED5F13D7C8
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 11:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgAPKTp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 05:19:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41218 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgAPKTp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 05:19:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so18530652wrw.8
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 02:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LYW1HOJkWkm8CkG4oZz8YW0hjzojvqbDd54in9oxxos=;
        b=kitK2vhT79YAfMD37ZxfYkn6cuCv4N1172ZfT/Jc0lrw5MlyGD/+VpUVlv14X2eb/e
         DOQmREfmLXdXAQrmOQtZl62RLY4AobIxaYXgzAe3dIkYIvx8xEqtIZzDLBAwUodM5Wgn
         avhUJExN45TU+azYYtWtlS5WYkQKi+36usi3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYW1HOJkWkm8CkG4oZz8YW0hjzojvqbDd54in9oxxos=;
        b=gn8wx8Az0CCG/tkuplYUOkBpjSGbggnhqiveASsRd7+H59ehwSWwH7yxFFNidUS09K
         o/ibkplATT3sbgbtANjZ96tWLpE/Spj/WqBL4EOGkvjibt3IreLhrAPL3TClVyGOp8xN
         pDQSbZO4X3eC6GazIF3QFqYuK8z+n98N/u13zt4boJMSVjrGmYFhHjETL/+Bk/5VpwxD
         20Y6oj/+yZdFTXMBneRZnYsF3/ruXTrR3hEtadgMWpm6PDMrP9sA+fvDGOH6VzYXCmeO
         oPlJuk90uIO/dq18qKPVu7NVsurIGXrXJRRjL22QL9zx8EK38YSxSkdq+zgvV2WbmLAR
         GR4w==
X-Gm-Message-State: APjAAAXmF6x5+evhOjLkVZuZPMJqE7Q+dU8bfrZi3kIbOTNMzZs4zj1c
        ucUrRhhMXnwqPLj62VdLDgtWpw==
X-Google-Smtp-Source: APXvYqweqJDSX004q0/RK04ZxcjXOYN7ZJt8Ce3ugut7zFw0fG8PPYsN1hWUxd5ntRVClW7juCRbkw==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr2552880wrj.357.1579169981939;
        Thu, 16 Jan 2020 02:19:41 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id i8sm29584201wro.47.2020.01.16.02.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 02:19:41 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 16 Jan 2020 11:19:40 +0100
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
Message-ID: <20200116101940.GC240584@google.com>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-5-kpsingh@chromium.org>
 <5793e9a8-e9cf-dd2d-261d-61f533cca20c@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5793e9a8-e9cf-dd2d-261d-61f533cca20c@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15-Jan 22:33, Casey Schaufler wrote:
> On 1/15/2020 9:13 AM, KP Singh wrote:
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
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  MAINTAINERS             |  1 +
> >  include/linux/bpf_lsm.h | 71 +++++++++++++++++++++++++++++++++++++++++
> >  security/bpf/Kconfig    |  1 +
> >  security/bpf/Makefile   |  2 +-
> >  security/bpf/hooks.c    | 20 ++++++++++++
> >  security/bpf/lsm.c      |  9 +++++-
> >  security/security.c     | 24 +++++++-------
> >  7 files changed, 115 insertions(+), 13 deletions(-)
> >  create mode 100644 include/linux/bpf_lsm.h
> >  create mode 100644 security/bpf/hooks.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0941f478cfa5..02d7e05e9b75 100644
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
> > index 000000000000..9883cf25241c
> > --- /dev/null
> > +++ b/include/linux/bpf_lsm.h
> > @@ -0,0 +1,71 @@
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
> > + * define LSM hooks.
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
> > +#define CALL_BPF_LSM_INT_HOOKS(RC, FUNC, ...) ({		\
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
> > +			RC = P->hook.FUNC(__VA_ARGS__);		\
> > +			if (RC && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
> > +				break;				\
> > +		}						\
> > +		bpf_lsm_srcu_read_unlock(_idx);			\
> > +	} while (0);						\
> > +	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? RC : 0;	\
> > +})
> > +
> > +#else /* !CONFIG_SECURITY_BPF */
> > +
> > +#define CALL_BPF_LSM_INT_HOOKS(RC, FUNC, ...) (RC)
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
> > index 5c5c14f990ce..d4ea6aa9ddb8 100644
> > --- a/security/bpf/lsm.c
> > +++ b/security/bpf/lsm.c
> > @@ -4,14 +4,21 @@
> >   * Copyright 2019 Google LLC.
> >   */
> >  
> > +#include <linux/bpf_lsm.h>
> >  #include <linux/lsm_hooks.h>
> >  
> >  /* This is only for internal hooks, always statically shipped as part of the
> > - * BPF LSM. Statically defined hooks are appeneded to the security_hook_heads
> > + * BPF LSM. Statically defined hooks are appended to the security_hook_heads
> >   * which is common for LSMs and R/O after init.
> >   */
> >  static struct security_hook_list lsm_hooks[] __lsm_ro_after_init = {};
> >  
> > +/* Security hooks registered dynamically by the BPF LSM and must be accessed
> > + * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock. The mutable
> > + * hooks dynamically allocated by the BPF LSM are appeneded here.
> > + */
> > +struct security_hook_heads bpf_lsm_hook_heads;
> > +
> >  static int __init lsm_init(void)
> >  {
> >  	security_add_hooks(lsm_hooks, ARRAY_SIZE(lsm_hooks), "bpf");
> > diff --git a/security/security.c b/security/security.c
> > index cd2d18d2d279..4a2eb4c089b2 100644
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
> > @@ -652,20 +653,21 @@ static void __init lsm_early_task(struct task_struct *task)
> >  								\
> >  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> >  			P->hook.FUNC(__VA_ARGS__);		\
> > +		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
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
> > +		RC = CALL_BPF_LSM_INT_HOOKS(RC, FUNC, __VA_ARGS__);	\
> 
> Do not do this. Add LSM_ORDER_LAST for the lsm_order field of lsm_info
> and use that to identify your module as one to be put on the list last.
> Update the LSM registration code to do this. It will be much like the code
> that uses LSM_ORDER_FIRST to put the capabilities at the head of the lists.
> 
> What you have here to way to much like the way Yama was invoked before
> stacking.

Thanks for taking a look!

The BPF LSM has two kinds of hooks. The static hooks which are
appended to the security_hook_heads in security.c and mutable hooks
which are allocated at runtime and attached to a separate
security_hook_heads (bpf_lsm_hook_heads) defined in security/bpf/lsm.c
This macro runs these mutable hooks (dynamically allocated at runtime)
under SRCU protection.

Having a separate security_hook_heads allows:

- The security_hook_heads in security.c to be __lsm_ro_after_init
  and thus limits the attack surface does not change the existing
  behaviour
- The SRCU critical section be limited to the execution of dynamically
  allocated hooks

I agree that the static hooks should indeed be LSM_ORDER_LAST which
makes logical sense and represents correctly how the LSM will behave
in reality. (i.e. its hooks are executed last irrespective of the
position it is mentioned in the list of LSMs.)

I will update this for v3.

- KP

> 
> > +	} while (0);							\
> > +	RC;								\
> >  })
> >  
> >  /* Security operations */
> 
