Return-Path: <bpf+bounces-35415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4A293A79D
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 21:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319971F232DB
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5A13DDA6;
	Tue, 23 Jul 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="deRTr/vB"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644D13C9D3
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762025; cv=none; b=cmX8WmNxU2wYrQtQ9IFC1wQ5UAYRyr/tBoROAXKxT3byVew+m4LcEAOaKh1u8tU6fIagZDUJEBCs5n38X6CcGrJl9mNiW992TUFv8Kqd58aLvlBHMvcaxKex7yJFrMRBEodg7tLRXUWqnPUL0YBHUgdEn2x+BARhdRNCzf2D4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762025; c=relaxed/simple;
	bh=iJuDHaCcQ9CeGNUcnzN22djiHosvvpdRpPOh+rMiuW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9hs6X92/RT6ZvZy86AfvMOGIziSADMnSA7i8zdn4ZnGyGyBe6rWQAoOB+EmAnENHYUwLc11ho1cRQniR02zdyERRe9uS4TiYL8Tsy/paS5ay5+1WyoVgp0D/l+zBwSq+gOdtFxGPE8Y49c6p31Uab1MIxyVBX+uUWuEGX+TSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=deRTr/vB; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <312c4729-d311-4c1c-817a-a5d43d18c4ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721762021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJuDHaCcQ9CeGNUcnzN22djiHosvvpdRpPOh+rMiuW8=;
	b=deRTr/vBviMePvsscPmPMz3f55THqRpEEzJNOkm7oE6lIsfsVbWlo4Z2V9bEY/dgv0vmwb
	Mj+fFaOefYQYRY348xkZiZeJADQkuZIzkdIvZWg8jgxmUjxmMwQRmDy2JnSAA/izanMTiC
	NLorhRV+fK3P/+bW3FhB7aMJSnOS4I4=
Date: Tue, 23 Jul 2024 12:13:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Add a test for mmap-able map in
 map
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net
References: <20240723051455.1589192-1-song@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240723051455.1589192-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/22/24 10:14 PM, Song Liu wrote:
> diff --git a/tools/testing/selftests/bpf/progs/mmap_inner_array.c b/tools/testing/selftests/bpf/progs/mmap_inner_array.c
> new file mode 100644
> index 000000000000..db8ca2aa4347
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mmap_inner_array.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>

nit. bpf_tracing.h is not needed.

> +
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"

Same for bpf_experimental.h. Removed before applying. Thanks.


