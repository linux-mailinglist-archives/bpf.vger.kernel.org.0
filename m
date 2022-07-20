Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF1D57C018
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 00:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiGTWdb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 18:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTWda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 18:33:30 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF44B0FE
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 15:33:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 72so17751612pge.0
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnFvY81FE2Ah3FzfTUo61tFAQT5jDyco1mEjPVQD4/Q=;
        b=ZmlU+sHkv6Bjlrw+I35i5476I5TyOOQixcZU+JO3uufjUMjSrnhnFanco+VrWu9x7d
         tg4lbP3HXaQfOsjQc6yaUf3ApYFqWsVgzVY1F2hgi4bTBHSYutkf4ytskzoozmCDxuJl
         TBkCqjHO91bXmEYFmMLwJzWe+flyGZjU9/96N8X22mmPvwZF32pwm11iTF1/OszSdgrr
         whcGWuLTss0bD/x1VDa7XaZvCtiy1nxnj2SG5Rc/8yv85F49jIMEellAzRNIH/q7AY4X
         09YLwDmAoi4g43djw5a/Ja6UO7k/mzeIxN0L2Z8EFc+1BlbI5bwiQvEKQf9f3xEVygoi
         EIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnFvY81FE2Ah3FzfTUo61tFAQT5jDyco1mEjPVQD4/Q=;
        b=zAToX+a8v/JB1R4Hdkhr2vXeiLn9gIjcfvYXpdgJfM+d5N7kQoH6z8dV+gogP7g8IF
         Zg2Cg7CcRgqA8qh57d8iuGwoQckCR5SljP+s6U6xN5v7vWKbBFam5VsKlCMlwK2RC0qu
         9xloCLL3c5oPtgaFqw/Fo3eOXIKHEtyXuJlKvWS6+RnaiAAgY2Y14a6tnjE1xVqkLHv1
         Z27g84iwhMFjSyyk6utKhlxasBrt1CjBhNXOFxuJH/nmymL7QPjaR/OHQltoXQ5gzo5U
         3klbQwkY4KG5TB/4UWx2MMkG1jgH09y1yMpbGuDv3hDNsuvR8bc3enbAq6f4KWQPWCSd
         W7xQ==
X-Gm-Message-State: AJIora+WcVH9Hmu6p85B7FOVgjree6sh0sO3vrvFYzjPSBZwV/byfZpb
        Cy+QTVK1gkOHZsuCTTfMufxyxgcC8woMgW1K2JuXbg==
X-Google-Smtp-Source: AGRyM1tE73fYGmySjeJvA28Aplb7dltxwNXg5ooqTvBnykuAD/Qlo18Hqvl0bC9qPradgIVJQa0oizuUfe6iPDZZP3M=
X-Received: by 2002:a65:4c0b:0:b0:415:d3a4:44d1 with SMTP id
 u11-20020a654c0b000000b00415d3a444d1mr36180142pgq.191.1658356408165; Wed, 20
 Jul 2022 15:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220718190748.2988882-1-sdf@google.com> <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
 <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com>
 <CAKH8qBv66=Fdea0u-vbu-Q=P9pySo+tjy5YpPPcNo8dF0qN8bw@mail.gmail.com>
 <CAADnVQ+Gmo=B=NpXofq=LmFq6HsJZ-X9D1a4MwSLK3k_F9SEqg@mail.gmail.com>
 <Ytc8RvDTpEmC0pQD@google.com> <YthDy8uhE2ky0rBr@google.com> <20220720205255.4v3y3a4xttesfkn6@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220720205255.4v3y3a4xttesfkn6@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 20 Jul 2022 15:33:16 -0700
Message-ID: <CAKH8qBsnXnTYJ7e2v8qLOmWcp5j96LKwTuMLQaTzHsxhDdZ-dQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 1:53 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Jul 20, 2022 at 11:04:59AM -0700, sdf@google.com wrote:
> > On 07/19, sdf@google.com wrote:
> > > On 07/19, Alexei Starovoitov wrote:
> > > > On Tue, Jul 19, 2022 at 2:41 PM Stanislav Fomichev <sdf@google.com>
> > > wrote:
> > > > >
> > > > > On Tue, Jul 19, 2022 at 1:33 PM Stanislav Fomichev <sdf@google.com>
> > > > wrote:
> > > > > >
> > > > > > On Tue, Jul 19, 2022 at 1:21 PM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev
> > > > <sdf@google.com> wrote:
> > > > > > > >
> > > > > > > > Motivation:
> > > > > > > >
> > > > > > > > Our bpf programs have a bunch of options which are set at the
> > > > loading
> > > > > > > > time. After loading, they don't change. We currently use array
> > > map
> > > > > > > > to store them and bpf program does the following:
> > > > > > > >
> > > > > > > > val = bpf_map_lookup_elem(&config_map, &key);
> > > > > > > > if (likely(val && *val)) {
> > > > > > > >   // do some optional feature
> > > > > > > > }
> > > > > > > >
> > > > > > > > Since the configuration is static and we have a lot of those
> > > > features,
> > > > > > > > I feel like we're wasting precious cycles doing dynamic lookups
> > > > > > > > (and stalling on memory loads).
> > > > > > > >
> > > > > > > > I was assuming that converting those to some fake kconfig
> > > options
> > > > > > > > would solve it, but it still seems like kconfig is stored in the
> > > > > > > > global map and kconfig entries are resolved dynamically.
> > > > > > > >
> > > > > > > > Proposal:
> > > > > > > >
> > > > > > > > Resolve kconfig options statically upon loading. Basically
> > > rewrite
> > > > > > > > ld+ldx to two nops and 'mov val, x'.
> > > > > > > >
> > > > > > > > I'm also trying to rewrite conditional jump when the condition
> > > is
> > > > > > > > !imm. This seems to be catching all the cases in my program, but
> > > > > > > > it's probably too hacky.
> > > > > > > >
> > > > > > > > I've attached very raw RFC patch to demonstrate the idea.
> > > Anything
> > > > > > > > I'm missing? Any potential problems with this approach?
> > > > > > >
> > > > > > > Have you considered using global variables for that?
> > > > > > > With skeleton the user space has a natural way to set
> > > > > > > all of these knobs after doing skel_open and before skel_load.
> > > > > > > Then the verifier sees them as readonly vars and
> > > > > > > automatically converts LDX into fixed constants and if the code
> > > > > > > looks like if (my_config_var) then the verifier will remove
> > > > > > > all the dead code too.
> > > > > >
> > > > > > Hm, that's a good alternative, let me try it out. Thanks!
> > > > >
> > > > > Turns out we already freeze kconfig map in libbpf:
> > > > > if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG) {
> > > > >         err = bpf_map_freeze(map->fd);
> > > > >
> > > > > And I've verified that I do hit bpf_map_direct_read in the verifier.
> > > > >
> > > > > But the code still stays the same (bpftool dump xlated):
> > > > >   72: (18) r1 = map[id:24][0]+20
> > > > >   74: (61) r1 = *(u32 *)(r1 +0)
> > > > >   75: (bf) r2 = r9
> > > > >   76: (b7) r0 = 0
> > > > >   77: (15) if r1 == 0x0 goto pc+9
> > > > >
> > > > > I guess there is nothing for sanitize_dead_code to do because my
> > > > > conditional is "if (likely(some_condition)) { do something }" and the
> > > > > branch instruction itself is '.seen' by the verifier.
> >
> > > > I bet your variable is not 'const'.
> > > > Please see any of the progs in selftests that do:
> > > > const volatile int var = 123;
> > > > to express configs.
> >
> > > Yeah, I was testing against the following:
> >
> > >     extern int CONFIG_XYZ __kconfig __weak;
> >
> > > But ended up writing this small reproducer:
> >
> > >     struct __sk_buff;
> >
> > >     const volatile int CONFIG_DROP = 1; // volatile so it's not
> > >                                         // clang-optimized
> >
> > >     __attribute__((section("tc"), used))
> > >     int my_config(struct __sk_buff *skb)
> > >     {
> > >             int ret = 0; /*TC_ACT_OK*/
> >
> > >             if (CONFIG_DROP)
> > >                     ret = 2 /*TC_ACT_SHOT*/;
> >
> > >             return ret;
> > >     }
> >
> > > $ bpftool map dump name my_confi.rodata
> >
> > > [{
> > >          "value": {
> > >              ".rodata": [{
> > >                      "CONFIG_DROP": 1
> > >                  }
> > >              ]
> > >          }
> > >      }
> > > ]
> >
> > > $ bpftool prog dump xlated name my_config
> >
> > > int my_config(struct __sk_buff * skb):
> > > ; if (CONFIG_DROP)
> > >     0: (18) r1 = map[id:3][0]+0
> > >     2: (61) r1 = *(u32 *)(r1 +0)
> > >     3: (b4) w0 = 1
> > > ; if (CONFIG_DROP)
> > >     4: (64) w0 <<= 1
> > > ; return ret;
> > >     5: (95) exit
> >
> > > The branch is gone, but the map lookup is still there :-(
> >
> > Attached another RFC below which is doing the same but from the verifier
> > side. It seems we should be able to resolve LD+LDX if their dst_reg
> > is the same? If they are different, we should be able to pre-lookup
> > LDX value at least. Would something like this work (haven't run full
> > verifier/test_progs yet)?
> >
> > (note, in this case, with kconfig, I still see the branch)
> >
> >  test_fold_ro_ldx:PASS:open 0 nsec
> >  test_fold_ro_ldx:PASS:load 0 nsec
> >  test_fold_ro_ldx:PASS:bpf_obj_get_info_by_fd 0 nsec
> >  int fold_ro_ldx(struct __sk_buff * skb):
> >  ; if (CONFIG_DROP)
> >     0: (b7) r1 = 1
> >     1: (b4) w0 = 1
> >  ; if (CONFIG_DROP)
> >     2: (16) if w1 == 0x0 goto pc+1
> >     3: (b4) w0 = 2
> >  ; return ret;
> >     4: (95) exit
> >  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >  test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >  test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >  #66      fold_ro_ldx:OK
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  kernel/bpf/verifier.c                         | 74 ++++++++++++++++++-
> >  .../selftests/bpf/prog_tests/fold_ro_ldx.c    | 52 +++++++++++++
> >  .../testing/selftests/bpf/progs/fold_ro_ldx.c | 20 +++++
> >  3 files changed, 144 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fold_ro_ldx.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/fold_ro_ldx.c
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c59c3df0fea6..ffedd8234288 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12695,6 +12695,69 @@ static bool bpf_map_is_cgroup_storage(struct
> > bpf_map *map)
> >               map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> >  }
> >
> > +/* if the map is read-only, we can try to fully resolve the load */
> > +static bool fold_ro_pseudo_ldimm64(struct bpf_verifier_env *env,
> > +                                struct bpf_map *map,
> > +                                struct bpf_insn *insn)
> > +{
> > +     struct bpf_insn *ldx_insn = insn + 2;
> > +     int dst_reg = ldx_insn->dst_reg;
> > +     u64 val = 0;
> > +     int size;
> > +     int err;
> > +
> > +     if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr)
> > +             return false;
> > +
> > +     /* 0: BPF_LD  r=MAP
> > +      * 1: BPF_LD  r=MAP
> > +      * 2: BPF_LDX r=MAP->VAL
> > +      */
> > +
> > +     if (BPF_CLASS((insn+0)->code) != BPF_LD ||
> > +         BPF_CLASS((insn+1)->code) != BPF_LD ||
> > +         BPF_CLASS((insn+2)->code) != BPF_LDX)
> > +             return false;
> > +
> > +     if (BPF_MODE((insn+0)->code) != BPF_IMM ||
> > +         BPF_MODE((insn+1)->code) != BPF_IMM ||
> > +         BPF_MODE((insn+2)->code) != BPF_MEM)
> > +             return false;
> > +
> > +     if (insn->src_reg != BPF_PSEUDO_MAP_VALUE &&
> > +         insn->src_reg != BPF_PSEUDO_MAP_IDX_VALUE)
> > +             return false;
> > +
> > +     if (insn->dst_reg != ldx_insn->src_reg)
> > +             return false;
> > +
> > +     if (ldx_insn->off != 0)
> > +             return false;
> > +
> > +     size = bpf_size_to_bytes(BPF_SIZE(ldx_insn->code));
> > +     if (size < 0 || size > 4)
> > +             return false;
> > +
> > +     err = bpf_map_direct_read(map, (insn+1)->imm, size, &val);
> > +     if (err)
> > +             return false;
> > +
> > +     if (insn->dst_reg == ldx_insn->dst_reg) {
> > +             /* LDX is using the same destination register as LD.
> > +              * This means we are not interested in the map
> > +              * pointer itself and can remove it.
> > +              */
> > +             *(insn + 0) = BPF_JMP_A(0);
> > +             *(insn + 1) = BPF_JMP_A(0);
> > +             *(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
> Have you figured out why the branch is not removed
> with BPF_ALU64_IMM(BPF_MOV) ?

I do have an idea, yes, but I'm not 100% certain. The rewrite has
nothing to do with it.
If I change the default ret from 1 to 0, I get a different bytecode
where this branch is eventually removed by the verifier.

I think it comes down to the following snippet:
r1 = 0 ll
r1 = *(u32 *)(r1 + 0) <<< rodata, verifier is able to resolve to r1 = 1
w0 = 1
if w1 == 0 goto +1
w0 = 2
exit
Here, 'if w1 == 0' is never taken, but it has been 'seen' by the
verifier. There is no 'dead' code, it just jumps around 'w0 = 2' which
has seen=true.

VS this one:
r1 = 0 ll
r1 = *(u32 *)(r1 + 0) <<< rodata, verifier is able to resolve to r1 = 1
w0 = 1
if w1 != 0 goto +1
w0 = 0
w0 <<= 1
exit
Here, 'if w1 != 0' is seen, but the next insn has 'seen=false', so
this whole thing is ripped out.

So basically, from my quick look, it seems like there should be some
real dead code to trigger the removal. If you simply have 'if
condition_that_never_happens goto +1' which doesn't lead to some dead
code, this single jump-over-some-seen-code is never gonna be removed.
So, IMO, that's something that should be addressed independently.

> Can it also support 8 bytes (BPF_DW) ?  Is it because there
> is not enough space for ld_imm64?  so wonder if this
> patching can be done in do_misc_fixups() instead.

Yeah, I've limited it to 4 bytes because of sizeof(imm) for now.
I think one complication might be that at do_misc_fixups point, the
immediate args of bpf_ld have been rewritten which might make it
harder to get the data offset.

But I guess I'm still at the point where I'm trying to understand
whether what I'm doing makes sense or not :-) And whether we should do
it at the verifier level, in libbpf or if at all..




> > +             return true;
> > +     }
> > +
> > +     *(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
> > +     /* Only LDX can be resolved, we still have to resolve LD address. */
> > +     return false;
> > +}
