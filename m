Return-Path: <bpf+bounces-76667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AC9CC09F4
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF524301B83B
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDCF2C21FF;
	Tue, 16 Dec 2025 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e1OZWV13"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB123EA8B
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765852867; cv=none; b=rBRwHsSnSTgt7nDGtBw1kZSEgC8q5ixEPm0R7JyVOwLjKW8n30pZM6t4wH0/IYNeQlrWYIAYhL7iXZZ00MRYYeba7VFwai+BEnYBSm5KCYhoFHTnk9EWrafLcj8ncuN3egOR7Ip7Lu6wSvUO1elu0UyBC+qtibVLER+bHOJPf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765852867; c=relaxed/simple;
	bh=tfWDHofzMebiRcOGNldFQDVacKqeMdwUb7FytkcumI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCP5C4iV/LAlntS8Pr/9TMQT2USm/0Jg2Sc5ygGuXFaoGg1aX5lxQZkcYIA+8OK9hDIlweNmLRPcSoX8DjRPr10puohIg1rzYFlYL+EDrbgHKBI/Ubwb/ntDAM1RFXv1SpuI7zfd/K18TyMTa1qZJI6Ny1PzlWZWaJjH4TdAWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e1OZWV13; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <85b89c11-8a97-49ec-9c5c-9b028d339195@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765852862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzZovHK8HDtcFcCDm3GlnuGabKeFhqNDxebi6h1KZcI=;
	b=e1OZWV13x75p6CY73SkIucf4cGTc+rdgnzHcntUQy5MwlHuWwoAfB2WrPdpclDU/WJpehr
	i0oSa7ZJyn0PiEA51BzXfmhPqS+mxjNVYViyIbPWXqPbQwuu04KzjSS4aFFDVW01hH6/T9
	8h/5y8B4gtP99gc5LPpdT9fQyinEpK4=
Date: Mon, 15 Dec 2025 18:40:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/6] lib/Kconfig.debug: Set the minimum
 required pahole version to v1.22
To: Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
 <20251205223046.4155870-5-ihor.solodrai@linux.dev>
 <8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/12/25 9:26 AM, Alan Maguire wrote:
> On 05/12/2025 22:30, Ihor Solodrai wrote:
>> Subsequent patches in the series change vmlinux linking scripts to
>> unconditionally pass --btf_encode_detached to pahole, which was
>> introduced in v1.22 [1][2].
>>
>> This change allows to remove PAHOLE_HAS_SPLIT_BTF Kconfig option and
>> other checks of older pahole versions.
>>
>> [1] https://github.com/acmel/dwarves/releases/tag/v1.22
>> [2] https://lore.kernel.org/bpf/cbafbf4e-9073-4383-8ee6-1353f9e5869c@oracle.com/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  lib/Kconfig.debug         | 13 ++++---------
>>  scripts/Makefile.btf      |  9 +--------
>>  tools/sched_ext/README.md |  1 -
>>  3 files changed, 5 insertions(+), 18 deletions(-)
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 742b23ef0d8b..3abf3ae554b6 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -389,18 +389,13 @@ config DEBUG_INFO_BTF
>>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>>  	depends on BPF_SYSCALL
>> -	depends on PAHOLE_VERSION >= 116
>> -	depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >= 121
>> +	depends on PAHOLE_VERSION >= 122
>>  	# pahole uses elfutils, which does not have support for Hexagon relocations
>>  	depends on !HEXAGON
>>  	help
>>  	  Generate deduplicated BTF type information from DWARF debug info.
>> -	  Turning this on requires pahole v1.16 or later (v1.21 or later to
>> -	  support DWARF 5), which will convert DWARF type info into equivalent
>> -	  deduplicated BTF type info.
>> -
>> -config PAHOLE_HAS_SPLIT_BTF
>> -	def_bool PAHOLE_VERSION >= 119
>> +	  Turning this on requires pahole v1.22 or later, which will convert
>> +	  DWARF type info into equivalent deduplicated BTF type info.
>>  
>>  config PAHOLE_HAS_BTF_TAG
>>  	def_bool PAHOLE_VERSION >= 123
>> @@ -422,7 +417,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
>>  config DEBUG_INFO_BTF_MODULES
>>  	bool "Generate BTF type information for kernel modules"
>>  	default y
>> -	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
>> +	depends on DEBUG_INFO_BTF && MODULES
>>  	help
>>  	  Generate compact split BTF type information for kernel modules.
>>  
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index db76335dd917..7c1cd6c2ff75 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -7,14 +7,7 @@ JOBS := $(patsubst -j%,%,$(filter -j%,$(MAKEFLAGS)))
>>
> 
> hi Ihor, a small suggestion here, and it is orthogonal to what you're 
> doing here, so just for consideration if you're planning a v4 since you're 
> touching this file.

Hi Alan. v4 for sure, and maybe even v5, we'll see.

> 
> We've had problems in the past because we get pahole version from .config
> in Makefile.btf
> 
> pahole-ver := $(CONFIG_PAHOLE_VERSION)
> 
> and it can be outdated.
> 
> Specifically the problem is that if "make oldconfig" is not run after
> updating pahole we don't get the actual pahole version during builds
> and options can be missing. See [1] for an example, but perhaps we
> should do
> 
> pahole-ver := $(shell $(srctree)/scripts/pahole-version.sh)
> 
> in Makefile.btf to ensure the value reflects latest pahole and that
> then determines which options we use? Andrii suggested an approach like
> CC_VERSION_TEXT might be worth pursuing; AFAICT that recomputes the
> CC_VERSION and warns the user if there is a version difference. Given that
> the CONFIG pahole version requirements are all pretty modest - it might
> simply be enough to recompute it in Makefile.btf and perhaps ensure it's 
> not less than CONFIG_PAHOLE_VERSION. Just a thought anyway. Thanks!

Yeah, I am aware of the issue.

I am not sure version refresh in Makefile.btf would be enough, since
there are config dependencies in Kconfig.debug.  So we either need to
trigger re-config, and maybe even force full kernel re-build, or
somehow get rid of the version checks in the kconfig, which may be a
challenge.

I think the simplest thing we could is to check if the version has
changed and fail the build. That's a "panic!" approach though.

I'll look into how compiler versions are checked, maybe it's not that
hard to add similar behavior for pahole.


> 
> Alan
>  
> [1] https://lore.kernel.org/bpf/CAEf4BzYi1xX3p_bY3j9dEuPvtCW3H7z=p2vdn-2GY0OOenxQAg@mail.gmail.com/
> 


