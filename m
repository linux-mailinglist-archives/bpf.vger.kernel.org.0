Return-Path: <bpf+bounces-57031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06941AA418A
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 05:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDC89884AD
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 03:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64BF1C84B6;
	Wed, 30 Apr 2025 03:56:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4C5383
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985371; cv=none; b=sw2nvclKrk5FUmFtOEI3chnpR19K/nbez6/W7r5+f+KalXfSUlz2a32AkiqEJ6HHeF7pwkuIc0xu3qFebXA3GtqFB41IJdlZB5mD0eLq9B3rZ1NN9cKHIZwvHWTX45oM3zCNAtKPH0igwxBsO/WvmfLUXMIdmqh18G22BXldf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985371; c=relaxed/simple;
	bh=hsccn6NdM4a/+qEfwKEZkPF4F/vODERJ5mC8vtYkr7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bNHkzUUxPN0sSzjeDf5Twrdt0A3KT587TPBjA2f8ubY8N6rEP2q6urNuyCmfa8F2qpGcUcidSUEMxYP9VZ7Yx1wBhk6v0Bq/xUKOttL4wrmzWNDxNSK8U5mOx0O+DKWUNfREQCKoB+3C+K+JtWnr3ewFO8M6ANWsBMtmUmYvsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZnNYY6kJ7z2Cdgx;
	Wed, 30 Apr 2025 11:52:33 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EEDE1A0188;
	Wed, 30 Apr 2025 11:56:06 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Apr 2025 11:56:04 +0800
Message-ID: <e6805e47-befa-427f-a73f-2dba92adf059@huawei.com>
Date: Wed, 30 Apr 2025 11:56:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/8] bpf, riscv64: Support load-acquire and
 store-release instructions
Content-Language: en-US
To: Peilin Ye <yepeilin@google.com>, <bpf@vger.kernel.org>
CC: <linux-riscv@lists.infradead.org>, Andrea Parri <parri.andrea@gmail.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Puranjay Mohan
	<puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Josh Don
	<joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu
	<neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
References: <cover.1745970908.git.yepeilin@google.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2025/4/30 8:48, Peilin Ye wrote:
> Hi all!
> 
> Patchset [1] introduced BPF load-acquire (BPF_LOAD_ACQ) and
> store-release (BPF_STORE_REL) instructions, and added x86-64 and arm64
> JIT compiler support.  As a follow-up, this patchset supports
> load-acquire and store-release instructions for the riscv64 JIT
> compiler, and introduces some related selftests/ changes.
> 
> Specifically:
> 
>   * PATCH 1 makes insn_def_regno() handle load-acquires properly for
>     bpf_jit_needs_zext() (true for riscv64) architectures
>   * PATCH 2, 3 from Andrea Parri add the actual support to the riscv64
>     JIT compiler
>   * PATCH 4 optimizes code emission by skipping redundant zext
>     instructions inserted by the verifier
>   * PATCH 5, 6 and 7 are minor selftest/ improvements
>   * PATCH 8 enables (non-arena) load-acquire/store-release selftests for
>     riscv64
> 
> Please refer to individual patches for details.  Thanks!
> 
> [1] https://lore.kernel.org/all/cover.1741049567.git.yepeilin@google.com/
> 
> Andrea Parri (2):
>    bpf, riscv64: Introduce emit_load_*() and emit_store_*()
>    bpf, riscv64: Support load-acquire and store-release instructions
> 
> Peilin Ye (6):
>    bpf/verifier: Handle BPF_LOAD_ACQ instructions in insn_def_regno()
>    bpf, riscv64: Skip redundant zext instruction after load-acquire
>    selftests/bpf: Use CAN_USE_LOAD_ACQ_STORE_REL when appropriate
>    selftests/bpf: Avoid passing out-of-range values to __retval()
>    selftests/bpf: Verify zero-extension behavior in load-acquire tests
>    selftests/bpf: Enable non-arena load-acquire/store-release selftests
>      for riscv64
> 
>   arch/riscv/net/bpf_jit.h                      |  15 +
>   arch/riscv/net/bpf_jit_comp64.c               | 334 ++++++++++++------
>   arch/riscv/net/bpf_jit_core.c                 |   3 +-
>   kernel/bpf/verifier.c                         |  11 +-
>   tools/testing/selftests/bpf/progs/bpf_misc.h  |   5 +-
>   .../bpf/progs/verifier_load_acquire.c         |  48 ++-
>   .../selftests/bpf/progs/verifier_precision.c  |   5 +-
>   .../bpf/progs/verifier_store_release.c        |  39 +-
>   8 files changed, 314 insertions(+), 146 deletions(-)
> 

Hi Peilin, good to see the implementation of load-acquire and 
store-release instructions on RV64! But I'm about to start my vacation, 
so I'll test it once I'm back.

