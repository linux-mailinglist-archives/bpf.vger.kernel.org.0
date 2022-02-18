Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90DF4BC2D4
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 00:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiBRXVd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 18:21:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiBRXVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 18:21:32 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A821A58E4
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 15:21:14 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nLCYd-0007Pf-Np; Sat, 19 Feb 2022 00:20:59 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nLCYd-000PBv-EJ; Sat, 19 Feb 2022 00:20:59 +0100
Subject: Re: [PATCH bpf-next v3 2/2] bpf, arm64: calculate offset as
 byte-offset for bpf line info
To:     Hou Tao <houtao1@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220208012539.491753-1-houtao1@huawei.com>
 <20220208012539.491753-3-houtao1@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4df19b70-6ed7-c521-ed25-97f92f703483@iogearbox.net>
Date:   Sat, 19 Feb 2022 00:20:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220208012539.491753-3-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26457/Fri Feb 18 10:25:22 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/8/22 2:25 AM, Hou Tao wrote:
> insn_to_jit_off passed to bpf_prog_fill_jited_linfo() is calculated
> in instruction granularity instead of bytes granularity, but bpf
> line info requires byte offset, so fixing it by calculating ctx->offset
> as byte-offset. bpf2a64_offset() needs to return relative instruction
> offset by using ctx->offfset, so update it accordingly.
> 
> Fixes: 37ab566c178d ("bpf: arm64: Enable arm64 jit to provide bpf_line_info")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 68b35c83e637..aed07cba78ec 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -164,9 +164,14 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
>   	/*
>   	 * Whereas arm64 branch instructions encode the offset
>   	 * from the branch itself, so we must subtract 1 from the
> -	 * instruction offset.
> +	 * instruction offset. The unit of ctx->offset is byte, so
> +	 * subtract AARCH64_INSN_SIZE from it. bpf2a64_offset()
> +	 * returns instruction offset, so divide by AARCH64_INSN_SIZE
> +	 * at the end.
>   	 */
> -	return ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1);
> +	return (ctx->offset[bpf_insn + off] -
> +		(ctx->offset[bpf_insn] - AARCH64_INSN_SIZE)) /
> +		AARCH64_INSN_SIZE;
>   }
>   
>   static void jit_fill_hole(void *area, unsigned int size)
> @@ -1087,13 +1092,14 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
>   		const struct bpf_insn *insn = &prog->insnsi[i];
>   		int ret;
>   
> +		/* BPF line info needs byte-offset instead of insn-offset */
>   		if (ctx->image == NULL)
> -			ctx->offset[i] = ctx->idx;
> +			ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
>   		ret = build_insn(insn, ctx, extra_pass);
>   		if (ret > 0) {
>   			i++;
>   			if (ctx->image == NULL)
> -				ctx->offset[i] = ctx->idx;
> +				ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
>   			continue;
>   		}
>   		if (ret)
> @@ -1105,7 +1111,7 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
>   	 * instruction (end of program)
>   	 */
>   	if (ctx->image == NULL)
> -		ctx->offset[i] = ctx->idx;
> +		ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;

Both patches look good to me. For this one specifically, given bpf2a64_offset()
needs to return relative instruction offset via ctx->offfset, can't we just
simplify it like this w/o the AARCH64_INSN_SIZE back/forth dance?

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 74f9a9b6a053..72f4702a9d01 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -999,7 +999,7 @@ struct arm64_jit_data {

  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
  {
-	int image_size, prog_size, extable_size;
+	int image_size, prog_size, extable_size, i;
  	struct bpf_prog *tmp, *orig_prog = prog;
  	struct bpf_binary_header *header;
  	struct arm64_jit_data *jit_data;
@@ -1130,6 +1130,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
  	prog->jited_len = prog_size;

  	if (!prog->is_func || extra_pass) {
+		/* BPF line info needs byte-offset instead of insn-offset. */
+		for (i = 0; i < prog->len + 1; i++)
+			ctx.offset[i] *= AARCH64_INSN_SIZE;
  		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
  out_off:
  		kfree(ctx.offset);
-- 
2.21.0
