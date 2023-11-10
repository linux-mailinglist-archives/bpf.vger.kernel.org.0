Return-Path: <bpf+bounces-14684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5297E775E
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF41E28161A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9F51374;
	Fri, 10 Nov 2023 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZrsAb3e"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE121363
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 02:23:33 +0000 (UTC)
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D003420B
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:23:32 -0800 (PST)
Message-ID: <fc7f56af-03e1-faa1-1e53-12dfe353d46e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699583010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1WlOoIci7egeLN8bFPY4JFeTuNURMPYyWiYjAnI/To=;
	b=MZrsAb3ekPlGFXhfGbUN5NdNsqFO10VIBIbIegDpZBiY0MGsMXy2MdhaVYWpnOHuXBN0lL
	2Euzk58mLQHiXpPGet8LsauKjtYkrNrVcZG94nZjzHEwqQPV+utHWhep02rtm51wcjwbcI
	zApXXRd4liCdI9YVtFuaXB/EJmSciwQ=
Date: Thu, 9 Nov 2023 18:23:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 13/13] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-14-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231106201252.1568931-14-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Create a new struct_ops type called bpf_testmod_ops within the bpf_testmod
> module. When a struct_ops object is registered, the bpf_testmod module will
> invoke test_2 from the module.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  59 +++++++
>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
>   .../bpf/prog_tests/test_struct_ops_module.c   | 144 ++++++++++++++++++
>   .../selftests/bpf/progs/struct_ops_module.c   |  30 ++++
>   .../testing/selftests/bpf/progs/testmod_btf.c |  26 ++++
>   5 files changed, 264 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
>   create mode 100644 tools/testing/selftests/bpf/progs/testmod_btf.c
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index a5e246f7b202..418e10311c33 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2020 Facebook */
> +#include <linux/bpf.h>
>   #include <linux/btf.h>
>   #include <linux/btf_ids.h>
>   #include <linux/error-injection.h>
> @@ -522,11 +523,66 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
>   BTF_SET8_END(bpf_testmod_check_kfunc_ids)
>   
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES

I don't think it is needed. It should have been enabled (directly/indirectly) by 
the selftests/bpf/config already.

[ ... ]


