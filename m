Return-Path: <bpf+bounces-63390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D41DEB06A66
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E524564200
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD7405F7;
	Wed, 16 Jul 2025 00:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmcXucJw"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86A2E36F4;
	Wed, 16 Jul 2025 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625628; cv=none; b=rSq9QNPhwSchciamQtip7jKu6YXxXSPkx7NQVaSik6hY+nycK/hBnfZRvx7v7QAohJNWNhUow+bjyvKe/R6Ed77yDgLMM4hRkRrZmGxePiG7tXeTzQjt9sV4aHYLDRe9Ncwt0ZpyCPq/PkrdTT610yjZz7LeiSevWN7wMuhO74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625628; c=relaxed/simple;
	bh=o26up7XWLVyfUZaEO5H78deSqYI1YRtMc1XuRG5c03M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WNEwqUaVxZjNiszsFNVJj/NOxPf8H6EGFm3XOMDf9idpGy31yzouqP2dHW9zOSuUj81ct4MlElwPyAeEP1p0PBtDIU4ODdgQG8tmoZoIYKQG2cYr1xQjkZeXHbFMjViJhc23d6oCFQeeC6ZjN7yK5ds8d+61m9avb9eNeUDgHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmcXucJw; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3dfbc97c-5721-4bd7-9443-ce57d7ba592c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752625621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t35EhvxvVIgR0YLOtYYZ8sab82R/SSIxUd51N5PlS8g=;
	b=qmcXucJw6j+lDZnryS9NoM9ToT2lCLqOnjVi08u6cc51ZQ2agrFaTrjqYozZj2zVh3oFYg
	LLfiUGmTqdH5BmfnEhxhKOvIBqxGtieON5zmC3EW3h6/sJdGyJxxb/yDVPASmnSd6ODsr5
	nTXrV2nJosoLrLYGwNR/GtXgpg0qA7c=
Date: Tue, 15 Jul 2025 17:26:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 17/18] selftests/bpf: add basic testcases for
 tracing_multi
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-18-dongml2@chinatelecom.cn>
 <CAADnVQKxgrXZ3ATO4rdC9GcTtXvURpKR8XcGCdCa_qPh4RGFrQ@mail.gmail.com>
 <9771eaa3-413a-4ab0-b7e1-d6a6f326c43f@linux.dev>
Content-Language: en-US
In-Reply-To: <9771eaa3-413a-4ab0-b7e1-d6a6f326c43f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/14/25 4:49 PM, Ihor Solodrai wrote:
> On 7/8/25 1:07 PM, Alexei Starovoitov wrote:
>> On Thu, Jul 3, 2025 at 5:18 AM Menglong Dong 
>> <menglong8.dong@gmail.com> wrote:
>>>
>>> +               return true;
>>> +
>>> +       /* Following symbols have multi definition in kallsyms, take
>>> +        * "t_next" for example:
>>> +        *
>>> +        *     ffffffff813c10d0 t t_next
>>> +        *     ffffffff813d31b0 t t_next
>>> +        *     ffffffff813e06b0 t t_next
>>> +        *     ffffffff813eb360 t t_next
>>> +        *     ffffffff81613360 t t_next
>>> +        *
>>> +        * but only one of them have corresponding mrecord:
>>> +        *     ffffffff81613364 t_next
>>> +        *
>>> +        * The kernel search the target function address by the symbol
>>> +        * name "t_next" with kallsyms_lookup_name() during attaching
>>> +        * and the function "0xffffffff813c10d0" can be matched, which
>>> +        * doesn't have a corresponding mrecord. And this will make
>>> +        * the attach failing. Skip the functions like this.
>>> +        *
>>> +        * The list maybe not whole, so we still can fail......We need a
>>> +        * way to make the whole things right. Yes, we need fix it :/
>>> +        */
>>> +       if (!strcmp(name, "kill_pid_usb_asyncio"))
>>> +               return true;
>>> +       if (!strcmp(name, "t_next"))
>>> +               return true;
>>> +       if (!strcmp(name, "t_stop"))
>>> +               return true;

This little patch will filter out from BTF any static functions with
the same name that appear more than once.

diff --git a/btf_encoder.c b/btf_encoder.c
index 0bc2334..6441269 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -96,7 +96,8 @@ struct elf_function {
         const char      *name;
         char            *alias;
         size_t          prefixlen;
-       bool            kfunc;
+       uint8_t         is_static:1;
+       uint8_t         kfunc:1;
         uint32_t        kfunc_flags;
  };

@@ -1374,7 +1375,7 @@ static int saved_functions_combine(struct 
btf_encoder_func_state *a, struct btf_
                 return ret;
         optimized = a->optimized_parms | b->optimized_parms;
         unexpected = a->unexpected_reg | b->unexpected_reg;
-       inconsistent = a->inconsistent_proto | b->inconsistent_proto;
+       inconsistent = a->inconsistent_proto | b->inconsistent_proto | 
a->elf->is_static | b->elf->is_static;
         if (!unexpected && !inconsistent && !funcs__match(a, b))
                 inconsistent = 1;
         a->optimized_parms = b->optimized_parms = optimized;
@@ -1461,6 +1462,8 @@ static void elf_functions__collect_function(struct 
elf_functions *functions, GEl

         func = &functions->entries[functions->cnt];
         func->name = name;
+       func->is_static = elf_sym__bind(sym) == STB_LOCAL;
+
         if (strchr(name, '.')) {
                 const char *suffix = strchr(name, '.');

See the full BTF functions diff here (from vmlinux 6.15.3):
https://gist.github.com/theihor/3f8fabc32d916e592f8e84f434d9950c

This covers t_next and t_stop, but not all functions in the list. Some
of them are not static, such as kill_pid_usb_asyncio [1]. And p_next,
for example, appears only once [2].

So filtering statics in pahole might not be the only problem here.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/signal.c#n1521
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/trace/trace_events.c#n1717


>>
>> This looks like pahole bug. It shouldn't emit BTF for static
>> functions with the same name in different files.
>> I recall we discussed it in the past and I thought the fix had landed.
> 
> I checked this particular case (the t_next function), and what seems
> to be happening is that all function prototypes match, according to
> this check in pahole's BTF encoding:
> 
> * https://github.com/acmel/dwarves/blob/v1.30/btf_encoder.c#L1378
> * https://github.com/acmel/dwarves/blob/v1.30/btf_encoder.c#L1112-L1152
> 
> That is: the name, number and types of parameters all match.
> 
> So at least according to the current pahole logic the prototypes are
> *consistent*. As a result, a single BTF function t_next is emitted.
> 
> Maybe funcs__match() check should be even more strict? Say, disallow
> static functions?
> 
> I am not sure that the draft that Jiri sent [1] is right as it just
> filters out duplicates by name.
> 
> [1] https://lore.kernel.org/bpf/aHD0IdJBqd3XNybw@krava/
> 


