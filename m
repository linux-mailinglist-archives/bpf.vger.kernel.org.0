Return-Path: <bpf+bounces-19188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDED826FF2
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 14:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7251F22553
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0BB44C8D;
	Mon,  8 Jan 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6N4GVZ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D144C80
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso2001150a12.2
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 05:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704720891; x=1705325691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/PGjz1WzXFdMdPKws5Z/QSOjzZCz49Pe7peE3tvWFg=;
        b=c6N4GVZ+PrTzZ4Jfv5XOdWKQSmWNarBrzwvaBghDCJESAEjvP/o0xPf2cCcEoKvpXC
         lg4o5nUPc/BFYG0C9ZmzoS18qLnOOvxu2phlxpaDd1dxhiPy6ffZYFjAvQti/o54Nksq
         14Z3AzXqVlePoT2/KxDjk34ygL35u5EPzfTK2r3IqhBuwsM64iAubSq3BvDcDlBB5SQx
         W1wJ2OfOPlWUzPJcw7hINFqnJoEeRRTlzq/GMOaNOuz48xSrflGV2UY+3BabWzTH/D1c
         BbYsCweigBSWZqlfaQgn9B398ZovEtJQxMHhcApyOkrV9Qi5uKGTb5FXrchlS5pdC2eg
         R6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704720891; x=1705325691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/PGjz1WzXFdMdPKws5Z/QSOjzZCz49Pe7peE3tvWFg=;
        b=qTpKSTiEJjy1dXaQkjDohXqtJ9abFjw7C+byaZm4DaxJV4lWWGR4BOGHrog9z/B80L
         JnPY97gcGNgHrJ1GYQ7uUkUOCAP+aO68ZJpxNSBopDkbAQwRfkCeaRMU7FqXPSyfEVwf
         T+lzbGF8sUN0zwaZOxQiV/2gSNJSnheEUlon0S27QM5/C9bFi8H9V8/CyK10HJ4vls8A
         ahalxZklaSbOaTwrZiX+vlD99ys9FjNwPuif0OpB0rB9SnCL+hiUgiGLHK8tRaMojl2g
         7zp2qGozFVPhITsDmoxpjssE5M+lg56F9KH0Bv3PGJcWCXanCKzS2eVmb95q2Xklcg62
         6nlQ==
X-Gm-Message-State: AOJu0YwUeHUG04j6xhejUYv9DPIXdoKhIRH6hBrHQan+CGZYM/+iEwrc
	0eeWAggZ1mga/2O9XFoPbqQ=
X-Google-Smtp-Source: AGHT+IEn3qkahIrupXCX1x9MUeDUYDzxrV7l67ej6jKGpGngqLkk1wAAmm2IJ8fAEVD+PzzFkVz9BA==
X-Received: by 2002:a17:906:9b4f:b0:a2a:dba3:faac with SMTP id ep15-20020a1709069b4f00b00a2adba3faacmr371045ejc.154.1704720891140;
        Mon, 08 Jan 2024 05:34:51 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id lj18-20020a170906f9d200b00a26f63d16f6sm3912520ejb.25.2024.01.08.05.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:34:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 8 Jan 2024 14:34:49 +0100
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next 0/2] bpf: Add benchmark for bpf memory allocator
Message-ID: <ZZv5-YDKz-5xEje8@krava>
References: <20231221141501.3588586-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221141501.3588586-1-houtao@huaweicloud.com>

On Thu, Dec 21, 2023 at 10:14:59PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set aims to add a benchmark for bpf memory allocator to test
> both its alloc/free ratio and the memory usage.
> 
> Patch #1 is a preparatory patch which moves bench specific metrics into
> union of structs, so newly-added benchmark can add metrics which doesn't
> fit with the existing one easily. Patch #2 is the benchmark patch. It
> tests the performance through the following steps:
> 1) find the inner array by using the cpu number as key
> 2) allocate at most 64 128-bytes-sized objects through bpf_obj_new()
> 3) stash these objectes into the inner array through bpf_kptr_xchg()
> 4) account the time used in step 1)~3)
> 5) calculate the performance in M/s: alloc_cnt * 1000 / alloc_tim_ns
> 6) calculate the memory usage by reading slub field in memory.stat file
>    and get the final value after subtracting the base value.
> 
> Please see individual patches for more details. And comments are always
> welcome.
> 
> Hou Tao (2):
>   selftests/bpf: Move bench specific metrics into union of structs
>   selftests/bpf: Add benchmark for bpf memory allocator

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  tools/testing/selftests/bpf/Makefile          |   2 +
>  tools/testing/selftests/bpf/bench.c           |  13 +-
>  tools/testing/selftests/bpf/bench.h           |  22 +-
>  .../selftests/bpf/benchs/bench_bpf_ma.c       | 273 ++++++++++++++++++
>  .../selftests/bpf/benchs/bench_htab_mem.c     |  10 +-
>  .../bench_local_storage_rcu_tasks_trace.c     |  10 +-
>  .../selftests/bpf/progs/bench_bpf_ma.c        | 222 ++++++++++++++
>  7 files changed, 535 insertions(+), 17 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_ma.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_ma.c
> 
> -- 
> 2.29.2
> 

