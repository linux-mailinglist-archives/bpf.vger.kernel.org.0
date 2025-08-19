Return-Path: <bpf+bounces-66031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE840B2CCE2
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664A71BC747C
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FDD322A06;
	Tue, 19 Aug 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SwrOVqGy"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A82D248A
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631253; cv=none; b=eoLsDK4z20urs9sNrgXh8lKPk3uflQed3lRHHShgxy+xc6kfFRw+jfoFT0BSCZBEwiNU6AULEB37FbEhVcZF1T6+XgbCYNQJUn+pp3zG8d3yJCiSDOhYSO9tS4qz6oko00xpeLqwalMS76hx9zGiMycZluJmlc93zaS/esYnIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631253; c=relaxed/simple;
	bh=pt+k+7gganuT1koKMjYMT/keyIG0P7TROZ27afkrCVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hmjtcy4CyGYv8fQmpKc7HHZzQqbYKxsMfM/anE/UdUDTUO0eilq2PsxAsiIl7rQXssT0wQvo7TLrK9BEDkAkcy24wiWBb32LRKhdW7pFlMX3sIQCoS57tqKXT8eloLd8c3wXN9FQprDVSsB0zhMd6l+X2FLmJDLlNIrFApoE4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SwrOVqGy; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <acef4a0e-7d3b-4e05-b3ca-1007580f2754@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755631248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3V4G8whUAW6DOBCF2tqk+IbXZSO7gu3VTeoA0htigx4=;
	b=SwrOVqGyB8aKKs1ObnBme+BLefT/ld3aO09w6BcxYt139LMWkfT/7VZZOBuu4hyn/l7GDj
	v5BVzv1lmUEikRnCsWW6wxrQsbC+EQQthJPvXtEHEzR1e1nmgZrmh9kEoUYcUgW3VxiCHS
	TF+QbzjESZuOUwQCDQhaNeWNEgxvtiY=
Date: Tue, 19 Aug 2025 12:20:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: "Segmentation fault" of pahole
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Changqing Li <changqing.li@windriver.com>, dwarves@vger.kernel.org,
 Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
References: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
 <37030a9d-28d8-4871-8acb-b26c59240710@linux.dev>
 <f1e2dc2b-a88b-4342-8e94-65481ae0cb4f@windriver.com>
 <ec72bbb8-b74d-49d1-bb42-5343feab8e5b@windriver.com>
 <7b071d63-71db-49d4-ab03-2dd7072a28aa@oracle.com>
 <979a1ac4-21d3-4384-8ce4-d10f41887088@linux.dev> <aKOSqWlQHZM0Icyj@x1>
 <ad67ade4-f645-4121-a4ca-40f9ecb988fe@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <ad67ade4-f645-4121-a4ca-40f9ecb988fe@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/19/25 10:33 AM, Alan Maguire wrote:
> On 18/08/2025 21:52, Arnaldo Carvalho de Melo wrote:
>> On Mon, Aug 18, 2025 at 10:56:36AM -0700, Ihor Solodrai wrote:
>>>
>>> [...]
>>>
>>> Hi everyone.
>>>
>>> I was able to reproduce the error by feeding pahole a vmlinux with a
>>> debuglink [1], created with:
>>>
>>>      vmlinux=$(realpath ~/kernels/bpf-next/.tmp_vmlinux1)
>>>      objcopy --only-keep-debug $vmlinux vmlinux.debug
>>>      objcopy --strip-all --add-gnu-debuglink=vmlinux.debug $vmlinux
>>> vmlinux.stripped
>>>
>>> With that, I got the following valgrind output:
>>>
>>>      $ valgrind ./build/pahole --btf_features=default -J
>>> ./mbox/vmlinux.stripped
>>>      ==40680== Memcheck, a memory error detector
>>>      ==40680== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et
>>> al.
>>>      ==40680== Using Valgrind-3.25.1 and LibVEX; rerun with -h for copyright
>>> info
>>>      ==40680== Command: ./build/pahole --btf_features=default -J
>>> ./mbox/vmlinux.stripped
>>>      ==40680==
>>>      ==40680== Warning: set address range perms: large range [0x7c20000,
>>> 0x32e2d000) (defined)
>>>      ==40680== Thread 2:
>>>      ==40680== Invalid write of size 8
>>>      ==40680==    at 0x487D34D: __list_del (list.h:106)
>>>      ==40680==    by 0x487D384: list_del (list.h:118)
>>>      ==40680==    by 0x487D6DB: elf_functions__delete (btf_encoder.c:170)
>>>      ==40680==    by 0x487D77C: elf_functions__new (btf_encoder.c:201)
>>>      ==40680==    by 0x4880E2A: btf_encoder__elf_functions
>>> (btf_encoder.c:1485)
>>>      ==40680==    by 0x4883558: btf_encoder__new (btf_encoder.c:2450)
>>>      ==40680==    by 0x4078DD: pahole_stealer__btf_encode (pahole.c:3160)
>>>      ==40680==    by 0x407B0D: pahole_stealer (pahole.c:3221)
>>>      ==40680==    by 0x488D2F5: cus__steal_now (dwarf_loader.c:3266)
>>>      ==40680==    by 0x488DF74: dwarf_loader__worker_thread
>>> (dwarf_loader.c:3678)
>>>      ==40680==    by 0x4A8F723: start_thread (pthread_create.c:448)
>>>      ==40680==    by 0x4B13613: clone (clone.S:100)
>>>      ==40680==  Address 0x8 is not stack'd, malloc'd or (recently) free'd
>>>
>>> As far as I understand, in principle pahole could support search for a
>>> file linked via .gnu_debuglink, but that's a separate issue.
>>
>> Agreed.
>>   
>>> Please see a bugfix patch below.
>>>
>>> [1]
>>> https://manpages.debian.org/unstable/binutils-common/objcopy.1.en.html#add~3
>>>
>>>
>>>  From 6104783080709dad0726740615149951109f839e Mon Sep 17 00:00:00 2001
>>> From: Ihor Solodrai <ihor.solodrai@linux.dev>
>>> Date: Mon, 18 Aug 2025 10:30:16 -0700
>>> Subject: [PATCH] btf_encoder: fix elf_functions cleanup on error
>>>
>>> When elf_functions__new() errors out and jumps to
>>> elf_functions__delete(), pahole segfaults on attempt to list_del the
>>> elf_functions instance from a list, to which it was never added.
>>>
>>> Fix this by changing elf_functions__delete() to
>>> elf_functions__clear(), moving list_del and free calls out of it. Then
>>> clear and free on error, and remove from the list on normal cleanup in
>>> elf_functions_list__clear().
>>
>> I think we should still call it __delete() to have a counterpart to
>> __new() and just remove that removal from the list from the __delete().

Thanks for the review. Here is a v2:

 From f3d6b1eb33df182bed94e09d716de0f883816513 Mon Sep 17 00:00:00 2001
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Date: Tue, 19 Aug 2025 12:05:38 -0700
Subject: [PATCH dwarves v2] btf_encoder: fix elf_functions cleanup on error

When elf_functions__new() errors out and jumps to
elf_functions__delete(), pahole segfaults on attempt to list_del() the
elf_functions instance from a list, to which it was never added.

Fix this by moving list_del() call out of
elf_functions__delete(). Remove from the list only on normal cleanup
in elf_functions_list__clear().

v1: 
https://lore.kernel.org/dwarves/979a1ac4-21d3-4384-8ce4-d10f41887088@linux.dev/

Closes: 
https://lore.kernel.org/dwarves/24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com/
Reported-by: Changqing Li <changqing.li@windriver.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
  btf_encoder.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 3f040fe..6300a43 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -168,7 +168,6 @@ static inline void elf_functions__delete(struct 
elf_functions *funcs)
  		free(funcs->entries[i].alias);
  	free(funcs->entries);
  	elf_symtab__delete(funcs->symtab);
-	list_del(&funcs->node);
  	free(funcs);
  }

@@ -210,6 +209,7 @@ static inline void elf_functions_list__clear(struct 
list_head *elf_functions_lis

  	list_for_each_safe(pos, tmp, elf_functions_list) {
  		funcs = list_entry(pos, struct elf_functions, node);
+		list_del(&funcs->node);
  		elf_functions__delete(funcs);
  	}
  }
-- 
2.50.1



>>
>> Apart from that, it looks to address a bug, so with the above changed:
>>
>> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
> 
> Thanks for the fix Ihor!
> 
> Sorry to bikeshed this but how about using funcs->elf as a proxy for
> determining if we have elf function info to add to the list, so we could
> then fix elf_functions__delete() to guard the list_del():
> 
> 	if (funcs->elf)
> 		list_del(&funcs->node);
> 
> 
> we'd just then need to tweak
> 
> -	funcs->elf = elf;
>          err = elf_functions__collect(funcs);
> 	if (err < 0)
>                  goto out_delete;
> +	funcs->elf = elf;
> 
> Would that work?

Not for this bug, because we actually check for a NULL Elf earlier here:

static struct elf_functions *btf_encoder__elf_functions(struct 
btf_encoder *encoder)
{
	struct elf_functions *funcs = NULL;

	if (!encoder->cu || !encoder->cu->elf)    // <-- this
		return NULL;

	funcs = elf_functions__find(encoder->cu->elf, 
&encoder->elf_functions_list);
	if (!funcs) {
		funcs = elf_functions__new(encoder->cu->elf);
		if (funcs)
			list_add(&funcs->node, &encoder->elf_functions_list);
	}

	return funcs;
}

The condition triggering an error (at least in the case of debuglink
that I made up) is in elf_symtab__new():

struct elf_symtab *elf_symtab__new(const char *name, Elf *elf)
{
	size_t symtab_index;

	if (name == NULL)
		name = ".symtab";

	GElf_Shdr shdr;
	Elf_Scn *sec = elf_section_by_name(elf, &shdr, name, &symtab_index);

	if (sec == NULL)    // <--- this
		return NULL;
     ...


> 
>> [...]


