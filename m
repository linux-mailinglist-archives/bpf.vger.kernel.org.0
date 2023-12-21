Return-Path: <bpf+bounces-18499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461AE81AED6
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 07:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36792B20F65
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 06:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C55B673;
	Thu, 21 Dec 2023 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="FQtmcV3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3Y8O5tX1"
X-Original-To: bpf@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6818B672
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 2E1D53200A31;
	Thu, 21 Dec 2023 01:37:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 21 Dec 2023 01:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703140623; x=1703227023; bh=oMmRMRSvfr
	rH3zq3U2wvigECTJJ8WyW7NKJuqKxont4=; b=FQtmcV3SQ0UV/txYxeQdNViMXn
	upVSQgym88gwdwg6BoqAJ54eGMlWzUoMwMX/H2Gmbif8KBMlzq7KSj4ohBCLL27I
	/87zO9AISUrUpsmCFvB3TUbtzDQWGF0RAZs9kO0nUZ8J+Hqt/LO8GAgIHjOPD00Y
	uTFboH1IbNTf16BWE08oCs46QfvVBiTuImGIryYOvd4QEaA11dDJ0wATSQ5EllUj
	8qEQZa0bn/J1jePA6UlmLxCk95Ka4Wj3R0ovkg7IFmiuUQ5mLc+H8ty5X/paBlAB
	bZ5Ef2U4e6edQssy6HoKA3iNHbQMpESxJyNOTw9rDI4v/XQ8vhW7K4k3e7RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703140623; x=1703227023; bh=oMmRMRSvfrrH3zq3U2wvigECTJJ8
	WyW7NKJuqKxont4=; b=3Y8O5tX1YgXOim8OTxQ/qnp77SaTyLsn5RYvjvJpGywJ
	yScKKomA0L8LKQiiP5IhB176ljwPVBi/le8OjbYPur3fJtpxwufyqskXuhVjCRW9
	FkQcsG9P5UV+qZA0jhEywKevc6xC5CT2nCMkvfNMDHN2XEBcruhMXdrfHQ3osXRY
	TMU2uJCeIzFEfyfLJyTak0fCVUhUH8y7ViM50dO6jOL8PU2/nIApZydLTEeQHDqK
	+Kmyj/bbMS52Si1e4fTOfaWklxGZ36jrbetViFCgzPyLo2PJLW1TYDn+aWtUUQhW
	FdA4mRCvNKBk4eCFqPUldupzhN3woR0vbf7wnJ6pyA==
X-ME-Sender: <xms:D92DZcz9sqb8-zeM7MG9mI4Z75fxJY9GCMOpLPQVCzUgkSRu7fHgvg>
    <xme:D92DZQR0QfJrltCdrAKsHt5icntL92hdgKXX6HIcQ9_rifnEgODkFnbd6xPCRdRaD
    SjI-JqSOaGa4N5ajw>
X-ME-Received: <xmr:D92DZeVVKlfpTga2B1SfEIYjDlS4GuDwg7h9zfz1ru1iwfewUlGnNd64GrpAeRMDfl1ILua5xZ6oXjAoQ4M-xkiy0BArEMJ9DrCuVLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeige
    dtheefffekuedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:D92DZai8MTCkDfTCRt9h6L8d4cu3sDS-2ESZstOisLPfhtwFwnZd_A>
    <xmx:D92DZeAH0AurFxuNci30ry1qwjqI87S_XpSuYUuDrEjSjAfyNrjbhw>
    <xmx:D92DZbI2DfL5mpvmGMZid2TuuzUKl0MEqvG1cW4ndLil-NZK2pD8Cg>
    <xmx:D92DZV4NJaEM1h4AYgAAxrUzsyjwJNBqoovnnKXsj564cpz3f7LETg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 01:37:02 -0500 (EST)
Date: Wed, 20 Dec 2023 23:37:01 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>

On Wed, Dec 20, 2023 at 03:19:52PM -0700, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
>
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
>
> Example of encoding:
>
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
>         388
>
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
>         [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
>         [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  btf_encoder.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
>

Hmm, looking more, seems like this will pick up non-kfunc functions as
well. For example, kernel/trace/bpf_trace.c:


        BTF_SET_START(btf_allowlist_d_path)
        #ifdef CONFIG_SECURITY
        BTF_ID(func, security_file_permission)
        BTF_ID(func, security_inode_getattr)
        BTF_ID(func, security_file_open)
        #endif
        #ifdef CONFIG_SECURITY_PATH
        BTF_ID(func, security_path_truncate)
        #endif
        BTF_ID(func, vfs_truncate)
        BTF_ID(func, vfs_fallocate)
        BTF_ID(func, dentry_open)
        BTF_ID(func, vfs_getattr)
        BTF_ID(func, filp_close)
        BTF_SET_END(btf_allowlist_d_path)

Maybe we need a codemod from:

        BTF_ID(func, ...

to:

        BTF_ID(kfunc, ...


The change to resolve_btfids would be relatively small. Not sure what
the drawbacks are yet.

One way or another we'll need to annotate the kfuncs in source.

