Return-Path: <bpf+bounces-12888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5EF7D1A53
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88984282789
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D427A806;
	Sat, 21 Oct 2023 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlrsUXPQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990F7EA;
	Sat, 21 Oct 2023 01:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA00C433C8;
	Sat, 21 Oct 2023 01:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697852502;
	bh=o4yj0YMZx8poXrRL6Bs/UWmx2BDcoKNM+4/vIFhrYdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TlrsUXPQx5Gbav1kH0EhcICB38FwZcWm+NUpaMgTlomh6RgfUW9bsAQ03Dncvxlad
	 bJqAs4SmP0nHYipOkQ6V99ek3qVXz+qhaEiC9BE5v+wqf977vq6ZMzgQ4fELSC+o7G
	 LEUbGjgcCg4tgBLM2Q+YIY63RqhO60Y76ZQtc/JGUpD2LUCNPyiOTmWAIueIPGxUxC
	 vX/B9B3pYhgCFbfwogwOoF+zpbTejRd/UM00z1UL/vu9ncsvjg/VTfVKqGk8cH4/Ms
	 ZwXZyk6iLPJZ/SbX+89WOC+wJROvJShfTI0yNXUffTYlnpct5fl3gsrJG+Jk4pKVEB
	 f9W/y74XHm5BQ==
Date: Fri, 20 Oct 2023 18:41:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, toke@kernel.org
Subject: Re: [PATCH bpf-next v2 1/7] netkit, bpf: Add bpf programmable net
 device
Message-ID: <20231020184141.4b3dad9f@kernel.org>
In-Reply-To: <20231019204919.4203-2-daniel@iogearbox.net>
References: <20231019204919.4203-1-daniel@iogearbox.net>
	<20231019204919.4203-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 22:49:13 +0200 Daniel Borkmann wrote:
> +	if (ifmp && tbp[IFLA_IFNAME]) {
> +		nla_strscpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
> +		name_assign_type = NET_NAME_USER;
> +	} else {
> +		snprintf(ifname, IFNAMSIZ, "nk%%d");

strscpy()? 

> +	nkl = kzalloc(sizeof(*nkl), GFP_USER);

GFP_KERNEL_ACCOUNT is prolly what you want, no?

