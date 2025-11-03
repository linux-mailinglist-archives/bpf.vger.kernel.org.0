Return-Path: <bpf+bounces-73291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8667C29B4E
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 01:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642F73AC401
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 00:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC6E8405C;
	Mon,  3 Nov 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NHtIGHcy"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1F8BEC
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762129951; cv=none; b=Qsxs5s6iBj14EgulcuEHcOHvVmzICbwjxWVIIAYAgocefvRK84GEQkhhCaAvwCThIdk0Xk+DlvzGFgD6UusVpwKkQ8c2aqcBaobrVzp3qzTFLyu3oy5Ko6wmiFOkO3Qa6K9dasnPyh3z+f5ks7EOT1UW/iqG+lCy2k6TVCEPWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762129951; c=relaxed/simple;
	bh=vUFQ9YSurF580nTO7xn4WPAAuuL167yQIgv66l0dpJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvFhcilu5QObYIZ+De0VDslAImBYzA4sgeBIN4tI0XbC4LEQppciMWi8i+FjMtyVEI9ZVBIQtsCyq/vtuQ466CjG6baSmvycUV2bKNgWgCfoW0VRY2a7IkiI8/RLr2l70SFuvXU6kWx7vOFpFgGY8GJm0dGV2VVCgICzDbaCEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NHtIGHcy; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a9ba760-c9e4-4851-b971-ac929811c52a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762129946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrcQR8eSp1vLEgBENpghJfwYN5J5DBYaPB+ZbYn/Bng=;
	b=NHtIGHcyc/dm5dBEE526cmjJ+XhTYdNH/dJe4tiYEVIl6ct3Jrd7SQ8izxVqBBHOkn3nUK
	8kYC6xIdlDNqLG4wkt+G24tOEVUEsN58Xow26ChUu3ClGHB5DTgreTKKH1GUqxqcs3XJqx
	ZqlAjGxiSLsPkBk2N9/lXk8UdOANLzE=
Date: Sun, 2 Nov 2025 16:32:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
 qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com
References: <20251102205722.3266908-9-a.s.protopopov@gmail.com>
 <311fb2ea7bc0de371449e98951bf8366aa8b30be8c50c8c549e2501fc9095878@mail.kernel.org>
 <aQfPbc97GSajDCcc@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aQfPbc97GSajDCcc@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/2/25 1:38 PM, Anton Protopopov wrote:
> On 25/11/02 09:13PM, bot+bpf-ci@kernel.org wrote:
>>
>> ```
>> commit b44690c09995d34f7665c7d687b359d41a6ab79f
>> Author: Anton Protopopov <a.s.protopopov@gmail.com>
>>
>> libbpf: support llvm-generated indirect jumps
>>
>> This commit adds support for LLVM-generated indirect jumps in BPF v4
>> instruction set. It handles jump table metadata from the .jumptables
>> ELF section and creates BPF_MAP_TYPE_INSN_ARRAY maps for them.
>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index fbe74686c..ed14090a9 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>
>> [ ... ]
>>
>>> @@ -6144,6 +6192,157 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
>>>  	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
>>>  }
>>>
>>> +static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym_off)
>>> +{
>>
>> [ ... ]
>>
>>> +static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struct reloc_desc *relo)
>>> +{
>>> +	const __u32 jt_entry_size = 8;
>>> +	int sym_off = relo->sym_off;
>>> +	int jt_size = relo->sym_size;
>>> +	__u32 max_entries = jt_size / jt_entry_size;
>>> +	__u32 value_size = sizeof(struct bpf_insn_array_value);
>>> +	struct bpf_insn_array_value val = {};
>>> +	int subprog_idx;
>>> +	int map_fd, err;
>>> +	__u64 insn_off;
>>> +	__u64 *jt;
>>> +	__u32 i;
>>> +
>>> +	map_fd = find_jt_map(obj, prog, sym_off);
>>> +	if (map_fd >= 0)
>>> +		return map_fd;
>>> +
>>> +	if (sym_off % jt_entry_size) {
>>> +		pr_warn("map '.jumptables': jumptable start %d should be multiple of %u\n",
>>> +			sym_off, jt_entry_size);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (jt_size % jt_entry_size) {
>>> +		pr_warn("map '.jumptables': jumptable size %d should be multiple of %u\n",
>>> +			jt_size, jt_entry_size);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
>>> +				4, value_size, max_entries, NULL);
>>> +	if (map_fd < 0)
>>> +		return map_fd;
>>> +
>>> +	if (!obj->jumptables_data) {
>>> +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
>>> +		err = -EINVAL;
>>> +		goto err_close;
>>> +	}
>>> +	if (sym_off + jt_size > obj->jumptables_data_sz) {
>>> +		pr_warn("map '.jumptables': jumptables_data size is %zd, trying to access %d\n",
>>> +			obj->jumptables_data_sz, sym_off + jt_size);
>>> +		err = -EINVAL;
>>> +		goto err_close;
>>> +	}
>>> +
>>> +	subprog_idx = -1; /* main program */
>>> +	if (relo->insn_idx < 0 || relo->insn_idx >= prog->insns_cnt) {
>>> +		pr_warn("map '.jumptables': invalid instruction index %d\n", relo->insn_idx);
>>> +		err = -EINVAL;
>>> +		goto err_close;
>>> +	}
>>> +	if (prog->subprogs)
>>> +		subprog_idx = find_subprog_idx(prog, relo->insn_idx);
>>> +
>>> +	jt = (__u64 *)(obj->jumptables_data + sym_off);
>>> +	for (i = 0; i < max_entries; i++) {
>>> +		/*
>>> +		 * The offset should be made to be relative to the beginning of
>>> +		 * the main function, not the subfunction.
>>> +		 */
>>> +		insn_off = jt[i]/sizeof(struct bpf_insn);
>>> +		if (subprog_idx >= 0) {
>>> +			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
>>> +			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
>>> +		} else {
>>> +			insn_off -= prog->sec_insn_off;
>>> +		}
>>> +
>>> +		/*
>>> +		 * LLVM-generated jump tables contain u64 records, however
>>> +		 * should contain values that fit in u32.
>>> +		 */
>>> +		if (insn_off > UINT32_MAX) {
>>> +			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offset %d\n",
>>> +				(long long)jt[i], sym_off + i);
>>                                                       ^^^^^^^^^^^^
>>
>> Does this error message print the correct offset? Since jt is a pointer
>> to __u64, the array access jt[i] is at byte offset "sym_off + i * 8",
>> not "sym_off + i". All the other error messages in create_jt_map report
>> byte offsets and sizes (sym_off, jt_size, sym_off + jt_size), so this
>> one should probably be "sym_off + i * jt_entry_size" for consistency.
> 
> Is there a way to run this AI as part of any PR to
> kernel-patches/bpf, not only those coming from the mailing list?
> Maybe for a selected commit?

Hi Anton,

If you have access to an "agentic" AI coding tool that runs locally,
such as Claude Code, you can use our prompts repository [1] with a
trigger prompt like this:

  Current directory is the root of a Linux Kernel git repository.
  Using the prompt `review/review-core.md` and the prompt directory
  `review` do a code review of the top commit in the Linux repository.

The prompts expect the "agent" to be able to read and write files, and
execute basic commands such as grep, find, awk and similar.

In principle it's possible to enable the review CI job for arbitrary
pull requests, but the tokens are not free so we haven't considered
that yet.

[1] https://github.com/masoncl/review-prompts

> 
> Also, how deterministinc it is?  Will it generate different comments
> for a given patch for different runs?

The short answer is no, the answers are not deterministic.

However for typical/obvious bugs you might often get a comment about
the same issue worded differently.

> 
>>> +			err = -EINVAL;
>>> +			goto err_close;
>>> +		}
>>> +
>>> +		val.orig_off = insn_off;
>>> +		err = bpf_map_update_elem(map_fd, &i, &val, 0);
>>> +		if (err)
>>> +			goto err_close;
>>> +	}
>>> +
>>> +	err = bpf_map_freeze(map_fd);
>>> +	if (err)
>>> +		goto err_close;
>>> +
>>> +	err = add_jt_map(obj, prog, sym_off, map_fd);
>>> +	if (err)
>>> +		goto err_close;
>>> +
>>> +	return map_fd;
>>> +
>>> +err_close:
>>> +	close(map_fd);
>>> +	return err;
>>> +}
>>
>> [ ... ]
>>
>>
>> ```
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> In-Reply-To-Subject: `libbpf: support llvm-generated indirect jumps`
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19018051915
> 


