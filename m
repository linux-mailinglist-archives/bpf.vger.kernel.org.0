Return-Path: <bpf+bounces-66551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED4AB36D80
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 17:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC73188216D
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779002641FC;
	Tue, 26 Aug 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iHU9DMbv"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9E246BC6
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221284; cv=none; b=OwCoi2NtOBL+emvLfeunALD2tHWWJ8H5OXi0rwsz6g3n1Et10jhESZZGeUxOLHFFlW3h6OZCSHm5Qsk4JWfAT6/FJ07CRDzPbQUL0PEVlPxhcDWlNwDb41HNtW5K91KdDxWGdSLhVNu7zF50FOYEK08Swp+n59iGzY0KWl6CYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221284; c=relaxed/simple;
	bh=lSyzP83D4gbzZel3LrKsHONLu8+wCEnZ/3tvWAlrn7s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bzqPwD8RvY0mE0fZLgFzGmSg6lC8/HGuZwweyFk04epYYPPUuMrs6LkZafmvXSDO8+/OHLphcYHlHr/1Gl61P5Uii2uY2GNnTM1MXFz5iuMctL0C/JGi6XSGjJrPRya8pLPtbs4UnRZIca9I0Y2nEhoWi13n3xq1MVaz7LD/4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iHU9DMbv; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756221277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqHxo+iR9cy3xz1tS0lle7SItTgcTzunmy6GcF1Vw3A=;
	b=iHU9DMbva+VEpkAkZkqewOFMjD5QtxEq4mkh2pLGmrfrbjRlp7dKZwFvB5YXrAS9d80SSP
	DPoaT/GK648pD5neEXC3z9aXM4BAdjK26eglTYH3kFfgzjnuRZwMx41DuEDY1NxVTRAmND
	BHQnluEdBim5g1oQGVyEFW9FAOzPTMU=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 23:14:26 +0800
Message-Id: <DCCGHBQ8JKS8.1A9UN7MN5604V@linux.dev>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <olsajiri@gmail.com>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Introduce BPF_F_CPU flag for
 percpu_hash and lru_percpu_hash maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
References: <20250821160817.70285-1-leon.hwang@linux.dev>
 <20250821160817.70285-4-leon.hwang@linux.dev>
 <CAEf4BzZQBTMNBhp2HhYqGa0sb0X308oabBhWeeizDbw9erXzpA@mail.gmail.com>
In-Reply-To: <CAEf4BzZQBTMNBhp2HhYqGa0sb0X308oabBhWeeizDbw9erXzpA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat Aug 23, 2025 at 6:14 AM +08, Andrii Nakryiko wrote:
> On Thu, Aug 21, 2025 at 9:08=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_has=
h
>> maps to allow updating values for all CPUs with a single value.
>>
>> Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
>> maps to allow updating value for specified CPU.
>>
>> This enhancement enables:
>>
>> * Efficient update values across all CPUs with a single value when
>>   BPF_F_ALL_CPUS is set for update_elem and update_batch APIs.
>> * Targeted update or lookup for a specified CPU when BPF_F_CPU is set.
>>
>> The BPF_F_CPU flag is passed via:
>>
>> * map_flags of lookup_elem and update_elem APIs along with embedded cpu
>>   field.
>> * elem_flags of lookup_batch and update_batch APIs along with embedded
>>   cpu field.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h   |  54 +++++++++++++++++++-
>>  kernel/bpf/arraymap.c |  29 ++++-------
>>  kernel/bpf/hashtab.c  | 111 +++++++++++++++++++++++++++++-------------
>>  kernel/bpf/syscall.c  |  30 +++---------
>>  4 files changed, 147 insertions(+), 77 deletions(-)
>>
>
> [...]
>
>> @@ -397,22 +395,14 @@ int bpf_percpu_array_update(struct bpf_map *map, v=
oid *key, void *value,
>>                             u64 map_flags)
>>  {
>>         struct bpf_array *array =3D container_of(map, struct bpf_array, =
map);
>> -       const u64 cpu_flags =3D BPF_F_CPU | BPF_F_ALL_CPUS;
>>         u32 index =3D *(u32 *)key;
>>         void __percpu *pptr;
>> +       int off =3D 0, err;
>>         u32 size, cpu;
>> -       int off =3D 0;
>> -
>> -       if (unlikely((u32)map_flags > BPF_F_ALL_CPUS))
>> -               /* unknown flags */
>> -               return -EINVAL;
>> -       if (unlikely((map_flags & cpu_flags) =3D=3D cpu_flags))
>> -               return -EINVAL;
>>
>> -       cpu =3D map_flags >> 32;
>> -       if (unlikely((map_flags & BPF_F_CPU) && cpu >=3D num_possible_cp=
us()))
>> -               /* invalid cpu */
>> -               return -ERANGE;
>> +       err =3D bpf_map_check_cpu_flags(map_flags, true);
>> +       if (unlikely(err))
>> +               return err;
>
> again, unnecessary churn, why not add this function in previous patch
> when you add cpu flags ?
>

Ack.

>
>>
>>         if (unlikely(index >=3D array->map.max_entries))
>>                 /* all elements were pre-allocated, cannot insert a new =
one */
>> @@ -432,6 +422,7 @@ int bpf_percpu_array_update(struct bpf_map *map, voi=
d *key, void *value,
>>         rcu_read_lock();
>>         pptr =3D array->pptrs[index & array->index_mask];
>>         if (map_flags & BPF_F_CPU) {
>> +               cpu =3D map_flags >> 32;
>>                 copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
>>                 bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr,=
 cpu));
>>         } else {
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 71f9931ac64cd..34a35cdade425 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -937,24 +937,39 @@ static void free_htab_elem(struct bpf_htab *htab, =
struct htab_elem *l)
>>  }
>>
>>  static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
>> -                           void *value, bool onallcpus)
>> +                           void *value, bool onallcpus, u64 map_flags)
>>  {
>> +       int cpu =3D map_flags & BPF_F_CPU ? map_flags >> 32 : 0;
>> +       int current_cpu =3D raw_smp_processor_id();
>> +
>>         if (!onallcpus) {
>>                 /* copy true value_size bytes */
>> -               copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
>> +               copy_map_value(&htab->map, (map_flags & BPF_F_CPU) && cp=
u !=3D current_cpu ?
>> +                              per_cpu_ptr(pptr, cpu) : this_cpu_ptr(ppt=
r), value);
>
> is there any benefit to this cpu =3D=3D current_cpu special casing?
> Wouldn't per_cpu_ptr() do the right thing even if cpu =3D=3D current_cpu?
>

per_cpu_ptr() seems doing the same thing of this_cpu_ptr().

However, after having a deep research of per_cpu_ptr() and
this_cpu_ptr(), I think this_cpu_ptr() is more efficient than
per_cpu_ptr().

e.g.

DEFINE_PER_CPU(int, my_percpu_var) =3D 0;

int percpu_read(int cpu);
int thiscpu_read(void);
int percpu_currcpu_read(int cpu);

int percpu_read(int cpu)
{
    return *(int *)(void *)per_cpu_ptr(&my_percpu_var, cpu);
}
EXPORT_SYMBOL(percpu_read);

int thiscpu_read(void)
{
    return *(int *)(void *)this_cpu_ptr(&my_percpu_var);
}
EXPORT_SYMBOL(thiscpu_read);

int percpu_currcpu_read(int cpu)
{
    if (cpu =3D=3D raw_smp_processor_id())
        return *(int *)(void *)this_cpu_ptr(&my_percpu_var);
    else
        return *(int *)(void *)per_cpu_ptr(&my_percpu_var, cpu);
}
EXPORT_SYMBOL(percpu_currcpu_read);

Source code link[0].

With disassembling these functions, the core insns of this_cpu_ptr()
are:

0xffffffffc15c5076 <+6/0x6>:      48 c7 c0 04 60 03 00	movq	$0x36004, %rax
0xffffffffc15c507d <+13/0xd>:     65 48 03 05 7b 49 a5 3e	addq	%gs:0x3ea549=
7b(%rip), %rax
0xffffffffc15c5085 <+21/0x15>:    8b 00              	movl	(%rax), %eax

The core insns of per_cpu_ptr() are:

0xffffffffc15c501b <+11/0xb>:     49 c7 c4 04 60 03 00	movq	$0x36004, %r12
0xffffffffc15c5022 <+18/0x12>:    53                 	pushq	%rbx
0xffffffffc15c5023 <+19/0x13>:    48 63 df           	movslq	%edi, %rbx
0xffffffffc15c5026 <+22/0x16>:    48 81 fb 00 20 00 00	cmpq	$0x2000, %rbx
0xffffffffc15c502d <+29/0x1d>:    73 19              	jae	0xffffffffc15c504=
8	; percpu_read+0x38
0xffffffffc15c502f <+31/0x1f>:    48 8b 04 dd 80 fc 24 a8	movq	-0x57db0380(=
, %rbx, 8), %rax
0xffffffffc15c5037 <+39/0x27>:    5b                 	popq	%rbx
0xffffffffc15c5038 <+40/0x28>:    42 8b 04 20        	movl	(%rax, %r12), %e=
ax
0xffffffffc15c503c <+44/0x2c>:    41 5c              	popq	%r12
0xffffffffc15c503e <+46/0x2e>:    5d                 	popq	%rbp
0xffffffffc15c503f <+47/0x2f>:    31 f6              	xorl	%esi, %esi
0xffffffffc15c5041 <+49/0x31>:    31 ff              	xorl	%edi, %edi
0xffffffffc15c5043 <+51/0x33>:    c3                 	retq
0xffffffffc15c5044 <+52/0x34>:    cc                 	int3
0xffffffffc15c5045 <+53/0x35>:    cc                 	int3
0xffffffffc15c5046 <+54/0x36>:    cc                 	int3
0xffffffffc15c5047 <+55/0x37>:    cc                 	int3
0xffffffffc15c5048 <+56/0x38>:    48 89 de           	movq	%rbx, %rsi
0xffffffffc15c504b <+59/0x3b>:    48 c7 c7 a0 70 5c c1	movq	$18446744072658=
645152, %rdi
0xffffffffc15c5052 <+66/0x42>:    e8 d9 87 ac e5     	callq	0xffffffffa708d=
830	; __ubsan_handle_out_of_bounds+0x0 lib/ubsan.c:336
0xffffffffc15c5057 <+71/0x47>:    eb d6              	jmp	0xffffffffc15c502=
f	; percpu_read+0x1f

Disasm log link[1].

As we can see, per_cpu_ptr() calls __ubsan_handle_out_of_bounds() to
check index range of percpu offset array. The callq insn is much slower
than the addq insn.

Therefore, cpu =3D=3D current_cpu + this_cpu_ptr() is much better than
per_cpu_ptr().

Links:
[0] https://github.com/Asphaltt/kernel-module-fun/blob/master/percpu-ptr.c
[1] https://github.com/Asphaltt/kernel-module-fun/blob/master/percpu_ptr.md

>>         } else {
>>                 u32 size =3D round_up(htab->map.value_size, 8);
>> -               int off =3D 0, cpu;
>> +               int off =3D 0;
>> +
>> +               if (map_flags & BPF_F_CPU) {
>> +                       copy_map_value_long(&htab->map, cpu !=3D current=
_cpu ?
>> +                                           per_cpu_ptr(pptr, cpu) : thi=
s_cpu_ptr(pptr), value);
>> +                       return;
>> +               }
>
> [...]
>
>> @@ -1806,10 +1834,17 @@ __htab_map_lookup_and_delete_batch(struct bpf_ma=
p *map,
>>                         void __percpu *pptr;
>>
>>                         pptr =3D htab_elem_get_ptr(l, map->key_size);
>> -                       for_each_possible_cpu(cpu) {
>> -                               copy_map_value_long(&htab->map, dst_val =
+ off, per_cpu_ptr(pptr, cpu));
>> -                               check_and_init_map_value(&htab->map, dst=
_val + off);
>> -                               off +=3D size;
>> +                       if (!do_delete && (elem_map_flags & BPF_F_CPU)) =
{
>
> if do_delete is true we can't have BPF_F_CPU set, right? We checked
> that above, so why all these complications?
>

Ack.

This !do_delete is unnecessary. I'll drop it in next revision.

>> +                               cpu =3D elem_map_flags >> 32;
>> +                               copy_map_value_long(&htab->map, dst_val,=
 per_cpu_ptr(pptr, cpu));
>> +                               check_and_init_map_value(&htab->map, dst=
_val);
>> +                       } else {
>> +                               for_each_possible_cpu(cpu) {
>> +                                       copy_map_value_long(&htab->map, =
dst_val + off,
>> +                                                           per_cpu_ptr(=
pptr, cpu));
>> +                                       check_and_init_map_value(&htab->=
map, dst_val + off);
>> +                                       off +=3D size;
>> +                               }
>>                         }
>>                 } else {
>>                         value =3D htab_elem_value(l, key_size);
>> @@ -2365,14 +2400,18 @@ static void *htab_lru_percpu_map_lookup_percpu_e=
lem(struct bpf_map *map, void *k
>>         return NULL;
>>  }
>>
>> -int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
>> +int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u=
64 map_flags)
>>  {
>> +       int ret, cpu, off =3D 0;
>>         struct htab_elem *l;
>>         void __percpu *pptr;
>> -       int ret =3D -ENOENT;
>> -       int cpu, off =3D 0;
>>         u32 size;
>>
>> +       ret =3D bpf_map_check_cpu_flags(map_flags, false);
>> +       if (unlikely(ret))
>> +               return ret;
>> +       ret =3D -ENOENT;
>> +
>>         /* per_cpu areas are zero-filled and bpf programs can only
>>          * access 'value_size' of them, so copying rounded areas
>>          * will not leak any kernel data
>> @@ -2386,10 +2425,16 @@ int bpf_percpu_hash_copy(struct bpf_map *map, vo=
id *key, void *value)
>>          * eviction heuristics when user space does a map walk.
>>          */
>>         pptr =3D htab_elem_get_ptr(l, map->key_size);
>> -       for_each_possible_cpu(cpu) {
>> -               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, =
cpu));
>> -               check_and_init_map_value(map, value + off);
>> -               off +=3D size;
>> +       if (map_flags & BPF_F_CPU) {
>> +               cpu =3D map_flags >> 32;
>> +               copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
>> +               check_and_init_map_value(map, value);
>> +       } else {
>> +               for_each_possible_cpu(cpu) {
>> +                       copy_map_value_long(map, value + off, per_cpu_pt=
r(pptr, cpu));
>> +                       check_and_init_map_value(map, value + off);
>> +                       off +=3D size;
>> +               }
>>         }
>
> it feels like this whole logic of copying per-cpu value to/from user
> should be generic between all per-cpu maps, once we get that `void
> __percpu *` pointer, no? See if you can extract it as reusable helper
> (but, you know, without all the per-map type special casing, though it
> doesn't seem like you should need it, though I might be missing
> details, of course). One for bpf_percpu_copy_to_user() and another for
> bpf_percpu_copy_from_user(), which would take into account all these
> cpu flags?
>

Good idea.

Let's introduce these two helper functions.

Thanks,
Leon

[...]

