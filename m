Return-Path: <bpf+bounces-28198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE598B65D8
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686AD2835DB
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90E1863C;
	Mon, 29 Apr 2024 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="MuV2UJ9X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqEMH4lH"
X-Original-To: bpf@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABE13AEE
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430334; cv=none; b=oysShPuurpmQ5w0tC160HEnRVIus+7yRvQMDXhedL8ir+ouyEeGHDNyL0QqZJ9aw405XsYZIwgD+U65S64bRNjKVaQycL8Mooa/N5eI2UOT1eAZmm/mI67dIfyfXv+S8YMJimfmxpBNxEiI1UXz1E8bpmlvlKBzKq3CVReXQJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430334; c=relaxed/simple;
	bh=L2H/VXKEcnZ6dNhiG4RME9x9ZNzretqZRI3xEbxwLKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRux1lBAwXsLlukH71MCT7Dvn+6OFQKaIYPxJdZa036S2z/AqI4k8FWE1u5whxMRTA0wZHA0jRI1RXRla5fkB/bwnXDt+eqRqXCgp2foME2fC3M05PSEb7DbQ4pFpze0LJt0txuRoEXJbfFzrAe78cTmIQlqJ1x2vRvbv0Fnn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=MuV2UJ9X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqEMH4lH; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 1E0481C00078;
	Mon, 29 Apr 2024 18:38:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Apr 2024 18:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714430330; x=1714516730; bh=Kgg0UpHu09
	AiI/dMdHdyXPjeP2iT0c4JDG/qJR9bzcg=; b=MuV2UJ9XOZRN2zVUhUidptei18
	fr3qCWGzVpIWvDN6jlEB1wP8bbhc3Xk4OqY13m/57MS6zEBKejCu12npfQ3ojEeY
	RW163PkhRcjPJbVbrU89aAaGUkMIuouhmm3lDlswFaiyXwnDC6sPVZCvNAXJxMZe
	rbXNkWtVH0VoQurAW5tbyxpmwaY0b7lKck0z58B4112iTxRK+tDPW8daEL2L3eXk
	j4NeuueIJ1/hIAOmJpPNPVY4BPnxCH3zXUji72bwZK7DANJhO5R0a3/5qRk2VcSu
	qP0a/cyFK3ZZRZ+X1mdE6wdK1owcvBqmGdjh62F5SsDFTOiErE3GXX5udFVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714430330; x=1714516730; bh=Kgg0UpHu09AiI/dMdHdyXPjeP2iT
	0c4JDG/qJR9bzcg=; b=gqEMH4lHTg0WVL3MXRpT4e7E/BJ9NhbYya17oxY+jr/m
	qF/pL2n/jmp66Sota9EkPWSCXzUl6obhRaTr/LXg3giULI337Z0ltGZvYzzpb9b/
	CIeMiUb9RlMixfWXF4xSN5HVtebkx562y5VoKoLwMhLDhMJ8xB1hAPzB3PObid+H
	92T4oJ6tQBsALMFUKAt0NyUT1PrALg9B94q0QGEhRsZTHL+31kTh/8OwzkG2sLrK
	MsNzgrzysVZa78Xi5brhlQ4dNNPE589YxqimMX8sQ8mK94A0L7m4Xvsje7Tr7io+
	5qKepelI9+eTENQ7a3QSnQOeQ87+LVOCm8V+NoX3Kg==
X-ME-Sender: <xms:eiEwZuLyivZ52ZGhiCTacJP5pl0FxIGHFTGBAV0o24rBojxxTNjD8g>
    <xme:eiEwZmKSrvucvv7BHZ9trJsSf0fE767pSzn6cuWy9zoLTBuon0zktx-Ly6Sr2faqf
    NoYsv66XmLy0PSO5A>
X-ME-Received: <xmr:eiEwZuu3kOb5jdNiaOzpcGxAH89lj9pnDDYNwGlV5631fd-fqSX7TZE5oW5pu2-TikBXXh5ViRINHfcUq7e58nTw_91Box_LskXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdejkeduleeitedvfe
    egvdegjeehhfdvgffgjeduuedtgeevieevtdfhheefleeknecuffhomhgrihhnpehgihht
    hhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:eiEwZjbdYsy-KdvdhsZVHmmpBcSBABp1st6JWJ_7ElGxBThZogAFFQ>
    <xmx:eiEwZlZ44tZEAieYdrsVi8sB9KhxelP4Kbhknq0MQM4jPsGEVqlwPg>
    <xmx:eiEwZvAcufoIuxJ9hoUZDLv4ez9hEaTIVeeGQ235y89Ypp-_GVf9ug>
    <xmx:eiEwZraDrlAVVuSNIBmubG5CX2mZlz4UhjJIbR27kDrGd_n4XWGI0g>
    <xmx:eiEwZnm3YUQ1ELLijHuDJzbqpHCdTGRvy57ffI0GeiefLgy1_b2aXU8E>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 18:38:49 -0400 (EDT)
Date: Mon, 29 Apr 2024 16:38:48 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com, 
	alan.maguire@oracle.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v8 3/3] pahole: Inject kfunc decl tags into BTF
Message-ID: <wtvaeidnvqqby7leeiqnlph4rlfdnvpgiomvmclr3bsoelgspk@okdfmcfgqmsh>
References: <cover.1714091281.git.dxu@dxuuu.xyz>
 <1f82795e9ae651a3d303d498e2ce71540170b781.1714091281.git.dxu@dxuuu.xyz>
 <40cce745854cf1fd0ea63b2e636828c87442a21d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40cce745854cf1fd0ea63b2e636828c87442a21d.camel@gmail.com>

Hi Eduard,

On Fri, Apr 26, 2024 at 04:47:53PM GMT, Eduard Zingerman wrote:
> On Thu, 2024-04-25 at 18:28 -0600, Daniel Xu wrote:
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
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Tested-by: Jiri Olsa <jolsa@kernel.org>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> 
> I tested this patch-set on current master with Makefile.btf modified
> to have --btf_features=+decl_tag_kfuncs, the tests are passing.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> (But please fix get_func_name...)
> 
> [...]
> 
> > +static char *get_func_name(const char *sym)
> > +{
> > +	char *func, *end;
> > +
> > +	/* Example input: __BTF_ID__func__vfs_close__1
> > +	 *
> > +	 * The goal is to strip the prefix and suffix such that we only
> > +	 * return vfs_close.
> > +	 */
> > +
> > +	if (!strstarts(sym, BTF_ID_FUNC_PFX))
> > +		return NULL;
> > +
> > +	/* Strip prefix and handle malformed input such as  __BTF_ID__func___ */
> > +	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> > +	if (strlen(func) < 2) {
> > +                free(func);
> > +                return NULL;
> > +        }
> > +
> > +	/* Strip suffix */
> > +	end = strrchr(func, '_');
> > +	if (!end || *(end - 1) != '_') {
> 
> Sorry, I'm complaining about this silly function again...
> This will do an invalid read for input like "__BTF_ID__func___a":
> - 'func' would be a result of strdup("_a");
> - 'end' would point to the first character of 'func';
> - 'end - 1' would point outside of 'func'.
> 
> Here is a repro with valgrind report:
> https://gist.github.com/eddyz87/dfd653ada6584b7b7563fbfe66355eae

Ah, yes. Good catch. I think this diff should do it:

diff --git a/btf_encoder.c b/btf_encoder.c
index 02f0cbb..6cb0c8f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1435,7 +1435,7 @@ static char *get_func_name(const char *sym)

        /* Strip prefix and handle malformed input such as  __BTF_ID__func___ */
        func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
-       if (strlen(func) < 2) {
+       if (!strstr(func, "__")) {
                 free(func);
                 return NULL;
         }

I'll respin.

Thanks,
Daniel

