Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C435D6755FF
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 14:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjATNjQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 08:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjATNjP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 08:39:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03F4B497
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 05:39:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m15so4094262wms.4
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 05:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LfxsoWSvciqwxXLs0bYVGCYm8ZMLuHaQ7WKqF8eEwVg=;
        b=qqGqnYg+KyeLS6nDPwPELOIJpWLpv5O4YTMi/JB6P1Bov9UawlVK/C/sXkTernCeJe
         pNNnOQ4O0/0WeWC+rjy1rP+x6/AUsRkcFwOWIBIO/Btc0wuz3YJI4VjbgjZN7sFKFcmZ
         aHaIlaVftc88R6Tkmc7fR4JH+D2X8y0IHWbYwnGKDzdoWSohTTz595y9PaXMD5zufMq3
         mKGbcuhYv6vM++cl/yoFPnEANhLRALSn0k8WR6kITMwTYWn/1KCi17NLpusPczLD2V5o
         kbe6VdQpNyXD85oQJjYEKYpYEXCCbt1dmbahg6QdJExzcFF6WZh9n+lVPiM/IsvCsXW3
         HXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfxsoWSvciqwxXLs0bYVGCYm8ZMLuHaQ7WKqF8eEwVg=;
        b=FuAeCIs0ZjvYlpZ3cSezMWBtjju4mUtH3LTUOgcnAQojOVfUrdou54LAEiKIh6T4Do
         jEgObqmyqpat0SAjKAbaIKST2hajwH+Wj4AkbUr0JfkbPnkDUVj/wC7qzFvOoYQjYkgK
         EEK8gN0MuWCmO7XaJe7n778hJJGj1KALJy1BlW7z6iKfFLY1TdaGicpnXi+y7iwnar0i
         BlD/IC4bFvGQQ6eIi++1/ItFvvghJt1eR4ms2JwKyLgJ5WnOqoKT2TVU5VocHiF1McpK
         7OX7MMLVPdloh3zg6Km9AVE4jxoGHCTVZl/82wsprb0/piRRar0fZ73LShN/XmJsDKYG
         eKOA==
X-Gm-Message-State: AFqh2krOrTp8SMDgzwZ2gNomvvXnwienmypQ94KH387evUPpxRrSUV2i
        2zQ3ugfjrlYcNHdKYBGsLEFSHOE7TLU=
X-Google-Smtp-Source: AMrXdXt/An84s/wWiT4/3vAmOgepY5hBZvwhVYP+8Tzbrj7otAwGbZcilnhfdWbpPuA9p4/u1D1HAA==
X-Received: by 2002:a05:600c:4f08:b0:3db:9e3:3bf1 with SMTP id l8-20020a05600c4f0800b003db09e33bf1mr12944037wmq.31.1674221952530;
        Fri, 20 Jan 2023 05:39:12 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x15-20020a05600c188f00b003db122d5ac2sm2203824wmp.15.2023.01.20.05.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 05:39:11 -0800 (PST)
Message-ID: <9c827da9781034332a94031dc52c39efca5e3049.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Date:   Fri, 20 Jan 2023 15:39:10 +0200
In-Reply-To: <CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com>
References: <20230106142214.1040390-1-eddyz87@gmail.com>
         <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
         <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
         <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
         <b836c36a68b670df8f649db621bb3ec74e03ef9b.camel@gmail.com>
         <CAEf4Bza8q2P1mqN4LYwiYqssBiQDorjkFaZDsudOQFCb2825Vw@mail.gmail.com>
         <CAEf4BzY9ikdrT5WN__QJgaYhWJ=h0Do8T7YkiYLpT9VftqecVg@mail.gmail.com>
         <CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-01-19 at 15:52 -0800, Alexei Starovoitov wrote:
> On Fri, Jan 13, 2023 at 5:31 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >=20
> > On Fri, Jan 13, 2023 at 5:17 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >=20
> > > On Fri, Jan 13, 2023 at 4:10 PM Eduard Zingerman <eddyz87@gmail.com> =
wrote:
> > > >=20
> > > > On Fri, 2023-01-13 at 14:22 -0800, Andrii Nakryiko wrote:
> > > > > On Fri, Jan 13, 2023 at 12:02 PM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > > > > >=20
> > > > > > On Wed, 2023-01-11 at 16:24 -0800, Andrii Nakryiko wrote:
> > > > > > [...]
> > > > > > >=20
> > > > > > > I'm wondering if we should consider allowing uninitialized
> > > > > > > (STACK_INVALID) reads from stack, in general. It feels like i=
t's
> > > > > > > causing more issues than is actually helpful in practice. Com=
mon code
> > > > > > > pattern is to __builtin_memset() some struct first, and only =
then
> > > > > > > initialize it, basically doing unnecessary work of zeroing ou=
t. All
> > > > > > > just to avoid verifier to complain about some irrelevant padd=
ing not
> > > > > > > being initialized. I haven't thought about this much, but it =
feels
> > > > > > > that STACK_MISC (initialized, but unknown scalar value) is ba=
sically
> > > > > > > equivalent to STACK_INVALID for all intents and purposes. Tho=
ughts?
> > > > > >=20
> > > > > > Do you have an example of the __builtin_memset() usage?
> > > > > > I tried passing partially initialized stack allocated structure=
 to
> > > > > > bpf_map_update_elem() and bpf_probe_write_user() and verifier d=
id not
> > > > > > complain.
> > > > > >=20
> > > > > > Regarding STACK_MISC vs STACK_INVALID, I think it's ok to repla=
ce
> > > > > > STACK_INVALID with STACK_MISC if we are talking about STX/LDX/A=
LU
> > > > > > instructions because after LDX you would get a full range regis=
ter and
> > > > > > you can't do much with a full range value. However, if a struct=
ure
> > > > > > containing un-initialized fields (e.g. not just padding) is pas=
sed to
> > > > > > a helper or kfunc is it an error?
> > > > >=20
> > > > > if we are passing stack as a memory to helper/kfunc (which should=
 be
> > > > > the only valid use case with STACK_MISC, right?), then I think we
> > > > > expect helper/kfunc to treat it as memory with unknowable content=
s.
> > > > > Not sure if I'm missing something, but MISC says it's some unknow=
n
> > > > > value, and the only difference between INVALID and MISC is that M=
ISC's
> > > > > value was written by program explicitly, while for INVALID that
> > > > > garbage value was there on the stack already (but still unknowabl=
e
> > > > > scalar), which effectively is the same thing.
> > > >=20
> > > > I looked through the places where STACK_INVALID is used, here is th=
e list:
> > > >=20
> > > > - unmark_stack_slots_dynptr()
> > > >   Destroy dynptr marks. Suppose STACK_INVALID is replaced by
> > > >   STACK_MISC here, in this case a scalar read would be possible fro=
m
> > > >   such slot, which in turn might lead to pointer leak.
> > > >   Might be a problem?
> > >=20
> > > We are already talking to enable reading STACK_DYNPTR slots directly.
> > > So not a problem?
> > >=20
> > > >=20
> > > > - scrub_spilled_slot()
> > > >   mark spill slot STACK_MISC if not STACK_INVALID
> > > >   Called from:
> > > >   - save_register_state() called from check_stack_write_fixed_off()
> > > >     Would mark not all slots only for 32-bit writes.
> > > >   - check_stack_write_fixed_off() for insns like `fp[-8] =3D <const=
>` to
> > > >     destroy previous stack marks.
> > > >   - check_stack_range_initialized()
> > > >     here it always marks all 8 spi slots as STACK_MISC.
> > > >   Looks like STACK_MISC instead of STACK_INVALID wouldn't make a
> > > >   difference in these cases.
> > > >=20
> > > > - check_stack_write_fixed_off()
> > > >   Mark insn as sanitize_stack_spill if pointer is spilled to a stac=
k
> > > >   slot that is marked STACK_INVALID. This one is a bit strange.
> > > >   E.g. the program like this:
> > > >=20
> > > >     ...
> > > >     42:  fp[-8] =3D ptr
> > > >     ...
> > > >=20
> > > >   Will mark insn (42) as sanitize_stack_spill.
> > > >   However, the program like this:
> > > >=20
> > > >     ...
> > > >     21:  fp[-8] =3D 22   ;; marks as STACK_MISC
> > > >     ...
> > > >     42:  fp[-8] =3D ptr
> > > >     ...
> > > >=20
> > > >   Won't mark insn (42) as sanitize_stack_spill, which seems strange=
.
> > > >=20
> > > > - stack_write_var_off()
> > > >   If !env->allow_ptr_leaks only allow writes if slots are not
> > > >   STACK_INVALID. I'm not sure I understand the intention.
> > > >=20
> > > > - clean_func_state()
> > > >   STACK_INVALID is used to mark spi's that are not REG_LIVE_READ as
> > > >   such that should not take part in the state comparison. However,
> > > >   stacksafe() has REG_LIVE_READ check as well, so this marking migh=
t
> > > >   be unnecessary.
> > > >=20
> > > > - stacksafe()
> > > >   STACK_INVALID is used as a mark that some bytes of an spi are not
> > > >   important in a state cached for state comparison. E.g. a slot in =
an
> > > >   old state might be marked 'mmmm????' and 'mmmmmmmm' or 'mmmm0000'=
 in
> > > >   a new state. However other checks in stacksafe() would catch thes=
e
> > > >   variations.
> > > >=20
> > > > The conclusion being that some pointer leakage checks might need
> > > > adjustment if STACK_INVALID is replaced by STACK_MISC.
> > >=20
> > > Just to be clear. My suggestion was to *treat* STACK_INVALID as
> > > equivalent to STACK_MISC in stacksafe(), not really replace all the
> > > uses of STACK_INVALID with STACK_MISC. And to be on the safe side, I'=
d
> > > do it only if env->allow_ptr_leaks, of course.
> >=20
> > Well, that, and to allow STACK_INVALID if env->allow_ptr_leaks in
> > check_stack_read_fixed_off(), of course, to avoid "invalid read from
> > stack off %d+%d size %d\n" error (that's fixing at least part of the
> > problem with uninitialized struct padding).
>=20
> +1 to Andrii's idea.
> It should help us recover this small increase in processed states.
>=20
> Eduard,
>=20
> The fix itself is brilliant. Thank you for investigating
> and providing the detailed explanation.
> I've read this thread and the previous one,
> walked through all the points and it all looks correct.
> Sorry it took me a long time to remember the details
> of liveness logic to review it properly.
>=20
> While you, Andrii and me keep this tricky knowledge in our
> heads could you please document how liveness works in
> Documentation/bpf/verifier.rst ?
> We'll be able to review it now and next time it will be
> easier to remember.

I'll extend the doc and finalize your patch over the weekend,
thank you for the review.

>=20
> I've tried Andrii's suggestion:
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7ee218827259..0f71ba6a56e2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3591,7 +3591,7 @@ static int check_stack_read_fixed_off(struct
> bpf_verifier_env *env,
>=20
> copy_register_state(&state->regs[dst_regno], reg);
>                                 state->regs[dst_regno].subreg_def =3D sub=
reg_def;
>                         } else {
> -                               for (i =3D 0; i < size; i++) {
> +                               for (i =3D 0; i < size &&
> !env->allow_uninit_stack; i++) {
>                                         type =3D stype[(slot - i) % BPF_R=
EG_SIZE];
>                                         if (type =3D=3D STACK_SPILL)
>                                                 continue;
> @@ -3628,7 +3628,7 @@ static int check_stack_read_fixed_off(struct
> bpf_verifier_env *env,
>                 }
>                 mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
>         } else {
> -               for (i =3D 0; i < size; i++) {
> +               for (i =3D 0; i < size && !env->allow_uninit_stack; i++) =
{
>                         type =3D stype[(slot - i) % BPF_REG_SIZE];
>                         if (type =3D=3D STACK_MISC)
>                                 continue;
> @@ -13208,6 +13208,10 @@ static bool stacksafe(struct bpf_verifier_env
> *env, struct bpf_func_state *old,
>                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D
> STACK_INVALID)
>                         continue;
>=20
> +               if (env->allow_uninit_stack &&
> +                   old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D ST=
ACK_MISC)
> +                       continue;
>=20
> and only dynptr/invalid_read[134] tests failed
> which is expected and acceptable.
> We can tweak those tests.
>=20
> Could you take over this diff, run veristat analysis and
> submit it as an official patch? I suspect we should see nice
> improvements in states processed.
>=20
> Thanks!

