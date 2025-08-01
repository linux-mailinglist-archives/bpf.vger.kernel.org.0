Return-Path: <bpf+bounces-64917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 062CCB185D8
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B0C7A3B0E
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9027A19C546;
	Fri,  1 Aug 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CwI/YzVc"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B8176ADE
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066035; cv=none; b=lKoKG5xN1V2BCFDliO794IO2kIhsADpw/UUYFHEnM4gn9w1AneI94Nss9uxPX//l9wY1oK/BoeJzg6aE4z4Zz/w+a6VIHUaVtubPnQkJ719VQVcDPKFxhYj/Jdu+T44qCYTVtjwRBPMke3qlXMzL4J3IckVmcFlLgl6zNacRVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066035; c=relaxed/simple;
	bh=gRpqzxnyoZ7jPe+n4EhOPlrGYXnJeXx1cCMF4cLZisA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aK1weheHYP5Sh/JLE38m1OM9lMHXu2N9dsia/T7CSWvVWu3X6hcLbKNPdOmRBI+Bz/vWzzh2w4iUlSlTouWLJsYSDATY0lyZmKlVawMTbiPg/HnaKOraSI5ecrFdIj/NxnHoNuMO/orSrcnjwgKq3BNSe7PvJLiL4M9IYtEZnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CwI/YzVc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed412825-5de5-465d-bc25-7eda8a45d288@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754066031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRpqzxnyoZ7jPe+n4EhOPlrGYXnJeXx1cCMF4cLZisA=;
	b=CwI/YzVcB0VOvS888SWRGfl+BAl4bI39QHGU6iuF2aRteCBHqksrdSuYN+5GBYj8jhRROv
	1tqzsYBnXgg/qSo91gAlHcSompBCTtHaN8th6pDJ+kanTf6Izh8/MYxX799kGFReyN7X0p
	dGAu68YMZvir86tYYkFN0q4rMYiOxQo=
Date: Fri, 1 Aug 2025 09:33:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 4/4] selftests/bpf: Test for unaligned flow_dissector
 ctx access
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, netfilter-devel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Petar Penkov <ppenkov@google.com>,
 Florian Westphal <fw@strlen.de>
References: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
 <bf014046ddcf41677fb8b98d150c14027e9fddba.1754039605.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bf014046ddcf41677fb8b98d150c14027e9fddba.1754039605.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/1/25 2:49 AM, Paul Chaignon wrote:
> This patch adds tests for two context fields where unaligned accesses
> were not properly rejected.
>
> Note the new macro is similar to the existing narrow_load macro, but we
> need a different description and access offset. Combining the two
> macros into one is probably doable but I don't think it would help
> readability.
>
> vmlinux.h is included in place of bpf.h so we have the definition of
> struct bpf_nf_ctx.
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


