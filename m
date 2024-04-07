Return-Path: <bpf+bounces-26107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F82989ADEA
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 03:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2204F282B08
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65CF15C0;
	Sun,  7 Apr 2024 01:47:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B95223;
	Sun,  7 Apr 2024 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712454467; cv=none; b=owIs1wSz9uS9p1Mzi068oau78VS9Lo6OfX3ap+kFfOdOKCcURZU0Blk1DV+F5CiNYS+AT6YuS7XVCf+L/EX6DFqM+iIhSWKW5MM5981LPrVrHquntabVKs34kMlgi0QrHo6uK5qWfHUdEeSW9ieE6Yutpid/M3WqO2SXCCT/azk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712454467; c=relaxed/simple;
	bh=3ZcpxR9wsm3F98xCGc2DPxsXXCX+A8HMy5dSk8T23gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OCpmuuGYc5GgT65bGIidEFVtBxLDZYGMssq2eVnRlbtLVBKXIv+XlW9EG3OptAFaH7lhq0DpFSVYvjRY3HLo1s9kFy2k7Qahq0YwBCEere56ETC+F6NoMxu5Ldi07GxZMbvyc25hNnWJmRMncqIyToWinDLcPuBRn8U7rZGSP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VBw5C23hLz1RBSv;
	Sun,  7 Apr 2024 09:44:47 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 8630E14011F;
	Sun,  7 Apr 2024 09:47:36 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 7 Apr 2024 09:47:35 +0800
Message-ID: <959db176-a79e-4074-a4bb-d9ee5ce19f79@huawei.com>
Date: Sun, 7 Apr 2024 09:47:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] MAINTAINERS: bpf: Add Lehui and Puranjay as riscv64
 reviewers
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Puranjay Mohan
	<puranjay@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
References: <20240405123352.2852393-1-bjorn@kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240405123352.2852393-1-bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100009.china.huawei.com (7.221.188.135)


On 2024/4/5 20:33, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Lehui and Puranjay have been active RISC-V 64-bit BPF JIT
> contributors/reviewers for a long time!
> 
> Let's make it more official by adding them as reviewers in
> MAINTAINERS.

It's my honor to take on this responsibility, and delighted to be 
partnered with you Björn and Puranjay.😀

Lehui

> 
> Thank you for your hard work!
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 75381386fe4c..58ab032ad33d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3764,6 +3764,8 @@ X:	arch/riscv/net/bpf_jit_comp64.c
>   
>   BPF JIT for RISC-V (64-bit)
>   M:	Björn Töpel <bjorn@kernel.org>
> +R:	Pu Lehui <pulehui@huawei.com>
> +R:	Puranjay Mohan <puranjay@kernel.org>
>   L:	bpf@vger.kernel.org
>   S:	Maintained
>   F:	arch/riscv/net/
> 
> base-commit: c88b9b4cde17aec34fb9bfaf69f9f72a1c44f511

