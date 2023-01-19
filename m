Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE53674789
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjASXws (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjASXwr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 18:52:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796A8222FF
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 15:52:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vw16so9903313ejc.12
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 15:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rrbdmzDskbL2M7HeuxMHmZBImDUkBvFGEZkrl6kbsNk=;
        b=gaexHr3JdQ3aWT+YEYaEtwlqutd5MUdEfE6ZpVHiVOTUx9rVTIAVWYkPWfbxMTWgaE
         qb3UlMBqYD6WmuadOoaUsRT8rCB4lPCCoMOzu4G0c0sS2G+pCQZ11YA4u0PGaANvzeCc
         tLolc7MgnLxngMCmot8iL7ymJxKX4JZxA2nw/JOY0qrJeuvlzWvDblwi13xR9DYcEam2
         0Cl1kryzcwqHDKL7zf6XKGhoek1RNJDL7ODEkpZT3GW3kJPW0/TV5S6AHbfNdoov3a1H
         ialGgfyD+e/b46n9vIRViTpRBwxVDBxXoU8p6nrlLR294jXeMmfNJk29KMixC4CJSXmg
         hlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrbdmzDskbL2M7HeuxMHmZBImDUkBvFGEZkrl6kbsNk=;
        b=ZPX5r+PKv183RWDrw3H7HcVj5KpJBuVbzernX3ddBE5l7V2T1zVXHhOnlEZHty0rWk
         VZ6iwyr4bEx8lJk5Pnv1tgCvP1Z5DIzn2A3inXk26c/vtdalHHudUGtFOeMy6/DvfttB
         rSnzD0/AoixpMMQSlDiuJh+ni5IPI04BDY0+UHKAKc2REi/uPpFYzZHMJZ1UKY1MMEXD
         oBrptsIlPOeBIAXGDYTY4udtyz8gpBHIiu3SjJySD8bTblLGKFY0abdafdgYHIXu4p+a
         P7FfsHra+J8cUXAM9+htoKa9/kEZGKl/dahMzic4if7uOw3mKFi9bMrm3FM//GzGDcpT
         e89w==
X-Gm-Message-State: AFqh2kpZ+6Sq8kDS14zn2Sxda+3P7LQKVtrvEf6k5M88zDCRSua+uN9W
        GdBDbbJLUfxPaOGVFh4+1gYnbSt+fsLlVKa//jA=
X-Google-Smtp-Source: AMrXdXudq4jbWeAoiK5tSNJ+LYwaEJV+nKknxu/M4sGZRkalM/mmM+CtvOOOwZVEUPTtGysncTvBMAW+T+DTBO999EI=
X-Received: by 2002:a17:906:8294:b0:867:cbca:a397 with SMTP id
 h20-20020a170906829400b00867cbcaa397mr1067566ejx.87.1674172363721; Thu, 19
 Jan 2023 15:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20230106142214.1040390-1-eddyz87@gmail.com> <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
 <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
 <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
 <b836c36a68b670df8f649db621bb3ec74e03ef9b.camel@gmail.com>
 <CAEf4Bza8q2P1mqN4LYwiYqssBiQDorjkFaZDsudOQFCb2825Vw@mail.gmail.com> <CAEf4BzY9ikdrT5WN__QJgaYhWJ=h0Do8T7YkiYLpT9VftqecVg@mail.gmail.com>
In-Reply-To: <CAEf4BzY9ikdrT5WN__QJgaYhWJ=h0Do8T7YkiYLpT9VftqecVg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 19 Jan 2023 15:52:31 -0800
Message-ID: <CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 5:31 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 5:17 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 13, 2023 at 4:10 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Fri, 2023-01-13 at 14:22 -0800, Andrii Nakryiko wrote:
> > > > On Fri, Jan 13, 2023 at 12:02 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > > >
> > > > > On Wed, 2023-01-11 at 16:24 -0800, Andrii Nakryiko wrote:
> > > > > [...]
> > > > > >
> > > > > > I'm wondering if we should consider allowing uninitialized
> > > > > > (STACK_INVALID) reads from stack, in general. It feels like it's
> > > > > > causing more issues than is actually helpful in practice. Common code
> > > > > > pattern is to __builtin_memset() some struct first, and only then
> > > > > > initialize it, basically doing unnecessary work of zeroing out. All
> > > > > > just to avoid verifier to complain about some irrelevant padding not
> > > > > > being initialized. I haven't thought about this much, but it feels
> > > > > > that STACK_MISC (initialized, but unknown scalar value) is basically
> > > > > > equivalent to STACK_INVALID for all intents and purposes. Thoughts?
> > > > >
> > > > > Do you have an example of the __builtin_memset() usage?
> > > > > I tried passing partially initialized stack allocated structure to
> > > > > bpf_map_update_elem() and bpf_probe_write_user() and verifier did not
> > > > > complain.
> > > > >
> > > > > Regarding STACK_MISC vs STACK_INVALID, I think it's ok to replace
> > > > > STACK_INVALID with STACK_MISC if we are talking about STX/LDX/ALU
> > > > > instructions because after LDX you would get a full range register and
> > > > > you can't do much with a full range value. However, if a structure
> > > > > containing un-initialized fields (e.g. not just padding) is passed to
> > > > > a helper or kfunc is it an error?
> > > >
> > > > if we are passing stack as a memory to helper/kfunc (which should be
> > > > the only valid use case with STACK_MISC, right?), then I think we
> > > > expect helper/kfunc to treat it as memory with unknowable contents.
> > > > Not sure if I'm missing something, but MISC says it's some unknown
> > > > value, and the only difference between INVALID and MISC is that MISC's
> > > > value was written by program explicitly, while for INVALID that
> > > > garbage value was there on the stack already (but still unknowable
> > > > scalar), which effectively is the same thing.
> > >
> > > I looked through the places where STACK_INVALID is used, here is the list:
> > >
> > > - unmark_stack_slots_dynptr()
> > >   Destroy dynptr marks. Suppose STACK_INVALID is replaced by
> > >   STACK_MISC here, in this case a scalar read would be possible from
> > >   such slot, which in turn might lead to pointer leak.
> > >   Might be a problem?
> >
> > We are already talking to enable reading STACK_DYNPTR slots directly.
> > So not a problem?
> >
> > >
> > > - scrub_spilled_slot()
> > >   mark spill slot STACK_MISC if not STACK_INVALID
> > >   Called from:
> > >   - save_register_state() called from check_stack_write_fixed_off()
> > >     Would mark not all slots only for 32-bit writes.
> > >   - check_stack_write_fixed_off() for insns like `fp[-8] = <const>` to
> > >     destroy previous stack marks.
> > >   - check_stack_range_initialized()
> > >     here it always marks all 8 spi slots as STACK_MISC.
> > >   Looks like STACK_MISC instead of STACK_INVALID wouldn't make a
> > >   difference in these cases.
> > >
> > > - check_stack_write_fixed_off()
> > >   Mark insn as sanitize_stack_spill if pointer is spilled to a stack
> > >   slot that is marked STACK_INVALID. This one is a bit strange.
> > >   E.g. the program like this:
> > >
> > >     ...
> > >     42:  fp[-8] = ptr
> > >     ...
> > >
> > >   Will mark insn (42) as sanitize_stack_spill.
> > >   However, the program like this:
> > >
> > >     ...
> > >     21:  fp[-8] = 22   ;; marks as STACK_MISC
> > >     ...
> > >     42:  fp[-8] = ptr
> > >     ...
> > >
> > >   Won't mark insn (42) as sanitize_stack_spill, which seems strange.
> > >
> > > - stack_write_var_off()
> > >   If !env->allow_ptr_leaks only allow writes if slots are not
> > >   STACK_INVALID. I'm not sure I understand the intention.
> > >
> > > - clean_func_state()
> > >   STACK_INVALID is used to mark spi's that are not REG_LIVE_READ as
> > >   such that should not take part in the state comparison. However,
> > >   stacksafe() has REG_LIVE_READ check as well, so this marking might
> > >   be unnecessary.
> > >
> > > - stacksafe()
> > >   STACK_INVALID is used as a mark that some bytes of an spi are not
> > >   important in a state cached for state comparison. E.g. a slot in an
> > >   old state might be marked 'mmmm????' and 'mmmmmmmm' or 'mmmm0000' in
> > >   a new state. However other checks in stacksafe() would catch these
> > >   variations.
> > >
> > > The conclusion being that some pointer leakage checks might need
> > > adjustment if STACK_INVALID is replaced by STACK_MISC.
> >
> > Just to be clear. My suggestion was to *treat* STACK_INVALID as
> > equivalent to STACK_MISC in stacksafe(), not really replace all the
> > uses of STACK_INVALID with STACK_MISC. And to be on the safe side, I'd
> > do it only if env->allow_ptr_leaks, of course.
>
> Well, that, and to allow STACK_INVALID if env->allow_ptr_leaks in
> check_stack_read_fixed_off(), of course, to avoid "invalid read from
> stack off %d+%d size %d\n" error (that's fixing at least part of the
> problem with uninitialized struct padding).

+1 to Andrii's idea.
It should help us recover this small increase in processed states.

Eduard,

The fix itself is brilliant. Thank you for investigating
and providing the detailed explanation.
I've read this thread and the previous one,
walked through all the points and it all looks correct.
Sorry it took me a long time to remember the details
of liveness logic to review it properly.

While you, Andrii and me keep this tricky knowledge in our
heads could you please document how liveness works in
Documentation/bpf/verifier.rst ?
We'll be able to review it now and next time it will be
easier to remember.

I've tried Andrii's suggestion:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7ee218827259..0f71ba6a56e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3591,7 +3591,7 @@ static int check_stack_read_fixed_off(struct
bpf_verifier_env *env,

copy_register_state(&state->regs[dst_regno], reg);
                                state->regs[dst_regno].subreg_def = subreg_def;
                        } else {
-                               for (i = 0; i < size; i++) {
+                               for (i = 0; i < size &&
!env->allow_uninit_stack; i++) {
                                        type = stype[(slot - i) % BPF_REG_SIZE];
                                        if (type == STACK_SPILL)
                                                continue;
@@ -3628,7 +3628,7 @@ static int check_stack_read_fixed_off(struct
bpf_verifier_env *env,
                }
                mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
        } else {
-               for (i = 0; i < size; i++) {
+               for (i = 0; i < size && !env->allow_uninit_stack; i++) {
                        type = stype[(slot - i) % BPF_REG_SIZE];
                        if (type == STACK_MISC)
                                continue;
@@ -13208,6 +13208,10 @@ static bool stacksafe(struct bpf_verifier_env
*env, struct bpf_func_state *old,
                if (old->stack[spi].slot_type[i % BPF_REG_SIZE] ==
STACK_INVALID)
                        continue;

+               if (env->allow_uninit_stack &&
+                   old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
+                       continue;

and only dynptr/invalid_read[134] tests failed
which is expected and acceptable.
We can tweak those tests.

Could you take over this diff, run veristat analysis and
submit it as an official patch? I suspect we should see nice
improvements in states processed.

Thanks!
