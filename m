Return-Path: <bpf+bounces-49160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB7A148AD
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 05:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B716169022
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 04:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F5F1F63F1;
	Fri, 17 Jan 2025 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1gOaq2D"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49676C61
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737086530; cv=none; b=VqFcqJtp9UYDLqMcMwUem0W9+T1LmJG9zUzmjtxLfLbPfXFDOc7aqfFHLwaHO0VW+vCLdno8gRsfF8+yuU/9vxa/RnOEgc/fk1QwrAX/qust76ntnHXOivo/M0YEWdXiHQDnx0HcJ7dQ/Awvja9ADkKJwTH7xQV7SuEXhU94b4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737086530; c=relaxed/simple;
	bh=qt8Y2f0z90eAZVeD3TJ3Fcph9xhHO9DZRKWGGod3+wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEM+k6o3kcpXNZ0QR2hnsFne5RgsMQvHWTNeSysxJ8ruQJEEBHzM+oYxXvA7l9aaT9f5ooAwV+RhkunOzTXs5k8Rt6sciLRmbsXv8uUxv+rJvtyOj9orQ4NaIVasqZmRrBxBLMVHY2GMS8vVThV1p8g73HQElELSXHOiDADknpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1gOaq2D; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <20050719-365d-431d-90d5-183b35e328ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737086521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEiYPLe2qoQwJsXJ1hslHmogKwuvW1hmjPdoFHEOpcc=;
	b=t1gOaq2DjxnEdrcTne8mhPIpcmWl26pnPP1Y9EYPwK2GAX3LW8A8CXWR4tAqPLEhEBINOM
	EvDwnzt/mzACQT3fWUYshytVxu2TrOigRB4AGIC9386PBioxw3TjHWMarbTDnCOiUdyBL/
	JKso7xcsPlJJNvSlaWdX0Iu9MR/oG8E=
Date: Thu, 16 Jan 2025 20:01:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: work around kernel inconsistently
 stripping '.llvm.' suffix
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20250117003957.179331-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250117003957.179331-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/16/25 4:39 PM, Andrii Nakryiko wrote:
> Some versions of kernel were stripping out '.llvm.<hash>' suffix from
> kerne symbols (produced by Clang LTO compilation) from function names
> reported in available_filter_functions, while kallsyms reported full
> original name. This confuses libbpf's multi-kprobe logic of finding all
> matching kernel functions for specified user glob pattern by joining
> available_filter_functions and kallsyms contents, because joining by
> full symbol name won't work for symbols containing '.llvm.<hash>' suffix.
>
> This was eventually fixed by [0] in the kernel, but we'd like to not
> regress multi-kprobe experience and add a work around for this bug on
> libbpf side, stripping kallsym's name if it matches user pattern and
> contains '.llvm.' suffix.
>
>    [0] fb6a421fb615 ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

The fix LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


