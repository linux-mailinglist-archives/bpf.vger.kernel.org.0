Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9366A850
	for <lists+bpf@lfdr.de>; Sat, 14 Jan 2023 02:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjANBbO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 20:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjANBbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 20:31:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BA72BEC
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 17:31:06 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id fy8so56050006ejc.13
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 17:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uRJGZ74bpZQfNwKmKMW7zfvNaXTFAzOysYJvn4U5o3o=;
        b=d96EweZFgjpWYsAkk8b039xuK5G1XC8wNJjk7K1oQxosaMiWXrqzGL2h3Wme18B06/
         7AOPGnh353S9HMab0F9WJM7nDnyFpaoDM0Ma2MzMfFv/GZ5QY4qFWgY7vzIt1HPHCiDA
         ytzz2ZN82z0qHcsq3YCdMlm32Uo77vSjHGz1rbNBygty9KsDyglSsb5AUYBk5axn/X+a
         QagPgkb+VF2fJxGsd9kU5xiQ3U8YfPia4lv6rbS6dMCDDKbsB/nhW1QslPEzrZOGToCV
         t8D+lxmUtYsa8zZFyqUTVH6Zx1EhoWQpz4XRDfE3YJFymZ45zjDGyfIazpWvN30OkcrX
         HVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRJGZ74bpZQfNwKmKMW7zfvNaXTFAzOysYJvn4U5o3o=;
        b=Rm39OtGkw2RXFW68eGxd90BAxMIVwjeSSEl2kUksO+4KARzwPFC+tT4jjZRdLywjfG
         sZFIAOkUaO+OXE4RemTLsavtvsHMba6j2tT7YttdilIMyWtzQ+ck2vq6mrKlFcwAOQbI
         UKRmocSUkrahAhuRGm1dFbVkSBUQt2AX3rj3jRrTCbHNjiBPgI2dwzRyTqPd059YlVG/
         o1plNKggnoAlypLBoPJkZGddDK0Y6FgJwY/LJS6IrXupzyzpRrp6e/iryx1wqQdhWXsz
         5m3C3z8vF6CQJe7N12WFTlwH/bLMwyCL/9eJIIc4B6fRpYGGrUYVEx0gMqIm0yLmpexD
         VylQ==
X-Gm-Message-State: AFqh2kp2pmgT7xlFf+wzBmSC5ZguCW2o8xl1RsJZ/7SRi4HxXTfQSb9D
        iiCgUOhTcACYCxnngkLOYualAA2PH8H7hrgzvB8=
X-Google-Smtp-Source: AMrXdXvBI4xaBLvCvVriYdCgwUJFMpp18fygUXQuEa6A4f3gVuqo8HcBqaZj2o6te5ou4rB/NMBiu9GQQ6T+aBhgBfQ=
X-Received: by 2002:a17:906:75a:b0:855:d6ed:60d8 with SMTP id
 z26-20020a170906075a00b00855d6ed60d8mr1088408ejb.302.1673659865021; Fri, 13
 Jan 2023 17:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20230106142214.1040390-1-eddyz87@gmail.com> <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
 <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
 <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
 <b836c36a68b670df8f649db621bb3ec74e03ef9b.camel@gmail.com> <CAEf4Bza8q2P1mqN4LYwiYqssBiQDorjkFaZDsudOQFCb2825Vw@mail.gmail.com>
In-Reply-To: <CAEf4Bza8q2P1mqN4LYwiYqssBiQDorjkFaZDsudOQFCb2825Vw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Jan 2023 17:30:53 -0800
Message-ID: <CAEf4BzY9ikdrT5WN__QJgaYhWJ=h0Do8T7YkiYLpT9VftqecVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Fri, Jan 13, 2023 at 5:17 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 4:10 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Fri, 2023-01-13 at 14:22 -0800, Andrii Nakryiko wrote:
> > > On Fri, Jan 13, 2023 at 12:02 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > >
> > > > On Wed, 2023-01-11 at 16:24 -0800, Andrii Nakryiko wrote:
> > > > [...]
> > > > >
> > > > > I'm wondering if we should consider allowing uninitialized
> > > > > (STACK_INVALID) reads from stack, in general. It feels like it's
> > > > > causing more issues than is actually helpful in practice. Common code
> > > > > pattern is to __builtin_memset() some struct first, and only then
> > > > > initialize it, basically doing unnecessary work of zeroing out. All
> > > > > just to avoid verifier to complain about some irrelevant padding not
> > > > > being initialized. I haven't thought about this much, but it feels
> > > > > that STACK_MISC (initialized, but unknown scalar value) is basically
> > > > > equivalent to STACK_INVALID for all intents and purposes. Thoughts?
> > > >
> > > > Do you have an example of the __builtin_memset() usage?
> > > > I tried passing partially initialized stack allocated structure to
> > > > bpf_map_update_elem() and bpf_probe_write_user() and verifier did not
> > > > complain.
> > > >
> > > > Regarding STACK_MISC vs STACK_INVALID, I think it's ok to replace
> > > > STACK_INVALID with STACK_MISC if we are talking about STX/LDX/ALU
> > > > instructions because after LDX you would get a full range register and
> > > > you can't do much with a full range value. However, if a structure
> > > > containing un-initialized fields (e.g. not just padding) is passed to
> > > > a helper or kfunc is it an error?
> > >
> > > if we are passing stack as a memory to helper/kfunc (which should be
> > > the only valid use case with STACK_MISC, right?), then I think we
> > > expect helper/kfunc to treat it as memory with unknowable contents.
> > > Not sure if I'm missing something, but MISC says it's some unknown
> > > value, and the only difference between INVALID and MISC is that MISC's
> > > value was written by program explicitly, while for INVALID that
> > > garbage value was there on the stack already (but still unknowable
> > > scalar), which effectively is the same thing.
> >
> > I looked through the places where STACK_INVALID is used, here is the list:
> >
> > - unmark_stack_slots_dynptr()
> >   Destroy dynptr marks. Suppose STACK_INVALID is replaced by
> >   STACK_MISC here, in this case a scalar read would be possible from
> >   such slot, which in turn might lead to pointer leak.
> >   Might be a problem?
>
> We are already talking to enable reading STACK_DYNPTR slots directly.
> So not a problem?
>
> >
> > - scrub_spilled_slot()
> >   mark spill slot STACK_MISC if not STACK_INVALID
> >   Called from:
> >   - save_register_state() called from check_stack_write_fixed_off()
> >     Would mark not all slots only for 32-bit writes.
> >   - check_stack_write_fixed_off() for insns like `fp[-8] = <const>` to
> >     destroy previous stack marks.
> >   - check_stack_range_initialized()
> >     here it always marks all 8 spi slots as STACK_MISC.
> >   Looks like STACK_MISC instead of STACK_INVALID wouldn't make a
> >   difference in these cases.
> >
> > - check_stack_write_fixed_off()
> >   Mark insn as sanitize_stack_spill if pointer is spilled to a stack
> >   slot that is marked STACK_INVALID. This one is a bit strange.
> >   E.g. the program like this:
> >
> >     ...
> >     42:  fp[-8] = ptr
> >     ...
> >
> >   Will mark insn (42) as sanitize_stack_spill.
> >   However, the program like this:
> >
> >     ...
> >     21:  fp[-8] = 22   ;; marks as STACK_MISC
> >     ...
> >     42:  fp[-8] = ptr
> >     ...
> >
> >   Won't mark insn (42) as sanitize_stack_spill, which seems strange.
> >
> > - stack_write_var_off()
> >   If !env->allow_ptr_leaks only allow writes if slots are not
> >   STACK_INVALID. I'm not sure I understand the intention.
> >
> > - clean_func_state()
> >   STACK_INVALID is used to mark spi's that are not REG_LIVE_READ as
> >   such that should not take part in the state comparison. However,
> >   stacksafe() has REG_LIVE_READ check as well, so this marking might
> >   be unnecessary.
> >
> > - stacksafe()
> >   STACK_INVALID is used as a mark that some bytes of an spi are not
> >   important in a state cached for state comparison. E.g. a slot in an
> >   old state might be marked 'mmmm????' and 'mmmmmmmm' or 'mmmm0000' in
> >   a new state. However other checks in stacksafe() would catch these
> >   variations.
> >
> > The conclusion being that some pointer leakage checks might need
> > adjustment if STACK_INVALID is replaced by STACK_MISC.
>
> Just to be clear. My suggestion was to *treat* STACK_INVALID as
> equivalent to STACK_MISC in stacksafe(), not really replace all the
> uses of STACK_INVALID with STACK_MISC. And to be on the safe side, I'd
> do it only if env->allow_ptr_leaks, of course.

Well, that, and to allow STACK_INVALID if env->allow_ptr_leaks in
check_stack_read_fixed_off(), of course, to avoid "invalid read from
stack off %d+%d size %d\n" error (that's fixing at least part of the
problem with uninitialized struct padding).

>
> >
> > >
> > > >
> > > > > Obviously, this is a completely separate change and issue from what
> > > > > you are addressing in this patch set.
> > > > >
> > > > > Awesome job on tracking this down and fixing it! For the patch set:
> > > >
> > > > Thank you for reviewing this issue with me.
> > > >
> > > > >
> > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > >
> > > > >
> > > > [...]
> >
