Return-Path: <bpf+bounces-43658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F69B7FC3
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 17:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AED2281491
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBFA1B0105;
	Thu, 31 Oct 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyANvDV+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FA156CF
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391318; cv=none; b=HqsR0RBBfAwiylapuLm2HJKjY3B0m+RpuzwTCec/dTUELx5SBKrqKFewIaX9bz5SNRBCGum9Isp9//w8flH4Qz6WVZFYYlbOTFAaP6/qpmrE7UD3gdSIQkKDciIHNt5pHVroBw5JrY1Z9oftcIz07Vk1l14gV9s3Gj9OjkxZEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391318; c=relaxed/simple;
	bh=UjKlhEnnbqWISZ+DuI5EPAA2oxYg8H/UanZ2lGvNCws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8AcfG8HKTWi02LSwWJhmsTCmMDdIlcDsgLa9OePjXNuEGVZnsyM3uE6SMNV4MXBbcJrL/kNyUqkuEQrmT+XJF60qpu5WZIwWKt/huaJyweV4Hf5R3kZ7ZUK3xKPWYfOJ8yNfyPVusn8KtRetWZA+hb7HufdJGtsd8xEuf7O4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyANvDV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3D6C4E676;
	Thu, 31 Oct 2024 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730391318;
	bh=UjKlhEnnbqWISZ+DuI5EPAA2oxYg8H/UanZ2lGvNCws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LyANvDV+OG5jOeyOnAEvjIUTj3CvGLWyTpTqL/LDWRW4/K/SkqLu+/uKPzPEBqdqu
	 M0rrNqrB16P0ZLL+VAsrsemmCeOIzBWFo6AsjOYQTb/FERFxlH4hhXe+a86LfGQJoL
	 fVp8H2/kYYnYrgIUiyEukYZMwK6vEZgooOipJTew9V+B1s7lhLvGLnTn4xdeTaWFsd
	 abZTw/OFNjyUCqv3S2edB8MsACj1qnnMJ7mwAEKuujogx8G+OrpZP3FPTTFWVDw4Mw
	 ZGreF2EHY/lcY+TnyrTAgRuu0nMPLnG0dm/je6PG4jn1RZ1jw7ovjC18Agwt9OIwvw
	 D32Ou0uqRT28A==
Message-ID: <292fa9b1-3302-4cb7-b7dc-903a3f1b70c7@kernel.org>
Date: Thu, 31 Oct 2024 16:15:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] bpf, bpftool: Fix incorrect disasm pc
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, gray.liang@isovalent.com, stfomichev@gmail.com,
 kernel-patches-bot@fb.com
References: <20241031152844.68817-1-leon.hwang@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241031152844.68817-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-10-31 23:28 UTC+0800 ~ Leon Hwang <leon.hwang@linux.dev>
> This patch addresses the bpftool issue "Wrong callq address displayed"[0].
> 
> The issue stemmed from an incorrect program counter (PC) value used during
> disassembly with LLVM or libbfd.
> 
> For LLVM: The PC argument must represent the actual address in the kernel
> to compute the correct relative address.
> 
> For libbfd: The relative address can be adjusted by adding func_ksym within
> the custom info->print_address_func to yield the correct address.
> 
> Links:
> [0] https://github.com/libbpf/bpftool/issues/109
> 
> Changes:
> v2 -> v3:
>   * Address comment from Quentin:
>     * Remove the typedef.
> 
> v1 -> v2:
>   * Fix the broken libbfd disassembler.
> 
> Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Thanks a lot!

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>

