Return-Path: <bpf+bounces-47913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5765BA01F51
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 07:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D035161ED8
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 06:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FA119E997;
	Mon,  6 Jan 2025 06:43:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FB1D47CE;
	Mon,  6 Jan 2025 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736145784; cv=none; b=vA7Q9ipMUtLOkok7Mu/YYz6yTBxziq9cJrHBGygkvSHkkYoQpGovejXpOn6EDrD9rJb05Yi8Nhp4+snR2IrgTF5Jn4mf/wDyu792k/6QrynvNwlOW8GjMQSV9+5FaB3nOroZGfnNiQdrKQ9V2EAJsG+hs8yRhDWl/aTFBJL6Tjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736145784; c=relaxed/simple;
	bh=K1+kKm8krNcOXdfW2tD6Nzh+v51qsUByovVZUHtP7nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjopsVzQyS4KZQVlQyMNLooop+Fw4gZXdFbw0VLL4stlZ0kf3elGN6wA9UX8in41isrIxy+iom7PPDWpgH3Zpo2v9J3Bexfp6bkYNfrtdsyPT048v+rVh0vvOwBg7JvtZL98wn+c3PDFKWmyriiuB5LP6cJkhhdXNaqdfqiq99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YRPkN3LkSz4f3jMy;
	Mon,  6 Jan 2025 14:42:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8E9971A103C;
	Mon,  6 Jan 2025 14:42:56 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgD3AGRve3tn+wG3AA--.5981S2;
	Mon, 06 Jan 2025 14:42:56 +0800 (CST)
Message-ID: <4a3f8848-7d3f-42ae-ac30-93d9bef83fc9@huaweicloud.com>
Date: Mon, 6 Jan 2025 14:42:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf, arm64: Simplify if logic in
 emit_lse_atomic()
Content-Language: en-US
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <e8520e5503a489e2dea8526077976ae5a0ab1849.1735868489.git.yepeilin@google.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <e8520e5503a489e2dea8526077976ae5a0ab1849.1735868489.git.yepeilin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3AGRve3tn+wG3AA--.5981S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy3WFW5KF43Zr1kAFykAFb_yoWkZFc_GF
	WxGa12grs3tr1fZrWUCF15GFyIkw4DGF1fJry7KFWDt3sIqr18JrWkKryfWryfXrsFkrWr
	ZrykJas7tw1jvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 1/3/2025 10:02 AM, Peilin Ye wrote:
> Delete that unnecessary outer if clause.  No functional change.
> 
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 66708b95493a..9040033eb1ea 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -648,16 +648,14 @@ static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   	const s16 off = insn->off;
>   	u8 reg = dst;
>   
> -	if (off || arena) {
> -		if (off) {
> -			emit_a64_mov_i(1, tmp, off, ctx);
> -			emit(A64_ADD(1, tmp, tmp, dst), ctx);
> -			reg = tmp;
> -		}
> -		if (arena) {
> -			emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
> -			reg = tmp;
> -		}
> +	if (off) {
> +		emit_a64_mov_i(1, tmp, off, ctx);
> +		emit(A64_ADD(1, tmp, tmp, dst), ctx);
> +		reg = tmp;
> +	}
> +	if (arena) {
> +		emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
> +		reg = tmp;
>   	}
>   
>   	switch (insn->imm) {

Thanks for the improvements.

For the series:

Acked-by: Xu Kuohai <xukuohai@huawei.com>


