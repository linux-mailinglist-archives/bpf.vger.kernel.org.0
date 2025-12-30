Return-Path: <bpf+bounces-77496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A89C6CE8752
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 01:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF743014D9F
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 00:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643C2DCF67;
	Tue, 30 Dec 2025 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oLZ7OzKO"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523242DCF6C;
	Tue, 30 Dec 2025 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767056365; cv=none; b=BAbbccrvCROsFgZ8qm1t6XZXBBeX7Me8exNTZDOUy3IGlHyXHMP2aKQie8wDaLOy18TfSgvynhM8OYdNOaFrmijy0vAME7w9aIIXhV3h6pGKduYWbOzUJm47VX9SBuPfY3iB9IS43Mc5OFh10EWG04ipkrFevOautum5BDoRh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767056365; c=relaxed/simple;
	bh=2lxDnwdsZekXe4NfDsKQJITWCMDUWP6xiRX5VchwVV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/VNADts5yLU90PsjaMUHC76ju/yZY8QZQDqaVXhyhrAVL2/sh6I0NB2B76yRFF87EqSRfmBKUIaz3jvgBzOMA03fvr0Gxt/8SPJmlV/8d42Hp+i9/Aw/JAMTjAVuYRwHNutZxSM6hD6MhZCo6+6zL0xR+/9UTNqLi22wlnWpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oLZ7OzKO; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26800836-3864-47ec-910b-aed571758f04@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767056351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSyzvjl2It73lqYA6EDJUDBcvQxjHw4X7Zb7XrvQVUQ=;
	b=oLZ7OzKOpf4AbXx1p7wAm4IkLiVOcM7MnlHBnQYpYeKv2eymkHXiCpvQz03QcYr9tU4Bcc
	WO/jFUHfHLy+ol+q9jTWIiewXfC4ZhoMW2JWLqXm3jpqTCQ0vVgUq9r9RnZRw1hiOGyWHH
	FgosFZ8sEO9qw+v4wRKSoxAGCYXUflA=
Date: Mon, 29 Dec 2025 16:59:03 -0800
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
>> [...]
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

AFAIU, the problem is that the llvm-objcopy bug is essentially
use-after-free [1], that may (or may not) corrupt st_shndx value of
some symbols when executing --update-section.

And so we can't trust this command anywhere in the kernel build, even
though it only manifested itself in a BPF test module.

With the gen-btf.sh changes ${OBJCOPY} --update-section is called for
all binaries with .BTF_ids: vmlinux and all modules.

The fix in module.c is an independent kernel bug, that is hopefully
fixed with the st_shndx check.

[1] https://github.com/llvm/llvm-project/issues/168060#issuecomment-3533552952


