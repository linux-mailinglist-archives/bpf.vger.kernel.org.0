Return-Path: <bpf+bounces-61329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E094AE5873
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 02:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E664C1DA0
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 00:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B126881AC8;
	Tue, 24 Jun 2025 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVqE0rcx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B751F956;
	Tue, 24 Jun 2025 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750724228; cv=none; b=ECEurjhSv43kWcLVdQrEhFexfUNdjjNgQjvd4NZXdiluDVTnWXgpNOe7CsgLhMWdXOTACUm3OVbIPBm6QIPT5FUVNyYsl8SZrYHfNeEflC9kpR2I0YQOFzvHoPLxnffdsmJjuCL0hyUY60OItjm44iyomrlfhCmimzgB8u/GLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750724228; c=relaxed/simple;
	bh=LG8hwkkohimmR2ukc3sgckWtHUtEhHZxioav2+XzR+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhGgNcCnvUaW4QFyqzedomnxqXhja2DpdGP3ok6EAoW5zHVw9ibYYUG1XjH9uyQb3zrV9bti82YKqVpJIC9IMgLf9HSBRJz3a2HTRcN3Ew4o84Gr2mLC7DCWlEUuIPGdMLiNNz2+QtcIas4H2BrElCJI/SSOPeue8bG/0i7fgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVqE0rcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2A4C4CEEA;
	Tue, 24 Jun 2025 00:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750724227;
	bh=LG8hwkkohimmR2ukc3sgckWtHUtEhHZxioav2+XzR+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DVqE0rcxj4nXHjkupIsyOpMvoxPH9i0W440Rbm4yCJh0Dvj6MLKvoiZ1akBKEwuGP
	 6+hYkOXD4EAjvXtNxtYkp+yfKpklk54QlEpEAoImhkpMSlTn25SIXbP5hEtU4nu/+Z
	 3jdWVIHhx72nG0Nww/Ji0eCP9V74AXtGpwl17mQucL5JEqAoLbhyrSzL0w6u8EX1VW
	 6vPdIGs0npmAfb585QQNHnl9ovZriqMprMYRv7GMdv4DiuC58b3/A3OEb4pUUo7n9L
	 1wqFCW27ShpJAtJO5P6UmVcedbeic3T2irI4dhg3kvYm3AyGoR+1JyrCentzjZ17cN
	 yYwTj9l9+zGkA==
Date: Mon, 23 Jun 2025 17:17:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
Subject: Re: [PATCH net-next v6 6/9] netmem: remove __netmem_get_pp()
Message-ID: <20250623171706.3bb10482@kernel.org>
In-Reply-To: <20250623043207.GA31962@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
	<20250620041224.46646-7-byungchul@sk.com>
	<20250623043207.GA31962@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 13:32:07 +0900 Byungchul Park wrote:
> In the meantime, libeth started to use __netmem_get_pp() again :(
> 
> Discard this patch please.  Do I have to resend this series with this
> excluded?

You'll need to repost, unfortunately. If there's a build failure 
the CI doesn't execute any functional testing nodes.
-- 
pw-bot: cr

