Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3440662C53D
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiKPQqY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 11:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbiKPQqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 11:46:06 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64BA25C58;
        Wed, 16 Nov 2022 08:41:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NC7tg2nwfz9v7Hb;
        Thu, 17 Nov 2022 00:34:51 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCnRXKgEnVjK3ptAA--.39850S2;
        Wed, 16 Nov 2022 17:41:16 +0100 (CET)
Message-ID: <05bf553f795ac93ea3032cfc1b56ca35fd6a920a.camel@huaweicloud.com>
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
Date:   Wed, 16 Nov 2022 17:41:00 +0100
In-Reply-To: <CAADnVQLQswvu3oGyeevLrKMT200yD4hzCbkBUAs=1bKSDVaOQg@mail.gmail.com>
References: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
         <20221116154712.4115929-1-roberto.sassu@huaweicloud.com>
         <CAADnVQLQswvu3oGyeevLrKMT200yD4hzCbkBUAs=1bKSDVaOQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCnRXKgEnVjK3ptAA--.39850S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF18GF1UuFWUuFy5GFyUZFb_yoW5Xw1kpr
        WrGFWYkF4DZ3yxGrWqyw45Cw4rX34fJr48G345K348Aayayw1xtw1UKF1Y9F4UCr4vg34F
        9FZrZ34fCwnrZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj4WFggACsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-11-16 at 08:16 -0800, Alexei Starovoitov wrote:
> On Wed, Nov 16, 2022 at 7:48 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > +static bool is_ret_value_allowed(int ret, u32 ret_flags)
> > +{
> > +       if ((ret < 0 && !(ret_flags & LSM_RET_NEG)) ||
> > +           (ret == 0 && !(ret_flags & LSM_RET_ZERO)) ||
> > +           (ret == 1 && !(ret_flags & LSM_RET_ONE)) ||
> > +           (ret > 1 && !(ret_flags & LSM_RET_GT_ONE)))
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
> >  /* For every LSM hook that allows attachment of BPF programs, declare a nop
> >   * function where a BPF program can be attached.
> >   */
> > @@ -30,6 +41,15 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)     \
> >  #include <linux/lsm_hook_defs.h>
> >  #undef LSM_HOOK
> > 
> > +#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...)   \
> > +noinline RET bpf_lsm_##NAME##_ret(int ret)     \
> > +{                                              \
> > +       return is_ret_value_allowed(ret, RET_FLAGS) ? ret : DEFAULT; \
> > +}
> > +
> > +#include <linux/lsm_hook_defs.h>
> > +#undef LSM_HOOK
> > +
> 
> because lsm hooks is mess of undocumented return values your
> "solution" is to add hundreds of noninline functions
> and hack the call into them in JITs ?!

I revisited the documentation and checked each LSM hook one by one.
Hopefully, I completed it correctly, but I would review again (others
are also welcome to do it).

Not sure if there is a more efficient way. Do you have any idea?
Maybe we find a way to use only one check function (by reusing the
address of the attachment point?).

Regarding the JIT approach, I didn't find a reliable solution for using
just the verifier. As I wrote to you, there could be the case where the
range can include positive values, despite the possible return values
are zero and -EACCES.

# ./test_progs-no_alu32 -t libbpf_get_fd

*reg = {type = SCALAR_VALUE, off = 0, {range = 0, {map_ptr = 0x0
<fixed_percpu_data>, map_uid = 0}, {btf = 0x0 <fixed_percpu_data>,
btf_id = 0}, mem_size = 0, dynptr = {type = BPF_DYNPTR_TYPE_INVALID,
first_slot = false}, raw = {raw1 = 0, raw2 = 0}, subprogno = 0}, id =
0, 
  ref_obj_id = 0, var_off = {value = 0, mask = 18446744073709551603},
smin_value = -9223372036854775808, smax_value = 9223372036854775795,
umin_value = 0, umax_value = 18446744073709551603, s32_min_value =
-2147483648, s32_max_value = 2147483635, u32_min_value = 0, 
  u32_max_value = 4294967283, parent = 0x0 <fixed_percpu_data>, frameno
= 0, subreg_def = 0, live = REG_LIVE_WRITTEN, precise = false}

The JIT approach instead is 100% reliable, as you check the real value
to be returned to BPF LSM.

But of course, the performance will be worse this way. If you are able
to determine at verification time that an eBPF program is not going to
return illegal values, that would be better. I'm not sure it is
feasible.

Thanks

Roberto

