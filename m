Return-Path: <bpf+bounces-13815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4987DE5A0
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 18:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2438A281956
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237018653;
	Wed,  1 Nov 2023 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ju+O9zjV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tB2pIg+5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358F15E83;
	Wed,  1 Nov 2023 17:51:52 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95210A2;
	Wed,  1 Nov 2023 10:51:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 5E7A95C0405;
	Wed,  1 Nov 2023 13:51:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 13:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698861106; x=1698947506; bh=eaeRHsOIThQN1udl/ucOzomysNnXo1Okkum
	+nyz4aiA=; b=ju+O9zjVVtcQ2eEnDL9svFNxQ3gbhZ339N/mkTXLc1Ub5S3/wXe
	NZmwdZ5X+ywRAE7xuaP77lhadr3tNBSNbj6Aib5OH31uFynwzjF/LLXLHSpzeWZw
	rtJYHx+jFi/kqWCp9uudgEvYY+c3LaygLS43iRLwC5o2HrDMqIKLDQE6y4OQ5731
	gHS+k7RvbgNQ2bhYIYmcjXb+LdtN+30WPYLSwQl0MNCPcsyoh/zMV8txbS+kVQW2
	XndgDDISbuuUHlFgFPc19ijrzCqfgMi1xfUP3DJzFs/IWe+V+MXhneTy6f9TKIw0
	A7KdQZkIarxMIJ+Op2Sol1hY7J0g088HjEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698861106; x=1698947506; bh=eaeRHsOIThQN1udl/ucOzomysNnXo1Okkum
	+nyz4aiA=; b=tB2pIg+5tQ1Y57S0WTlOe2T9mC+86F0DQ21rw2s83N99oFWNAIH
	TiFcU9VAht4T+oQCOcqMu8dLcId7lexrFF6FW6uJSQK5+i7OP6Bosf3/Oq+W//EX
	OQrLVS7KbP2NmFkelm7BvTNm6uwn9PtaZ8Gw0hqsQv3BDjkvf/R39eSkms4PS8tk
	Eb1/64MwmhJzoov+LsVxSWZu6zmRbBKcPLdolp3nIK5lY+EomoqazWi/L4nsresL
	qvZ/kB18FRcV9lYPS3RHdLGpVauaPxJwDQsH3/TaRXDkgtqtbhP7v97y/fdDCr9O
	T1AB04460oqL39yuPOhTSOXBKmAdZLDKE7g==
X-ME-Sender: <xms:L5BCZarapNLr64U7VnDOqjcXnONKr1N9NSqro-sJgu4QjEYknVq20A>
    <xme:L5BCZYryUxWZu6pO0SyMHwnHS8FvdLDo-lyiIzVgBFwSjgxUxM4Rsh0tM8XbdkhCz
    AbbcvvFXy546myD_g>
X-ME-Received: <xmr:L5BCZfOYPruQ50VHfVygT2zjxnRNxBv6hglhPBpMUwWxwbehHNm6YP0grRk6tpDx0e2K_n5yi2QxjQ1vjCt8H7kw2Hh9001xfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhepffffgeegkeejvdejgeehteekudfhgfefgeevkeelhfeg
    ueeljefhleejtdekveffnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:L5BCZZ7d-PWgoO3PLSCv_YYzM3FUom7vpxZYnK8zXbxY7n9UHB2V4Q>
    <xmx:L5BCZZ4U_t_sl_TmsjKtjjp3C1NYZPI5GNdfW0jevICykYJ3UJwe7Q>
    <xmx:L5BCZZhXQyyJCIy6BeY1WMF5kFsMi9dG8LuD8YAYLrPu-Vuo8OHVig>
    <xmx:MpBCZYRo_I-HDkfuEwl8hv06FG6uQwj15r3CooE5JLbjRNb_kU_vnA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 13:51:42 -0400 (EDT)
Date: Wed, 1 Nov 2023 11:51:41 -0600
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
Message-ID: <fzgysfsfgeqq3tzy2yqrqjibu542qtfi75fcnbxkivsiajaiys@ddd4vftvtwse>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
 <ee5513e6384696147da9bdccd2e22ea27d690084.1698431765.git.dxu@dxuuu.xyz>
 <CAADnVQ+UUsJvrPp=YhtpwuC6xVWGB=OgwXZwXtHi=2Je6n5a=A@mail.gmail.com>
 <io26znzyhw4t4drmcqkmvgyykyblxzxpizuntgk5fhqasipfyo@r5tpoqo3djkp>
 <CAADnVQJkfAGG9_868tLW9m-9V2husAaRK5afnrLL1HqaxN_3vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJkfAGG9_868tLW9m-9V2husAaRK5afnrLL1HqaxN_3vQ@mail.gmail.com>

On Tue, Oct 31, 2023 at 03:38:26PM -0700, Alexei Starovoitov wrote:
> On Sun, Oct 29, 2023 at 3:55 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi Alexei,
> >
> > On Sat, Oct 28, 2023 at 04:49:45PM -0700, Alexei Starovoitov wrote:
> > > On Fri, Oct 27, 2023 at 11:46 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > >
> > > > This commit adds an unstable kfunc helper to access internal xfrm_state
> > > > associated with an SA. This is intended to be used for the upcoming
> > > > IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
> > > > words: for custom software RSS.
> > > >
> > > > That being said, the function that this kfunc wraps is fairly generic
> > > > and used for a lot of xfrm tasks. I'm sure people will find uses
> > > > elsewhere over time.
> > > >
> > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > ---
> > > >  include/net/xfrm.h        |   9 ++++
> > > >  net/xfrm/Makefile         |   1 +
> > > >  net/xfrm/xfrm_policy.c    |   2 +
> > > >  net/xfrm/xfrm_state_bpf.c | 105 ++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 117 insertions(+)
> > > >  create mode 100644 net/xfrm/xfrm_state_bpf.c
> > > >
> > > > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > > > index 98d7aa78adda..ab4cf66480f3 100644
> > > > --- a/include/net/xfrm.h
> > > > +++ b/include/net/xfrm.h
> > > > @@ -2188,4 +2188,13 @@ static inline int register_xfrm_interface_bpf(void)
> > > >
> > > >  #endif
> > > >
> > > > +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
> > > > +int register_xfrm_state_bpf(void);
> > > > +#else
> > > > +static inline int register_xfrm_state_bpf(void)
> > > > +{
> > > > +       return 0;
> > > > +}
> > > > +#endif
> > > > +
> > > >  #endif /* _NET_XFRM_H */
> > > > diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> > > > index cd47f88921f5..547cec77ba03 100644
> > > > --- a/net/xfrm/Makefile
> > > > +++ b/net/xfrm/Makefile
> > > > @@ -21,3 +21,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
> > > >  obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
> > > >  obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
> > > >  obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
> > > > +obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
> > > > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > > > index 5cdd3bca3637..62e64fa7ae5c 100644
> > > > --- a/net/xfrm/xfrm_policy.c
> > > > +++ b/net/xfrm/xfrm_policy.c
> > > > @@ -4267,6 +4267,8 @@ void __init xfrm_init(void)
> > > >  #ifdef CONFIG_XFRM_ESPINTCP
> > > >         espintcp_init();
> > > >  #endif
> > > > +
> > > > +       register_xfrm_state_bpf();
> > > >  }
> > > >
> > > >  #ifdef CONFIG_AUDITSYSCALL
> > > > diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
> > > > new file mode 100644
> > > > index 000000000000..a73a17a6497b
> > > > --- /dev/null
> > > > +++ b/net/xfrm/xfrm_state_bpf.c
> > > > @@ -0,0 +1,105 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/* Unstable XFRM state BPF helpers.
> > > > + *
> > > > + * Note that it is allowed to break compatibility for these functions since the
> > > > + * interface they are exposed through to BPF programs is explicitly unstable.
> > > > + */
> > > > +
> > > > +#include <linux/bpf.h>
> > > > +#include <linux/btf_ids.h>
> > > > +#include <net/xdp.h>
> > > > +#include <net/xfrm.h>
> > > > +
> > > > +/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
> > > > + *
> > > > + * Members:
> > > > + * @error      - Out parameter, set for any errors encountered
> > > > + *              Values:
> > > > + *                -EINVAL - netns_id is less than -1
> > > > + *                -EINVAL - Passed NULL for opts
> > > > + *                -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
> > > > + *                -ENONET - No network namespace found for netns_id
> > > > + * @netns_id   - Specify the network namespace for lookup
> > > > + *              Values:
> > > > + *                BPF_F_CURRENT_NETNS (-1)
> > > > + *                  Use namespace associated with ctx
> > > > + *                [0, S32_MAX]
> > > > + *                  Network Namespace ID
> > > > + * @mark       - XFRM mark to match on
> > > > + * @daddr      - Destination address to match on
> > > > + * @spi                - Security parameter index to match on
> > > > + * @proto      - L3 protocol to match on
> > > > + * @family     - L3 protocol family to match on
> > > > + */
> > > > +struct bpf_xfrm_state_opts {
> > > > +       s32 error;
> > > > +       s32 netns_id;
> > > > +       u32 mark;
> > > > +       xfrm_address_t daddr;
> > > > +       __be32 spi;
> > > > +       u8 proto;
> > > > +       u16 family;
> > > > +};
> > > > +
> > > > +enum {
> > > > +       BPF_XFRM_STATE_OPTS_SZ = sizeof(struct bpf_xfrm_state_opts),
> > > > +};
> > > > +
> > > > +__diag_push();
> > > > +__diag_ignore_all("-Wmissing-prototypes",
> > > > +                 "Global functions as their definitions will be in xfrm_state BTF");
> > > > +
> > > > +/* bpf_xdp_get_xfrm_state - Get XFRM state
> > > > + *
> > > > + * Parameters:
> > > > + * @ctx        - Pointer to ctx (xdp_md) in XDP program
> > > > + *                 Cannot be NULL
> > > > + * @opts       - Options for lookup (documented above)
> > > > + *                 Cannot be NULL
> > > > + * @opts__sz   - Length of the bpf_xfrm_state_opts structure
> > > > + *                 Must be BPF_XFRM_STATE_OPTS_SZ
> > > > + */
> > > > +__bpf_kfunc struct xfrm_state *
> > > > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32 opts__sz)
> > > > +{
> > > > +       struct xdp_buff *xdp = (struct xdp_buff *)ctx;
> > > > +       struct net *net = dev_net(xdp->rxq->dev);
> > > > +
> > > > +       if (!opts || opts__sz != BPF_XFRM_STATE_OPTS_SZ) {
> > > > +               opts->error = -EINVAL;
> > > > +               return NULL;
> > > > +       }
> > > > +
> > > > +       if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS)) {
> > > > +               opts->error = -EINVAL;
> > > > +               return NULL;
> > > > +       }
> > > > +
> > > > +       if (opts->netns_id >= 0) {
> > > > +               net = get_net_ns_by_id(net, opts->netns_id);
> > > > +               if (unlikely(!net)) {
> > > > +                       opts->error = -ENONET;
> > > > +                       return NULL;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       return xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi,
> > > > +                                opts->proto, opts->family);
> > > > +}
> > >
> > > Patch 6 example does little to explain how this kfunc can be used.
> > > Cover letter sounds promising, but no code to demonstrate the result.
> >
> > Part of the reason for that is this kfunc is intended to be used with a
> > not-yet-upstreamed xfrm patchset. The other is that the usage is quite
> > trivial. This is the code the experiments were run with:
> >
> > https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357d6ce2863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406
> >
> > We intend to upstream that cpumap mode to xdp-tools as soon as the xfrm
> > patches are in. (Note the linked code is a little buggy but the
> > main idea is there).
> 
> I don't understand how it survives anything, but sanity check.
> To measure perf gains it needs to be under traffic for some time,
> but
> x = bpf_xdp_get_xfrm_state(ctx, &opts, sizeof(opts));
> will keep refcnt++ that state for every packet.
> Minimum -> memory leak or refcnt overflow.

Yeah, I agree the code in this patchset is not correct. I have the fix
(a KF_RELEASE wrapper around xfrm_state_put()) ready to send. I think
Steffen was gonna chat w/ you about this at IETF next week. But I can
send it now if you'd like.

To answer your question why it doesn't blow up immediately:

* The test system only has ~33 inbound SAs and the test doesn't try to
  delete any. So leak is not noticed in the test. Oddly enough I recall
  `ip x s flush` working correctly... Could be misremembering.

* Refcnt overflow will indeed happen, but some rough math shows it'll
  take about 12 hrs receiving at 100Gbps for that to happen. 100Gbps =
  12.5 GB/s. 12.5GB / (32 CPUs) / (9000B) = 43k pps for each pcpu SA.
  INT_MAX = 2 billion. 2B / 4k = 46k. 46k seconds to hours is ~12 hrs.
  And I was only running traffic for ~1 hour.

At least I think that math is right.

Thanks,
Daniel

