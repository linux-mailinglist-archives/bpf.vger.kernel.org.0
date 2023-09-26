Return-Path: <bpf+bounces-10834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056707AE35D
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 03:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 777A02815B7
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E91EA2;
	Tue, 26 Sep 2023 01:33:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABB4A4C
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 01:33:23 +0000 (UTC)
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA3710A
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 18:33:21 -0700 (PDT)
Message-ID: <944d9d18-c07a-0fb3-c801-59b0a9203d27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695692000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgwaGqmZDnehtbXBR4N8DHtlczUAP+6F6PrQIjDAZ5c=;
	b=CQQq31+OlCt8hodjCIOqNDqfhjkA4V5bAjv1WqjhQDqyqfmHr83bBdAD3lxeB2NLvmW+oN
	oS2OFUWar86ThkRf6gu1kzgT4ZbiO1oYX3vWKup/BIBxfqyn9hjjduBm8+XY1wY8rcsoF5
	LG9vGilVXxOrlolNTOmqAryK/pBcPyI=
Date: Mon, 25 Sep 2023 18:33:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 00/11] Registrating struct_ops types from
 modules
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Given the current constraints of the current implementation,
> struct_ops cannot be registered dynamically. This presents a
> significant limitation for modules like coming fuse-bpf, which seeks
> to implement a new struct_ops type. To address this issue, a new API
> is introduced that allows the registration of new struct_ops types
> from modules.
> 
> Previously, struct_ops types were defined in bpf_struct_ops_types.h
> and collected as a static array. The new API lets callers add new
> struct_ops types dynamically. The static array has been removed and
> replaced by the per-btf struct_ops_tab.
> 
> The struct_ops subsystem relies on BTF to determine the layout of
> values in a struct_ops map and identify the subsystem that the
> struct_ops map registers to. However, the kernel BTF does not include
> the type information of struct_ops types defined by a module. The
> struct_ops subsystem requires knowledge of the corresponding module
> for a given struct_ops map and the utilization of BTF information from
> that module. We empower libbpf to determine the correct module for
> accessing the BTF information and pass an identity (FD) of the module
> btf to the kernel. The kernel looks up type information and registered
> struct_ops types directly from the given btf.
> 
> If a module exits while one or more struct_ops maps still refer to a
> struct_ops type defined by the module, it can lead to unforeseen
> complications. Therefore, it is crucial to ensure that a module
> remains intact as long as any struct_ops map is still linked to a
> struct_ops type defined by the module. To achieve this, every
> struct_ops map holds a reference to the module for each struct_ops
> map.

Overall makes sense. The next revision should be in a non-RFC state.

The 'bpftool struct_ops dump' support is also needed.

Please cc the FUSE-bpf members in the next revision.

Please also cc netdev for the patch changing the net/ipv4/bpf_tcp_ca.c.

Thanks.

