Return-Path: <bpf+bounces-18843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7B282262E
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E441F2358C
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCA81C;
	Wed,  3 Jan 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="AZQvg1sr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fh7ZNyfQ"
X-Original-To: bpf@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17A7F1
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4C5FF3200B01;
	Tue,  2 Jan 2024 19:56:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Jan 2024 19:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704243364; x=1704329764; bh=SxyiJA2tYu
	upLHs1zAuTBPoHYW/V5xDhEmxlYzbHmcY=; b=AZQvg1srcWXU18Vv5x4ZrHZI+p
	Elst5yET+mWUkf1g7ReFOmlKKRiq7mxFpcqxXjoG2GiJ5ypqoh3mEdK0kFm04Gtp
	0NQ4aZkgje3BU966wbN2++y4dIC7S5VQzczOIgGoipGz8rG9Zs5r0rv+uN8K6sG3
	0kGZByFdgkXQ/Bh3uAZDWtT7Lp7XKRpNrQlmHevUdj1z0WjJRAPd80o35Qz9Pbod
	0RV2bNXsR0VPYuMAIgZS1992XAssqhrvJeplausgmGpIJWGjluktISaVNlPc9Yt8
	mv2cvCEd59bpmz81I5hUN8hoi3l/NJ+A70U5MDG0Rp8OEgOGXNLB1k7oEuoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704243364; x=1704329764; bh=SxyiJA2tYuupLHs1zAuTBPoHYW/V
	5xDhEmxlYzbHmcY=; b=fh7ZNyfQSxBwHNDCht/YdAj/gz3pnKmJb1DEGxG6Uy1+
	XReow2WbGFXKRwGoSh+P2hru0t0oVgmxGcXTWe0fF2WqSNSoEm/p+6aw8XoP84vh
	wPCM0LdvRN5NUVGWWhY7iKnkl+U4VY1y/gVVFbeixOnb+rc/erlHV1d1W1ga7k1e
	rIsiUA60BpQa8QWOw0loqmDVhuiIyIfMtBjQsF5oZIk2zlXRKxAPw5q2nNxm2GaS
	TsYAiAsb9KgwhnfhSM6n+CwHurM/FyzO4ZFNiY70B+TcKnGiCJDPZIQfKZneptrF
	Xz8IqCNhYbu6rRxXqybo13v6UDazquNUKylXsFT5IA==
X-ME-Sender: <xms:pLCUZUjh_LA1lE6dDTyAGy-m7yExw_kVsu4E5TBAHsYrfNw8Bpr4pQ>
    <xme:pLCUZdC3aPSQdbfpdJjwlxsFtNV8lbF8SPiDev8n0WHktjc3Xe-RCPXdy7X_mdiEN
    PTeWFlRWoxM2sbJQw>
X-ME-Received: <xmr:pLCUZcF72_Bh05qqq015ipwV3pZZK2IRZHFc8qlxQFQN896awSyjXVjDBuhoOwlefSYSgLiP1BOOj9VgIh6uKJstRR1OJO9A0y-mG68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:pLCUZVSDcnfRCbuBwtRELRP5EcX2sP-LWQpqarSbBp6PztHT0hMVaw>
    <xmx:pLCUZRwnc-MYkA8dXflzIRR2JqiuLhlm6dL18qlDqxqEiZpjafZWhg>
    <xmx:pLCUZT5r4SPBf2zH5CEGnBklNkPu_WEX8ldpJUJSWYU_mH7l37Q6CQ>
    <xmx:pLCUZUrUlvtC6ja0Ph-w7gpBIjdka33Wojmy0Uvn2upVN-FRCp1yfw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jan 2024 19:56:03 -0500 (EST)
Date: Tue, 2 Jan 2024 17:56:02 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <pciti5oczkgz3lti5auqj3r7do6luceb6jena3cfwhh3u2fcua@sk7xbxq7hmch>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYP40EN9U9GKOu7x@krava>

On Thu, Dec 21, 2023 at 09:35:28AM +0100, Jiri Olsa wrote:
> On Wed, Dec 20, 2023 at 11:37:01PM -0700, Daniel Xu wrote:
> > On Wed, Dec 20, 2023 at 03:19:52PM -0700, Daniel Xu wrote:
> > > This commit teaches pahole to parse symbols in .BTF_ids section in
> > > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > >
> > > This enables downstream users and tools to dynamically discover which
> > > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > > available in /sys/kernel/btf.
> > >
> > > Example of encoding:
> > >
> > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
> > >         388
> > >
> > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
> > >         [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
> > >         [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  btf_encoder.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 202 insertions(+)
> > >
> > 
> > Hmm, looking more, seems like this will pick up non-kfunc functions as
> > well. For example, kernel/trace/bpf_trace.c:
> > 
> > 
> >         BTF_SET_START(btf_allowlist_d_path)
> >         #ifdef CONFIG_SECURITY
> >         BTF_ID(func, security_file_permission)
> >         BTF_ID(func, security_inode_getattr)
> >         BTF_ID(func, security_file_open)
> >         #endif
> >         #ifdef CONFIG_SECURITY_PATH
> >         BTF_ID(func, security_path_truncate)
> >         #endif
> >         BTF_ID(func, vfs_truncate)
> >         BTF_ID(func, vfs_fallocate)
> >         BTF_ID(func, dentry_open)
> >         BTF_ID(func, vfs_getattr)
> >         BTF_ID(func, filp_close)
> >         BTF_SET_END(btf_allowlist_d_path)
> 
> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
> which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
> 
> __BTF_ID__func_* symbol that has address inside the SET8 list is kfunc

I managed to add that logic. But I did some spot checks and it looks
like SET8 lists are not quite limited to kfuncs. For example, in
net/mptcp/bpf.c:

        BTF_SET8_START(bpf_mptcp_fmodret_ids)
        BTF_ID_FLAGS(func, update_socket_protocol)
        BTF_SET8_END(bpf_mptcp_fmodret_ids)

        static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
                .owner = THIS_MODULE,
                .set   = &bpf_mptcp_fmodret_ids,
        };

And in net/socket.c:

        __bpf_hook_start();
        __weak noinline int update_socket_protocol(int family, int type, int protocol)
        {
                return protocol;
        }
        __bpf_hook_end();

IOW, update_socket_protocol() is a hook, not a kfunc.

> 
> > 
> > Maybe we need a codemod from:
> > 
> >         BTF_ID(func, ...
> > 
> > to:
> > 
> >         BTF_ID(kfunc, ...
> 
> I think it's better to keep just 'func' and not to do anything special for
> kfuncs in resolve_btfids logic to keep it simple
> 
> also it's going to be already in pahole so if we want to make a fix in future
> you need to change pahole, resolve_btfids and possibly also kernel

So maybe special annotation is still needed. WDYT?

[..]

Thanks,
Daniel

