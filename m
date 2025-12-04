Return-Path: <bpf+bounces-76076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E088DCA4C75
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 18:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 834E0304FB8C
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94813002B6;
	Thu,  4 Dec 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o0FpQ1HN"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4128851F
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869377; cv=none; b=dzZXPNe6uBGHOBicnaLNoqcuW/zEe7KZecWPyiAuqRfItLS7CEuYR9paKGpMntYt4CvD53aYI+hF8su8E+e7qPp4bA5EZywA36ySzDWIqtd6vJlND6r6Rj/BMS5/ZLyvb6DuaGmIp1I44pPeeOL2uEN/EZgW2yNw7LysOHeVUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869377; c=relaxed/simple;
	bh=VObQTcmuw106kO7LqSo5gKzmOxYv+iNa0d9/Azcw9K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNvodEKU53yJP00mzAxDMtTCzAubsthQav3wiK2Hj0ZouCm/ycBZfJoWjIHRoNuZ/YdGmGtBcUqQvQEFCtdgzr6EMyH3Fv3UJYpZ0XpPjDAANIP3B+nU8HYaiO7yefSapM8dyr/q7zsW2I3Qtt7KdETqb3RArDl5R8J/6k0P+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o0FpQ1HN; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79031f38-d131-4b78-982c-7ca6ab9de71e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764869363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzdwd2xo/mbl9AiCmV7jWAIZgfbn0MTtXVPvlyQqC0U=;
	b=o0FpQ1HNNc+dzIR1vTeCURGZ+zrS4s1vZgFdhJ9/C8y+aLVMunED8ES9Z1Tq13ji9EtRWl
	El9QI9VWJPhHq1p4EnymoKwPaZjHfPYeBnJ2e6Ywjvlk3vIhXqRQIHt019nIekxQCQN7cn
	2GPbzqtkyGmWolooa7AgHhi7TZ0ozCI=
Date: Thu, 4 Dec 2025 09:29:14 -0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <763200e4f55197da44789b97fd5379ae8bf32c08.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/4/25 8:57 AM, Eduard Zingerman wrote:
> On Wed, 2025-12-03 at 21:13 -0800, Ihor Solodrai wrote:
>> On 12/1/25 11:55 AM, Eduard Zingerman wrote:
>>> On Thu, 2025-11-27 at 10:52 -0800, Ihor Solodrai wrote:
>>>> Currently resolve_btfids updates .BTF_ids section of an ELF file
>>>> in-place, based on the contents of provided BTF, usually within the
>>>> same input file, and optionally a BTF base.
>>>>
>>
>> Hi Eduard, thank you for the review.
>>
>>>> This patch changes resolve_btfids behavior to enable BTF
>>>> transformations as part of its main operation. To achieve this
>>>> in-place ELF write in resolve_btfids is replaced with generation of
>>>> the following binaries:
>>>>   * ${1}.btf with .BTF section data
>>>>   * ${1}.distilled_base.btf with .BTF.base section data (for
>>>>     out-of-tree modules)
>>>>   * ${1}.btf_ids with .BTF_ids section data, if it exists in ${1}
>>>
>>> Nit: use ${1}.BTF / ${1}.BTF.base / ${1}.BTF_ids, so that each file is
>>>      named by it's corresponding section?
>>
>> Sure, makes sense.
>>
>>>
>>>>
>>>> The execution of resolve_btfids and consumption of its output is
>>>> orchestrated by scripts/gen-btf.sh introduced in this patch.
>>>>
>>>> The rationale for this approach is that updating ELF in-place with
>>>> libelf API is complicated and bug-prone, especially in the context of
>>>> the kernel build. On the other hand applying objcopy to manipulate ELF
>>>> sections is simpler and more reliable.
>>>
>>> Nit: more context needed, as is the statement raises questions but not
>>>      answers them.
>>
>> Would you like to see more details about why using libelf is complicated?
>> I don't follow what's unclear here, sorry...
> 
> The claim here is: "libelf API is complicated and bug-prone ... in
> context of the kernel build". This is a very vague wording.
> The decision to rely on objcopy/linker comes from a specific needs
> outlined by Andrii in an off-list discussion. It will be good to have
> this context captured in the commit message, instead of bluntly
> stating that libelf is bug-prone.

Ok, it seems you're conflating two separate issues.

There is a requirement to *link* .BTF section into vmlinux, because it
must have a SHF_ALLOC flag, which makes objcopying the section data
insufficient: linker has to do some magic under the hood.

The patch doesn't change this behavior, and this was (and is) covered
in the script comments.

A separate issue is what resolve_btfids does: updates ELF in-place
(before the patch) or outputs detached section data (after patch).

The paragraph in the commit message attempted to explain the decision
to output raw section data. And apparently I did a bad job of
that. I'll rewrite this part it in the next revision.

And I feel I should clarify that I didn't claim that libelf is buggy.
I meant that using it is complicated, which makes resolve_btfids buggy.

> 
>>>> [...]
>>>>  # Create ${2}.o file with all symbols from the ${1} object file
>>>>  kallsyms()
>>>>  {
>>>> @@ -204,6 +176,7 @@ if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX; then
>>>>  fi
>>>>  
>>>>  btf_vmlinux_bin_o=
>>>> +btfids_vmlinux=
>>>>  kallsymso=
>>>>  strip_debug=
>>>>  generate_map=
>>>> @@ -224,11 +197,13 @@ if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
>>>>  fi
>>>>  
>>>>  if is_enabled CONFIG_DEBUG_INFO_BTF; then
>>>> -	if ! gen_btf .tmp_vmlinux1; then
>>>> +	if ! ${srctree}/scripts/gen-btf.sh .tmp_vmlinux1; then
>>>
>>> Nit: maybe pass output file names as parameters for get-btf.sh?
>>
>> I don't see a point in that. The script and callsite will become
>> more complicated, but what is the benefit?
> 
> In order to avoid implicit naming conventions.  Hence, the reader of
> the script code has clear understanding about in and out parameters.

I think implicit naming convention makes sense for this script.
The script's top comment describes what it does in detail, including
the output naming.

> 
>>> [...]
>>>>  
>>>> +static inline bool is_envvar_set(const char *var_name)
>>>> +{
>>>> +	const char *value = getenv(var_name);
>>>> +
>>>> +	return value && value[0] != '\0';
>>>> +}
>>>> +
>>>>  static int load_btf(struct object *obj)
>>>>  {
>>>>  	struct btf *base_btf = NULL, *btf = NULL;
>>>> @@ -571,6 +554,20 @@ static int load_btf(struct object *obj)
>>>>  	obj->base_btf = base_btf;
>>>>  	obj->btf = btf;
>>>>  
>>>> +	if (obj->base_btf && is_envvar_set("KBUILD_EXTMOD")) {
>>>
>>> This is a bit ugly, maybe use a dedicated parameter instead of
>>> checking environment variable?
>>
>> Disagree. I intentionally tried to avoid adding options to
>> resolve_btfids, because it's not intendend for general CLI usage (as
>> opposed to pahole, for example). IMO the interface should be as simple
>> as possible.
>>
>> If we add an option, we still have to check for the env variable
>> somewhere, and then pass the argument through. Why? Just checking an
>> env var when it matters is simpler.
>>
>> I don't think we want or expect resolve_btfids to run outside of the
>> kernel or selftests build.
> 
> This comes to personal opinion, of-course.
> So, in my personal opinion, obfuscating a command line tool interface
> with it being parameterized by both environment variables and command
> line parameters is rarely justified.  In this particular case it will
> only make life a tad harder for someone debugging resolve_btfids by
> copy-pasting command from make output.
> 
> Hence, I find this piece of code ugly.
> 
> [...]


