Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969591473C9
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 23:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgAWWYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 17:24:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41364 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgAWWYo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 17:24:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id x8so2090870pgk.8
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 14:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lBn5phI/wvY2dGyGq5+GP6PZXQDJo0dQ0g226tozhLw=;
        b=JFJqrpBTRixhHPkhc3o74fo9jnsE+ii0G7INopIoeIw3xNFfzok9E6d8HdvYfWw5Bj
         jA/78vAs4tXzwjeZjCHn2FXcGNfTUZlUiTtBqwNRudlIBcGpW+TP69BakRuRFHQuBY8v
         k4wkVtVqm8kiCa5vhxJxY26tm+J9pjQtL5oEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lBn5phI/wvY2dGyGq5+GP6PZXQDJo0dQ0g226tozhLw=;
        b=ckposddt2VdkxSFaIZ7AI8sr8/OYsKz79cIOVBQ2jgIOGGv0oGxxXfJH2ZRReVhPYI
         WRXmaY3NQbHO7CjHYpX6sE/T2zHaP7SSO3JNdDAD+tFY0G4SQeXsR9GBoIr9fM1Nb6+e
         TK26m6d22MwKCIf11jghA4/aGJaPL91Ij2MbL6qOfzuqw8b2s7WvIk2CbcowxPzwsBxC
         kAQliVK7y0UhUksd2sU4u1kEoe78mJw+SPJb1JubVEKkN3gJux3ZlTeRt3JIA9/0PNm0
         H6il0XzWpWiKIPS4PR2X1JQsizsWSUwt1mNiM/hJ60hulnB8iJp4L0xCEqIEXlK1ewec
         X8og==
X-Gm-Message-State: APjAAAUZyBy1yNcOeeE/aM/m2FtucRWap/gDQ9XNbLbdJEhGLoEU2jZ5
        Fxj94/wubIxiXInAEQM66n8aZg==
X-Google-Smtp-Source: APXvYqz0ypJ4B3MMtsyYkJBD/mIB2rhy6JHC4GhM3IlaKoQDYRZCROcJ1IuiGwybSNmz3smRAWsR1w==
X-Received: by 2002:a63:fa50:: with SMTP id g16mr619334pgk.202.1579818282803;
        Thu, 23 Jan 2020 14:24:42 -0800 (PST)
Received: from chromium.org ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id f9sm3768994pfd.141.2020.01.23.14.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 14:24:41 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 23 Jan 2020 14:24:36 -0800
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
Message-ID: <20200123222436.GA1598@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <29157a88-7049-906e-fe92-b7a1e2183c6b@schaufler-ca.com>
 <20200123175942.GA131348@google.com>
 <5004b3f4-ca5b-a546-4e87-b852cc248079@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5004b3f4-ca5b-a546-4e87-b852cc248079@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23-Jan 11:09, Casey Schaufler wrote:
> On 1/23/2020 9:59 AM, KP Singh wrote:
> > On 23-Jan 09:03, Casey Schaufler wrote:
> >> On 1/23/2020 7:24 AM, KP Singh wrote:
> >>> From: KP Singh <kpsingh@google.com>
> >>>
> >>> - The list of hooks registered by an LSM is currently immutable as they
> >>>   are declared with __lsm_ro_after_init and they are attached to a
> >>>   security_hook_heads struct.
> >>> - For the BPF LSM we need to de/register the hooks at runtime. Making
> >>>   the existing security_hook_heads mutable broadens an
> >>>   attack vector, so a separate security_hook_heads is added for only
> >>>   those that ~must~ be mutable.
> >>> - These mutable hooks are run only after all the static hooks have
> >>>   successfully executed.
> >>>
> >>> This is based on the ideas discussed in:
> >>>
> >>>   https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal
> >>>
> >>> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> >>> Reviewed-by: Florent Revest <revest@google.com>
> >>> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> >>> Signed-off-by: KP Singh <kpsingh@google.com>
> >>> ---
> >>>  MAINTAINERS             |  1 +
> >>>  include/linux/bpf_lsm.h | 72 +++++++++++++++++++++++++++++++++++++++++
> >>>  security/bpf/Kconfig    |  1 +
> >>>  security/bpf/Makefile   |  2 +-
> >>>  security/bpf/hooks.c    | 20 ++++++++++++
> >>>  security/bpf/lsm.c      |  7 ++++
> >>>  security/security.c     | 25 +++++++-------
> >>>  7 files changed, 116 insertions(+), 12 deletions(-)
> >>>  create mode 100644 include/linux/bpf_lsm.h
> >>>  create mode 100644 security/bpf/hooks.c
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index e2b7f76a1a70..c606b3d89992 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -3209,6 +3209,7 @@ L:	linux-security-module@vger.kernel.org
> >>>  L:	bpf@vger.kernel.org
> >>>  S:	Maintained
> >>>  F:	security/bpf/
> >>> +F:	include/linux/bpf_lsm.h
> >>>  
> >>>  BROADCOM B44 10/100 ETHERNET DRIVER
> >>>  M:	Michael Chan <michael.chan@broadcom.com>
> >>> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> >>> new file mode 100644
> >>> index 000000000000..57c20b2cd2f4
> >>> --- /dev/null
> >>> +++ b/include/linux/bpf_lsm.h
> >>> @@ -0,0 +1,72 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +
> >>> +/*
> >>> + * Copyright 2019 Google LLC.
> >>> + */
> >>> +
> >>> +#ifndef _LINUX_BPF_LSM_H
> >>> +#define _LINUX_BPF_LSM_H
> >>> +
> >>> +#include <linux/bpf.h>
> >>> +#include <linux/lsm_hooks.h>
> >>> +
> >>> +#ifdef CONFIG_SECURITY_BPF
> >>> +
> >>> +/* Mutable hooks defined at runtime and executed after all the statically
> >>> + * defined LSM hooks.
> >>> + */
> >>> +extern struct security_hook_heads bpf_lsm_hook_heads;
> >>> +
> >>> +int bpf_lsm_srcu_read_lock(void);
> >>> +void bpf_lsm_srcu_read_unlock(int idx);
> >>> +
> >>> +#define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
> >>> +	do {							\
> >>> +		struct security_hook_list *P;			\
> >>> +		int _idx;					\
> >>> +								\
> >>> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
> >>> +			break;					\
> >>> +								\
> >>> +		_idx = bpf_lsm_srcu_read_lock();		\
> >>> +		hlist_for_each_entry(P, &bpf_lsm_hook_heads.FUNC, list) \
> >>> +			P->hook.FUNC(__VA_ARGS__);		\
> >>> +		bpf_lsm_srcu_read_unlock(_idx);			\
> >>> +	} while (0)
> >>> +
> >>> +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) ({			\
> >>> +	int _ret = 0;						\
> >>> +	do {							\
> >>> +		struct security_hook_list *P;			\
> >>> +		int _idx;					\
> >>> +								\
> >>> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
> >>> +			break;					\
> >>> +								\
> >>> +		_idx = bpf_lsm_srcu_read_lock();		\
> >>> +								\
> >>> +		hlist_for_each_entry(P,				\
> >>> +			&bpf_lsm_hook_heads.FUNC, list) {	\
> >>> +			_ret = P->hook.FUNC(__VA_ARGS__);		\
> >>> +			if (_ret && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
> >>> +				break;				\
> >>> +		}						\
> >>> +		bpf_lsm_srcu_read_unlock(_idx);			\
> >>> +	} while (0);						\
> >>> +	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? _ret : 0;	\
> >>> +})
> >>> +
> >>> +#else /* !CONFIG_SECURITY_BPF */
> >>> +
> >>> +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) (0)
> >>> +#define CALL_BPF_LSM_VOID_HOOKS(...)
> >>> +
> >>> +static inline int bpf_lsm_srcu_read_lock(void)
> >>> +{
> >>> +	return 0;
> >>> +}
> >>> +static inline void bpf_lsm_srcu_read_unlock(int idx) {}
> >>> +
> >>> +#endif /* CONFIG_SECURITY_BPF */
> >>> +
> >>> +#endif /* _LINUX_BPF_LSM_H */
> >>> diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
> >>> index a5f6c67ae526..595e4ad597ae 100644
> >>> --- a/security/bpf/Kconfig
> >>> +++ b/security/bpf/Kconfig
> >>> @@ -6,6 +6,7 @@ config SECURITY_BPF
> >>>  	bool "BPF-based MAC and audit policy"
> >>>  	depends on SECURITY
> >>>  	depends on BPF_SYSCALL
> >>> +	depends on SRCU
> >>>  	help
> >>>  	  This enables instrumentation of the security hooks with
> >>>  	  eBPF programs.
> >>> diff --git a/security/bpf/Makefile b/security/bpf/Makefile
> >>> index c78a8a056e7e..c526927c337d 100644
> >>> --- a/security/bpf/Makefile
> >>> +++ b/security/bpf/Makefile
> >>> @@ -2,4 +2,4 @@
> >>>  #
> >>>  # Copyright 2019 Google LLC.
> >>>  
> >>> -obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o
> >>> +obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o hooks.o
> >>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> >>> new file mode 100644
> >>> index 000000000000..b123d9cb4cd4
> >>> --- /dev/null
> >>> +++ b/security/bpf/hooks.c
> >>> @@ -0,0 +1,20 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +
> >>> +/*
> >>> + * Copyright 2019 Google LLC.
> >>> + */
> >>> +
> >>> +#include <linux/bpf_lsm.h>
> >>> +#include <linux/srcu.h>
> >>> +
> >>> +DEFINE_STATIC_SRCU(security_hook_srcu);
> >>> +
> >>> +int bpf_lsm_srcu_read_lock(void)
> >>> +{
> >>> +	return srcu_read_lock(&security_hook_srcu);
> >>> +}
> >>> +
> >>> +void bpf_lsm_srcu_read_unlock(int idx)
> >>> +{
> >>> +	return srcu_read_unlock(&security_hook_srcu, idx);
> >>> +}
> >>> diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
> >>> index dc9ac03c7aa0..a25a068e1781 100644
> >>> --- a/security/bpf/lsm.c
> >>> +++ b/security/bpf/lsm.c
> >>> @@ -4,6 +4,7 @@
> >>>   * Copyright 2019 Google LLC.
> >>>   */
> >>>  
> >>> +#include <linux/bpf_lsm.h>
> >>>  #include <linux/lsm_hooks.h>
> >>>  
> >>>  /* This is only for internal hooks, always statically shipped as part of the
> >>> @@ -12,6 +13,12 @@
> >>>   */
> >>>  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {};
> >>>  
> >>> +/* Security hooks registered dynamically by the BPF LSM and must be accessed
> >>> + * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock. The mutable
> >>> + * hooks dynamically allocated by the BPF LSM are appeneded here.
> >>> + */
> >>> +struct security_hook_heads bpf_lsm_hook_heads;
> >>> +
> >>>  static int __init bpf_lsm_init(void)
> >>>  {
> >>>  	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
> >>> diff --git a/security/security.c b/security/security.c
> >>> index 30a8aa700557..95a46ca25dcd 100644
> >>> --- a/security/security.c
> >>> +++ b/security/security.c
> >>> @@ -27,6 +27,7 @@
> >>>  #include <linux/backing-dev.h>
> >>>  #include <linux/string.h>
> >>>  #include <linux/msg.h>
> >>> +#include <linux/bpf_lsm.h>
> >>>  #include <net/flow.h>
> >>>  
> >>>  #define MAX_LSM_EVM_XATTR	2
> >>> @@ -657,20 +658,22 @@ static void __init lsm_early_task(struct task_struct *task)
> >>>  								\
> >>>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> >>>  			P->hook.FUNC(__VA_ARGS__);		\
> >>> +		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
> >> I'm sorry if I wasn't clear on the v2 review.
> >> This does not belong in the infrastructure. You should be
> >> doing all the bpf_lsm hook processing in you module.
> >> bpf_lsm_task_alloc() should loop though all the bpf
> >> task_alloc hooks if they have to be handled differently
> >> from "normal" LSM hooks.
> > The BPF LSM does not define static hooks (the ones registered to
> > security_hook_heads in security.c with __lsm_ro_after_init) for each
> > LSM hook. If it tries to do that one ends with what was in v1:
> >
> >   https://lore.kernel.org/bpf/20191220154208.15895-7-kpsingh@chromium.org
> >
> > This gets quite ugly (security/bpf/hooks.h from v1) and was noted by
> > the BPF maintainers:
> >
> >   https://lore.kernel.org/bpf/20191222012722.gdqhppxpfmqfqbld@ast-mbp.dhcp.thefacebook.com/
> >
> > As I mentioned, some of the ideas we used here are based on:
> >
> >   https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal
> >
> > Which gave each LSM the ability to add mutable hooks at runtime. If
> > you prefer we can make this generic and allow the LSMs to register
> > mutable hooks with the BPF LSM be the only LSM that uses it (and
> > enforce it with a whitelist).
> >
> > Would this generic approach be something you would consider better
> > than just calling the BPF mutable hooks directly?
> 
> What I think makes sense is for the BPF LSM to have a hook
> for each of the interfaces and for that hook to handle the
> mutable list for the interface. If BPF not included there
> will be no mutable hooks. 
> 
> Yes, your v1 got this right.

BPF LSM does provide mutable LSM hooks and it ends up being simpler
to implement/maintain when they are treated as such.

 The other approaches which we have considered are:

- Using macro magic to allocate static hook bodies which call eBPF
  programs as implemented in v1. This entails maintaining a
  separate list of LSM hooks in the BPF LSM which is evident from the
  giant security/bpf/include/hooks.h in:

  https://lore.kernel.org/bpf/20191220154208.15895-7-kpsingh@chromium.org

- Another approach one can think of is to allocate all the trampoline
  images (one page each) at __init and update these images to invoke
  BPF programs when they are attached.

Both these approaches seem to suffer from the downside of doing more
work when it's not really needed (i.e. doing prep work for hooks which
have no eBPF programs attached) and they appear to to mask the fact
that what the BPF LSM provides is actually mutable LSM hooks by
allocating static wrappers around mutable callbacks.

Are there other downsides apart from the fact we have an explicit call
to the mutable hooks in the LSM code? (Note that we want to have these
mutable hooks run after all the static LSM hooks so ordering
would still end up being LSM_ORDER_LAST)

It would be great to hear the maintainers' perspective based on the
trade-offs involved with the different approaches discussed.

We are happy to adapt our approach based on the consensus we reach
here.

- KP

> 
> >
> > - KP
> >
> >>>  	} while (0)
> >>>  
> >>> -#define call_int_hook(FUNC, IRC, ...) ({			\
> >>> -	int RC = IRC;						\
> >>> -	do {							\
> >>> -		struct security_hook_list *P;			\
> >>> -								\
> >>> +#define call_int_hook(FUNC, IRC, ...) ({				\
> >>> +	int RC = IRC;							\
> >>> +	do {								\
> >>> +		struct security_hook_list *P;				\
> >>>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> >>> -			RC = P->hook.FUNC(__VA_ARGS__);		\
> >>> -			if (RC != 0)				\
> >>> -				break;				\
> >>> -		}						\
> >>> -	} while (0);						\
> >>> -	RC;							\
> >>> +			RC = P->hook.FUNC(__VA_ARGS__);			\
> >>> +			if (RC != 0)					\
> >>> +				break;					\
> >>> +		}							\
> >>> +		if (RC == 0)						\
> >>> +			RC = CALL_BPF_LSM_INT_HOOKS(FUNC, __VA_ARGS__);	\
> >>> +	} while (0);							\
> >>> +	RC;								\
> >>>  })
> >>>  
> >>>  /* Security operations */
> 
