Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDDD5EBEE1
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiI0Jpq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 05:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiI0Jpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 05:45:45 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A888911171
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 02:45:36 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1od79i-0001bA-5M; Tue, 27 Sep 2022 11:45:34 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1od79h-000D8e-W1; Tue, 27 Sep 2022 11:45:34 +0200
Subject: Re: [PATCH bpf-next v2 1/2] bpf,x64: use shrx/sarx/shlx when
 available
To:     Jie Meng <jmeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
References: <a6d54d1e-f525-0351-18bd-647ea3d4814f@iogearbox.net>
 <20220924003211.775483-1-jmeng@fb.com> <20220924003211.775483-2-jmeng@fb.com>
 <427a1876-ac4c-ae4d-6320-5055d0a8ab51@iogearbox.net>
 <YzJGBx/7BED9Bwwm@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7437e1cb-325c-fc86-37f6-3422c085007d@iogearbox.net>
Date:   Tue, 27 Sep 2022 11:45:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YzJGBx/7BED9Bwwm@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26671/Tue Sep 27 09:56:57 2022)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/27/22 2:38 AM, Jie Meng wrote:
> On Mon, Sep 26, 2022 at 09:16:41PM +0200, Daniel Borkmann wrote:
>> On 9/24/22 2:32 AM, Jie Meng wrote:
>>> Instead of shr/sar/shl that implicitly use %cl, emit their more flexible
>>> alternatives provided in BMI2
>>>
>>> Signed-off-by: Jie Meng <jmeng@fb.com>
>>> ---
>>>    arch/x86/net/bpf_jit_comp.c | 53 +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 53 insertions(+)
>>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index ae89f4143eb4..2227d81a5e44 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -889,6 +889,35 @@ static void emit_nops(u8 **pprog, int len)
>>>    	*pprog = prog;
>>>    }
>>> +static void emit_3vex(u8 **pprog, bool r, bool x, bool b, u8 m,
>>> +		      bool w, u8 src_reg2, bool l, u8 p)
>>> +{
>>> +	u8 *prog = *pprog;
>>> +	u8 b0 = 0xc4, b1, b2;
>>> +	u8 src2 = reg2hex[src_reg2];
>>> +
>>> +	if (is_ereg(src_reg2))
>>> +		src2 |= 1 << 3;
>>> +
>>> +	/*
>>> +	 *    7                           0
>>> +	 *  +---+---+---+---+---+---+---+---+
>>> +	 *  |~R |~X |~B |         m         |
>>> +	 *  +---+---+---+---+---+---+---+---+
>>> +	 */
>>> +	b1 = (!r << 7) | (!x << 6) | (!b << 5) | (m & 0x1f);
>>> +	/*
>>> +	 *    7                           0
>>> +	 *  +---+---+---+---+---+---+---+---+
>>> +	 *  | W |     ~vvvv     | L |   pp  |
>>> +	 *  +---+---+---+---+---+---+---+---+
>>> +	 */
>>> +	b2 = (w << 7) | ((~src2 & 0xf) << 3) | (l << 2) | (p & 3);
>>> +
>>> +	EMIT3(b0, b1, b2);
>>> +	*pprog = prog;
>>> +}
>>> +
>>>    #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>>>    static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>>> @@ -1135,7 +1164,31 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>>    		case BPF_ALU64 | BPF_LSH | BPF_X:
>>>    		case BPF_ALU64 | BPF_RSH | BPF_X:
>>>    		case BPF_ALU64 | BPF_ARSH | BPF_X:
>>> +			if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
>>> +				/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
>>> +				bool r = is_ereg(dst_reg);
>>> +				u8 m = 2; /* escape code 0f38 */
>>> +				bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
>>
>> Looks like you just pass all the above vars into emit_3vex(), so why not hide them
>> there directly? The only thing really needed is p (and should probably be called op?),
>> so you just pass emit_3vex(&prog, op, dst_reg, src_reg)..
> 
> emit_3vex() is to encode the 3 bytes VEX prefix and exposes all the
> information that can be encoded. The wish is to make it reusable for future
> instructions that may use VEX so I deliberately avoided hardcoding anything that is specific to a particular instruction.

This bit of context was missing from your description, but I also think it's okay
to do the refactor when the time comes where this gets reused. (You could also just
hide these in an emit_shift which calls emit_3vex or such.. and explain your rationale
in the commit message.)

>> please also improve the
>> commit message a bit, e.g. before/after disasm + opcode hexdump example (e.g. extract
>> from bpftool dump) would be nice and also add a sentence about the BPF_REG_4 limitation
>> case.
> 
> Sure I can do that but would like to know your opinion about emit_3vex()
> first.
>   
>>> +				u8 p;
>>> +
>>> +				switch (BPF_OP(insn->code)) {
>>> +				case BPF_LSH:
>>> +					p = 1; /* prefix 0x66 */
>>> +					break;
>>> +				case BPF_RSH:
>>> +					p = 3; /* prefix 0xf2 */
>>> +					break;
>>> +				case BPF_ARSH:
>>> +					p = 2; /* prefix 0xf3 */
>>> +					break;
>>> +				}
>>> +
>>> +				emit_3vex(&prog, r, false, r, m,
>>> +					  w, src_reg, false, p);
>>> +				EMIT2(0xf7, add_2reg(0xC0, dst_reg, dst_reg));
>>> +				break;
>>> +			}
>>>    			/* Check for bad case when dst_reg == rcx */
>>>    			if (dst_reg == BPF_REG_4) {
>>>    				/* mov r11, dst_reg */
>>>
