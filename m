Return-Path: <bpf+bounces-14737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F67E799F
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0591C20D9E
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D441874;
	Fri, 10 Nov 2023 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gIwkSPJP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CEC6FAB
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:57:08 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [IPv6:2001:41d0:1004:224b::aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2815F8245
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:57:07 -0800 (PST)
Message-ID: <2af5b517-5f47-644b-9d55-5400f990cba1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699599425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trmke9HBdNk5Ak7dexdUONaYWiPgsOdNXSX+82fzh7E=;
	b=gIwkSPJPY0CF+iKd9yxvbWYM4TJBYHT2v3UjLvp/wRYzPCkZ8r4PNGf496/5HlmXo8yIcE
	8Oj8IDUgecf4xPCAQVzFB8X4AoxqreqBUAh911Q686zNe7XwM9GmMQMUXEukB9qZsMBy7p
	4SXg0vPEAhF5xjN+51KKihOJf5ONVbo=
Date: Thu, 9 Nov 2023 22:56:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 00/13] Registrating struct_ops types from
 modules
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231106201252.1568931-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
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
> struct_ops map holds a reference to the module while being registered.
> 
> Changes from v10:
> 
>   - Guard btf.c from CONFIG_BPF_JIT=n. This patchset has introduced
>     symbols from bpf_struct_ops.c which is only built when
>     CONFIG_BPF_JIT=y.
> 
>   - Fix the warning of unused errout_free label by moving code that is
>     leaked to patch 8 to patch 7.

Thanks for the patches and working on this feature.

One thing that still needs to check is the "bpftool struct_ops dump" support for 
kmod's btf. The bpftool changes can be a followup. However, please check if the 
current uapi has what it needs. A quick look is the userspace should be able to 
find the kmod btf from the map_info->btf_vmlinux_value_type_id.

We discussed a bit offline on patch 8 about putting the btf and module refcnt 
together in bpf_struct_ops_map_free (but before synchronize_rcu_mult) which 
should further simplify patch 8 also. hope that will work out.

Looking forward to v12.


