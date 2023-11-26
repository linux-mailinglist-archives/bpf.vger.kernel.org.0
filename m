Return-Path: <bpf+bounces-15866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB257F914F
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 05:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE79C1C20C2B
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 04:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4ED23CE;
	Sun, 26 Nov 2023 04:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="MHIiThcV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDUFjvhk"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEFD110;
	Sat, 25 Nov 2023 20:38:22 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 61BA75C0194;
	Sat, 25 Nov 2023 23:38:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 25 Nov 2023 23:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1700973501; x=1701059901; bh=yr
	LXPMHi24LCFKMdUZ11G2Ag/QYAI/E5WnYexGYjqZ4=; b=MHIiThcVdorTBcRmJ+
	nxPSpex22ZcWAJ2uHWiPrA+4uphlwn3vjiCp0BReaKEK5g8SEj17qyPSnMmOLAnE
	6nBEEmJmsCvfsQrlsehdcSmW8EULbFBAciiHV8l9ensyANNvBvzjqHuJo8Y0MYeG
	1Qknmxi5PUaWdq8NIZGEsrJAEjg8VDUWc7NufcDWITwlnZ43SAXgePNW8cCEZyuu
	LCX1e/eR0ud7FLBRdTNdXNDofpiWxX3tYgp1KeocusKD1O1dlJGWjzJ1GocvDG0I
	7fv/gp+Ay9PTf3PCnjvrWdycsM4+QhNVwI90COFjTxv2soKBXhQW81gRia3jjHNV
	wXTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700973501; x=1701059901; bh=yrLXPMHi24LCF
	KMdUZ11G2Ag/QYAI/E5WnYexGYjqZ4=; b=SDUFjvhk0c3HELSBvoLhM9JGv9McS
	lQd7PzECovKiyA+1rx4MmgpB2mMCep4Dmq4cTInPOeyNrARzI9/b6Mh7kfbEr27f
	NEQFLY/4W47C60ZFaTkcIB7u9okD3+Vjk2XYSSnpmvXN6BRvMs0IUwe0GLlFmsvQ
	vGpc2i9OPUgPOgsHu/aL8ifHmAjARc/U6BzqbZc2b7XPQOVTMsLwxBPdWFIaPj9c
	hDj9rkDYx2i8mEKIpJ4zKql0eM2pLA3err9b/GwSQ5MYLVKLwvZmPzZs3XlYZCtn
	ICwnBR/ZBXVU007NTYOCABZ55m5BtjGpiTqnQYvmjymCVz6gciq2NuO/A==
X-ME-Sender: <xms:vMtiZaI7AG0UsuVm4UXbv3ba12Ywr_yVLSRQJVk0m4MH8jPZQX4nJg>
    <xme:vMtiZSIM-1v0izo4q3VuwqV05ZxmhmA3E8uY1wNEosofuS7VwJIMS8M0G9ZJbKY_u
    XDGum9vvmZ4N2CoHQ>
X-ME-Received: <xmr:vMtiZasOg1mAh2y5B2TUI1EFK-Tf4DCLlNpZf6S89oU3iHOOCTUfECZK9LBvkGkw7NkhEzb1-zgx1XPEES7pgyrzR0xEmp-0UfqTc0gSHY-pIvPTwkGmQNwYMys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:vMtiZfZMgvBjSooi02aofwkgSSw2Bli6uBvvoitZvV9_TB7POpXOcg>
    <xmx:vMtiZRaNq_vPZ1a62RTRitDQt718MGyEgIfUXGweQ73b9gan3V9FyQ>
    <xmx:vMtiZbBy--1fF0aHFPFTfrnpjGGoWBby3CyXch_4-5NOxm-PFf9Kig>
    <xmx:vctiZaIsgNE37sb92llXz9Ep9BMIxo-Sgu6QgUddkKhnu2Nu6C2zuQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Nov 2023 23:38:19 -0500 (EST)
Date: Sat, 25 Nov 2023 22:38:18 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: john.fastabend@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>, 
	davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net, pabeni@redhat.com, 
	hawk@kernel.org, kuba@kernel.org, edumazet@google.com, 
	steffen.klassert@secunet.com, antony.antony@secunet.com, alexei.starovoitov@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v1 1/7] bpf: xfrm: Add
 bpf_xdp_get_xfrm_state() kfunc
Message-ID: <fkwti7loufn3rc5ecwid5nvhbvxjdxuo5yeztyolyd2376cqu4@ev3g3dsn5kdk>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <2443b6093691c7ae9dace98b0257f61ff2ff30ec.1700676682.git.dxu@dxuuu.xyz>
 <0e72fb5b-2e26-4c28-b139-68203cd72e59@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e72fb5b-2e26-4c28-b139-68203cd72e59@linux.dev>

On Sat, Nov 25, 2023 at 12:36:29PM -0800, Yonghong Song wrote:
> 
> On 11/22/23 1:20 PM, Daniel Xu wrote:
> > This commit adds an unstable kfunc helper to access internal xfrm_state
> > associated with an SA. This is intended to be used for the upcoming
> > IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
> > words: for custom software RSS.
> > 
> > That being said, the function that this kfunc wraps is fairly generic
> > and used for a lot of xfrm tasks. I'm sure people will find uses
> > elsewhere over time.
> > 
> > Co-developed-by: Antony Antony <antony.antony@secunet.com>
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >   include/net/xfrm.h        |   9 ++++
> >   net/xfrm/Makefile         |   1 +
> >   net/xfrm/xfrm_policy.c    |   2 +
> >   net/xfrm/xfrm_state_bpf.c | 111 ++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 123 insertions(+)
> >   create mode 100644 net/xfrm/xfrm_state_bpf.c
> > 
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index c9bb0f892f55..1d107241b901 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -2190,4 +2190,13 @@ static inline int register_xfrm_interface_bpf(void)
> >   #endif
> > +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
> > +int register_xfrm_state_bpf(void);
> > +#else
> > +static inline int register_xfrm_state_bpf(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >   #endif	/* _NET_XFRM_H */
> > diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> > index cd47f88921f5..547cec77ba03 100644
> > --- a/net/xfrm/Makefile
> > +++ b/net/xfrm/Makefile
> > @@ -21,3 +21,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
> >   obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
> >   obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
> >   obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
> > +obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index c13dc3ef7910..1b7e75159727 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -4218,6 +4218,8 @@ void __init xfrm_init(void)
> >   #ifdef CONFIG_XFRM_ESPINTCP
> >   	espintcp_init();
> >   #endif
> > +
> > +	register_xfrm_state_bpf();
> >   }
> >   #ifdef CONFIG_AUDITSYSCALL
> > diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
> > new file mode 100644
> > index 000000000000..0c1f2f91125c
> > --- /dev/null
> > +++ b/net/xfrm/xfrm_state_bpf.c
> > @@ -0,0 +1,111 @@
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
> > + *		 Values:
> > + *		   -EINVAL - netns_id is less than -1
> > + *		   -EINVAL - Passed NULL for opts
> > + *		   -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
> > + *		   -ENONET - No network namespace found for netns_id
> > + * @netns_id	- Specify the network namespace for lookup
> > + *		 Values:
> > + *		   BPF_F_CURRENT_NETNS (-1)
> > + *		     Use namespace associated with ctx
> > + *		   [0, S32_MAX]
> > + *		     Network Namespace ID
> > + * @mark	- XFRM mark to match on
> > + * @daddr	- Destination address to match on
> > + * @spi		- Security parameter index to match on
> > + * @proto	- L3 protocol to match on
> > + * @family	- L3 protocol family to match on
> > + */
> > +struct bpf_xfrm_state_opts {
> > +	s32 error;
> > +	s32 netns_id;
> > +	u32 mark;
> > +	xfrm_address_t daddr;
> > +	__be32 spi;
> > +	u8 proto;
> > +	u16 family;
> > +};
> > +
> > +enum {
> > +	BPF_XFRM_STATE_OPTS_SZ = sizeof(struct bpf_xfrm_state_opts),
> > +};
> > +
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +		  "Global functions as their definitions will be in xfrm_state BTF");
> > +
> > +/* bpf_xdp_get_xfrm_state - Get XFRM state
> > + *
> > + * Parameters:
> > + * @ctx 	- Pointer to ctx (xdp_md) in XDP program
> > + *		    Cannot be NULL
> > + * @opts	- Options for lookup (documented above)
> > + *		    Cannot be NULL
> > + * @opts__sz	- Length of the bpf_xfrm_state_opts structure
> > + *		    Must be BPF_XFRM_STATE_OPTS_SZ
> > + */
> > +__bpf_kfunc struct xfrm_state *
> > +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32 opts__sz)
> > +{
> > +	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
> > +	struct net *net = dev_net(xdp->rxq->dev);
> > +	struct xfrm_state *x;
> > +
> > +	if (!opts || opts__sz != BPF_XFRM_STATE_OPTS_SZ) {
> > +		opts->error = -EINVAL;
> 
> If opts is NULL, obvious we have issue opts->error access.
> If opts is not NULL and opts_sz < 4, we also have issue with
> opts->error access since it may override some other stuff
> on the stack.
> 
> In such cases, we do not need to do 'opts->error = -EINVAL'
> and can simply 'return NULL'. bpf program won't be able
> to check opts->error anyway since the opts is either NULL
> or opts_sz < 4.

Ack, will fix.

[...]


Thanks,
Daniel

