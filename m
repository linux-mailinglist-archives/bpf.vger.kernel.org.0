Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E231C693CBD
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 04:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBMDCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Feb 2023 22:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjBMDCA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Feb 2023 22:02:00 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C51BA6185
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 19:01:58 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxrOokqOljkOQRAA--.35408S3;
        Mon, 13 Feb 2023 11:01:56 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax97wjqOljlAUyAA--.27550S3;
        Mon, 13 Feb 2023 11:01:56 +0800 (CST)
Subject: Re: [PATCH 1/2] LoongArch: BPF: Treat function address as 64-bit
 value
To:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20230212035236.1436532-1-hengqi.chen@gmail.com>
 <20230212035236.1436532-2-hengqi.chen@gmail.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <07edfd3b-9895-f711-47a7-a805a4e92691@loongson.cn>
Date:   Mon, 13 Feb 2023 11:01:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230212035236.1436532-2-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Ax97wjqOljlAUyAA--.27550S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr1fAry5uFyUCryDuw4Durg_yoW8tFykpr
        s8CFs5CrW8Xr47WFnxJa18WFnIyFs8K3yUX3W7t3yFkanxXr93XF1kKw4a9as8G3y8Cw4I
        vrW0kw15Zan0ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hengqi,

On 02/12/2023 11:52 AM, Hengqi Chen wrote:
> Let's always use 4 instructions for function address in JIT.
> So that the instruction sequences don't change between the first
> pass and the extra pass for function calls.
>
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index c4b1947ebf76..2d952110be72 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -446,6 +446,27 @@ static int add_exception_handler(const struct bpf_insn *insn,
>  	return 0;
>  }
>
> +static inline void emit_addr_move(struct jit_ctx *ctx, enum loongarch_gpr rd, u64 addr)
> +{
> +	u64 imm_11_0, imm_31_12, imm_51_32, imm_63_52;
> +
> +	/* lu12iw rd, imm_31_12 */
> +	imm_31_12 = (addr >> 12) & 0xfffff;
> +	emit_insn(ctx, lu12iw, rd, imm_31_12);
> +
> +	/* ori rd, rd, imm_11_0 */
> +	imm_11_0 = addr & 0xfff;
> +	emit_insn(ctx, ori, rd, rd, imm_11_0);
> +
> +	/* lu32id rd, imm_51_32 */
> +	imm_51_32 = (addr >> 32) & 0xfffff;
> +	emit_insn(ctx, lu32id, rd, imm_51_32);
> +
> +	/* lu52id rd, rd, imm_63_52 */
> +	imm_63_52 = (addr >> 52) & 0xfff;
> +	emit_insn(ctx, lu52id, rd, rd, imm_63_52);
> +}
> +
>  static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
>  {
>  	u8 tm = -1;
> @@ -841,7 +862,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>  		if (ret < 0)
>  			return ret;
>
> -		move_imm(ctx, t1, func_addr, is32);
> +		emit_addr_move(ctx, t1, func_addr);
>  		emit_insn(ctx, jirl, t1, LOONGARCH_GPR_RA, 0);
>  		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
>  		break;
>

The code itself looks good to me.

Could you please give more detailed info in the commit message?
For example, description of problem, steps to reproduce, ...
I think the descriptions in the cover letter are useful, it is
better to record them in the commit message.

Additionally, emit_addr_move() is similar with move_imm(), it is
better to define emit_addr_move() before move_imm() in bpf_jit.h.

Thanks,
Tiezhu

