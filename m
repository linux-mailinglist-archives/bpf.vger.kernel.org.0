Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C546A8A39
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 21:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCBU2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 15:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCBU2N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 15:28:13 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C487F1BE6
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 12:28:08 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id iw4-20020a170903044400b0019ccafc1fbeso226228plb.3
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 12:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677788888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLAIwkliyAqDKA1qWJLQtqycjdxuTylOGMu94mTp7wc=;
        b=AuIvNU+FjsqzNT6/MTzw60zQ1t95JcRPseUBFIs32Y3xj6fa3Drblrj9Ly+i2T9Nw5
         FXkHOdUWBnkbMFip7DkKfLYzTQU21NfB8OStowEldR4LQVLngo7WrSNTuIIIV+LRPFfj
         uceWEJgg04TkWMNv3EWOvrqeXRy8GHZTKuHbS9dULIU/Q1mSW3OWzZYxBSmaEB4CtJ8R
         tqopaIkKRTy80+frUU6/TJt5DyE3zARKB7vfvnYcANWmB9b/TfXa8Bl9Q9ZqLQLBgKUI
         uClXGTcJbK1sEGE5ocUPwqMCq67AIbSy7SSWLlOlg8NSeIvSpnPg066KSlJJNEITcxgv
         lAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677788888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLAIwkliyAqDKA1qWJLQtqycjdxuTylOGMu94mTp7wc=;
        b=wu6DHtkeTQfpZcGvDiTPl7htuWiWF8hVP+o5r5pnzNFcD1tz2q6kM8+zRK/2TR1Uoe
         SGkevazFBrGNkrG0CUPugNCVR7VwQerSpuA/f5okYHtdFFO8w4Net4pMnpYUBBQ9epsa
         0Neejk/Tr7CUD6fPzYWQI/uKLsCq7Hlk2JXcQe8JHSBQF9+L5z066XEi7FM9HOUts1ih
         7to6dyqXV1tQpOQV/w+WFc0hbO0Z+gHtv2Y1GiCwsTK0tjnbqp3iNZXaK8Lfp2OOai4z
         p/4guyEYuInrQWOVxGjSsBQ8aYwH1VRGo9wT/ULeKzAjewcyAeRnIUgQ7tKG5fzZf16G
         iwGA==
X-Gm-Message-State: AO0yUKWabkZq9SkTMDGMOnvPIZPHYAVS9V6301R/EMQXEyETZI36nIvv
        /EvzaKBIO71Z23shWA0XNJ74bUE=
X-Google-Smtp-Source: AK7set9wGYet8F5EDsOHiotDHor49od7CUGfbiaEeEjIlEYEq0YY7KIeJ/8DhECGZ36DMAyoIh9Y9O8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:5ac4:b0:237:3d0c:8d2e with SMTP id
 n62-20020a17090a5ac400b002373d0c8d2emr4525606pji.2.1677788888255; Thu, 02 Mar
 2023 12:28:08 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:28:06 -0800
In-Reply-To: <20230302172757.9548-2-fw@strlen.de>
Mime-Version: 1.0
References: <20230302172757.9548-1-fw@strlen.de> <20230302172757.9548-2-fw@strlen.de>
Message-ID: <ZAEG1gtoXl125GlW@google.com>
Subject: Re: [PATCH RFC v2 bpf-next 1/3] bpf: add bpf_link support for
 BPF_NETFILTER programs
From:   Stanislav Fomichev <sdf@google.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/02, Florian Westphal wrote:
> Add bpf_link support skeleton.  To keep this reviewable, no bpf program
> can be invoked here, if a program would be attached only a c-stub is  
> called.

> This defaults to 'y' if both netfilter and bpf syscall are enabled in
> kconfig.

> Uapi example usage:
> 	union bpf_attr attr = { };

> 	attr.link_create.prog_fd = progfd;
> 	attr.link_create.attach_type = BPF_NETFILTER;
> 	attr.link_create.netfilter.pf = PF_INET;
> 	attr.link_create.netfilter.hooknum = NF_INET_LOCAL_IN;
> 	attr.link_create.netfilter.priority = -128;

> 	err = bpf(BPF_LINK_CREATE, &attr, sizeof(attr));

> ... this would attach progfd to ipv4:input hook.

> Such hook gets removed automatically if the calling program exits.

> BPF_NETFILTER program invocation is added in followup change.

> NF_HOOK_OP_BPF enum will eventually be read from nfnetlink_hook, it
> allows to tell userspace which program is attached at the given hook
> when user runs 'nft hook list' command rather than just the priority
> and not-very-helpful 'this hook runs a bpf prog but I can't tell which
> one'.

> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>   include/linux/netfilter.h           |   1 +
>   include/net/netfilter/nf_hook_bpf.h |   2 +
>   include/uapi/linux/bpf.h            |  12 +++
>   kernel/bpf/syscall.c                |   6 ++
>   net/netfilter/Kconfig               |   3 +
>   net/netfilter/Makefile              |   1 +
>   net/netfilter/nf_bpf_link.c         | 116 ++++++++++++++++++++++++++++
>   7 files changed, 141 insertions(+)
>   create mode 100644 include/net/netfilter/nf_hook_bpf.h
>   create mode 100644 net/netfilter/nf_bpf_link.c

> diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
> index 6863e271a9de..beec40ccbd79 100644
> --- a/include/linux/netfilter.h
> +++ b/include/linux/netfilter.h
> @@ -80,6 +80,7 @@ typedef unsigned int nf_hookfn(void *priv,
>   enum nf_hook_ops_type {
>   	NF_HOOK_OP_UNDEFINED,
>   	NF_HOOK_OP_NF_TABLES,
> +	NF_HOOK_OP_BPF,
>   };

>   struct nf_hook_ops {
> diff --git a/include/net/netfilter/nf_hook_bpf.h  
> b/include/net/netfilter/nf_hook_bpf.h
> new file mode 100644
> index 000000000000..9d1b338e89d7
> --- /dev/null
> +++ b/include/net/netfilter/nf_hook_bpf.h
> @@ -0,0 +1,2 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog  
> *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c9699304aed2..b063c6985769 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -986,6 +986,7 @@ enum bpf_prog_type {
>   	BPF_PROG_TYPE_LSM,
>   	BPF_PROG_TYPE_SK_LOOKUP,
>   	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
> +	BPF_PROG_TYPE_NETFILTER,
>   };

>   enum bpf_attach_type {
> @@ -1049,6 +1050,7 @@ enum bpf_link_type {
>   	BPF_LINK_TYPE_PERF_EVENT = 7,
>   	BPF_LINK_TYPE_KPROBE_MULTI = 8,
>   	BPF_LINK_TYPE_STRUCT_OPS = 9,
> +	BPF_LINK_TYPE_NETFILTER = 10,

>   	MAX_BPF_LINK_TYPE,
>   };
> @@ -1543,6 +1545,11 @@ union bpf_attr {
>   				 */
>   				__u64		cookie;
>   			} tracing;
> +			struct {
> +				__u32		pf;
> +				__u32		hooknum;
> +				__s32		prio;
> +			} netfilter;

For recent tc BPF program extensions, we've discussed that it might be  
better
to have an option to attach program before/after another one in the chain.
So the API essentially would receive a before/after flag + fd/id of the
program where we want to be.

Should we do something similar here? See [0] for the original
discussion.

0: https://lore.kernel.org/bpf/YzzWDqAmN5DRTupQ@google.com/

>   		};
>   	} link_create;

> @@ -6373,6 +6380,11 @@ struct bpf_link_info {
>   		struct {
>   			__u32 ifindex;
>   		} xdp;
> +		struct {
> +			__u32 pf;
> +			__u32 hooknum;
> +			__s32 priority;
> +		} netfilter;
>   	};
>   } __attribute__((aligned(8)));

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e3fcdc9836a6..8f5cd1fb83ee 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -35,6 +35,7 @@
>   #include <linux/rcupdate_trace.h>
>   #include <linux/memcontrol.h>
>   #include <linux/trace_events.h>
> +#include <net/netfilter/nf_hook_bpf.h>

>   #define IS_FD_ARRAY(map) ((map)->map_type ==  
> BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
>   			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
> @@ -2448,6 +2449,7 @@ static bool is_net_admin_prog_type(enum  
> bpf_prog_type prog_type)
>   	case BPF_PROG_TYPE_CGROUP_SYSCTL:
>   	case BPF_PROG_TYPE_SOCK_OPS:
>   	case BPF_PROG_TYPE_EXT: /* extends any prog */
> +	case BPF_PROG_TYPE_NETFILTER:
>   		return true;
>   	case BPF_PROG_TYPE_CGROUP_SKB:
>   		/* always unpriv */
> @@ -4562,6 +4564,7 @@ static int link_create(union bpf_attr *attr,  
> bpfptr_t uattr)

>   	switch (prog->type) {
>   	case BPF_PROG_TYPE_EXT:
> +	case BPF_PROG_TYPE_NETFILTER:
>   		break;
>   	case BPF_PROG_TYPE_PERF_EVENT:
>   	case BPF_PROG_TYPE_TRACEPOINT:
> @@ -4628,6 +4631,9 @@ static int link_create(union bpf_attr *attr,  
> bpfptr_t uattr)
>   	case BPF_PROG_TYPE_XDP:
>   		ret = bpf_xdp_link_attach(attr, prog);
>   		break;
> +	case BPF_PROG_TYPE_NETFILTER:
> +		ret = bpf_nf_link_attach(attr, prog);
> +		break;
>   #endif
>   	case BPF_PROG_TYPE_PERF_EVENT:
>   	case BPF_PROG_TYPE_TRACEPOINT:
> diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
> index 4d6737160857..bea06f62a30e 100644
> --- a/net/netfilter/Kconfig
> +++ b/net/netfilter/Kconfig
> @@ -30,6 +30,9 @@ config NETFILTER_FAMILY_BRIDGE
>   config NETFILTER_FAMILY_ARP
>   	bool

> +config NETFILTER_BPF_LINK
> +	def_bool BPF_SYSCALL
> +
>   config NETFILTER_NETLINK_HOOK
>   	tristate "Netfilter base hook dump support"
>   	depends on NETFILTER_ADVANCED
> diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
> index 5ffef1cd6143..d4958e7e7631 100644
> --- a/net/netfilter/Makefile
> +++ b/net/netfilter/Makefile
> @@ -22,6 +22,7 @@ nf_conntrack-$(CONFIG_DEBUG_INFO_BTF) +=  
> nf_conntrack_bpf.o
>   endif

>   obj-$(CONFIG_NETFILTER) = netfilter.o
> +obj-$(CONFIG_NETFILTER_BPF_LINK) += nf_bpf_link.o

>   obj-$(CONFIG_NETFILTER_NETLINK) += nfnetlink.o
>   obj-$(CONFIG_NETFILTER_NETLINK_ACCT) += nfnetlink_acct.o
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> new file mode 100644
> index 000000000000..fa4fae5cc669
> --- /dev/null
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <linux/netfilter.h>
> +
> +#include <net/netfilter/nf_hook_bpf.h>
> +
> +static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,  
> const struct nf_hook_state *s)
> +{
> +	return NF_ACCEPT;
> +}
> +
> +struct bpf_nf_link {
> +	struct bpf_link link;
> +	struct nf_hook_ops hook_ops;
> +	struct net *net;
> +};
> +
> +static void bpf_nf_link_release(struct bpf_link *link)
> +{
> +	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link,  
> link);
> +
> +	nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
> +}
> +
> +static void bpf_nf_link_dealloc(struct bpf_link *link)
> +{
> +	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link,  
> link);
> +
> +	kfree(nf_link);
> +}
> +
> +static int bpf_nf_link_detach(struct bpf_link *link)
> +{
> +	bpf_nf_link_release(link);
> +	return 0;
> +}
> +
> +static void bpf_nf_link_show_info(const struct bpf_link *link,
> +				  struct seq_file *seq)
> +{
> +	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link,  
> link);
> +
> +	seq_printf(seq, "pf:\t%u\thooknum:\t%u\tprio:\t%d\n",
> +		  nf_link->hook_ops.pf, nf_link->hook_ops.hooknum,
> +		  nf_link->hook_ops.priority);
> +}
> +
> +static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
> +				      struct bpf_link_info *info)
> +{
> +	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link,  
> link);
> +
> +	info->netfilter.pf = nf_link->hook_ops.pf;
> +	info->netfilter.hooknum = nf_link->hook_ops.hooknum;
> +	info->netfilter.priority = nf_link->hook_ops.priority;
> +
> +	return 0;
> +}
> +
> +static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog  
> *new_prog,
> +			      struct bpf_prog *old_prog)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct bpf_link_ops bpf_nf_link_lops = {
> +	.release = bpf_nf_link_release,
> +	.dealloc = bpf_nf_link_dealloc,
> +	.detach = bpf_nf_link_detach,
> +	.show_fdinfo = bpf_nf_link_show_info,
> +	.fill_link_info = bpf_nf_link_fill_link_info,
> +	.update_prog = bpf_nf_link_update,
> +};
> +
> +int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct net *net = current->nsproxy->net_ns;
> +	struct bpf_link_primer link_primer;
> +	struct bpf_nf_link *link;
> +	int err;
> +
> +	if (attr->link_create.flags)
> +		return -EINVAL;
> +
> +	link = kzalloc(sizeof(*link), GFP_USER);
> +	if (!link)
> +		return -ENOMEM;
> +
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_NETFILTER, &bpf_nf_link_lops,  
> prog);
> +
> +	link->hook_ops.hook = nf_hook_run_bpf;
> +	link->hook_ops.hook_ops_type = NF_HOOK_OP_BPF;
> +	link->hook_ops.priv = prog;
> +
> +	link->hook_ops.pf = attr->link_create.netfilter.pf;
> +	link->hook_ops.priority = attr->link_create.netfilter.prio;
> +	link->hook_ops.hooknum = attr->link_create.netfilter.hooknum;
> +
> +	link->net = net;
> +
> +	err = bpf_link_prime(&link->link, &link_primer);
> +	if (err)
> +		goto out_free;
> +
> +	err = nf_register_net_hook(net, &link->hook_ops);
> +	if (err) {
> +		bpf_link_cleanup(&link_primer);
> +		goto out_free;
> +	}
> +
> +	return bpf_link_settle(&link_primer);
> +
> +out_free:
> +	kfree(link);
> +	return err;
> +}
> --
> 2.39.2

