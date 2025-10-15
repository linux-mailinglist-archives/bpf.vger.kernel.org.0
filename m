Return-Path: <bpf+bounces-71039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E778BE04E8
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 597544E29CF
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD42303A10;
	Wed, 15 Oct 2025 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcA/iRLp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775462BDC3B
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555317; cv=none; b=QgKewjU+1GN+iWHoyCzCPDatI6uFwAzWvyyJSneaHc6LPMzvHDddiCgMAVIrCCjhaAGBymRHHEUtw5iRXhimJXaCvGva7coijXijbKyJ7NIbJPgPvJqbuOOIDiJGDpa3kz/gNA21HLoEzQH8SpPCY5o2Sdq5aD9NFmMYOExzSao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555317; c=relaxed/simple;
	bh=EMZKqTSnOfnBuvdExLH/0/j3qYB9lnczgf7ubSdND4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqAn2orp8yjxDD31CtLGuQfgVnadiXoGWrO6G9nqmlf8yuBz7FywzMKb50uU+VFnjvigppNDvhIdjDQzqJsqCv5FTC1g6XRXAjKT6/ZmZZi6RAkWRfYd7+IeGrI+kPau+mYrXzS4D6h+XHluIbmR1LoB6SvxNNzEawu8u5lQEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcA/iRLp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-791c287c10dso5835012b3a.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760555315; x=1761160115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QmSbXI2ApsZqfklDnKMr9/VcpSy3bad84AJw3uoOIms=;
        b=bcA/iRLpY9K8P/XezsHMElhfPCNILJ5H/Z45fIm/C4CjcYUfQBREAGqs95rUyQCFg7
         RnWVGvwRM/j5p/JQgFgiqAsfbZSNtiVOjMcGKqOdIsdXIAEEUAdYGrOrNjDDVNYInJL9
         8y2pKY+ZZ2xO+XDTc/14F3s1K/PG0CkbD4Gt2O1erNlfUGubleO0WB4TMgMUwCnHpalm
         +Gk5luKxbLFPEepiqUtiZmqCdx4AYHvOrOTkTV7z19UJAyfWBrUDexHxwhsm6iqkGdTU
         DzdvWyXv8yFZA5vm4WVkuBPFJaoaXiRTcS0C0RLV60+W86HIJy31+EpfPdFVfoRj+9+C
         e64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760555315; x=1761160115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmSbXI2ApsZqfklDnKMr9/VcpSy3bad84AJw3uoOIms=;
        b=wkrP6DslMUbeuh9sRBopV9ilCqjWLIkPNz7pcg8D1VcxwlGj7oZABIPPhE1l33WBSn
         dL9NmvXo8PYYuM5KGLlxPt25/s0yc31ffo4nSDs2QV1Gd1CVCx6AH7oW6R9Rn+HvqFn2
         dyrVxKzKYCPpvR+qvC2u0x1e1JFfdP9oXK0LwyP2sxR4EjfYv0/OLN+GaFxGxvuOfyA5
         X+4jK+aSHPI14K5q6/h//WFfkjJFcJF/gvuUM9hgyaPELwLboO7gKuxRSe+mvqvPv+ip
         uqaQUdpuKMjif7aR4lmC/t6lbnK4ikAvVvvsonkA8b9R/VCqcCBQJwZiy58nC1NNSxa4
         K4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWHwcKjEWe5WMw8zYoh9gWYUVDXgvikQOvEfdRhYif9K/4IBAs7W/C3UqfHafcde+PXqCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQZVkSWKLqHBDH5HeJYIX19OmBm1GJzgGBhveJbY4ERrttS3j
	PLw1wI+XCDWNb/HNXNFAUXml5ioXRGLY3EGQ6dTbEZQPXaXmQ7IST5vt
X-Gm-Gg: ASbGncsF8EbxxsG8ucblF6Dv5M3C49BOkPbY1OxgFOjnHe9oEir/SAB2mEoHFJyZPFc
	vJzIly2sSqzrbK3U0eS7lXsMGKnnTbKiCSB7zzXb8SQJrEBjvURrJ82cPBHs1rhHDuG8cK8/4R8
	8+76QCqWcbD4FZUqv/CgqB8SczSMTWEPDPs8hzlBHM1hH7xFZpY/yRq0YWt726QI+4T9E+Bk6PG
	BmJBAi6p/b8uD0ArzEVqOXheQqBhuzLGBERSt9wUvNR2HCkC9fIpFuBShbS55e6DhFWFjW8054+
	BndW3gsy3LdtjasD0UQYUu4wjU+ElWM1eMLUaw2uVMC8HL2obJ8NLm54BjcTdgpIW4JK6m0TCej
	A00WlEPs6Agd6vnPKC8baFWMnMIU1596KCkEIlf8yyjnkoTwrwizBlzXidUOS2RYIb3GQbw==
X-Google-Smtp-Source: AGHT+IHMSB7YdnX8tgv3hAnoptITEW+v5c6/QGjesZK24TcZjCmiCjAy3xCUPKMz1WHLBr4gr+e/lA==
X-Received: by 2002:a05:6a00:1884:b0:77f:416e:de8e with SMTP id d2e1a72fcca58-79387efb06cmr33823101b3a.26.1760555314450;
        Wed, 15 Oct 2025 12:08:34 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:1069])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm19483106b3a.69.2025.10.15.12.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:08:33 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	andrii@kernel.org,
	ast@kernel.org,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 0/2] memcg: reading memcg stats more efficiently
Date: Wed, 15 Oct 2025 12:08:11 -0700
Message-ID: <20251015190813.80163-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading cgroup memory.stat files there is significant kernel overhead
in the formatting and encoding of numeric data into a string buffer. Beyond
that, the given user mode program must decode this data and possibly
perform filtering to obtain the desired stats. This process can be
expensive for programs that periodically sample this data over a large
enough fleet.

As an alternative to reading memory.stat, introduce new kfuncs that allow
fetching specific memcg stats from within cgroup iterator based bpf
programs. This approach allows for numeric values to be transferred
directly from the kernel to user mode via the mapped memory of the bpf
program's elf data section. Reading stats this way effectively eliminates
the numeric conversion work needed to be performed in both kernel and user
mode. It also eliminates the need for filtering in a user mode program.
i.e. where reading memory.stat returns all stats, this new approach allows
returning only select stats.

An experiment was setup to compare the performance of a program using these
new kfuncs vs a program that uses the traditional method of reading
memory.stat. On the experimental side, a libbpf based program was written
which sets up a link to the bpf program once in advance and then reuses
this link to create and read from a bpf iterator program for 1M iterations.
Meanwhile on the control side, a program was written to open the root
memory.stat file and repeatedly read 1M times from the associated file
descriptor (while seeking back to zero before each subsequent read). Note
that the program does not bother to decode or filter any data in user mode.
The reason for this is because the experimental program completely removes
the need for this work.

The results showed a significant perf benefit on the experimental side,
outperforming the control side by a margin of 80% elapsed time in kernel
mode. The kernel overhead of numeric conversion on the control side is
eliminated on the experimental side since the values are read directly
through mapped memory of the bpf program. The experiment data is shown
here:

control: elapsed time
real    0m13.062s
user    0m0.147s
sys     0m12.876s

experiment: elapsed time
real    0m2.717s
user    0m0.175s
sys     0m2.451s

control: perf data
22.23% a.out [kernel.kallsyms] [k] vsnprintf
18.83% a.out [kernel.kallsyms] [k] format_decode
12.05% a.out [kernel.kallsyms] [k] string
11.56% a.out [kernel.kallsyms] [k] number
 7.71% a.out [kernel.kallsyms] [k] strlen
 4.80% a.out [kernel.kallsyms] [k] memcpy_orig
 4.67% a.out [kernel.kallsyms] [k] memory_stat_format
 4.63% a.out [kernel.kallsyms] [k] seq_buf_printf
 2.22% a.out [kernel.kallsyms] [k] widen_string
 1.65% a.out [kernel.kallsyms] [k] put_dec_trunc8
 0.95% a.out [kernel.kallsyms] [k] put_dec_full8
 0.69% a.out [kernel.kallsyms] [k] put_dec
 0.69% a.out [kernel.kallsyms] [k] memcpy

experiment: perf data
10.04% memcgstat bpf_prog_.._query [k] bpf_prog_527781c811d5b45c_query
 7.85% memcgstat [kernel.kallsyms] [k] memcg_node_stat_fetch
 4.03% memcgstat [kernel.kallsyms] [k] __memcg_slab_post_alloc_hook
 3.47% memcgstat [kernel.kallsyms] [k] _raw_spin_lock
 2.58% memcgstat [kernel.kallsyms] [k] memcg_vm_event_fetch
 2.58% memcgstat [kernel.kallsyms] [k] entry_SYSRETQ_unsafe_stack
 2.32% memcgstat [kernel.kallsyms] [k] kmem_cache_free
 2.19% memcgstat [kernel.kallsyms] [k] __memcg_slab_free_hook
 2.13% memcgstat [kernel.kallsyms] [k] mutex_lock
 2.12% memcgstat [kernel.kallsyms] [k] get_page_from_freelist

Aside from the perf gain, the kfunc/bpf approach provides flexibility in
how memcg data can be delivered to a user mode program. As seen in the
second patch which contains the selftests, it is possible to use a struct
with select memory stat fields. But it is completely up to the programmer
on how to lay out the data.

JP Kobryn (2):
  memcg: introduce kfuncs for fetching memcg stats
  memcg: selftests for memcg stat kfuncs

 mm/memcontrol.c                               |  67 ++++
 .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 294 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_memcg.c   |  61 ++++
 4 files changed, 440 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c

-- 
2.47.3


