Return-Path: <bpf+bounces-13763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC57DD870
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 23:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE931C20D90
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 22:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B5E27466;
	Tue, 31 Oct 2023 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+30KIRB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485625103;
	Tue, 31 Oct 2023 22:38:41 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1477F4;
	Tue, 31 Oct 2023 15:38:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso50468025e9.2;
        Tue, 31 Oct 2023 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698791918; x=1699396718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yNnFVQiHIMKBbkJdP4Bo88uYPZR71YVjxbz/oPSYuw=;
        b=T+30KIRBjXelxp/eUrY79RSq3lnD4/L/JgiGnYGg4RGo5g6Mx72bHsatzJmAvUFT4z
         Myc5elYlM3vXPRPL2MhKa+ppAUyECudv4Nj1m39lt0Ih5Qgs+wownL3DOutrMTQHORjT
         LFp2E+8enQwTDnDHCXJGWCyXTYN0ag6BT2PDE1tUXJ7OJv10Qde7Vhx4HZgsGcFFdy7I
         Aa2PvmqMir0tofk4IpL4kzodncAg65hDw8iHKauYz8+uZdumfIvx2RWwZA+iuCo5uRah
         /5xFZ1vL1vrS8IRmDJTUI+teE70tms/rYZu9XnaWq9A4+Z1wFqxWPaGHpyBcxitNC74E
         jPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791918; x=1699396718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yNnFVQiHIMKBbkJdP4Bo88uYPZR71YVjxbz/oPSYuw=;
        b=ITToJUzbwVvP3rDxoqCZSkFwMsVT3kLsTd/zUK9sPqOAipW0c9LYBXY2dZh4/V2xLn
         E+YxRVs2hE55Bu5ABQdUC0AedtdX+yXlGH708M/ksS6MUs5vyHEWNG6KQ5X2OjqX6t09
         wwbzLcYR8a5T2IRBJxCvgHLJ5bGq6G0XLtlDP3M1cutBPBlyKHeNV09BN4MOWdV/Piaz
         ECcn/JJ9RM1bM+AIgEeciMw/cEwMf7BffDL4NOey1MqJ9/dYi73bAarEtNV4eunqz76n
         aWACcKe14R9DKihWt8/4kYMG7fk5BqcEe3DxQw0oELIpzwwWOf23daCmEX6QlujafKRy
         jFJA==
X-Gm-Message-State: AOJu0Yw0ZDkRlZwsN3fxXJn8G0DZag0Eqlsgjewmww9BSCPXAcl3b5Di
	CN+9pf1wChaHqfGEIykVWM8Xgq0eavA07+KOEfE=
X-Google-Smtp-Source: AGHT+IFEToQ0jaQCfZXrT3l50xsZYDINQsLq8vB9PcCCTGW9BFC0ZBcZbfg9XiVETDdXg4hLeUrkhPB8IZ36tT+SD7U=
X-Received: by 2002:a05:600c:19d1:b0:401:be5a:989 with SMTP id
 u17-20020a05600c19d100b00401be5a0989mr10650711wmq.23.1698791918006; Tue, 31
 Oct 2023 15:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698431765.git.dxu@dxuuu.xyz> <ee5513e6384696147da9bdccd2e22ea27d690084.1698431765.git.dxu@dxuuu.xyz>
 <CAADnVQ+UUsJvrPp=YhtpwuC6xVWGB=OgwXZwXtHi=2Je6n5a=A@mail.gmail.com> <io26znzyhw4t4drmcqkmvgyykyblxzxpizuntgk5fhqasipfyo@r5tpoqo3djkp>
In-Reply-To: <io26znzyhw4t4drmcqkmvgyykyblxzxpizuntgk5fhqasipfyo@r5tpoqo3djkp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 15:38:26 -0700
Message-ID: <CAADnVQJkfAGG9_868tLW9m-9V2husAaRK5afnrLL1HqaxN_3vQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/6] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Alexei Starovoitov <ast@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	antony.antony@secunet.com, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 3:55=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Alexei,
>
> On Sat, Oct 28, 2023 at 04:49:45PM -0700, Alexei Starovoitov wrote:
> > On Fri, Oct 27, 2023 at 11:46=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrot=
e:
> > >
> > > This commit adds an unstable kfunc helper to access internal xfrm_sta=
te
> > > associated with an SA. This is intended to be used for the upcoming
> > > IPsec pcpu work to assign special pcpu SAs to a particular CPU. In ot=
her
> > > words: for custom software RSS.
> > >
> > > That being said, the function that this kfunc wraps is fairly generic
> > > and used for a lot of xfrm tasks. I'm sure people will find uses
> > > elsewhere over time.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  include/net/xfrm.h        |   9 ++++
> > >  net/xfrm/Makefile         |   1 +
> > >  net/xfrm/xfrm_policy.c    |   2 +
> > >  net/xfrm/xfrm_state_bpf.c | 105 ++++++++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 117 insertions(+)
> > >  create mode 100644 net/xfrm/xfrm_state_bpf.c
> > >
> > > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > > index 98d7aa78adda..ab4cf66480f3 100644
> > > --- a/include/net/xfrm.h
> > > +++ b/include/net/xfrm.h
> > > @@ -2188,4 +2188,13 @@ static inline int register_xfrm_interface_bpf(=
void)
> > >
> > >  #endif
> > >
> > > +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
> > > +int register_xfrm_state_bpf(void);
> > > +#else
> > > +static inline int register_xfrm_state_bpf(void)
> > > +{
> > > +       return 0;
> > > +}
> > > +#endif
> > > +
> > >  #endif /* _NET_XFRM_H */
> > > diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> > > index cd47f88921f5..547cec77ba03 100644
> > > --- a/net/xfrm/Makefile
> > > +++ b/net/xfrm/Makefile
> > > @@ -21,3 +21,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) +=3D xfrm_compat.o
> > >  obj-$(CONFIG_XFRM_IPCOMP) +=3D xfrm_ipcomp.o
> > >  obj-$(CONFIG_XFRM_INTERFACE) +=3D xfrm_interface.o
> > >  obj-$(CONFIG_XFRM_ESPINTCP) +=3D espintcp.o
> > > +obj-$(CONFIG_DEBUG_INFO_BTF) +=3D xfrm_state_bpf.o
> > > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > > index 5cdd3bca3637..62e64fa7ae5c 100644
> > > --- a/net/xfrm/xfrm_policy.c
> > > +++ b/net/xfrm/xfrm_policy.c
> > > @@ -4267,6 +4267,8 @@ void __init xfrm_init(void)
> > >  #ifdef CONFIG_XFRM_ESPINTCP
> > >         espintcp_init();
> > >  #endif
> > > +
> > > +       register_xfrm_state_bpf();
> > >  }
> > >
> > >  #ifdef CONFIG_AUDITSYSCALL
> > > diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
> > > new file mode 100644
> > > index 000000000000..a73a17a6497b
> > > --- /dev/null
> > > +++ b/net/xfrm/xfrm_state_bpf.c
> > > @@ -0,0 +1,105 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Unstable XFRM state BPF helpers.
> > > + *
> > > + * Note that it is allowed to break compatibility for these function=
s since the
> > > + * interface they are exposed through to BPF programs is explicitly =
unstable.
> > > + */
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <linux/btf_ids.h>
> > > +#include <net/xdp.h>
> > > +#include <net/xfrm.h>
> > > +
> > > +/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
> > > + *
> > > + * Members:
> > > + * @error      - Out parameter, set for any errors encountered
> > > + *              Values:
> > > + *                -EINVAL - netns_id is less than -1
> > > + *                -EINVAL - Passed NULL for opts
> > > + *                -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
> > > + *                -ENONET - No network namespace found for netns_id
> > > + * @netns_id   - Specify the network namespace for lookup
> > > + *              Values:
> > > + *                BPF_F_CURRENT_NETNS (-1)
> > > + *                  Use namespace associated with ctx
> > > + *                [0, S32_MAX]
> > > + *                  Network Namespace ID
> > > + * @mark       - XFRM mark to match on
> > > + * @daddr      - Destination address to match on
> > > + * @spi                - Security parameter index to match on
> > > + * @proto      - L3 protocol to match on
> > > + * @family     - L3 protocol family to match on
> > > + */
> > > +struct bpf_xfrm_state_opts {
> > > +       s32 error;
> > > +       s32 netns_id;
> > > +       u32 mark;
> > > +       xfrm_address_t daddr;
> > > +       __be32 spi;
> > > +       u8 proto;
> > > +       u16 family;
> > > +};
> > > +
> > > +enum {
> > > +       BPF_XFRM_STATE_OPTS_SZ =3D sizeof(struct bpf_xfrm_state_opts)=
,
> > > +};
> > > +
> > > +__diag_push();
> > > +__diag_ignore_all("-Wmissing-prototypes",
> > > +                 "Global functions as their definitions will be in x=
frm_state BTF");
> > > +
> > > +/* bpf_xdp_get_xfrm_state - Get XFRM state
> > > + *
> > > + * Parameters:
> > > + * @ctx        - Pointer to ctx (xdp_md) in XDP program
> > > + *                 Cannot be NULL
> > > + * @opts       - Options for lookup (documented above)
> > > + *                 Cannot be NULL
> > > + * @opts__sz   - Length of the bpf_xfrm_state_opts structure
> > > + *                 Must be BPF_XFRM_STATE_OPTS_SZ
> > > + */
> > > +__bpf_kfunc struct xfrm_state *
> > > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opt=
s *opts, u32 opts__sz)
> > > +{
> > > +       struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> > > +       struct net *net =3D dev_net(xdp->rxq->dev);
> > > +
> > > +       if (!opts || opts__sz !=3D BPF_XFRM_STATE_OPTS_SZ) {
> > > +               opts->error =3D -EINVAL;
> > > +               return NULL;
> > > +       }
> > > +
> > > +       if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS)) {
> > > +               opts->error =3D -EINVAL;
> > > +               return NULL;
> > > +       }
> > > +
> > > +       if (opts->netns_id >=3D 0) {
> > > +               net =3D get_net_ns_by_id(net, opts->netns_id);
> > > +               if (unlikely(!net)) {
> > > +                       opts->error =3D -ENONET;
> > > +                       return NULL;
> > > +               }
> > > +       }
> > > +
> > > +       return xfrm_state_lookup(net, opts->mark, &opts->daddr, opts-=
>spi,
> > > +                                opts->proto, opts->family);
> > > +}
> >
> > Patch 6 example does little to explain how this kfunc can be used.
> > Cover letter sounds promising, but no code to demonstrate the result.
>
> Part of the reason for that is this kfunc is intended to be used with a
> not-yet-upstreamed xfrm patchset. The other is that the usage is quite
> trivial. This is the code the experiments were run with:
>
> https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357d6ce2=
863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406
>
> We intend to upstream that cpumap mode to xdp-tools as soon as the xfrm
> patches are in. (Note the linked code is a little buggy but the
> main idea is there).

I don't understand how it survives anything, but sanity check.
To measure perf gains it needs to be under traffic for some time,
but
x =3D bpf_xdp_get_xfrm_state(ctx, &opts, sizeof(opts));
will keep refcnt++ that state for every packet.
Minimum -> memory leak or refcnt overflow.

