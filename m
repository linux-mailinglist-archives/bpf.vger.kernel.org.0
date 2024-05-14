Return-Path: <bpf+bounces-29701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25A8C57EE
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DB4282663
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509CF145338;
	Tue, 14 May 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caKJqc4b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C5EA4
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697027; cv=none; b=dCTxphomJG1gT0c/6WxkNRH0Wlzuo7DHGDyicej6wZe0QP9Os57uFMCYSe0SCVJTTVLYRelmoZgRSBP3qXNmny2R0rx7Ip+ALLMw50tmxaLSgh0KyFN/4U3poDxZN+tn3FI3YjxHacN1mxaTmHY3WP3bsZ7zGUK9LE9Jininks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697027; c=relaxed/simple;
	bh=ETFrBhjjjILCoMsMN3YPjAqPzLE6n8Mgn4SHYlernTY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JBLMtKJUvPyspOFHfgB51zUkpyKbQYjEUNLSjGzGKqRuC/LE/Li66dT2NV9iYTS8jYVem5JUgeon+Lq15a2Hr9DCQRPG4GdF5EphdqzA58G0X2JFAcvf/oXf7KYezsZL5qSck+Gq70VA6/ScH/qdlatptd0jWwsEH0zbZDKfJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caKJqc4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153AAC2BD10;
	Tue, 14 May 2024 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715697027;
	bh=ETFrBhjjjILCoMsMN3YPjAqPzLE6n8Mgn4SHYlernTY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=caKJqc4bYkf5l4HHlOZdCYYGzxtB3pC+X2XuEHe2fezdB/bWsLVCpmLeoWL/HQ8Wx
	 JGx+A8e88yxdwWmunl3vqzC4jukHhM75Sr+lsVUOIVJM6EvAcTxKl9wDsWbcDrBLEM
	 lZeAdoeLQDQm9nENHSCkqjeHGNb1xUOc8VeMTyn7dBeeUCSECfporXFV4PIh5ojpfA
	 BtmPoQaq875ugRZwbPgN+to1DxcfTX9/4zl8v2SEfPOXqaIaQOL7pW8oZIspUrDNc+
	 rSaadT5v5OVGyTdf6k3AeDAAnRtUOnia8jSlCU/AP6VPdfMPgcrExXMiJ+sh3442AH
	 dvUlP/lPG/39w==
Message-ID: <6cb7213f-2f2b-479c-aa2f-2fbd3575eff6@kernel.org>
Date: Tue, 14 May 2024 15:30:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v4 bpf-next] bpftool: introduce btf c dump sorting
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240514131221.20585-1-yatsenko@meta.com>
Content-Language: en-GB
In-Reply-To: <20240514131221.20585-1-yatsenko@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-05-14 14:12 UTC+0100 ~ Mykyta Yatsenko mykyta.yatsenko5@gmail.com
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
> forcing more natural type definitions ordering.
> 
> Definitions are sorted first by their BTF kind ranks, then by their base
> type name and by their own name.
> 
> Type ranks
> 
> Assign ranks to btf kinds (defined in function btf_type_rank) to set
> next order:
> 1. Anonymous enums/enums64
> 2. Named enums/enums64
> 3. Trivial types typedefs (ints, then floats)
> 4. Structs/Unions
> 5. Function prototypes
> 6. Forward declarations
> 
> Type rank is set to maximum for unnamed reference types, structs and
> unions to avoid emitting those types early. They will be emitted as
> part of the type chain starting with named type.
> 
> Lexicographical ordering
> 
> Each type is assigned a sort_name and own_name.
> sort_name is the resolved name of the final base type for reference
> types (typedef, pointer, array etc). Sorting by sort_name allows to
> group typedefs of the same base type. sort_name for non-reference type
> is the same as own_name. own_name is a direct name of particular type,
> is used as final sorting step.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>


Please keep the tags from previous versions when the changes are trivial:

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks a lot!

