Return-Path: <bpf+bounces-18397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E181A58A
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 17:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F701F23FAA
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF041A92;
	Wed, 20 Dec 2023 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="HSqZGhTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQEy3oz1"
X-Original-To: bpf@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBDA41206
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 64FE85C080A;
	Wed, 20 Dec 2023 11:44:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 20 Dec 2023 11:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1703090652;
	 x=1703177052; bh=jpQ0Kv5hUSr3ZuDqaULtAU1wJfLWs31OCn2y/KTUOQU=; b=
	HSqZGhTtGEQvGdNTiO9QoB3GofS4l0o/e2DS2tE/UTPan/vbFrE1NqscFkw6EwJG
	sMRBKVsPP5lwEwj8+alHoM12yBLa3jN7ZjvpM3wJfZjubTdjDPE5dGNkLhUOHs8b
	13caeKy0TEreAtsEV+mlRtcBGC6mnOuIPzdcBew8rpoSXCiHxEOJzsRz34Ot/BzR
	xxWb1Bptql04xap59FMXmCdnQhlEudrwGDP0N5YypGokEmW1mb8qGAov0O7abS2o
	CWUf2JF8V/1nTIEf5YHPBWfvVWA5fRx5c6tn1pYxAxx+qeK6QAhdnJQxRTtA6Dvz
	PARoFG/eE5J2NZFKuOG9Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703090652; x=
	1703177052; bh=jpQ0Kv5hUSr3ZuDqaULtAU1wJfLWs31OCn2y/KTUOQU=; b=D
	QEy3oz1nLhwapuZVV8vMDRmdKvEhrQtWD6hXbWVLbi1+AP9ZwszJWUR5tZr6QqLZ
	Xx2/atudkUXfNIJAoBe7XWV1wa0n6zLOdGY6tY+Uw7flFqPQemmLg17Fvvi7DERs
	MCb8yXJZJSKkHKiq0TBjB+cf/CeLBX8k8Wkwzoa4IG2XTXmYBEeRx0pIDNYTEpkW
	/Z3YJYAU/xQwpSUS75CxLUwQ/diAyG9aeDpLbIBE0j9c52cEGj3p2coRYcKpIFhJ
	y6MpCzU753prS4Z1X8fU5rNPxFYXw4ofIvXzXhlTSzBx/yWJk1xk1HL1Zfl/yvio
	b9omdKe7WeiXFmFxg2Pow==
X-ME-Sender: <xms:3BmDZb5fy4hP_9ikKuttqTntbVsohK3YNTif_4M56vFgz-iB5Vs66g>
    <xme:3BmDZQ6UukUkIe05EmxBwu0TjvoaF9gCTnxaYngUASrmRmVHqTsAUbxKqpYXertbi
    RIhzP8BImCZ3nCeXA>
X-ME-Received: <xmr:3BmDZSf2vemwp10OZbk5hPu2N2gCEr3aY7h0s_Xv_EtWKhmIziXjwGAOlvbtqoX7eI0MHN6rLQex2t9G4URj_BE3ifg7HIPvdmOfYdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:3BmDZcJE4DMoIhCiYhDBG0f8wB3tAodztSBpnQ4_JtdiWWtXzYTztg>
    <xmx:3BmDZfJWX29Jv5222tJnaQ3VBHoFfCaveBcn5TNPp0MRddIMMr09QA>
    <xmx:3BmDZVwNtJc_2S0Ph4excnu5LJDFSRPxa-v2WEhFjyTOeILn6GtYwQ>
    <xmx:3BmDZX1CdlrAaWQDFHuFPzwP1wLLT443ZJqqv8fgso88c30MJ9_07w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 11:44:11 -0500 (EST)
Date: Wed, 20 Dec 2023 09:44:10 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Dynamic kfunc discovery
Message-ID: <4hfjkuvoprm5qawiscm6yd64ffhuf7ig2onm2zqc2bb2r7bbvv@u774my22jfn6>
References: <67b0a25f-b75b-453c-9dde-17adf527a14a@app.fastmail.com>
 <CAADnVQLYafmCffxbpxcTFf09W6XqgXCRH6V4gpRL+82+OMMVMA@mail.gmail.com>
 <ZYKu1oysidMOHbbE@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYKu1oysidMOHbbE@krava>

Hi Jiri,

On Wed, Dec 20, 2023 at 10:07:34AM +0100, Jiri Olsa wrote:
> On Tue, Dec 19, 2023 at 07:15:42PM -0800, Alexei Starovoitov wrote:
> > On Tue, Dec 19, 2023 at 9:29 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > Hi,
> > >
> > > I was chatting w/ Quentin [0] about how bpftool could:
> > >
> > > 1. Support a "feature dump" of all supported kfuncs on running kernel
> > > 2. Generate vmlinux.h with kfunc prototypes
> > >
> > > I had another idea this morning so I thought I'd bounce it around
> > > on the list in case others had better ones. 3 vague ideas:
> > >
> > > 1. Add a BTF type tag annotation in __bpf_kfunc macro. This would
> > >    let bpftool parse BTF to do discovery. It would be fairly clean and
> > >    straightforward, except that I don't think GCC supports these type
> > >    tags. So only clang-built-linux would work.
> > >
> > > 2. Do the same thing as above, except rather than tagging src code,
> > >    teach pahole about the .BTF_ids section in vmlinux. pahole could then
> > >    construct BTF with the appropriate type tags.
> 
> I thought it'd be nice to have this in BTF, but to generate the .BTF_ids
> section we need the BTF data (for BTF IDs), so that might be tricky

Isn't .BTF_ids already present in vmlinux before getting to
resolve_btfids? It looks to me like all resolve_btfids does is patch
symbols to the read BTF ID values.

To inject BTF type tags from pahole, I don't think it needs a patched
.BTF_ids section, right? After pahole has generated all the regular
entries, it could walk .BTF_ids and try to match up symbol names with
BTF function entries. And then inject the BTF type tag.

> 
> > 
> > resolve_btfids knows about all of them already.
> > The best is to teach bpftool about them as well.
> > It can look for BTF_SET8_START and there it can find btf_ids
> 
> with the access to vmlinux, bpftool could get the addresses of all
> set8s, read all btf ids and generate the header
> 
> $ nm vmlinux | grep BTF_ID__set8 
> ffffffff843bf044 r __BTF_ID__set8__bpf_kfunc_check_set_skb
> ffffffff843bf064 r __BTF_ID__set8__bpf_kfunc_check_set_sock_addr
> ffffffff843bf054 r __BTF_ID__set8__bpf_kfunc_check_set_xdp
> ffffffff843be940 r __BTF_ID__set8__bpf_map_iter_kfunc_ids
> ffffffff843bf22c r __BTF_ID__set8__bpf_mptcp_fmodret_ids
> ffffffff843be604 r __BTF_ID__set8__bpf_rstat_kfunc_ids
> ffffffff843bf074 r __BTF_ID__set8__bpf_sk_iter_kfunc_ids
> ffffffff843bf1c4 r __BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids
> ffffffff843bf0bc r __BTF_ID__set8__bpf_test_modify_return_ids
> ffffffff843be864 r __BTF_ID__set8__common_btf_ids
> ffffffff843be9a8 r __BTF_ID__set8__cpumask_kfunc_btf_ids
> ffffffff843bf174 r __BTF_ID__set8__fou_kfunc_set
> ffffffff843be678 r __BTF_ID__set8__fs_kfunc_set_ids
> ffffffff843be794 r __BTF_ID__set8__generic_btf_ids
> ffffffff843be650 r __BTF_ID__set8__key_sig_kfunc_set
> ffffffff843bf10c r __BTF_ID__set8__nf_ct_kfunc_set
> ffffffff843bf164 r __BTF_ID__set8__nf_nat_kfunc_set
> ffffffff843bf18c r __BTF_ID__set8__tcp_cubic_check_kfunc_ids
> ffffffff843bf0dc r __BTF_ID__set8__test_sk_check_kfunc_ids
> ffffffff843bf084 r __BTF_ID__set8__xdp_metadata_kfunc_ids
> ffffffff843bf1f4 r __BTF_ID__set8__xfrm_ifc_kfunc_set
> ffffffff843bf20c r __BTF_ID__set8__xfrm_state_kfunc_set
> 
> jirka
> 
> > of all kfuncs.
> > From there it can generate them into vmlinux.h
> > 
> > We wanted kfuncs to appear in vmlinux.h for quite some time,
> > but no one had cycles to do it.
> > Still an awesome feature to have.
> > 

Thanks,
Daniel

