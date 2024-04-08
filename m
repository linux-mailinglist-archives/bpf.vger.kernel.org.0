Return-Path: <bpf+bounces-26165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAC089BE3C
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 13:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98214283DCC
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F21169DFA;
	Mon,  8 Apr 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SX5Bjqzg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95C1E497;
	Mon,  8 Apr 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576499; cv=none; b=Cm5QYxXdxH1mQtzrqRkr2IBA51tI8ZLmtMNXomOYgGoWcBFC9YbrqGmA068h5K2iMcXzTkoMpMp+k91hxjbWBC4vss5ehdv3bJeTzMrTMU/QpaO340g3hyfg3m0TeXlMWpQ1sEkhsApbxRemkvzw4eBs/49IsEJP2vQ+4vkLOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576499; c=relaxed/simple;
	bh=mCE7RTdwBqXjX+4d8ESnt/ctiwZdNz3fDuMQS5Tqz90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kja00qzX1OQh+VjfK5jglhqcpww1mtQklbdciOvoDVuPyl12eW4Yd/UQ/Ytgnnu8zxF88vj/nsThtAGYcUmVWZOu2AA9Bh/Usv0Ech7bP8wlxABKIYyT7AR29n2FmJ3uEzNcqZo+rUD3PXII6x/Rv2/NtcZS2nzkaYjQOnsP0fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SX5Bjqzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D13C43390;
	Mon,  8 Apr 2024 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712576499;
	bh=mCE7RTdwBqXjX+4d8ESnt/ctiwZdNz3fDuMQS5Tqz90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SX5Bjqzg8Q+TcAXxcy4swShJwpD1dIjsCQEANaW90mLGNG0CW7mGJeO64VSMMqSGS
	 TyYA98UNnDVrXipDVidajxFwEzQWGrkDyR46/A05GZHQWqmBTF0FGtxKsZNlX+Qg8Y
	 PJQS1JRcxyB3IYie1t+yguu7iWUuT3iEi6AK4RJk=
Date: Mon, 8 Apr 2024 13:41:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] bpf: put uprobe link's path and task in
 release callback
Message-ID: <2024040824-moody-halt-f864@gregkh>
References: <2024040548-lid-mahogany-fd86@gregkh>
 <20240405163806.45495-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405163806.45495-1-andrii@kernel.org>

On Fri, Apr 05, 2024 at 09:38:05AM -0700, Andrii Nakryiko wrote:
> There is no need to delay putting either path or task to deallocation
> step. It can be done right after bpf_uprobe_unregister. Between release
> and dealloc, there could be still some running BPF programs, but they
> don't access either task or path, only data in link->uprobes, so it is
> safe to do.
> 
> On the other hand, doing path_put() in dealloc callback makes this
> dealloc sleepable because path_put() itself might sleep. Which is
> problematic due to the need to call uprobe's dealloc through call_rcu(),
> which is what is done in the next bug fix patch. So solve the problem by
> releasing these resources early.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/r/20240328052426.3042617-1-andrii@kernel.org
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> (cherry picked from commit e9c856cabefb71d47b2eeb197f72c9c88e9b45b0)
> ---
>  kernel/trace/bpf_trace.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

All now queued up, thanks.

greg k-h

