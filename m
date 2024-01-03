Return-Path: <bpf+bounces-18910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89A823674
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1608B24BDD
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC821D53E;
	Wed,  3 Jan 2024 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="B3AOGFaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lhwz87qA"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB61D530
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4CAE23200A83;
	Wed,  3 Jan 2024 15:19:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Jan 2024 15:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704313193; x=1704399593; bh=xQ1eNbQ0lh
	BdZLcBS3gSS0qoD+8ZvQX+WljoGlmn68M=; b=B3AOGFaTrcd3ht3XCgoQoL1fu3
	qkx1Wo7tvTDhAWf9PbU+jKkgDLEjTl9m/i+Exl4En7RFKtFr8laDgAT10j+0S5Tm
	3J1Ko6vLTE+Bw7k52w+2DArh/7YVJSpqE9bhpVOrt87fk7s1JwHV/ryo+jc44I/l
	6IXJpfolw9iAUQXabGkwp1MAXtlTMsf2ZaWdsX13SjRxYVGFiEWmsshq61T9MCw6
	tGmZWJE+HdChFCfdxH6cDNhjQPTEMLr3IZKJimLRp/oQexujvnDO9hGl2g0hJfbt
	BXaGmxPODAXPTFFN2pAxvKDCgxfPpwEr+Nv8BAFQn2q/3GmoSha/Z940fdrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704313193; x=1704399593; bh=xQ1eNbQ0lhBdZLcBS3gSS0qoD+8Z
	vQX+WljoGlmn68M=; b=lhwz87qAc7YJFNOAaML8QP9NKPC5Nx0+YZzQGbEARozn
	u9nBnwAKTLwFeOztostkZrEmBkBKELbDOXXectg5CofwPUXpk6cJ1q1TErUxcry+
	0ymfQsJ53ddcxzhsP6B3kKBcotr/5ZvTnQX96SL0Ljbed7OUGL5I52mAo8lgqmIm
	IOvaV/cWunfsoOHfdIAJ+B8DVlEUsfc0DE4ve/3X9I3rv2qwWuk3wWBownBHJr0L
	nvgMzBjB5ZcHU6XCYTwRBXewa68979xd778DNuKWmZuKnqq96ptoyMGmCGsj4Ylr
	BREhwIQxCJnh5FdQooxRVeuVOWyllc5unoMyzacBEg==
X-ME-Sender: <xms:acGVZUhUiEBaVE7JoucGvE7jqPBfEzoQlo4gu2hnDU1lH04q-KmHOQ>
    <xme:acGVZdCuGmCMkk_grxbW_7blFFrIY-Bz9-SyHgaPDEf0R3o_IZ8588hkT2_Buu1dN
    UGMBxLY1edkB8TwGw>
X-ME-Received: <xmr:acGVZcGmi2NuCHrTTsPKFOHnrslW_YdwEgyTQLa-RbZGfkbGYPOkiH0Vp-XLzgnBj3wMlpVgvLWGoGFT8ju7yJAuIjHEO-NR1Z7NAhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffff
    gfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:acGVZVTSFjdCcbu-wUdMhGrsJvIiroMBLi0gY7v7Ai_vFiTaiq8KoA>
    <xmx:acGVZRzKYu92SIsfPKZcY8BbezTOdbCVF2VSoadZyrf1EyoifWekVA>
    <xmx:acGVZT7SW8md2a8To_B-24pdi-MKEZXk0VdZhSDcderRUSYbholGGw>
    <xmx:acGVZYlbU087wPF4uvqCK9TUfr2RzoGtS-Lg-zG4mhZtUlOqRMTM1g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 15:19:52 -0500 (EST)
Date: Wed, 3 Jan 2024 13:19:51 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <wilo6jm4mcbjplbzauhxbnaymtkvqcbwo2iztngncu7be32ara@h27eafqpwpzt>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava>
 <pciti5oczkgz3lti5auqj3r7do6luceb6jena3cfwhh3u2fcua@sk7xbxq7hmch>
 <ZZUfSQPFNOLfnL0l@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZUfSQPFNOLfnL0l@krava>

On Wed, Jan 03, 2024 at 09:48:09AM +0100, Jiri Olsa wrote:
> On Tue, Jan 02, 2024 at 05:56:02PM -0700, Daniel Xu wrote:
> > On Thu, Dec 21, 2023 at 09:35:28AM +0100, Jiri Olsa wrote:
> > > On Wed, Dec 20, 2023 at 11:37:01PM -0700, Daniel Xu wrote:
> > > > On Wed, Dec 20, 2023 at 03:19:52PM -0700, Daniel Xu wrote:
> > > > > This commit teaches pahole to parse symbols in .BTF_ids section in
> > > > > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > > > > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > > > >
> > > > > This enables downstream users and tools to dynamically discover which
> > > > > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > > > > available in /sys/kernel/btf.
> > > > >
> > > > > Example of encoding:
> > > > >
> > > > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
> > > > >         388
> > > > >
> > > > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
> > > > >         [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
> > > > >         [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1
> > > > >
> > > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > > ---
> > > > >  btf_encoder.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 202 insertions(+)
> > > > >
> > > > 
> > > > Hmm, looking more, seems like this will pick up non-kfunc functions as
> > > > well. For example, kernel/trace/bpf_trace.c:
> > > > 
> > > > 
> > > >         BTF_SET_START(btf_allowlist_d_path)
> > > >         #ifdef CONFIG_SECURITY
> > > >         BTF_ID(func, security_file_permission)
> > > >         BTF_ID(func, security_inode_getattr)
> > > >         BTF_ID(func, security_file_open)
> > > >         #endif
> > > >         #ifdef CONFIG_SECURITY_PATH
> > > >         BTF_ID(func, security_path_truncate)
> > > >         #endif
> > > >         BTF_ID(func, vfs_truncate)
> > > >         BTF_ID(func, vfs_fallocate)
> > > >         BTF_ID(func, dentry_open)
> > > >         BTF_ID(func, vfs_getattr)
> > > >         BTF_ID(func, filp_close)
> > > >         BTF_SET_END(btf_allowlist_d_path)
> > > 
> > > you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
> > > which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
> > > 
> > > __BTF_ID__func_* symbol that has address inside the SET8 list is kfunc
> > 
> > I managed to add that logic. But I did some spot checks and it looks
> > like SET8 lists are not quite limited to kfuncs. For example, in
> > net/mptcp/bpf.c:
> > 
> >         BTF_SET8_START(bpf_mptcp_fmodret_ids)
> >         BTF_ID_FLAGS(func, update_socket_protocol)
> >         BTF_SET8_END(bpf_mptcp_fmodret_ids)
> > 
> >         static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
> >                 .owner = THIS_MODULE,
> >                 .set   = &bpf_mptcp_fmodret_ids,
> >         };
> > 
> > And in net/socket.c:
> > 
> >         __bpf_hook_start();
> >         __weak noinline int update_socket_protocol(int family, int type, int protocol)
> >         {
> >                 return protocol;
> >         }
> >         __bpf_hook_end();
> > 
> > IOW, update_socket_protocol() is a hook, not a kfunc.
> 
> hum, right.. we use kfuncs set8 registration now also to mark attachable
> hooks for fmodret programs, see [1]
> 
> there are similar hooks registered in HID code as well
> 
> [1] 5b481acab4ce bpf: do not rely on ALLOW_ERROR_INJECTION for fmod_ret)
> 
> > 
> > > 
> > > > 
> > > > Maybe we need a codemod from:
> > > > 
> > > >         BTF_ID(func, ...
> > > > 
> > > > to:
> > > > 
> > > >         BTF_ID(kfunc, ...
> > > 
> > > I think it's better to keep just 'func' and not to do anything special for
> > > kfuncs in resolve_btfids logic to keep it simple
> > > 
> > > also it's going to be already in pahole so if we want to make a fix in future
> > > you need to change pahole, resolve_btfids and possibly also kernel
> > 
> > So maybe special annotation is still needed. WDYT?
> 
> anyway, it looks like we actually do have flags field in set8 (thanks Kumar! ;-) )
> 
> 	struct btf_id_set8 {
> 		u32 cnt;
> 		u32 flags;
> 		struct {
> 			u32 id;
> 			u32 flags;
> 		} pairs[];
> 	};
> 
> it's not mentioned in the commit changelog [2], but it looks like it was
> added just to keep data aligned, and AFAICS it's not used anywhere
> 
> how about we add a flag saying this set8 has kfuncs in it

Nice, yeah. This makes sense. We can tag it at the BTF_SET8_START level
to reduce churn. At same time, we can WARN_ON() if the flag is missing
in register_btf_kfunc_id_set().

Thanks,
Daniel

