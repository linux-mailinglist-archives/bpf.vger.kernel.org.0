Return-Path: <bpf+bounces-13618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D37DBF74
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 18:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37274B20CC6
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6220B199A9;
	Mon, 30 Oct 2023 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pRgWRkaL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584FD2F0
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 17:56:46 +0000 (UTC)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C9BD
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 10:56:44 -0700 (PDT)
Message-ID: <6b0d3b4a-ff0a-4d04-8905-a564d87f446a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698688602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzCli7wbwfpNINZHKOysoYvnIr0YMAABkARiI2CkLOs=;
	b=pRgWRkaL1+M/kt2eP/19HiVWgxrXaD3eBBTyhoC/eXcLz5332q2pqxPoZjFFk0tGDB9bQP
	R/Aib26ve4TbpvsqxYieQJhra61qKcrFpVLkAfPEAe7qGk1I+R1LuCmcaoewUkIUsdjvum
	u8CWTLN9KNepoCNLglRsqtQmHlFMFN0=
Date: Mon, 30 Oct 2023 10:56:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 1/4] bpf: Fix btf_get_field_type to fail for
 multiple bpf_refcount fields
Content-Language: en-GB
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231023220030.2556229-1-davemarchevsky@fb.com>
 <20231023220030.2556229-2-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231023220030.2556229-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/23/23 3:00 PM, Dave Marchevsky wrote:
> If a struct has a bpf_refcount field, the refcount controls lifetime of
> the entire struct. Currently there's no usecase or support for multiple
> bpf_refcount fields in a struct.
>
> bpf_spin_lock and bpf_timer fields don't support multiples either, but
> with better error behavior. Parsing BTF w/ a struct containing multiple
> {bpf_spin_lock, bpf_timer} fields fails in btf_get_field_type, while
> multiple bpf_refcount fields doesn't fail BTF parsing at all, instead
> triggering a WARN_ON_ONCE in btf_parse_fields, with the verifier using
> the last bpf_refcount field to actually do refcounting.
>
> This patch changes bpf_refcount handling in btf_get_field_type to use
> same error logic as bpf_spin_lock and bpf_timer. Since it's being used
> 3x and is boilerplatey, the logic is shoved into
> field_mask_test_name_check_seen helper macro.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Fixes: d54730b50bae ("bpf: Introduce opaque bpf_refcount struct and add btf_record plumbing")

Acked-by: Yonghong Song <yonghong.song@linux.dev>


