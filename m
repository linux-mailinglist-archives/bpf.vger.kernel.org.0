Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0542E405B38
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhIIQtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239747AbhIIQtK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 12:49:10 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379E7C061574
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 09:48:01 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v21-20020a05620a0a9500b003d5c1e2f277so5181189qkg.13
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IMj/rIfNdJeeUF+FlwIsH4hs1mbpSXmqFJm48NclVww=;
        b=UFn0HFmXoW6gwgT17y/0iUAcakdzLusQlRpqyDyweWHtAo0WTVbcyLQ+W8LAynefHC
         9zAuum1lNIkuOVkFuFKAvAkHhS2mWtSiUuY0mOo008XFAZjUSZElEZJzc+hYFvIyPSBt
         8zHNlLO4jHZrIVV4680qt/DAs9us6dlT0KjuTEp6mbg5Phl5lRLjOjsL5JgdqsXE+gSW
         AahcvmjLP2wUNirlwMC7weUI5CGxFwhG2etGtElgAWDiSDyHfK/ODsp6NnnfIsGS+/lU
         fc7CiPUNaPJNum5ROFLp2cg9PKLWJ/YSagBuTNUXBDfoaEsW7XmkADJayFGmPwP4Zsvj
         0bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IMj/rIfNdJeeUF+FlwIsH4hs1mbpSXmqFJm48NclVww=;
        b=let4ZsN0OzegH7Mhj+86sBxG69IiDr/fn814WFIiGs8ImFXxFk5bX8uXpmSI7kZn26
         75RGS7VtRykdpIcFwjOWamqWe/SS8QWk97ULsJKNuLovW/B7s7GEtTja9HN65GPHCFUR
         wHwfHzn/2qKmrphAou0CrMQLLR5+/iNbv/gtwDDBI8Xgy5g6B2yPIttQ2TZQNEQ2sz5E
         hOwVyLhCMtCi0wB8C6Q+WsRu1pCDEhVtH/X4yYSS3IpZjbcT1/4Xcqqc87GiQ9XowiIh
         JnR68WVV9uSEwppb7HNgAnQh3K7VWEkF1n3DHlfF/WcM3IofpEUjekluVhEKWp1K5K2N
         VRig==
X-Gm-Message-State: AOAM5335x8IUG30zyw7IZWpqEama8kuj4B81gMpZlYoMNu9oHFLF5J1S
        l1l3m4Ln6TW+ALwVYzDLi1aQjLs=
X-Google-Smtp-Source: ABdhPJyuPqofISYhPI3+Hna52ReTYpusT0R3wqECL0uHS7mhMxKTEprmvZqj9wnaSSSGN5cUEVRycC8=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:5cc5:b62d:9471:6101])
 (user=sdf job=sendgmr) by 2002:a05:6214:6aa:: with SMTP id
 s10mr937017qvz.56.1631206080415; Thu, 09 Sep 2021 09:48:00 -0700 (PDT)
Date:   Thu, 9 Sep 2021 09:47:58 -0700
In-Reply-To: <1e9ee1059ddb0ad7cd2c5f9eeaa26606f9d5fbbf.1631189197.git.daniel@iogearbox.net>
Message-Id: <YTo6vkBA9U65tdDG@google.com>
Mime-Version: 1.0
References: <1e9ee1059ddb0ad7cd2c5f9eeaa26606f9d5fbbf.1631189197.git.daniel@iogearbox.net>
Subject: Re: [PATCH bpf 1/3] bpf, cgroups: Fix cgroup v2 fallback on v1/v2
 mixed mode
From:   sdf@google.com
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
        davem@davemloft.net, m@lambda.lt, alexei.starovoitov@gmail.com,
        andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/09, Daniel Borkmann wrote:
> Fix cgroup v1 interference when non-root cgroup v2 BPF programs are used.
> Back in the days, commit bd1060a1d671 ("sock, cgroup: add  
> sock->sk_cgroup")
> embedded per-socket cgroup information into sock->sk_cgrp_data and in  
> order
> to save 8 bytes in struct sock made both mutually exclusive, that is, when
> cgroup v1 socket tagging (e.g. net_cls/net_prio) is used, then cgroup v2
> falls back to the root cgroup in sock_cgroup_ptr() (&cgrp_dfl_root.cgrp).

> The assumption made was "there is no reason to mix the two and this is in  
> line
> with how legacy and v2 compatibility is handled" as stated in  
> bd1060a1d671.
> However, with Kubernetes more widely supporting cgroups v2 as well  
> nowadays,
> this assumption no longer holds, and the possibility of the v1/v2 mixed  
> mode
> with the v2 root fallback being hit becomes a real security issue.

> Many of the cgroup v2 BPF programs are also used for policy enforcement,  
> just
> to pick _one_ example, that is, to programmatically deny socket related  
> system
> calls like connect(2) or bind(2). A v2 root fallback would implicitly  
> cause
> a policy bypass for the affected Pods.

> In production environments, we have recently seen this case due to various
> circumstances: i) a different 3rd party agent and/or ii) a container  
> runtime
> such as [0] in the user's environment configuring legacy cgroup v1 net_cls
> tags, which triggered implicitly mentioned root fallback. Another case is
> Kubernetes projects like kind [1] which create Kubernetes nodes in a  
> container
> and also add cgroup namespaces to the mix, meaning programs which are  
> attached
> to the cgroup v2 root of the cgroup namespace get attached to a non-root
> cgroup v2 path from init namespace point of view. And the latter's root is
> out of reach for agents on a kind Kubernetes node to configure. Meaning,  
> any
> entity on the node setting cgroup v1 net_cls tag will trigger the bypass
> despite cgroup v2 BPF programs attached to the namespace root.

> Generally, this mutual exclusiveness does not hold anymore in today's user
> environments and makes cgroup v2 usage from BPF side fragile and  
> unreliable.
> This fix adds proper struct cgroup pointer for the cgroup v2 case to  
> struct
> sock_cgroup_data in order to address these issues; this implicitly also  
> fixes
> the tradeoffs being made back then with regards to races and refcount  
> leaks
> as stated in bd1060a1d671, and removes the fallback, so that cgroup v2 BPF
> programs always operate as expected.

>    [0] https://github.com/nestybox/sysbox/
>    [1] https://kind.sigs.k8s.io/

> Fixes: bd1060a1d671 ("sock, cgroup: add sock->sk_cgroup")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Martynas Pumputis <m@lambda.lt>
> ---
>   include/linux/cgroup-defs.h  | 107 +++++++++--------------------------
>   include/linux/cgroup.h       |  22 +------
>   kernel/cgroup/cgroup.c       |  50 ++++------------
>   net/core/netclassid_cgroup.c |   7 +--
>   net/core/netprio_cgroup.c    |  10 +---
>   5 files changed, 41 insertions(+), 155 deletions(-)

> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index e1c705fdfa7c..44446025741f 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -752,107 +752,54 @@ static inline void  
> cgroup_threadgroup_change_end(struct task_struct *tsk) {}
>    * sock_cgroup_data is embedded at sock->sk_cgrp_data and contains
>    * per-socket cgroup information except for memcg association.
>    *
> - * On legacy hierarchies, net_prio and net_cls controllers directly set
> - * attributes on each sock which can then be tested by the network layer.
> - * On the default hierarchy, each sock is associated with the cgroup it  
> was
> - * created in and the networking layer can match the cgroup directly.
> - *
> - * To avoid carrying all three cgroup related fields separately in sock,
> - * sock_cgroup_data overloads (prioidx, classid) and the cgroup pointer.
> - * On boot, sock_cgroup_data records the cgroup that the sock was created
> - * in so that cgroup2 matches can be made; however, once either net_prio  
> or
> - * net_cls starts being used, the area is overridden to carry prioidx  
> and/or
> - * classid.  The two modes are distinguished by whether the lowest bit is
> - * set.  Clear bit indicates cgroup pointer while set bit prioidx and
> - * classid.
> - *
> - * While userland may start using net_prio or net_cls at any time, once
> - * either is used, cgroup2 matching no longer works.  There is no reason  
> to
> - * mix the two and this is in line with how legacy and v2 compatibility  
> is
> - * handled.  On mode switch, cgroup references which are already being
> - * pointed to by socks may be leaked.  While this can be remedied by  
> adding
> - * synchronization around sock_cgroup_data, given that the number of  
> leaked
> - * cgroups is bound and highly unlikely to be high, this seems to be the
> - * better trade-off.
> + * On legacy hierarchies, net_prio and net_cls controllers directly
> + * set attributes on each sock which can then be tested by the network
> + * layer. On the default hierarchy, each sock is associated with the
> + * cgroup it was created in and the networking layer can match the
> + * cgroup directly.
>    */
>   struct sock_cgroup_data {
> -	union {
> -#ifdef __LITTLE_ENDIAN
> -		struct {
> -			u8	is_data : 1;
> -			u8	no_refcnt : 1;
> -			u8	unused : 6;
> -			u8	padding;
> -			u16	prioidx;
> -			u32	classid;
> -		} __packed;
> -#else
> -		struct {
> -			u32	classid;
> -			u16	prioidx;
> -			u8	padding;
> -			u8	unused : 6;
> -			u8	no_refcnt : 1;
> -			u8	is_data : 1;
> -		} __packed;
> +	struct cgroup	*cgroup; /* v2 */
> +#if defined(CONFIG_CGROUP_NET_CLASSID)
> +	u32		classid; /* v1 */
> +#endif
> +#if defined(CONFIG_CGROUP_NET_PRIO)
> +	u16		prioidx; /* v1 */
>   #endif
> -		u64		val;
> -	};
>   };

> -/*
> - * There's a theoretical window where the following accessors race with
> - * updaters and return part of the previous pointer as the prioidx or
> - * classid.  Such races are short-lived and the result isn't critical.
> - */
>   static inline u16 sock_cgroup_prioidx(const struct sock_cgroup_data  
> *skcd)
>   {
> -	/* fallback to 1 which is always the ID of the root cgroup */
> -	return (skcd->is_data & 1) ? skcd->prioidx : 1;
> +#if defined(CONFIG_CGROUP_NET_PRIO)
> +	return READ_ONCE(skcd->prioidx);
> +#else
> +	return 1;
> +#endif
>   }

>   static inline u32 sock_cgroup_classid(const struct sock_cgroup_data  
> *skcd)
>   {
> -	/* fallback to 0 which is the unconfigured default classid */
> -	return (skcd->is_data & 1) ? skcd->classid : 0;
> +#if defined(CONFIG_CGROUP_NET_CLASSID)
> +	return READ_ONCE(skcd->classid);
> +#else
> +	return 0;
> +#endif
>   }

> -/*
> - * If invoked concurrently, the updaters may clobber each other.  The
> - * caller is responsible for synchronization.
> - */
>   static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
>   					   u16 prioidx)
>   {
> -	struct sock_cgroup_data skcd_buf = {{ .val = READ_ONCE(skcd->val) }};
> -
> -	if (sock_cgroup_prioidx(&skcd_buf) == prioidx)
> -		return;
> -
> -	if (!(skcd_buf.is_data & 1)) {
> -		skcd_buf.val = 0;
> -		skcd_buf.is_data = 1;
> -	}
> -
> -	skcd_buf.prioidx = prioidx;
> -	WRITE_ONCE(skcd->val, skcd_buf.val);	/* see sock_cgroup_ptr() */
> +#if defined(CONFIG_CGROUP_NET_PRIO)
> +	WRITE_ONCE(skcd->prioidx, prioidx);
> +#endif
>   }

>   static inline void sock_cgroup_set_classid(struct sock_cgroup_data *skcd,
>   					   u32 classid)
>   {
> -	struct sock_cgroup_data skcd_buf = {{ .val = READ_ONCE(skcd->val) }};
> -
> -	if (sock_cgroup_classid(&skcd_buf) == classid)
> -		return;
> -
> -	if (!(skcd_buf.is_data & 1)) {
> -		skcd_buf.val = 0;
> -		skcd_buf.is_data = 1;
> -	}
> -
> -	skcd_buf.classid = classid;
> -	WRITE_ONCE(skcd->val, skcd_buf.val);	/* see sock_cgroup_ptr() */
> +#if defined(CONFIG_CGROUP_NET_CLASSID)
> +	WRITE_ONCE(skcd->classid, classid);
> +#endif
>   }

>   #else	/* CONFIG_SOCK_CGROUP_DATA */
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 7bf60454a313..a7e79ad7c9b0 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -829,33 +829,13 @@ static inline void  
> cgroup_account_cputime_field(struct task_struct *task,
>    */
>   #ifdef CONFIG_SOCK_CGROUP_DATA

> -#if defined(CONFIG_CGROUP_NET_PRIO) || defined(CONFIG_CGROUP_NET_CLASSID)
> -extern spinlock_t cgroup_sk_update_lock;
> -#endif
> -
> -void cgroup_sk_alloc_disable(void);
>   void cgroup_sk_alloc(struct sock_cgroup_data *skcd);
>   void cgroup_sk_clone(struct sock_cgroup_data *skcd);
>   void cgroup_sk_free(struct sock_cgroup_data *skcd);

>   static inline struct cgroup *sock_cgroup_ptr(struct sock_cgroup_data  
> *skcd)
>   {
> -#if defined(CONFIG_CGROUP_NET_PRIO) || defined(CONFIG_CGROUP_NET_CLASSID)
> -	unsigned long v;
> -
> -	/*
> -	 * @skcd->val is 64bit but the following is safe on 32bit too as we
> -	 * just need the lower ulong to be written and read atomically.
> -	 */
> -	v = READ_ONCE(skcd->val);
> -
> -	if (v & 3)
> -		return &cgrp_dfl_root.cgrp;
> -
> -	return (struct cgroup *)(unsigned long)v ?: &cgrp_dfl_root.cgrp;
> -#else
> -	return (struct cgroup *)(unsigned long)skcd->val;
> -#endif
> +	return READ_ONCE(skcd->cgroup);

Do we really need READ_ONCE here? I was always assuming it was there
because we were flipping that lower bit. Now that it's a simple
pointer, why not 'return skcd->cgroup' instead?

>   }

>   #else	/* CONFIG_CGROUP_DATA */
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 881ce1470beb..15ad5c8b24a8 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6572,74 +6572,44 @@ int cgroup_parse_float(const char *input,  
> unsigned dec_shift, s64 *v)
>    */
>   #ifdef CONFIG_SOCK_CGROUP_DATA

> -#if defined(CONFIG_CGROUP_NET_PRIO) || defined(CONFIG_CGROUP_NET_CLASSID)
> -
> -DEFINE_SPINLOCK(cgroup_sk_update_lock);
> -static bool cgroup_sk_alloc_disabled __read_mostly;
> -
> -void cgroup_sk_alloc_disable(void)
> -{
> -	if (cgroup_sk_alloc_disabled)
> -		return;
> -	pr_info("cgroup: disabling cgroup2 socket matching due to net_prio or  
> net_cls activation\n");
> -	cgroup_sk_alloc_disabled = true;
> -}
> -
> -#else
> -
> -#define cgroup_sk_alloc_disabled	false
> -
> -#endif
> -
>   void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
>   {
> -	if (cgroup_sk_alloc_disabled) {
> -		skcd->no_refcnt = 1;
> -		return;
> -	}
> -
>   	/* Don't associate the sock with unrelated interrupted task's cgroup. */
>   	if (in_interrupt())
>   		return;

>   	rcu_read_lock();
> -
>   	while (true) {
>   		struct css_set *cset;

>   		cset = task_css_set(current);
>   		if (likely(cgroup_tryget(cset->dfl_cgrp))) {
> -			skcd->val = (unsigned long)cset->dfl_cgrp;
> +			WRITE_ONCE(skcd->cgroup, cset->dfl_cgrp);
>   			cgroup_bpf_get(cset->dfl_cgrp);
>   			break;
>   		}
>   		cpu_relax();
>   	}
> -
>   	rcu_read_unlock();
>   }

>   void cgroup_sk_clone(struct sock_cgroup_data *skcd)
>   {
> -	if (skcd->val) {
> -		if (skcd->no_refcnt)
> -			return;
> -		/*
> -		 * We might be cloning a socket which is left in an empty
> -		 * cgroup and the cgroup might have already been rmdir'd.
> -		 * Don't use cgroup_get_live().
> -		 */
> -		cgroup_get(sock_cgroup_ptr(skcd));
> -		cgroup_bpf_get(sock_cgroup_ptr(skcd));
> -	}
> +	struct cgroup *cgrp = sock_cgroup_ptr(skcd);
> +
> +	/*
> +	 * We might be cloning a socket which is left in an empty
> +	 * cgroup and the cgroup might have already been rmdir'd.
> +	 * Don't use cgroup_get_live().
> +	 */
> +	cgroup_get(cgrp);
> +	cgroup_bpf_get(cgrp);
>   }

>   void cgroup_sk_free(struct sock_cgroup_data *skcd)
>   {
>   	struct cgroup *cgrp = sock_cgroup_ptr(skcd);

> -	if (skcd->no_refcnt)
> -		return;
>   	cgroup_bpf_put(cgrp);
>   	cgroup_put(cgrp);
>   }
> diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
> index b49c57d35a88..1a6a86693b74 100644
> --- a/net/core/netclassid_cgroup.c
> +++ b/net/core/netclassid_cgroup.c
> @@ -71,11 +71,8 @@ static int update_classid_sock(const void *v, struct  
> file *file, unsigned n)
>   	struct update_classid_context *ctx = (void *)v;
>   	struct socket *sock = sock_from_file(file);

> -	if (sock) {
> -		spin_lock(&cgroup_sk_update_lock);
> +	if (sock)
>   		sock_cgroup_set_classid(&sock->sk->sk_cgrp_data, ctx->classid);
> -		spin_unlock(&cgroup_sk_update_lock);
> -	}
>   	if (--ctx->batch == 0) {
>   		ctx->batch = UPDATE_CLASSID_BATCH;
>   		return n + 1;
> @@ -121,8 +118,6 @@ static int write_classid(struct cgroup_subsys_state  
> *css, struct cftype *cft,
>   	struct css_task_iter it;
>   	struct task_struct *p;

> -	cgroup_sk_alloc_disable();
> -
>   	cs->classid = (u32)value;

>   	css_task_iter_start(css, 0, &it);
> diff --git a/net/core/netprio_cgroup.c b/net/core/netprio_cgroup.c
> index 99a431c56f23..8456dfbe2eb4 100644
> --- a/net/core/netprio_cgroup.c
> +++ b/net/core/netprio_cgroup.c
> @@ -207,8 +207,6 @@ static ssize_t write_priomap(struct kernfs_open_file  
> *of,
>   	if (!dev)
>   		return -ENODEV;

> -	cgroup_sk_alloc_disable();
> -
>   	rtnl_lock();

>   	ret = netprio_set_prio(of_css(of), dev, prio);
> @@ -221,12 +219,10 @@ static ssize_t write_priomap(struct  
> kernfs_open_file *of,
>   static int update_netprio(const void *v, struct file *file, unsigned n)
>   {
>   	struct socket *sock = sock_from_file(file);
> -	if (sock) {
> -		spin_lock(&cgroup_sk_update_lock);
> +
> +	if (sock)
>   		sock_cgroup_set_prioidx(&sock->sk->sk_cgrp_data,
>   					(unsigned long)v);
> -		spin_unlock(&cgroup_sk_update_lock);
> -	}
>   	return 0;
>   }

> @@ -235,8 +231,6 @@ static void net_prio_attach(struct cgroup_taskset  
> *tset)
>   	struct task_struct *p;
>   	struct cgroup_subsys_state *css;

> -	cgroup_sk_alloc_disable();
> -
>   	cgroup_taskset_for_each(p, css, tset) {
>   		void *v = (void *)(unsigned long)css->id;

> --
> 2.21.0

