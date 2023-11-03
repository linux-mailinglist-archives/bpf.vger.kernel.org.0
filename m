Return-Path: <bpf+bounces-14082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BB47E070E
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 17:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC791C210D5
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120301DA39;
	Fri,  3 Nov 2023 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DYhz1Sck"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443101CF88
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:53:59 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7AD1BC
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 09:53:54 -0700 (PDT)
Message-ID: <57a8597c-0739-4b3b-a157-c31d9db55845@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699030432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55gyAz3uWzWd+PZUOW4bjhcVTwYvphV9bg3T+AvaY1o=;
	b=DYhz1Sckbw6oOIN5uKV0MVFXrJZVRIKudLW3HttXoxsmqSBUyXkF9dFQ1mRrY8Hw/JrdAW
	XKvKPhySvwcoJRPaer6ykzbTI+SH1psQMziSs6EG8Y6FTZWMrV3N/6/YdYLmAiE56d9B2r
	RMkonFk34tUgvCDONLJeS31otgHdHkw=
Date: Fri, 3 Nov 2023 09:53:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next] libbpf: bpftool : Emit aligned(8) attr for
 empty struct in btf source dump
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Vadim Fedorenko <vadfed@meta.com>, Martin KaFai Lau <martin.lau@linux.dev>
References: <20231103055218.2395034-1-yonghong.song@linux.dev>
 <CAEf4BzZ1ZKEGvcz+fuvZ18bx5E4kkqg0-dTu1DqohZMTMcqR0g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZ1ZKEGvcz+fuvZ18bx5E4kkqg0-dTu1DqohZMTMcqR0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/3/23 9:21 AM, Andrii Nakryiko wrote:
> On Thu, Nov 2, 2023 at 10:52 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Martin and Vadim reported a verifier failure with bpf_dynptr usage.
>> The issue is mentioned but Vadim workarounded the issue with source
>> change ([1]). The below describes what is the issue and why there
>> is a verification failure.
>>
>>    int BPF_PROG(skb_crypto_setup) {
>>      struct bpf_dynptr algo, key;
>>      ...
>>
>>      bpf_dynptr_from_mem(..., ..., 0, &algo);
>>      ...
>>    }
>>
>> The bpf program is using vmlinux.h, so we have the following definition in
>> vmlinux.h:
>>    struct bpf_dynptr {
>>          long: 64;
>>          long: 64;
>>    };
>> Note that in uapi header bpf.h, we have
>>    struct bpf_dynptr {
>>          long: 64;
>>          long: 64;
>> } __attribute__((aligned(8)));
>>
>> So we lost alignment information for struct bpf_dynptr by using vmlinux.h.
>> Let us take a look at a simple program below:
>>    $ cat align.c
>>    typedef unsigned long long __u64;
>>    struct bpf_dynptr_no_align {
>>          __u64 :64;
>>          __u64 :64;
>>    };
>>    struct bpf_dynptr_yes_align {
>>          __u64 :64;
>>          __u64 :64;
>>    } __attribute__((aligned(8)));
>>
>>    void bar(void *, void *);
>>    int foo() {
>>      struct bpf_dynptr_no_align a;
>>      struct bpf_dynptr_yes_align b;
>>      bar(&a, &b);
>>      return 0;
>>    }
>>    $ clang --target=bpf -O2 -S -emit-llvm align.c
>>
>> Look at the generated IR file align.ll:
>>    ...
>>    %a = alloca %struct.bpf_dynptr_no_align, align 1
>>    %b = alloca %struct.bpf_dynptr_yes_align, align 8
>>    ...
>>
>> The compiler dictates the alignment for struct bpf_dynptr_no_align is 1 and
>> the alignment for struct bpf_dynptr_yes_align is 8. So theoretically compiler
>> could allocate variable %a with alignment 1 although in reallity the compiler
>> may choose a different alignment by considering other variables.
>>
>> In [1], the verification failure happens because variable 'algo' is allocated
>> on the stack with alignment 4 (fp-28). But the verifer wants its alignment
>> to be 8.
>>
>> To fix the issue, the aligned(8) attribute should be emitted for those
>> special uapi structs (bpf_dynptr etc.) whose values will be used by
>> kernel helpers or kfuncs. For example, the following bpf_dynptr type
>> will be generated in vmlinux.h:
>>    struct bpf_dynptr {
>>          long: 64;
>>          long: 64;
>> } __attribute__((aligned(8)));
>>
>> There are a few ways to do this:
>>    (1). this patch added an option 'empty_struct_align8' in 'btf_dump_opts',
>>         and bpftool will enable this option so libbpf will emit aligned(8)
>>         for empty structs. The only drawback is that some other non-bpf-uapi
>>         empty structs may be marked as well but this does not have any real impact.
>>    (2). Only add aligned(8) if the struct having 'bpf_' prefix. Similar to (1),
>>         the action is controlled with an option in 'btf_dump_opts'.
>>
>> Also, not sure whether adding an option in 'btf_dump_opts' is the best solution
>> or not. Another possibility is to add an option to btf_dump__dump_type() with
>> a different function name, e.g., btf_dump__dump_type_opts() but it makes the
>> function is not consistent with btf_dump__emit_type_decl().
>>
>> So send this patch as RFC due to above different implementation choices.
>>
> Let's do what we do for open-coded iterators, add opaque u64s:
>
> /* BPF numbers iterator state */
> struct bpf_iter_num {
>          /* opaque iterator state; having __u64 here allows to preserve correct
>           * alignment requirements in vmlinux.h, generated from BTF
>           */
>          __u64 __opaque[1];
> } __attribute__((aligned(8)));

Good point. Will do. This will need change uapi struct, I think it is okay.
with __u64, we should not need aligned(8) attribute, but since uapi header
already has it like in the above, I can keep it as well.


>
>
> I think it's much better than random extra options or having to do
> what we do with private() macro everywhere:
>
> #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
>
>
>>    [1] https://lore.kernel.org/bpf/1b100f73-7625-4c1f-3ae5-50ecf84d3ff0@linux.dev/
>>
>> Cc: Vadim Fedorenko <vadfed@meta.com>
>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/bpf/bpftool/btf.c  | 5 ++++-
>>   tools/lib/bpf/btf.h      | 7 ++++++-
>>   tools/lib/bpf/btf_dump.c | 7 ++++++-
>>   3 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 91fcb75babe3..c9061d476f7d 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -463,10 +463,13 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
>>   static int dump_btf_c(const struct btf *btf,
>>                        __u32 *root_type_ids, int root_type_cnt)
>>   {
>> +       LIBBPF_OPTS(btf_dump_opts, opts,
>> +               .empty_struct_align8 = true,
>> +       );
>>          struct btf_dump *d;
>>          int err = 0, i;
>>
>> -       d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
>> +       d = btf_dump__new(btf, btf_dump_printf, NULL, &opts);
>>          if (!d)
>>                  return -errno;
>>
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index 8e6880d91c84..af88563fe0ff 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -235,8 +235,13 @@ struct btf_dump;
>>
>>   struct btf_dump_opts {
>>          size_t sz;
>> +       /* emit '__attribute__((aligned(8)))' for empty struct, i.e.,
>> +        * the struct has no named member.
>> +        */
>> +       bool empty_struct_align8;
>> +       size_t :0;
>>   };
>> -#define btf_dump_opts__last_field sz
>> +#define btf_dump_opts__last_field empty_struct_align8
>>
>>   typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
>>
>> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
>> index 4d9f30bf7f01..fe386d20a43a 100644
>> --- a/tools/lib/bpf/btf_dump.c
>> +++ b/tools/lib/bpf/btf_dump.c
>> @@ -83,6 +83,7 @@ struct btf_dump {
>>          int ptr_sz;
>>          bool strip_mods;
>>          bool skip_anon_defs;
>> +       bool empty_struct_align8;
>>          int last_id;
>>
>>          /* per-type auxiliary state */
>> @@ -167,6 +168,7 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
>>          d->printf_fn = printf_fn;
>>          d->cb_ctx = ctx;
>>          d->ptr_sz = btf__pointer_size(btf) ? : sizeof(void *);
>> +       d->empty_struct_align8 = OPTS_GET(opts, empty_struct_align8, false);
>>
>>          d->type_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
>>          if (IS_ERR(d->type_names)) {
>> @@ -808,7 +810,10 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
>>
>>                  if (top_level_def) {
>>                          btf_dump_emit_struct_def(d, id, t, 0);
>> -                       btf_dump_printf(d, ";\n\n");
>> +                       if (kind == BTF_KIND_UNION || btf_vlen(t) || !d->empty_struct_align8)
>> +                               btf_dump_printf(d, ";\n\n");
>> +                       else
>> +                               btf_dump_printf(d, " __attribute__((aligned(8)));\n\n");
>>                          tstate->emit_state = EMITTED;
>>                  } else {
>>                          tstate->emit_state = NOT_EMITTED;
>> --
>> 2.34.1
>>

