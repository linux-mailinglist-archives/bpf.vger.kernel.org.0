Return-Path: <bpf+bounces-46431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100F9EA243
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13725164BFC
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4FE19E82A;
	Mon,  9 Dec 2024 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxGuMlfB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644919884C;
	Mon,  9 Dec 2024 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785251; cv=none; b=LImioLvBHoBSwxOyGGSaiw9JkYA2RmetmU14x5ILS1hH2nhe3QNB7tbMxS7FkB9QABcsq+ckPuNLgFxBJQC37Es/EVx1jG6OP/Jh66QxdEU3teEiJE1CZxWw0O/EUnz1vFnJt2lsvvApDH2R878O545b1awcrp5ZSbXyPoEcgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785251; c=relaxed/simple;
	bh=elYk55NDhAKqhse8FxLZo1SmGQ8M2MoLwtBE/+Rkzpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOdQCM8MKFYVV+dEl2o/vO4KjXjIBhULwtsmME0f8E/KD+W+OobrwCIEU0l6inEckNwXUpQNH8KTLi2JW7LTfKYy6vcWCb0LqYJ+kp6Db3CzbBrgzsNr41Ox+pZmE24Cvksg7edh+JZz6Sbi4ZiE7a8ZxOqVkitMyau3+qccw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxGuMlfB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so3966167a12.0;
        Mon, 09 Dec 2024 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733785249; x=1734390049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVwcZR0vEQf+lGLOIYoDvUdbgkf3uRnNWAqEvhym4Zo=;
        b=ZxGuMlfBg5tXrfDWPPVAfWzJlFsC6DtXQ0/17ui7cwWhBvuvSHuJdGlW4/qiljAv63
         rm2EjvxjgVwwMkE9W03nsfBpOT+GlEYVwzfnstLVECcDvPpUT4S/sRMguQtT5ayVpUjb
         PT8pVe/3EBOrsjFcm0WANnTJNAqWxueB14UF63QH/OJp4ir/Y6UC9sCvUUqol1jyumEG
         3h384duAtNCHhLeAMIGHHToPJQPEcP5JG+ej9NeSD/VTf20skMsgextlirhW7/N5Q1I4
         FjXTwZe637L1udabDvUlv13l4uJ+2kyFC23+ytRiXV0pQdUL9SUgAUlDikAZovsk1o+2
         CwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733785249; x=1734390049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVwcZR0vEQf+lGLOIYoDvUdbgkf3uRnNWAqEvhym4Zo=;
        b=C6fY+468Y4Yo18ww/llsxeeHeeyfySfyJonmggp5vxORGSPvwMd4jfBayFIWe2G9KH
         gFniCtaA88PE2hwSjzxEU7auxh9NmrrLOHI21wYiO1ozjIxa6YD9H0nfU8z4+AqvoiHx
         sv2vogT4qO/D6iqkat+b3QtmOOwZ4TMIkzs2fTtvZHHpMnEBOCJBmFKKZrYFf2LhvLjM
         FjVOkMJiAaVPIfVDemixHbzFFqL3fj8P8PuzxdsX4Wifo4ABH81Aq/EHlCsxgvh4TMhV
         khF6lrYatxrN6WONxK6L/D6SO2iilWcnAaYWZ/i3pgPvLbhYytfCo7pVzJcWnyLRrr7J
         yJhw==
X-Forwarded-Encrypted: i=1; AJvYcCVKBV77UJzUCB4kQsFZpE1BQ6wKOHy47g5cJVKNQCxoRGFO6cBjKqiVXWRcvEWScFYR57uGULGARVwvBBF9iKjr6g==@vger.kernel.org, AJvYcCVNCjaz9kmTdpm9XZdD9LJXFdxqpfL4hiUuVLp9Npb1JCq+NIKOWuAdP1CPEmArYMhrOzESfApBb+NW22f/@vger.kernel.org, AJvYcCXjp2T51euIsf4EstNuGIEaKVbaHVM4Grh6bT/XDh6JXvAmd4mveHggDygdtapqzu5M7EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSWxrlf+3GsVpPWAl6JRkbnppDRfC85CAk/mMVvpkcB22C8MK
	Rq4M8KEfeEeiWSQZacLMLlTAiY5H03iJih2V8JwTSNQ9lECQDvt5slR1eCHT1dFTfkZgV+NyJfI
	pD13P1VXvJMDbduUOADF/+Pi0yrQ=
X-Gm-Gg: ASbGnct9/YwtRFrW8JWEGxa7m72i6o78eIohBrcpn6uF+BJZJ5ex+UCDrWFAz3q3x4E
	aDWKZTYvfSmgiHrlqETClpOK1GbR/PcOpI6NskylChZSPAWUOEnc=
X-Google-Smtp-Source: AGHT+IFCLud9Tl/llTWYjfJbJI8At2PeiwsxUEH2EXyTvY2DsuqR+rP2NvVtJCxzQroYZBAKgUM4v2nqzLuP/R7sFzk=
X-Received: by 2002:a05:6a20:7348:b0:1e0:c50c:9842 with SMTP id
 adf61e73a8af0-1e1871291d0mr25062081637.31.1733785248824; Mon, 09 Dec 2024
 15:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108061500.2698340-1-namhyung@kernel.org> <20241108061500.2698340-3-namhyung@kernel.org>
 <Z1ccoNOl4Z8c5DCz@x1> <Z1cdDzXe4QNJe8jL@x1> <Z1dRyiruUl1Xo45O@x1>
In-Reply-To: <Z1dRyiruUl1Xo45O@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Dec 2024 15:00:36 -0800
Message-ID: <CAEf4Bza5B9rSX7cw4K0iC-gW+OeEATLCcQ=6KGfmuxfJ2XOhvA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf lock contention: Run BPF slab cache iterator
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:23=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Dec 09, 2024 at 01:38:39PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Dec 09, 2024 at 01:36:52PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Thu, Nov 07, 2024 at 10:14:57PM -0800, Namhyung Kim wrote:
> > > > Recently the kernel got the kmem_cache iterator to traverse metadat=
a of
> > > > slab objects.  This can be used to symbolize dynamic locks in a sla=
b.
>
> > > > The new slab_caches hash map will have the pointer of the kmem_cach=
e as
> > > > a key and save the name and a id.  The id will be saved in the flag=
s
> > > > part of the lock.
>
> > > Trying to fix this
> >
> > So you have that struct in tools/perf/util/bpf_skel/vmlinux/vmlinux.h,
> > but then, this kernel is old and doesn't have the kmem_cache iterator,
> > so using the generated vmlinux.h will fail the build.
>
> I tried passing the right offset to the iterator so as not to try to use
> a type that isn't in vmlinux.h generated from the old kernel BTF:
>
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -52,7 +52,7 @@ static void check_slab_cache_iter(struct lock_contentio=
n *con)
>                 pr_debug("slab cache iterator is not available: %d\n", re=
t);
>                 goto out;
>         } else {
> -               const struct btf_member *s =3D __btf_type__find_member_by=
_name(btf, ret, "s");
> +               const struct btf_member *s =3D __btf_type__find_unnamed_u=
nion_with_member_by_name(btf, ret, "s");
>
>                 if (s =3D=3D NULL) {
>                         skel->rodata->slab_cache_iter_member_offset =3D -=
1;
> @@ -60,7 +60,9 @@ static void check_slab_cache_iter(struct lock_contentio=
n *con)
>                         goto out;
>                 }
>
>                 skel->rodata->slab_cache_iter_member_offset =3D s->offset=
 / 8; // bits -> bytes
> +               pr_debug("slab cache iterator kmem_cache pointer offset: =
%d\n",
> +                        skel->rodata->slab_cache_iter_member_offset);
>         }
>
>
> but the verifier doesn't like that:
>
> ; struct kmem_cache *s =3D slab_cache_iter_member_offset < 0 ? NULL : @ l=
ock_contention.bpf.c:615
> 12: (7b) *(u64 *)(r10 -8) =3D r2        ; R2_w=3Dctx(off=3D8) R10=3Dfp0 f=
p-8_w=3Dctx(off=3D8)
> ; if (s =3D=3D NULL) @ lock_contention.bpf.c:619
> 13: (15) if r1 =3D=3D 0x0 goto pc+22      ; R1=3Dctx()
> ; d.id =3D ++slab_cache_id << LCB_F_SLAB_ID_SHIFT; @ lock_contention.bpf.=
c:622
> 14: (18) r1 =3D 0xffffc14bcde3a014      ; R1_w=3Dmap_value(map=3Dlock_con=
.bss,ks=3D4,vs=3D40,off=3D20)
> 16: (61) r3 =3D *(u32 *)(r1 +0)         ; R1_w=3Dmap_value(map=3Dlock_con=
.bss,ks=3D4,vs=3D40,off=3D20) R3_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffff=
ff,var_off=3D(0x0; 0xffffffff))
> 17: (07) r3 +=3D 1                      ; R3_w=3Dscalar(smin=3Dumin=3D1,s=
max=3Dumax=3D0x100000000,var_off=3D(0x0; 0x1ffffffff))
> 18: (63) *(u32 *)(r1 +0) =3D r3         ; R1_w=3Dmap_value(map=3Dlock_con=
.bss,ks=3D4,vs=3D40,off=3D20) R3_w=3Dscalar(smin=3Dumin=3D1,smax=3Dumax=3D0=
x100000000,var_off=3D(0x0; 0x1ffffffff))
> 19: (67) r3 <<=3D 16                    ; R3_w=3Dscalar(smin=3Dumin=3D0x1=
0000,smax=3Dumax=3D0x1000000000000,smax32=3D0x7fff0000,umax32=3D0xffff0000,=
var_off=3D(0x0; 0x1ffffffff0000))
> 20: (63) *(u32 *)(r10 -40) =3D r3       ; R3_w=3Dscalar(smin=3Dumin=3D0x1=
0000,smax=3Dumax=3D0x1000000000000,smax32=3D0x7fff0000,umax32=3D0xffff0000,=
var_off=3D(0x0; 0x1ffffffff0000)) R10=3Dfp0 fp-40=3D????scalar(smin=3Dumin=
=3D0x10000,smax=3Dumax=3D0x1000000000000,smax32=3D0x7fff0000,umax32=3D0xfff=
f0000,var_off=3D(0x0; 0x1ffffffff0000))
> ; bpf_probe_read_kernel_str(d.name, sizeof(d.name), s->name); @ lock_cont=
ention.bpf.c:623
> 21: (79) r3 =3D *(u64 *)(r2 +96)
> dereference of modified ctx ptr R2 off=3D8 disallowed
> processed 19 insns (limit 1000000) max_states_per_insn 0 total_states 0 p=
eak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'slab_cache_iter': failed to load: -EACCES
> libbpf: failed to load object 'lock_contention_bpf'
> libbpf: failed to load BPF skeleton 'lock_contention_bpf': -EACCES
> Failed to load lock-contention BPF skeleton
> lock contention BPF setup failed
> root@number:~#
>
> and additionally the type is not like the one you added to the barebones
> vmlinux.h:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ git show d82e2e170d1c756b | gre=
p 'struct bpf_iter__kmem_cache {' -A3
> +struct bpf_iter__kmem_cache {
> +       struct kmem_cache *s;
> +} __attribute__((preserve_access_index));
> +
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> But:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ uname -a
> Linux toolbox 6.13.0-rc2 #1 SMP PREEMPT_DYNAMIC Mon Dec  9 12:33:35 -03 2=
024 x86_64 GNU/Linux
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ pahole bpf_iter__kmem_cache
> struct bpf_iter__kmem_cache {
>         union {
>                 struct bpf_iter_meta * meta;             /*     0     8 *=
/
>         };                                               /*     0     8 *=
/
>         union {
>                 struct kmem_cache * s;                   /*     8     8 *=
/
>         };                                               /*     8     8 *=
/
>
>         /* size: 16, cachelines: 1, members: 2 */
>         /* last cacheline: 16 bytes */
> };
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> Do CO-RE handle this?
>

I don't know exactly what the problem you are running into is, but
yes, BPF CO-RE allows handling missing fields, incompatible field type
changes, field renames, etc. All without having to break a
compilation. See [0] (and one subsection after that) for
"documentation" and examples.

  [0] https://nakryiko.com/posts/bpf-core-reference-guide/#defining-own-co-=
re-relocatable-type-definitions

> - Arnaldo

