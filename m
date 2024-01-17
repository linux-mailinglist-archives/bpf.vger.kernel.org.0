Return-Path: <bpf+bounces-19740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7272830B85
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 17:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2331C21D5E
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165E9225CB;
	Wed, 17 Jan 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T7Qpy/ZV"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF6224DA
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510397; cv=none; b=EvXtPI++VtkkR8NcHvrLV8P9Atl3F80WNHHIA5ZaHLtVr46RYHUOFtLT7FmJX5OP7XZBREP8zTRLtyIe/uDaRAOOmZFFsQMWnDtYtZ10zyg89oUnZAzOEk7b7dS0KG+KJMgIOJckwT4JcWd5f8vv82hcvOryqRAulxCo/uwil3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510397; c=relaxed/simple;
	bh=kRv+cI5Vdhqdd/21TbEMvuhMcnhTXWXpKKYsmnDCDys=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=J39ETQGp5VcEIXSI/nr08BGH+gf8vo1Xjo7OCsfPS41Q+E81xbqFCiNln/ni667KUHHEn35Py7mgDK5N+pzfnRVaklTenqgAdHuJqg7foj+SAFMHpyDD62bQq57TvkqPCANyNqx/UsXPgW6qCQ+sGBnBCuOcw1r+PlCYA7QxHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T7Qpy/ZV; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e97a9573-7847-463b-86c9-7db24206d14f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705510394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRv+cI5Vdhqdd/21TbEMvuhMcnhTXWXpKKYsmnDCDys=;
	b=T7Qpy/ZVS1T2hNURVY3KBOpHMmgWtZh3MLQQ7tfb29SG2VNen4Rd/x/fY7SlGfp4YpeqTN
	5FqAvKghLP/FmuX5x9JY97dDpRh4feAl54P7rQxlFZbb4WWEHKEghXivNe2nLB5tT2Twse
	P9rSdSbHJYzVeJaCRsbdUVoZL76kSug=
Date: Wed, 17 Jan 2024 08:53:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v5 2/2] selftest/bpf: Add map_in_maps with
 BPF_MAP_TYPE_PERF_EVENT_ARRAY values
Content-Language: en-GB
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240117130619.9403-1-conquistador@yandex-team.ru>
 <20240117130619.9403-2-conquistador@yandex-team.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240117130619.9403-2-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/17/24 5:06 AM, Andrey Grafin wrote:
> Check that bpf_object__load() successfully creates map_in_maps
> with BPF_MAP_TYPE_PERF_EVENT_ARRAY values.
> These changes cover fix in the previous patch
> "libbpf: Apply map_set_def_max_entries() for inner_maps on creation".
>
> A command line output is:
> - w/o fix
> $ sudo ./test_maps
> libbpf: map 'mim_array_pe': failed to create inner map: -22
> libbpf: map 'mim_array_pe': failed to create: Invalid argument(-22)
> libbpf: failed to load object './test_map_in_map.bpf.o'
> Failed to load test prog
>
> - with fix
> $ sudo ./test_maps
> ...
> test_maps: OK, 0 SKIPPED
>
> Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


