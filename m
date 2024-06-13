Return-Path: <bpf+bounces-32095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB5490767A
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 17:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103C61F237CD
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F83149DFD;
	Thu, 13 Jun 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="jQY42aii";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S39dDXl0"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98C13CF85;
	Thu, 13 Jun 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292171; cv=none; b=eyJiRC0/7nZ3tCSmd7FH8P2tbLQOw2BvtLbyFIJA0Fx2yn4J05fysV30rVxt2CZow0peJhkIYcRBaLdddCeXK8B3hLl5I9mP8c6qeUs7CsBiZEDNY6GziIRNAfhkfq/6iinkDDxc6ewQXNONmg4rPt4kvDJLUHj3xExs0iDLLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292171; c=relaxed/simple;
	bh=qLFWh1U9jaUWDO9WRBPcNLWKrgZ7z6IUsDlCbyKOfak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9R+KdV0VOB7bxnI3eXp/9ZGibMxVJxS6zr/+6OKOrWFN5XpsOP1wqwQ8cT2/30OBf055igasNkoKsb3mvdDLhnddDY7g5MRbN7sqVawTzQIuPpH2ZK4wn3iEE/ItEG5IUfPlq8tCJEHDHL2YqO7AuNe3v3eLDU11NyrInHep6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=jQY42aii; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S39dDXl0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 046031140151;
	Thu, 13 Jun 2024 11:22:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Jun 2024 11:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718292169; x=1718378569; bh=TulpzQT49Q
	EA7WtUk72+PFYGe8eurHLi82GVa+TZ26I=; b=jQY42aiiNIoQOBpU7dHLqzO2V9
	O4+CjZ8K4tcf/LK0i9JT+eWL/jhO90ZbL1+D+ZBcjtyEiXiysZkr7ErSBVEF89VJ
	IfZgXPEVCijuGi0cQYA8sR59jpvfYLzXsl/hMXRh73hI/LPMU0/S6tcbm9TMzLJ4
	T/mGMvnxPmMxT3pEuIwjdEJTIYyclnEnzCzU6lADs6P2fy7gqTQJmcpY7L90l6ed
	8617Q7j3kjyG7jYx6rT/w07i11P3dtlAGbJQFwcA8hOZx7gT7waxZgXleVTcFpsN
	c7aJld78KA1kmsy2uQIxunfdDZVyH3BDZEpUXjfveGXAlJhijtYcO40zMXIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718292169; x=1718378569; bh=TulpzQT49QEA7WtUk72+PFYGe8eu
	rHLi82GVa+TZ26I=; b=S39dDXl0m8ySdgkIFWaa4mdR+sW8epKX3LxDuvnXENeh
	2/VG826/mzcnTmgWqXFT7Vzxy2ez4ndQKnZn41Yza4+7fWpj0l4vuHpvI+rYxzV2
	yslfJ+U+Z37g5TyZQyedUZ+l6c9WpU7YmFNLyNKjxC1eIQCWLwYAjVt/bKquIIuD
	UJu8ggSfCWu+uLdVTXDy/PKM5xSef1YVlKTYJA6IjZrVfqfvkBw2OW+i6B/7b3nc
	KL4/hVZvZ/z6ygDd3UBpif4mxtCrqXpfeDKaMJudsDZxcThHunb8R7IFSvXtUHpJ
	DROWrjL8Vi7ossYtsDi3JdIBcfingmdgQm/BUIdgdQ==
X-ME-Sender: <xms:yA5rZjmgN9pVH4nA0yttijF2C0lieS_P_J1IfgwFbTKP9eMkHEwSmA>
    <xme:yA5rZm2KJE6hkEbWVljnW1OvbWcRix4DW0mafcy6FVKHZv39sWUxoOiO_Tt1MhLM-
    Xz94PxDTDqUbA3foQ>
X-ME-Received: <xmr:yA5rZpo2yTN97SK027dENUSXxHIL7ShdyHhOONeOWJR_QZBDCjW25Z9r8MqUoRyQqQYCouD1t0BS9iRBRAhuPFUeXFVau56PBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:yA5rZrkHlvo_7veytHQzZyoYXNqh6E-M7qkuOeygVS6B66XDhVNx4w>
    <xmx:yA5rZh1EoUVTConfGA7Qh4nq615h1kOVv6XHp-jWu_rDterD0BXkqw>
    <xmx:yA5rZquqfvrGZ80MCkyLrX5cK5KHNAhoawgkjybA7-DUztOs74UObw>
    <xmx:yA5rZlXehYdwLKcvUhrKssRiz2SP_K8rxDQbC44cSut55FM0zSFBbQ>
    <xmx:yA5rZqL5-m2Zdry3bflnZDmYnrBBlE9epTy4t3wcUr7PHpLtIoShskkM>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 11:22:47 -0400 (EDT)
Date: Thu, 13 Jun 2024 09:22:46 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the bpf-next tree
Message-ID: <a4ottbruejm5wssdhgo7tqeopfmpiv7trvc44dogbwuesxwbwi@f22dnl5qxfcf>
References: <20240613144239.29675ebc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613144239.29675ebc@canb.auug.org.au>

Hi Stephen,

On Thu, Jun 13, 2024 at 02:42:39PM GMT, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bpf-next tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> kernel/bpf/helpers.c:2464: warning: Excess function parameter 'ptr' description in 'bpf_dynptr_slice'
> kernel/bpf/helpers.c:2549: warning: Excess function parameter 'ptr' description in 'bpf_dynptr_slice_rdwr'
> 
> Introduced by commit
> 
>   cce4c40b9606 ("bpf: treewide: Align kfunc signatures to prog point-of-view")
> 
> -- 
> Cheers,
> Stephen Rothwell

Thanks for reporting. I'll send a fix today.

Daniel



