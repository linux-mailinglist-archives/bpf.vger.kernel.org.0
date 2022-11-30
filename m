Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8586963D73B
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 14:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiK3NxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 08:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiK3NxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 08:53:20 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE948428;
        Wed, 30 Nov 2022 05:53:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NMgTg3PMSz9xHZ9;
        Wed, 30 Nov 2022 21:46:15 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCnRXIpYIdjFoOrAA--.3628S2;
        Wed, 30 Nov 2022 14:52:53 +0100 (CET)
Message-ID: <30f658418386dd55aef5d109a52b7a32c4678648.camel@huaweicloud.com>
Subject: Re: [PoC][PATCH] bpf: Call return value check function in the JITed
 code
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 30 Nov 2022 14:52:38 +0100
In-Reply-To: <CAADnVQJu7isDCi4+f8s4LfiwcYJbN4kXkvgJ8+ZnsS+QGDVnMw@mail.gmail.com>
References: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
         <20221116154712.4115929-1-roberto.sassu@huaweicloud.com>
         <CAADnVQLQswvu3oGyeevLrKMT200yD4hzCbkBUAs=1bKSDVaOQg@mail.gmail.com>
         <05bf553f795ac93ea3032cfc1b56ca35fd6a920a.camel@huaweicloud.com>
         <CAADnVQJu7isDCi4+f8s4LfiwcYJbN4kXkvgJ8+ZnsS+QGDVnMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCnRXIpYIdjFoOrAA--.3628S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF18GrW5Wr43Jw4xCF18uFg_yoWrCw1rpr
        W5JF15Gr48Ar18Ar1Utwn8KFs3tF1xA3WUW3s8Ary8Ar13Kry3Jr1UGr4Yka1DAr1ktryS
        vF1DXr47Kwn8XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4YaIQAAsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-11-16 at 09:55 -0800, Alexei Starovoitov wrote:
> On Wed, Nov 16, 2022 at 8:41 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Wed, 2022-11-16 at 08:16 -0800, Alexei Starovoitov wrote:
> > > On Wed, Nov 16, 2022 at 7:48 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > +static bool is_ret_value_allowed(int ret, u32 ret_flags)
> > > > +{
> > > > +       if ((ret < 0 && !(ret_flags & LSM_RET_NEG)) ||
> > > > +           (ret == 0 && !(ret_flags & LSM_RET_ZERO)) ||
> > > > +           (ret == 1 && !(ret_flags & LSM_RET_ONE)) ||
> > > > +           (ret > 1 && !(ret_flags & LSM_RET_GT_ONE)))
> > > > +               return false;
> > > > +
> > > > +       return true;
> > > > +}
> > > > +
> > > >  /* For every LSM hook that allows attachment of BPF programs, declare a nop
> > > >   * function where a BPF program can be attached.
> > > >   */
> > > > @@ -30,6 +41,15 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)     \
> > > >  #include <linux/lsm_hook_defs.h>
> > > >  #undef LSM_HOOK
> > > > 
> > > > +#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...)   \
> > > > +noinline RET bpf_lsm_##NAME##_ret(int ret)     \
> > > > +{                                              \
> > > > +       return is_ret_value_allowed(ret, RET_FLAGS) ? ret : DEFAULT; \
> > > > +}
> > > > +
> > > > +#include <linux/lsm_hook_defs.h>
> > > > +#undef LSM_HOOK
> > > > +
> > > 
> > > because lsm hooks is mess of undocumented return values your
> > > "solution" is to add hundreds of noninline functions
> > > and hack the call into them in JITs ?!
> > 
> > I revisited the documentation and checked each LSM hook one by one.
> > Hopefully, I completed it correctly, but I would review again (others
> > are also welcome to do it).
> > 
> > Not sure if there is a more efficient way. Do you have any idea?
> > Maybe we find a way to use only one check function (by reusing the
> > address of the attachment point?).
> > 
> > Regarding the JIT approach, I didn't find a reliable solution for using
> > just the verifier. As I wrote to you, there could be the case where the
> > range can include positive values, despite the possible return values
> > are zero and -EACCES.
> 
> Didn't you find that there are only 12 or so odd return cases.
> Maybe refactor some of them to something that the verifier can enforce
> and denylist the rest ?

Ok, went back to trying to enforce the return value on the verifier
side, assuming that for now we consider hooks that return zero or a
negative value.

I wanted to see if at least we are able to enforce that.

The biggest problem is which value of the register I should use, the 64
bit one or the 32 bit one?

We can have a look at test_libbpf_get_fd_by_id_opts. The default flavor
gives:

0000000000000000 <check_access>:
       0:	b4 00 00 00 00 00 00 00	w0 = 0
       1:	79 12 00 00 00 00 00 00	r2 = *(u64 *)(r1 + 0)
       2:	18 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00	r3 = 0 ll
       4:	5d 32 05 00 00 00 00 00	if r2 != r3 goto +5 <LBB0_3>
       5:	79 11 08 00 00 00 00 00	r1 = *(u64 *)(r1 + 8)
       6:	57 01 00 00 02 00 00 00	r1 &= 2
       7:	b4 00 00 00 00 00 00 00	w0 = 0
       8:	15 01 01 00 00 00 00 00	if r1 == 0 goto +1 <LBB0_3>
       9:	b4 00 00 00 f3 ff ff ff	w0 = -13

smin_value = 0xfffffff3, smax_value = 0xfffffff3,
s32_min_value = 0xfffffff3, s32_max_value = 0xfffffff3,

I think it is because of this, in check_alu_op():

if (BPF_CLASS(insn->code) == BPF_ALU64) {
	__mark_reg_known(regs + insn->dst_reg,
			 insn->imm);
} else {
	__mark_reg_known(regs + insn->dst_reg,
			 (u32)insn->imm);
	}
}

So, here you have to use the 32 bit values. But, if you use the
no_alu32 flavor:

0000000000000000 <check_access>:
       0:	b7 00 00 00 00 00 00 00	r0 = 0
       1:	79 12 00 00 00 00 00 00	r2 = *(u64 *)(r1 + 0)
       2:	18 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00	r3 = 0 ll
       4:	5d 32 04 00 00 00 00 00	if r2 != r3 goto +4 <LBB0_2>
       5:	79 10 08 00 00 00 00 00	r0 = *(u64 *)(r1 + 8)
       6:	67 00 00 00 3e 00 00 00	r0 <<= 62
       7:	c7 00 00 00 3f 00 00 00	r0 s>>= 63

smin_value = 0xffffffffffffffff, smax_value = 0x0,
s32_min_value = 0x80000000, s32_max_value = 0x7fffffff,

       8:	57 00 00 00 f3 ff ff ff	r0 &= -13

smin_value = 0xfffffffffffffff3, smax_value = 0x7fffffffffffffff,
s32_min_value = 0x80000000, s32_max_value = 0x7ffffff3,

I would have hoped to see:

smin_value = 0xfffffffffffffff3, smax_value = 0x0,

but it doesn't because of this, in scalar_min_max_and():

if (dst_reg->smin_value < 0 || smin_val < 0) {
	/* Lose signed bounds when ANDing negative numbers,
	 * ain't nobody got time for that.
	 */
	dst_reg->smin_value = S64_MIN;
	dst_reg->smax_value = S64_MAX;

Could we do an AND, if src_reg is known?

And what would be the right register value to use?

Thanks

Roberto

