Return-Path: <bpf+bounces-13585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A17DAF1E
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 23:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94CA28101B
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D9B12E6C;
	Sun, 29 Oct 2023 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="VyQ3s6uJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwrfeDNE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115C12E51;
	Sun, 29 Oct 2023 22:56:21 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D602C26AD;
	Sun, 29 Oct 2023 15:55:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 90FD95C00FF;
	Sun, 29 Oct 2023 18:55:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 29 Oct 2023 18:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698620143; x=1698706543; bh=Ojv0xXhmC6UvWmXfFmEGeOiFIHR8QBj2HEs
	0AJdBuXw=; b=VyQ3s6uJj8sHu2Yqu3zXXg6+h593DAKTAbF/5u+oKv00FezWOWT
	gZp5mXJ4B/Zq1uIrYw2FdX4CrCdg1BCFq3oYSVaB2SBq1ikKzO3t5mpLbSFM1Qy6
	kCNZH14IqEfOXHbUWofJX7ocAMrPE1zCvqJg6XYeSpYmcd91r0apYOdNoBn6Yeu/
	DEIZoXzlSSm0pjxXiX3eZfyRb7SZaHzCxsj0DCJ2u/wKujcLv+4WLemql2RR2Fa2
	gYmBlqIXqN9ioPIyJV3mJb+VxMjnTAv2ZcvxhA8j3Duu0b4rBBZoMPuWfW7b/HRU
	zWqFz7YiBlfwICStO7VDRa/ur/Q40flFe8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698620143; x=1698706543; bh=Ojv0xXhmC6UvWmXfFmEGeOiFIHR8QBj2HEs
	0AJdBuXw=; b=MwrfeDNEsRQYmvFdDaXgAVfJBL3iBBM9jqyRk7E0UGYfehBMFDK
	f/Z1RrXA9XpnXpR4rDtnXqRu9SgLrz+S0uF6jBcEo5JDUyEfDTTi1wF7WQXwMpL6
	qkcz2jg6SC731JcA5tLS+B0tATSoxbzDDDLdj3RMP8qBN2dK7uZw2MxAShMMx5DN
	ma8AlciXh5Azwox6Fon3ivxD9OYUMIiWZAgYqWSIB8Q/4xDnwwZ97VorbEB6CN8N
	g9CJSyWAKYo3P51vdnPnZf3cWV+eBKNtAALRRVIeOIuTWyE0JlWG4nk+cABZDCHF
	6HjYI+3avT8OBt5p+LiePKUnqM+xVmUp28w==
X-ME-Sender: <xms:7uI-Zch1DJB3GWAGQCgD1sfhKErRS6AkLJTPbhv_VcDwwTCibeznYg>
    <xme:7uI-ZVDyddMTUY6Elg77WmozbEpxQwVcEql2U07AIaF5o7xbFscwKrzTtP_kLe08X
    leiOoAEPdamSODq5w>
X-ME-Received: <xmr:7uI-ZUFkDLqnLJbIDgrUByiX8sjlqdMHBPg-_OtWldn5RIvpkfRCfxLW4xGJOjbLzjpmgrDjfevv8NRK_CfqiIvZDNMebtjj71eIE_3-XoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleelgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepieetkeegfeeujefgkeevleelffduleejkedtueekveeuueeg
    feegueeffeelhfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpugiguhhuuhdrgi
    ihiienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    gihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:7uI-ZdSBKGhV_8y_-NYlnhIMRGCErfncEg3datJPiRHsNbCIR1Ld4A>
    <xmx:7uI-ZZyDl4GIYkXTKRi7CzvLgvkHLn0GD3hlu69S84a060i-iGPe6Q>
    <xmx:7uI-Zb7Nd2qzSY-AZP-FCCYO7Z-e0_X4oMnAIuKRJ43O4sbpc_e3EA>
    <xmx:7-I-ZeL8BtmiN5g0x4tWYYb1HTbGYn7leNkIhYY7chBCsBUko8BapQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 18:55:40 -0400 (EDT)
Date: Sun, 29 Oct 2023 16:55:39 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Alexei Starovoitov <ast@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Kicinski <kuba@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, antony.antony@secunet.com, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, devel@linux-ipsec.org
Subject: Re: [RFC bpf-next 1/6] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
Message-ID: <io26znzyhw4t4drmcqkmvgyykyblxzxpizuntgk5fhqasipfyo@r5tpoqo3djkp>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
 <ee5513e6384696147da9bdccd2e22ea27d690084.1698431765.git.dxu@dxuuu.xyz>
 <CAADnVQ+UUsJvrPp=YhtpwuC6xVWGB=OgwXZwXtHi=2Je6n5a=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+UUsJvrPp=YhtpwuC6xVWGB=OgwXZwXtHi=2Je6n5a=A@mail.gmail.com>

Hi Alexei,

On Sat, Oct 28, 2023 at 04:49:45PM -0700, Alexei Starovoitov wrote:
> On Fri, Oct 27, 2023 at 11:46 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This commit adds an unstable kfunc helper to access internal xfrm_state
> > associated with an SA. This is intended to be used for the upcoming
> > IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
> > words: for custom software RSS.
> >
> > That being said, the function that this kfunc wraps is fairly generic
> > and used for a lot of xfrm tasks. I'm sure people will find uses
> > elsewhere over time.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  include/net/xfrm.h        |   9 ++++
> >  net/xfrm/Makefile         |   1 +
> >  net/xfrm/xfrm_policy.c    |   2 +
> >  net/xfrm/xfrm_state_bpf.c | 105 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 117 insertions(+)
> >  create mode 100644 net/xfrm/xfrm_state_bpf.c
> >
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 98d7aa78adda..ab4cf66480f3 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -2188,4 +2188,13 @@ static inline int register_xfrm_interface_bpf(void)
> >
> >  #endif
> >
> > +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
> > +int register_xfrm_state_bpf(void);
> > +#else
> > +static inline int register_xfrm_state_bpf(void)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >  #endif /* _NET_XFRM_H */
> > diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> > index cd47f88921f5..547cec77ba03 100644
> > --- a/net/xfrm/Makefile
> > +++ b/net/xfrm/Makefile
> > @@ -21,3 +21,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
> >  obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
> >  obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
> >  obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
> > +obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index 5cdd3bca3637..62e64fa7ae5c 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -4267,6 +4267,8 @@ void __init xfrm_init(void)
> >  #ifdef CONFIG_XFRM_ESPINTCP
> >         espintcp_init();
> >  #endif
> > +
> > +       register_xfrm_state_bpf();
> >  }
> >
> >  #ifdef CONFIG_AUDITSYSCALL
> > diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
> > new file mode 100644
> > index 000000000000..a73a17a6497b
> > --- /dev/null
> > +++ b/net/xfrm/xfrm_state_bpf.c
> > @@ -0,0 +1,105 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Unstable XFRM state BPF helpers.
> > + *
> > + * Note that it is allowed to break compatibility for these functions since the
> > + * interface they are exposed through to BPF programs is explicitly unstable.
> > + */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf_ids.h>
> > +#include <net/xdp.h>
> > +#include <net/xfrm.h>
> > +
> > +/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
> > + *
> > + * Members:
> > + * @error      - Out parameter, set for any errors encountered
> > + *              Values:
> > + *                -EINVAL - netns_id is less than -1
> > + *                -EINVAL - Passed NULL for opts
> > + *                -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
> > + *                -ENONET - No network namespace found for netns_id
> > + * @netns_id   - Specify the network namespace for lookup
> > + *              Values:
> > + *                BPF_F_CURRENT_NETNS (-1)
> > + *                  Use namespace associated with ctx
> > + *                [0, S32_MAX]
> > + *                  Network Namespace ID
> > + * @mark       - XFRM mark to match on
> > + * @daddr      - Destination address to match on
> > + * @spi                - Security parameter index to match on
> > + * @proto      - L3 protocol to match on
> > + * @family     - L3 protocol family to match on
> > + */
> > +struct bpf_xfrm_state_opts {
> > +       s32 error;
> > +       s32 netns_id;
> > +       u32 mark;
> > +       xfrm_address_t daddr;
> > +       __be32 spi;
> > +       u8 proto;
> > +       u16 family;
> > +};
> > +
> > +enum {
> > +       BPF_XFRM_STATE_OPTS_SZ = sizeof(struct bpf_xfrm_state_opts),
> > +};
> > +
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +                 "Global functions as their definitions will be in xfrm_state BTF");
> > +
> > +/* bpf_xdp_get_xfrm_state - Get XFRM state
> > + *
> > + * Parameters:
> > + * @ctx        - Pointer to ctx (xdp_md) in XDP program
> > + *                 Cannot be NULL
> > + * @opts       - Options for lookup (documented above)
> > + *                 Cannot be NULL
> > + * @opts__sz   - Length of the bpf_xfrm_state_opts structure
> > + *                 Must be BPF_XFRM_STATE_OPTS_SZ
> > + */
> > +__bpf_kfunc struct xfrm_state *
> > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32 opts__sz)
> > +{
> > +       struct xdp_buff *xdp = (struct xdp_buff *)ctx;
> > +       struct net *net = dev_net(xdp->rxq->dev);
> > +
> > +       if (!opts || opts__sz != BPF_XFRM_STATE_OPTS_SZ) {
> > +               opts->error = -EINVAL;
> > +               return NULL;
> > +       }
> > +
> > +       if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS)) {
> > +               opts->error = -EINVAL;
> > +               return NULL;
> > +       }
> > +
> > +       if (opts->netns_id >= 0) {
> > +               net = get_net_ns_by_id(net, opts->netns_id);
> > +               if (unlikely(!net)) {
> > +                       opts->error = -ENONET;
> > +                       return NULL;
> > +               }
> > +       }
> > +
> > +       return xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi,
> > +                                opts->proto, opts->family);
> > +}
> 
> Patch 6 example does little to explain how this kfunc can be used.
> Cover letter sounds promising, but no code to demonstrate the result.

Part of the reason for that is this kfunc is intended to be used with a
not-yet-upstreamed xfrm patchset. The other is that the usage is quite
trivial. This is the code the experiments were run with:

https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357d6ce2863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406

We intend to upstream that cpumap mode to xdp-tools as soon as the xfrm
patches are in. (Note the linked code is a little buggy but the
main idea is there).

Depending on your appetite for complex diagrams, I can also offer you a
sequence diagram that describes how everything fits together:

https://dxuuu.xyz/r/ipsec-pcpu.png

The TLDR is that all the magic comes from xfrm subsystem. This kfunc
just enables software RSS.

> The main issue is that this kfunc has to be KF_ACQUIRE,
> otherwise bpf prog will keep leaking xfrm_state.
> Plenty of red flags in this RFC.

Ack, will check on KF_ACQUIRE.

Thanks,
Daniel

