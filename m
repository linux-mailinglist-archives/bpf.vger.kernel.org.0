Return-Path: <bpf+bounces-70333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E8BB7ED0
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C13D3B2D0A
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C62DF125;
	Fri,  3 Oct 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RaD85swx"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968B2DF123
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517441; cv=none; b=TZmPsIAAFbBJsw/fErF2EycPlMZ0WjGzySNWZiog/BJT134nCAJ+y4Qer9JxecX87tSPSCAiAWUcBj0zawvO663cArxy0SpLIh00ClKAqGRhCnOUlyk/LZxwBB5CxTC5bG2nWQh1IxInQV6eOvy3HCF5OdE9T48ixl4Ja0+eEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517441; c=relaxed/simple;
	bh=8zIsYsgDfEZa7I7tB/V6cpcUz49D8RFg9UQvHpQHhwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTbAhVIlSbnLeItOCDvbylM6XRmToVeoCIDapag0c8g51XND6HMjUACs9sNBL2KoSK5XwDGMhVPN7NAYOWFMtm2Nd4AIiNg2NTp+1uh8/h3ljija3kmZcI0yW7rqLKcA3JwgwA3Am7dvcjG3suOdBK/O60l/rLUbzR4pQcchAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RaD85swx; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44ca44bb-a641-4d70-ad7a-96a3187706a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759517427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikaIhTGzbrKsi7o6KZMKmzN4UHLKbNVk29IQZ87Klwk=;
	b=RaD85swxavEjzWRZp1Lm++6G4PW8INLvYeWw/XceNrVyuy0OFLV72PSMpCyAta75dU3kUu
	P0KJA6MDGs2/4NcEJKjZZrjWB8VQZQAkLu4f+YK8FKY3qiV5bW8si5ErPk9EarwaHKruh+
	MZPLo6Ot/bk0U6mz/le0y6gWm9DqTvs=
Date: Fri, 3 Oct 2025 11:50:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix metadata_dst leak
 __bpf_redirect_neigh_v{4,6}
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Yusuke Suzuki <yusuke.suzuki@isovalent.com>,
 Julian Wiedmann <jwi@isovalent.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Jordan Rife <jrife@google.com>
References: <20251003073418.291171-1-daniel@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20251003073418.291171-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/3/25 12:34 AM, Daniel Borkmann wrote:
> Cilium has a BPF egress gateway feature which forces outgoing K8s Pod
> traffic to pass through dedicated egress gateways which then SNAT the
> traffic in order to interact with stable IPs outside the cluster.
> 
> The traffic is directed to the gateway via vxlan tunnel in collect md
> mode. A recent BPF change utilized the bpf_redirect_neigh() helper to
> forward packets after the arrival and decap on vxlan, which turned out
> over time that the kmalloc-256 slab usage in kernel was ever-increasing.
> 
> The issue was that vxlan allocates the metadata_dst object and attaches
> it through a fake dst entry to the skb. The latter was never released
> though given bpf_redirect_neigh() was merely setting the new dst entry
> via skb_dst_set() without dropping an existing one first.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>

