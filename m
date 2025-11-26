Return-Path: <bpf+bounces-75605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A74C8B84A
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 20:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47483A4B8D
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BAD33EB1D;
	Wed, 26 Nov 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jWv7MUXT"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4E3126A2
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183735; cv=none; b=CGII9oHFfzVhBGyV86h7yZ6P+ImOKSoCM5IVniwDS8Xe/u4pHUV2aMQTAL9+98UEE4ZQ8IKgVIiJUIb7RXv4k+7KMgYAc7+H2TadV6RLdqYKRBuNykxM+AGbpxbZGI+JJrStM63m0CKeyZ3QzajXdVVZhhpiMDhvIlnLeRvF+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183735; c=relaxed/simple;
	bh=PGb8QzCiz9c4xSY4LPkdirXHsPvgBNAHw9qgYtuKWIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSyeB3lSs1eKRxGf32SeEEGrDSyA4mtYmdIrr+nnh0U/NCRhQ2v8ZpUp0PLv08vQZiAyr5eLETmlX3tSdf4qxLlFJqKlsFUkhiG8jkkpS5Xr3Vnt84FwaU4XZ2GLoaOHZHG+4ZSGBzqFoLD6TKtInuBNhhZ+8b4tDj5xD3BbQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jWv7MUXT; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <362b4519-522f-440b-a2ed-bd233166609b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764183718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YF+vsyUPsLX+oIXuhWbF9px0T1obEdHnI8t1Kbok7xs=;
	b=jWv7MUXTuCuMm5O1dI2pDhkIp7Tos4/paH/uMgfCpFyy0ge38vXNgek8dsVN03YJ9sK9wu
	DzidIyBE0iGb5GOC9oZXsHrGbjJ+eJ5xD9VKxVosKouOiVVpKfQG9nnCu7vZntPSPhWeZR
	O5/qXNoXN68Vee2K6QC6hpus+iw3ujw=
Date: Wed, 26 Nov 2025 11:01:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 0/4] resolve_btfids: Support for BTF
 modifications
To: Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Donglin Peng <dolinux.peng@gmail.com>
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
 <5bd0b578-e9ff-4958-b01c-fa3e9336eecb@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <5bd0b578-e9ff-4958-b01c-fa3e9336eecb@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/26/25 4:36 AM, Alan Maguire wrote:
> On 26/11/2025 01:26, Ihor Solodrai wrote:
>> This series changes resolve_btfids and kernel build scripts to enable
>> BTF transformations in resolve_btfids. Main motivation for enhancing
>> resolve_btfids is to reduce dependency of the kernel build on pahole
>> capabilities [1] and enable BTF features and optimizations [2][3]
>> particular to the kernel.
>>
>> Patches #1-#3 in the series are non-functional refactoring in
>> resolve_btfids. The last patch (#4) makes significant changes in
>> resolve_btfids and introduces scripts/gen-btf.sh. Implementation
>> changes are described in detail in the patch description.
>>
>> One RFC item in this patchset is the --distilled_base [4] handling.
>> Before this patchset .BTF.base was generated and added to target
>> binary by pahole, based on these conditions [5]:
>>   * pahole version >=1.28
>>   * the kernel module is out-of-tree (KBUILD_EXTMOD)
>>
>> Since BTF finalization is now done by resolve_btfids, it requires
>> btf__distill_base() to happen there. However, in my opinion, it is
>> unnecessary to add and pass through a --distilled_base flag for
>> resolve_btfids.
>>
> hi Ihor,
> 
> Can you say more about what constitutes BTF finalization and why BTF
> distillation prior to finalization (i.e. in pahole) isn't workable? Is
> it the concern that we eliminate types due to filtering, or is it a
> problem with sorting/tracking type ids? Are there operations we
> do/anticipate that make prior distillation infeasbile? Thanks!

Hi Alan,

That's a good question. AFAIU the distillation should be done on the
final BTF, after all the transformations (sorting, adding/removing BTF
types) have been applied. At least this way we can be sure that the
distilled base is valid.

We certainly want BTF generation process to be the same for modules
and the kernel, which means that BTF modifications in resolve_btfids
have to be applied to module BTF also.

So the question is whether btf2btf will be safe to do *after*
distillation, and that of course depends on the specifics.

Let's say pahole generated BTF for a module and a distilled base.  If
later some types are removed from module BTF, or a new type is added
(that might refer to a type absent in distilled base), is the btf/base
pair still valid?

My intuition is that it is more reliable to distill the final-final
BTF, and so with resolve_btfids taking over kernel BTF finalization it
makes sense to do it there. Otherwise we may be upfront limiting
ourselves in how module BTF can be changed in resolve_btfids.

What are the reasons to keep distillation in pahole? It's a simple
libbpf API call after all. Anything I might be missing?


> 
>> Logically, any split BTF referring to kernel BTF is not very useful
>> without the .BTF.base, which is why the feature was developed in the
>> first place. Therefore it makes sense to always emit .BTF.base for all
>> modules, unconditionally. This is implemented in the series.
>>
>> However it might be argued that .BTF.base is redundant for in-tree
>> modules: it takes space the module ELF and triggers unnecessary
>> btf__relocate() call on load [6]. It can be avoided by special-casing
>> in-tree module handling in resolve_btfids either with a flag or by
>> checking env variables. The trade-off is slight performance impact vs
>> code complexity.
>>
> 
> I would say avoid distillation for in-tree modules if possible, as it
> imposes runtime costs in relocation/type renumbering on module load. For
> large modules (amdgpu take a bow) that could be non-trivial time-wise.
> IMO the build-time costs/complexities are worth paying to avoid a
> runtime tax on module load.

Acked. I still would like to avoid passing flags around if possible.

Is it reasonable to simply check for KBUILD_EXTMOD env var from
withing resolve_btfids? Any drawbacks to that?

Thanks.


> 
>> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
>> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
>> [3] https://lore.kernel.org/bpf/20251119031531.1817099-1-dolinux.peng@gmail.com/
>> [4] https://docs.kernel.org/bpf/btf.html#btf-base-section
>> [5] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scripts/Makefile.btf#n29
>> [6] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/kernel/bpf/btf.c#n6358
>>
>> Ihor Solodrai (4):
>>   resolve_btfids: rename object btf field to btf_path
>>   resolve_btfids: factor out load_btf()
>>   resolve_btfids: introduce enum btf_id_kind
>>   resolve_btfids: change in-place update with raw binary output
>>
>>  MAINTAINERS                     |   1 +
>>  scripts/Makefile.modfinal       |   5 +-
>>  scripts/gen-btf.sh              | 166 ++++++++++++++++++++++
>>  scripts/link-vmlinux.sh         |  42 +-----
>>  tools/bpf/resolve_btfids/main.c | 234 +++++++++++++++++++++++---------
>>  5 files changed, 348 insertions(+), 100 deletions(-)
>>  create mode 100755 scripts/gen-btf.sh
>>
> 


