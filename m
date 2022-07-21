Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50F57D74E
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 01:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiGUXQe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 19:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiGUXQ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 19:16:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD33C8E6C0
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 16:16:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d7-20020a17090a564700b001f209736b89so6722546pji.0
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYd+yDTXY/RMXhWY60u1x2BortQg+iqstP9YfhbF79E=;
        b=SiMg2c3KnVa8uqf3UCT3Va1wsNap2vaXJADMrgwVM/btZvc55yXedISPk/Zc9Fx2zF
         QOSOszGAIBXyDotJtCKK3mGmDx/8b8iHdfv9bZAzv+mhsT1NhbS/wzqhEH4WWowv5haQ
         Q4JaNpCR5fgsgVkG4QOqT5YH6cQ+QfsVg7XRp1jkYdzAARNpoPMzPb8zQ0j3IpwXg0Cb
         gJHS22m5aqMXz1XOzV1ovdIOgcC74hoBO++dR7EpFU5fD0TQ0HEFZtNLtJWAybzk/ThO
         1m3K8uWsiIowrZmvLkoKMMpfwTY/ZWLG97CT3IkjhCiYFUAtRvQbCfwUARgxBKR5ZQKY
         QPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYd+yDTXY/RMXhWY60u1x2BortQg+iqstP9YfhbF79E=;
        b=0DI1CebpHm3kX9BjFQf4isd5OH8goZOpy5I44UdjntEygFfru0irAy33CSFaAkTxoK
         7t5BVNFvZGOul2U/aj3eZgNENCeUCGGTO3Hqh2KcXv4TK0ntUDgIkcAA8yDFvvZxjYbd
         EfQxcMT3at3I9znjSY/00Xl5GQ4CpYLs9l4votDZOmppYc4bEXaxFWwoDozvtVoauUkD
         WAyb6cSR0fQfVAsTllxEKd5iKT7C8vgFUd0f9ZKDnv1ANnC8M+g/GLx9D6NUxCsCH39X
         aRtUTShraJxEzrLBIOGtbmSUkPIaOKr2ZpgyNaYFkQ4djggeJqy0xb0WTlLqQhxeoM3H
         Ew1w==
X-Gm-Message-State: AJIora9P7RdQD9ImHMeoD/HG1sVlfJ/z1wJQyVZPhj7Zv7YkjNg8zS+S
        NV3WZEybc9Ryw49/CLu1Pc5RgLOE7oG2BEc8IjJ5h/4EzdR9hw==
X-Google-Smtp-Source: AGRyM1v7R/hpJFH7mQ9RmNq+zAb/vNd3NVD3UpRxeA5jpob9luG8iBSzGluE7C6cDNeSWhFyo1FNgXxKXYZiVDFeoHw=
X-Received: by 2002:a17:903:1111:b0:16a:acf4:e951 with SMTP id
 n17-20020a170903111100b0016aacf4e951mr615707plh.72.1658445386952; Thu, 21 Jul
 2022 16:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220718190748.2988882-1-sdf@google.com> <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
 <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com>
 <CAKH8qBv66=Fdea0u-vbu-Q=P9pySo+tjy5YpPPcNo8dF0qN8bw@mail.gmail.com>
 <CAADnVQ+Gmo=B=NpXofq=LmFq6HsJZ-X9D1a4MwSLK3k_F9SEqg@mail.gmail.com>
 <Ytc8RvDTpEmC0pQD@google.com> <YthDy8uhE2ky0rBr@google.com>
 <20220720205255.4v3y3a4xttesfkn6@kafai-mbp.dhcp.thefacebook.com>
 <CAKH8qBsnXnTYJ7e2v8qLOmWcp5j96LKwTuMLQaTzHsxhDdZ-dQ@mail.gmail.com> <7b2e6553-5bcc-1c70-2c4b-78e95593755b@fb.com>
In-Reply-To: <7b2e6553-5bcc-1c70-2c4b-78e95593755b@fb.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 21 Jul 2022 16:16:15 -0700
Message-ID: <CAKH8qBvbhDkrmoKEk8OWSndFwmuEPEXp9ULW249JSu7O0kn0NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
To:     Yonghong Song <yhs@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
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

On Thu, Jul 21, 2022 at 3:30 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/20/22 3:33 PM, Stanislav Fomichev wrote:
> > On Wed, Jul 20, 2022 at 1:53 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >>
> >> On Wed, Jul 20, 2022 at 11:04:59AM -0700, sdf@google.com wrote:
> >>> On 07/19, sdf@google.com wrote:
> >>>> On 07/19, Alexei Starovoitov wrote:
> >>>>> On Tue, Jul 19, 2022 at 2:41 PM Stanislav Fomichev <sdf@google.com>
> >>>> wrote:
> >>>>>>
> >>>>>> On Tue, Jul 19, 2022 at 1:33 PM Stanislav Fomichev <sdf@google.com>
> >>>>> wrote:
> >>>>>>>
> >>>>>>> On Tue, Jul 19, 2022 at 1:21 PM Alexei Starovoitov
> >>>>>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev
> >>>>> <sdf@google.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Motivation:
> >>>>>>>>>
> >>>>>>>>> Our bpf programs have a bunch of options which are set at the
> >>>>> loading
> >>>>>>>>> time. After loading, they don't change. We currently use array
> >>>> map
> >>>>>>>>> to store them and bpf program does the following:
> >>>>>>>>>
> >>>>>>>>> val = bpf_map_lookup_elem(&config_map, &key);
> >>>>>>>>> if (likely(val && *val)) {
> >>>>>>>>>    // do some optional feature
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> Since the configuration is static and we have a lot of those
> >>>>> features,
> >>>>>>>>> I feel like we're wasting precious cycles doing dynamic lookups
> >>>>>>>>> (and stalling on memory loads).
> >>>>>>>>>
> >>>>>>>>> I was assuming that converting those to some fake kconfig
> >>>> options
> >>>>>>>>> would solve it, but it still seems like kconfig is stored in the
> >>>>>>>>> global map and kconfig entries are resolved dynamically.
> >>>>>>>>>
> >>>>>>>>> Proposal:
> >>>>>>>>>
> >>>>>>>>> Resolve kconfig options statically upon loading. Basically
> >>>> rewrite
> >>>>>>>>> ld+ldx to two nops and 'mov val, x'.
> >>>>>>>>>
> >>>>>>>>> I'm also trying to rewrite conditional jump when the condition
> >>>> is
> >>>>>>>>> !imm. This seems to be catching all the cases in my program, but
> >>>>>>>>> it's probably too hacky.
> >>>>>>>>>
> >>>>>>>>> I've attached very raw RFC patch to demonstrate the idea.
> >>>> Anything
> >>>>>>>>> I'm missing? Any potential problems with this approach?
> >>>>>>>>
> >>>>>>>> Have you considered using global variables for that?
> >>>>>>>> With skeleton the user space has a natural way to set
> >>>>>>>> all of these knobs after doing skel_open and before skel_load.
> >>>>>>>> Then the verifier sees them as readonly vars and
> >>>>>>>> automatically converts LDX into fixed constants and if the code
> >>>>>>>> looks like if (my_config_var) then the verifier will remove
> >>>>>>>> all the dead code too.
> >>>>>>>
> >>>>>>> Hm, that's a good alternative, let me try it out. Thanks!
> >>>>>>
> >>>>>> Turns out we already freeze kconfig map in libbpf:
> >>>>>> if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG) {
> >>>>>>          err = bpf_map_freeze(map->fd);
> >>>>>>
> >>>>>> And I've verified that I do hit bpf_map_direct_read in the verifier.
> >>>>>>
> >>>>>> But the code still stays the same (bpftool dump xlated):
> >>>>>>    72: (18) r1 = map[id:24][0]+20
> >>>>>>    74: (61) r1 = *(u32 *)(r1 +0)
> >>>>>>    75: (bf) r2 = r9
> >>>>>>    76: (b7) r0 = 0
> >>>>>>    77: (15) if r1 == 0x0 goto pc+9
> >>>>>>
> >>>>>> I guess there is nothing for sanitize_dead_code to do because my
> >>>>>> conditional is "if (likely(some_condition)) { do something }" and the
> >>>>>> branch instruction itself is '.seen' by the verifier.
> >>>
> >>>>> I bet your variable is not 'const'.
> >>>>> Please see any of the progs in selftests that do:
> >>>>> const volatile int var = 123;
> >>>>> to express configs.
> >>>
> >>>> Yeah, I was testing against the following:
> >>>
> >>>>      extern int CONFIG_XYZ __kconfig __weak;
> >>>
> >>>> But ended up writing this small reproducer:
> >>>
> >>>>      struct __sk_buff;
> >>>
> >>>>      const volatile int CONFIG_DROP = 1; // volatile so it's not
> >>>>                                          // clang-optimized
> >>>
> >>>>      __attribute__((section("tc"), used))
> >>>>      int my_config(struct __sk_buff *skb)
> >>>>      {
> >>>>              int ret = 0; /*TC_ACT_OK*/
> >>>
> >>>>              if (CONFIG_DROP)
> >>>>                      ret = 2 /*TC_ACT_SHOT*/;
> >>>
> >>>>              return ret;
> >>>>      }
> >>>
> >>>> $ bpftool map dump name my_confi.rodata
> >>>
> >>>> [{
> >>>>           "value": {
> >>>>               ".rodata": [{
> >>>>                       "CONFIG_DROP": 1
> >>>>                   }
> >>>>               ]
> >>>>           }
> >>>>       }
> >>>> ]
> >>>
> >>>> $ bpftool prog dump xlated name my_config
> >>>
> >>>> int my_config(struct __sk_buff * skb):
> >>>> ; if (CONFIG_DROP)
> >>>>      0: (18) r1 = map[id:3][0]+0
> >>>>      2: (61) r1 = *(u32 *)(r1 +0)
> >>>>      3: (b4) w0 = 1
> >>>> ; if (CONFIG_DROP)
> >>>>      4: (64) w0 <<= 1
> >>>> ; return ret;
> >>>>      5: (95) exit
> >>>
> >>>> The branch is gone, but the map lookup is still there :-(
> >>>
> >>> Attached another RFC below which is doing the same but from the verifier
> >>> side. It seems we should be able to resolve LD+LDX if their dst_reg
> >>> is the same? If they are different, we should be able to pre-lookup
> >>> LDX value at least. Would something like this work (haven't run full
> >>> verifier/test_progs yet)?
> >>>
> >>> (note, in this case, with kconfig, I still see the branch)
> >>>
> >>>   test_fold_ro_ldx:PASS:open 0 nsec
> >>>   test_fold_ro_ldx:PASS:load 0 nsec
> >>>   test_fold_ro_ldx:PASS:bpf_obj_get_info_by_fd 0 nsec
> >>>   int fold_ro_ldx(struct __sk_buff * skb):
> >>>   ; if (CONFIG_DROP)
> >>>      0: (b7) r1 = 1
> >>>      1: (b4) w0 = 1
> >>>   ; if (CONFIG_DROP)
> >>>      2: (16) if w1 == 0x0 goto pc+1
> >>>      3: (b4) w0 = 2
> >>>   ; return ret;
> >>>      4: (95) exit
> >>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
> >>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
> >>>   #66      fold_ro_ldx:OK
> >>>
> >>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>> ---
> >>>   kernel/bpf/verifier.c                         | 74 ++++++++++++++++++-
> >>>   .../selftests/bpf/prog_tests/fold_ro_ldx.c    | 52 +++++++++++++
> >>>   .../testing/selftests/bpf/progs/fold_ro_ldx.c | 20 +++++
> >>>   3 files changed, 144 insertions(+), 2 deletions(-)
> >>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/fold_ro_ldx.c
> >>>   create mode 100644 tools/testing/selftests/bpf/progs/fold_ro_ldx.c
> >>>
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index c59c3df0fea6..ffedd8234288 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -12695,6 +12695,69 @@ static bool bpf_map_is_cgroup_storage(struct
> >>> bpf_map *map)
> >>>                map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> >>>   }
> >>>
> >>> +/* if the map is read-only, we can try to fully resolve the load */
> >>> +static bool fold_ro_pseudo_ldimm64(struct bpf_verifier_env *env,
> >>> +                                struct bpf_map *map,
> >>> +                                struct bpf_insn *insn)
> >>> +{
> >>> +     struct bpf_insn *ldx_insn = insn + 2;
> >>> +     int dst_reg = ldx_insn->dst_reg;
> >>> +     u64 val = 0;
> >>> +     int size;
> >>> +     int err;
> >>> +
> >>> +     if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr)
> >>> +             return false;
> >>> +
> >>> +     /* 0: BPF_LD  r=MAP
> >>> +      * 1: BPF_LD  r=MAP
> >>> +      * 2: BPF_LDX r=MAP->VAL
> >>> +      */
> >>> +
> >>> +     if (BPF_CLASS((insn+0)->code) != BPF_LD ||
> >>> +         BPF_CLASS((insn+1)->code) != BPF_LD ||
> >>> +         BPF_CLASS((insn+2)->code) != BPF_LDX)
> >>> +             return false;
> >>> +
> >>> +     if (BPF_MODE((insn+0)->code) != BPF_IMM ||
> >>> +         BPF_MODE((insn+1)->code) != BPF_IMM ||
> >>> +         BPF_MODE((insn+2)->code) != BPF_MEM)
> >>> +             return false;
> >>> +
> >>> +     if (insn->src_reg != BPF_PSEUDO_MAP_VALUE &&
> >>> +         insn->src_reg != BPF_PSEUDO_MAP_IDX_VALUE)
> >>> +             return false;
> >>> +
> >>> +     if (insn->dst_reg != ldx_insn->src_reg)
> >>> +             return false;
> >>> +
> >>> +     if (ldx_insn->off != 0)
> >>> +             return false;
> >>> +
> >>> +     size = bpf_size_to_bytes(BPF_SIZE(ldx_insn->code));
> >>> +     if (size < 0 || size > 4)
> >>> +             return false;
> >>> +
> >>> +     err = bpf_map_direct_read(map, (insn+1)->imm, size, &val);
> >>> +     if (err)
> >>> +             return false;
> >>> +
> >>> +     if (insn->dst_reg == ldx_insn->dst_reg) {
> >>> +             /* LDX is using the same destination register as LD.
> >>> +              * This means we are not interested in the map
> >>> +              * pointer itself and can remove it.
> >>> +              */
> >>> +             *(insn + 0) = BPF_JMP_A(0);
> >>> +             *(insn + 1) = BPF_JMP_A(0);
> >>> +             *(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
> >> Have you figured out why the branch is not removed
> >> with BPF_ALU64_IMM(BPF_MOV) ?
> >
> > I do have an idea, yes, but I'm not 100% certain. The rewrite has
> > nothing to do with it.
> > If I change the default ret from 1 to 0, I get a different bytecode
> > where this branch is eventually removed by the verifier.
> >
> > I think it comes down to the following snippet:
> > r1 = 0 ll
> > r1 = *(u32 *)(r1 + 0) <<< rodata, verifier is able to resolve to r1 = 1
> > w0 = 1
> > if w1 == 0 goto +1
> > w0 = 2
> > exit
> > Here, 'if w1 == 0' is never taken, but it has been 'seen' by the
> > verifier. There is no 'dead' code, it just jumps around 'w0 = 2' which
> > has seen=true.
> >
> > VS this one:
> > r1 = 0 ll
> > r1 = *(u32 *)(r1 + 0) <<< rodata, verifier is able to resolve to r1 = 1
> > w0 = 1
> > if w1 != 0 goto +1
> > w0 = 0
> > w0 <<= 1
> > exit
> > Here, 'if w1 != 0' is seen, but the next insn has 'seen=false', so
> > this whole thing is ripped out.
> >
> > So basically, from my quick look, it seems like there should be some
> > real dead code to trigger the removal. If you simply have 'if
> > condition_that_never_happens goto +1' which doesn't lead to some dead
> > code, this single jump-over-some-seen-code is never gonna be removed.
> > So, IMO, that's something that should be addressed independently.
> >
> >> Can it also support 8 bytes (BPF_DW) ?  Is it because there
> >> is not enough space for ld_imm64?  so wonder if this
> >> patching can be done in do_misc_fixups() instead.
> >
> > Yeah, I've limited it to 4 bytes because of sizeof(imm) for now.
> > I think one complication might be that at do_misc_fixups point, the
> > immediate args of bpf_ld have been rewritten which might make it
> > harder to get the data offset.
> >
> > But I guess I'm still at the point where I'm trying to understand
> > whether what I'm doing makes sense or not :-) And whether we should do
> > it at the verifier level, in libbpf or if at all..
>
> I think the approach above is a little bit fragile.
> There is no guarantee that ldx immediately after ld.
> Also, after rewrite, some redundant instructions still
> left (e.g., map pointer load) although it can be rewritten
> as a nop.

Yeah, it's possible there is no ldx, or it's possible that map's ptr
in ld is used by some other instruction later on. I agree that all
this rewriting is still best case and might be a bit ugly :-(

> In general, 'const volatile int var' should be good enough
> although it still have one extra load instruction. How much
> did you see performance hit with this extra load?

I haven't tested anything yet. I think I'll try to convert my prog to
kconfig and then have:

#ifdef STATIC_CONFIG
const int CONFIG_XYZ = 1;
#else
extern const int CONFIG_XYZ __kconfig __weak;
#endif

And maybe roll that STATIC_CONFIG=true version somewhere for a week or
two to see whether there is any effect.

> If we truely want to generate best code (no libbpf/verifier
> rewrite with nop's) robustly, we can implement this in llvm as
> a CO-RE relocation. In such cases, compiler will be
> able to generate
>       r = <patchable_value>
>       ... using r ...
>
> So in the above code, the CO-RE based approach will generate:
>    r1 = <patchable value>  // we can make it always 64bit value
>    w0 = 1
>    if w1 != 0 goto +1
>    w0 = 0
>    w0 <<= 1
>    exit
>
> This will only work for upto 64bit int types.
> The kconfig itself supports array as well for which
> CO-RE won't work.

What is the criteria for emitting a relocation in this case? Something
like a __kconfig tag?
In my initial attempt, I've been doing these rewrites on the libbpf
side, so maybe that's the way to go if we can emit proper relocations
for ld+ldx?

[1] https://lore.kernel.org/bpf/7b2e6553-5bcc-1c70-2c4b-78e95593755b@fb.com/T/#m5efdc6672ff3da98f806375381d5e055060cbe54

> >
> >
> >
> >
> >>> +             return true;
> >>> +     }
> >>> +
> >>> +     *(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
> >>> +     /* Only LDX can be resolved, we still have to resolve LD address. */
> >>> +     return false;
> >>> +}
