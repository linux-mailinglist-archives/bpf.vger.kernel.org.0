Return-Path: <bpf+bounces-73416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05635C2F5F5
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 06:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9FE188F766
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 05:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765F2D060E;
	Tue,  4 Nov 2025 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GzQhhA4d"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C129B8E6
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234009; cv=none; b=Dos7J7g5YmyIAKyALLi1hy1IFs9DJMRqbftTF0FqGDmnd4R9SQ3yu81/OykVyKd1z7ZYk7GxJes+I4N3ntNqmI8MfmfH6BqE0LMtOVHKCjbRkR9bJ9hQao8MZftjBcJtq3lM128+C6UgzN8jTUaYCax0cIGEWjxGBgzeIhIRpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234009; c=relaxed/simple;
	bh=kJKDFsS8jYyjCnw0yMxwBmLdVwqt6ISsiMYvSit6vNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gj6Z3867wx8KUVr3Z8N5B1EXbrwj8KQTHPws2cwO+RRIuTUjxNbEe39b60Pci8k6dixDqjdKuiOw5MU1u9UjzWYrx3pZoF6C3sRvnEnH2RAAfh/pqNn2V628p578cDswiUBhoAHJRve30W/POx1CWHCA73U87G9NIB18ODS0rjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GzQhhA4d; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45c6e54a-d715-424e-b9c8-ad53956686da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762234002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkRJRWX7w2xBR5JvHhq+WWeNoirobVVGcwnnb3zKOHo=;
	b=GzQhhA4dC3uSOSq+vYBmIN75RwBEnF+W992tbB/bnFF9OyNzs8NpwmPvKaOzXmvrCaLG3B
	/Jvn9MilFGfhOquN3ha+kMeukaBcogjN+Vny+NvdfQmscfwdoHBs3X0EeF1ZJ6LbJ6V16D
	GZQHWQaqAW2BhqN/CoQOpJYSms1G8hA=
Date: Mon, 3 Nov 2025 21:26:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
 <20251102205722.3266908-9-a.s.protopopov@gmail.com>
 <4c9b089ea2c24b12d0d83f507c986d544f2c4e75.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <4c9b089ea2c24b12d0d83f507c986d544f2c4e75.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/3/25 5:15 PM, Eduard Zingerman wrote:
> On Sun, 2025-11-02 at 20:57 +0000, Anton Protopopov wrote:
>
> [...]
>
>> +static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struct reloc_desc *relo)
>> +{
>> +	const __u32 jt_entry_size = 8;
>> +	int sym_off = relo->sym_off;
>> +	int jt_size = relo->sym_size;
>> +	__u32 max_entries = jt_size / jt_entry_size;
>> +	__u32 value_size = sizeof(struct bpf_insn_array_value);
>> +	struct bpf_insn_array_value val = {};
>> +	int subprog_idx;
>> +	int map_fd, err;
>> +	__u64 insn_off;
>> +	__u64 *jt;
>> +	__u32 i;
>> +
>> +	map_fd = find_jt_map(obj, prog, sym_off);
>> +	if (map_fd >= 0)
>> +		return map_fd;
>> +
>> +	if (sym_off % jt_entry_size) {
>> +		pr_warn("map '.jumptables': jumptable start %d should be multiple of %u\n",
>> +			sym_off, jt_entry_size);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (jt_size % jt_entry_size) {
>> +		pr_warn("map '.jumptables': jumptable size %d should be multiple of %u\n",
>> +			jt_size, jt_entry_size);
>> +		return -EINVAL;
>> +	}
>> +
>> +	map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
>> +				4, value_size, max_entries, NULL);
>> +	if (map_fd < 0)
>> +		return map_fd;
>> +
>> +	if (!obj->jumptables_data) {
>> +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
>> +		err = -EINVAL;
>> +		goto err_close;
>> +	}
>> +	if (sym_off + jt_size > obj->jumptables_data_sz) {
>> +		pr_warn("map '.jumptables': jumptables_data size is %zd, trying to access %d\n",
>> +			obj->jumptables_data_sz, sym_off + jt_size);
>> +		err = -EINVAL;
>> +		goto err_close;
>> +	}
>> +
>> +	subprog_idx = -1; /* main program */
>> +	if (relo->insn_idx < 0 || relo->insn_idx >= prog->insns_cnt) {
>> +		pr_warn("map '.jumptables': invalid instruction index %d\n", relo->insn_idx);
>> +		err = -EINVAL;
>> +		goto err_close;
>> +	}
>> +	if (prog->subprogs)
>> +		subprog_idx = find_subprog_idx(prog, relo->insn_idx);
>> +
>> +	jt = (__u64 *)(obj->jumptables_data + sym_off);
>> +	for (i = 0; i < max_entries; i++) {
>> +		/*
>> +		 * The offset should be made to be relative to the beginning of
>> +		 * the main function, not the subfunction.
>> +		 */
>> +		insn_off = jt[i]/sizeof(struct bpf_insn);
>> +		if (subprog_idx >= 0) {
>> +			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
>> +			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
> I'd like to reiterate my point about relocation related warnings [1]:
>
>    > I'm seeing the following messages when rebuilding bpf_gotox using
>    > llvm main, where Yonghong added __BPF_FEATURE_GOTOX.
>    >
>    >     CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
>    >     GEN-SKEL [test_progs-cpuv4] bpf_gotox.skel.h
>    >   libbpf: elf: skipping relo section(13) .rel.jumptables for section(6) .jumptables
>    >   libbpf: elf: skipping relo section(13) .rel.jumptables for section(6) .jumptables
>
> In the context of Yonghong's reply [2].
>
> I inserted some debug prints and confirm that these relocations are
> generated for basic block labels, e.g.:
>
>    .S file corresponding to shortened bpf_gotox.c:
>        ...
>               gotox r1
>       .Ltmp25:
>       .Ltmp26:
>       .Ltmp27:                                # Block address taken
>       LBB0_5:                                 # %l1
>               #DEBUG_LABEL: one_jump_two_maps:l1
>               .loc    0 36 10 is_stmt 1               # progs/bpf_gotox.c:36:10
>       .Ltmp28:
>               w1 = *(u32 *)(r10 - 4)
>        ...
>               .section        .jumptables,"",@progbits
>      BPF.JT.0.0:
>              .quad   LBB0_5
>
>    objdump --symbols, corresponding to same shortened bpf_gotox.c:
>
>      Symbol table '.symtab' contains 18 entries:
>         Num:    Value          Size Type    Bind   Vis       Ndx Name
>           ...
>           2: 0000000000000000     0 SECTION LOCAL  DEFAULT     3 syscall
>
>    objdump --relocations, corresponding to same shortened bpf_gotox.c:
>
>      Relocation section '.rel.jumptables' at offset 0xde8 contains 4 entries:
>           Offset             Info             Type               Symbol's Value  Symbol's Name
>       0000000000000000  0000000200000002 R_BPF_64_ABS64         0000000000000000 syscall
>       ...
>
> Here the first entry corresponds to LBB0_5 symbol, specifically:
>
>                           Relocation type (R_BPF_64_ABS64).
>                               vvvvvvvv
>     0000000000000000  0000000200000002 R_BPF_64_ABS64         0000000000000000 syscall
>     ^^^^^^^^^^^^^^^^  ^^^^^^^^                                ^^^^^^^^^^^^^^^^
>     Offset at which   Section                                 Given that relocation type is
>     to apply the      index                                   R_BPF_64_ABS64, this is the value
>     relocation,       for 'syscall'.                          which has to be written at offset.
>     first jumptables                                          (See [3]).
>     record.
>
> Given above, I conclude that:
>
> - [to Anton] libbpf has to apply the relocations from .rel.jumptables
>    in order to assign correct the sec_insn_off for records in the jump
>    table.  Right now we imply that each record in the table corresponds
>    to a section where jump table is referenced from, but that is not
>    true.
>
> - [to Yonghong] LLVM should generate a different relocation kind,
>    or a different "Symbol's Value", otherwise applying relocations as
>    instructed in [3] will lead to zeroes in the jump table:
>    
>    > In another case, R_BPF_64_ABS64 relocation type is used for normal
>    > 64-bit data. The actual to-be-relocated data is stored at
>    > r_offset and the read/write data bitsize is 64 (8 bytes). The
>    > relocation can be resolved with the symbol value plus implicit
>    > addend.

I think the following llvm patch
    https://github.com/llvm/llvm-project/pull/166301
should avoid jumptable relocation. The idea is originated from one of
Eduard's idea which put the label difference in the jump table entry.
Please give a try. I think it should work.

>
> [1] https://lore.kernel.org/bpf/68754a9c03b960d5057de816b217e824e51021a1.camel@gmail.com/
> [2] https://lore.kernel.org/bpf/3b07e879-9905-4161-88e0-05ed54bdb628@linux.dev/
> [3] https://docs.kernel.org/bpf/llvm_reloc.html
>
>> +		} else {
>> +			insn_off -= prog->sec_insn_off;
>> +		}
>> +
>> +		/*
>> +		 * LLVM-generated jump tables contain u64 records, however
>> +		 * should contain values that fit in u32.
>> +		 */
>> +		if (insn_off > UINT32_MAX) {
>> +			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offset %d\n",
>> +				(long long)jt[i], sym_off + i);
>> +			err = -EINVAL;
>> +			goto err_close;
>> +		}
>> +
>> +		val.orig_off = insn_off;
>> +		err = bpf_map_update_elem(map_fd, &i, &val, 0);
>> +		if (err)
>> +			goto err_close;
>> +	}
> [...]


