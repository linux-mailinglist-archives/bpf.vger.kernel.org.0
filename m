Return-Path: <bpf+bounces-30402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C38CD7B9
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143A02852E0
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA3F13AF9;
	Thu, 23 May 2024 15:51:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20197125AC;
	Thu, 23 May 2024 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479503; cv=none; b=aM8UGmyieodeg/nt9tznVqeuIBUzk1LmbpqbqQhVVRhV+nxK3FMPn6JFQWClHqeAaABRVohal43RHu7n2+4iLxRHqGlH0XSkc+SucIFLpQicwYijr5Q9dMNKuaYrKbuQ2z0c0mp+g+L1RrP48YPUgmmOTF0y+YYo8wkKFrItpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479503; c=relaxed/simple;
	bh=c+omJLXIaKohFU40Ei43xY+PMLmF+0y9NVZRG4jJmi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhWIh/8eEgdPgg6UQHWhrPEimNRKBXdx5mtpVGJE1wzZ3kQ8mwEkxBxdmMKXOmkSaW+Jb3pCfL9sZzZS8KqVXjBKGEy5493UXQgoLAlVIPxnYmmt5xzCyvMwcYBNcxKgQDgV6PS5p2Ws1pGDN+/BGSnpoLP/e0kZUTRRXV4Hudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Thu, 23 May 2024 17:51:36 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de,
	hawk@kernel.org, horms@kernel.org, donhunte@redhat.com,
	memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] netfilter: nf_tables: add flowtable map
 for xdp offload
Message-ID: <Zk9mCJIqMoWopQaA@calendula>
References: <cover.1716465377.git.lorenzo@kernel.org>
 <1925643414ddbea91659007826fd829f8aa56864.1716465377.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1925643414ddbea91659007826fd829f8aa56864.1716465377.git.lorenzo@kernel.org>

Hi Lorenzo,

On Thu, May 23, 2024 at 02:06:16PM +0200, Lorenzo Bianconi wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> This adds a small internal mapping table so that a new bpf (xdp) kfunc
> can perform lookups in a flowtable.
> 
> As-is, xdp program has access to the device pointer, but no way to do a
> lookup in a flowtable -- there is no way to obtain the needed struct
> without questionable stunts.
> 
> This allows to obtain an nf_flowtable pointer given a net_device
> structure.
> 
> In order to keep backward compatibility, the infrastructure allows the
> user to add a given device to multiple flowtables, but it will always
> return the first added mapping performing the lookup since it assumes
> the right configuration is 1:1 mapping between flowtables and net_devices.

Would it be possible to move this new code in _offload.c to
nf_flow_table_xdp.c?

The flowtable offload code is already a bit convoluted, the hardware
offload API for payload matching results in chatty with many sparse
warnings (unless I adds casting everywhere), but I remember I failed
to provide a convincing improvements on that front without requiring
changes to drivers at the time. This is of course no related to this
series.

