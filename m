Return-Path: <bpf+bounces-28304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B438B8300
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 01:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79CEBB216ED
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCAF1C0DD1;
	Tue, 30 Apr 2024 23:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="PJ9tVJrC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ETGURmtv"
X-Original-To: bpf@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433329A2
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519651; cv=none; b=K6wRKDg9eYU7t6X/MTmTlhW5h1Sydd9em/TD6Ws0EdJyLViLpYvSOo430P1bwVaEYK7N4WIE0hkooeR9VrveKZxRas4JWBRBtHQZfnFhgsQ6td/zf6Q8IzhITXdMRozVhYKh8JS0WxEla5Oxcx8zLoAoguzx/GY2VuXwPhtDnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519651; c=relaxed/simple;
	bh=9aYGL/PLGNd45wGOkNy7nNv4NWuo5pD6q46cUup4Hvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlwbT0r+ZeNUY0C3UedlLsCY8jn05aFonHhJmlkC/oV2iGeUqShH2faapwOwO8/EFNuBgUdpvC7H/30m3WxZqgDO3is4hcuXV9SrI7e8VuqZDM1EtWxicWCu9kD+0Gs38QfRm2pSwjTCPimJUN0Qtj3/kSiYZZzLkB1P3ozNNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=PJ9tVJrC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ETGURmtv; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 2002D1C00115;
	Tue, 30 Apr 2024 19:27:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 19:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714519647;
	 x=1714606047; bh=67d2YD4vbDSNz7aILrlKEw1ZBVF/Ytzjq87GsZQtE4o=; b=
	PJ9tVJrCj6VNmjCFPkDr42eKBgDzLTvtlPzGLOPalMlgqmURkv/9JTEFNQkaumaK
	EAeKk4qjmKI3FRuv9tmXjz+NIo62UHOCTj75DedfD4gu5onH+elTdblCXFx106hW
	mOEQPOHtUmhAEBFEgPUWay/sjNxNG1L/+8OJyiOMPUvtkFUn8lUu14niqOcxm7QB
	0dVtB0ITTm4hG6cki8tqRb4a4L5Fza8DYniD2bMQ2kBxITCJS5CmD/kqWbLKFsc3
	DyjK8eZQFdeimVye/Ac7x15VrUMMoYeJCNKp/eMbPN2quFMRvOy+IQBX/ccjKgSE
	MSba2qRT6tTndwPElqb3Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714519647; x=
	1714606047; bh=67d2YD4vbDSNz7aILrlKEw1ZBVF/Ytzjq87GsZQtE4o=; b=E
	TGURmtvWBJxKlXIq5N8cjPzKRUsF9ad+7SFibZBbj1M8jiQWKtiJ6hniI2gw8EHo
	9PcLsEEa89Q+xLH4fXp3Z5mRvOupBP24mp5us1pnUiQy/2lxR/2+HQMQElaw46DS
	rCJfHAXb+Iq0bHlb/P6nTJQoxqHCoFtm6AsaX7EuYl9/NoXVFY3cJ1K9qeZ8JNl4
	PZQ58BwUBNtpvBbRCer1wJP1+zzNdO9eNHRrBdil9AGr0scXpCbjpDDK6xjHAoC+
	Ffx8dTDQ8f7+dfJznmdyN6RdUJlh/F5/ouBdo3x7vuuMnh5lH8UK0EHK7gPaLFT8
	xt44TAdnTfJeUpwdyC5IA==
X-ME-Sender: <xms:X34xZiDRu0AojGwEmjdWo3GH5mx5ssT07ivkJEG2T1ldCK6jhpaAbQ>
    <xme:X34xZsjmUB-aq_ZF5jne_9PtrQTTe-NXcitQqPyD-PhlNiu-ktyhoezYFoL0teum4
    -noCFRcM7Q4SrBirw>
X-ME-Received: <xmr:X34xZllLiizG4TnijuU0MfcnxdtlsDJHoN-Bh5WJdk0sxZUJGc-iC2gSH_CBJqdXsdwqxc6EbSCHHpcDCEyeaox0fP_tiK16dweE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpeffhf
    fvvefukfhfgggtugfgjgestheksfdttddtjeenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeffffeggeekjedvje
    egheetkeduhffgfeegveeklefhgeeuleejhfeljedtkeevffenucffohhmrghinhepghhi
    thhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:X34xZgx3gx9kpppM0anW8Fhj4Qmw8qP1xCEdpwKqn2BXKNldkpXHBw>
    <xmx:X34xZnQ8QuvnkEq2Xok6mbksKx3dqmjFqDTzu-7WIARv52limScPlA>
    <xmx:X34xZraRWoHm_cZdCXt-eeXvXHHnL97H_PeLRHnnw_ELfjH2M8ew-Q>
    <xmx:X34xZgQg3wxHj_BalcUCUzjmpq2bpKZoIWQt-8SE5lCCKckyPKkFXA>
    <xmx:X34xZs9y1JVwy0bmpxZiaFfjbHcg5yQ5cMJYXxSx0EA7t8fWJRzXZv3x>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 19:27:26 -0400 (EDT)
Date: Tue, 30 Apr 2024 17:27:24 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com, 
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 3/3] pahole: Inject kfunc decl tags into BTF
Message-ID: <zdag4h7ztmwn56yrmieisbhno4gpb24k7rgjevp6gc46e5dxak@3stxrh2qfnlu>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <26ec519a00aa47f25bc6b4c7e4e15e5191ba4d45.1714430735.git.dxu@dxuuu.xyz>
 <ZjFXpgRjpDyDnvdc@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjFXpgRjpDyDnvdc@x1>

On Tue, Apr 30, 2024 at 05:42:14PM GMT, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 29, 2024 at 04:46:00PM -0600, Daniel Xu wrote:
> > This commit teaches pahole to parse symbols in .BTF_ids section in
> > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > 
> > Example of encoding:
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
> >         121
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
> >         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
> >         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> > 
> > This enables downstream users and tools to dynamically discover which
> > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > available in /sys/kernel/btf.
> > 
> > This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> 
> I'm trying this but:
> 
> ⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> btf_encoder__tag_kfuncs(cgroup_rstat_updated): found=0
> btf_encoder__tag_kfuncs(cgroup_rstat_flush): found=0
> btf_encoder__tag_kfuncs(security_file_permission): found=0
> btf_encoder__tag_kfuncs(security_inode_getattr): found=0
> btf_encoder__tag_kfuncs(security_file_open): found=0
> btf_encoder__tag_kfuncs(security_path_truncate): found=0
> btf_encoder__tag_kfuncs(vfs_truncate): found=0
> btf_encoder__tag_kfuncs(vfs_fallocate): found=0
> btf_encoder__tag_kfuncs(dentry_open): found=0
> btf_encoder__tag_kfuncs(vfs_getattr): found=0
> btf_encoder__tag_kfuncs(filp_close): found=0
> btf_encoder__tag_kfuncs(bpf_lookup_user_key): found=0
> btf_encoder__tag_kfuncs(bpf_lookup_system_key): found=0
> btf_encoder__tag_kfuncs(bpf_key_put): found=0
> btf_encoder__tag_kfuncs(bpf_verify_pkcs7_signature): found=0
> btf_encoder__tag_kfuncs(bpf_obj_new_impl): found=0
> <SNIP all with found=0>
> 
> With:
> 
> ⬢[acme@toolbox pahole]$ git diff -U16
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c2df2bc7a374447b..27a16d6564381b60 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1689,32 +1689,35 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  		func = get_func_name(name);
>  		if (!func)
>  			continue;
>  
>  		/* Check if function belongs to a kfunc set */
>  		ranges = gobuffer__entries(&btf_kfunc_ranges);
>  		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
>  		found = false;
>  		for (j = 0; j < ranges_cnt; j++) {
>  			size_t addr = sym.st_value;
>  
>  			if (ranges[j].start <= addr && addr < ranges[j].end) {
>  				found = true;
>  				break;
>  			}
>  		}
> +
> +		printf("%s(%s): found=%d\n", __func__, func, found);
> +
>  		if (!found) {
>  			free(func);
>  			continue;
>  		}
>  
>  		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
>  		if (err) {
>  			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
>  			free(func);
>  			goto out;
>  		}
>  		free(func);
>  	}
>  
>  	err = 0;
>  out:
> 
> --------------
> 
> The vmlinux I'm testing on has the kfuncs, etc, as we can see with:
> 
> ⬢[acme@toolbox pahole]$ readelf -sW vmlinux | grep __BTF_ID__func__ | wc -l
> 517
> ⬢[acme@toolbox pahole]$ readelf -sW vmlinux | grep __BTF_ID__func__ | tail
>  97887: ffffffff83266bfc     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_cong_avoid__805493
>  97888: ffffffff83266c04     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_state__806494
>  97889: ffffffff83266c0c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_cwnd_event__807495
>  97890: ffffffff83266c14     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_acked__808496
>  98068: ffffffff83266c24     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_ssthresh__773199
>  98069: ffffffff83266c2c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_cong_avoid__774200
>  98070: ffffffff83266c34     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_undo_cwnd__775201
>  98071: ffffffff83266c3c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_slow_start__776202
>  98072: ffffffff83266c44     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_cong_avoid_ai__777203
> 101522: ffffffff83266c5c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__update_socket_protocol__80024
> ⬢[acme@toolbox pahole]$
> 
> 
> So that btf_encoder__tag_kfuncs() isn't finding any?
> 
> $ pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> btf_encoder__tag_kfuncs(vmlinux)
> 
> Yeah, getting the source filename, the right one.
> 
> Then is_sym_kfunc_set() never returns true... But:
> 
> ⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> is_sym_kfunc_set(__BTF_ID__set8__bpf_rstat_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__key_sig_kfunc_set, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__generic_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__common_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_map_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__cpumask_kfunc_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_syscall_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_skb, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_xdp, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_sock_addr, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_sk_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__xdp_metadata_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_test_modify_return_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__test_sk_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__tcp_cubic_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_mptcp_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> 
> real	0m5.586s
> user	0m29.707s
> sys	0m2.160s
> ⬢[acme@toolbox pahole]$
> 
> And then:
> 
> ⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> is_sym_kfunc_set(__BTF_ID__set8__bpf_rstat_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__key_sig_kfunc_set, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__generic_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__common_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_map_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__cpumask_kfunc_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_syscall_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_skb, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_xdp, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_sock_addr, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_sk_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__xdp_metadata_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_test_modify_return_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__test_sk_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__tcp_cubic_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> is_sym_kfunc_set(__BTF_ID__set8__bpf_mptcp_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)

set->flags=0 here is odd. I'd expect at least some of those to be
non-zero. Can you check if your tree has
https://github.com/torvalds/linux/commit/6f3189f38a3e995232e028a4c341164c4aca1b20
?

Thanks,
Daniel

