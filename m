Return-Path: <bpf+bounces-46422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2169EA034
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 21:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883AD166541
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E2319ABAB;
	Mon,  9 Dec 2024 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foPj6UMV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF611957FC;
	Mon,  9 Dec 2024 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733775837; cv=none; b=Wn9z8wR3tKhNByTNerGDocXDwRqK1H9UST1FDlEsB8o4oasTODmChzvVOc7QrSj+Bbp5XtlP5VEo+TQ6oPNDHr2GtT2Us2FI+YFyT57TLZwSriBHyCq6h1UWFvF1iVH2idNCC74E6QOSb4DmQ0t3IqSU1pFWF+zbGUUcdIiVZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733775837; c=relaxed/simple;
	bh=JFKpTW00y3iE12soUkt/JIG9Dy7GjwoxQwOBw9tZfds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmoxQtW5Wk9SoBYk2BZXyou6SuZJwMeDQyeQltyrCRgbXn4LWU/rEtHLlzAupwBqWH97Uv/+uXiO/n2YXUD1pQ+RYs90NjmWTDbYppsVxF+GW9e0rtwiJ8nfIKYNagnycBulbZh6OfVgoE7SBUxWMnaAzlkzLhSas0rmfsIltx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foPj6UMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A03C4CEE1;
	Mon,  9 Dec 2024 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733775837;
	bh=JFKpTW00y3iE12soUkt/JIG9Dy7GjwoxQwOBw9tZfds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foPj6UMVsqms2pAjpj+7R4laV9r0KTvwUCcJgnU88O7h7P4F9MiT8zsDi5Cwo/8CI
	 m3nawIvU8OJOdkYjjkcu1UzNl3+p/PAFqvBrDUfgC02ROEQZwq4IEHR7GyfZg2XvE+
	 9runmfqo7CtIHBIGYiNnWPIvOoBaGQTCquw9fJXprppPtJCENh+uQE2NVT/Oaq2fps
	 xE1f/GpbmSJGn6pDGYpNEvD2gPHCMfPnvInLJEC93vP27uSSHz83DMNsFia/M1ZYmT
	 faE+eTcCplEEW0j8I40ikxj287xpkJ4kKfJQWpJA5BjqJnh84Tvnht7PuDddLLK4Rb
	 BiBs2juGYYG0w==
Date: Mon, 9 Dec 2024 17:23:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 2/4] perf lock contention: Run BPF slab cache iterator
Message-ID: <Z1dRyiruUl1Xo45O@x1>
References: <20241108061500.2698340-1-namhyung@kernel.org>
 <20241108061500.2698340-3-namhyung@kernel.org>
 <Z1ccoNOl4Z8c5DCz@x1>
 <Z1cdDzXe4QNJe8jL@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1cdDzXe4QNJe8jL@x1>

On Mon, Dec 09, 2024 at 01:38:39PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Dec 09, 2024 at 01:36:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Nov 07, 2024 at 10:14:57PM -0800, Namhyung Kim wrote:
> > > Recently the kernel got the kmem_cache iterator to traverse metadata of
> > > slab objects.  This can be used to symbolize dynamic locks in a slab.

> > > The new slab_caches hash map will have the pointer of the kmem_cache as
> > > a key and save the name and a id.  The id will be saved in the flags
> > > part of the lock.

> > Trying to fix this 
> 
> So you have that struct in tools/perf/util/bpf_skel/vmlinux/vmlinux.h,
> but then, this kernel is old and doesn't have the kmem_cache iterator,
> so using the generated vmlinux.h will fail the build.

I tried passing the right offset to the iterator so as not to try to use
a type that isn't in vmlinux.h generated from the old kernel BTF:

+++ b/tools/perf/util/bpf_lock_contention.c
@@ -52,7 +52,7 @@ static void check_slab_cache_iter(struct lock_contention *con)
                pr_debug("slab cache iterator is not available: %d\n", ret);
                goto out;
        } else {
-               const struct btf_member *s = __btf_type__find_member_by_name(btf, ret, "s");
+               const struct btf_member *s = __btf_type__find_unnamed_union_with_member_by_name(btf, ret, "s");
 
                if (s == NULL) {
                        skel->rodata->slab_cache_iter_member_offset = -1;
@@ -60,7 +60,9 @@ static void check_slab_cache_iter(struct lock_contention *con)
                        goto out;
                }
 
                skel->rodata->slab_cache_iter_member_offset = s->offset / 8; // bits -> bytes
+               pr_debug("slab cache iterator kmem_cache pointer offset: %d\n",
+                        skel->rodata->slab_cache_iter_member_offset);
        }


but the verifier doesn't like that:

; struct kmem_cache *s = slab_cache_iter_member_offset < 0 ? NULL : @ lock_contention.bpf.c:615
12: (7b) *(u64 *)(r10 -8) = r2        ; R2_w=ctx(off=8) R10=fp0 fp-8_w=ctx(off=8)
; if (s == NULL) @ lock_contention.bpf.c:619
13: (15) if r1 == 0x0 goto pc+22      ; R1=ctx()
; d.id = ++slab_cache_id << LCB_F_SLAB_ID_SHIFT; @ lock_contention.bpf.c:622
14: (18) r1 = 0xffffc14bcde3a014      ; R1_w=map_value(map=lock_con.bss,ks=4,vs=40,off=20)
16: (61) r3 = *(u32 *)(r1 +0)         ; R1_w=map_value(map=lock_con.bss,ks=4,vs=40,off=20) R3_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
17: (07) r3 += 1                      ; R3_w=scalar(smin=umin=1,smax=umax=0x100000000,var_off=(0x0; 0x1ffffffff))
18: (63) *(u32 *)(r1 +0) = r3         ; R1_w=map_value(map=lock_con.bss,ks=4,vs=40,off=20) R3_w=scalar(smin=umin=1,smax=umax=0x100000000,var_off=(0x0; 0x1ffffffff))
19: (67) r3 <<= 16                    ; R3_w=scalar(smin=umin=0x10000,smax=umax=0x1000000000000,smax32=0x7fff0000,umax32=0xffff0000,var_off=(0x0; 0x1ffffffff0000))
20: (63) *(u32 *)(r10 -40) = r3       ; R3_w=scalar(smin=umin=0x10000,smax=umax=0x1000000000000,smax32=0x7fff0000,umax32=0xffff0000,var_off=(0x0; 0x1ffffffff0000)) R10=fp0 fp-40=????scalar(smin=umin=0x10000,smax=umax=0x1000000000000,smax32=0x7fff0000,umax32=0xffff0000,var_off=(0x0; 0x1ffffffff0000))
; bpf_probe_read_kernel_str(d.name, sizeof(d.name), s->name); @ lock_contention.bpf.c:623
21: (79) r3 = *(u64 *)(r2 +96)
dereference of modified ctx ptr R2 off=8 disallowed
processed 19 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'slab_cache_iter': failed to load: -EACCES
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -EACCES
Failed to load lock-contention BPF skeleton
lock contention BPF setup failed
root@number:~# 

and additionally the type is not like the one you added to the barebones
vmlinux.h:

⬢ [acme@toolbox perf-tools-next]$ git show d82e2e170d1c756b | grep 'struct bpf_iter__kmem_cache {' -A3
+struct bpf_iter__kmem_cache {
+	struct kmem_cache *s;
+} __attribute__((preserve_access_index));
+
⬢ [acme@toolbox perf-tools-next]$

But:

⬢ [acme@toolbox perf-tools-next]$ uname -a
Linux toolbox 6.13.0-rc2 #1 SMP PREEMPT_DYNAMIC Mon Dec  9 12:33:35 -03 2024 x86_64 GNU/Linux
⬢ [acme@toolbox perf-tools-next]$ pahole bpf_iter__kmem_cache
struct bpf_iter__kmem_cache {
	union {
		struct bpf_iter_meta * meta;             /*     0     8 */
	};                                               /*     0     8 */
	union {
		struct kmem_cache * s;                   /*     8     8 */
	};                                               /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};

⬢ [acme@toolbox perf-tools-next]$

Do CO-RE handle this?

- Arnaldo

