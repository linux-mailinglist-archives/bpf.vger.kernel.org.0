Return-Path: <bpf+bounces-54397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BCCA696B9
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9EC19C58E6
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9F1F4C97;
	Wed, 19 Mar 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="cfIEs0tV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AE1DF747
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406110; cv=none; b=tijqYfA9/9giq40uHhBA0jWWusyjEAKwWu3ciYwhTFBKF4nJ+K9lzhY7YHp74wgx/PDGATmGFeHREtqitC1gEZRLyu5o6XAN+L/k6ART5PNZeMxTcPwk5UnD+HgMRxuwTGUGdAXK4aHSQoYT4rTzHl3VQ8cDMBqkaojlosR1WWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406110; c=relaxed/simple;
	bh=QBIc44HZE97a3U9rkLoPRX04W4d+cLtwDuApOm9o2Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBv0izZiEwmbYrDQD63fady688liID6gn6Tkj+3qsrudmqu5OOm72YWW5GbcFBWVKGmQq9aZmJJ8m2ybsK/yxmNW2lQdG1Tygq6wxQgPvuC+IrUP8YU6D06uHxpGU4fNnzcioNd8Lul91X2YjSwh+gABx5dvzR4pi19JdWJj464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=cfIEs0tV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso51676905e9.3
        for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742406107; x=1743010907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flAIqWjvJ4M/gYcpOleeOMvEwMzgJiN7GNpbxaVy9mg=;
        b=cfIEs0tVxmZDHMYYsmi+8smikTqiZA9BDjXu7QvW4NvCrogzMqtTxLmvaVyPuCWJzv
         gour2y5Z2MV0xyq1CL2XB8zP7LxJOemVTjRViVcSfeAsAAb+zbicoWvU2veN3YS8Qa/Q
         exSL8wrxG1l4ipbTwT9Bf/JyiDD1z+AqqBVzq63ATl14ea7/xLpK+1EVwnxOqS0fV4aB
         J0T+TDe6K7fj7OOFl1wGdDgJmvhIG4qpRlCRGI8LwrlsGKXztaJk1EAU8IfOkTRZBbp9
         dDfomEgFM5JEgO/i1LgSy4ReDGTbHmLzyP5s5fckW6wiNFXiB0n9ghSAwpyddpL5oZ+A
         sr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406107; x=1743010907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flAIqWjvJ4M/gYcpOleeOMvEwMzgJiN7GNpbxaVy9mg=;
        b=YERAtDWSRDOZVyoejfMl3aH2+4m9sXnuVA8KRbVvI/WbNkJ6JczoQas6efKc2E4gs3
         XgCc5HnWSE4LxIkD7bpt5+XuESAsDwJVh4C8BUB2+eQ2QUp52EzCPVR69HpHgbYnq/JG
         Wg1ToeN0A15rX9ZJqQQP1rcgEbBn5xUGUof1rARFTalVAtZipn4x5T0lWqoPujj1J4lj
         2iBPl2nk6GXx4wB2NUzxpxxpyrNs3qRE3mzQyHFpyZXH+QdY7BVkM0qZdi6i/HovNJrg
         45jy0qHJd5epHEeQZYHa5WSNlVkL+lu7ppBd7P7NCKG0XJnOpG0qCQMwUFw4K3CiOUz5
         4WJQ==
X-Gm-Message-State: AOJu0YxbCMhlIS6hN8HkmlHcpj2LEsiCQolTC8xa2RzMlS8AzmquX3Ly
	G0wd1tMss/IS2UqHnArSIz08A2SW8yGVfLd5ntoWZslhsGVCxw/83QT9y3cLNtE4UCyjbVLDmXj
	C
X-Gm-Gg: ASbGncv+uJvliddiofBwTxpXhGeIba1VXPUjc0S4f5ls8DVDQ+1S0kG32cPPXtMwOTN
	RJQB0RSmb9Rgo2is1qn7B157t4ENEVQ0GUlfgyJ8Hm/hyFECcrkOaOZPg32qzHuklJB13aQRS2O
	AfgilVZi38LxDtEKM2Gsu7Z/jKJ9Qd+2NFyzr3tmfKBaJ52SrKCAbZslJHyYNq8YEA7B+FjPNd4
	GC5VMsMNR7FbZbF40CyV+TL4CPIct4ovUClMrRAo+BliN5THuHeZqFNw/GfDiKlIagcKSj5BdFr
	ir5x/f/s83RjHaiyyNmZvjPOr10rM/tIobq6bHK0qnQdzxYa
X-Google-Smtp-Source: AGHT+IHjB3VevpKlLtFJkF2z2Az7TFgvRaB/UZwXjYH0FfDXzx1bbWftoBfZNOiuJfol0A1q5Q/V4g==
X-Received: by 2002:a5d:47c8:0:b0:38a:88ac:f115 with SMTP id ffacd0b85a97d-39973af8e00mr2702460f8f.34.1742406106654;
        Wed, 19 Mar 2025 10:41:46 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb92csm22070512f8f.91.2025.03.19.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:41:46 -0700 (PDT)
Date: Wed, 19 Mar 2025 17:45:27 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH bpf-next 00/14] instruction sets and static keys
Message-ID: <Z9sCt+Zb8/IzeG1D@mail.gmail.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <4a128a09-0b8b-488a-986b-7882f96bc5bb@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a128a09-0b8b-488a-986b-7882f96bc5bb@linux.dev>

On 25/03/18 02:00PM, Yonghong Song wrote:
> 
> 
> On 3/18/25 7:33 AM, Anton Protopopov wrote:
> > This patchset implements new type of map, instruction set, and uses
> > it to build support for BPF static keys. The same map will be later
> > used to provide support for indirect jumps and indirect calls. See
> > [1], [2] for more context.
> > 
> > Short table of contents:
> > 
> >    * patches 1, 9, 10, 11 are simple fixes (which can be sent
> >      independently, if acked)
> > 
> >    * patches 2, 3 add a new map type, BPF_MAP_TYPE_INSN_SET, and
> >      corresponding selftests. This map is used to track how original
> >      instructions were relocated into 'xlated' during the verification
> > 
> >    * patches 4, 5, 6, 7, 8 add support for static keys (kernel only)
> >      using (an extension) to that new map type. Only x86 support is
> >      added in this RFC
> > 
> >    * patches 12, 13, 14 add libbpf-side support for static keys and
> >      selftests
> > 
> > It is RFC for a few reasons:
> > 
> > 1) The kernel side of the static keys looks clear, however, the
> > libbpf side is not _that_ clear. I thought that this is better to
> > commit to a particular userspace design, as any particular design
> > requires a lot of changes on the libbpf side. See patch 12 for
> > the details
> > 
> > 2) The libbpf part of the series requires a patched LLVM (see [3]),
> > which adds support for gotol_or_nop/nop_or_gotol instructions, so
> > selftests would not compile in CI.
> > 
> > 3) Patch 4 adds support for a new BPF instruction. It looks
> > reasonable to use an extended BPF_JMP|BPF_JA instruction, and not
> > may_goto. Reasons: a follow up will add support for
> > BPF_JMP|BPF_JA|BPF_X (indirect jumps), which also utilizes INSN_SET maps (see [2]).
> > Then another follow up will add support CALL|BPF_X, for which there's
> > no corresponding magic instruction (to be discussed at the following
> > LSF/MM/BPF).
> > 
> > Besides these reasons, there are some questions / known bugs,
> > which will be fixed once the general plan is confirmed:
> > 
> >    * bpf_jit_blind_constants will patch code, which is ignored in this
> >      RFC series. The solution would be either moving tracking
> >      instruction sets to bpf_prog from the verifier environment,
> >      or moving bpf_jit_blind_constants upper the stack (right now,
> >      this is the first thing which every jit does, so maybe it can
> >      be actually executed from the verifier, and provide env context)
> > 
> >    * gen-loader not supported, fd_array usage in libbpf should be
> >      re-designed (see patch 12 for more details)
> > 
> >    * insn_off -> insn_set map mapping should be optimized (now it is
> >      brute force)
> > 
> > Links:
> >    1. http://oldvger.kernel.org/bpfconf2024_material/bpf_static_keys.pdf
> >    2. https://lpc.events/event/18/contributions/1941/
> >    3. https://github.com/aspsk/llvm-project/tree/static-keys
> 
> For llvm patch in [3], please remove changes in function isValidIdInMiddle()
> as gotol_or_nop or nop_or_gotol will not appear in the *middle* of any
> instruction. "gotol" should not be there either, I may remove it sometime
> later.

Thanks, removed.

> > 
> > Anton Protopopov (14):
> >    bpf: fix a comment describing bpf_attr
> >    bpf: add new map type: instructions set
> >    selftests/bpf: add selftests for new insn_set map
> >    bpf: add support for an extended JA instruction
> >    bpf: Add kernel/bpftool asm support for new instructions
> >    bpf: add BPF_STATIC_KEY_UPDATE syscall
> >    bpf: save the start of functions in bpf_prog_aux
> >    bpf, x86: implement static key support
> >    selftests/bpf: add guard macros around likely/unlikely
> >    libbpf: add likely/unlikely macros
> >    selftests/bpf: remove likely/unlikely definitions
> >    libbpf: BPF Static Keys support
> >    libbpf: Add bpf_static_key_update() API
> >    selftests/bpf: Add tests for BPF static calls
> > 
> >   arch/x86/net/bpf_jit_comp.c                   |  65 +-
> >   include/linux/bpf.h                           |  28 +
> >   include/linux/bpf_types.h                     |   1 +
> >   include/linux/bpf_verifier.h                  |   2 +
> >   include/uapi/linux/bpf.h                      |  40 +-
> >   kernel/bpf/Makefile                           |   2 +-
> >   kernel/bpf/bpf_insn_set.c                     | 400 +++++++++++
> >   kernel/bpf/core.c                             |   5 +
> >   kernel/bpf/disasm.c                           |  33 +-
> >   kernel/bpf/syscall.c                          |  28 +
> >   kernel/bpf/verifier.c                         |  94 ++-
> >   tools/include/uapi/linux/bpf.h                |  40 +-
> >   tools/lib/bpf/bpf.c                           |  17 +
> >   tools/lib/bpf/bpf.h                           |  19 +
> >   tools/lib/bpf/bpf_helpers.h                   |  63 ++
> >   tools/lib/bpf/libbpf.c                        | 362 +++++++++-
> >   tools/lib/bpf/libbpf.map                      |   1 +
> >   tools/lib/bpf/libbpf_internal.h               |   3 +
> >   tools/lib/bpf/linker.c                        |   6 +-
> >   .../selftests/bpf/bpf_arena_spin_lock.h       |   3 -
> >   .../selftests/bpf/prog_tests/bpf_insn_set.c   | 639 ++++++++++++++++++
> >   .../bpf/prog_tests/bpf_static_keys.c          | 359 ++++++++++
> >   .../selftests/bpf/progs/bpf_static_keys.c     | 131 ++++
> >   tools/testing/selftests/bpf/progs/iters.c     |   2 -
> >   24 files changed, 2315 insertions(+), 28 deletions(-)
> >   create mode 100644 kernel/bpf/bpf_insn_set.c
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/bpf_static_keys.c
> > 
> 

