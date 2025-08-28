Return-Path: <bpf+bounces-66775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34DDB3920D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 05:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350DE465A3A
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEE281520;
	Thu, 28 Aug 2025 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQc5csC7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F327B4EE;
	Thu, 28 Aug 2025 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349978; cv=none; b=lbauG49c7b0gn2qrxH4J8il2Jx9p9frdsNy55B8vLPlYo5njWz1M0/WAMVmwlmfSXy2shT6s+vZs/6bASuPklJKkdFpX7PKbzJE0dRIsSkj6aIeOV8+VtvO8IjahxxBIzHjFJbevAc0Uvi6J9ED4U3uRG/VDdz2o9AXYIe6Hdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349978; c=relaxed/simple;
	bh=z9ygR8wZkcRHowqndwrws0uZ5+b9m7+gA89ywU3b2K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AODo2Oi8LerxPLyLAS6nz3kzJ8Sf5eUnljxqd8m526qFQH8UvVrIHSUwsenShssknusNH9oUU/MddPCah0T5bQf05+fn1YLX9KDuf/RxWhtnov1jdZAi4dyIQkN6InY00W5SwBA+ZxBKFaTfmROFR5ChM7lV73atAZ2+npe8nnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQc5csC7; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70def6089b2so5896356d6.1;
        Wed, 27 Aug 2025 19:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756349975; x=1756954775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t35FyPKwwdQ8g4j+/LU2AEGoNi4QA0Yjv85YIy0KfQQ=;
        b=hQc5csC7e1dFAuJUsQ8eqKM9oF2zlsDRFj7aoP3/l34IHKR833NAKVYS+az0lmQvp9
         2SdFb3pPltXd+oTvfhpcBrnbNqI5bf0He8bE+jSvsjmCntts4dfdiJNy1XJlGfcW5iPQ
         EAlGsKdkiWAU2OAYmEGJGciIhp9+7b54ztpqD5lg8WwEJnsrLz2oPh2cvv8Iwthrj3zA
         FO+pIx5W2iEibjHgZoWpIc+8fJKsXT8Vg92uxcgz84Gi5292xs+TfbCMVx41WSrMNIXB
         GpjIl1rddWWHaxNl6PaiucI3chVjgfxIta9tl9Ffr4DWsVnoyEdaGoYW9DVXINGaAZMQ
         eHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756349975; x=1756954775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t35FyPKwwdQ8g4j+/LU2AEGoNi4QA0Yjv85YIy0KfQQ=;
        b=EQNZWRyFBKgkuWzMzVnVWNP6KBjpNe7eg6P44plFQin/l5A2NH3qhs/d/1iK5SaiRK
         8IbDlaV7xLPTe5ChhsT+yFqi/2zk534nIRQUQfm7z8nMwlvRaxr+gWIewSs7y4jAuWJV
         BQcRJA53AsZ6ICq6cH2fGKMZxlMKYMnCVgH4OW/N6DiNvH10mSn39T8keNBVQnm1ExNo
         2jpceLKRgIfplXH3msO2Wk4ruLYEwSsQnDkmxMJK20BWy2qsPXwGY7qpBVvUS/227U/2
         /FIfiX2lPPOG5Aox3Jccc6FHic2lecTk9YQzV4oo8e6oSpMwg159ltnFMhoXKiF60PFD
         7DAA==
X-Forwarded-Encrypted: i=1; AJvYcCVB3/M30PL/HEDj3eP1UVa8QEwtq0IG/zBCGPzRlQUTomk//hu2p7uuxjnSDGJVHinn2YgJUdRIgTzP@vger.kernel.org, AJvYcCVStSskpq7dHi3vLKAm3ZrAfW0gTQP6ligZkeoOkQAll7PQLIG2ZE0wtB/IS4QsOhSlYpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YAwJXV1bsPMNSqTeGr898sK0/VHl71dncNKx7DFFDAeRGbTR
	llvWvH3fQvJMywLO7JosrcGBx5ovMgAHdgnaLdMtqEUkdryAlKxPw1qGKljH9qApCcHZJQLTW2d
	Hxbf3Y7ylwlvEsQiPzpxFk9/+D33zbvo=
X-Gm-Gg: ASbGncuHV4OSw1tRTm1B/Bp/iz0ynH5EnrLY1DzBfYkKTkuPLy3ePkYz9S8dIH5Nagu
	9jXSffLM0XsMOaZU/UpIeq8VjrdDTI8f1rSCocX7sWmPU0uU0iU4hFg33VrxFEcuVM38LfrGK0u
	0sb3jQCqK0rHCG/6RBwS4UW8bFlyBfHaCdzva42FBFNoWavt5l6hzU7yXXNjjlDrXxyKQqDuf2X
	ikaDOUjsscWpz7NYzO2ec2yyfny53vQATJ4a0TzT3uF+11Q+Ug=
X-Google-Smtp-Source: AGHT+IEy259srY+vu9FkWq6fUb184mC2kXtFB+ag+8ue7OGFzMwwHBeCZoroAVcUSsARAL1Fs9+m1BXRcIe+kdv66g0=
X-Received: by 2002:ad4:4ee9:0:b0:70d:bf1a:4703 with SMTP id
 6a1803df08f44-70dbf1a4950mr143947036d6.65.1756349974647; Wed, 27 Aug 2025
 19:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <06d7bde9-e3f8-45fd-9674-2451b980ef13@lucifer.local>
In-Reply-To: <06d7bde9-e3f8-45fd-9674-2451b980ef13@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Aug 2025 10:58:57 +0800
X-Gm-Features: Ac12FXytGU973HTwPFg_ZVzsdimnNmtB76eHLAUwx50b3G9QPYiVt4FHmqmoTK0
Message-ID: <CALOAHbA7wT_LF0Sr2jGWxKU52d-tmHt1sBBjM1koja64t1vi2Q@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 00/10] mm, bpf: BPF based THP order selection
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:14=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 26, 2025 at 03:19:38PM +0800, Yafang Shao wrote:
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Our production servers consistently configure THP to "never" due to
> > historical incidents caused by its behavior. Key issues include:
> > - Increased Memory Consumption
> >   THP significantly raises overall memory usage, reducing available mem=
ory
> >   for workloads.
> >
> > - Latency Spikes
> >   Random latency spikes occur due to frequent memory compaction trigger=
ed
> >   by THP.
> >
> > - Lack of Fine-Grained Control
> >   THP tuning is globally configured, making it unsuitable for container=
ized
> >   environments. When multiple workloads share a host, enabling THP with=
out
> >   per-workload control leads to unpredictable behavior.
> >
> > Due to these issues, administrators avoid switching to madvise or alway=
s
> > modes=E2=80=94unless per-workload THP control is implemented.
> >
> > To address this, we propose BPF-based THP policy for flexible adjustmen=
t.
> > Additionally, as David mentioned [0], this mechanism can also serve as =
a
> > policy prototyping tool (test policies via BPF before upstreaming them)=
.
>

Thank you for providing so many comments.  I'll take some time to go
through it carefully and will reply afterward.

> I think it's important to highlight here that we are exploring an _experi=
mental_
> implementation.

I will add it.

>
> >
> > Proposed Solution
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > As suggested by David [0], we introduce a new BPF interface:
>
> I do agree, to be clear, with this broad approach - that is, to provide t=
he
> minimum information that a reasonable decision can be made upon and to ke=
ep
> things as simple as we can.
>
> As per the THP cabal (I think? :) the general consensus was in line with
> this.

My testing in both test and production indicates the following
parameters are essential:
- mm_struct (associated with the THP allocation)
- vma_flags (VM_HUGEPAGE, VM_NOHUGEPAGE, or N/A)
- tva_type
- The requested THP orders bitmask

I will retain these four and remove @vma__nullable.

>
>
> >
> > /**
> >  * @get_suggested_order: Get the suggested THP orders for allocation
> >  * @mm: mm_struct associated with the THP allocation
> >  * @vma__nullable: vm_area_struct associated with the THP allocation (m=
ay be NULL)
> >  *                 When NULL, the decision should be based on @mm (i.e.=
, when
> >  *                 triggered from an mm-scope hook rather than a VMA-sp=
ecific
> >  *                 context).
>
> I'm a little wary of handing a VMA to BPF, under what locking would it be
> provided?

We cannot arbitrarily use members of the struct vm_area_struct because
they are untrusted pointers. The only trusted pointer is vma->vm_mm,
which can be accessed without holding any additional locks. For the
VMA itself, the caller at the callsite has already taken the necessary
locks, so we do not need to acquire them again.

My testing shows the @vma parameter is not needed. I will remove it in
the next update.

>
> >  *                 Must belong to @mm (guaranteed by the caller).
> >  * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma =
is NULL)
>
> Hmm this one is also a bit odd - why would these flags differ? Note that =
I will
> be changing the VMA flags to a bitmap relatively soon which may be larger=
 than
> the system word size.
>
> So 'handing around all the flags' is something we probably want to avoid.

Good suggestion. Since we specifically need to identify VM_HUGEPAGE or
VM_NOHUGEPAGE, I will add a new enum for clarity, bpf_thp_vma_type:

+enum bpf_thp_vma_type {
+       BPF_VM_NONE =3D 0,
+       BPF_VM_HUGEPAGE,        /* VM_HUGEPAGE */
+       BPF_VM_NOHUGEPAGE,      /* VM_NOHUGEPAGE */
+};

The enum can be extended in the future to support file-backed THP by
adding new types.

>
> For the f_op->mmap_prepare stuff I provided an abstraction
>
> >  * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
> >  * @orders: Bitmask of requested THP orders for this allocation
> >  *          - PMD-mapped allocation if PMD_ORDER is set
> >  *          - mTHP allocation otherwise
> >  *
> >  * Rerurn: Bitmask of suggested THP orders for allocation. The highest
>
> Obv. a cover letter thing but typo her :P rerurn -> return.

will change it.

>
> >  *         suggested order will not exceed the highest requested order
> >  *         in @orders.
>
> In what sense are they 'suggested'? Is this a product of sysfs settings o=
r? I
> think this needs to be clearer.

The order is suggested by a BPF program. I will clarify it in the next vers=
ion.

>
> >  */
> >  int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_struct=
 *vma__nullable,
> >                             u64 vma_flags, enum tva_type tva_flags, int=
 orders) __rcu;
>
> Also here in what sense is this suggested? :)

Agreed. I'll rename it to bpf_hook_thp_get_order() as suggested for clarity=
.

>
> >
> > This interface:
> > - Supports both use cases (per-workload tuning + policy prototyping).
> > - Can be extended with BPF helpers (e.g., for memory pressure awareness=
).
>
> Hm how would extensions like this work?

To optimize THP allocation, we should consult the PSI  data
beforehand. If memory pressure is already high=E2=80=94indicating difficult=
y
in allocating high-order pages=E2=80=94the system should default to allocat=
ing
4K pages instead. This could be implemented by checking the PSI data
of the relevant cgroup:

  struct cgroup *cgrp =3D task_dfl_cgroup(mm->owner);
  struct psi_group *psi =3D cgroup_psi(cgrp);  // or psi_system
  u64 psi_data =3D psi->total[PSI_AVGS][PSI_MEM];

The allocation strategy would then branch based on the value of
psi_data. This may require new BPF helpers to access PSI data
efficiently.

>
> >
> > This is an experimental feature. To use it, you must enable
> > CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION.
>
> Yes! Thanks. I am glad we are putting this behind a config flag.
>
> >
> > Warning:
> > - The interface may change
> > - Behavior may differ in future kernel versions
> > - We might remove it in the future
> >
> >
> > Selftests
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > BPF selftests
> > -------------
> >
> > Patch #5: Implements a basic BPF THP policy that restricts THP allocati=
on
> >           via khugepaged to tasks within a specified memory cgroup.
> > Patch #6: Contains test cases validating the khugepaged fork behavior.
> > Patch #7: Provides tests for dynamic BPF program updates and replacemen=
t.
> > Patch #8: Includes negative tests for invalid BPF helper usage, verifyi=
ng
> >           proper verification by the BPF verifier.
> >
> > Currently, several dependency patches reside in mm-new but haven't been
> > merged into bpf-next:
> >   mm: add bitmap mm->flags field
> >   mm/huge_memory: convert "tva_flags" to "enum tva_type"
> >   mm: convert core mm to mm_flags_*() accessors
> >
> > To enable BPF CI testing, these dependencies were manually applied to
> > bpf-next [1]. All selftests in this series pass successfully. The obser=
ved
> > CI failures are unrelated to these changes.
>
> Cool, glad at least my mm changes were ok :)
>
> >
> > Performance Evaluation
> > ----------------------
> >
> > As suggested by Usama [2], performance impact was measured given the pa=
ge
> > fault handler modifications. The standard `perf bench mem memset` bench=
mark
> > was employed to assess page fault performance.
> >
> > Testing was conducted on an AMD EPYC 7W83 64-Core Processor (single NUM=
A
> > node). Due to variance between individual test runs, a script executed
> > 10000 iterations to calculate meaningful averages and standard deviatio=
ns.
> >
> > The results across three configurations show negligible performance imp=
act:
> > - Baseline (without this patch series)
> > - With patch series but no BPF program attached
> > - With patch series and BPF program attached
> >
> > The result are as follows,
> >
> >   Number of runs: 10,000
> >   Average throughput: 40-41 GB/sec
> >   Standard deviation: 7-8 GB/sec
>
> You're not giving data comparing the 3? Could you do so? Thanks.

I tested all three cases. The results from the three test cases were
similar, so I aggregated the data.

>
> >
> > Production verification
> > -----------------------
> >
> > We have successfully deployed a variant of this approach across numerou=
s
> > Kubernetes production servers. The implementation enables THP for speci=
fic
> > workloads (such as applications utilizing ZGC [3]) while disabling it f=
or
> > others. This selective deployment has operated flawlessly, with no
> > regression reports to date.
> >
> > For ZGC-based applications, our verification demonstrates that shmem TH=
P
> > delivers significant improvements:
> > - Reduced CPU utilization
> > - Lower average latencies
>
> Obviously it's _really key_ to point out that this feature is intendend t=
o
> be _absolutely_ ephemeral - we may or may not implement something like th=
is
> - it's really about both exploring how such an interface might look and
> also helping to determine how an 'automagic' future might look.

Our users can benefit from this feature, which is why we have already
deployed it on our production servers. We are now extending it to more
workloads, such as RDMA applications, where THP provides significant
performance gains. Given the complexity of our production environment,
we have found that manual control is a necessary practice. I am
presenting this case solely to demonstrate the feature's stability and
that it does not introduce regressions. However, I understand this use
case is not recommended by the maintainers and will clarify this in
the next version.

>
> >
> > Future work
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Based on our validation with production workloads, we observed mixed
> > results with XFS large folios (also known as File THP):
> >
> > - Performance Benefits
> >   Some workloads demonstrated significant improvements with XFS large
> >   folios enabled
> > - Performance Regression
> >   Some workloads experienced degradation when using XFS large folios
> >
> > These results demonstrate that File THP, similar to anonymous THP, requ=
ires
> > a more granular approach instead of a uniform implementation.
> >
> > We will extend the BPF-based order selection mechanism to support File =
THP
> > allocation policies.
> >
> > Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redha=
t.com/ [0]
> > Link: https://github.com/kernel-patches/bpf/pull/9561 [1]
> > Link: https://lwn.net/ml/all/a24d632d-4b11-4c88-9ed0-26fa12a0fce4@gmail=
.com/ [2]
> > Link: https://wiki.openjdk.org/display/zgc/Main#Main-EnablingTransparen=
tHugePagesOnLinux [3]
> >
> > Changes:
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > RFC v5-> v6:
> > - Code improvement around the RCU usage (Usama)
> > - Add selftests for khugepaged fork (Usama)
> > - Add performance data for page fault (Usama)
> > - Remove the RFC tag
> >
>
> Sorry I haven't been involved in the RFC reviews, always intended to but
> workload etc.
>
> Will be looking through this series as very interested in exploring this
> approach.

Thanks a lot for your reviews.

--=20
Regards
Yafang

