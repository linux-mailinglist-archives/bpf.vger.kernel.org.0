Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2458B68152D
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 16:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjA3Ped (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 10:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjA3Pec (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 10:34:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2909B3EFE5
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 07:34:05 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so8447927wms.2
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 07:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGcICkap1rEfcO2Uf4GqU9jqYUFyruLtBeSMHeLNj7E=;
        b=iHyoQ6mbd8yeSNV2QwfRe38jAhDutpWg/Nlu1pfKNz2k8OFDIZL0R/OHIk7COsEEio
         MDUOGG0ajmpAOHKdOk9+C54Eu5suXbZ58W841AG9nn64xI+yM5qayQm6ZwCr7ucqY8ou
         UBe7JEZll0f02lPCm678/Wl8LNkSIKGTkZAwnHIqVYfM4uxLJlAmpMlnV4vuyOYGbi6g
         CMh+85U7P3o5h8BhwmvQbr5LPy6mMRU0IQiOcpao7taNTXnn9uS/UqS81jCOvUnDWs4v
         IzaD1eZGNFr5soJVPXsbAl0lHv9axNl7IfAteas5q1m2j4XB8ra9qMowcvNez5xdSU8u
         Ng1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGcICkap1rEfcO2Uf4GqU9jqYUFyruLtBeSMHeLNj7E=;
        b=mMqt1zyc8MIu1JIfdSrM4MNJc5WIl+VceEowIorPZwSzoyjADs2FgP+jdNgGtrQv23
         4sIxmYDBH34w84AFCUMHOmtkEgrZ+PeuTJxZb7Q8g6fPIsUY8XQD8j5wzQkTI5lfMZa3
         kXdJ5A49vzS+35xu8VWMTWDINbwYYjKsQ0h9lamKCvjifVsF7ugseJQTC43wJzECakfH
         ajRGrfkgBWxd4zqiDfScquSewGyA2o/OQagXdmInRT6/ipqRnK4yySJ+Cdyksg2D4Sb7
         /dMk7p5C/K6zBrQZb8EvC9e9H9P+Ch6DFmhnGuHpceCBQbM7zHZQEgE8YNXxdEPkiKQf
         eq4A==
X-Gm-Message-State: AFqh2ko0mm9kB3rIuQzxI0E/zN+8U+JxJCAcJVuCBagCK2yNgq9WGbZp
        +9DAgMVvXV4KvD0WNPt8LLw=
X-Google-Smtp-Source: AMrXdXsyFGk3BHW+ALDUgsrhSkKh+ZI1u6Va+kn83OZQyXMYJprCrVsj7WIzFLYRLNGxkryY63qMEg==
X-Received: by 2002:a05:600c:3d98:b0:3d6:ecc4:6279 with SMTP id bi24-20020a05600c3d9800b003d6ecc46279mr47268719wmb.27.1675092839687;
        Mon, 30 Jan 2023 07:33:59 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003d9fba3c7a4sm17964586wmq.16.2023.01.30.07.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:33:59 -0800 (PST)
Message-ID: <dd76a0254d08b25d83ad30d6f07acef36e6223e1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Date:   Mon, 30 Jan 2023 17:33:57 +0200
In-Reply-To: <CAADnVQLybn06cYYV3uf3FeAGMjOiL5riRzhV6f9fuFOHr9bL=g@mail.gmail.com>
References: <20230106142214.1040390-1-eddyz87@gmail.com>
         <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
         <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
         <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
         <b836c36a68b670df8f649db621bb3ec74e03ef9b.camel@gmail.com>
         <CAEf4Bza8q2P1mqN4LYwiYqssBiQDorjkFaZDsudOQFCb2825Vw@mail.gmail.com>
         <CAEf4BzY9ikdrT5WN__QJgaYhWJ=h0Do8T7YkiYLpT9VftqecVg@mail.gmail.com>
         <CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com>
         <CAADnVQLybn06cYYV3uf3FeAGMjOiL5riRzhV6f9fuFOHr9bL=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-01-19 at 16:16 -0800, Alexei Starovoitov wrote:
[...]
> > > >=20
> > > > Just to be clear. My suggestion was to *treat* STACK_INVALID as
> > > > equivalent to STACK_MISC in stacksafe(), not really replace all the
> > > > uses of STACK_INVALID with STACK_MISC. And to be on the safe side, =
I'd
> > > > do it only if env->allow_ptr_leaks, of course.
> > >=20
> > > Well, that, and to allow STACK_INVALID if env->allow_ptr_leaks in
> > > check_stack_read_fixed_off(), of course, to avoid "invalid read from
> > > stack off %d+%d size %d\n" error (that's fixing at least part of the
> > > problem with uninitialized struct padding).
> >=20
> > +1 to Andrii's idea.
> > It should help us recover this small increase in processed states.
> >=20
[...]
> >=20
> > I've tried Andrii's suggestion:
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7ee218827259..0f71ba6a56e2 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3591,7 +3591,7 @@ static int check_stack_read_fixed_off(struct
> > bpf_verifier_env *env,
> >=20
> > copy_register_state(&state->regs[dst_regno], reg);
> >                                 state->regs[dst_regno].subreg_def =3D s=
ubreg_def;
> >                         } else {
> > -                               for (i =3D 0; i < size; i++) {
> > +                               for (i =3D 0; i < size &&
> > !env->allow_uninit_stack; i++) {
> >                                         type =3D stype[(slot - i) % BPF=
_REG_SIZE];
> >                                         if (type =3D=3D STACK_SPILL)
> >                                                 continue;
> > @@ -3628,7 +3628,7 @@ static int check_stack_read_fixed_off(struct
> > bpf_verifier_env *env,
> >                 }
> >                 mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
> >         } else {
> > -               for (i =3D 0; i < size; i++) {
> > +               for (i =3D 0; i < size && !env->allow_uninit_stack; i++=
) {
> >                         type =3D stype[(slot - i) % BPF_REG_SIZE];
> >                         if (type =3D=3D STACK_MISC)
> >                                 continue;
> > @@ -13208,6 +13208,10 @@ static bool stacksafe(struct bpf_verifier_env
> > *env, struct bpf_func_state *old,
> >                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D
> > STACK_INVALID)
> >                         continue;
> >=20
> > +               if (env->allow_uninit_stack &&
> > +                   old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D =
STACK_MISC)
> > +                       continue;
> >=20
> > and only dynptr/invalid_read[134] tests failed
> > which is expected and acceptable.
> > We can tweak those tests.
> >=20
> > Could you take over this diff, run veristat analysis and
> > submit it as an official patch? I suspect we should see nice
> > improvements in states processed.
>=20

Hi Alexei, Andrii,

Please note that the patch
"bpf: Fix to preserve reg parent/live fields when copying range info"
that started this conversation was applied to `bpf` tree, not `bpf-next`,
so I'll wait until it gets its way to `bpf-next` before submitting formal
patches, as it changes the performance numbers collected by veristat.
I did all my experiments with this patch applied on top of `bpf-next`.

I adapted the patch suggested by Alexei and put it to my github for
now [1]. The performance gains are indeed significant:

$ ./veristat -e file,states -C -f 'states_pct<-30' master.log uninit-reads.=
log
File                        States (A)  States (B)  States    (DIFF)
--------------------------  ----------  ----------  ----------------
bpf_host.o                         349         244    -105 (-30.09%)
bpf_host.o                        1320         895    -425 (-32.20%)
bpf_lxc.o                         1320         895    -425 (-32.20%)
bpf_sock.o                          70          48     -22 (-31.43%)
bpf_sock.o                          68          46     -22 (-32.35%)
bpf_xdp.o                         1554         803    -751 (-48.33%)
bpf_xdp.o                         6457        2473   -3984 (-61.70%)
bpf_xdp.o                         7249        3908   -3341 (-46.09%)
pyperf600_bpf_loop.bpf.o           287         145    -142 (-49.48%)
strobemeta.bpf.o                 15879        4790  -11089 (-69.83%)
strobemeta_nounroll2.bpf.o       20505        3931  -16574 (-80.83%)
xdp_synproxy_kern.bpf.o          22564        7009  -15555 (-68.94%)
xdp_synproxy_kern.bpf.o          24206        6941  -17265 (-71.33%)
--------------------------  ----------  ----------  ----------------

However, this comes at a cost of allowing reads from uninitialized
stack locations. As far as I understand access to uninitialized local
variable is one of the most common errors when programming in C
(although citation is needed).

Also more tests are failing after register parentage chains patch is
applied than in Alexei's initial try: 10 verifier tests and 1 progs
test (test_global_func10.c, I have not modified it yet, it should wait
for my changes for unprivileged execution mode support in
test_loader.c). I don't really like how I had to fix those tests.

I took a detailed look at the difference in verifier behavior between
master and the branch [1] for pyperf600_bpf_loop.bpf.o and identified
that the difference is caused by the fact that helper functions do not
mark the stack they access as REG_LIVE_WRITTEN, the details are in the
commit message [3], but TLDR is the following example:

        1: bpf_probe_read_user(&foo, ...);
        2: if (*foo) ...

Here `*foo` will not get REG_LIVE_WRITTEN mark when (1) is verified,
thus `*foo` read at (2) might lead to excessive REG_LIVE_READ marks
and thus more verification states.

I prepared a patch that changes helper calls verification to apply
REG_LIVE_WRITTEN when write size and alignment allow this, again
currently on my github [2]. This patch has less dramatic performance
impact, but nonetheless significant:

$ veristat -e file,states -C -f 'states_pct<-30' master.log helpers-written=
.log
File                        States (A)  States (B)  States    (DIFF)
--------------------------  ----------  ----------  ----------------
pyperf600_bpf_loop.bpf.o           287         156    -131 (-45.64%)
strobemeta.bpf.o                 15879        4772  -11107 (-69.95%)
strobemeta_nounroll1.bpf.o        2065        1337    -728 (-35.25%)
strobemeta_nounroll2.bpf.o       20505        3788  -16717 (-81.53%)
test_cls_redirect.bpf.o           8129        4799   -3330 (-40.96%)
--------------------------  ----------  ----------  ----------------

I suggest that instead of dropping a useful safety check I can further
investigate difference in behavior between "uninit-reads.log" and
"helpers-written.log" and maybe figure out other improvements.
Unfortunately the comparison process is extremely time consuming.

wdyt?
       =20
[1] https://github.com/eddyz87/bpf/tree/allow-uninit-stack-reads
[2] https://github.com/eddyz87/bpf/tree/mark-helper-stack-as-written
[3] https://github.com/kernel-patches/bpf/commit/b29842309271c21cbcb3f85d56=
cdf9f45f8382d2

> Indeed, some massive improvements:
> ./veristat -e file,prog,states -C -f 'states_diff<-10' bb aa
> File                              Program                  States (A)
> States (B)  States    (DIFF)
> --------------------------------  -----------------------  ----------
> ----------  ----------------
> bpf_flow.bpf.o                    flow_dissector_0                 78
>         67     -11 (-14.10%)
> loop6.bpf.o                       trace_virtqueue_add_sgs         336
>        316      -20 (-5.95%)
> pyperf100.bpf.o                   on_event                       6213
>       4670   -1543 (-24.84%)
> pyperf180.bpf.o                   on_event                      11470
>       8364   -3106 (-27.08%)
> pyperf50.bpf.o                    on_event                       3263
>       2370    -893 (-27.37%)
> pyperf600.bpf.o                   on_event                      30335
>      22200   -8135 (-26.82%)
> pyperf600_bpf_loop.bpf.o          on_event                        287
>        145    -142 (-49.48%)
> pyperf600_nounroll.bpf.o          on_event                      37101
>      34169    -2932 (-7.90%)
> strobemeta.bpf.o                  on_event                      15939
>       4893  -11046 (-69.30%)
> strobemeta_nounroll1.bpf.o        on_event                       1936
>       1538    -398 (-20.56%)
> strobemeta_nounroll2.bpf.o        on_event                       4436
>       3991    -445 (-10.03%)
> strobemeta_subprogs.bpf.o         on_event                       2025
>       1689    -336 (-16.59%)
> test_cls_redirect.bpf.o           cls_redirect                   4865
>       4042    -823 (-16.92%)
> test_cls_redirect_subprogs.bpf.o  cls_redirect                   4506
>       4389     -117 (-2.60%)
> test_tcp_hdr_options.bpf.o        estab                           211
>        178     -33 (-15.64%)
> test_xdp_noinline.bpf.o           balancer_ingress_v4             262
>        235     -27 (-10.31%)
> test_xdp_noinline.bpf.o           balancer_ingress_v6             253
>        210     -43 (-17.00%)
> xdp_synproxy_kern.bpf.o           syncookie_tc                  25086
>       7016  -18070 (-72.03%)
> xdp_synproxy_kern.bpf.o           syncookie_xdp                 24206
>       6941  -17265 (-71.33%)
> --------------------------------  -----------------------  ----------
> ----------  ----------------

