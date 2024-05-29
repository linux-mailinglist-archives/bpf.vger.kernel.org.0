Return-Path: <bpf+bounces-30878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 103C18D415E
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 00:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D876B24901
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772D16C680;
	Wed, 29 May 2024 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hK9yJm8C"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B615B0E6
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021576; cv=none; b=dk42a54fNMtz3zNbrnqvEkCewL4jZ0ttb2pXHqvTJazBVKxJjxxM5NFGMPwl0hPhO4d+log6DE80vzNfzLRsQoA45oReJiV+O7edqXMkSkI3YNMdQBFiEIZWvEtgE72Rt2qqLEsn8/VUy1bmn3eRp8r6MY1GnVffbYUpaEUFIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021576; c=relaxed/simple;
	bh=OJ+JnQo4aG8k+kz1XB4lOYpAcvZlc18m9kz/g97kzNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYeu22NbY2a6NWRz0nsUYc38sO08wEAlRIrL7WOuUk7yOEfZyy5J1HhdujZ1strvmGIesSumsGwbRP8dY+ae4Py95hCASEn1UFXARl0oN/IC7yqcQxoRG95AFuJ56D7TajOYqNIoHoibIqBmA2NVp96d+3vxEBKnQUGlkv53BXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hK9yJm8C; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: thinker.li@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717021571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fje6aM7qihzObEUySFTO/tDIyF5ti/yJf0DF4cnHrG0=;
	b=hK9yJm8CuidsU9EhbJBXegoOkUbtyLuEP+qIm2NIIlzLnMlExtYeCgFQejqtzX8MJZ1sld
	JHKvLSd+YadKIkdJPsapFGkz41KuO6jb+9exCU7gEZAZ1cWi+bW7TmBf7oG3Ga3ZJwXJS5
	wagneJ9aZ4oms7vsBeTniQOkBUMtYKo=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: kuifeng@meta.com
Message-ID: <029a0b33-b596-4bc3-8c53-e1230ed896bb@linux.dev>
Date: Wed, 29 May 2024 15:26:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 5/8] selftests/bpf: test struct_ops with epoll
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com,
 kuifeng@meta.com
References: <20240524223036.318800-1-thinker.li@gmail.com>
 <20240524223036.318800-6-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240524223036.318800-6-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/24/24 3:30 PM, Kui-Feng Lee wrote:
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
> new file mode 100644
> index 000000000000..45eacc2ca657
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_do_detach

I was trying if the set can go without patch 6/7 but patch 5 cannot compile by 
itself... :(

progs/struct_ops_detach.c:6:16: error: expected ';' after top level declarator
     6 | char _license[] SEC("license") = "GPL";
       |                ^
       |                ;
progs/struct_ops_detach.c:8:5: error: expected parameter declarator
     8 | SEC(".struct_ops.link")

pw-bot: cr

