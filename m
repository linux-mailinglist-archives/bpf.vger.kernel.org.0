Return-Path: <bpf+bounces-13559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8793D7DAA33
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 01:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43CC1C209F7
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 23:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4419318C10;
	Sat, 28 Oct 2023 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAgyjfAn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A167FD;
	Sat, 28 Oct 2023 23:50:03 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B8ACF;
	Sat, 28 Oct 2023 16:49:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-408425c7c10so26091045e9.0;
        Sat, 28 Oct 2023 16:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698536997; x=1699141797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/C8RdsxmTPE6wff6Gcpqd7wLJY2aX8b3m06UTd80i0=;
        b=QAgyjfAnNngL+dx/G4BVAw1SiSjxt7wgckAsqc4hna5T/hiXtZ9iHo/vmkmdgqfGkj
         TXFO8g20SiQ8G8LHMT8G+BsXmSK8rdeK/+4wy6EvJ7KPRipDmfKu+db8qGg9EkcnrHUh
         nUU74hndalEN11M50/dJr2JU3XYogF17fCiUtNEFH7UuNH3y4O0zg/MUewWmeIzP92v+
         YKUUSiIqgIK5d21C9x4PdZZTRw4xq80b6lBDN4fjO0xzQDQOHkcAivzb1bsnp3amoVbf
         KiS6G7KdsPBtcNmvPsZhZG/OmOdmObznpI0qQUsT3CscHAN2+V8nY8w+ez7/b8XPauq4
         VgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698536997; x=1699141797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/C8RdsxmTPE6wff6Gcpqd7wLJY2aX8b3m06UTd80i0=;
        b=Hm54VAND7BukXAWyG48Pv1DziwUuT+CLWrjeOrYyjWUSFXVpfeux/dksn1yLqd2vXz
         42JQFgztm5VMseyYrnJM/xCMbyGD0jyoVzH8kcgicXq8e42qtLJxBiJ7v59AbAycu5p+
         Tj30CHkvAiYvDIjcwyaVF9SfaIxDPofmMxuAXtkpuBxXYSrT5P3mHO1HGiZcfCl5f7Dx
         s5677HmkQawtRcvF1RqLhkiDXqXsWPTE7/LyeXDgm7d3bXJXMQgh2Lp3gV/Bg9zXI/wx
         fJ81dmn0Um/DHmwzivYddTg+pSzVOkgQzCxcx4i7knd1Xg8VM3Ggt6KQLLTKJGDjuQyD
         77Og==
X-Gm-Message-State: AOJu0Yy4WJlIWM/ZWr8S8YMKjvAG4O5RLL88rHn/oW8P4cklMf5piet/
	tJHwW2HNi+Uh6ks23MYuN8Hxbdn1OKfh+7HBLvc=
X-Google-Smtp-Source: AGHT+IFkLIZdxJqOddVHY2lTFwnf1BOfRen48CuhxfISgFdSg4+7VUC7c/jhVA1PEpvon/ctWj1OWuGWlB//tjjpluM=
X-Received: by 2002:a5d:4049:0:b0:320:8e6:b0cf with SMTP id
 w9-20020a5d4049000000b0032008e6b0cfmr3731864wrp.42.1698536996822; Sat, 28 Oct
 2023 16:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698431765.git.dxu@dxuuu.xyz> <ee5513e6384696147da9bdccd2e22ea27d690084.1698431765.git.dxu@dxuuu.xyz>
In-Reply-To: <ee5513e6384696147da9bdccd2e22ea27d690084.1698431765.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 28 Oct 2023 16:49:45 -0700
Message-ID: <CAADnVQ+UUsJvrPp=YhtpwuC6xVWGB=OgwXZwXtHi=2Je6n5a=A@mail.gmail.com>
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

On Fri, Oct 27, 2023 at 11:46=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit adds an unstable kfunc helper to access internal xfrm_state
> associated with an SA. This is intended to be used for the upcoming
> IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
> words: for custom software RSS.
>
> That being said, the function that this kfunc wraps is fairly generic
> and used for a lot of xfrm tasks. I'm sure people will find uses
> elsewhere over time.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/net/xfrm.h        |   9 ++++
>  net/xfrm/Makefile         |   1 +
>  net/xfrm/xfrm_policy.c    |   2 +
>  net/xfrm/xfrm_state_bpf.c | 105 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 117 insertions(+)
>  create mode 100644 net/xfrm/xfrm_state_bpf.c
>
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 98d7aa78adda..ab4cf66480f3 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -2188,4 +2188,13 @@ static inline int register_xfrm_interface_bpf(void=
)
>
>  #endif
>
> +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
> +int register_xfrm_state_bpf(void);
> +#else
> +static inline int register_xfrm_state_bpf(void)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #endif /* _NET_XFRM_H */
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index cd47f88921f5..547cec77ba03 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) +=3D xfrm_compat.o
>  obj-$(CONFIG_XFRM_IPCOMP) +=3D xfrm_ipcomp.o
>  obj-$(CONFIG_XFRM_INTERFACE) +=3D xfrm_interface.o
>  obj-$(CONFIG_XFRM_ESPINTCP) +=3D espintcp.o
> +obj-$(CONFIG_DEBUG_INFO_BTF) +=3D xfrm_state_bpf.o
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 5cdd3bca3637..62e64fa7ae5c 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4267,6 +4267,8 @@ void __init xfrm_init(void)
>  #ifdef CONFIG_XFRM_ESPINTCP
>         espintcp_init();
>  #endif
> +
> +       register_xfrm_state_bpf();
>  }
>
>  #ifdef CONFIG_AUDITSYSCALL
> diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
> new file mode 100644
> index 000000000000..a73a17a6497b
> --- /dev/null
> +++ b/net/xfrm/xfrm_state_bpf.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Unstable XFRM state BPF helpers.
> + *
> + * Note that it is allowed to break compatibility for these functions si=
nce the
> + * interface they are exposed through to BPF programs is explicitly unst=
able.
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <net/xdp.h>
> +#include <net/xfrm.h>
> +
> +/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
> + *
> + * Members:
> + * @error      - Out parameter, set for any errors encountered
> + *              Values:
> + *                -EINVAL - netns_id is less than -1
> + *                -EINVAL - Passed NULL for opts
> + *                -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
> + *                -ENONET - No network namespace found for netns_id
> + * @netns_id   - Specify the network namespace for lookup
> + *              Values:
> + *                BPF_F_CURRENT_NETNS (-1)
> + *                  Use namespace associated with ctx
> + *                [0, S32_MAX]
> + *                  Network Namespace ID
> + * @mark       - XFRM mark to match on
> + * @daddr      - Destination address to match on
> + * @spi                - Security parameter index to match on
> + * @proto      - L3 protocol to match on
> + * @family     - L3 protocol family to match on
> + */
> +struct bpf_xfrm_state_opts {
> +       s32 error;
> +       s32 netns_id;
> +       u32 mark;
> +       xfrm_address_t daddr;
> +       __be32 spi;
> +       u8 proto;
> +       u16 family;
> +};
> +
> +enum {
> +       BPF_XFRM_STATE_OPTS_SZ =3D sizeof(struct bpf_xfrm_state_opts),
> +};
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "Global functions as their definitions will be in xfrm_=
state BTF");
> +
> +/* bpf_xdp_get_xfrm_state - Get XFRM state
> + *
> + * Parameters:
> + * @ctx        - Pointer to ctx (xdp_md) in XDP program
> + *                 Cannot be NULL
> + * @opts       - Options for lookup (documented above)
> + *                 Cannot be NULL
> + * @opts__sz   - Length of the bpf_xfrm_state_opts structure
> + *                 Must be BPF_XFRM_STATE_OPTS_SZ
> + */
> +__bpf_kfunc struct xfrm_state *
> +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *o=
pts, u32 opts__sz)
> +{
> +       struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> +       struct net *net =3D dev_net(xdp->rxq->dev);
> +
> +       if (!opts || opts__sz !=3D BPF_XFRM_STATE_OPTS_SZ) {
> +               opts->error =3D -EINVAL;
> +               return NULL;
> +       }
> +
> +       if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS)) {
> +               opts->error =3D -EINVAL;
> +               return NULL;
> +       }
> +
> +       if (opts->netns_id >=3D 0) {
> +               net =3D get_net_ns_by_id(net, opts->netns_id);
> +               if (unlikely(!net)) {
> +                       opts->error =3D -ENONET;
> +                       return NULL;
> +               }
> +       }
> +
> +       return xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi=
,
> +                                opts->proto, opts->family);
> +}

Patch 6 example does little to explain how this kfunc can be used.
Cover letter sounds promising, but no code to demonstrate the result.
The main issue is that this kfunc has to be KF_ACQUIRE,
otherwise bpf prog will keep leaking xfrm_state.
Plenty of red flags in this RFC.

