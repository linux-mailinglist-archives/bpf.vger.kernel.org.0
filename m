Return-Path: <bpf+bounces-69309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC9B93D66
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8F514E1157
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB91723AB94;
	Tue, 23 Sep 2025 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kygEdYQU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58623815C;
	Tue, 23 Sep 2025 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590813; cv=none; b=KMvePBgUWg1mjU1vBCgYENZzLreKtl3FwtVbWUFRB4Bkptf1E4ViNS2QWs6rg6gtY0N5l3i8t3GszaMKcEx1/z/xwsaXB8MmK0+B+qqY6eClFW9fzHrYyjxaD78Ik0c42JbFqulEknpsiUcF3kjR+TMC/ZRCv1N4Dhd/kUYk3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590813; c=relaxed/simple;
	bh=HtLJWt3Az3q5FGnVm8doJruQbgKs/1f81/npuya51HM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1rQr6C6E8XcKgsBVm+DkHH4NJQ4F1/ihosn8RpxYZIX4qbeeXPVoeAihhiG2VAJUmr4Eil7ACxhmS/zodIWro36fYy1XXakktFTYDQ/J0kO/pr112QMA32HBSsYRXP2gJRDnJWDNTGlrEgMK1xQZgdOJWzJux1+qBMswso+wiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kygEdYQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66287C4CEF0;
	Tue, 23 Sep 2025 01:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758590813;
	bh=HtLJWt3Az3q5FGnVm8doJruQbgKs/1f81/npuya51HM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kygEdYQUHVUz7XQz/nDqSHAyIUJBB4bWCKFIE8Xeu2TRvJt052AYNyF3flahf34MM
	 xP5DbVz5VOwa0Ug2z2iDQOabJwPtOL6uB3FJG5uDeqyZ2VPwsGeC3BfV//e+gR4HEu
	 mR2mjU8D0HZ0yPcqS4BoeEPlFScl3QT4jVXyX5MouGWtAKtNZ96N4Tpaq4jxwuOiwv
	 yfdKSSZBafL/zqnsQkT2DgQs86//rRSNI9v3fkVVltYMPCf/Ia14UGpdwlzQ1QIoKm
	 arQt2T0CZLBJv/rrVCuoJUIWbbIT8sUSK8eSx6wDdBh5+PpFl/Lwx/yqnykQnbb8hk
	 1e9rMKNlLX3pg==
Date: Mon, 22 Sep 2025 18:26:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, David Wei
 <dw@davidwei.uk>
Subject: Re: [PATCH net-next 05/20] net, ynl: Implement
 netdev_nl_bind_queue_doit
Message-ID: <20250922182651.2a009988@kernel.org>
In-Reply-To: <aNF0G6UyjYCJIEO5@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
	<20250919213153.103606-6-daniel@iogearbox.net>
	<aNF0G6UyjYCJIEO5@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 09:06:51 -0700 Stanislav Fomichev wrote:
> > +	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
> > +	if (IS_ERR(priv))
> > +		return PTR_ERR(priv);  
> 
> Why do you need genl_sk_priv_get and mutex_lock?

+1

Also you're taking the instance lock on two netdev instances,
how will this not deadlock? :$

