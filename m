Return-Path: <bpf+bounces-64027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D27B0D792
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 12:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFB63ADEDE
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589F2E11BC;
	Tue, 22 Jul 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj2qLMlv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC42F41;
	Tue, 22 Jul 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181695; cv=none; b=M/oNDA0KPyvMoccPsLaPAbukzBK1rwhdAO/iOPLDoc4km4bvU+oEpFoGotIKf3XuOM+PD4kDaHcbejgsq7BX4ypCnuCoXHAJPMz/Tp/k/VMRsOMaCwXPw+hpCHcIkyOBgukW5H4qzeniq2y72r1QKe+XAfqIB/CBUeqyFnuJ/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181695; c=relaxed/simple;
	bh=qQI8q1mADsL7bmphkINZZwkzwsAlL6We2Kj8Iz6IRNc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cley8J1lcaY0S6S37wFlOsPR5WvZHfANCTnHG2RcSri6R3paLuCuOTW4DYpSMZ7ea7wnYhoXEysEOftbpFBp5uE373p57DFfoj2YuWIDLISuff6oxOJMk+KyoIbp7WmGoyl+lNEs/Jyy5qj2TYZCwv0rOL+12G9lrHYF5TPFPpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj2qLMlv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0c4945c76so722339166b.3;
        Tue, 22 Jul 2025 03:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753181691; x=1753786491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mhCA0zutR4AMaHFF+M2VBWAZJrLfejPHqtvZNphOOKQ=;
        b=Jj2qLMlvLZUYZDKNoJDEGjxJCLVNpf0UouXlOOcNTUhfnQQ3lfbyjpA7hw5YxIut1d
         3MUMe5fogRt4uA29VOE1MmGWnw2iLgjJrrk4K/XhMoSfO7Rp44Ueni1Edq6F5HDYcCMP
         qdWMK9JkUXaOTyxnZoYXxsEgdQGCeZ9tfofOJgiM4tH6C+Y7kE+vnKKF6p+oCJcCLm/K
         Ea1Wq+HohH+nsOH92jkDNDvGGlME/UDoHBnSVTfTfgeI6e15sDyk9Pxy42p2Fa1lgUWX
         459jeO5WJCgBgDRdyGqTJjsioQgyfURQutVA6yMvy+v2LphMtWUxt/Hb0r990hdlDUe3
         npfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753181691; x=1753786491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhCA0zutR4AMaHFF+M2VBWAZJrLfejPHqtvZNphOOKQ=;
        b=hPzb8lrWGA4ameceaQ8tMwpgT1pyrI7AjzNz/CW2ZWUCTeOCsjmL0ZgxO5vMfgjgdW
         So4t+HQT29bHqHYFMspohX+Vn0WZOieflezprj3Ka3FrVDRpeIg/8Q+VC1TroCE1hnXR
         gAmKSvORIBco7Vi1gIOorrSl78SQBSoFJnJXJXCSeRW0SkfCIP1XU4nrruoHIL8Ek7cR
         S03XyLWUkXrP9X642KgTBDmejC79sUGrnEoGa+/bJMPmjpZRTvfHf8mlInSTa+Ud2vZF
         T7d7/YH8KY0fJ4xVEXNsb5W5YO5Vmnh1pf9QdcCM6LQmESzMhmDMtze2euxrolwirtpy
         S2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCzVhIejdxFdMMwPFmbsVBKoy3Z595i2yahBQMi5Q2pgfEn8ZomPUg2KZh1zBv1kup3Vs=@vger.kernel.org, AJvYcCXyhz+zEVhinw/HuX+HXgEZiugfVlOSGpWrz08+rmglOigjb3s7svoBN5rXOystko8ec9OkjX9deA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9PffqzB5iS2iyB1rs3GrLrv540zpNE46Wr9sADMWAB2wYgZX
	QuJY9Xux4CALvqo2+eDJcmbDmGSu7r91KQz1610CEY30bExkl6w1df6H
X-Gm-Gg: ASbGncvVOCF+GVFI83L+rF3pQ2uMCBBW+qXy5mHPrLgXyUTA7ITXKTt2eQBYDc8/NyM
	LzIofD5Fn4hx5UrCQEa77QHOMAFW+K7OkQVSAfm8nkQeMED9uqzmAFTAjwGzpgmvuirGCDqAocG
	wc0oI/EqOkzp8qWEgKZAcQ8zhnyuiHxgdxDQqHfl8/SnSmzv0tCANkbatuLWiLePBCTqQ80n8NK
	ycyPPw0vHgO8HeZhFD2S6+9eJv0ip9KNwoJsJC31MRA2dM9cby+ouILPk5HfBhuJ9BZdTyVRrKr
	qvGONPhGv06VjmHoy+c3U2p54nqyLHPCWrb/m0i4a13LTeGz0v8DrxFUB4nM+fxxWStKhWfO8A5
	Ru49E5S0a
X-Google-Smtp-Source: AGHT+IEzeNgEiIECYRogyLor3HZxeMXxHYeFPZ0Y56Fmj5/i1ss4TH9PKf4vQ8ZQH0KAU+C6fuDJvQ==
X-Received: by 2002:a17:907:3f08:b0:ade:36e4:ceba with SMTP id a640c23a62f3a-ae9ce17c782mr2126705166b.52.1753181690981;
        Tue, 22 Jul 2025 03:54:50 -0700 (PDT)
Received: from krava ([173.38.220.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7d7a4sm847617266b.116.2025.07.22.03.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 03:54:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 22 Jul 2025 12:54:48 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
Message-ID: <aH9t-GjmPga5YQmv@krava>
References: <20250717152512.488022-1-jolsa@kernel.org>
 <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com>
 <aH5OW0rtSuMn1st1@krava>
 <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev>

On Mon, Jul 21, 2025 at 11:27:31PM +0000, Ihor Solodrai wrote:
> On 7/21/25 7:27 AM, Jiri Olsa wrote:
> > On Mon, Jul 21, 2025 at 12:41:00PM +0100, Alan Maguire wrote:
> >> On 17/07/2025 16:25, Jiri Olsa wrote:
> >>> Menglong reported issue where we can have function in BTF which has
> >>> multiple addresses in kallsysm [1].
> >>>
> >>> Rather than filtering this in runtime, let's teach pahole to remove
> >>> such functions.
> >>>
> >>> Removing duplicate records from functions entries that have more
> >>> at least one different address. This way btf_encoder__find_function
> >>> won't find such functions and they won't be added in BTF.
> >>>
> >>> In my setup it removed 428 functions out of 77141.
> >>>
> >>
> >> Is such removal necessary? If the presence of an mcount annotation is
> >> the requirement, couldn't we just utilize
> >>
> >> /sys/kernel/tracing/available_filter_functions_addrs
> >>
> >> to map name to address safely? It identifies mcount-containing functions
> >> and some of these appear to be duplicates, for example there I see
> >>
> >> ffffffff8376e8b4 acpi_attr_is_visible
> >> ffffffff8379b7d4 acpi_attr_is_visible
> > 
> > for that we'd need new interface for loading fentry/fexit.. programs, right?
> > 
> > the current interface to get fentry/fexit.. attach address is:
> >    - user specifies function name, that translates to btf_id
> >    - in kernel that btf id translates back to function name
> >    - kernel uses kallsyms_lookup_name or find_kallsyms_symbol_value
> >      to get the address
> > 
> > so we don't really know which address user wanted in the first place
> 
> Hi Jiri, Alan.
> 
> I stumbled on a bug today which seems to be relevant to this
> discussion.
> 
> I tried building the kernel with KASAN and UBSAN, and that resulted in
> some kfuncs disappearing from vmlinux.h, triggering selftests/bpf
> compilation errors, for example:
> 
>       CLNG-BPF [test_progs-no_alu32] cgroup_read_xattr.bpf.o
>     progs/cgroup_read_xattr.c:127:13: error: call to undeclared function 'bpf_cgroup_ancestor'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       127 |         ancestor = bpf_cgroup_ancestor(cgrp, 1);
>           |                    ^

hi,
I tried that and tests build for me with KASAN and UBSAN,
both with gcc (15.1.1) and clang (22.0.0)

could you share your config?

> 
> Here is a piece of vmlinux.h diff between CONFIG_UBSAN=y/n:
> 
>     --- ./tools/testing/selftests/bpf/tools/include/vmlinux.h	2025-07-21 17:35:14.415733105 +0000
>     +++ ubsan_vmlinux.h	2025-07-21 17:33:10.455312623 +0000
>     @@ -117203,7 +117292,6 @@
>      extern int bpf_arena_reserve_pages(void *p__map, void __attribute__((address_space(1))) *ptr__ign, u32 page_cnt) __weak __ksym;
>      extern __bpf_fastcall void *bpf_cast_to_kern_ctx(void *obj) __weak __ksym;
>      extern struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp) __weak __ksym;
>     -extern struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __weak __ksym;
>      extern struct cgroup *bpf_cgroup_from_id(u64 cgid) __weak __ksym;
>      extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str, struct bpf_dynptr *value_p) __weak __ksym;
>      extern void bpf_cgroup_release(struct cgroup *cgrp) __weak __ksym;
>     @@ -117260,7 +117348,6 @@
>      extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p) __weak __ksym;
>      extern int bpf_dynptr_memset(struct bpf_dynptr *p, u32 offset, u32 size, u8 val) __weak __ksym;
>      extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __weak __ksym;
>     -extern void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset, void *buffer__opt, u32 buffer__szk) __weak __ksym;
>      extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset, void *buffer__opt, u32 buffer__szk) __weak __ksym;
>      extern int bpf_fentry_test1(int a) __weak __ksym;
>      extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str, struct bpf_dynptr *value_p) __weak __ksym;
>     @@ -117287,7 +117374,6 @@
>      extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;
>      extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
>      extern void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __weak __ksym;
>     -extern int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __weak __ksym;
>      extern struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __weak __ksym;
>      extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
>      extern int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task__nullable, unsigned int flags) __weak __ksym;
>     @@ -117373,11 +117459,8 @@
>      extern int bpf_strspn(const char *s__ign, const char *accept__ign) __weak __ksym;
>      extern int bpf_strstr(const char *s1__ign, const char *s2__ign) __weak __ksym;
>      extern struct task_struct *bpf_task_acquire(struct task_struct *p) __weak __ksym;
>     -extern struct task_struct *bpf_task_from_pid(s32 pid) __weak __ksym;
>     -extern struct task_struct *bpf_task_from_vpid(s32 vpid) __weak __ksym;
>      extern struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __weak __ksym;
>      extern void bpf_task_release(struct task_struct *p) __weak __ksym;
>     -extern long int bpf_task_under_cgroup(struct task_struct *task, struct cgroup *ancestor) __weak __ksym;
>      extern void bpf_throw(u64 cookie) __weak __ksym;
>      extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p, struct bpf_dynptr *sig_p, struct bpf_key *trusted_keyring) __weak __ksym;
>      extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>     @@ -117412,15 +117495,10 @@
>      extern u32 scx_bpf_cpuperf_cur(s32 cpu) __weak __ksym;
>      extern void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __weak __ksym;
>      extern s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __weak __ksym;
>     -extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
>     -extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __weak __ksym;
>      extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
>      extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>     -extern void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
>     -extern void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>      extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
>      extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>     -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>      extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __weak __ksym;
>      extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>      extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>     @@ -117428,10 +117506,8 @@
>      extern void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>      extern bool scx_bpf_dsq_move_to_local(u64 dsq_id) __weak __ksym;
>      extern bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>     -extern s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __weak __ksym;
>      extern void scx_bpf_dump_bstr(char *fmt, long long unsigned int *data, u32 data__sz) __weak __ksym;
>      extern void scx_bpf_error_bstr(char *fmt, long long unsigned int *data, u32 data__sz) __weak __ksym;
>     -extern void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __weak __ksym;
>      extern void scx_bpf_exit_bstr(s64 exit_code, char *fmt, long long unsigned int *data, u32 data__sz) __weak __ksym;
>      extern const struct cpumask *scx_bpf_get_idle_cpumask(void) __weak __ksym;
>      extern const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __weak __ksym;
> 
> Then I checked the difference between BTFs, and found that there is no
> DECL_TAG 'bpf_kfunc' produced for the affected functions:
> 
>     $ diff -u vmlinux.btf.out vmlinux_ubsan.btf.out | grep -C5 cgroup_ancestor
>     +[52749] FUNC 'bpf_cgroup_acquire' type_id=52748 linkage=static
>     +[52750] DECL_TAG 'bpf_kfunc' type_id=52749 component_idx=-1
>     +[52751] FUNC_PROTO '(anon)' ret_type_id=426 vlen=2
>             'cgrp' type_id=426
>             'level' type_id=21
>     -[52681] FUNC 'bpf_cgroup_ancestor' type_id=52680 linkage=static
>     -[52682] DECL_TAG 'bpf_kfunc' type_id=52681 component_idx=-1
>     -[52683] FUNC_PROTO '(anon)' ret_type_id=3987 vlen=2
>     +[52752] FUNC 'bpf_cgroup_ancestor' type_id=52751 linkage=static
>     +[52753] FUNC_PROTO '(anon)' ret_type_id=3987 vlen=2
>             'attach_type' type_id=1767
>             'attach_btf_id' type_id=34
>     -[52684] FUNC 'bpf_cgroup_atype_find' type_id=52683 linkage=static
>     -[52685] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
> 
> Which is clearly wrong and suggests a bug.
> 
> After some debugging, I found that the problem is in
> btf_encoder__find_function(), and more specifically in
> the comparator used for bsearch and qsort.
> 
>    static int functions_cmp(const void *_a, const void *_b)
>    {
>    	const struct elf_function *a = _a;
>    	const struct elf_function *b = _b;
> 
>    	/* if search key allows prefix match, verify target has matching
>    	 * prefix len and prefix matches.
>    	 */
>    	if (a->prefixlen && a->prefixlen == b->prefixlen)
>    		return strncmp(a->name, b->name, b->prefixlen);
>    	return strcmp(a->name, b->name);
>    }
> 
> For this particular vmlinux that I compiled,
> btf_encoder__find_function("bpf_cgroup_ancestor", prefixlen=0) returns
> NULL, even though there is an elf_function struct for
> bpf_cgroup_ancestor in the table.
> 
> The reason for it is that bsearch() happens to hit
> "bpf_cgroup_ancestor.cold" in the table first.
> strcmp("bpf_cgroup_ancestor", "bpf_cgroup_ancestor.cold)") gives a
> negative value, but bpf_cgroup_ancestor entry is stored in the other
> direction in the table.
> 
> This is surprising at the first glance, because we use the same
> functions_cmp both for search and for qsort.
> 
> But as it turns we are actually using two different comparators within
> functions_cmp(): we set key.prefixlen=0 for exact match and when it's
> non-zero we search for prefix match. When sorting the table, there are
> no entries with prefixlen=0, so the order of elements is not exactly
> right for the bsearch().
> 
> That's a nasty bug, but as far as I understand, all this complexity is
> unnecessary in case of '.cold' suffix, because they simply are not
> supposed to be in the elf_functions table: it's usually just a piece
> of a target function.
> 
> There are a couple of ways this particular bug could be fixed
> (filtering out .cold symbols, for example). But I think this bug and
> the problem Jiri is trying to solve stems from the fact that one
> function name, which is an identifier the users care about the most,
> may be associated with many ELF symbols and/or addresses.
> 
> What is clear to me in the context of pahole's BTF encoding is that we
> want elf_functions table to only have a single entry per name (where
> name is an actual name that might be referred to by users, not an ELF
> sym name), and have a deterministic mechanism for selecting one (or
> none) func from many at the time of processing ELF data.
> 
> The current implementation is just buggy in this regard.
> 
> I am not aware of long term plans for addressing this, though it looks
> like this was discussed before. I'd appreciate if you share any
> relevant threads.

I did some ill attempt to have function addresses in BTF but that never
took place.. I thought perhaps Alan took over that, but can't find any
evidence ;-)

jirka

