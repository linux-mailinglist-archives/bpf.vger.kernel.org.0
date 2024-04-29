Return-Path: <bpf+bounces-28161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864348B645E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FAC1C21452
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9842018133A;
	Mon, 29 Apr 2024 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="cQfcMcfl"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F9178CD6;
	Mon, 29 Apr 2024 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425270; cv=none; b=h4mp4Kblbi8u9Xub+7oRPpakXoA/2Ik6i/IY3UoEICCU9nwJAFdCnjn/x1y/HS/F0Ey4pEKh0iZHbdTncDXZaXPDxREnrttmZdK2XAJ7eIXbp4guak2HzuFJMoG5eJhChefYnhsQLC+/8wgxOTR3EiApLMkBrKm0JkNMgJRGQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425270; c=relaxed/simple;
	bh=qwMpFbANwo0sRg8jCXwcgz2Sjr6QLfOlfxWy8Xy4z/E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=u5Y3nSfb5MfaMo5C+n6xSOr+nufNfYJJuEdoD0uwBVKEPT2yHFSB6a4f4huQ7steytpYiVSjF6Le3qAWZVQdFZAe7vsSxefOqiwdnDgdl7i6BCHpwNJmjfxVQDLGampccJElQrrpfPApAFCLpmZZVX4sDjMx1FLdD71LDDiYSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=cQfcMcfl; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aphzhpTKvWzgE0KCtMD7HJhk9kalpX6G2e4l9feR28Q=; b=cQfcMcfl/BOMDKUjn/yNwp5ZDT
	fSZBs71fxD/2I8HvAfUSCHlXxsBP0h2kxrsLMa046YIVfUqdiliLF/J5pFD6bNgBlh4c/aLspCOR0
	oCZsIu7qSFRMlinPu8HJFkQm7oHi3DmSa9bWXsbG4CDaiyOu+5RL+ARKpszPE1vM7sZ5UrFMKjDKL
	a0uEwLHSQpGdM8IhXxkZjYA38eeUAKpSvYW/msikHXyNwU5+BqXvN3KJb+jo1CKoeKJOAge+TtLSx
	mbftmL9fWlBhs4Kfgi64feLoAc5YT4z0NcqKd9wjW1s4ML7LxgsNT7CCCKCkhGdn1y4lb6VUMmyOJ
	1fYQtTVw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s1YJd-000B7Z-80; Mon, 29 Apr 2024 23:14:15 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s1YKE-00HQKq-1E;
	Mon, 29 Apr 2024 23:14:14 +0200
Subject: Re: pull-request: bpf-next 2024-04-29
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>
References: <20240429131657.19423-1-daniel@iogearbox.net>
 <20240429132207.58ecf430@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <799ac0bf-30ba-c9ab-ae10-1a941fa0f90f@iogearbox.net>
Date: Mon, 29 Apr 2024 23:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240429132207.58ecf430@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27260/Mon Apr 29 10:23:47 2024)

On 4/29/24 10:22 PM, Jakub Kicinski wrote:
> On Mon, 29 Apr 2024 15:16:57 +0200 Daniel Borkmann wrote:
>>        tools: Add ethtool.h header to tooling infra
> 
> Could you follow up to remove this header?
> Having to keep multiple headers in sync is annoying, and using
> 'make headers' or including in-tree headers directly is not rocket
> science.

[ Adding Tushar/Magnus, ptal. ]

