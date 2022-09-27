Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE01F5EB655
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 02:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiI0Aih (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 20:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiI0Aig (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 20:38:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500936D561
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 17:38:35 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28QKCh7p009919
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 17:38:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=bGvrqNzplH30diPQcl4UZ0tSUliRCldsvG9Msq5UB9I=;
 b=IFEZx24OCwfQXj6ZhXKT3nkoP0z4bCz/O6cOmQef24OYsbC782r4Ba13hXyAvhJzWM7L
 rtSJhea61J3Si4j9CTJYphvB4WjkzK3tj8fNM5xtma9O1EBbJuRx+/oBusKrxpIu9kjX
 /FwEoCYBOutit7s0W1raUAqTzjfzRG6Ipd0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3jswjuqn7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 17:38:34 -0700
Received: from twshared20183.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:38:33 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id 21F0710AA009B; Mon, 26 Sep 2022 17:38:31 -0700 (PDT)
Date:   Mon, 26 Sep 2022 17:38:31 -0700
From:   Jie Meng <jmeng@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf,x64: use shrx/sarx/shlx when
 available
Message-ID: <YzJGBx/7BED9Bwwm@fb.com>
References: <a6d54d1e-f525-0351-18bd-647ea3d4814f@iogearbox.net>
 <20220924003211.775483-1-jmeng@fb.com>
 <20220924003211.775483-2-jmeng@fb.com>
 <427a1876-ac4c-ae4d-6320-5055d0a8ab51@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <427a1876-ac4c-ae4d-6320-5055d0a8ab51@iogearbox.net>
X-FB-Internal: Safe
X-Proofpoint-GUID: UTCVay6fn2w601kQDCLpZs6U6mS7F4Y9
X-Proofpoint-ORIG-GUID: UTCVay6fn2w601kQDCLpZs6U6mS7F4Y9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 26, 2022 at 09:16:41PM +0200, Daniel Borkmann wrote:
> On 9/24/22 2:32 AM, Jie Meng wrote:
> > Instead of shr/sar/shl that implicitly use %cl, emit their more flexible
> > alternatives provided in BMI2
> > 
> > Signed-off-by: Jie Meng <jmeng@fb.com>
> > ---
> >   arch/x86/net/bpf_jit_comp.c | 53 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 53 insertions(+)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index ae89f4143eb4..2227d81a5e44 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -889,6 +889,35 @@ static void emit_nops(u8 **pprog, int len)
> >   	*pprog = prog;
> >   }
> > +static void emit_3vex(u8 **pprog, bool r, bool x, bool b, u8 m,
> > +		      bool w, u8 src_reg2, bool l, u8 p)
> > +{
> > +	u8 *prog = *pprog;
> > +	u8 b0 = 0xc4, b1, b2;
> > +	u8 src2 = reg2hex[src_reg2];
> > +
> > +	if (is_ereg(src_reg2))
> > +		src2 |= 1 << 3;
> > +
> > +	/*
> > +	 *    7                           0
> > +	 *  +---+---+---+---+---+---+---+---+
> > +	 *  |~R |~X |~B |         m         |
> > +	 *  +---+---+---+---+---+---+---+---+
> > +	 */
> > +	b1 = (!r << 7) | (!x << 6) | (!b << 5) | (m & 0x1f);
> > +	/*
> > +	 *    7                           0
> > +	 *  +---+---+---+---+---+---+---+---+
> > +	 *  | W |     ~vvvv     | L |   pp  |
> > +	 *  +---+---+---+---+---+---+---+---+
> > +	 */
> > +	b2 = (w << 7) | ((~src2 & 0xf) << 3) | (l << 2) | (p & 3);
> > +
> > +	EMIT3(b0, b1, b2);
> > +	*pprog = prog;
> > +}
> > +
> >   #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
> >   static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
> > @@ -1135,7 +1164,31 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> >   		case BPF_ALU64 | BPF_LSH | BPF_X:
> >   		case BPF_ALU64 | BPF_RSH | BPF_X:
> >   		case BPF_ALU64 | BPF_ARSH | BPF_X:
> > +			if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
> > +				/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
> > +				bool r = is_ereg(dst_reg);
> > +				u8 m = 2; /* escape code 0f38 */
> > +				bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
> 
> Looks like you just pass all the above vars into emit_3vex(), so why not hide them
> there directly? The only thing really needed is p (and should probably be called op?),
> so you just pass emit_3vex(&prog, op, dst_reg, src_reg).. 

emit_3vex() is to encode the 3 bytes VEX prefix and exposes all the
information that can be encoded. The wish is to make it reusable for future
instructions that may use VEX so I deliberately avoided hardcoding anything that is specific to a particular instruction.

> please also improve the
> commit message a bit, e.g. before/after disasm + opcode hexdump example (e.g. extract
> from bpftool dump) would be nice and also add a sentence about the BPF_REG_4 limitation
> case.
>

Sure I can do that but would like to know your opinion about emit_3vex()
first.
 
> > +				u8 p;
> > +
> > +				switch (BPF_OP(insn->code)) {
> > +				case BPF_LSH:
> > +					p = 1; /* prefix 0x66 */
> > +					break;
> > +				case BPF_RSH:
> > +					p = 3; /* prefix 0xf2 */
> > +					break;
> > +				case BPF_ARSH:
> > +					p = 2; /* prefix 0xf3 */
> > +					break;
> > +				}
> > +
> > +				emit_3vex(&prog, r, false, r, m,
> > +					  w, src_reg, false, p);
> > +				EMIT2(0xf7, add_2reg(0xC0, dst_reg, dst_reg));
> > +				break;
> > +			}
> >   			/* Check for bad case when dst_reg == rcx */
> >   			if (dst_reg == BPF_REG_4) {
> >   				/* mov r11, dst_reg */
> > 
> 
