Return-Path: <bpf+bounces-79361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A34D38CF3
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 07:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBFB9302D89A
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 06:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239632E6AC;
	Sat, 17 Jan 2026 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ahAmEyaJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3532D45B
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768631828; cv=none; b=iaIsXjFMhyi33nZVIUV1/gxT4EkhN3/PjiDLcuWuvjvtDtmw1ngDyu5KJb4MJTFVXqSw3AmTFvHl/6bAawOc1U9kNfH0NexapTP43MgOTPCOfVdTEo5rh2ZDs9EGCjcBdQnnr5cPz/puww+viGeRLqc1cHZPaOtjVVc7dmAqsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768631828; c=relaxed/simple;
	bh=iqWB92MSc5umvicJ2v8WHKy1Jpu4uhUM/7FH0tZx32Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLycxkth56nHGttkYgod/soh8S9ySo4F+x14cbk6sLeC/BPqK7ZxSBvULuBuPbmSdD1SGLtgFTTonq9UMiIcA3IgdvJK7wKw4CN/KNkeA9RzL8Y/TnTQ5doEdUsKEvpdezeA5Lecmanw8X8eWcvK5z0OnK0UHloxh+VDt+ypE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ahAmEyaJ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aff3f58f-aa81-44a3-ae5f-078befeceb39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768631812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNFWgFXwIkUuZEfcmkFcjXMNpWUdKsl5LRIGc+0kRuA=;
	b=ahAmEyaJNUZIbHTIMMPDmI4jfzO2b4APDjDycjCvPP8TEVfQ9fa86nXk0MGeX3DrcNB6Gu
	JUGIykzBLs+xxr6G0BBhXmeBj+R1y5lmSwYs2BHEXX3e/ANU+PVNfnJWMiVwdK8tYn23+z
	0Rl0MEd7bOYsbtS9A0auRG8K3Xkt2K0=
Date: Fri, 16 Jan 2026 22:36:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 05/13] resolve_btfids: Support for
 KF_IMPLICIT_ARGS
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 Tejun Heo <tj@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
 <20260116201700.864797-6-ihor.solodrai@linux.dev>
 <CAEf4BzbG=GMh0-1tT_2gdMtc-ZuV3X7hgoJZpt1RLCYgPMM3oQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzbG=GMh0-1tT_2gdMtc-ZuV3X7hgoJZpt1RLCYgPMM3oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/16/26 4:06 PM, Andrii Nakryiko wrote:
> On Fri, Jan 16, 2026 at 12:17 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Implement BTF modifications in resolve_btfids to support BPF kernel
>> functions with implicit arguments.
>>
>> For a kfunc marked with KF_IMPLICIT_ARGS flag, a new function
>> prototype is added to BTF that does not have implicit arguments. The
>> kfunc's prototype is then updated to a new one in BTF. This prototype
>> is the intended interface for the BPF programs.
>>
>> A <func_name>_impl function is added to BTF to make the original kfunc
>> prototype searchable for the BPF verifier. If a <func_name>_impl
>> function already exists in BTF, its interpreted as a legacy case, and
>> this step is skipped.
>>
>> Whether an argument is implicit is determined by its type:
>> currently only `struct bpf_prog_aux *` is supported.
>>
>> As a result, the BTF associated with kfunc is changed from
>>
>>     __bpf_kfunc bpf_foo(int arg1, struct bpf_prog_aux *aux);
>>
>> into
>>
>>     bpf_foo_impl(int arg1, struct bpf_prog_aux *aux);
>>     __bpf_kfunc bpf_foo(int arg1);
>>
>> For more context see previous discussions and patches [1][2].
>>
>> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
>> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/bpf/resolve_btfids/main.c | 383 ++++++++++++++++++++++++++++++++
>>  1 file changed, 383 insertions(+)
>>
> 
> [...]
> 
>> +static int collect_decl_tags(struct btf2btf_context *ctx)
>> +{
>> +       const u32 type_cnt = btf__type_cnt(ctx->btf);
>> +       struct btf *btf = ctx->btf;
>> +       const struct btf_type *t;
>> +       u32 *tags, *tmp;
>> +       u32 nr_tags = 0;
>> +
>> +       tags = malloc(type_cnt * sizeof(u32));
> 
> waste of memory, really, see below
> 
>> +       if (!tags)
>> +               return -ENOMEM;
>> +
>> +       for (u32 id = 1; id < type_cnt; id++) {
>> +               t = btf__type_by_id(btf, id);
>> +               if (!btf_is_decl_tag(t))
>> +                       continue;
>> +               tags[nr_tags++] = id;
>> +       }
>> +
>> +       if (nr_tags == 0) {
>> +               ctx->decl_tags = NULL;
>> +               free(tags);
>> +               return 0;
>> +       }
>> +
>> +       tmp = realloc(tags, nr_tags * sizeof(u32));
>> +       if (!tmp) {
>> +               free(tags);
>> +               return -ENOMEM;
>> +       }
> 
> This is an interesting realloc() usage pattern, it's quite
> unconventional to preallocate too much memory, and then shrink (in C
> world)
> 
> check libbpf's libbpf_add_mem(), that's a generic "primitive" inside
> the libbpf. Do not reuse it as is, but it should give you an idea of a
> common pattern: you start with NULL (empty data), when you need to add
> a new element, you calculate a new array size which normally would be
> some minimal value (to avoid going through 1 -> 2 -> 4 -> 8, many
> small and wasteful steps; normally we just jump straight to 16 or so)
> or some factor of previous size (doesn't have to be 2x,
> libbpf_add_mem() expands by 25%, for instance).
> 
> This is a super common approach in C. Please utilize it here as well.

Hi Andrii, thanks for taking a quick look.

I am aware of the typical size doubling (or whatever the multiplier
is) pattern for growing arrays. Amortized cost and all that.

I don't know if this pre-alloc + shrink is common, but I did use it in
pahole before [1], for example.

The chain of thought that makes me like it is:
  * if we knew the array size beforehand, we'd simply pre-allocate it
  * here we don't, but we do know an upper limit (and it's not crazy)
  * if we pre-allocate to upper limit, we can use the array without
    worrying about the bounds checks and growing on every use
  * if we care (we might not), we can shrink to the actual size

The dynamic array approach is certainly more generic, and helpers can
be written to make it easy. But in cases like this - collect something
once and then use - over-pre-allocating makes more sense to me.

Re waste we are talking <1Mb (~100k types * 4), so it's whatever.

In any case it's not super important, so I don't mind changing this if
you insist. Being conventional has it's benefits too.

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encoder.c?h=v1.31#n2182

> 
>> +
>> +       ctx->decl_tags = tmp;
>> +       ctx->nr_decl_tags = nr_tags;
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * To find the kfunc flags having its struct btf_id (with ELF addresses)
>> + * we need to find the address that is in range of a set8.
>> + * If a set8 is found, then the flags are located at addr + 4 bytes.
>> + * Return 0 (no flags!) if not found.
>> + */
>> +static u32 find_kfunc_flags(struct object *obj, struct btf_id *kfunc_id)
>> +{
>> +       const u32 *elf_data_ptr = obj->efile.idlist->d_buf;
>> +       u64 set_lower_addr, set_upper_addr, addr;
>> +       struct btf_id *set_id;
>> +       struct rb_node *next;
>> +       u32 flags;
>> +       u64 idx;
>> +
>> +       next = rb_first(&obj->sets);
>> +       while (next) {
> 
> for(next = rb_first(...); next; next = rb_next(next)) seems like a
> good fit here, no?

Looks like it. We could do 'continue' then.

> 
>> +               set_id = rb_entry(next, struct btf_id, rb_node);
>> +               if (set_id->kind != BTF_ID_KIND_SET8 || set_id->addr_cnt != 1)
>> +                       goto skip;
>> +
>> +               set_lower_addr = set_id->addr[0];
>> +               set_upper_addr = set_lower_addr + set_id->cnt * sizeof(u64);
>> +
>> +               for (u32 i = 0; i < kfunc_id->addr_cnt; i++) {
>> +                       addr = kfunc_id->addr[i];
>> +                       /*
>> +                        * Lower bound is exclusive to skip the 8-byte header of the set.
>> +                        * Upper bound is inclusive to capture the last entry at offset 8*cnt.
>> +                        */
>> +                       if (set_lower_addr < addr && addr <= set_upper_addr) {
>> +                               pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
>> +                                        kfunc_id->name, set_id->name);
>> +                               goto found;
> 
> why goto, just do what needs to be done and return?

Indeed.

> 
>> +                       }
>> +               }
>> +skip:
>> +               next = rb_next(next);
>> +       }
>> +
>> +       return 0;
>> +
>> +found:
>> +       idx = addr - obj->efile.idlist_addr;
>> +       idx = idx / sizeof(u32) + 1;
>> +       flags = elf_data_ptr[idx];
>> +
>> +       return flags;
>> +}
>> +
>> +static s64 collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
>> +{
>> +       struct kfunc *kfunc, *kfuncs, *tmp;
>> +       const char *tag_name, *func_name;
>> +       struct btf *btf = ctx->btf;
>> +       const struct btf_type *t;
>> +       u32 flags, func_id;
>> +       struct btf_id *id;
>> +       s64 nr_kfuncs = 0;
>> +
>> +       if (ctx->nr_decl_tags == 0)
>> +               return 0;
>> +
>> +       kfuncs = malloc(ctx->nr_decl_tags * sizeof(*kfuncs));
> 
> ditto about realloc() usage pattern
> 
>> +       if (!kfuncs)
>> +               return -ENOMEM;
>> +
> 
> [...]
> 
>> +/*
>> + * For a kfunc with KF_IMPLICIT_ARGS we do the following:
>> + *   1. Add a new function with _impl suffix in the name, with the prototype
>> + *      of the original kfunc.
>> + *   2. Add all decl tags except "bpf_kfunc" for the _impl func.
>> + *   3. Add a new function prototype with modified list of arguments:
>> + *      omitting implicit args.
>> + *   4. Change the prototype of the original kfunc to the new one.
>> + *
>> + * This way we transform the BTF associated with the kfunc from
>> + *     __bpf_kfunc bpf_foo(int arg1, void *implicit_arg);
>> + * into
>> + *     bpf_foo_impl(int arg1, void *implicit_arg);
>> + *     __bpf_kfunc bpf_foo(int arg1);
>> + *
>> + * If a kfunc with KF_IMPLICIT_ARGS already has an _impl counterpart
>> + * in BTF, then it's a legacy case: an _impl function is declared in the
>> + * source code. In this case, we can skip adding an _impl function, but we
>> + * still have to add a func prototype that omits implicit args.
>> + */
>> +static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct kfunc *kfunc)
>> +{
> 
> this logic looks good
> 
>> +       s32 idx, new_proto_id, new_func_id, proto_id;
>> +       const char *param_name, *tag_name;
>> +       const struct btf_param *params;
>> +       enum btf_func_linkage linkage;
>> +       char tmp_name[KSYM_NAME_LEN];
>> +       struct btf *btf = ctx->btf;
>> +       int err, len, nr_params;
>> +       struct btf_type *t;
>> +
> 
> [...]


