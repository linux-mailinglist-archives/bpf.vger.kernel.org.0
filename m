Return-Path: <bpf+bounces-43485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0429B5A04
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 03:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B319D1C2281C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1019340C;
	Wed, 30 Oct 2024 02:41:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AA7489
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 02:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256087; cv=none; b=tlq+1sgSU9VWpWR8blr43vRiV/OlA1gFnD0RuKPBXebsCGw/WqaYfKbXdcDs/9Q1IS/j2+lrxEVjgsOS9T86sIpiDO376LXaZuShYYx3fMHRfAvBX0rjgSRQ5YzZG+BZs8QNvIn6SpkSjGH5wX7d4T88KZlwscR1F3imvKH+GWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256087; c=relaxed/simple;
	bh=b0KhincoPqD1nnsZl+DFpLk4hNpT0aoRGHbKGPPNz5w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HquaJI+jerDdRKYv30d0DI/zpJZa0Ja9c9/HVGKMh2OGHIAa7DNbT4YQSdliDq+J5ejmf+HzPS5bnlMKzQ2lj43aSUM7nQ+eOUKRP+hYR05WObRn9dgFcjFYLF++1rKkrJx6ZuQH7mZclfFz6AjgezheVFaXAbmSpPPVDJj+Fjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XdWZt5YTxz4f3jdG
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 10:40:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7824A1A0359
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 10:41:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3CMXDnCFn9kdIAQ--.13991S2;
	Wed, 30 Oct 2024 10:41:11 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: disallow 40-bytes extra stack for bpf_fastcall
 patterns
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev
References: <20241029193911.1575719-1-eddyz87@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3f142a53-3c30-f4e3-c932-ed785c3e62c2@huaweicloud.com>
Date: Wed, 30 Oct 2024 10:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241029193911.1575719-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3CMXDnCFn9kdIAQ--.13991S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1kZF4ktF1UWr15Zw48tFb_yoW8tw1Up3
	9FkF4UKFZFvrWjkan7A34xAay8WFs5JF17XrWfAFyYyF15AFySgF43Ka1xtFykurnFk3yD
	CF4DJrZrJryqqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/30/2024 3:39 AM, Eduard Zingerman wrote:
> Hou Tao reported an issue with bpf_fastcall patterns allowing extra
> stack space above MAX_BPF_STACK limit. This extra stack allowance is
> not integrated properly with the following verifier parts:
> - backtracking logic still assumes that stack can't exceed
>   MAX_BPF_STACK;
> - bpf_verifier_env->scratched_stack_slots assumes only 64 slots are
>   available.
>
> Here is an example of an issue with precision tracking
> (note stack slot -8 tracked as precise instead of -520):
>
>     0: (b7) r1 = 42                       ; R1_w=42
>     1: (b7) r2 = 42                       ; R2_w=42
>     2: (7b) *(u64 *)(r10 -512) = r1       ; R1_w=42 R10=fp0 fp-512_w=42
>     3: (7b) *(u64 *)(r10 -520) = r2       ; R2_w=42 R10=fp0 fp-520_w=42
>     4: (85) call bpf_get_smp_processor_id#8       ; R0_w=scalar(...)
>     5: (79) r2 = *(u64 *)(r10 -520)       ; R2_w=42 R10=fp0 fp-520_w=42
>     6: (79) r1 = *(u64 *)(r10 -512)       ; R1_w=42 R10=fp0 fp-512_w=42
>     7: (bf) r3 = r10                      ; R3_w=fp0 R10=fp0
>     8: (0f) r3 += r2
>     mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
>     mark_precise: frame0: regs=r2 stack= before 7: (bf) r3 = r10
>     mark_precise: frame0: regs=r2 stack= before 6: (79) r1 = *(u64 *)(r10 -512)
>     mark_precise: frame0: regs=r2 stack= before 5: (79) r2 = *(u64 *)(r10 -520)
>     mark_precise: frame0: regs= stack=-8 before 4: (85) call bpf_get_smp_processor_id#8
>     mark_precise: frame0: regs= stack=-8 before 3: (7b) *(u64 *)(r10 -520) = r2
>     mark_precise: frame0: regs=r2 stack= before 2: (7b) *(u64 *)(r10 -512) = r1
>     mark_precise: frame0: regs=r2 stack= before 1: (b7) r2 = 42
>     9: R2_w=42 R3_w=fp42
>     9: (95) exit
>
> This patch disables the additional allowance for the moment.
> Also, two test cases are removed:
> - bpf_fastcall_max_stack_ok:
>   it fails w/o additional stack allowance;
> - bpf_fastcall_max_stack_fail:
>   this test is no longer necessary, stack size follows
>   regular rules, pattern invalidation is checked by other
>   test cases.
>
> Reported-by: Hou Tao <houtao@huaweicloud.com>
> Closes: https://lore.kernel.org/bpf/20241023022752.172005-1-houtao@huaweicloud.com/
> Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper calls")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Tested-by: Hou Tao <houtao1@huawei.com>


