Return-Path: <bpf+bounces-57625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E15CAAD43D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998FA1BA758B
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F118C937;
	Wed,  7 May 2025 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnpJSbOI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD3610D
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589581; cv=none; b=oc2Spg5k2E6Yhybbaoq3g+B1+X90byQ4pwQvrWLtAT2wbKGvsyNXhOusKunZC8bHkdQb6J7xViPZM1g9GLV91iVajM8WM325da3uop8GtSWIYpw/gxD2YTg8ijYjsDi3CxaavV0O28vMXLY87Tj9xPJhBms0RGuykcTMD7XKU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589581; c=relaxed/simple;
	bh=Aea/tbOHkfb6PZk0DrA2Rji75ejDh2Y5DsZeTeIkR3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT12YZ29If0VTtYS3TQ6r09GECw3Yuv6AEcfqyS9cQFe09Jvfi0E9N6zCU57G8C9cz/J26yNNLUGB9PmbwMRBmko1AuRUUypZ0ZXA1hA+vbfuxcoE3KK0FvxH0nxpm/sT8JNKC/By2H3G1Y9+jgODjv2xh3zIRIUndKyOEJ1Zv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnpJSbOI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e39fbad5fso71265ad.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589578; x=1747194378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CprdoLUso6rbsqIqPABR3Bwu/KBPakjt6caNQFlDa9s=;
        b=UnpJSbOIyCOfkNtxo8uVv//Ybku08nxEYOjuNNwAUOS+n5L7yVQkSNSG5IloYJRFKV
         9AXZVn84jS5On5SjVSR9uSXKIhxPbryY03WaYvxVnzuQKV1SBk6pe+qFKACiEktMx38O
         d7Iz5E7hj7He0l+RH0OLB8Q8XsNcAWFLd5a3pAu2fZ/VKEhUhNQe8Q6Sy0A1OzTZI9/d
         HocyxfLKsjXULkp6wQCIun+Ur3Yyw9eU6kdb2iLX/zLKR6jCHahK4ZEOO3JaYXOFnnHn
         RGNUjUhkcyB7izNdIM5GWegSSHYilGiF40Xqwxl3P4yIu88lmd/gQkamlfiDo8i/HmHD
         37pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589578; x=1747194378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CprdoLUso6rbsqIqPABR3Bwu/KBPakjt6caNQFlDa9s=;
        b=MvAmJkzzDSMP2s5rqqUH0eumBz91cjmWq5DVc+CcRzdVxoAA04XnELQDqlNx2r61uw
         eMQtZsTB+O5JROAB9SsfTTALvUv0TxV9R4V9opwInYX9lUdRtAEp/nXbAQlu7od/ZRNc
         mHPElB4hlLisltUKe7V5DmuTz1TZiXmcL0c80Vus2erHsginPtqyPu8XADBNqeldHNfo
         BUufnK1ZCO23h5673LK8jXyYsZsFLr1n6a06JvHTmsYDaO8bLK066a67XHaXIvR0e6bX
         yUXmf+0yg5qlkoDKdKzKOt/80VqovFgLsrG0a0rgAJ5ysSEZ1e9FhuD3dQkFw9FP8Hql
         AhKg==
X-Gm-Message-State: AOJu0YwOnmjDGe59nOw0cunC8DiDT6wY0sQ5aypDEkip3x2GIb1qggMJ
	MhfkXgchKoBNM4amqp4zaez9zdySyqfqGp7ldHKtGQ98Sjchj29jxFAV4wKX+E4/5TMmRFXHfs1
	WIg==
X-Gm-Gg: ASbGncvIsMMTgzjnqoOWX3pbRAJHc3VMc1smkur8bLxNk231pK6QNz8ULoeTnG9cqVC
	ZxCKCEON6Nc7UU1Lw/7h3bJVF5yrRlEBUfWu7atptLdNP9Db8woEEY6BtDd3pjKkzp7Nw4zebRz
	VtxBi4PJMVFJSvd29+dmYL8oQIAo5Ru4ufqmstAQ0iFAKtqRt2zm04FtAYyuIY/IZgrtTLX1HxE
	xgE8QKaqwFyPBoeyX4CU5Kwmx/gkIATQ4uXn8kB00dJW/6ZpDDqwl/GahF/DwG3NU68k2vms+fa
	jgvUc2xlaPxWeTA5ecFDlVzZlktXYw02Kla8prza6oUVo9HSG6NjibRVshNQWizIn2TDAxQI+rp
	VLGe5rQ==
X-Google-Smtp-Source: AGHT+IGBb8IZ+p4eSssPzIozOCBP9geGZhXA8XOl5UScfnTahE2nYrYHiyIiwfXFxk5ASUPHxlM5IA==
X-Received: by 2002:a17:902:ccc7:b0:223:5696:44f5 with SMTP id d9443c01a7336-22e5ee8bfdemr1866575ad.12.1746589578269;
        Tue, 06 May 2025 20:46:18 -0700 (PDT)
Received: from google.com (202.108.125.34.bc.googleusercontent.com. [34.125.108.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3c6c4a4sm8409572a12.73.2025.05.06.20.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 20:46:17 -0700 (PDT)
Date: Wed, 7 May 2025 03:46:12 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, Andrea Parri <parri.andrea@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>
Subject: Re: [PATCH bpf-next v2 0/8] bpf, riscv64: Support load-acquire and
 store-release instructions
Message-ID: <aBrXhK_Tv1M5ON-e@google.com>
References: <cover.1746588351.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>

Hi Lehui,

On Wed, May 07, 2025 at 03:42:29AM +0000, Peilin Ye wrote:
> v1: https://lore.kernel.org/bpf/cover.1745970908.git.yepeilin@google.com/
> Changes since v1:
> 
>  * add Acked-by:, Reviewed-by: and Tested-by: tags from Lehui and Björn
>  * simplify code logic in PATCH 1 (Lehui)
>  * in PATCH 3, avoid changing 'return 0;' to 'return ret;' at the end of
>    bpf_jit_emit_insn() (Lehui)
> 
> Please refer to individual patches for details.  Thanks!
> 
> [1] https://lore.kernel.org/all/cover.1741049567.git.yepeilin@google.com/
> 
> Andrea Parri (2):
>   bpf, riscv64: Introduce emit_load_*() and emit_store_*()
>   bpf, riscv64: Support load-acquire and store-release instructions
> 
> Peilin Ye (6):
>   bpf/verifier: Handle BPF_LOAD_ACQ instructions in insn_def_regno()
>   bpf, riscv64: Skip redundant zext instruction after load-acquire
>   selftests/bpf: Use CAN_USE_LOAD_ACQ_STORE_REL when appropriate
>   selftests/bpf: Avoid passing out-of-range values to __retval()
>   selftests/bpf: Verify zero-extension behavior in load-acquire tests
>   selftests/bpf: Enable non-arena load-acquire/store-release selftests
>     for riscv64
> 
>  arch/riscv/net/bpf_jit.h                      |  15 +
>  arch/riscv/net/bpf_jit_comp64.c               | 332 ++++++++++++------
>  arch/riscv/net/bpf_jit_core.c                 |   3 +-
>  kernel/bpf/verifier.c                         |  12 +-
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |   5 +-
>  .../bpf/progs/verifier_load_acquire.c         |  48 ++-
>  .../selftests/bpf/progs/verifier_precision.c  |   5 +-
>  .../bpf/progs/verifier_store_release.c        |  39 +-
>  8 files changed, 313 insertions(+), 146 deletions(-)

Please take another look at v2 PATCH 1/8 and 3/8, thanks!

Peilin Ye


