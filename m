Return-Path: <bpf+bounces-18551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709BF81BDDF
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 19:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6F628C1ED
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E064AB1;
	Thu, 21 Dec 2023 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTgd5KQI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53816351A
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d3bf30664so10791775e9.0
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703181718; x=1703786518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01pmU25iPd68MvEa08pvyHeTqz7/GCeqoZjVP1yol7Q=;
        b=UTgd5KQICQXXrh5joayiXAuPYCRsat11OXeR3Mdy6TS+cThmxJpReiTgaSa26FfsqT
         UtP9+o6tEJMOiukg28km/id1Y3SwbsCFq1Ir17aPM96xPffMtoR19U5WdQSEQtqoUlNF
         YrxTBH3cBxWfGrB9B7WhTzlXhT6dXuXdNuijvNvm3j6pTU7OvVewquc5jNXUQSq1LBBt
         X+j4RLTycRCwC/I6qIXuMSs5pc8OHrTJIRhJBvmf4q02r7LM4oQCeFWE2tJbsnu4gb7q
         u+d7vgkxRq71BgFiuKC7NxTD8vx68BtaheTgER0LQNW1CKDhx5VcW7S4KK9rY8XJ/ksz
         Nxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181718; x=1703786518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01pmU25iPd68MvEa08pvyHeTqz7/GCeqoZjVP1yol7Q=;
        b=l3GRf60aJI64dC5t/1MEfPy6CwNv7y5z6AggQnC/9pdhEAvc1E7xElDBKcEam1i1F3
         j+hyrkN6+lujABHbSe9MJGxRBy+3+KBY80a0zpl7NaDyyJAZ+PMoXVQE5aPo/mll2iMl
         Cpuoe7RwVQpAxxiXhS0ey4+N4P88ru3e+i3urnp1OisfwiU5thZ+2fZqFWU4OndnAx4Z
         QlpXqzuLvF0bBayxjwWJGov8HR313YXSwksBGFlqCSP1X0MSgdnBZc8drf5yst1stNDj
         za0IJQ3rg7b3RbmWHWEHw4DoN2ng2ko3vYLE4rkyt2wf7FYlYNkiPA5W5xwegF7rnuMY
         L+zA==
X-Gm-Message-State: AOJu0YwMhL7fwswhNBxHur9gdMGIMiAVxvxeFw/bZG5eQTAp5TGvjW8X
	PlH1gxVqcAl2HI9RLiM06FY=
X-Google-Smtp-Source: AGHT+IHgB+nLl8gIEpEnD9VgIo7NLzszKEWYXSCl31SJipM/XdzNGqle9PjHPWf+9b3qOAtSPJHavQ==
X-Received: by 2002:a05:600c:1f8d:b0:40d:3d06:5107 with SMTP id je13-20020a05600c1f8d00b0040d3d065107mr72744wmb.64.1703181717802;
        Thu, 21 Dec 2023 10:01:57 -0800 (PST)
Received: from krava (cst-prg-70-88.cust.vodafone.cz. [46.135.70.88])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b003fee6e170f9sm4069142wmo.45.2023.12.21.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:01:57 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Dec 2023 19:01:51 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	dxu@dxuuu.xyz, memxor@gmail.com, john.fastabend@gmail.com,
	bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 0/5] bpf: volatile compare
Message-ID: <ZYR9jwJOgRjW0YYr@krava>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221033854.38397-1-alexei.starovoitov@gmail.com>

On Wed, Dec 20, 2023 at 07:38:49PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v1->v2:
> Fixed issues pointed out by Daniel, added more tests, attempted to convert profiler.c,
> but barrier_var() wins vs bpf_cmp(). To be investigated.
> Patches 1-4 are good to go, but 5 needs more work.
> 
> Alexei Starovoitov (5):
>   selftests/bpf: Attempt to build BPF programs with -Wsign-compare
>   bpf: Introduce "volatile compare" macro
>   selftests/bpf: Convert exceptions_assert.c to bpf_cmp
>   selftests/bpf: Remove bpf_assert_eq-like macros.
>   selftests/bpf: Attempt to convert profiler.c to bpf_cmp.

lgtm, for patches 1-4:

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  .../testing/selftests/bpf/bpf_experimental.h  | 194 ++++--------------
>  .../bpf/progs/bpf_iter_bpf_percpu_hash_map.c  |   2 +-
>  .../selftests/bpf/progs/bpf_iter_task_vmas.c  |   2 +-
>  .../selftests/bpf/progs/bpf_iter_tasks.c      |   2 +-
>  .../selftests/bpf/progs/bpf_iter_test_kern4.c |   2 +-
>  .../progs/cgroup_getset_retval_setsockopt.c   |   2 +-
>  .../selftests/bpf/progs/cgrp_ls_sleepable.c   |   2 +-
>  .../selftests/bpf/progs/cpumask_success.c     |   2 +-
>  .../testing/selftests/bpf/progs/exceptions.c  |  20 +-
>  .../selftests/bpf/progs/exceptions_assert.c   |  80 ++++----
>  tools/testing/selftests/bpf/progs/iters.c     |   4 +-
>  .../selftests/bpf/progs/iters_task_vma.c      |   3 +-
>  .../selftests/bpf/progs/linked_funcs1.c       |   2 +-
>  .../selftests/bpf/progs/linked_funcs2.c       |   2 +-
>  .../testing/selftests/bpf/progs/linked_list.c |   2 +-
>  .../selftests/bpf/progs/local_storage.c       |   2 +-
>  tools/testing/selftests/bpf/progs/lsm.c       |   2 +-
>  .../selftests/bpf/progs/normal_map_btf.c      |   2 +-
>  .../selftests/bpf/progs/profiler.inc.h        |  71 ++-----
>  tools/testing/selftests/bpf/progs/profiler2.c |   1 +
>  tools/testing/selftests/bpf/progs/profiler3.c |   1 +
>  .../selftests/bpf/progs/sockopt_inherit.c     |   2 +-
>  .../selftests/bpf/progs/sockopt_multi.c       |   2 +-
>  .../selftests/bpf/progs/sockopt_qos_to_cc.c   |   2 +-
>  .../testing/selftests/bpf/progs/test_bpf_ma.c |   2 +-
>  .../bpf/progs/test_core_reloc_kernel.c        |   2 +-
>  .../bpf/progs/test_core_reloc_module.c        |   8 +-
>  .../selftests/bpf/progs/test_fsverity.c       |   2 +-
>  .../bpf/progs/test_skc_to_unix_sock.c         |   2 +-
>  .../bpf/progs/test_xdp_do_redirect.c          |   2 +-
>  31 files changed, 146 insertions(+), 279 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

