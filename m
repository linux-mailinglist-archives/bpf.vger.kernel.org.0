Return-Path: <bpf+bounces-76201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998CCA9CB5
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 02:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A553304E3A8
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 00:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684EF1D7E5C;
	Sat,  6 Dec 2025 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MYtOH8Zv"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FB4A35
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982775; cv=none; b=j/pevLfa2dFBHxdAZVMwYApATfCWiiUGl5PKufQdZ5azXsCOsMgjzcYZAtV4Tzgj2LxDkJWIn4YX9Z+jEr7z9ILvPZpHsbbAokqJH1CC+TnM+VELK/67ju6tl1q4fMmzoogNzDIUvjAGTka0UfMdV7v4JkMuu4i92oEzQx/jVcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982775; c=relaxed/simple;
	bh=0jQ3a9oazjtLu0ajytfIcW6UxT6F8I4cHqmPzkFmk+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SC5B/PLJvZKQ7V6Rm3oe7n9X64Xf0FZhQVIDM82szsu9gG5xzcfh8HismZKp0wjXYSUoO9fjgRf48ToA6ExCjHpZ5vOQ6LWADKSdlKl6br8k4Pw9Oyha3b2rRknFjKK7UoOgVyof4FMfx83qO3kAhuY/67d0g2nGzwr9kscK30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MYtOH8Zv; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <941a15fa-0048-4c60-a3ae-fe1c00386c89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764982761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTfQkhpJ0K8ZKCiJ/wOi9QlqOTf2vyou5RQO0OZGMVs=;
	b=MYtOH8ZvkTGnxHos6voi5+3p9O/ZPsEYNBHbGkRB9NC4Yy029HsDBXLGllH8REL2oFwzpj
	o8CXkvHaWjjvnK5+Lll2Q8AW0cMRKhcjg2ilqI+mff5l/mQUfi9y4byU3IyhtdqJ1Y6tto
	Mxj12ujAloLnYbXYF38ngIcslk8ZhHg=
Date: Fri, 5 Dec 2025 16:58:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/6] lib/Kconfig.debug: Set the minimum
 required pahole version to v1.22
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng
 <dolinux.peng@gmail.com>, bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
 <20251205223046.4155870-5-ihor.solodrai@linux.dev>
 <CAEf4BzbwTWGs0g1dhrRGpYOxA-ce5n9z3FSKPHZ+KZ=fpJODag@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzbwTWGs0g1dhrRGpYOxA-ce5n9z3FSKPHZ+KZ=fpJODag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/5/25 4:32 PM, Andrii Nakryiko wrote:
> On Fri, Dec 5, 2025 at 2:32 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
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
>>         depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>>         depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>>         depends on BPF_SYSCALL
>> -       depends on PAHOLE_VERSION >= 116
>> -       depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >= 121
>> +       depends on PAHOLE_VERSION >= 122
>>         # pahole uses elfutils, which does not have support for Hexagon relocations
>>         depends on !HEXAGON
>>         help
>>           Generate deduplicated BTF type information from DWARF debug info.
>> -         Turning this on requires pahole v1.16 or later (v1.21 or later to
>> -         support DWARF 5), which will convert DWARF type info into equivalent
>> -         deduplicated BTF type info.
>> -
>> -config PAHOLE_HAS_SPLIT_BTF
>> -       def_bool PAHOLE_VERSION >= 119
>> +         Turning this on requires pahole v1.22 or later, which will convert
>> +         DWARF type info into equivalent deduplicated BTF type info.
>>
>>  config PAHOLE_HAS_BTF_TAG
>>         def_bool PAHOLE_VERSION >= 123
>> @@ -422,7 +417,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
>>  config DEBUG_INFO_BTF_MODULES
>>         bool "Generate BTF type information for kernel modules"
>>         default y
>> -       depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
>> +       depends on DEBUG_INFO_BTF && MODULES
>>         help
>>           Generate compact split BTF type information for kernel modules.
>>
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index db76335dd917..7c1cd6c2ff75 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -7,14 +7,7 @@ JOBS := $(patsubst -j%,%,$(filter -j%,$(MAKEFLAGS)))
>>
>>  ifeq ($(call test-le, $(pahole-ver), 125),y)
>>
>> -# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
>> -ifeq ($(call test-le, $(pahole-ver), 121),y)
>> -pahole-flags-$(call test-ge, $(pahole-ver), 118)       += --skip_encoding_btf_vars
>> -endif
>> -
>> -pahole-flags-$(call test-ge, $(pahole-ver), 121)       += --btf_gen_floats
>> -
>> -pahole-flags-$(call test-ge, $(pahole-ver), 122)       += -j$(JOBS)
>> +pahole-flags-$(call test-ge, $(pahole-ver), 122)       += --btf_gen_floats -j$(JOBS)
> 
> this should be unconditional given we expect at least 1.22, no?

Yes, it can be unconditional, but still under if ver < 125.

> 
>>
>>  pahole-flags-$(call test-ge, $(pahole-ver), 125)       += --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
>>
>> diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
>> index 16a42e4060f6..56a9d1557ac4 100644
>> --- a/tools/sched_ext/README.md
>> +++ b/tools/sched_ext/README.md
>> @@ -65,7 +65,6 @@ It's also recommended that you also include the following Kconfig options:
>>  ```
>>  CONFIG_BPF_JIT_ALWAYS_ON=y
>>  CONFIG_BPF_JIT_DEFAULT_ON=y
>> -CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>>  CONFIG_PAHOLE_HAS_BTF_TAG=y
>>  ```
>>
>> --
>> 2.52.0
>>


