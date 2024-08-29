Return-Path: <bpf+bounces-38404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F59646D8
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E30C1F23489
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED951AE86F;
	Thu, 29 Aug 2024 13:35:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B3D1AE05B;
	Thu, 29 Aug 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938526; cv=none; b=CFc6Z/jZLAcUTf5j/cExH7EOZaDWkZLVbjeOsIGfS008vTePiZs4LNCoYYBB9vQ4kcGX5vf8Wcr9ITqf8XNOzeWfwk46KS5CIb1hDLz5ic3R2oCGJTt+372Eliuw9V+9DgEBy0w5DqOcCBVFCTKqnKtn6AVOiM73flUtx8BmDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938526; c=relaxed/simple;
	bh=a7E2nuLibxxLSuwRJYoTUviAaeli7PPrv3FteJiC5HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zw3wYJFqznB7ARt/94+3EUmUcD5r/9EnNIcj9kyI1CU2d0v4EOkvExakm1eapDh2IiAft1zJsgy7miTLt9X2q3DsYAf7PDHQqSkzUOB+mRhPF3lmmqUCqTPop2SrSQqKaQ9qtdziZugI4Np+WZNhKXTScnNoCLCBKeY/xsQSVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wvj0M6gnyz1xwG6;
	Thu, 29 Aug 2024 21:33:23 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 1246D180042;
	Thu, 29 Aug 2024 21:35:22 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Aug 2024 21:35:21 +0800
Message-ID: <f7a7d089-3313-4c25-884c-8d073ddf54e4@huawei.com>
Date: Thu, 29 Aug 2024 21:35:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] Fix accessing first syscall argument on RV64
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Ilya Leoshkevich
	<iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20240829133253.882133-1-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240829133253.882133-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2024/8/29 21:32, Pu Lehui wrote:
> On RV64, as Ilya mentioned before [0], the first syscall parameter should be
> accessed through orig_a0 (see arch/riscv64/include/asm/syscall.h),
> otherwise it will cause selftests like bpf_syscall_macro, vmlinux,
> test_lsm, etc. to fail on RV64.
> 
> Link: https://lore.kernel.org/bpf/20220209021745.2215452-1-iii@linux.ibm.com [0]
> 
> Pu Lehui (2):
>    libbpf: Fix accessing first syscall argument on RV64
>    selftests/bpf: Skip case involving first arg in bpf_syscall_macro on
>      RV64
> 
>   tools/lib/bpf/bpf_tracing.h                              | 9 ++++++++-
>   .../selftests/bpf/prog_tests/test_bpf_syscall_macro.c    | 2 +-
>   tools/testing/selftests/bpf/progs/bpf_syscall_macro.c    | 2 +-
>   3 files changed, 10 insertions(+), 3 deletions(-)
> 

There was an error in sending this time. A new one has been sent. Sorry 
for the noise.

