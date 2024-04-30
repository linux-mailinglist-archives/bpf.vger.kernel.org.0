Return-Path: <bpf+bounces-28305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E88B8303
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 01:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A971AB21AC8
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8601C0DC7;
	Tue, 30 Apr 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ATYNk794";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CgV7s0av"
X-Original-To: bpf@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCFF29A2
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519777; cv=none; b=AkGl04v0VOm9n9F8/MZs69Lfk1vYMysImBZkM2c9R11JWlrpXsq71XcgrW2lGNSLqb4lIHCSgc4Ym9fWAHWsNQEgCIcnxLSVToHjILJP8MJKH3BzwfQ4Wdn6C7gookiMaqZkinVAKDCDA25OQD6XIF/3ex0CqKSg4KQY0ZzCNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519777; c=relaxed/simple;
	bh=BaF1lZHFGScGucJHwZTz1NuGpMZOt8jXBP/CO9pfG1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHgOqXachfs3SiZMWv5Xf1l9zjnuEpHJ0JMDHXrLxbj749lDv+2yGSFryN0oOmcf29dnmPv7aIdDgfaRtI5PBJQcXOfphlSDaObfjdVk6k5+dqKx0XbYwGfLmoS20/aWXQCgdZrHg7JFl5QP+P8+m/iXdyaFEoogdLvBbReMfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ATYNk794; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CgV7s0av; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id E7EED1C00146;
	Tue, 30 Apr 2024 19:29:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 19:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714519773; x=1714606173; bh=aq+6FSPs+h
	vKLMIWDYssIribjWWIG+u0C0st8Ozi3BM=; b=ATYNk794WgjOhPLD9NXD7Y+KnF
	JIIIgjYgIUZsaeYLhgcRQoDO89L5zZqH4zxh/i+Sc6k5TeNA46HmHPVar8pjbwiD
	qi1HPD3/GMP+yyaBGno3khof8MjIg2LWfo3qCGHLVyfgzZa3z2yhzM7zOVWV2a8X
	zU/BkgBZiMx+pABZU0fkVMDrrQAWvVix9me9UoInjAQMjEU2eH7c8dorFrtm9y6I
	97oKfj+sJd1x8yx6un5bLz34E29NW7fo6mnZ9PWk8Ei2YZx+jJXutK8r+5bQon2l
	dMCNziqGMXuoQq69JqQ8eTk8o10hYugSLSxaqjkAjFAVPqs25vOBYnNhOIJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714519773; x=1714606173; bh=aq+6FSPs+hvKLMIWDYssIribjWWI
	G+u0C0st8Ozi3BM=; b=CgV7s0avL/X7J+RDUZgyUqN0iYIc+h27hpgTtu9hcwbb
	g/75z45rRYaoO9YEEyzEWoqHrN6lsQ2OrbZCluWBb4d6Qy95xa1p95IM6nSC4MrY
	18ut4bB7OZIFNlnf28NhKQ7Lp9xAr7i8F6uY5MIoFtsseAMYUo8JaORKFlEvH3fy
	7HqnsR/MNQ6tNlRUdjcNS+PxAdKzPAw7UlGz2wOaN3ahLaB/kiMFUrOwPBCADHT7
	uKgDBwSrtz4RMd6xwPgVCUnuzUqI+f/C7V0glTn5vq4njn4WsI6qny6U7JJ/XCcq
	ISXrjmYUrRHRA/EVsZ1/VQAz1PEHA4XDCCc0NR5S/Q==
X-ME-Sender: <xms:3X4xZu2WL7rIqUHRkamIiY9Y3l3I0BxxgevTFtsd03fZwxYr7xxk4g>
    <xme:3X4xZhFNTvgMJtD36vsYEt1FKM_jiWpR46En-TdW0Gx81pDyZ5cvuU01TFTYJ_IeI
    UdcM8omcAI4FbMsEA>
X-ME-Received: <xmr:3X4xZm5uoNMhv92R6omDc9pcVBxO38GQP2y_AExcsLZQvBYlzZvlIj-X7Aroa-yaR5oOLRMU8kHmiKQcSogr2Kzng93BfADJwBKN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeige
    dtheefffekuedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:3X4xZv1E0bSpHaEG-hyb7Fss48exz1xGCboP4TicJJJG0kiBOepwZQ>
    <xmx:3X4xZhFylTzwSwpWRk0FMyxMxNzZRb-fq55n4gXaqs5-3BtY4Srrhw>
    <xmx:3X4xZo9zr3axaFcqSMsUzEbMteid6sJ_CvOFsXhMLe_lilRnfE8m2A>
    <xmx:3X4xZmk_-CZrdz9K2K0t-uqmYU2ZNv64U96NkvurrXFpdknzfquDQA>
    <xmx:3X4xZgCfZcvh7r1XdOq8P31uWLtNXeLcvWx1FSWXYKied0OD4Z5AsaM1>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 19:29:32 -0400 (EDT)
Date: Tue, 30 Apr 2024 17:29:31 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com, 
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 3/3] pahole: Inject kfunc decl tags into BTF
Message-ID: <poooh5vz2ua27i2lmfqczvwsxq4qfukwgivpoxiczyjovxaouc@26anentddvef>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <26ec519a00aa47f25bc6b4c7e4e15e5191ba4d45.1714430735.git.dxu@dxuuu.xyz>
 <ZjFNJmfq-DKQYx9K@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjFNJmfq-DKQYx9K@x1>

On Tue, Apr 30, 2024 at 04:57:26PM GMT, Arnaldo Carvalho de Melo wrote:
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
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Tested-by: Jiri Olsa <jolsa@kernel.org>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> Here I needed this to avoid an strdup possibly followed by a free and
> then checking the strdup result, please Ack/revalidate tags. I'm
> dropping them as there are changes.
> 
> - Arnaldo
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e9d82e0af0e178fd..c2df2bc7a374447b 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1434,11 +1434,13 @@ static char *get_func_name(const char *sym)
>  		return NULL;
>  
>  	/* Strip prefix and handle malformed input such as  __BTF_ID__func___ */
> -	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> -	if (!strstr(func, "__")) {
> -                free(func);
> +	const char *func_sans_prefix = sym + sizeof(BTF_ID_FUNC_PFX) - 1;
> +	if (!strstr(func_sans_prefix, "__"))
>                  return NULL;
> -        }
> +
> +	func = strdup(func_sans_prefix);
> +	if (!func)
> +		return NULL;
>  
>  	/* Strip suffix */
>  	end = strrchr(func, '_');

Thanks, that looks good to me. Please lemme know if I should re-spin.

Otherwise,

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

