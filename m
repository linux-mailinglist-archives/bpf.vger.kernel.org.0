Return-Path: <bpf+bounces-22413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9939285E2E7
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530E6287AD6
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720B8121F;
	Wed, 21 Feb 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b7GRrUe7"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDB3A1A2
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532385; cv=none; b=EL0w9NjZH67El0nS8BMZCOdpmCfXjN2/Wsm7Dsat9lh8pFLXWR7m6aQvX/61qC7g6LXFAv+PnAHIupj4SFFc9gHZfPSnAUw4HIvAyo7UNaSvNwwjESeSWATWGSS+tC7/PdS/PNl7w5Cd1+A+HTU+BC2BvTX6smQJabbUv0xps1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532385; c=relaxed/simple;
	bh=eajyNq+9rusqw5cZHZGOHS6Ete2OuSKJPdWDZyHGLpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBBWJPuqTm7mn6+s864o+PTJmjnD6bukBJoakvmuAuxzehSNgOtgBgYaZUUw0Hi2OB3eem/GIyWYemu/DK8sFVJj6zTDQPVC0FzDnY19d9HxtVVJSNAbZI9zA4/R/X35Oq+dPkoGS6mRvFbmfb6iO5Lsq+OZMwLeA/lucjkUfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b7GRrUe7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1ef40b6b-a1be-4469-932f-51b3a0b68cba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708532380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYudsOo1wHPzytTXBitbCMTeHq2407TiI5WFG1je56w=;
	b=b7GRrUe78K2ARTb3YDmZKNpqVrRflTfQoVFlsuVX2AhSRzoizF2nkdk98ej9NW5Zw/aWjD
	sPiTDg1d8yJ13VPig1YlbQqGGpAEoF833r3Fo3rvJoKbJQK9zogJs6fiJ5lf72XyARTCXo
	GIGBvJ2Dj3iCcMtMcGGPoMlXSVi8o6E=
Date: Wed, 21 Feb 2024 08:19:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove intermediate test files.
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 kernel-team@fb.com
References: <20240220231102.49090-1-alexei.starovoitov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240220231102.49090-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/20/24 3:11 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> The test of linking process creates several intermediate files.
> Remove them once the build is over.
> This reduces the number of files in selftests/bpf/ directory
> from ~4400 to ~2600.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

It looks like some light skeleton *llinked*.o files left.
   [~/work/bpf-next/tools/testing/selftests/bpf (master)]$ ls *linked1*
   atomics.bpf.llinked1.o             fexit_sleep.bpf.llinked1.o              map_ptr_kern.bpf.llinked1.o       test_ringbuf_map_key.bpf.llinked1.o
   core_kern.bpf.llinked1.o           fexit_test.bpf.llinked1.o               test_ksyms_module.bpf.llinked1.o  test_static_linked1.bpf.o
   core_kern_overflow.bpf.llinked1.o  kfunc_call_test.bpf.llinked1.o          test_ksyms_weak.bpf.llinked1.o    trace_printk.bpf.llinked1.o
   fentry_test.bpf.llinked1.o         kfunc_call_test_subprog.bpf.llinked1.o  test_ringbuf.bpf.llinked1.o       trace_vprintk.bpf.llinked1.o
   [~/work/bpf-next/tools/testing/selftests/bpf (master)]$

All of them from:
   LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c            \
         trace_printk.c trace_vprintk.c map_ptr_kern.c                   \
         core_kern.c core_kern_overflow.c test_ringbuf.c                 \
         test_ringbuf_map_key.c
   LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
         kfunc_call_test_subprog.c

Considering we only have limited light skeletons, so it should not be a problem. So

Acked-by: Yonghong Song <yonghong.song@linux.dev>


