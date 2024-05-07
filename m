Return-Path: <bpf+bounces-28751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5332E8BD95A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 04:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A43283F5A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDC04C6B;
	Tue,  7 May 2024 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="JKS/AxaI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhUYGMC5"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD03FE4
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715048327; cv=none; b=LsSf+GtLM838gx6xkOCU6QU60jrqDuv/vbkeljCnguhA8zZ4VjSixGcx6y58hmEGVuPeGhiCEXrUnHT/j1gLcBeiqQt3XNhzU59KSw19yrd2eF8VMSZlUs8bhvGtnwtRqVkUdNRUiYOK/MyW4aVeYHjI11uPEQkfTeGDBSfIFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715048327; c=relaxed/simple;
	bh=jOYNks6FkLL6ISNapIQdu4MUmc2tz91EX12CU2iTeHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKedE99fuy05j0m9omvMMcNjo1hS4m3Sf0mD9MBmEiZZQo2GREsyMU7oZE4Yb+gwucIudmgQwb1wWQ6YPOZWPw/RYfFsKuNFWw7q2PomVBULJcrsEFwxbEPBiwJrVTX0QXX0228YTZGHUj/B+wrza86mxrRA9Tr04vWrkyvxycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=JKS/AxaI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhUYGMC5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8718D1140168;
	Mon,  6 May 2024 22:18:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 06 May 2024 22:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1715048324;
	 x=1715134724; bh=gWSS9lNrNK+HFqjyAtlPilylLaKuUMBxtxD4gfPPh58=; b=
	JKS/AxaIHzdmT6fRZXWg8WBODCCk/zU7bsPxluewvDtdiI2XJKF1jwXELvLlz0zl
	p8OHl+WjT0+COsUS2KYd6gUxTnmL6leakDOA+s/RC+SqqtljbnFFgFn/zSoIom4p
	8xreNrOmmpO9iPppkCKVHce18uEu/WQh9g8+/zH83HttLz9rZ+/LLH6xjySjqVqv
	HLP5SAt/pj+Gxfq1NO+dywsYN75Aq4L8dodfM6jyEtSQxwtlq+vCVljCjhaPL9iN
	/a/sLm9tzb58r2mIW28ksLrXZmJeE/rue38GTF5KQwTZVOzXamDN89UxscNhETtK
	pf/YSptSGwcxzG2nWZkOVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715048324; x=
	1715134724; bh=gWSS9lNrNK+HFqjyAtlPilylLaKuUMBxtxD4gfPPh58=; b=R
	hUYGMC50pi3soYMoPadpW+pnBGpWPxCYeHkorZBfE2eDdpFnqcv5ilsl6SR9c+KV
	IkvoFMKme30szREb5bu//STfIkXoCgaXnNMqR3uUUNqYWDprLrxqBZGqauC0lomr
	+vS+PIifHkKPq66syGAuF9ra0AMgpjUYNrsIHyMZvA+v5L2Txx4LcnTuenWqtkwG
	SlKRcjEhqiyRoRUTQLYzX6lPFDmjqxs8Bygn7nA9YWSBG+Nb4kU2TLbLNhR7qb6r
	WW0PBZxFpXxuyZJsb1pQdZURvOExbMYXW6MgBZamhRuiHKIyWxrwYqAeFMVyOx9G
	oi9N5JusHFNx4WWXNHIKA==
X-ME-Sender: <xms:g485ZjGFrVaqCDVHKdTnRS5WUUqCz6-uP0fIJ0aahdXj35reCEjcVQ>
    <xme:g485ZgXYrVwKdSeVCFrhHAQVfskNGnrMeEekeYpRpu18wMkmkKPhru0OhUwghtUlD
    izRcP2CHyC2kwV5bQ>
X-ME-Received: <xmr:g485ZlLQFRjXfBn-LinFNHlFKK8AOKkSevoUumy8UMsaaOA2xKTsV747dZIxiuWBJzA6giDJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpeffhf
    fvvefukfhfgggtugfgjgestheksfdttddtjeenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedtfffhledulefghf
    duhfekveegvefftdetudeivddviefhleefueehuddvkefftdenucffohhmrghinhepghhi
    thhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:g485ZhHL7kaqJCIZw49ULx6HyjXhL6JlCGprMF17gK9xMm2BQzfHhA>
    <xmx:g485ZpWADezzGwveRUMt-gcmTncfQzdwRjMwSJZagLRGvopZSTLXfQ>
    <xmx:g485ZsM5iOPwc3ijEWYfMPNwwZCO9kFzE-w5jiydExsVPHE863vO0A>
    <xmx:g485Zo1bRxF90TZBf2K10Ni-qpmrV8ydEJnhHjpL27mPy2mh9T4cJw>
    <xmx:hI85ZhTSAGGJLJOHKR_min2KyP4r8eTvw-IpEyBuQ8wuPoGKpiQ1-bjq>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 22:18:40 -0400 (EDT)
Date: Mon, 6 May 2024 20:18:34 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com, 
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 3/3] pahole: Inject kfunc decl tags into BTF
Message-ID: <r5ruieufhwvp2u5jecc7ivjvablqzt7gyg5xop5nzj3wt7abtq@lziy75gz2zj6>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <26ec519a00aa47f25bc6b4c7e4e15e5191ba4d45.1714430735.git.dxu@dxuuu.xyz>
 <ZjFXpgRjpDyDnvdc@x1>
 <zdag4h7ztmwn56yrmieisbhno4gpb24k7rgjevp6gc46e5dxak@3stxrh2qfnlu>
 <Zjk4mlHKmukeUc4y@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zjk4mlHKmukeUc4y@x1>

On Mon, May 06, 2024 at 05:07:54PM GMT, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 30, 2024 at 05:27:24PM -0600, Daniel Xu wrote:
> > On Tue, Apr 30, 2024 at 05:42:14PM GMT, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Apr 29, 2024 at 04:46:00PM -0600, Daniel Xu wrote:
> > > > This commit teaches pahole to parse symbols in .BTF_ids section in
> > > > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > > > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > > > 
> > > > Example of encoding:
> > > > 
> > > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
> > > >         121
> > > > 
> > > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
> > > >         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
> > > >         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> > > > 
> > > > This enables downstream users and tools to dynamically discover which
> > > > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > > > available in /sys/kernel/btf.
> > > > 
> > > > This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> > > 
> > > I'm trying this but:
> > > 
> > > ⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> > > btf_encoder__tag_kfuncs(cgroup_rstat_updated): found=0
> > > btf_encoder__tag_kfuncs(cgroup_rstat_flush): found=0
> > > btf_encoder__tag_kfuncs(security_file_permission): found=0
> > > btf_encoder__tag_kfuncs(security_inode_getattr): found=0
> > > btf_encoder__tag_kfuncs(security_file_open): found=0
> > > btf_encoder__tag_kfuncs(security_path_truncate): found=0
> > > btf_encoder__tag_kfuncs(vfs_truncate): found=0
> > > btf_encoder__tag_kfuncs(vfs_fallocate): found=0
> > > btf_encoder__tag_kfuncs(dentry_open): found=0
> > > btf_encoder__tag_kfuncs(vfs_getattr): found=0
> > > btf_encoder__tag_kfuncs(filp_close): found=0
> > > btf_encoder__tag_kfuncs(bpf_lookup_user_key): found=0
> > > btf_encoder__tag_kfuncs(bpf_lookup_system_key): found=0
> > > btf_encoder__tag_kfuncs(bpf_key_put): found=0
> > > btf_encoder__tag_kfuncs(bpf_verify_pkcs7_signature): found=0
> > > btf_encoder__tag_kfuncs(bpf_obj_new_impl): found=0
> > > <SNIP all with found=0>
> > > 
> > > With:
> > > 
> > > ⬢[acme@toolbox pahole]$ git diff -U16
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index c2df2bc7a374447b..27a16d6564381b60 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -1689,32 +1689,35 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> > >  		func = get_func_name(name);
> > >  		if (!func)
> > >  			continue;
> > >  
> > >  		/* Check if function belongs to a kfunc set */
> > >  		ranges = gobuffer__entries(&btf_kfunc_ranges);
> > >  		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
> > >  		found = false;
> > >  		for (j = 0; j < ranges_cnt; j++) {
> > >  			size_t addr = sym.st_value;
> > >  
> > >  			if (ranges[j].start <= addr && addr < ranges[j].end) {
> > >  				found = true;
> > >  				break;
> > >  			}
> > >  		}
> > > +
> > > +		printf("%s(%s): found=%d\n", __func__, func, found);
> > > +
> > >  		if (!found) {
> > >  			free(func);
> > >  			continue;
> > >  		}
> > >  
> > >  		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
> > >  		if (err) {
> > >  			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
> > >  			free(func);
> > >  			goto out;
> > >  		}
> > >  		free(func);
> > >  	}
> > >  
> > >  	err = 0;
> > >  out:
> > > 
> > > --------------
> > > 
> > > The vmlinux I'm testing on has the kfuncs, etc, as we can see with:
> > > 
> > > ⬢[acme@toolbox pahole]$ readelf -sW vmlinux | grep __BTF_ID__func__ | wc -l
> > > 517
> > > ⬢[acme@toolbox pahole]$ readelf -sW vmlinux | grep __BTF_ID__func__ | tail
> > >  97887: ffffffff83266bfc     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_cong_avoid__805493
> > >  97888: ffffffff83266c04     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_state__806494
> > >  97889: ffffffff83266c0c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_cwnd_event__807495
> > >  97890: ffffffff83266c14     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_acked__808496
> > >  98068: ffffffff83266c24     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_ssthresh__773199
> > >  98069: ffffffff83266c2c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_cong_avoid__774200
> > >  98070: ffffffff83266c34     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_undo_cwnd__775201
> > >  98071: ffffffff83266c3c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_slow_start__776202
> > >  98072: ffffffff83266c44     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_cong_avoid_ai__777203
> > > 101522: ffffffff83266c5c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__update_socket_protocol__80024
> > > ⬢[acme@toolbox pahole]$
> > > 
> > > 
> > > So that btf_encoder__tag_kfuncs() isn't finding any?
> > > 
> > > $ pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> > > btf_encoder__tag_kfuncs(vmlinux)
> > > 
> > > Yeah, getting the source filename, the right one.
> > > 
> > > Then is_sym_kfunc_set() never returns true... But:
> > > 
> > > ⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_rstat_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__key_sig_kfunc_set, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__generic_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__common_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_map_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__cpumask_kfunc_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_syscall_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_skb, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_xdp, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_sock_addr, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_sk_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__xdp_metadata_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_test_modify_return_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__test_sk_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__tcp_cubic_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_mptcp_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > > 
> > > real	0m5.586s
> > > user	0m29.707s
> > > sys	0m2.160s
> > > ⬢[acme@toolbox pahole]$
> > > 
> > > And then:
> > > 
> > > ⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_rstat_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__key_sig_kfunc_set, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__generic_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__common_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_map_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__cpumask_kfunc_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_syscall_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_skb, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_xdp, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_sock_addr, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_sk_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__xdp_metadata_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_test_modify_return_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__test_sk_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__tcp_cubic_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > > is_sym_kfunc_set(__BTF_ID__set8__bpf_mptcp_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > 
> > set->flags=0 here is odd. I'd expect at least some of those to be
> > non-zero. Can you check if your tree has
> > https://github.com/torvalds/linux/commit/6f3189f38a3e995232e028a4c341164c4aca1b20
> > ?
> 
> ⬢[acme@toolbox linux]$ git tag --contains 6f3189f38a3e995232e028a4c341164c4aca1b20
> v6.9-rc1
> v6.9-rc2
> v6.9-rc3
> v6.9-rc4
> v6.9-rc5
> v6.9-rc6
> v6.9-rc7
> ⬢[acme@toolbox linux]$ git log --oneline -1
> dd5a440a31fae6e4 (HEAD, tag: v6.9-rc7, torvalds/master) Linux 6.9-rc7
> ⬢[acme@toolbox linux]$
> 
> So now with a just built upstream kernel I get the output below, do you
> have patches for other tools to consume this? Or does, say, bpftrace
> already handles such decl tags, etc?

Yep, I have v3 of https://lore.kernel.org/bpf/cover.1707080349.git.dxu@dxuuu.xyz/
ready to send. The step after that bpftool patch is merged is
teach/simplify the bpf selftests. Long term once all the changes
propagate, it'll make bpf programmers workflows more efficient too.

bpftrace will probably make use of these tags in the future. We are
still working on our kfunc story (not supported yet).

[..]

> [135552] DECL_TAG 'bpf_kfunc' type_id=33061 component_idx=-1
> [135553] DECL_TAG 'bpf_kfunc' type_id=134975 component_idx=-1
> [135554] DECL_TAG 'bpf_kfunc' type_id=134971 component_idx=-1
> [135555] DECL_TAG 'bpf_kfunc' type_id=134972 component_idx=-1
> [135556] DECL_TAG 'bpf_kfunc' type_id=134970 component_idx=-1
> [135557] DECL_TAG 'bpf_kfunc' type_id=134974 component_idx=-1
> [135558] DECL_TAG 'bpf_kfunc' type_id=134969 component_idx=-1
> [135559] DECL_TAG 'bpf_kfunc' type_id=53825 component_idx=-1
> [135560] DECL_TAG 'bpf_kfunc' type_id=53827 component_idx=-1
> [135561] DECL_TAG 'bpf_kfunc' type_id=53824 component_idx=-1
> [135562] DECL_TAG 'bpf_kfunc' type_id=53831 component_idx=-1
> [135563] DECL_TAG 'bpf_kfunc' type_id=53829 component_idx=-1
> [135564] DECL_TAG 'bpf_kfunc' type_id=21317 component_idx=-1
> [135565] DECL_TAG 'bpf_kfunc' type_id=21315 component_idx=-1
> ⬢[acme@toolbox pahole]$

Glad it works!

Thanks,
Daniel

