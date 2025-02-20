Return-Path: <bpf+bounces-52079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F2A3DA2A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 13:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B119B18958F0
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27511E9B0B;
	Thu, 20 Feb 2025 12:35:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417035942
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054905; cv=none; b=YgKwW/qebp13JMf6t8w3S2249GHQt6PY4S9TmvUPePnhvmHoiWjg048O9T1Pv/1Y3p1jKON5XGmqXy/Yb/yL72TFNNCj8Y1wOiFMvTU10jVKQHMCgcIWuVZ6kMXQOSoIdPb+cvPcjnU5Wynuw5Um1dYenizGGAGqeG1GGC5mQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054905; c=relaxed/simple;
	bh=atWwbPuLTAMWTK1scGoPaejQ/xYtW9Z2SHzLlU85QLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7jDaAUjDdwiuDlo4YRBG4RT/Dt4/ZeXSbhqhBVag04tcwNtqQpZjSYBwNMJ4B7NQsvNbbGV0uL4VRe0itklH9wEgFhSRduDq4e3BkpsQwotS4YGijRvA2FDNCuxm9Dlrh7YcxCMGqXtLp4CXlSQRCqAdHm0KHvW4SP8yKynxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YzCPn0DNSz4f3jt3
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 20:34:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5B1491A0E98
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 20:34:53 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgBnucNsIbdnQg9TEQ--.23254S2;
	Thu, 20 Feb 2025 20:34:53 +0800 (CST)
Message-ID: <55197030-7bf1-4bc8-ac58-0cc237b1eac7@huaweicloud.com>
Date: Thu, 20 Feb 2025 20:34:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: arm64: Silent "UBSAN: negation-overflow"
 warning
Content-Language: en-US
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, puranjay@kernel.org,
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
References: <20250218080240.2431257-1-song@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250218080240.2431257-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnucNsIbdnQg9TEQ--.23254S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryrXryrCFyfKw1ktrW8Zwb_yoW8Zw15pr
	43WrsYkw4qqF1rJa40yFy7tr4F9ws5JrsFgFyUA3yrKwn8X345WF1akw47Cr45GFyvkrs8
	uFyq9r9xAw1Dt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 2/18/2025 4:02 PM, Song Liu wrote:
> With UBSAN, test_bpf.ko triggers warnings like:
> 
> UBSAN: negation-overflow in arch/arm64/net/bpf_jit_comp.c:1333:28
> negation of -2147483648 cannot be represented in type 's32' (aka 'int'):
> 
> Silent these warnings by casting imm to u32 first.
> 
> Fixes: fd868f148189 ("bpf, arm64: Optimize ADD,SUB,JMP BPF_K using arm64 add/sub immediates")

I doubt this is a bug fix since I checked the build result and found nothing changed.

> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 8446848edddb..7409c8acbde3 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -272,7 +272,7 @@ static inline void emit_a64_add_i(const bool is64, const int dst, const int src,
>   {
>   	if (is_addsub_imm(imm)) {
>   		emit(A64_ADD_I(is64, dst, src, imm), ctx);
> -	} else if (is_addsub_imm(-imm)) {
> +	} else if (is_addsub_imm(-(u32)imm)) {
>   		emit(A64_SUB_I(is64, dst, src, -imm), ctx);
>   	} else {
>   		emit_a64_mov_i(is64, tmp, imm, ctx);
> @@ -1159,7 +1159,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   	case BPF_ALU64 | BPF_SUB | BPF_K:
>   		if (is_addsub_imm(imm)) {
>   			emit(A64_SUB_I(is64, dst, dst, imm), ctx);
> -		} else if (is_addsub_imm(-imm)) {
> +		} else if (is_addsub_imm(-(u32)imm)) {
>   			emit(A64_ADD_I(is64, dst, dst, -imm), ctx);
>   		} else {
>   			emit_a64_mov_i(is64, tmp, imm, ctx);
> @@ -1330,7 +1330,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   	case BPF_JMP32 | BPF_JSLE | BPF_K:
>   		if (is_addsub_imm(imm)) {
>   			emit(A64_CMP_I(is64, dst, imm), ctx);
> -		} else if (is_addsub_imm(-imm)) {
> +		} else if (is_addsub_imm(-(u32)imm)) {
>   			emit(A64_CMN_I(is64, dst, -imm), ctx);
>   		} else {
>   			emit_a64_mov_i(is64, tmp, imm, ctx);


