Return-Path: <bpf+bounces-5060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B875479F
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD3B1C208E5
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E615CD;
	Sat, 15 Jul 2023 09:03:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499F7FA
	for <bpf@vger.kernel.org>; Sat, 15 Jul 2023 09:03:51 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FFDE65;
	Sat, 15 Jul 2023 02:03:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R32St5Fy5z4f3mK3;
	Sat, 15 Jul 2023 17:03:42 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCHN6vwYLJk0+YROA--.24593S2;
	Sat, 15 Jul 2023 17:03:45 +0800 (CST)
Message-ID: <ce15b171-897f-bf2e-2897-c0b2b912e709@huaweicloud.com>
Date: Sat, 15 Jul 2023 17:03:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf] bpf, arm64: Fix BTI type used for freplace attached
 functions
Content-Language: en-US
To: Alexander Duyck <alexander.duyck@gmail.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <168926677665.316237.9953845318337455525.stgit@ahduyck-xeon-server.home.arpa>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <168926677665.316237.9953845318337455525.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHN6vwYLJk0+YROA--.24593S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xZFW7tF4xGryxJFy3XFb_yoW8CF1rpa
	18CrZ0krs2qFn7WFWkJan7tr4rKw4vqFsxKw15XrWYyFyYqa4xKFn8K34Ykrs8ArW5Gw4r
	Zry2krnYkF1DZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/14/2023 12:49 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> When running an freplace attached bpf program on an arm64 system w were
> seeing the following issue:
>    Unhandled 64-bit el1h sync exception on CPU47, ESR 0x0000000036000003 -- BTI
> 
> After a bit of work to track it down I determined that what appeared to be
> happening is that the 'bti c' at the start of the program was somehow being
> reached after a 'br' instruction. Further digging pointed me toward the
> fact that the function was attached via freplace. This in turn led me to
> build_plt which I believe is invoking the long jump which is triggering
> this error.
> 
> To resolve it we can replace the 'bti c' with 'bti jc' and add a comment
> explaining why this has to be modified as such.
> 
> Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 145b540ec34f..ec2174838f2a 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -322,7 +322,13 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   	 *
>   	 */
>   
> -	emit_bti(A64_BTI_C, ctx);
> +	/* bpf function may be invoked by 3 instruction types:
> +	 * 1. bl, attached via freplace to bpf prog via short jump
> +	 * 2. br, attached via freplace to bpf prog via long jump
> +	 * 3. blr, working as a function pointer, used by emit_call.
> +	 * So BTI_JC should used here to support both br and blr.
> +	 */
> +	emit_bti(A64_BTI_JC, ctx);

LGTM. Thanks for the fixes.

Acked-by: Xu Kuohai <xukuohai@huawei.com>

>   
>   	emit(A64_MOV(1, A64_R(9), A64_LR), ctx);
>   	emit(A64_NOP, ctx);
> 
> 


