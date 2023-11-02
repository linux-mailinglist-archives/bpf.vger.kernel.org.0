Return-Path: <bpf+bounces-13877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D147DE9FE
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 02:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC372B211AB
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD415BA;
	Thu,  2 Nov 2023 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh36X+0Z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83910E7;
	Thu,  2 Nov 2023 01:27:20 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACE2B9;
	Wed,  1 Nov 2023 18:27:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso8621835e9.0;
        Wed, 01 Nov 2023 18:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698888435; x=1699493235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm/7OFBSoips3tnbFo8g5Iu+aRQyE9BXKI+0RALQB2s=;
        b=hh36X+0ZgVfPXzVoEbmb//7/o5unnfqW+PXrw2ImucT0ffEQjykB6Dcv+3K8LbFkTP
         z+viv5+gPhIBG4MkxX+gHpzF7Erfphtv6cqGO6y9dwu0045GWRoZnz1y4rHDCOzvVTtJ
         /O3srxPjmtat3UwD80+W7rNpcyME8+PD+el8OHvEZvOcXUWl9WW1jmGtbKeummRh5yQh
         MI66FK0/y1hT2ib0/mlPq6FqHZR330HzX0qR47jPttE1+63DS8X/lvQPCHiy/JhgXm0x
         7MkfRkaNgUmKWRiCIl+8ZaEt+2l2a8/bjldcviedmTuABKPX8v4jKthoBlhpnwymRewH
         IA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698888435; x=1699493235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm/7OFBSoips3tnbFo8g5Iu+aRQyE9BXKI+0RALQB2s=;
        b=l2lkr0pRGF1Zt3+tYxY4vj1Q8Niz7DhQIuNdtkhyH/48sVfXWVuJbCmF9dpe7eyIyr
         fCBbG/QLiFwZuin/Cn1V4emvOISPVSn5gtU42GjqPrTZ9tSA0bvrUA41uppiWZBgafzz
         wU2T0gYzzNLIFzvTNaG+3LwETWHEMzKZ36vfXWJ1dItdZU2gdherooUNotOkGEHfsnxU
         RKnQ6AiuebAHGwVEhw97l9pTuH1q7IJznxOBYwf4BUR3PU8EbrBI9sBfGZ7GGUJoMoA4
         IVbWf/yqKj38rVUumTzITi2qpgU7TpSLFbAUq4qfCkAMLG2kXl1oOmx1UmSeC0F3st+b
         roug==
X-Gm-Message-State: AOJu0YzD18uZ3sFRYXLnhbBpHpl6lTkeTFilAzXEU2jRapQjjRWjoEYl
	/vp2M5WRvvRgTDzFRJEJGfEts6ua4JZwQYi3t7c=
X-Google-Smtp-Source: AGHT+IHj/G3eivIIeS4ybijd2Nw580bsygvI2ppnmzqjYuBfD5cWVeVQMU0I52I82q92r002zXMT32kkGW7PhXK6HPQ=
X-Received: by 2002:a05:6000:1867:b0:32d:9d03:29e6 with SMTP id
 d7-20020a056000186700b0032d9d0329e6mr9894030wri.27.1698888434551; Wed, 01 Nov
 2023 18:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698875025.git.dxu@dxuuu.xyz> <0a5dc090a098b911bdd19ed0e63c7e466f7054f6.1698875025.git.dxu@dxuuu.xyz>
In-Reply-To: <0a5dc090a098b911bdd19ed0e63c7e466f7054f6.1698875025.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Nov 2023 18:27:03 -0700
Message-ID: <CAADnVQJu27HZGaTH5046Smwjpn-ttVCRR7f_0B12es_juZiN5w@mail.gmail.com>
Subject: Re: [RFCv2 bpf-next 1/7] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, antony.antony@secunet.com, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 2:58=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
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
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
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
> index c9bb0f892f55..1d107241b901 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -2190,4 +2190,13 @@ static inline int register_xfrm_interface_bpf(void=
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
> index c13dc3ef7910..1b7e75159727 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4218,6 +4218,8 @@ void __init xfrm_init(void)
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
> index 000000000000..4aaac134b97a
> --- /dev/null
> +++ b/net/xfrm/xfrm_state_bpf.c

since net/xfrm/xfrm_interface_bpf.c is already there and
was meant to be use as a file for interface between xfrm and bpf
may be add new kfuncs there instead of new file?


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

netns is leaking :(

> +               if (unlikely(!net)) {
> +                       opts->error =3D -ENONET;
> +                       return NULL;
> +               }
> +       }
> +
> +       return xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi=
,
> +                                opts->proto, opts->family);

After looking into xfrm internals realized that
refcnt inc/dec and KF_ACQUIRE maybe unnecessary overhead.
XDP progs run under rcu_read_lock.
I think you can make a version of __xfrm_state_lookup()
without xfrm_state_hold_rcu() and avoid two atomics per packet,
but such xfrm_state may have refcnt=3D=3D0.
Since bpf prog will only read from there and won't pass it anywhere
else it might be ok.

But considering the rest of ipsec overhead this might be
a premature optimization and it's better to stay with clean
acquire/release semantics.


As far as IETF:
https://datatracker.ietf.org/doc/html/draft-ietf-ipsecme-multi-sa-performan=
ce-02
it's not clear to me why one Child SA (without new pcpu field)
has to be handled by one cpu.

Sounds like it's possible to implement differently. At least in SW.
In HW, I can see how duplicating multiple crypto state and the rest
in a single queue is difficult.

