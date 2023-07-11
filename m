Return-Path: <bpf+bounces-4800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626B74F8B1
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 22:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68F71C2102E
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C51EA85;
	Tue, 11 Jul 2023 20:04:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C417FE0;
	Tue, 11 Jul 2023 20:04:14 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD0A1998;
	Tue, 11 Jul 2023 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nsxDvjZn0aaZzEg/V4iHkOqBFaX/vWatq1iU6hkirzQ=; b=SzDycq1fnh7mg5GT4C964ejV/L
	gMiTwe9bZ4JoSlubC57fJSYcGjlmuy8DUniSdk1DxEL5wujrJYEx7QVGt0s/W7EtyJjP7A7/M3qDI
	alTwcPCQtyG/9LKr6ICOXNSW6EUuWhWlF4c0nsD2w3a/hrNHadly1AEi4hFeWsh5VwJV6mj3ORk+8
	WIlg8Z+I76mAuJdx+4hhra581suCfAtAbtT1O5NRkXsxMr/rGNnCkbC1YYJGpgNVWgCPX8mAj7XkW
	YltsXuH8/02LT1s7B0nAHivBGjMuBGkD5MI0oVyCtXcU6Ymg77Ck6hh709Tp7C5zUghcsf2HyYVOk
	y6DYkwmw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJJaO-0000qT-Rs; Tue, 11 Jul 2023 22:03:49 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJJaO-000PfD-62; Tue, 11 Jul 2023 22:03:48 +0200
Subject: Re: [PATCH bpf] riscv, bpf: Fix inconsistent JIT image generation
To: Palmer Dabbelt <palmer@dabbelt.com>, bjorn@kernel.org
Cc: ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Bjorn Topel <bjorn@rivosinc.com>,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 pulehui@huawei.com, luke.r.nels@gmail.com, xi.wang@gmail.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
References: <mhng-37770bfd-e982-4b87-a202-7cc08005b483@palmer-ri-x1c9a>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <830ab76b-ea2a-d522-73f9-b9392aecd0a4@iogearbox.net>
Date: Tue, 11 Jul 2023 22:03:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <mhng-37770bfd-e982-4b87-a202-7cc08005b483@palmer-ri-x1c9a>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26966/Tue Jul 11 09:28:31 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/23 7:50 PM, Palmer Dabbelt wrote:
> On Mon, 10 Jul 2023 00:41:31 PDT (-0700), bjorn@kernel.org wrote:
>> From: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
>>
>> In order to generate the prologue and epilogue, the BPF JIT needs to
>> know which registers that are clobbered. Therefore, the during
>> pre-final passes, the prologue is generated after the body of the
>> program body-prologue-epilogue. Then, in the final pass, a proper
>> prologue-body-epilogue JITted image is generated.
>>
>> This scheme has worked most of the time. However, for some large
>> programs with many jumps, e.g. the test_kmod.sh BPF selftest with
>> hardening enabled (blinding constants), this has shown to be
>> incorrect. For the final pass, when the proper prologue-body-epilogue
>> is generated, the image has not converged. This will lead to that the
>> final image will have incorrect jump offsets. The following is an
>> excerpt from an incorrect image:
>>
>>    | ...
>>    |     3b8:       00c50663                beq     a0,a2,3c4 <.text+0x3c4>
>>    |     3bc:       0020e317                auipc   t1,0x20e
>>    |     3c0:       49630067                jalr    zero,1174(t1) # 20e852 <.text+0x20e852>
>>    | ...
>>    |  20e84c:       8796                    c.mv    a5,t0
>>    |  20e84e:       6422                    c.ldsp  s0,8(sp)    # Epilogue start
>>    |  20e850:       6141                    c.addi16sp      sp,16
>>    |  20e852:       853e                    c.mv    a0,a5       # Incorrect jump target
>>    |  20e854:       8082                    c.jr    ra
>>
>> The image has shrunk, and the epilogue offset is incorrect in the
>> final pass.
>>
>> Correct the problem by always generating proper prologue-body-epilogue
>> outputs, which means that the first pass will only generate the body
>> to track what registers that are touched.
>>
>> Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
>> Signed-off-by: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
>> ---
>>   arch/riscv/net/bpf_jit.h      |  6 +++---
>>   arch/riscv/net/bpf_jit_core.c | 19 +++++++++++++------
>>   2 files changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index bf9802a63061..2717f5490428 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -69,7 +69,7 @@ struct rv_jit_context {
>>   	struct bpf_prog *prog;
>>   	u16 *insns;		/* RV insns */
>>   	int ninsns;
>> -	int body_len;
>> +	int prologue_len;
>>   	int epilogue_offset;
>>   	int *offset;		/* BPF to RV */
>>   	int nexentries;
>> @@ -216,8 +216,8 @@ static inline int rv_offset(int insn, int off, struct rv_jit_context *ctx)
>>   	int from, to;
>>
>>   	off++; /* BPF branch is from PC+1, RV is from PC */
>> -	from = (insn > 0) ? ctx->offset[insn - 1] : 0;
>> -	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : 0;
>> +	from = (insn > 0) ? ctx->offset[insn - 1] : ctx->prologue_len;
>> +	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : ctx->prologue_len;
>>   	return ninsns_rvoff(to - from);
>>   }
>>
>> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
>> index 737baf8715da..7a26a3e1c73c 100644
>> --- a/arch/riscv/net/bpf_jit_core.c
>> +++ b/arch/riscv/net/bpf_jit_core.c
>> @@ -44,7 +44,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   	unsigned int prog_size = 0, extable_size = 0;
>>   	bool tmp_blinded = false, extra_pass = false;
>>   	struct bpf_prog *tmp, *orig_prog = prog;
>> -	int pass = 0, prev_ninsns = 0, prologue_len, i;
>> +	int pass = 0, prev_ninsns = 0, i;
>>   	struct rv_jit_data *jit_data;
>>   	struct rv_jit_context *ctx;
>>
>> @@ -83,6 +83,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   		prog = orig_prog;
>>   		goto out_offset;
>>   	}
>> +
>> +	if (build_body(ctx, extra_pass, NULL)) {
>> +		prog = orig_prog;
>> +		goto out_offset;
>> +	}
>> +
>>   	for (i = 0; i < prog->len; i++) {
>>   		prev_ninsns += 32;
>>   		ctx->offset[i] = prev_ninsns;
>> @@ -91,12 +97,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
>>   		pass++;
>>   		ctx->ninsns = 0;
>> +
>> +		bpf_jit_build_prologue(ctx);
>> +		ctx->prologue_len = ctx->ninsns;
>> +
>>   		if (build_body(ctx, extra_pass, ctx->offset)) {
>>   			prog = orig_prog;
>>   			goto out_offset;
>>   		}
>> -		ctx->body_len = ctx->ninsns;
>> -		bpf_jit_build_prologue(ctx);
>> +
>>   		ctx->epilogue_offset = ctx->ninsns;
>>   		bpf_jit_build_epilogue(ctx);
>>
>> @@ -162,10 +171,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>
>>   	if (!prog->is_func || extra_pass) {
>>   		bpf_jit_binary_lock_ro(jit_data->header);
>> -		prologue_len = ctx->epilogue_offset - ctx->body_len;
>>   		for (i = 0; i < prog->len; i++)
>> -			ctx->offset[i] = ninsns_rvoff(prologue_len +
>> -						      ctx->offset[i]);
>> +			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
>>   		bpf_prog_fill_jited_linfo(prog, ctx->offset);
>>   out_offset:
>>   		kfree(ctx->offset);
>>
>> base-commit: 496720b7cfb6574a8f6f4d434f23e3d1e6cfaeb9
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I'm assuming this is aimed at the BPF tree, but LMK if you guys want me
> to pick it up -- I've already got something for this week, so it's easy
> on my end.  I'm dropping it from my queue and patchwork for now, though.

Sounds good, we applied it to bpf already.

Thanks,
Daniel

