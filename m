Return-Path: <bpf+bounces-77535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DEACEA804
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 19:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C6830204A4
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CCB2F12B7;
	Tue, 30 Dec 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YFU9FBMG"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4CB28489E
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767120304; cv=none; b=AJIp8Jz4verHp0iBsiFfyFRrs4XNiF9zZ3lKVJoyTnm+sAUxlJq2tZopyMxDgo3JXkPgGSadzV2Ljv1cmYmKSXF+WkEaBgi4HUhhyjevzb9d/wRZN+dLIo7drhtIEfzxjrGG23zbfCwdgN90Hq7PLtUainaoZmWqAu41V426VX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767120304; c=relaxed/simple;
	bh=yRC9t65PO3NSduAzMKoSrj4oMSrnLS8ACvjrMDeASUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkVHG+oy2O6adnxx5dFaVzp0JLypmyBSF8UmjfV3ybo1AGuV10p9GysjMImJJwVIcp0W6kN0VApEqHUrJMMn6PoThnI+4ve+j+/mlypgLwtna70eBMCywvGwU6VMPr90E+YeKI3Dj9fViVnf0/MBQeXygsbcCdq4BAaqplxJUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YFU9FBMG; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f845383-563e-49a7-941c-03e9db6158cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767120300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VR4Tl9AFiA48E3t4mhEMyh1YOQgRBN3waZ3st/FSflQ=;
	b=YFU9FBMGTOgpkSg9MZfgapPcIC9yjumwdoUDaBmMcBKdqJzVqMma9omfwqJJwbYSMJIHLe
	W5BidMBdcnreQsqktWGCN0feiN3N6VxEb5mUdY4BkEdmpk92iJtx6b2AFKLQsbdS6XHN3z
	/WgqNXwwu21cirsWK87Fw+setz+HDYo=
Date: Tue, 30 Dec 2025 10:44:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v1] module: Fix kernel panic when a symbol st_shndx is
 out of bounds
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-modules@vger.kernel.org, bpf <bpf@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 clang-built-linux <llvm@lists.linux.dev>
References: <20251224005752.201911-1-ihor.solodrai@linux.dev>
 <9edd1395-8651-446b-b056-9428076cd830@linux.dev>
 <af906e9e-8f94-41f5-9100-1a3b4526e220@linux.dev>
 <20251229212938.GA2701672@ax162>
 <6b87701b-98fb-4089-a201-a7b402e338f9@linux.dev>
 <CAADnVQ+X-a92LEgcd-HjTJUcw2zR_jtUmD9U-Z6OtNnvpVwfiw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQ+X-a92LEgcd-HjTJUcw2zR_jtUmD9U-Z6OtNnvpVwfiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/29/25 4:50 PM, Alexei Starovoitov wrote:
> On Mon, Dec 29, 2025 at 4:39 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 12/29/25 1:29 PM, Nathan Chancellor wrote:
>>> Hi Ihor,
>>>
>>> On Mon, Dec 29, 2025 at 12:40:10PM -0800, Ihor Solodrai wrote:
>>>> I think the simplest workaround is this one: use objcopy from binutils
>>>> instead of llvm-objcopy when doing --update-section.
>>>>
>>>> There are just 3 places where that happens, so the OBJCOPY
>>>> substitution is going to be localized.
>>>>
>>>> Also binutils is a documented requirement for compiling the kernel,
>>>> whether with clang or not [1].
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/changes.rst?h=v6.18#n29
>>>
>>> This would necessitate always specifying a CROSS_COMPILE variable when
>>> cross compiling with LLVM=1, which I would really like to avoid. The
>>> LLVM variants have generally been drop in substitutes for several
>>> versions now so some groups such as Android may not even have GNU
>>> binutils installed in their build environment (see a recent build
>>> fix [1]).
>>>
>>> I would much prefer detecting llvm-objcopy in Kconfig (such as by
>>> creating CONFIG_OBJCOPY_IS_LLVM using the existing check for
>>> llvm-objcopy in X86_X32_ABI in arch/x86/Kconfig) and requiring a working
>>> copy (>= 22.0.0 presuming the fix is soon merged) or an explicit opt
>>> into GNU objcopy via OBJCOPY=...objcopy for CONFIG_DEBUG_INFO_BTF to be
>>> selectable.
>>
>> I like the idea of opt into GNU objcopy, however I think we should
>> avoid requiring kbuilds that want CONFIG_DEBUG_INFO_BTF to change any
>> configuration (such as adding an explicit OBJCOPY= in a build command).
>>
>> I drafted a patch (pasted below), introducing BTF_OBJCOPY which
>> defaults to GNU objcopy. This implements the workaround, and should be
>> easy to update with a LLVM version check later after the bug is fixed.
>>
>> This bit:
>>
>> @@ -391,6 +391,7 @@ config DEBUG_INFO_BTF
>>         depends on PAHOLE_VERSION >= 122
>>         # pahole uses elfutils, which does not have support for Hexagon relocations
>>         depends on !HEXAGON
>> +       depends on $(success,command -v $(BTF_OBJCOPY))
>>
>> Will turn off DEBUG_INFO_BTF if relevant GNU objcopy happens to not be
>> installed.
>>
>> However I am not sure this is the right way to fail here. Because if
>> the kernel really does need BTF (which is effectively all kernels
>> using BPF), then we are breaking them anyways just downstream of the
>> build.
>>
>> An "objcopy: command not found" might make some pipelines red, but it
>> is very clear how to address.
>>
>> Thoughts?
>>
>>
>> From 7c3b9cce97cc76d0365d8948b1ca36c61faddde3 Mon Sep 17 00:00:00 2001
>> From: Ihor Solodrai <ihor.solodrai@linux.dev>
>> Date: Mon, 29 Dec 2025 15:49:51 -0800
>> Subject: [PATCH] BTF_OBJCOPY
>>
>> ---
>>  Makefile                             |  6 +++++-
>>  lib/Kconfig.debug                    |  1 +
>>  scripts/gen-btf.sh                   | 10 +++++-----
>>  scripts/link-vmlinux.sh              |  2 +-
>>  tools/testing/selftests/bpf/Makefile |  4 ++--
>>  5 files changed, 14 insertions(+), 9 deletions(-)
> 
> All the makefile hackery looks like overkill and wrong direction.
> 
> What's wrong with kernel/module/main.c change?
> 
> Module loading already does a bunch of sanity checks for ELF
> in elf_validity_cache_copy().
> 
> + if (sym[i].st_shndx >= info->hdr->e_shnum)
> is just one more.
> 
> Maybe it can be moved to elf_validity*() somewhere,
> but that's a minor detail.
> 
> iiuc llvm-objcopy affects only bpf testmod, so not a general
> issue that needs top level makefile changes.

By the way, we don't have to put BTF_OBJCOPY variable in the top level
Makefile.  It can be defined in Makefile.btf, which is included only
with CONFIG_DEBUG_INFO_BTF=y

We have to define BTF_OBJCOPY in the top-level makefile *if* we want
CONFIG_DEBUG_INFO_BTF to depend on it, and get disabled if BTF_OBJCOPY
is not set/available.

I was trying to address Nathan's concern, that some kernel build
environments might not have GNU binutils installed, and kconfig should
detect that.  IMO putting BTF_OBJCOPY in Makefile.btf is more
appropriate, assuming the BTF_OBJCOPY variable is at all an acceptable
workaround for the llvm-objcopy bug.




