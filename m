Return-Path: <bpf+bounces-66417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E429B34962
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5EB1B2474F
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E38305E10;
	Mon, 25 Aug 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jjx47OX6"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93327144B
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144453; cv=none; b=urnjTNEgErE4AFHjYi0QYoIxheC6KnEhihRN7bBjXwF5wAuH3Gout5i5U2Ze4MiAERWV+rQSzVDlTp+1bjGfolkc7zRgfMZH6kccIrpW5DAotPNqa+dsoI0FfhLfh1QUe2lEzUI2eVnBHa0TaLjCVh8Gg1LSlrEzv/C6ToZQFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144453; c=relaxed/simple;
	bh=of6zL/+Z53GfZoSXknbAsZFLLXkNr0oKvnDLed2zOaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7Td6/12Yza0yicOw0G/CBwfdsQewmp1jj7w7brd0a1N833MGd/tgtuxjxsWO8LCxWG5jxygm4uRRqaZhNXPuKEueqJKymaj0AKM4Hwju/MdxFxfOV9GEgNZ6rfq0AYXwb8jQfjG9nbmfs9/mHAPy/WXTsOltk0XjFXIAYeavuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jjx47OX6; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a2d8fba6-288c-4d2c-ac2c-d7a920c0cf39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756144448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyu6YQzJlIgNyWL79DJIXSiGvZzYfV3sVQ5Pz0jZRAw=;
	b=jjx47OX6HvWdtACMbemkJ5TSp0BMivsXbnyHmkwGZu4PvZu/HaWBNiGTmt9hFscUatT7pq
	R2bTzMgltSapGlO++HKTwmq2nOEQzf7ICzpV6yCB9r20T+DZ72X7Vwrltdt1ODT//OQJz2
	90U6v6Yw0YFYLAqo4+ZhFHcf6Rl/AoY=
Date: Mon, 25 Aug 2025 10:54:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: How to deal with increased install size with
 `CONFIG_DEBUG_INFO_BTF=y`
Content-Language: en-GB
To: Paul Menzel <pmenzel@molgen.mpg.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <15bcb208-3ccb-4d99-853b-545626914373@molgen.mpg.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <15bcb208-3ccb-4d99-853b-545626914373@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/25/25 8:42 AM, Paul Menzel wrote:
> Dear Linux folks,
>
>
> Trying to get ptcpdump [1] running, I needed to build Linux with BTF 
> symbols.
>
> ```
> @@ -5985,11 +5986,22 @@
>  #
>  # Compile-time checks and compiler options
>  #
> +CONFIG_DEBUG_INFO=y
>  CONFIG_AS_HAS_NON_CONST_ULEB128=y
> -CONFIG_DEBUG_INFO_NONE=y
> +# CONFIG_DEBUG_INFO_NONE is not set
>  # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
>  # CONFIG_DEBUG_INFO_DWARF4 is not set
> -# CONFIG_DEBUG_INFO_DWARF5 is not set
> +CONFIG_DEBUG_INFO_DWARF5=y
> +# CONFIG_DEBUG_INFO_REDUCED is not set
> +CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
> +# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> +# CONFIG_DEBUG_INFO_SPLIT is not set
> +CONFIG_DEBUG_INFO_BTF=y
> +CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> +CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
> +CONFIG_DEBUG_INFO_BTF_MODULES=y
> +# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
> +# CONFIG_GDB_SCRIPTS is not set
>  CONFIG_FRAME_WARN=2048
>  # CONFIG_STRIP_ASM_SYMS is not set
>  # CONFIG_READABLE_ASM is not set
> ```
>
> This increased the module size quite a bit:
>
>     $ du -sh /lib/modules/6.12.4*
>     128M        /lib/modules/6.12.40.mx64.484
>     1.9G        /lib/modules/6.12.43.mx64.485

The increase is mostly due to dwarf. The BTF related sections should be just ~6M.

>
> Searching the WWW, it was suggested to run `INSTALL_MOD_STRIP=1` [2], 
> bringing it down to 137 MB:
>
>     137M        /lib/modules/6.12.43.mx64.486
>
> I was under the expression, that BTF symbols are small compared to the 
> debug symbol types from the past. (Excuse my ignorance about the 
> terminology and subject.) Is `INSTALL_MOD_STRIP=1` the “recommended” 
> way to still use BPF/BTF on production systems.

You can use INSTALL_MOD_STRIP=1 to reduce kernel binary size in /lib/modules/... directory.

>
>
> Kind regards,
>
> Paul
>
>
> [1]: https://github.com/mozillazg/ptcpdump
> [2]: 
> https://gitlab.alpinelinux.org/alpine/aports/-/merge_requests/28218/diffs
>


