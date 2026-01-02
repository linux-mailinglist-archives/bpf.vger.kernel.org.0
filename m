Return-Path: <bpf+bounces-77689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B5CEEE0F
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A36C301A715
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8B2264DC;
	Fri,  2 Jan 2026 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dE5fKgc0"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7961A3029
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368053; cv=none; b=G1inqTCXcDCeG2vWNVj+2+3qxzY1Gj0m6JCPsBxss254X3uPFj5jZTqdBBRLZEezBuynuhV4X7ZMeWS/FKzY0VzA7w+PQmHmOi2VziwPeVJNrVX/AaIQbdPU/tCqIXZtQ8tdeyRePBSnNcAIXhAydkYSKsFJ6llLBMqUvE6k02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368053; c=relaxed/simple;
	bh=Lc0Vaiwhg93Kftu6FwUF3q06s2V6DW0Q+a+GiQZrgTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqok9aCYO6QyOhgV7FGsb1Zdi5IHb+rrW8GOxSpY/GoL9yXPGwE/8mL6d/0cCHZ+dHcUeWc2T+IQoXeiVM3+YMq6zJw26Bkz7sKgWVO5AR8+Ye06+yLuu2EcMGYguEeCqp+QQsg9UmS2bDq0fzG/HEEcYV+Tg4WmgFfrERw+IFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dE5fKgc0; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bcd23277-a18e-4bb5-ba76-3416c84511c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767368038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zq7PL7Unph+1q4/lCVQBzEE0/yE1hCPnq6+DR6Z5GKU=;
	b=dE5fKgc0cUMTP0cxONjiR/QximBbiXME50mdT2bwFrQOfC496bubQDvWMpnI5Jet8TMM1W
	UxABwrcWqNALr/2G6Wv2F51CsQD+eQQ94yi026maOeAAG6HocWMFTGESnlLwDS+x40V5gC
	qmkBlHRftFiIi+Apbkoy+vKzf4AL+44=
Date: Fri, 2 Jan 2026 07:33:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, docs: Update pahole to 1.28 for selftests
To: Hemanth Malla <vmalla@linux.microsoft.com>, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, vmalla@microsoft.com,
 corbet@lwn.net, Alan Maguire <alan.maguire@oracle.com>,
 dwarves <dwarves@vger.kernel.org>
References: <1767352415-24862-1-git-send-email-vmalla@linux.microsoft.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <1767352415-24862-1-git-send-email-vmalla@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/2/26 3:13 AM, Hemanth Malla wrote:
> From: Hemanth Malla <vmalla@microsoft.com>
> 
> pahole 1.16 doesn't seem to be to sufficient anymore for running bpf
> selftests.
> 
> Signed-off-by: Hemanth Malla <vmalla@microsoft.com>
> ---
>  Documentation/bpf/bpf_devel_QA.rst | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
> index 0acb4c9b8d90..3a147b6c780e 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -482,7 +482,7 @@ under test should match the config file fragment in
>  tools/testing/selftests/bpf as closely as possible.
>  
>  Finally to ensure support for latest BPF Type Format features -
> -discussed in Documentation/bpf/btf.rst - pahole version 1.16
> +discussed in Documentation/bpf/btf.rst - pahole version 1.28

Hi Hemanth, thanks for the patch.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

1.28 is needed for --distilled_base [1], which is only a requirement
for tests using modules. Many other tests are likely to work with
older versions, but the minimum for the kernel build is 1.22 now [2].

Not sure if it's worth it to add this nuance to the QA doc, although
in general we should recommend people running the selftests to use the
latest pahole release. Maybe add a comment?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/bpf/btf.rst?h=v6.18#n986
[2] https://lore.kernel.org/bpf/20251219181825.1289460-1-ihor.solodrai@linux.dev/

>  is required for kernels built with CONFIG_DEBUG_INFO_BTF=y.
>  pahole is delivered in the dwarves package or can be built
>  from source at
> @@ -502,9 +502,6 @@ codes from
>  
>  https://fedorapeople.org/~acme/dwarves
>  
> -Some distros have pahole version 1.16 packaged already, e.g.
> -Fedora, Gentoo.
> -
>  Q: Which BPF kernel selftests version should I run my kernel against?
>  ---------------------------------------------------------------------
>  A: If you run a kernel ``xyz``, then always run the BPF kernel selftests


