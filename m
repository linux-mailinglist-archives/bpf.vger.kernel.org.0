Return-Path: <bpf+bounces-17277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498F80B0CC
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27B91F21353
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20D38C;
	Sat,  9 Dec 2023 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ddIGLF7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+xGH14f"
X-Original-To: bpf@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A956AC;
	Fri,  8 Dec 2023 16:07:57 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 4FC5932005C1;
	Fri,  8 Dec 2023 19:07:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Dec 2023 19:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1702080474; x=1702166874; bh=m98dLHyPwI+eg2Ijq83uqu7OvTQevvvXu+0
	DP05ozNs=; b=ddIGLF7AaNmnEW79+jOnw5EwvTm7427Hej6wBRLVNLEogCxE9VX
	UrV3H2uUT0G3am/S/ednqVUmumgqCMkdusoE+QDqR5zrM3sW957QzdTrS2TD9YrP
	3EwDukzy8EpVk7k2UxT7Uw3dPqLSu7o8faCYm02ID+EA680i4yWaEvv8J3DRAoXP
	yhh5tRLTXe22KdksfC7joSItsRjRkDt2Nvkk/SjqfijaWigBjYNyENSU5ugz8ZKS
	9iwSdPj99tffOo61rhbxbfWnVP7u+oerMGNg2eSsVSX4Y0Pu0UT99A1UrPRYc7lg
	rvYrYx+LzkFjDs8/yXxKUEghGxpcMKe5dNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1702080474; x=1702166874; bh=m98dLHyPwI+eg2Ijq83uqu7OvTQevvvXu+0
	DP05ozNs=; b=d+xGH14fpAprU6BJ8STzBEuYXe0FQYuOl2+Q4Er8JyEW2egvFFe
	NNq2u3/smCxnE6TPc4JV+hVINPaAOYAY9Mgx2F92go0rE9DdxuqZ4xadtRbl99LV
	7BiAooaVU7dCarvRnLSSGEmEKmg1bgWOHkLJEBbr5IvYsKvOHpgR97O1or1u3vfv
	FBp7rdkbo0WxL6ogCqn66Sjsgza4S9ggSuhJESpAP1XrxP65LEbaVuAKBok8c9X1
	9BWO4Q1ZyLA/EV8AUvEADXkOr2Vz17gAtXCwMCFvyqX1nJaFqdt5Sulmbj47Nh5s
	SGxyeSITeplQ6QbbGYL9JA8BuMjuhvfk7Qg==
X-ME-Sender: <xms:2q9zZacriLGMalplAmHDmauXTOvPBXnYelEqSXNmuPLO4tA04UPLKg>
    <xme:2q9zZUO8HEbLaF-23rIW10L3kZgri4mPnEnyaapFz9Z6YY_7KyTgQLXZMcOXcWgFD
    iXKK67aiUWtZX4tkw>
X-ME-Received: <xmr:2q9zZbiyhErwE8pXZBC9qvuIxKo5f2ATxXQz_8Rr6bqBwMIn6_DWWn2LnhGdOIAgMvlslofqHA_pLGDx9mcr_t8UT2zE17dhksNq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekjedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:2q9zZX_UlIk7KVR-TgT5AqPFcpK2GuFcwnVIATnBAorsvyHVr38Mow>
    <xmx:2q9zZWtYoI7JYEHX0Zo3uLvJ8r4pchkZ61aRDbiCWlXB4m6vcBqpJQ>
    <xmx:2q9zZeFjQJd-q4YYFzwbl00kbGKZoDlQULT1JbcLgfu2sL7_efolRw>
    <xmx:2q9zZeQMwZLYJCuvn1cX10USK1fYv1AqMHSE7sNW-yFxJkbUBRT1hw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 19:07:53 -0500 (EST)
Date: Fri, 8 Dec 2023 17:07:51 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	Herbert Xu <herbert@gondor.apana.org.au>, steffen.klassert@secunet.com, pabeni@redhat.com, hawk@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, edumazet@google.com, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	devel@linux-ipsec.org
Subject: Re: [PATCH bpf-next v4 02/10] bpf: xfrm: Add
 bpf_xdp_get_xfrm_state() kfunc
Message-ID: <ubztsmdzjlyou662foobqjwkky2n6tgcp2ocgvxssd4jwplhdk@o2kmq3cthrkn>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
 <e0e2fc6161ceccfbb1075d367bcc37871012072d.1701722991.git.dxu@dxuuu.xyz>
 <CAHsH6GvRtFRRhjLoVL6HqmthGVY4KEb8EOzT61ofWyXgocD4NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GvRtFRRhjLoVL6HqmthGVY4KEb8EOzT61ofWyXgocD4NA@mail.gmail.com>

On Thu, Dec 07, 2023 at 01:21:11PM -0800, Eyal Birger wrote:
> On Mon, Dec 4, 2023 at 12:57 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
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
> > Co-developed-by: Antony Antony <antony.antony@secunet.com>
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  include/net/xfrm.h     |   9 ++++
> >  net/xfrm/xfrm_bpf.c    | 102 +++++++++++++++++++++++++++++++++++++++++
> >  net/xfrm/xfrm_policy.c |   2 +
> >  3 files changed, 113 insertions(+)
> >
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index c9bb0f892f55..1d107241b901 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -2190,4 +2190,13 @@ static inline int register_xfrm_interface_bpf(void)
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
> > diff --git a/net/xfrm/xfrm_bpf.c b/net/xfrm/xfrm_bpf.c
> > index 3d3018b87f96..3d6cac7345ca 100644
> > --- a/net/xfrm/xfrm_bpf.c
> > +++ b/net/xfrm/xfrm_bpf.c
> > @@ -6,9 +6,11 @@
> >   */
> >
> >  #include <linux/bpf.h>
> > +#include <linux/btf.h>
> >  #include <linux/btf_ids.h>
> >
> >  #include <net/dst_metadata.h>
> > +#include <net/xdp.h>
> >  #include <net/xfrm.h>
> >
> >  #if IS_BUILTIN(CONFIG_XFRM_INTERFACE) || \
> > @@ -112,3 +114,103 @@ int __init register_xfrm_interface_bpf(void)
> >  }
> >
> >  #endif /* xfrm interface */
> > +
> > +/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
> > + *
> > + * Members:
> > + * @error      - Out parameter, set for any errors encountered
> > + *              Values:
> > + *                -EINVAL - netns_id is less than -1
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
> > +__bpf_kfunc_start_defs();
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
> > +       struct xfrm_state *x;
> > +
> > +       if (!opts || opts__sz < sizeof(opts->error))
> > +               return NULL;
> > +
> > +       if (opts__sz != BPF_XFRM_STATE_OPTS_SZ) {
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
> > +       x = xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi,
> > +                             opts->proto, opts->family);
> > +
> > +       if (opts->netns_id >= 0)
> > +               put_net(net);
> 
> Maybe opts->error should be set to something like -ENOENT if x == NULL?

Originally I opted not to do that b/c xfrm_state_lookup() chooses not to
do anything like that (eg PTR_ERR()).

But I don't mind adding it - I think it's reasonable either way.

[..]

Thanks,
Daniel

