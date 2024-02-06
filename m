Return-Path: <bpf+bounces-21357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F65184BAB3
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 17:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64D61F237B4
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C0B13472F;
	Tue,  6 Feb 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XichmIa8"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1426212E1ED
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236147; cv=none; b=TkVc2aJMnS5gDtH0hWHwAMdZBkLEgfwwHMrcbJkd1bWiSU0qG30iWjLt9xpg2q5qEBBTwZZ5RoHRpX8qN+EPfvkEMXVTczewrNEb5AipgPjh/y0Ueu83c8ESBCa5as0Psfn93GTkfNS+w4UbYbhxATWKbVEe3/GMtYQb9EChhPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236147; c=relaxed/simple;
	bh=/mDafQrev2J0jJMOxflALwkn6jTSQeWbohmx+jhJsvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5TAa1sPtK0UsWoG26jdwdAWTcJMKzOLwOnZY+cKJVlmgjGNuG76ugvbqLXxW3zYnLjvY0QFvu9BLb/R+ul031xLLfHOhru6PCIIwoDRm1J62ApAm4m3RHjmS+u5NiLfHk4Vioy3EW2duZMIZHRt9oEUSCmx4gsONWf5eHh5xAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XichmIa8; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6fb7e648-4eef-418f-b156-5bce5d3bbb32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707236143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSa10TzKM1/U+wySOEJ2gxKjMst/Kx3fZ+aXrrYC8hY=;
	b=XichmIa8+c2KrpKL6Zk6QyubUszxccJ0pU29Rhhfu1Js9uu9e6h6YaROFjL7dr2UH3ailF
	JvxeiPo5TE48uhKdIkZ3aZ9C4gWDxUpLsdAbVAp72BiJLDJREWV0FSQeFUmDiqdvUohwHx
	3wgDLPKeIoLW5u3QaD0cfGkP+7B3JvI=
Date: Tue, 6 Feb 2024 08:15:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V3] bpf: use -Wno-address-of-packed-member in
 some selftests
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song
 <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
 David Faust <david.faust@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>
References: <20240206102330.7113-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240206102330.7113-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/6/24 2:23 AM, Jose E. Marchesi wrote:
> [Differences from V2:
> - Remove conditionals in the source files pragmas, as the
>    pragma is supported by both GCC and clang.]
>
> Both GCC and clang implement the -Wno-address-of-packed-member
> warning, which is enabled by -Wall, that warns about taking the
> address of a packed struct field when it can lead to an "unaligned"
> address.
>
> This triggers the following errors (-Werror) when building three
> particular BPF selftests with GCC:
>
>    progs/test_cls_redirect.c
>    986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
>    progs/test_cls_redirect_dynptr.c
>    410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>    progs/test_cls_redirect.c
>    521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>    progs/test_tc_tunnel.c
>     232 |         set_ipv4_csum((void *)&h_outer.ip);
>
> These warnings do not signal any real problem in the tests as far as I
> can see.
>
> This patch adds pragmas to these test files that inhibit the
> -Waddress-of-packed-member warning.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Cupertino Miranda <cupertino.miranda@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


