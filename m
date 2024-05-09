Return-Path: <bpf+bounces-29331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FB8C19C7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2E028543F
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282112D760;
	Thu,  9 May 2024 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYCQJ/Wf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07112838D
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296176; cv=none; b=dNJmUx2q5qbeW/Lm9/dE95ckxb/VFNKfB1vcmc+khhSxkoi9laSFC0F+F+eoB9ZMuUUXfsWX99juuJ+MF/CTYhnFU6p7Zr2Z1JP03rMPB7JTUn0e1VXRXCSZi/mHLRFjoHdmEwedb1nu6t+wIyIiC7LBP7NBaEdDenkxTbjJYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296176; c=relaxed/simple;
	bh=VwPy2X1QytQZvEMvECpGY8ibN2h/HLoZ0yAv6oUptvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USLbS/BHuMaYZDcFI/ZdLwhmZEl3g78FatsxwH+Vyf7bt9yLOLgP5Rd5//+QzneNZgtGzzXrYrPNcHLF+zHxuT67QhzbAnzs3K/u5/9VDzvjmtYEJuXVyScj7i8SpEhjd/muaAG+l11AHwGIpRIod3cAoF3i0JKmo3IiwOOe7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYCQJ/Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BBCC116B1;
	Thu,  9 May 2024 23:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715296176;
	bh=VwPy2X1QytQZvEMvECpGY8ibN2h/HLoZ0yAv6oUptvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VYCQJ/WfzxF66GlDbJtAY+TOCivalH9kgEAmUpBFPjJ2DfwhCHOgQ4FNZvo+e1N7D
	 pqgV5bA04kriqJdIovozUiM72CYKUCKuWZEM8jaiF7mTtNYU02b6yZBZkf0iiaLBJm
	 hGZLdLn4u9GcF5X6VULf+lsqRC6DLXLlDoV8lUJyMdKqNxPPVylwPY67zeFhH9boxT
	 8ObRiW2j8vbKMsNjL1nUGRbqEhjHZimhxcsQPieHkv4J2WF9Pxmu/obtW4vpUOPrl6
	 F9cenv/XHS2Fy75zry8iEFcXZRjn/KDMvm+ToM6wK0HWJaLcRY8Vnav1F72uHjxS1l
	 eCqOPDdukqRww==
Message-ID: <fa464ad7-4af3-4c25-a786-0f6b5c9d260e@kernel.org>
Date: Fri, 10 May 2024 00:09:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 bpf-next] bpftool: introduce btf c dump sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20240509151744.131648-1-yatsenko@meta.com>
 <CAEf4Bzbfiii8yamOoMgoQjswvvrehF8crUK_4zJ8AA1tmHWoxQ@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4Bzbfiii8yamOoMgoQjswvvrehF8crUK_4zJ8AA1tmHWoxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/05/2024 22:39, Andrii Nakryiko wrote:
> On Thu, May 9, 2024 at 8:17 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
>> forcing more natural type definitions ordering.
>>
>> Definitions are sorted first by their BTF kind ranks, then by their base
>> type name and by their own name.
>>
>> Type ranks
>>
>> Assign ranks to btf kinds (defined in function btf_type_rank) to set
>> next order:
>> 1. Anonymous enums/enums64
>> 2. Named enums/enums64
>> 3. Trivial types typedefs (ints, then floats)
>> 4. Structs/Unions
>> 5. Function prototypes
>> 6. Forward declarations
>>
>> Type rank is set to maximum for unnamed reference types, structs and
>> unions to avoid emitting those types early. They will be emitted as
>> part of the type chain starting with named type.
>>
>> Lexicographical ordering
>>
>> Each type is assigned a sort_name and own_name.
>> sort_name is the resolved name of the final base type for reference
>> types (typedef, pointer, array etc). Sorting by sort_name allows to
>> group typedefs of the same base type. sort_name for non-reference type
>> is the same as own_name. own_name is a direct name of particular type,
>> is used as final sorting step.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/bpf/bpftool/btf.c | 125 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 122 insertions(+), 3 deletions(-)
>>
> 
> It's getting very close, see a bunch of nits below.

Agreed, it's in a nice shape, thanks a lot for this work. Apologies for
the review delay, I just have a few additional nits.

> 
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 91fcb75babe3..09ecd2abf066 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -43,6 +43,13 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>>         [BTF_KIND_ENUM64]       = "ENUM64",
>>  };
>>
>> +struct sort_datum {
>> +       int index;
>> +       int type_rank;
>> +       const char *sort_name;
>> +       const char *own_name;
>> +};
>> +
>>  static const char *btf_int_enc_str(__u8 encoding)
>>  {
>>         switch (encoding) {
>> @@ -460,11 +467,114 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
>>         vfprintf(stdout, fmt, args);
>>  }
>>
>> +static bool is_reference_type(const struct btf_type *t)
>> +{
>> +       int kind = btf_kind(t);
>> +
>> +       return kind == BTF_KIND_CONST || kind == BTF_KIND_PTR || kind == BTF_KIND_VOLATILE ||
>> +               kind == BTF_KIND_RESTRICT || kind == BTF_KIND_ARRAY || kind == BTF_KIND_TYPEDEF ||
>> +               kind == BTF_KIND_DECL_TAG;
> 
> probably best to write as a switch, also make sure that
> BTF_KIND_TYPE_TAG is supported, it is effectively treated as
> CONST/VOLATILE
> 
> and actually looking below, I'd just incorporate these as extra cases
> in the existing btf_type_rank() switch, and then have a similar
> open-coded switch for btf_type_sort_name()
> 
> When dealing with BTF I find these explicit switches listing what
> kinds are special and how they are processed much easier to check and
> follow than any of the extra helpers doing some kind checks
> 
> 
>> +}
>> +
>> +static int btf_type_rank(const struct btf *btf, __u32 index, bool has_name)
>> +{
>> +       const struct btf_type *t = btf__type_by_id(btf, index);
>> +       const int max_rank = 10;
>> +       const int kind = btf_kind(t);
>> +
>> +       if (t->name_off)
>> +               has_name = true;
>> +
>> +       switch (kind) {
>> +       case BTF_KIND_ENUM:
>> +       case BTF_KIND_ENUM64:
>> +               return has_name ? 1 : 0;
>> +       case BTF_KIND_INT:
>> +       case BTF_KIND_FLOAT:
>> +               return 2;
>> +       case BTF_KIND_STRUCT:
>> +       case BTF_KIND_UNION:
>> +               return has_name ? 3 : max_rank;
>> +       case BTF_KIND_FUNC_PROTO:
>> +               return has_name ? 4 : max_rank;
>> +
>> +       default: {
>> +               if (has_name && is_reference_type(t)) {
>> +                       const int parent = kind == BTF_KIND_ARRAY ? btf_array(t)->type : t->type;
>> +
>> +                       return btf_type_rank(btf, parent, has_name);
>> +               }
>> +               return max_rank;
>> +       }
> 
> nit: you don't need these {} for default
> 
>> +       }
>> +}
>> +
>> +static const char *btf_type_sort_name(const struct btf *btf, __u32 index)
>> +{
>> +       const struct btf_type *t = btf__type_by_id(btf, index);
>> +       int kind = btf_kind(t);
>> +
>> +       /* Use name of the first element for anonymous enums */
>> +       if (!t->name_off && (kind == BTF_KIND_ENUM || kind == BTF_KIND_ENUM64) &&
> 
> there is btf_is_any_enum() helper for this kind check
> 
>> +           BTF_INFO_VLEN(t->info))
> 
> please use btf_vlen(t) helper
> 
>> +               return btf__name_by_offset(btf, btf_enum(t)->name_off);
> 
> what if enum's vlen == 0? I think I mentioned that before, it
> shouldn't happen in valid BTF, but it's technically allowable in BTF,
> so best to be able to handle that instead of crashing or doing random
> memory reads.
> 
>> +
>> +       /* Return base type name for reference types */
>> +       while (is_reference_type(t)) {
>> +               index = btf_kind(t) == BTF_KIND_ARRAY ? btf_array(t)->type : t->type;
>> +               t = btf__type_by_id(btf, index);
>> +       }
>> +
>> +       return btf__name_by_offset(btf, t->name_off);
>> +}
>> +
>> +static int btf_type_compare(const void *left, const void *right)
>> +{
>> +       const struct sort_datum *datum1 = (const struct sort_datum *)left;
>> +       const struct sort_datum *datum2 = (const struct sort_datum *)right;
>> +       int sort_name_cmp;
> 
> stylistic nit: it's minot, but I'd use less distracting naming. Eg., d1, d2, r.
> 
>> +
>> +       if (datum1->type_rank != datum2->type_rank)
>> +               return datum1->type_rank < datum2->type_rank ? -1 : 1;
>> +
>> +       sort_name_cmp = strcmp(datum1->sort_name, datum2->sort_name);
>> +       if (sort_name_cmp)
>> +               return sort_name_cmp;
>> +
>> +       return strcmp(datum1->own_name, datum2->own_name);
>> +}
>> +
>> +static struct sort_datum *sort_btf_c(const struct btf *btf)
>> +{
>> +       int total_root_types;
>> +       struct sort_datum *datums;
>> +
>> +       total_root_types = btf__type_cnt(btf);
> 
> nit: s/total_root_types/n/
> 
>> +       datums = malloc(sizeof(struct sort_datum) * total_root_types);
>> +       if (!datums)
>> +               return NULL;
>> +
>> +       for (int i = 0; i < total_root_types; ++i) {
>> +               struct sort_datum *current_datum = datums + i;
> 
> nit: just d for the name, it's not going to be hard to follow or ambiguous
> 
>> +               const struct btf_type *t = btf__type_by_id(btf, i);
>> +
>> +               current_datum->index = i;
>> +               current_datum->type_rank = btf_type_rank(btf, i, false);
>> +               current_datum->sort_name = btf_type_sort_name(btf, i);
>> +               current_datum->own_name = btf__name_by_offset(btf, t->name_off);
>> +       }
>> +
>> +       qsort(datums, total_root_types, sizeof(struct sort_datum), btf_type_compare);
>> +
>> +       return datums;
>> +}
>> +
>>  static int dump_btf_c(const struct btf *btf,
>> -                     __u32 *root_type_ids, int root_type_cnt)
>> +                     __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
>>  {
>>         struct btf_dump *d;
>>         int err = 0, i;
>> +       struct sort_datum *datums = NULL;

Nit: Most variables in the file are declared in "reverse-Christmas-tree"
order (longest lines first, unless there's a reason not to). Could you
please try to preserve this order, here and elsewhere, for consistency?

>>
>>         d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
>>         if (!d)
>> @@ -486,8 +596,12 @@ static int dump_btf_c(const struct btf *btf,
>>         } else {
>>                 int cnt = btf__type_cnt(btf);
>>
>> +               if (sort_dump)
>> +                       datums = sort_btf_c(btf);
>>                 for (i = 1; i < cnt; i++) {
>> -                       err = btf_dump__dump_type(d, i);
>> +                       int idx = datums ? datums[i].index : i;
>> +
>> +                       err = btf_dump__dump_type(d, idx);
>>                         if (err)
>>                                 goto done;
>>                 }
>> @@ -501,6 +615,7 @@ static int dump_btf_c(const struct btf *btf,
>>
>>  done:
>>         btf_dump__free(d);
>> +       free(datums);

Small nit: I'd swap the two lines above, it would seem more logical to
free in the reverse order from allocation and would be more
straightforward to "split" if we ever need to free d only when jumping
from the first goto.

>>         return err;
>>  }
>>
>> @@ -553,6 +668,7 @@ static int do_dump(int argc, char **argv)
>>         __u32 root_type_ids[2];
>>         int root_type_cnt = 0;
>>         bool dump_c = false;
>> +       bool sort_dump_c = true;
>>         __u32 btf_id = -1;
>>         const char *src;
>>         int fd = -1;
>> @@ -663,6 +779,9 @@ static int do_dump(int argc, char **argv)
>>                                 goto done;
>>                         }
>>                         NEXT_ARG();
>> +               } else if (is_prefix(*argv, "unordered")) {
> 
> it's more of a "original order" rather than unordered, so maybe "unnormalized"?
I'd have gone with "unsorted", but Andrii's reasoning probably applies
the same to it. I find "unnormalized" might be difficult to understand,
maybe "preserve_order" or, shorter, "keep_order"?

And as Alan mentioned on the other thread, we'll need the following
updates for the new keyword:

- Adding the keyword to the command summary at the top of
  tools/bpf/bpftool/Documentation/bpftool-btf.rst:
  | *FORMAT* := { **raw** | **c** [**unordered**]}
  (or whatever keyword we pick)
- Adding the description for the keyword, below on the same page
- Adding the keyword to the help message, at the end of btf.c
- Updating the bash completion. The patch below should work (to adjust
  with the final keyword):

------
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 04afe2ac2228..85a43c867e5f 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -930,6 +930,9 @@ _bpftool()
                         format)
                             COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
                             ;;
+                        c)
+                            COMPREPLY=( $( compgen -W "unordered" -- "$cur" ) )
+                            ;;
                         *)
                             # emit extra options
                             case ${words[3]} in
------

