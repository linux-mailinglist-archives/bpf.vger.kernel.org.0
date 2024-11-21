Return-Path: <bpf+bounces-45356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ADF9D4B74
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F4AB25B31
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3711D0F4D;
	Thu, 21 Nov 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV7HlaTJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA551CACDB;
	Thu, 21 Nov 2024 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187919; cv=none; b=pWQ36+P7PId/XSCGXvsEI4bSyC9DEpbiWepsSUCK2D60eo+4x10njIhnGOV5S32uYrQBiA1eRvqy1MgdmmJUKWsNLcXO6ok5pw1XM+VrhbGyECteM/nWndZAcJ10oTrQ/4EsaIh4kvYTK6TCXdL61QtqYefNthOP5dj1FLyIES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187919; c=relaxed/simple;
	bh=9/6EY2QPejgJaoCd8eS7IdDf1nk/mIZfnq1lnC3NuZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U92PIH1BPGa1zHvRti7TPhsp1cct5RMmhzrG/xZwQKit0lpPYc8uwgebcU+OVUi/jIyXXdq1miYLZhEh4U+wpdDm4MpFms2va/6zC/teo5h2pSjkgLE3QpeyDyVc1F1ztrc0nP8hYXWE3cdZzEAhHGYah+AkTnnlMy1y3aL9PI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV7HlaTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CCEC4CECC;
	Thu, 21 Nov 2024 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732187919;
	bh=9/6EY2QPejgJaoCd8eS7IdDf1nk/mIZfnq1lnC3NuZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iV7HlaTJhE8eQx0wuz7Ijcl73ujIrEwhmCFHvukRUIGOkRvJL/NFDqKWJ8Vwncvez
	 IOUN3AGAbSpPgnVxS298X7uvFYK3lV3K8S+BCUI1EJQpEAGc8ZMvg15/Mwa5AS9ht8
	 S29U99hhCD9SLQRaEmzr7iXjt+XIH0aWS/Sa34ifDC8PD2Qd8UE8eX89r6X2mYnggo
	 +gWU3N4lsT1r3qVccg31kVESxYKnyv4wnMZhkkdYvKWxO9Wqn/xljRJAenCyxoii/k
	 obOQzypJ0QAperLJRKl0MxUsbdjx/Ha04X1cIg40LnsF5sxYQFFthbp15uuOhGmQ+N
	 YPslbwYCwBaHQ==
Message-ID: <3ec0fb06-79a4-403c-8ff8-84f7477ddf1f@kernel.org>
Date: Thu, 21 Nov 2024 11:18:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bpftool: fix potential NULL pointer dereferencing in
 prog_dump()
To: Amir Mohammadi <amirmohammadi1999.am@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Amir Mohammadi <amiremohamadi@yahoo.com>
References: <47225498-12ab-4e69-ac50-2aab9dbe62c0@kernel.org>
 <20241121083413.7214-1-amiremohamadi@yahoo.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241121083413.7214-1-amiremohamadi@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-11-21 12:04 UTC+0330 ~ Amir Mohammadi <amirmohammadi1999.am@gmail.com>
> A NULL pointer dereference could occur if ksyms
> is not properly checked before usage in the prog_dump() function.
> 
> Fixes: b053b439b72a ("bpf: libbpf: bpftool: Print bpf_line_info during prog dump")
> Signed-off-by: Amir Mohammadi <amiremohamadi@yahoo.com>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!

