Return-Path: <bpf+bounces-45366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416C9D4C48
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D14D1F2155A
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE31D3562;
	Thu, 21 Nov 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AwNK8SED";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OQYcCsdD"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC61CEEB3
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189945; cv=none; b=bXUCXyT8HlTAHwxoV1aHNYyDYMJSmFqT9fXUv+7mQum2n3+ksNpj/+Dqq7na0jhenXIzjH6JVTdjpeE7YnqatI/AzgKoAECyKX6M74nx6G/snAKcTEnI7233vWApYJWLbyfMHWGmXAP3TSPx8kCO2GGr3+pnPvMsX5zaxTHVyVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189945; c=relaxed/simple;
	bh=NnoW7RCaJNS57gupSs3WZ5kzYCS03Pm7QLNnCfWtqKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEu/JCR7ze8glhQaEEpSfYyFtaBFav7+XZutfEsjqlV3X8Ik90Yds+YmbLTg+1ZbiJ8cWx3rSq4Tr2eeGCgKsrOEjeYrtuLy10Eppf81amJdzyogvtAL7HJWuAshIeP/hgNucRv6dI8UN8+zWb8xFKwwiLpi/561KcDYTChfitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AwNK8SED; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OQYcCsdD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Nov 2024 12:52:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732189941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4KKlNM8g685FXOE+FyH9mQrkclrVUa2UavF0Z2MVUM=;
	b=AwNK8SEDfzJyauCSBV+/CiN0LeVCaUrYiOcApsBs1tf/eVT+51v8803szKSEjVS3jWc8q+
	2lFBxvSfR8bUd7nae5dskk3+Y8tx8JzgQPvqoYLiikxkbdLxDTw4G1GLnLK5erciqds/f/
	ocQrgh+mDG18MpMWTB3cCCpcpyG/UkXG8KI4bgGgWkQVu3gRDP9JaaAuFC454Y25CGgWsU
	Ay86JrsveSrgqsEdglN2yx9KYskhlYyViBfm87uH30TSc/8hvFOj2+9vsRKf7XLWovxK2X
	joar7pj6o7dNUNF++sszsYgl0JRyV+Js5tayqh/sDIqf+73RpP+jn6RF1Ju5DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732189941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4KKlNM8g685FXOE+FyH9mQrkclrVUa2UavF0Z2MVUM=;
	b=OQYcCsdDUpbRk17/+O+WsPlR4P7TzeFDRocfqOjWdNScmMHz24HTNJOT7PWCxl/1v7CyYy
	pnQl7oQE4rgW4lDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 07/10] bpf: Switch to bpf mem allocator for LPM
 trie
Message-ID: <20241121124649-bc310634-8cc9-464e-bb81-6a9ad0f8e136@linutronix.de>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-8-houtao@huaweicloud.com>
 <8734jkizoj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734jkizoj.fsf@toke.dk>

On Thu, Nov 21, 2024 at 12:39:08PM +0100, Toke Høiland-Jørgensen wrote:
> Hou Tao <houtao@huaweicloud.com> writes:
> 
> > Fix these warnings by replacing kmalloc()/kfree()/kfree_rcu() with
> > equivalent bpf memory allocator APIs. Since intermediate node and leaf
> > node have fixed sizes, fixed-size allocation APIs are used.
> >
> > Two aspects of this change require explanation:
> >
> > 1. A new flag LPM_TREE_NODE_FLAG_ALLOC_LEAF is added to track the
> >    original allocator. This is necessary because during deletion, a leaf
> >    node may be used as an intermediate node. These nodes must be freed
> >    through the leaf allocator.
> > 2. The intermediate node allocator and leaf node allocator may be merged
> >    because value_size for LPM trie is usually small. The merging reduces
> >    the memory overhead of bpf memory allocator.
> 
> This seems like an awfully complicated way to fix this. Couldn't we just
> move the node allocations in trie_update_elem() out so they happen
> before the trie lock is taken instead?

The problematic lock nesting is not between the trie lock and the
allocator lock but between each of them and any other lock in the kernel.
BPF programs can be called from any context through tracepoints.
In this specific case the issue was a tracepoint executed under the
workqueue lock.


Thomas

