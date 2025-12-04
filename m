Return-Path: <bpf+bounces-76085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927DCA50F8
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 20:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A719304B87B
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6232342538;
	Thu,  4 Dec 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UcxlHrcg"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7C2E7648;
	Thu,  4 Dec 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875132; cv=none; b=MAiRm4S/LDC+6PiVvCNhbq6YTXJd75P5BW4JoSay9mkuVcGzVb48nbejUnf2rYxVMUhR++nuXqiaDE2tSF/8C2Zd22FmR29V1viglYWyd6xU43sW79s2UJ92oSVErLIQN6LT7ISIsJUtq4ocppp0J09ju6RCgPFi9PYgCsNZapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875132; c=relaxed/simple;
	bh=vrRZhWSLEMc/WMLnekKX0VoTY806Bb8zLAWdWzKD1TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiGp46umFUjstm3Z0xMYTRtq7T5xYl+8YNAfogoKnaPk2Ef6gLEOq8Z6QfLXPAmlRvQx+Ff10zLCuuo363AfHFpVKAg5B/F7GsTlyO9NyEPYUQ5FQ0nXb/3NWcX6h/JcJegbkAn5PAr8dY/aPGdiBi2mEFVsecRRI8NvVEJ/HR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UcxlHrcg; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <131b4190-9c49-4f79-a99d-c00fac97fa44@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764875121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fd7z8hCbWgtDKmMPY2PrW8eDGrbySIVxu9EPmfBj/CU=;
	b=UcxlHrcg4l3JH/oQ5nd6CFdsy4iUXAQXOm17a65nE5VyclI0xOLUR2eEaPEDHSnxjcb8Pe
	/5BrEezM2yJhtcC+5SOSKA3QeFMzreRtCwuLytfQoWp/KGRtcBVYDKBZXmHYfz0doIdi7/
	kkCVb1ClhCwToYF28NVw2HeiXrrtsDE=
Date: Thu, 4 Dec 2025 11:04:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
 <de6d1c8f581fb746ad97b93dbfb054ae7db6b5d8.camel@gmail.com>
 <e8aacbc8-3702-42e9-b5f0-cfcd71df072e@linux.dev>
 <763200e4f55197da44789b97fd5379ae8bf32c08.camel@gmail.com>
 <79031f38-d131-4b78-982c-7ca6ab9de71e@linux.dev>
 <707080716569c7de7c3cb5869b67d62b55a96b68.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <707080716569c7de7c3cb5869b67d62b55a96b68.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/4/25 10:06 AM, Eduard Zingerman wrote:
> On Thu, 2025-12-04 at 09:29 -0800, Ihor Solodrai wrote:
> 
> [...]
> 
>> Ok, it seems you're conflating two separate issues.
>>
>> There is a requirement to *link* .BTF section into vmlinux, because it
>> must have a SHF_ALLOC flag, which makes objcopying the section data
>> insufficient: linker has to do some magic under the hood.
>>
>> The patch doesn't change this behavior, and this was (and is) covered
>> in the script comments.
>>
>> A separate issue is what resolve_btfids does: updates ELF in-place
>> (before the patch) or outputs detached section data (after patch).
>>
>> The paragraph in the commit message attempted to explain the decision
>> to output raw section data. And apparently I did a bad job of
>> that. I'll rewrite this part it in the next revision.
>>
>> And I feel I should clarify that I didn't claim that libelf is buggy.
>> I meant that using it is complicated, which makes resolve_btfids buggy.
> 
> So, pahole does the following:
> - elf_begin(fildes: fd, cmd: ELF_C_RDWR, ref: NULL);
> - selects a section to modify and modifies it
> - elf_flagdata(data: btf_data, cmd: ELF_C_SET, flags: ELF_F_DIRTY);
> - elf_update(elf, cmd: ELF_C_WRITE)
> - elf_end(elf)
> 
> What exactly is complicated about that?

Take a look at the resolve_btfids code that is removed in this patch,
as a consequence of switching to read-only ELF.

Also consider that before these changes resolve_btfids had a simple
job: update data buffer of a single section, importantly, without
changing its size.

Now let's say we keep "update in-place" approach (which I tried to do,
btw). In addition to previous .BTF_ids data update, resolve_btfids may
need to either add or update .BTF section changing its size (triggering
reorg of sections in ELF, depending on the flags) and add .BTF.base
section. There is also a question of how to do it: do we elf_update()
multiple times or try to "batch" the updates?

All of this is possible, but the alternative is much simpler:

    ${OBJCOPY} --add-section .BTF=${ELF_FILE}.btf ${ELF_FILE}

Why re-implement our own incomplete version of objcopy if we can just
use it to deal with the details of the ELF update?

Note also that even in pahole "add .BTF section" is implemented via
llvm-objcopy call. My guess is: to avoid the headache of figuring out
correct libelf usage.


> 
> [...]


