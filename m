Return-Path: <bpf+bounces-73519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD150C33589
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C5514EE750
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2532D7DE8;
	Tue,  4 Nov 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E+jV5aXO"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB3299959
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297733; cv=none; b=C0TG/85feGOm0F9iwYSvbhsFyAXKyh7zQII0RnDrsy//syv48Cj4MXf2iRyk6I2FbDpE1fLuYS4AnwIMit7kwi1wA7lPlt9EZ2nlapVP9ImFbgSRR74K+dpdp5x61JSKuOAHJl0KFQbIJ96hTJ4xhHVrbdzouqnEk6sHM9JBi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297733; c=relaxed/simple;
	bh=4hKnvHY0CZcioDqL9d/zXSRr5y3DTTvD+avJbNQ5toA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNfnAi12R6YvdOEA2IFObj0rRGtMltkUjGn5JomUFS+Id5455n5lItgY4hrKodtUpBLhc6QNfLOlU2/raeegXRRQFfmBUnxWwDZwJU9zuyQcJ1luP0HpBzTeZqFd9sJ6wk31+43EBfqZnkOzVLpYjXQg8aytJzStJl2awOb5qeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E+jV5aXO; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0c4f896-c520-4ea1-92fd-fa151dc0c57d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762297728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zo5VJEemFK3+i2Pje009TjjQOmEoSHmAs0Yzy4iimD8=;
	b=E+jV5aXOJ0bfIp8NVV4cCrZ6i6K7fMg2MnrhZA98HAhakDF4RkrFTqZ19exanL1b6cigRk
	autvHulg/B8PrOSbPGv3NGb5ivjp+TkDTb5Z57Pzh19VUv6aBIL/oIADG6F/og16QoXoJo
	UdZXy6Iitxy+JDPmH0qyzh+chomKu+E=
Date: Tue, 4 Nov 2025 15:08:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 0/2] bpf: add _impl suffix for kfuncs with implicit
 args
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251104-implv2-v3-0-4772b9ae0e06@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251104-implv2-v3-0-4772b9ae0e06@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/4/25 2:54 PM, Mykyta Yatsenko wrote:
> We have established a pattern of function naming win "_impl" suffix;
> those functions accept verifier-provided bpf_prog_aux argument.
> Following uniform convention will allow for transparent backwards
> compatibility with the upcoming KF_IMPLICIT_ARGS feature. This patch
> set aims to fix current deviation from the convention to eliminate
> unnecessary backwards incompatibility in the future.
> 
> Three kfuncs added in 6.18 don’t follow this *_impl convention and
> therefore won’t participate in the new KF_IMPLICIT_ARGS mechanism:
>  * bpf_task_work_schedule_resume()
>  * bpf_task_work_schedule_signal()
>  * bpf_stream_vprintk()
> 
> Rename them to align with the implicit-arg flow:
> bpf_task_work_schedule_resume() -> bpf_task_work_schedule_resume_impl()
> bpf_task_work_schedule_signal() -> bpf_task_work_schedule_signal_impl()
> bpf_stream_vprintk() -> bpf_stream_vprintk_impl()
> 
> The KF_IMPLICIT_ARGS mechanism is not in tree yet, so callers must
> switch to the *_impl names for now. Once the new mechanism lands, the
> plain names (without _impl) will be reintroduced.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!

> ---
> Changes in v3:
> - Fix commit messages
> - Link to v2: https://lore.kernel.org/r/20251104-implv2-v2-0-6dbc35f39f28@meta.com
> 
> Changes in v1:
> - Split commit into 2
> - Rebase on the correct branch
> - Link to v1: https://lore.kernel.org/all/20251103232319.122965-1-mykyta.yatsenko5@gmail.com/
> 
> ---
> Mykyta Yatsenko (2):
>       bpf:add _impl suffix for bpf_task_work_schedule* kfuncs
>       bpf: add _impl suffix for bpf_stream_vprintk() kfunc
> 
>  kernel/bpf/helpers.c                               | 26 +++++++++++---------
>  kernel/bpf/stream.c                                |  3 ++-
>  kernel/bpf/verifier.c                              | 12 +++++-----
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  2 +-
>  tools/lib/bpf/bpf_helpers.h                        | 28 +++++++++++-----------
>  tools/testing/selftests/bpf/progs/stream_fail.c    |  6 ++---
>  tools/testing/selftests/bpf/progs/task_work.c      |  6 ++---
>  tools/testing/selftests/bpf/progs/task_work_fail.c |  8 +++----
>  .../testing/selftests/bpf/progs/task_work_stress.c |  4 ++--
>  9 files changed, 50 insertions(+), 45 deletions(-)
> ---
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> change-id: 20251104-implv2-d6c4be255026
> 
> Best regards,


