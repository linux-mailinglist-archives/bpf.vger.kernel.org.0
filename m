Return-Path: <bpf+bounces-63967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B591CB0CE1E
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66306188EB0F
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047CD246333;
	Mon, 21 Jul 2025 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uAEFW6PL"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E40B2459C8
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140471; cv=none; b=c7gBgCATbgDDf8s2qpE8w3fSizBnur3hd/mzK8XxLumFcvJAlR5sF+e8A5VicMApAn69zPCSNqD8PH+F4//FUQxz3aIiz0zZwITUL1XZy5o6dKsLgn1DW9NgDiX18BrPFMjtlzSz2vU8ssoTX56pPQWFveOD3BzU69UEaE7VCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140471; c=relaxed/simple;
	bh=J/MXvgo7mZxAC0LIsSYllW/8Q2AkZkyO6l4aq/l5s7Q=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=geusmq+gXRSi+wIVs3zqItqQ0+ncdzuvPwI32uT/zH/DkZTX1y+7sMQoroAPrfYJMko5nu4jrUp0PFAyy69gZnJbbU2etpX3XDYfEzVWTXV3mGrheRA+wDRxZH4ASjdIC6SRa5BJx/xMFymgw4zHozzavVBVJ/v2B/aT9XejjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uAEFW6PL; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753140456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIWLkt1fQeOALyHaPRopIrYWKOB+wbybSrugFCVF/YA=;
	b=uAEFW6PLSl1EVANoqmMifDXLbaKt2BA4bXOvdUc6obAIMnt01zSYaF1nTYl6l3xUI5XWFO
	XO8M4uP4tCh6PmOYY8GX4vlifFnvVYrZi55NF2qEMdR5Z+j+cp32lLaSh1hrsq4dJ5Kuwl
	J867Fbrjfckih3Lqv4DdH8GKQ2opgjA=
Date: Mon, 21 Jul 2025 23:27:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev>
TLS-Required: No
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
To: "Jiri Olsa" <olsajiri@gmail.com>, "Alan Maguire"
 <alan.maguire@oracle.com>
Cc: "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Menglong Dong"
 <menglong8.dong@gmail.com>, dwarves@vger.kernel.org, bpf@vger.kernel.org,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andriin@fb.com>, "Yonghong Song" <yhs@fb.com>, "Song Liu"
 <songliubraving@fb.com>, "Eduard Zingerman" <eddyz87@gmail.com>
In-Reply-To: <aH5OW0rtSuMn1st1@krava>
References: <20250717152512.488022-1-jolsa@kernel.org>
 <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com>
 <aH5OW0rtSuMn1st1@krava>
X-Migadu-Flow: FLOW_OUT

On 7/21/25 7:27 AM, Jiri Olsa wrote:
> On Mon, Jul 21, 2025 at 12:41:00PM +0100, Alan Maguire wrote:
>> On 17/07/2025 16:25, Jiri Olsa wrote:
>>> Menglong reported issue where we can have function in BTF which has
>>> multiple addresses in kallsysm [1].
>>>
>>> Rather than filtering this in runtime, let's teach pahole to remove
>>> such functions.
>>>
>>> Removing duplicate records from functions entries that have more
>>> at least one different address. This way btf_encoder__find_function
>>> won't find such functions and they won't be added in BTF.
>>>
>>> In my setup it removed 428 functions out of 77141.
>>>
>>
>> Is such removal necessary? If the presence of an mcount annotation is
>> the requirement, couldn't we just utilize
>>
>> /sys/kernel/tracing/available_filter_functions_addrs
>>
>> to map name to address safely? It identifies mcount-containing functio=
ns
>> and some of these appear to be duplicates, for example there I see
>>
>> ffffffff8376e8b4 acpi_attr_is_visible
>> ffffffff8379b7d4 acpi_attr_is_visible
>=20
>=20for that we'd need new interface for loading fentry/fexit.. programs,=
 right?
>=20
>=20the current interface to get fentry/fexit.. attach address is:
>    - user specifies function name, that translates to btf_id
>    - in kernel that btf id translates back to function name
>    - kernel uses kallsyms_lookup_name or find_kallsyms_symbol_value
>      to get the address
>=20
>=20so we don't really know which address user wanted in the first place

Hi Jiri, Alan.

I stumbled on a bug today which seems to be relevant to this
discussion.

I tried building the kernel with KASAN and UBSAN, and that resulted in
some kfuncs disappearing from vmlinux.h, triggering selftests/bpf
compilation errors, for example:

      CLNG-BPF [test_progs-no_alu32] cgroup_read_xattr.bpf.o
    progs/cgroup_read_xattr.c:127:13: error: call to undeclared function =
'bpf_cgroup_ancestor'; ISO C99 and later do not support implicit function=
 declarations [-Wimplicit-function-declaration]
      127 |         ancestor =3D bpf_cgroup_ancestor(cgrp, 1);
          |                    ^

Here is a piece of vmlinux.h diff between CONFIG_UBSAN=3Dy/n:

    --- ./tools/testing/selftests/bpf/tools/include/vmlinux.h	2025-07-21 =
17:35:14.415733105 +0000
    +++ ubsan_vmlinux.h	2025-07-21 17:33:10.455312623 +0000
    @@ -117203,7 +117292,6 @@
     extern int bpf_arena_reserve_pages(void *p__map, void __attribute__(=
(address_space(1))) *ptr__ign, u32 page_cnt) __weak __ksym;
     extern __bpf_fastcall void *bpf_cast_to_kern_ctx(void *obj) __weak _=
_ksym;
     extern struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp) __weak=
 __ksym;
    -extern struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int l=
evel) __weak __ksym;
     extern struct cgroup *bpf_cgroup_from_id(u64 cgid) __weak __ksym;
     extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *=
name__str, struct bpf_dynptr *value_p) __weak __ksym;
     extern void bpf_cgroup_release(struct cgroup *cgrp) __weak __ksym;
    @@ -117260,7 +117348,6 @@
     extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p) __weak =
__ksym;
     extern int bpf_dynptr_memset(struct bpf_dynptr *p, u32 offset, u32 s=
ize, u8 val) __weak __ksym;
     extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __weak __ks=
ym;
    -extern void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset=
, void *buffer__opt, u32 buffer__szk) __weak __ksym;
     extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 o=
ffset, void *buffer__opt, u32 buffer__szk) __weak __ksym;
     extern int bpf_fentry_test1(int a) __weak __ksym;
     extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *n=
ame__str, struct bpf_dynptr *value_p) __weak __ksym;
    @@ -117287,7 +117374,6 @@
     extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int =
end) __weak __ksym;
     extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym=
;
     extern void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __=
weak __ksym;
    -extern int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq=
_id, u64 flags) __weak __ksym;
     extern struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx=
_dsq *it) __weak __ksym;
     extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak _=
_ksym;
     extern int bpf_iter_task_new(struct bpf_iter_task *it, struct task_s=
truct *task__nullable, unsigned int flags) __weak __ksym;
    @@ -117373,11 +117459,8 @@
     extern int bpf_strspn(const char *s__ign, const char *accept__ign) _=
_weak __ksym;
     extern int bpf_strstr(const char *s1__ign, const char *s2__ign) __we=
ak __ksym;
     extern struct task_struct *bpf_task_acquire(struct task_struct *p) _=
_weak __ksym;
    -extern struct task_struct *bpf_task_from_pid(s32 pid) __weak __ksym;
    -extern struct task_struct *bpf_task_from_vpid(s32 vpid) __weak __ksy=
m;
     extern struct cgroup *bpf_task_get_cgroup1(struct task_struct *task,=
 int hierarchy_id) __weak __ksym;
     extern void bpf_task_release(struct task_struct *p) __weak __ksym;
    -extern long int bpf_task_under_cgroup(struct task_struct *task, stru=
ct cgroup *ancestor) __weak __ksym;
     extern void bpf_throw(u64 cookie) __weak __ksym;
     extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p, str=
uct bpf_dynptr *sig_p, struct bpf_key *trusted_keyring) __weak __ksym;
     extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int=
 flags) __weak __ksym;
    @@ -117412,15 +117495,10 @@
     extern u32 scx_bpf_cpuperf_cur(s32 cpu) __weak __ksym;
     extern void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __weak __ksym;
     extern s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __weak __ksym;
    -extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
    -extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 =
slice, u64 enq_flags) __weak __ksym;
     extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
     extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__i=
ter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
    -extern void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_=
dsq *it__iter, u64 slice) __weak __ksym;
    -extern void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_=
dsq *it__iter, u64 vtime) __weak __ksym;
     extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
     extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id=
, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
    -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq =
*it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksy=
m;
     extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u6=
4 slice, u64 enq_flags) __weak __ksym;
     extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_=
id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
     extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, stru=
ct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
    @@ -117428,10 +117506,8 @@
     extern void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__=
iter, u64 vtime) __weak __ksym;
     extern bool scx_bpf_dsq_move_to_local(u64 dsq_id) __weak __ksym;
     extern bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter=
, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
    -extern s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __weak __ksym;
     extern void scx_bpf_dump_bstr(char *fmt, long long unsigned int *dat=
a, u32 data__sz) __weak __ksym;
     extern void scx_bpf_error_bstr(char *fmt, long long unsigned int *da=
ta, u32 data__sz) __weak __ksym;
    -extern void scx_bpf_events(struct scx_event_stats *events, size_t ev=
ents__sz) __weak __ksym;
     extern void scx_bpf_exit_bstr(s64 exit_code, char *fmt, long long un=
signed int *data, u32 data__sz) __weak __ksym;
     extern const struct cpumask *scx_bpf_get_idle_cpumask(void) __weak _=
_ksym;
     extern const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)=
 __weak __ksym;

Then I checked the difference between BTFs, and found that there is no
DECL_TAG 'bpf_kfunc' produced for the affected functions:

    $ diff -u vmlinux.btf.out vmlinux_ubsan.btf.out | grep -C5 cgroup_anc=
estor
    +[52749] FUNC 'bpf_cgroup_acquire' type_id=3D52748 linkage=3Dstatic
    +[52750] DECL_TAG 'bpf_kfunc' type_id=3D52749 component_idx=3D-1
    +[52751] FUNC_PROTO '(anon)' ret_type_id=3D426 vlen=3D2
            'cgrp' type_id=3D426
            'level' type_id=3D21
    -[52681] FUNC 'bpf_cgroup_ancestor' type_id=3D52680 linkage=3Dstatic
    -[52682] DECL_TAG 'bpf_kfunc' type_id=3D52681 component_idx=3D-1
    -[52683] FUNC_PROTO '(anon)' ret_type_id=3D3987 vlen=3D2
    +[52752] FUNC 'bpf_cgroup_ancestor' type_id=3D52751 linkage=3Dstatic
    +[52753] FUNC_PROTO '(anon)' ret_type_id=3D3987 vlen=3D2
            'attach_type' type_id=3D1767
            'attach_btf_id' type_id=3D34
    -[52684] FUNC 'bpf_cgroup_atype_find' type_id=3D52683 linkage=3Dstati=
c
    -[52685] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D2

Which is clearly wrong and suggests a bug.

After some debugging, I found that the problem is in
btf_encoder__find_function(), and more specifically in
the comparator used for bsearch and qsort.

   static int functions_cmp(const void *_a, const void *_b)
   {
   	const struct elf_function *a =3D _a;
   	const struct elf_function *b =3D _b;

   	/* if search key allows prefix match, verify target has matching
   	 * prefix len and prefix matches.
   	 */
   	if (a->prefixlen && a->prefixlen =3D=3D b->prefixlen)
   		return strncmp(a->name, b->name, b->prefixlen);
   	return strcmp(a->name, b->name);
   }

For this particular vmlinux that I compiled,
btf_encoder__find_function("bpf_cgroup_ancestor", prefixlen=3D0) returns
NULL, even though there is an elf_function struct for
bpf_cgroup_ancestor in the table.

The reason for it is that bsearch() happens to hit
"bpf_cgroup_ancestor.cold" in the table first.
strcmp("bpf_cgroup_ancestor", "bpf_cgroup_ancestor.cold)") gives a
negative value, but bpf_cgroup_ancestor entry is stored in the other
direction in the table.

This is surprising at the first glance, because we use the same
functions_cmp both for search and for qsort.

But as it turns we are actually using two different comparators within
functions_cmp(): we set key.prefixlen=3D0 for exact match and when it's
non-zero we search for prefix match. When sorting the table, there are
no entries with prefixlen=3D0, so the order of elements is not exactly
right for the bsearch().

That's a nasty bug, but as far as I understand, all this complexity is
unnecessary in case of '.cold' suffix, because they simply are not
supposed to be in the elf_functions table: it's usually just a piece
of a target function.

There are a couple of ways this particular bug could be fixed
(filtering out .cold symbols, for example). But I think this bug and
the problem Jiri is trying to solve stems from the fact that one
function name, which is an identifier the users care about the most,
may be associated with many ELF symbols and/or addresses.

What is clear to me in the context of pahole's BTF encoding is that we
want elf_functions table to only have a single entry per name (where
name is an actual name that might be referred to by users, not an ELF
sym name), and have a deterministic mechanism for selecting one (or
none) func from many at the time of processing ELF data.

The current implementation is just buggy in this regard.

I am not aware of long term plans for addressing this, though it looks
like this was discussed before. I'd appreciate if you share any
relevant threads.

Thanks.


>=20
>=20I think we discussed this issue some time ago, but I'm not sure what
> the proposal was at the end (function address stored in BTF?)
>=20
>=20this change is to make sure there are no duplicate functions in BTF
> that could cause this confusion.. rather than bad result, let's deny
> the attach for such function
>=20
>=20jirka
>=20
>=20
>>
>> ?
>>
>>> [1] https://lore.kernel.org/bpf/20250710070835.260831-1-dongml2@china=
telecom.cn/
>>> Reported-by: Menglong Dong <menglong8.dong@gmail.com>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>
>>> Alan,
>>> I'd like to test this in the pahole CI, is there a way to manualy tri=
gger it?
>>>
>>
>> Easiest way is to base from pahole's next branch and push to a github
>> repo; the tests will run as actions there. I've just merged the functi=
on
>> comparison work so that will be available if you base/sync a branch on
>> next from git.kernel.org/pub/scm/devel/pahole/pahole.git/ . Thanks!
>>
>> Alan
>>
>>
>>> thanks,
>>> jirka
>>>
>>>
>>> ---
>>>   btf_encoder.c | 37 +++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 16739066caae..a25fe2f8bfb1 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -99,6 +99,7 @@ struct elf_function {
>>>   	size_t		prefixlen;
>>>   	bool		kfunc;
>>>   	uint32_t	kfunc_flags;
>>> +	unsigned long	addr;
>>>   };
>>>=20=20=20
>>>=20  struct elf_secinfo {
>>> @@ -1469,6 +1470,7 @@ static void elf_functions__collect_function(str=
uct elf_functions *functions, GEl
>>>=20=20=20
>>>=20  	func =3D &functions->entries[functions->cnt];
>>>   	func->name =3D name;
>>> +	func->addr =3D sym->st_value;
>>>   	if (strchr(name, '.')) {
>>>   		const char *suffix =3D strchr(name, '.');
>>>=20=20=20
>>>=20@@ -2143,6 +2145,40 @@ int btf_encoder__encode(struct btf_encoder *=
encoder, struct conf_load *conf)
>>>   	return err;
>>>   }
>>>=20=20=20
>>>=20+/*
>>> + * Remove name duplicates from functions->entries that have
>>> + * at least 2 different addresses.
>>> + */
>>> +static void functions_remove_dups(struct elf_functions *functions)
>>> +{
>>> +	struct elf_function *n =3D &functions->entries[0];
>>> +	bool matched =3D false, diff =3D false;
>>> +	int i, j;
>>> +
>>> +	for (i =3D 0, j =3D 1; i < functions->cnt && j < functions->cnt; i+=
+, j++) {
>>> +		struct elf_function *a =3D &functions->entries[i];
>>> +		struct elf_function *b =3D &functions->entries[j];
>>> +
>>> +		if (!strcmp(a->name, b->name)) {
>>> +			matched =3D true;
>>> +			diff |=3D a->addr !=3D b->addr;
>>> +			continue;
>>> +		}
>>> +
>>> +		/*
>>> +		 * Keep only not-matched entries and last one of the matched/dupli=
cates
>>> +		 * ones if all of the matched entries had the same address.
>>> +		 **/
>>> +		if (!matched || !diff)
>>> +			*n++ =3D *a;
>>> +		matched =3D diff =3D false;
>>> +	}
>>> +
>>> +	if (!matched || !diff)
>>> +		*n++ =3D functions->entries[functions->cnt - 1];
>>> +	functions->cnt =3D n - &functions->entries[0];
>>> +}
>>> +
>>>   static int elf_functions__collect(struct elf_functions *functions)
>>>   {
>>>   	uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
>>> @@ -2168,6 +2204,7 @@ static int elf_functions__collect(struct elf_fu=
nctions *functions)
>>>=20=20=20
>>>=20  	if (functions->cnt) {
>>>   		qsort(functions->entries, functions->cnt, sizeof(*functions->entr=
ies), functions_cmp);
>>> +		functions_remove_dups(functions);
>>>   	} else {
>>>   		err =3D 0;
>>>   		goto out_free;
>>

