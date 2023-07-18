Return-Path: <bpf+bounces-5187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659575876E
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCADE281593
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883A1774B;
	Tue, 18 Jul 2023 21:45:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC511174CB;
	Tue, 18 Jul 2023 21:45:40 +0000 (UTC)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED6198C;
	Tue, 18 Jul 2023 14:45:39 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.nyi.internal (Postfix) with ESMTP id 1E5B95802F2;
	Tue, 18 Jul 2023 17:45:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 18 Jul 2023 17:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1689716736; x=1689723936; bh=uD
	sDK041yg1GWCX+vHUCiSTd/14RpAua7/p4WDM2U2w=; b=l4pUQHhBDbItq74CZI
	hsQjElDCxkVCXPR0g7HAnQ6+3focB2iVFovFuzCHwe0Y02OECbUXx7s86cgtVQW/
	RzhE7Rhd9RdRA24SewI3hUuzsot8s09va6iHBR4FzHAs25jdOnNZpiqtK/Zxs2xQ
	MjWtJd2c1/dZUGXNHxlBZCfjs2OK1iXAUjWBJFBWFyCThD/83M2Q4x3R+MD9ie+o
	JndwLIECP+YSWqmrLTnQojgRwAzo7eDDesWYQBYlX49iOoqDzEwkReGer05sOG/6
	sFfo6WeUYQ29tPVF4VS2bCrrn12fzDLpDushXhupoad4zZaUjYmsB1p4Iu52c9Pl
	LdEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689716736; x=1689723936; bh=uDsDK041yg1GW
	CX+vHUCiSTd/14RpAua7/p4WDM2U2w=; b=KUWb1QenPKil0C6Cw9Jo1EMwp+N0C
	dF1qytWLyNgSAd5Jx2HgrgeIg1wcWkCP95e8nC1pCHwV1kYTjZQE4Kbcw68aWbuD
	iB3pCvjIUyJrosBMYL6p4z+HNwv6egp/dVWyaORDZ7ROZnMI/iEvaKoiRc3zRzSy
	sPw57IBZ93h1Nq8fby+HCTyqLXSqRTGrSj3h3YeY3/UzehBOYplfLOE2d/GbyfLi
	zyZSpVXGdBINYLFyAO4JLJ0aWGOy7N/vN/KoTSZ9vlGH1HesLIXmUUrl+6+h9X08
	gqMGDD75rx2J1Ab1kPUtGz9reBhfsVl6wmlzjy1w7YGWGsqKlz5rW788Q==
X-ME-Sender: <xms:_we3ZPHVR7lCTvVgpag5PAhv8YqG9pgJJSFndeJ6pVudjpFPTXAXvQ>
    <xme:_we3ZMW57u0KODVlsn8ifsYWyJM4QaSHuZpL1PSEUyPhHILn-HGNzTcR8oKR0bflp
    412_ZtGbaw-k55Cog>
X-ME-Received: <xmr:_we3ZBJviNjEyIcnnd87HfdU_dMDfh61e7PyTJ61qTZflTaRX71onH2EYxsbRYwPzjhq5sGaWUA7dkjhH2iOXHRMDrUBsDzXkfrG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeehgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:_we3ZNHiXAu_pXYHrB4e9sWxdijdluirm7JTTVqinPexzOtfp0wzMw>
    <xmx:_we3ZFUdRN2bIsClY4oI0HhqKg6rWlmDmr_fVRHBdQIfH0E5A1K3vQ>
    <xmx:_we3ZIN3nakgap87xh5VJsM1314_SAQGaayjCkDXp6jrr9GTcfEFoA>
    <xmx:AAi3ZD3w9P0TUi9niFO7ONGlvj_n9te545u08NhHn091q8v_CIj6ug>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 17:45:33 -0400 (EDT)
Date: Tue, 18 Jul 2023 15:45:32 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Florian Westphal <fw@strlen.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org, 
	Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH bpf-next v4 2/6] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <6av46ydgbufp5x23lempwmutcsjuy6efpysbvnqxjoirng43tr@gcyqxhln2x6f>
References: <cover.1689203090.git.dxu@dxuuu.xyz>
 <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
 <CAADnVQKKfEtZYZxihxvG3aQ34E1m95qTZ=jTD7yd0qvOASpAjQ@mail.gmail.com>
 <kwiwaeaijj6sxwz5fhtxyoquhz2kpujbsbeajysufgmdjgyx5c@f6lqrd23xr5f>
 <CAADnVQLcAoN5z+HD_44UKgJJc6t5TPW8+Ai9We0qJpau4NtEzA@mail.gmail.com>
 <wltfmammaf5g4gumsbna4kmwo6dtd24g472o7kgkug42dhwcy2@32fmd7q6kvg4>
 <CAADnVQJQZ2jQSWByVvi3N2ZOoL0XDSJzx5biSVvq=inS7OSW7A@mail.gmail.com>
 <t6wypww537golmoosbikfuombrqq555fh5mbycwl4whto6joo4@hcqlospkgqyr>
 <20230714094741.GA7912@breakpoint.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714094741.GA7912@breakpoint.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Florian,

On Fri, Jul 14, 2023 at 11:47:41AM +0200, Florian Westphal wrote:
> Daniel Xu <dxu@dxuuu.xyz> wrote:
> > On Thu, Jul 13, 2023 at 04:10:03PM -0700, Alexei Starovoitov wrote:
> > > Why is rcu_assign_pointer() used?
> > > If it's not RCU protected, what is the point of rcu_*() accessors
> > > and rcu_read_lock() ?
> > > 
> > > In general, the pattern:
> > > rcu_read_lock();
> > > ptr = rcu_dereference(...);
> > > rcu_read_unlock();
> > > ptr->..
> > > is a bug. 100%.
> 
> FWIW, I agree with Alexei, it does look... dodgy.
> 
> > The reason I left it like this is b/c otherwise I think there is a race
> > with module unload and taking a refcnt. For example:
> > 
> > ptr = READ_ONCE(global_var)
> >                                              <module unload on other cpu>
> > // ptr invalid
> > try_module_get(ptr->owner) 
> >
> 
> Yes, I agree.
> 
> > I think the the synchronize_rcu() call in
> > kernel/module/main.c:free_module() protects against that race based on
> > my reading.
> > 
> > Maybe the ->enable() path can store a copy of the hook ptr in
> > struct bpf_nf_link to get rid of the odd rcu_dereference()?
> > 
> > Open to other ideas too -- would appreciate any hints.
> 
> I would suggest the following:
> 
> - Switch ordering of patches 2 and 3.
>   What is currently patch 3 would add the .owner fields only.
> 
> Then, what is currently patch #2 would document the rcu/modref
> interaction like this (omitting error checking for brevity):
> 
> rcu_read_lock();
> v6_hook = rcu_dereference(nf_defrag_v6_hook);
> if (!v6_hook) {
>         rcu_read_unlock();
>         err = request_module("nf_defrag_ipv6");
>         if (err)
>                  return err < 0 ? err : -EINVAL;
>         rcu_read_lock();
> 	v6_hook = rcu_dereference(nf_defrag_v6_hook);
> }
> 
> if (v6_hook && try_module_get(v6_hook->owner))
> 	v6_hook = rcu_pointer_handoff(v6_hook);
> else
> 	v6_hook = NULL;
> 
> rcu_read_unlock();
> 
> if (!v6_hook)
> 	err();
> v6_hook->enable();
> 
> 
> I'd store the v4/6_hook pointer in the nf bpf link struct, its probably more
> self-explanatory for the disable side in that we did pick up a module reference
> that we still own at delete time, without need for any rcu involvement.
> 
> Because above handoff is repetitive for ipv4 and ipv6,
> I suggest to add an agnostic helper for this.
> 
> I know you added distinct structures for ipv4 and ipv6 but if they would use
>  the same one you could add
> 
> static const struct nf_defrag_hook *get_proto_frag_hook(const struct nf_defrag_hook __rcu *hook,
> 							const char *modulename);
> 
> And then use it like:
> 
> v4_hook = get_proto_frag_hook(nf_defrag_v4_hook, "nf_defrag_ipv4");
> 
> Without a need to copy the modprobe and handoff part.
> 
> What do you think?

That sounds reasonable to me. I'll give it a shot. Thanks for the input!

Daniel

