Return-Path: <bpf+bounces-29138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31E8C0783
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 01:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7BBB20FEB
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC23A8FF;
	Wed,  8 May 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn3tDsmL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86FE17C79
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715209658; cv=none; b=ASgpGlQUJhrD7BcbMsRqo0Tjtqq/LU26lI5FLsq3p151tjnvxkTkP//px4/dUNuU4KFXtNTzkDLjJDYwfa2gjYP2ANlIHWsGa25J+WclmUPOeH9RHBPconZRvAMLIRy1CI+MHm3xI1w/ObjrTP+i5w9WZPq3jkmeyMcDXdqJFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715209658; c=relaxed/simple;
	bh=seswmGHupHBsLOOxaMtJGclr74Q4DcL4n7RwnfPXA4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ithzpJWPZRr1r5U+qO3nlW0yvAnBCmsU1k13WQ+Ph7QfL22wURNUo/wATMQOAuaCOUXXN3LP3PTc6QtCY6o8day4FuTcJ7C1tlvS7k4OmDVgX462e+yduLaOdphXv/c9suRntjEhKXmqceq4MxhyZ+jw9hlA6nVBpWFCIf8EozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn3tDsmL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59cdd185b9so251382066b.1
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715209654; x=1715814454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+tBB5AQnsJLJE7TPcQoSI0WYy+s92qCjujbGMGLkE0=;
        b=Zn3tDsmLhjC4+xk4EugsMFiomXXQNBzjDa/FBtzH4do54PoNA0Nr8gU7yrX8D4KgxQ
         fEhhxB2QtrW6zjefIKUt3CwrNFT6ioD8CkX5Ce3+8PEo6t/dfLSGBpCF1pWVtc4shQq9
         v1O1p3xXl5R/baUo7ME3cylPi3KbqMvQ62V3KdF61J0puN2Hzf2pKC+bKMRmalUIGdR6
         DNnjXNq/p3AOdSgXMnhMyqbs1Qv+1pV7RbESP4Lx5LiB4uSP+oTPSN6M7qlOCfG+aJfM
         RNHTt9NWrBQ8sWgwuyn+Uj6NO/Ypo2tU7slL/B6dh7DyKW7elX3Kfjchp99AwcN8masA
         W/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715209654; x=1715814454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+tBB5AQnsJLJE7TPcQoSI0WYy+s92qCjujbGMGLkE0=;
        b=prmCjcUP0sHPp1c3cWX64/3pSZO7/OD4THnZ4dF3wWfTgFvMsAbTb/B24cT23p9WCH
         Lp0uxJl+OVc33LgsvnbL6FCepJCKDcSUQNmF9ix1gd/lnxUKTqGeAr6A9WyY1Iv6w+TU
         pqUxdr9YyGHIB8CnaYU2qFX4cJnrkqO75gSKFii7qZBfVXV4P3jiM0TXbpVkm1epo66P
         si4M+RvCkAyNyVI9KI2GglDgoVeW11FiR+v+eoiGgROk6nJuBk+uRmDOskKxP8JQTZoF
         99tr9BrTf/w2RwTLYuLo3bsRgfm5W1QFfFKp8gBPBI8Yzbpfj2trwqp/gW70KEJpOplq
         IjvQ==
X-Gm-Message-State: AOJu0Yzt8t9oOAISn1UiBZgTLjjQnUDeNK1rRbk/ESYuLfqEoUmO4MX5
	fTvlqkpukhXmOYavIAEKEB+6q5f5+/3R5TFwKkIf0DK1UYlT/Z2a
X-Google-Smtp-Source: AGHT+IGBuww+7NYktanjmfSApua+GqDiYCpPrlPyh1iozfG9cndnF4jRRQwlogMNSeyGNGM9FWFljg==
X-Received: by 2002:a17:907:7252:b0:a59:ba34:f047 with SMTP id a640c23a62f3a-a5a116f6254mr83708866b.22.1715209653668;
        Wed, 08 May 2024 16:07:33 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1131::1331? ([2620:10d:c092:400::5:54e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d35csm10436866b.36.2024.05.08.16.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 16:07:33 -0700 (PDT)
Message-ID: <8ff3e0a3-faf7-4377-a4c3-8ee1aa82dd21@gmail.com>
Date: Thu, 9 May 2024 00:07:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: introduce btf c dump sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20240506134458.727621-1-yatsenko@meta.com>
 <CAEf4BzZ+nw6iu8RO1xJutRf+qnxAotHx47bXuJuw8AT-5Z3QfQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzZ+nw6iu8RO1xJutRf+qnxAotHx47bXuJuw8AT-5Z3QfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/24 22:02, Andrii Nakryiko wrote:
> On Mon, May 6, 2024 at 6:45 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Provide a way to sort bpftool c dump output, to simplify vmlinux.h
>> diffing and forcing more natural definitions ordering.
>>
>> Use `normalized` argument in bpftool CLI after `format c` for example:
>> ```
>> bpftool btf dump file /sys/kernel/btf/fuse format c normalized
>> ```
>>
>> Definitions are sorted by their BTF kind ranks, lexicographically and
>> typedefs are forced to go right after their base type.
>>
>> Type ranks
>>
>> Assign ranks to btf kinds (defined in function btf_type_rank) to set
>> next order:
>> 1. Anonymous enums
>> 2. Anonymous enums64
>> 3. Named enums
>> 4. Named enums64
>> 5. Trivial types typedefs (ints, then floats)
>> 6. Structs
>> 7. Unions
>> 8. Function prototypes
>> 9. Forward declarations
>>
>> Lexicographical ordering
>>
>> Definitions within the same BTF kind are ordered by their names.
>> Anonymous enums are ordered by their first element.
>>
>> Forcing typedefs to go right after their base type
>>
>> To make sure that typedefs are emitted right after their base type,
>> we build a list of type's typedefs (struct typedef_ref) and after
>> emitting type, its typedefs are emitted as well (lexicographically)
>>
>> There is a small flaw in this implementation:
>> Type dependencies are resolved by bpf lib, so when type is dumped
>> because it is a dependency, its typedefs are not output right after it,
>> as bpflib does not have the list of typedefs for a given type.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/bpf/bpftool/btf.c | 264 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 259 insertions(+), 5 deletions(-)
>>
> I applied this locally to experiment. Generated vmlinux.h for the
> production (a bit older) kernel and then for latest bpf-next/master
> kernel. And then tried diff between normalized vmlinux.h dumps and
> non-normalized.
>
> It took a bit for the diff tool to generate, but I think diff for
> normalized vmlinux.h is actually very usable. You can see an example
> at [1]. It shows whole new types being added in front of existing
> ones. And for existing ones it shows only parts that actually changed.
> It's quite nice. And note that I used a relatively stale production
> kernel vs latest upstream bpf-next, *AND* with different (bigger)
> Kconfig. So for more incremental changes in kernel config/version the
> diff should be much slower.
>
> I think this idea of normalizing vmlinux.h works and is useful.
>
> Eduard, Quentin, please take a look when you get a chance.
>
> My high-level feedback. I like the idea and it seems to work well in
> practice. I do think, though, that the current implementation is a bit
> over-engineered. I'd drop all the complexity with TYPEDEF and try to
> get almost the same behavior with a slightly different ranking
> strategy.
>
> Tracking which types are emitted seems unnecessary btf_dumper is doing
> that already internally. So I think overall flow could be basically
> three steps:
>
>    - precalculate/cache "sort names" and ranks;
>    - sort based on those two, construct 0-based list of types to emit
>    - just go linearly over that sorted list, call btf_dump__dump_type()
> on each one with original type ID; if the type was already emitted or
> is not the type that's emitted as an independent type (e.g.,
> FUNC_PROTO), btf_dump__dump_type() should do the right thing (do
> nothing).
>
> Any flaws in the above proposal?
>
>    [1] https://gist.github.com/anakryiko/cca678c8f77833d9eb99ffc102612e28
>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 91fcb75babe3..93c876e90b04 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/btf.h>
>>   #include <sys/types.h>
>>   #include <sys/stat.h>
>> +#include <linux/list.h>
>>
>>   #include <bpf/bpf.h>
>>   #include <bpf/btf.h>
>> @@ -43,6 +44,20 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>>          [BTF_KIND_ENUM64]       = "ENUM64",
>>   };
>>
>> +struct typedef_ref {
>> +       struct sort_datum *datum;
>> +       struct list_head list;
>> +};
>> +
>> +struct sort_datum {
>> +       __u32 index;
>> +       int type_rank;
>> +       bool emitted;
>> +       const char *name;
>> +       // List of typedefs of this type
> let's not use C++-style comments in C code, please stick to /* */
>
>> +       struct list_head *typedef_list;
>> +};
>> +
>>   static const char *btf_int_enc_str(__u8 encoding)
>>   {
>>          switch (encoding) {
>> @@ -460,8 +475,233 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
>>          vfprintf(stdout, fmt, args);
>>   }
>>
>> +static int btf_type_rank(const struct btf *btf, __u32 index, bool has_name)
>> +{
>> +       const struct btf_type *btf_type = btf__type_by_id(btf, index);
> nit: we normally use `t` when there is one BTF type that function is
> working with, it's nice and short that way
>
>> +       const int max_rank = 1000;
>> +
>> +       has_name |= (bool)btf_type->name_off;
> this is a rather unconventional way of writing
>
> if (btf_type->name_off)
>      has_name = true;
>
>> +
>> +       switch (btf_kind(btf_type)) {
>> +       case BTF_KIND_ENUM:
>> +               return 100 + (btf_type->name_off == 0 ? 0 : 1);
>> +       case BTF_KIND_ENUM64:
>> +               return 200 + (btf_type->name_off == 0 ? 0 : 1);
> nit: ENUM and ENUM64 are not fundamentally different, I'd rank them
> absolutely the same
>
>> +       case BTF_KIND_INT:
>> +               return 300;
>> +       case BTF_KIND_FLOAT:
>> +               return 400;
>> +       case BTF_KIND_VAR:
>> +               return 500;
> doesn't really matter, because VAR is not emitted by btf_dumper, but
> I'd put it right before DATASEC, they are related (i.e., I'd just drop
> them to max_rank for now)
>
>> +
>> +       case BTF_KIND_STRUCT:
>> +               return 600 + (has_name ? 0 : max_rank);
>> +       case BTF_KIND_UNION:
>> +               return 700 + (has_name ? 0 : max_rank);
> struct/union are also conceptually on the same footing, let's rank them the same
>
>> +       case BTF_KIND_FUNC_PROTO:
>> +               return 800 + (has_name ? 0 : max_rank);
> func_proto by itself is not emitted, it can be emitted as part of TYPEDEF only
>
>> +
>> +       case BTF_KIND_FWD:
>> +               return 900;
>> +
>> +       case BTF_KIND_ARRAY:
>> +               return 1 + btf_type_rank(btf, btf_array(btf_type)->type, has_name);
> similarly not an independent type, but maybe it's ranking influences
> the order of typedef, still reading the rest of the logic...
>
>> +
>> +       case BTF_KIND_CONST:
>> +       case BTF_KIND_PTR:
>> +       case BTF_KIND_VOLATILE:
>> +       case BTF_KIND_RESTRICT:
>> +       case BTF_KIND_TYPE_TAG:
>> +       case BTF_KIND_TYPEDEF:
>> +               return 1 + btf_type_rank(btf, btf_type->type, has_name);
>> +
>> +       default:
>> +               return max_rank;
>> +       }
>> +}
>> +
>> +static const char *btf_type_sort_name(const struct btf *btf, __u32 index)
>> +{
>> +       const struct btf_type *btf_type = btf__type_by_id(btf, index);
> nit: btf_type -> t
>
>> +       const int kind = btf_kind(btf_type);
>> +       const char *name = btf__name_by_offset(btf, btf_type->name_off);
>> +
>> +       // Use name of the first element for anonymous enums
> /* */
>
>> +       if (!btf_type->name_off && (kind == BTF_KIND_ENUM || kind == BTF_KIND_ENUM64))
>> +               name = btf__name_by_offset(btf, btf_enum(btf_type)->name_off);
> we could have empty enums, but they should be named (because they are
> effectively a forward-declaration of an enum), but it would be nice to
> guard btf_enum() access by checking vlen first
>
>> +
>> +       return name;
>> +}
>> +
>> +static int btf_type_compare(const void *left, const void *right)
>> +{
>> +       const struct sort_datum *datum1 = (const struct sort_datum *)left;
>> +       const struct sort_datum *datum2 = (const struct sort_datum *)right;
>> +
>> +       if (datum1->type_rank != datum2->type_rank)
>> +               return datum1->type_rank < datum2->type_rank ? -1 : 1;
>> +
>> +       return strcmp(datum1->name, datum2->name);
>> +}
>> +
>> +static int emit_typedefs(struct list_head *typedef_list, int *sorted_indexes)
>> +{
>> +       struct typedef_ref *type;
>> +       int current_index = 0;
>> +
>> +       if (!typedef_list)
>> +               return 0;
>> +       list_for_each_entry(type, typedef_list, list) {
>> +               if (type->datum->emitted)
>> +                       continue;
>> +               type->datum->emitted = true;
>> +               sorted_indexes[current_index++] = type->datum->index;
>> +               current_index += emit_typedefs(type->datum->typedef_list,
>> +                                       sorted_indexes + current_index);
>> +       }
>> +       return current_index;
>> +}
>> +
>> +static void free_typedefs(struct list_head *typedef_list)
>> +{
>> +       struct typedef_ref *type;
>> +       struct typedef_ref *temp_type;
>> +
>> +       if (!typedef_list)
>> +               return;
>> +       list_for_each_entry_safe(type, temp_type, typedef_list, list) {
>> +               list_del(&type->list);
>> +               free(type);
>> +       }
>> +       free(typedef_list);
>> +}
>> +
>> +static void add_typedef_ref(const struct btf *btf, struct sort_datum *parent,
>> +                           struct typedef_ref *new_ref)
>> +{
>> +       struct typedef_ref *current_child;
>> +       const char *new_child_name = new_ref->datum->name;
>> +
>> +       if (!parent->typedef_list) {
>> +               parent->typedef_list = malloc(sizeof(struct list_head));
>> +               INIT_LIST_HEAD(parent->typedef_list);
>> +               list_add(&new_ref->list, parent->typedef_list);
>> +               return;
>> +       }
>> +       list_for_each_entry(current_child, parent->typedef_list, list) {
>> +               const struct btf_type *t = btf__type_by_id(btf, current_child->datum->index);
>> +               const char *current_name = btf_str(btf, t->name_off);
>> +
>> +               if (list_is_last(&current_child->list, parent->typedef_list)) {
>> +                       list_add(&new_ref->list, &current_child->list);
>> +                       return;
>> +               }
>> +               if (strcmp(new_child_name, current_name) < 0) {
>> +                       list_add_tail(&new_ref->list, &current_child->list);
>> +                       return;
>> +               }
>> +       }
>> +}
>> +
>> +static int find_base_typedef_type(const struct btf *btf, int index)
>> +{
>> +       const struct btf_type *type = btf__type_by_id(btf, index);
>> +       int kind = btf_kind(type);
>> +       int base_idx;
>> +
>> +       if (kind != BTF_KIND_TYPEDEF)
>> +               return 0;
>> +
>> +       do {
>> +               base_idx = kind == BTF_KIND_ARRAY ? btf_array(type)->type : type->type;
>> +               type = btf__type_by_id(btf, base_idx);
>> +               kind = btf_kind(type);
>> +       } while (kind == BTF_KIND_ARRAY ||
>> +                  kind == BTF_KIND_PTR ||
>> +                  kind == BTF_KIND_CONST ||
>> +                  kind == BTF_KIND_VOLATILE ||
>> +                  kind == BTF_KIND_RESTRICT ||
>> +                  kind == BTF_KIND_TYPE_TAG);
>> +
>> +       return base_idx;
>> +}
>> +
> can we avoid all this complexity with TYPEDEFs if we just rank them
> just like the type they are pointing to? I.e., TYPEDEF -> STRUCT is
> just a struct, TYPEDEF -> TYPEDEF -> INT is just an INT. Emitting the
> TYPEDEF type will force all the dependent types to be emitted, which
> is good.
>
> If we also use this "pointee type"'s name as TYPEDEF's sort name, it
> will also put it in the position where it should be, right? There
> might be some insignificant deviations, but I think it would keep the
> code much simpler (and either way we are striving for something that
> more-or-less works as expected in practice, not designing some API
> that's set in stone).
>
> WDYT?
>
I don't think this will guarantee for each type all typedefs follow 
immediately.
For example:

With this patch next output is generated:
     typedef s64 aaa; /* aaa is the smallest first level child of s64 */
     typedef aaa ccc; /* ccc immediately follows aaa as child */
     typedef s64 bbb; /* bbb is first level child of s64 following aaa */
     typedef s32 xxx; /* xxx follows bbb lexicographically */

Option 2: I we apply flat sorting by rank and then name, we'll get next 
order:
     typedef s64 aaa;
     typedef s64 bbb;
     typedef aaa ccc;
     typedef s32 xxx;

Here order just follows aaa - bbb - ccc - xxx. Type ccc does not immediately
follow its parent aaa.

Option3: If we use pointee name as sort name, next output is expected:
     typedef s64 aaa; /* dependency of the next line */
     typedef aaa ccc; /* sort name aaa */
     typedef s32 xxx; /* sort name s32 */
     typedef s64 bbb; /* sort name s64 */

I think Option 2 will have the simplest implementation, but we are 
getting BFS
ordering instead of DFS. I'm not entirely sure, but it looks to me, that we
can't achieve DFS ordering with sort-based simple implementation, let me 
know if
I'm missing anything here.
If DFS ordering is not required, I'm happy to scrap it.
>> +static int *sort_btf_c(const struct btf *btf)
>> +{
>> +       int total_root_types;
>> +       struct sort_datum *datums;
>> +       int *sorted_indexes = NULL;
>> +       int *type_index_to_datum_index;
> nit: most of these names are unnecessarily verbose. It's one
> relatively straightforward function, just use shorter names "n",
> "idxs", "idx_to_datum", stuff like this. Cooler and shorter C names
> :))
>
>> +
>> +       if (!btf)
>> +               return sorted_indexes;
> this would be a horrible bug if this happens, don't guard against it here
>
>> +
>> +       total_root_types = btf__type_cnt(btf);
>> +       datums = malloc(sizeof(struct sort_datum) * total_root_types);
>> +
>> +       for (int i = 1; i < total_root_types; ++i) {
>> +               struct sort_datum *current_datum = datums + i;
>> +
>> +               current_datum->index = i;
>> +               current_datum->name = btf_type_sort_name(btf, i);
>> +               current_datum->type_rank = btf_type_rank(btf, i, false);
>> +               current_datum->emitted = false;
> btf_dump__dump_type() keeps track of which types are already emitted,
> you probably don't need to do this explicitly?
I use `emitted` to indicate whether type index has been copied into output
`sorted_indexes` array. This is needed because type (if it is a typedef)
can be put into output out of order by its parent base type, if base has
been processed earlier. It helps to avoid putting the same type twice in
the output array preventing buffer overrun.
>> +               current_datum->typedef_list = NULL;
>> +       }
>> +
>> +       qsort(datums + 1, total_root_types - 1, sizeof(struct sort_datum), btf_type_compare);
> do we really need to do 1-based indexing?
>
>> +
>> +       // Build a mapping from btf type id to datums array index
>> +       type_index_to_datum_index = malloc(sizeof(int) * total_root_types);
>> +       type_index_to_datum_index[0] = 0;
>> +       for (int i = 1; i < total_root_types; ++i)
>> +               type_index_to_datum_index[datums[i].index] = i;
>> +
>> +       for (int i = 1; i < total_root_types; ++i) {
>> +               struct sort_datum *current_datum = datums + i;
>> +               const struct btf_type *current_type = btf__type_by_id(btf, current_datum->index);
>> +               int base_index;
>> +               struct sort_datum *base_datum;
>> +               const struct btf_type *base_type;
>> +               struct typedef_ref *new_ref;
>> +
>> +               if (btf_kind(current_type) != BTF_KIND_TYPEDEF)
>> +                       continue;
>> +
>> +               base_index = find_base_typedef_type(btf, current_datum->index);
>> +               if (!base_index)
>> +                       continue;
>> +
>> +               base_datum = datums + type_index_to_datum_index[base_index];
>> +               base_type = btf__type_by_id(btf, base_datum->index);
>> +               if (!base_type->name_off)
>> +                       continue;
>> +
>> +               new_ref = malloc(sizeof(struct typedef_ref));
>> +               new_ref->datum = current_datum;
>> +
>> +               add_typedef_ref(btf, base_datum, new_ref);
>> +       }
>> +
>> +       sorted_indexes = malloc(sizeof(int) * total_root_types);
> nit: here and above, gotta check your malloc()'s for NULL results, it's C
>
>> +       sorted_indexes[0] = 0;
>> +       for (int emit_index = 1, datum_index = 1; emit_index < total_root_types; ++datum_index) {
>> +               struct sort_datum *datum = datums + datum_index;
>> +
>> +               if (datum->emitted)
>> +                       continue;
>> +               datum->emitted = true;
>> +               sorted_indexes[emit_index++] = datum->index;
>> +               emit_index += emit_typedefs(datum->typedef_list, sorted_indexes + emit_index);
>> +               free_typedefs(datum->typedef_list);
>> +       }
>> +       free(type_index_to_datum_index);
>> +       free(datums);
>> +       return sorted_indexes;
>> +}
>> +
>>   static int dump_btf_c(const struct btf *btf,
>> -                     __u32 *root_type_ids, int root_type_cnt)
>> +                     __u32 *root_type_ids, int root_type_cnt, bool normalized)
>>   {
>>          struct btf_dump *d;
>>          int err = 0, i;
>> @@ -485,12 +725,17 @@ static int dump_btf_c(const struct btf *btf,
>>                  }
>>          } else {
>>                  int cnt = btf__type_cnt(btf);
>> -
>> +               int *sorted_indexes = normalized ? sort_btf_c(btf) : NULL;
> keep empty line between variable declaration and the rest of the code
> in the block. Also see below, I'd declare sorted_indexes at the
> function level, init to NULL, and free at the end, keeping clean up
> simpler
>
>>                  for (i = 1; i < cnt; i++) {
>> -                       err = btf_dump__dump_type(d, i);
>> +                       int idx = sorted_indexes ? sorted_indexes[i] : i;
>> +
>> +                       err = btf_dump__dump_type(d, idx);
>>                          if (err)
>> -                               goto done;
>> +                               break;
>>                  }
>> +               free(sorted_indexes);
>> +               if (err)
>> +                       goto done;
> too convoluted, just free(sorted_indexes) next to btf_dump__free() at
> the very end, initialize it to NULL and be done with it.
>
>>          }
>>
>>          printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
>> @@ -553,6 +798,7 @@ static int do_dump(int argc, char **argv)
>>          __u32 root_type_ids[2];
>>          int root_type_cnt = 0;
>>          bool dump_c = false;
>> +       bool normalized = false;
>>          __u32 btf_id = -1;
>>          const char *src;
>>          int fd = -1;
>> @@ -663,6 +909,14 @@ static int do_dump(int argc, char **argv)
>>                                  goto done;
>>                          }
>>                          NEXT_ARG();
>> +               } else if (strcmp(*argv, "normalized") == 0) {
> use is_prefix() helper, then we can do `bpftool btf dump file <path>
> format c norm` without having to spell out entire "normalized"
>
>> +                       if (!dump_c) {
>> +                               p_err("Only C dump supports normalization");
>> +                               err = -EINVAL;
>> +                               goto done;
>> +                       }
> this should be checked after processing all the options, we shouldn't
> assume any mutual ordering between them
>
>> +                       normalized = true;
>> +                       NEXT_ARG();
>>                  } else {
>>                          p_err("unrecognized option: '%s'", *argv);
>>                          err = -EINVAL;
>> @@ -691,7 +945,7 @@ static int do_dump(int argc, char **argv)
>>                          err = -ENOTSUP;
>>                          goto done;
>>                  }
>> -               err = dump_btf_c(btf, root_type_ids, root_type_cnt);
>> +               err = dump_btf_c(btf, root_type_ids, root_type_cnt, normalized);
>>          } else {
>>                  err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
>>          }
>> --
>> 2.44.0
>>

