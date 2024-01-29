Return-Path: <bpf+bounces-20611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5586E840B19
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2828B2565A
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B33155A48;
	Mon, 29 Jan 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="kRXCDl+f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRlVmv8M"
X-Original-To: bpf@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED719155A2D
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544953; cv=none; b=H73kI5M+g4PYFgJjot/7oDpbqyuAlR/CVap7WkgdnDmYEH/vbrOhAgPKoUvh5IYDN4qzP/5RUiYj7N+RNS3Z4TcKK7530j6VpJ1yxBvG5xRq1SItSd8nM1j98IfC0oWAGjygWARiz7OWwo8IPI2v5Rxu5Z/a07+85DGy2unPhsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544953; c=relaxed/simple;
	bh=96Rzyfvad8NVNoN4YxNwRlg9KwplkkCMh3mRc5NLO1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoZYqijHvbCSbqbnXFXt+SkBtloR0+N4LFMruP9iXMLSWiuuPoDQGB59cQMUvDwLNLBqkvqFoROuM+3QGJ5pQNUjNUA4o6aEWh2EzkRbyALL4U34HA001NSxD/mNw6y8emmwo0kJOfYfa/GzmKsAdEbpyIKrqayP10rQ2BD6RkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=kRXCDl+f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRlVmv8M; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E6FB85C016A;
	Mon, 29 Jan 2024 11:15:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Jan 2024 11:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706544950; x=1706631350; bh=+WDgkjTf/d
	wZjp76TFG5vzjXoAXti/T9+y55u6gfJ+M=; b=kRXCDl+fR7nF/E7nRHT4wYWY0J
	b1AxguysSyV9M81elDqZbT7PQjj+OCyUJGAi1/Sqb/4yu9Rf27nIeKeqJPkyVIVZ
	oZEydrijSehLCrH1RsgAGQQM3lFnbdnLT+CIgFtTL2aqBtpe3x9yO5N6vfvEZyE2
	C1Z0RZ/HkeQCxrAwUjuJ+bn+oP5eMlfVvYAKUNjR986PotXFy5bUwiweEYTv5jPX
	altBBVoLEWDm0cP2q9twn0gsZlR7jvaUEO12kTN/7CCtdWJoywPERfrUK4E2c0hi
	+voHtrAac/YNV5lPfK1EosEVa/oWT+gQnZi3PMQF9X9ZDyTFpXfb/jY8kKtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706544950; x=1706631350; bh=+WDgkjTf/dwZjp76TFG5vzjXoAXt
	i/T9+y55u6gfJ+M=; b=KRlVmv8MANIKRpkvz/7c2auzssRMv8EdIul7koTlERPS
	5+j4uBp7g+cQd4H1AF+W90SVr5SwrV2KPv8hCMGURub33Kp8fWJoamvNsMR5FfI0
	Xq36r2jgZ6DIPs6qbi9a0qJAuXp6e6/lWDmptCyuUY9vGYL1TZO81qGcAwu9GN+y
	aD/XhSlfTyxESimGEiqGBaCrdkUsuA6GrgwRCU9N7iHXd5DU0MQpA17ZhYccWemG
	Zz0IhSv1UYtac8rTmcOpqpkAuxc1HvrLTOGpVrgyVg5kkt18alvYAUvMN3Ej1pDV
	no/cdzyfjE08xD3tVthpmkUPxFqdJDYMyPhjt4KbOg==
X-ME-Sender: <xms:Ns-3ZSDou-NVJe-XccYtdrRlyytF_lp6H_s5yqDB3c_Sqdyj54lenw>
    <xme:Ns-3ZcixBM9qJhWcTRT37w9fyPdkwH_Ki8BVzkUqHGAQVSfue_dFJL8_aNQtDli12
    vaElqQcXz6IjnDrlQ>
X-ME-Received: <xmr:Ns-3ZVm6eaiaNSkOgq67V7PyvMRyRulmiEelQ4jG-mBII8WTgYrX0quBaMc57aOhChwSk8fchjE1Dil8TQQz1_tCSByZN1aYXAHSJes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Ns-3ZQy6L1YH6qvfjbZcARxHY2AACqR_8i9Ge1k4eqgUrdGSZARIqA>
    <xmx:Ns-3ZXTDzLrOBfkDmR1_KUrZhv8cGwd_SOhCfL-FuLxq8saiyq3CJQ>
    <xmx:Ns-3ZbYMoMg72JuWY45v9K8xn_DD8rpNhRx6b3CCx49BSrMDPNbcYw>
    <xmx:Ns-3ZWGVcySqGG-1aJzRp2sCjfk89_eQqNH9xcKw4cKvwXz1DiNGTw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 11:15:49 -0500 (EST)
Date: Mon, 29 Jan 2024 09:15:48 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, jolsa@kernel.org, 
	quentin@isovalent.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3] pahole: Inject kfunc decl tags into BTF
Message-ID: <6wjvzdisn364fpoxruc5aefes5ujvgqcys4axp3sglk5mas4ot@vb6d5sqtsj2t>
References: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>
 <49da8aff-1ec7-b908-2167-ee499e7a857a@oracle.com>
 <Zbe1DfHjhZHwIKha@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbe1DfHjhZHwIKha@kernel.org>

Hi Alan, Arnaldo,

On Mon, Jan 29, 2024 at 11:24:13AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 29, 2024 at 01:05:05PM +0000, Alan Maguire escreveu:
> > This should probably be a BTF feature supported by --btf_features; that
> > way we'd have a mechanism to switch it off if needed. Can you look at
> > adding a "tag_kfunc" or whatever name suits into the btf_features[]
> > array in pahole.c?  Something like:
>  
> > 	BTF_FEATURE(tag_kfunc, btf_tag_kfunc, false),
>  
> > You'll also then need to add a btf_tag_kfunc boolean field to
> > struct conf_load, and generation of kfunc tags should then be guarded by
>  
> > if (conf_load->btf_tag_kfunc)
>  
> > ...so that the tags are added conditionally depending on whether
> > the user wants them.
>  
> > Then if a user specifies --btf_features=all or some subset of BTF
> > features including "tag_kfunc" they will get kfunc tags.
> 
> Agreed.

Ack. Will add for next rev.

>  
> > We probably should also move to using --btf_features instead of the
> > current combination of "--" parameters when pahole is bumped to v1.26.
> 
> Alan, talking about that, I guess we better tag v1.26 before merging
> this new kfunc work, wdyt?
> 
> - Arnaldo

