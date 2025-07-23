Return-Path: <bpf+bounces-64150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97611B0EC46
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 09:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4472D3A5991
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 07:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73544278E63;
	Wed, 23 Jul 2025 07:46:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9A27814A
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256805; cv=none; b=ooH4qqzzzTUuPvv8YYnzw03EMZE6NlHb+MSL5mRPuOhww9mqHhhCqhTw8VrkFElO1G0yVNW3Q/GCl8nYFC4YfxIncZbk8ys8AqTdiAued5M/A6H9PdQWa9lqdvNOwRGgGMPmKm9Iz9rTyIKiVmPS5Yp2VyKcZ/n5uhGkxUIvsZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256805; c=relaxed/simple;
	bh=I/G/lTidN4hUJDaTAXGz0hBBBM8ioX/BUtkqFsy/Gn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HOfmp+eF0m3KNPzrjwZ/w9I6J9W3asTk7mDDHCNp4hdIMq+hhZ7sJux4+QnbK2TyrmrEm4GwEdquCWamTleSH1QvfVO3ls8PZcOP3Tu/gEyRv16G/lJO4AqF24AzH+gH9ZNS3iKTwnrJFI/w2GNz+DfyecGlFwoteUlGJb+tHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bn5mv0JbGzYQtxq
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 15:46:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BB0EF1A058E
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 15:46:37 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgAnM7Vck4BoYSS_BA--.22046S2;
	Wed, 23 Jul 2025 15:46:37 +0800 (CST)
Message-ID: <0ecabd7b-6bea-49fa-b19c-9474c6e14a87@huaweicloud.com>
Date: Wed, 23 Jul 2025 15:46:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/1] bpf, arm64: fix fp initialization for
 exception boundary
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, bpf@vger.kernel.org
References: <20250722133410.54161-1-puranjay@kernel.org>
 <20250722133410.54161-2-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250722133410.54161-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnM7Vck4BoYSS_BA--.22046S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUtr1xAw45JFy7KFyUJrb_yoW8WrW8pa
	4fC3sakrZFqFyDCa40yw18Xr15Krs8XrW7CF15WrWay3ZIkFy0gryrKa98CrWDArWIkr45
	ZrWUKr1fC3Z8Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/22/2025 9:34 PM, Puranjay Mohan wrote:
> In the ARM64 BPF JIT when prog->aux->exception_boundary is set for a BPF
> program, find_used_callee_regs() is not called because for a program
> acting as exception boundary, all callee saved registers are saved.
> find_used_callee_regs() sets `ctx->fp_used = true;` when it sees FP
> being used in any of the instructions.
> 
> For programs acting as exception boundary, ctx->fp_used remains false
> even if frame pointer is used by the program and therefore, FP is not
> set-up for such programs in the prologue. This can cause the kernel to
> crash due to a pagefault.
> 
> Fix it by setting ctx->fp_used = true for exception boundary programs as
> fp is always saved in such programs.
> 
> Fixes: 5d4fa9ec5643 ("bpf, arm64: Avoid blindly saving/restoring all callee-saved registers")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 89b1b8c248c62..97ab651c0bd5d 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -412,6 +412,7 @@ static void push_callee_regs(struct jit_ctx *ctx)
>   		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
>   		emit(A64_PUSH(A64_R(25), A64_R(26), A64_SP), ctx);
>   		emit(A64_PUSH(A64_R(27), A64_R(28), A64_SP), ctx);
> +		ctx->fp_used = true;
>   	} else {
>   		find_used_callee_regs(ctx);
>   		for (i = 0; i + 1 < ctx->nr_used_callee_reg; i += 2) {

Acked-by: Xu Kuohai <xukuohai@huawei.com>


