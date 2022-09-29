Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770315EF0B1
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiI2IiM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiI2IiL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 04:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3CA132FC2
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 01:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664440688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCejEhOZeEz4lRq8eB7eRjuOrzlC81ktVxPeHJ8t7qA=;
        b=OMlKwrm20fXyyrXcJAZqUfPsrV/vhE2O4/8M4C07yS7HLS1j9gyOX+4OSz7aLvMDwJP9iT
        4XZCIAE8DaVWXPNIDxcg5oiNkp8L6hHW2dR5egaorA/KoSfZ88CDlG8OA5M0Rc/1+kuJwD
        thqyFYVkvxoxXQ4qsq8fiLsb40KiD3E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-317-FVeo_q9aMBGDLEnrIsnSIw-1; Thu, 29 Sep 2022 04:38:07 -0400
X-MC-Unique: FVeo_q9aMBGDLEnrIsnSIw-1
Received: by mail-wr1-f71.google.com with SMTP id g27-20020adfa49b000000b0022cd5476cc7so241269wrb.17
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 01:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XCejEhOZeEz4lRq8eB7eRjuOrzlC81ktVxPeHJ8t7qA=;
        b=jCzlUMPN66TYYFr+SQ+UJ3QUOygmGyCTlU9rz8mQLIagTqI6MTwDLlQs7GQYES+Cuh
         5DTqZEE8W6al8ISl82K8uDuBFOBcnM1Aj7DoQbjW853ZMz50V2DuPXQczqi2b4+e0erm
         yo9nD0NZ59jheGBgFw4ggZX2zgDqloxMI+fc1Kbuz01vzYLYaih2n+w6DGNJYS8gaPwl
         StfTh37hMEvuLn0hpfgblnRRHYKSFUutSYANc4PdZ7fQA3qGG7ea6efv9PXz3uUf1frB
         3YpEaxg4DH3Zq1CybMrh3tnbjAF1kv55eV8iQeZIi7WKDnWRb4WxUeYNZib3PJpPzXAz
         ZF6g==
X-Gm-Message-State: ACrzQf0bOIC0SI5a2RdPpLy1O/ioixQCgR2WBBJsVOK40gcG4t52c5JP
        J9xtok2tL3TEpoYFxz1AGzQnhegKvxZNgTdF6m4jG5fJrejt+EqS7tNzSvsJBaITUFuJQd04e8U
        7l/UB8n2l4NzusofWII0h1zfiyRf/
X-Received: by 2002:a05:6000:184e:b0:228:bc3a:8e35 with SMTP id c14-20020a056000184e00b00228bc3a8e35mr1310725wri.443.1664440685987;
        Thu, 29 Sep 2022 01:38:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4m8/ZPNZDCLAnP6JQdsaOW9OGZVvqHY8iEty+ntfHNZtB3G4XLZkfhAggzN/lIGjtSbNJoPsCBmBM26YqhzYQ=
X-Received: by 2002:a05:6000:184e:b0:228:bc3a:8e35 with SMTP id
 c14-20020a056000184e00b00228bc3a8e35mr1310700wri.443.1664440685683; Thu, 29
 Sep 2022 01:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <ddd17d808fe25917893eb035b20146479810124c.1664111646.git.lorenzo@kernel.org>
In-Reply-To: <ddd17d808fe25917893eb035b20146479810124c.1664111646.git.lorenzo@kernel.org>
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Thu, 29 Sep 2022 11:37:49 +0300
Message-ID: <CANoWswkJwZ0mLVmA5npm6Zty=CXJ1dupKvOjAU5G+Y19xM9T0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] net: netfilter: move bpf_ct_set_nat_info kfunc
 in nf_nat_bpf.c
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, pablo@netfilter.org,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jesper Brouer <brouer@redhat.com>,
        Toke Hoiland Jorgensen <toke@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

The patch leads to

depmod: ERROR: Cycle detected: nf_conntrack -> nf_nat -> nf_conntrack

when it is built as modules (due to nf_nat_setup_info() dependency)

On Sun, Sep 25, 2022 at 4:26 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Remove circular dependency between nf_nat module and nf_conntrack one
> moving bpf_ct_set_nat_info kfunc in nf_nat_bpf.c
>
> Fixes: 0fabd2aa199f ("net: netfilter: add bpf_ct_set_nat_info kfunc helper")
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/netfilter/nf_conntrack_bpf.h |  5 ++
>  include/net/netfilter/nf_nat.h           | 14 +++++
>  net/netfilter/Makefile                   |  6 ++
>  net/netfilter/nf_conntrack_bpf.c         | 49 ---------------
>  net/netfilter/nf_nat_bpf.c               | 79 ++++++++++++++++++++++++
>  net/netfilter/nf_nat_core.c              |  2 +-
>  6 files changed, 105 insertions(+), 50 deletions(-)
>  create mode 100644 net/netfilter/nf_nat_bpf.c
>
> diff --git a/include/net/netfilter/nf_conntrack_bpf.h b/include/net/netfilter/nf_conntrack_bpf.h
> index c8b80add1142..1ce46e406062 100644
> --- a/include/net/netfilter/nf_conntrack_bpf.h
> +++ b/include/net/netfilter/nf_conntrack_bpf.h
> @@ -4,6 +4,11 @@
>  #define _NF_CONNTRACK_BPF_H
>
>  #include <linux/kconfig.h>
> +#include <net/netfilter/nf_conntrack.h>
> +
> +struct nf_conn___init {
> +       struct nf_conn ct;
> +};
>
>  #if (IS_BUILTIN(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
>      (IS_MODULE(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> diff --git a/include/net/netfilter/nf_nat.h b/include/net/netfilter/nf_nat.h
> index e9eb01e99d2f..cd084059a953 100644
> --- a/include/net/netfilter/nf_nat.h
> +++ b/include/net/netfilter/nf_nat.h
> @@ -68,6 +68,20 @@ static inline bool nf_nat_oif_changed(unsigned int hooknum,
>  #endif
>  }
>
> +#if (IS_BUILTIN(CONFIG_NF_NAT) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
> +    (IS_MODULE(CONFIG_NF_NAT) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> +
> +extern int register_nf_nat_bpf(void);
> +
> +#else
> +
> +static inline int register_nf_nat_bpf(void)
> +{
> +       return 0;
> +}
> +
> +#endif
> +
>  int nf_nat_register_fn(struct net *net, u8 pf, const struct nf_hook_ops *ops,
>                        const struct nf_hook_ops *nat_ops, unsigned int ops_count);
>  void nf_nat_unregister_fn(struct net *net, u8 pf, const struct nf_hook_ops *ops,
> diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
> index 06df49ea6329..0f060d100880 100644
> --- a/net/netfilter/Makefile
> +++ b/net/netfilter/Makefile
> @@ -60,6 +60,12 @@ obj-$(CONFIG_NF_NAT) += nf_nat.o
>  nf_nat-$(CONFIG_NF_NAT_REDIRECT) += nf_nat_redirect.o
>  nf_nat-$(CONFIG_NF_NAT_MASQUERADE) += nf_nat_masquerade.o
>
> +ifeq ($(CONFIG_NF_NAT),m)
> +nf_nat-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_nat_bpf.o
> +else ifeq ($(CONFIG_NF_NAT),y)
> +nf_nat-$(CONFIG_DEBUG_INFO_BTF) += nf_nat_bpf.o
> +endif
> +
>  # NAT helpers
>  obj-$(CONFIG_NF_NAT_AMANDA) += nf_nat_amanda.o
>  obj-$(CONFIG_NF_NAT_FTP) += nf_nat_ftp.o
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
> index 756ea818574e..f4ba4ff3a63b 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -14,7 +14,6 @@
>  #include <linux/types.h>
>  #include <linux/btf_ids.h>
>  #include <linux/net_namespace.h>
> -#include <net/netfilter/nf_conntrack.h>
>  #include <net/netfilter/nf_conntrack_bpf.h>
>  #include <net/netfilter/nf_conntrack_core.h>
>  #include <net/netfilter/nf_nat.h>
> @@ -239,10 +238,6 @@ __diag_push();
>  __diag_ignore_all("-Wmissing-prototypes",
>                   "Global functions as their definitions will be in nf_conntrack BTF");
>
> -struct nf_conn___init {
> -       struct nf_conn ct;
> -};
> -
>  /* bpf_xdp_ct_alloc - Allocate a new CT entry
>   *
>   * Parameters:
> @@ -476,49 +471,6 @@ int bpf_ct_change_status(struct nf_conn *nfct, u32 status)
>         return nf_ct_change_status_common(nfct, status);
>  }
>
> -/* bpf_ct_set_nat_info - Set source or destination nat address
> - *
> - * Set source or destination nat address of the newly allocated
> - * nf_conn before insertion. This must be invoked for referenced
> - * PTR_TO_BTF_ID to nf_conn___init.
> - *
> - * Parameters:
> - * @nfct       - Pointer to referenced nf_conn object, obtained using
> - *               bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
> - * @addr       - Nat source/destination address
> - * @port       - Nat source/destination port. Non-positive values are
> - *               interpreted as select a random port.
> - * @manip      - NF_NAT_MANIP_SRC or NF_NAT_MANIP_DST
> - */
> -int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
> -                       union nf_inet_addr *addr, int port,
> -                       enum nf_nat_manip_type manip)
> -{
> -#if ((IS_MODULE(CONFIG_NF_NAT) && IS_MODULE(CONFIG_NF_CONNTRACK)) || \
> -     IS_BUILTIN(CONFIG_NF_NAT))
> -       struct nf_conn *ct = (struct nf_conn *)nfct;
> -       u16 proto = nf_ct_l3num(ct);
> -       struct nf_nat_range2 range;
> -
> -       if (proto != NFPROTO_IPV4 && proto != NFPROTO_IPV6)
> -               return -EINVAL;
> -
> -       memset(&range, 0, sizeof(struct nf_nat_range2));
> -       range.flags = NF_NAT_RANGE_MAP_IPS;
> -       range.min_addr = *addr;
> -       range.max_addr = range.min_addr;
> -       if (port > 0) {
> -               range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
> -               range.min_proto.all = cpu_to_be16(port);
> -               range.max_proto.all = range.min_proto.all;
> -       }
> -
> -       return nf_nat_setup_info(ct, &range, manip) == NF_DROP ? -ENOMEM : 0;
> -#else
> -       return -EOPNOTSUPP;
> -#endif
> -}
> -
>  __diag_pop()
>
>  BTF_SET8_START(nf_ct_kfunc_set)
> @@ -532,7 +484,6 @@ BTF_ID_FLAGS(func, bpf_ct_set_timeout, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_ct_change_timeout, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_ct_set_status, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_ct_change_status, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
>  BTF_SET8_END(nf_ct_kfunc_set)
>
>  static const struct btf_kfunc_id_set nf_conntrack_kfunc_set = {
> diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
> new file mode 100644
> index 000000000000..0fa5a0bbb0ff
> --- /dev/null
> +++ b/net/netfilter/nf_nat_bpf.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Unstable NAT Helpers for XDP and TC-BPF hook
> + *
> + * These are called from the XDP and SCHED_CLS BPF programs. Note that it is
> + * allowed to break compatibility for these functions since the interface they
> + * are exposed through to BPF programs is explicitly unstable.
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <net/netfilter/nf_conntrack_bpf.h>
> +#include <net/netfilter/nf_conntrack_core.h>
> +#include <net/netfilter/nf_nat.h>
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "Global functions as their definitions will be in nf_nat BTF");
> +
> +/* bpf_ct_set_nat_info - Set source or destination nat address
> + *
> + * Set source or destination nat address of the newly allocated
> + * nf_conn before insertion. This must be invoked for referenced
> + * PTR_TO_BTF_ID to nf_conn___init.
> + *
> + * Parameters:
> + * @nfct       - Pointer to referenced nf_conn object, obtained using
> + *               bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
> + * @addr       - Nat source/destination address
> + * @port       - Nat source/destination port. Non-positive values are
> + *               interpreted as select a random port.
> + * @manip      - NF_NAT_MANIP_SRC or NF_NAT_MANIP_DST
> + */
> +int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
> +                       union nf_inet_addr *addr, int port,
> +                       enum nf_nat_manip_type manip)
> +{
> +       struct nf_conn *ct = (struct nf_conn *)nfct;
> +       u16 proto = nf_ct_l3num(ct);
> +       struct nf_nat_range2 range;
> +
> +       if (proto != NFPROTO_IPV4 && proto != NFPROTO_IPV6)
> +               return -EINVAL;
> +
> +       memset(&range, 0, sizeof(struct nf_nat_range2));
> +       range.flags = NF_NAT_RANGE_MAP_IPS;
> +       range.min_addr = *addr;
> +       range.max_addr = range.min_addr;
> +       if (port > 0) {
> +               range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
> +               range.min_proto.all = cpu_to_be16(port);
> +               range.max_proto.all = range.min_proto.all;
> +       }
> +
> +       return nf_nat_setup_info(ct, &range, manip) == NF_DROP ? -ENOMEM : 0;
> +}
> +
> +__diag_pop()
> +
> +BTF_SET8_START(nf_nat_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
> +BTF_SET8_END(nf_nat_kfunc_set)
> +
> +static const struct btf_kfunc_id_set nf_bpf_nat_kfunc_set = {
> +       .owner = THIS_MODULE,
> +       .set   = &nf_nat_kfunc_set,
> +};
> +
> +int register_nf_nat_bpf(void)
> +{
> +       int ret;
> +
> +       ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> +                                       &nf_bpf_nat_kfunc_set);
> +       if (ret)
> +               return ret;
> +
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
> +                                        &nf_bpf_nat_kfunc_set);
> +}
> diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
> index 7981be526f26..1ed09c9af5e5 100644
> --- a/net/netfilter/nf_nat_core.c
> +++ b/net/netfilter/nf_nat_core.c
> @@ -1152,7 +1152,7 @@ static int __init nf_nat_init(void)
>         WARN_ON(nf_nat_hook != NULL);
>         RCU_INIT_POINTER(nf_nat_hook, &nat_hook);
>
> -       return 0;
> +       return register_nf_nat_bpf();
>  }
>
>  static void __exit nf_nat_cleanup(void)
> --
> 2.37.3
>


-- 
WBR, Yauheni

