Return-Path: <bpf+bounces-78436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4C3D0CAFA
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 02:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 452A9303C823
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 01:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBBA1DF248;
	Sat, 10 Jan 2026 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JXaW1P5N"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0741925BC
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007723; cv=none; b=a15FlRGD1zo01c0eoR7007BQdNpjDKWFS5Pf2yWrupOx/MxS/Xold9eZNuN98CXhbkyhPg8TvshDLoJ1fE0AXoOaYMplCaxFpcBG2qoimzMP4IQk78PEZWikBNwSoNcQEV/lGmxcenjYEMc8YvLVd9G/Gf4DMFzfR/REzfcnhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007723; c=relaxed/simple;
	bh=LKcHJ98y04o62fTJkAbYH1SsK3Ta4Ieq+XFm9usbtNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUlNToGWwM3LB3HjnqQJBVcWlHCWjo47yGJTux5LCq+B/FhzNbM526XQAsVhII8yDRgzr1SQskqcnkvvS5OtwIDGgATHhpEWXkNWcuURRVWbTYGAhK30feODXHG31Q5ebQtXhYj4zo8V4ZHkNUwzaQSHHYAwnILuf3QnBgnrKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JXaW1P5N; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ea17ba8-3248-4a01-8fed-183ce66aa39c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768007708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahAH3rzPdL93igYQW+98YrKZjud91Tlnt5ogrhyCeBY=;
	b=JXaW1P5NyD+BjdacN8mfxxBxgPknRVW2761h4FMTuDftKZykTsdgL0P5mMtFDuDEEmvlpf
	B+wQ7jh3oxmP9w6R3sqVwKfA4+qAUd5OFWe93XYnMqMpKvdRxNT1ExGjIIs2o77Ow8dIqe
	6tCY6KuFPApxFu6fkDf7XtNSOvnKrCA=
Date: Fri, 9 Jan 2026 17:15:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 04/10] resolve_btfids: Support for
 KF_IMPLICIT_ARGS
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 Tejun Heo <tj@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-5-ihor.solodrai@linux.dev>
 <CAEf4BzYcZ5pLCvfn8uWiKCjpBXBw9dxR_WZnKxVz1Bhf96xOGg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYcZ5pLCvfn8uWiKCjpBXBw9dxR_WZnKxVz1Bhf96xOGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/9/26 3:25 PM, Andrii Nakryiko wrote:
> On Fri, Jan 9, 2026 at 10:49 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
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
>>  tools/bpf/resolve_btfids/main.c | 282 ++++++++++++++++++++++++++++++++
>>  1 file changed, 282 insertions(+)
>>
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index df39982f51df..b361e726fa36 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -152,6 +152,18 @@ struct object {
>>         int nr_typedefs;
>>  };
>>
>> +#define KF_IMPLICIT_ARGS (1 << 16)
>> +#define KF_IMPL_SUFFIX "_impl"
>> +#define MAX_BPF_FUNC_REG_ARGS 5
>> +#define MAX_KFUNCS 256
>> +#define MAX_DECL_TAGS (MAX_KFUNCS * 4)
> 
> can't we get that from include/linux/bpf.h? seems like
> resolve_btfids's main.c include internal headers just fine, so why
> duplicate definitions?

Hi Andrii, thank you for a quick review.

Including internal include/linux/btf.h directly doesn't work, which is
probably expected.

resolve_btfids is currently built with:

HOSTCFLAGS_resolve_btfids += -g \
          -I$(srctree)/tools/include \
          -I$(srctree)/tools/include/uapi \
          -I$(LIBBPF_INCLUDE) \
          -I$(SUBCMD_INCLUDE) \
          $(LIBELF_FLAGS) \
          -Wall -Werror

If I add -I$(srctree)/include option and then

    #include <linux/btf.h>

A bunch of build errors happen.

AFAIU we'd have to create a stripped copy of relevant headers in
tools/include first.  Is that what you're suggesting?

> 
>> +
>> +struct btf2btf_context {
>> +       struct btf *btf;
>> +       u32 nr_decl_tags;
>> +       s32 decl_tags[MAX_DECL_TAGS];
>> +};
>> +
>>  static int verbose;
>>  static int warnings;
>>
>> @@ -972,6 +984,273 @@ static int patch_btfids(const char *btfids_path, const char *elf_path)
>>         return err;
>>  }
>>
>> +static s64 collect_kfunc_ids_by_flags(struct object *obj,
>> +                                     u32 flags,
>> +                                     s32 kfunc_ids[],
>> +                                     const u32 kfunc_ids_sz)
>> +{
>> +       Elf_Data *data = obj->efile.idlist;
>> +       struct rb_node *next;
>> +       s64 nr_kfuncs = 0;
>> +       int i;
>> +
>> +       next = rb_first(&obj->sets);
>> +       while (next) {
>> +               struct btf_id_set8 *set8 = NULL;
>> +               unsigned long addr, off;
>> +               struct btf_id *id;
>> +
>> +               id = rb_entry(next, struct btf_id, rb_node);
>> +
>> +               if (id->kind != BTF_ID_KIND_SET8)
>> +                       goto skip;
>> +
>> +               addr = id->addr[0];
>> +               off = addr - obj->efile.idlist_addr;
>> +               set8 = data->d_buf + off;
>> +
>> +               for (i = 0; i < set8->cnt; i++) {
>> +                       if (set8->pairs[i].flags & flags) {
> 
> invert condition and continue, reduce nesting?
> 
>> +                               if (nr_kfuncs >= kfunc_ids_sz) {
> 
> it's silly to set static limits like this: we are not in NMI, you have
> memory allocator, use it

I kinda like that btf2btf_context is stack allocated, but I see your
point. It's not necessary to set hard limits in resolve_btfids.

> 
>> +                                       pr_err("ERROR: resolve_btfids: too many kfuncs with flags %u - limit %d\n",
>> +                                              flags, kfunc_ids_sz);
>> +                                       return -E2BIG;
>> +                               }
>> +                               kfunc_ids[nr_kfuncs++] = set8->pairs[i].id;
>> +                       }
>> +               }
>> +skip:
>> +               next = rb_next(next);
>> +       }
>> +
>> +       return nr_kfuncs;
>> +}
>> +
>> +static const struct btf_type *btf__unqualified_type_by_id(const struct btf *btf, s32 type_id)
>> +{
>> +       const struct btf_type *t = btf__type_by_id(btf, type_id);
>> +
>> +       while (btf_is_mod(t))
>> +               t = btf__type_by_id(btf, t->type);
>> +
>> +       return t;
>> +}
>> +
>> +/* Implicit BPF kfunc arguments can only be of particular types */
>> +static bool btf__is_kf_implicit_arg(const struct btf *btf, const struct btf_param *p)
> 
> nit: not sure why you use double underscore convention, this is not
> really an "API" of btf, it's just a helper... I'd just call it
> "is_kf_implicit_arg", btf is just and input argument
> 
>> +{
>> +       static const char *const kf_implicit_arg_types[] = {
>> +               "bpf_prog_aux",
>> +       };
>> +       const struct btf_type *t;
>> +       const char *name;
>> +
> 
> [...]
> 
>> +       /* Copy all decl tags except "bpf_kfunc" from the original kfunc to the new one */
>> +       for (int i = 0; i < ctx->nr_decl_tags; i++) {
>> +               t = (struct btf_type *)btf__type_by_id(btf, ctx->decl_tags[i]);
>> +               if (t->type != kfunc_id)
>> +                       continue;
>> +
>> +               tag_name = btf__name_by_offset(btf, t->name_off);
>> +               if (strcmp(tag_name, "bpf_kfunc") == 0)
>> +                       continue;
>> +
>> +               err = btf__add_decl_tag(btf, tag_name, new_func_id, -1);
> 
> decl_tag can apply to arguments as well (that -1 will be actually >=
> 0), we should copy those as well, no?

I think you're right. Technically decl_tags can point to parameters as
well.  Is this actually used in kernel BTF?

For the type tags we don't have to do anything though, because the
param type should point to the top type tag, right?

> 
>> +               if (err < 0) {
>> +                       pr_err("ERROR: resolve_btfids: failed to add decl tag %s for %s\n",
>> +                              tag_name, tmp_name);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +add_new_proto:
>> +       /*
>> +        * Drop the _impl suffix and point kfunc_name to the local buffer for later use.
>> +        * When BTF is modified the original pointer is invalidated.
>> +        */
>> +       tmp_name[name_len] = '\0';
>> +       kfunc_name = tmp_name;
>> +
>> +       /* Load non-implicit args from the original prototype */
>> +       t = (struct btf_type *)btf__type_by_id(btf, proto_id);
>> +       params = btf_params(t);
>> +       nr_params = 0;
>> +       for (int i = 0; i < btf_vlen(t); i++) {
>> +               if (btf__is_kf_implicit_arg(btf, &params[i]))
>> +                       break;
>> +               new_params[nr_params++] = params[i];
>> +       }
> 
> this is unnecessary, just when you working with original prototype and
> its arguments, just re-fetch it back from IDs, all those pointers will
> be valid until next btf__add_xxx() invocation, no need for this
> awkward local copies
> 
>> +
>> +       new_proto_id = btf__add_func_proto(btf, t->type);
>> +       if (new_proto_id < 0) {
>> +               pr_err("ERROR: resolve_btfids: failed to add func proto for %s\n", kfunc_name);
>> +               return new_proto_id;
>> +       }
>> +
>> +       /* Add non-implicit args to the new prototype */
>> +       for (int i = 0; i < nr_params; i++) {
>> +               param_name = btf__name_by_offset(btf, new_params[i].name_off);
>> +               err = btf__add_func_param(btf, param_name, new_params[i].type);
>> +               if (err < 0) {
>> +                       pr_err("ERROR: resolve_btfids: failed to add param %s for %s\n",
>> +                              param_name, kfunc_name);
>> +                       return err;
>> +               }
>> +       }
>> +
>> +       /* Finally change the prototype of the original kfunc to the new one */
>> +       t = (struct btf_type *)btf__type_by_id(btf, kfunc_id);
>> +       t->type = new_proto_id;
>> +
>> +       pr_debug("resolve_btfids: updated BTF for kfunc with implicit args %s\n", kfunc_name);
>> +
>> +       return 0;
>> +}
>> +
>> +static s64 btf__collect_decl_tags(const struct btf *btf, s32 *decl_tags, u32 decl_tags_sz)
>> +{
>> +       const u32 type_cnt = btf__type_cnt(btf);
>> +       const struct btf_type *t;
>> +       s64 nr_decl_tags = 0;
>> +
>> +       for (u32 id = 1; id < type_cnt; id++) {
>> +               t = btf__type_by_id(btf, id);
>> +               if (!btf_is_decl_tag(t))
>> +                       continue;
>> +               if (nr_decl_tags >= decl_tags_sz) {
>> +                       pr_err("ERROR: resolve_btfids: too many decl tags in BTF - limit %s\n",
> 
> realloc is your friend, no fixed-sized arrays
> 
>> +                               decl_tags_sz);
>> +                       return -E2BIG;
>> +               }
>> +               decl_tags[nr_decl_tags++] = id;
>> +       }
>> +
>> +       return nr_decl_tags;
>> +}
>> +
> 
> [...]


