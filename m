Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915D7666797
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 01:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjALAYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 19:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjALAYa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 19:24:30 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1297D2F799
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:24:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id l22so11253964eja.12
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G5QT9y+4LRA/zRRfmIOSVopeavGZxRpZyrYqwzw3NDk=;
        b=oHN3Ao2GilUQQO0UZoQZ8Gas7n8XSQBD8Ayrc4uQaLSmSO5XU3/8dqf0Ky3mvw1gAk
         yQPH8ZPN7ow6cPNMjpJ9cvUOuunvTtnU/ll3UEmjiz7DecBKB4vYmh0fcASfoOs5cD3M
         IQPJNtUbPQIWSz6mPGMEncZiODYROhijPTB1oBOAzV2lMTRrqhgFdCVF0jufzXOucOOf
         Tg0IgzXvl+MhNSjjlIEAdPE1rmZV5ngpDviHJJA46gaHNn5Rnbi+ZHyYrOg7k3Kj6hMM
         6dkNr9rg9SCrAGLII44LuJCKoEDbDeIVRdM8ajAc6e3ji5qUvWMJuvxDznrgNl1azdCz
         bXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5QT9y+4LRA/zRRfmIOSVopeavGZxRpZyrYqwzw3NDk=;
        b=zDE0JYqAIC3iGpInm3pybW++tH9u/DsPI+DG8xmlkDqJbgp3/J17KQW1UwWci3t9iz
         YUvsjKxoR0OxF7WW7/fbjMHz/+frEgJ4IjnM1OVltcLG3glZqVT8Z5tZrCTIaujrwx14
         xZbu73NxLOaxVebW8vF9pL2ACj7VrZ4MkjuI820XA2mHkCmRJEeW3yZgBHh6Nzwrnjy3
         cRd0R5geBah/jZysX1Zx3o1u1nN9TZeMb8TCOUaqBM9YkKVi85ECw75VD3KSEY9buOSv
         jYqHdtKEm+L96KseNT9lPwDAh2GwreA2u8MF1Pql2DiibwL4CS5cE8Q41LkwQ9/ZOtP1
         1l8w==
X-Gm-Message-State: AFqh2kpTkToJzxW7VgqYCgtj5h/RtzRFENoaWwwSzcG1/2hN56vXgIiq
        kir8xXAwDaReHdmWsAMmsDBdYjzFtHgJO19Op7Xciwt9qUI=
X-Google-Smtp-Source: AMrXdXsAh32AyxvvWP9OLtyS6Q/RLw5Ep/OC7OsmvHI0HzevIbBgfQ3EbcZtbqpzy3J4qaHTUN+NAIons0sd0W5z24U=
X-Received: by 2002:a17:906:f43:b0:84c:95c7:304d with SMTP id
 h3-20020a1709060f4300b0084c95c7304dmr5619419ejj.545.1673483067474; Wed, 11
 Jan 2023 16:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20230106142214.1040390-1-eddyz87@gmail.com>
In-Reply-To: <20230106142214.1040390-1-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Jan 2023 16:24:14 -0800
Message-ID: <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 6, 2023 at 6:22 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Struct bpf_reg_state is copied directly in several places including:
> - check_stack_write_fixed_off() (via save_register_state());
> - check_stack_read_fixed_off();
> - find_equal_scalars().
>
> However, a literal copy of this struct also copies the following fields:
>
> struct bpf_reg_state {
>         ...
>         struct bpf_reg_state *parent;
>         ...
>         enum bpf_reg_liveness live;
>         ...
> };
>
> This breaks register parentage chain and liveness marking logic.
> The commit message for the first patch has a detailed example.
> This patch-set replaces direct copies with a call to a function
> copy_register_state(dst,src), which preserves 'parent' and 'live'
> fields of the 'dst'.
>
> The fix comes with a significant verifier runtime penalty for some
> selftest binaries listed in tools/testing/selftests/bpf/veristat.cfg
> and cilium BPF binaries (see [1]):
>
> $ ./veristat -e file,prog,states -C -f 'states_diff>10' master-baseline.log current.log
> File                        Program                           States (A)  States (B)  States   (DIFF)
> --------------------------  --------------------------------  ----------  ----------  ---------------
> bpf_host.o                  tail_handle_ipv4_from_host               231         299    +68 (+29.44%)
> bpf_host.o                  tail_handle_nat_fwd_ipv4                1088        1320   +232 (+21.32%)
> bpf_host.o                  tail_handle_nat_fwd_ipv6                 716         729     +13 (+1.82%)
> bpf_host.o                  tail_nodeport_nat_ingress_ipv4           281         314    +33 (+11.74%)
> bpf_host.o                  tail_nodeport_nat_ingress_ipv6           245         256     +11 (+4.49%)
> bpf_lxc.o                   tail_handle_nat_fwd_ipv4                1088        1320   +232 (+21.32%)
> bpf_lxc.o                   tail_handle_nat_fwd_ipv6                 716         729     +13 (+1.82%)
> bpf_lxc.o                   tail_ipv4_ct_egress                      239         262     +23 (+9.62%)
> bpf_lxc.o                   tail_ipv4_ct_ingress                     239         262     +23 (+9.62%)
> bpf_lxc.o                   tail_ipv4_ct_ingress_policy_only         239         262     +23 (+9.62%)
> bpf_lxc.o                   tail_ipv6_ct_egress                      181         195     +14 (+7.73%)
> bpf_lxc.o                   tail_ipv6_ct_ingress                     181         195     +14 (+7.73%)
> bpf_lxc.o                   tail_ipv6_ct_ingress_policy_only         181         195     +14 (+7.73%)
> bpf_lxc.o                   tail_nodeport_nat_ingress_ipv4           281         314    +33 (+11.74%)
> bpf_lxc.o                   tail_nodeport_nat_ingress_ipv6           245         256     +11 (+4.49%)
> bpf_overlay.o               tail_handle_nat_fwd_ipv4                 799         829     +30 (+3.75%)
> bpf_overlay.o               tail_nodeport_nat_ingress_ipv4           281         314    +33 (+11.74%)
> bpf_overlay.o               tail_nodeport_nat_ingress_ipv6           245         256     +11 (+4.49%)
> bpf_sock.o                  cil_sock4_connect                         47          70    +23 (+48.94%)
> bpf_sock.o                  cil_sock4_sendmsg                         45          68    +23 (+51.11%)
> bpf_sock.o                  cil_sock6_post_bind                       31          42    +11 (+35.48%)
> bpf_xdp.o                   tail_lb_ipv4                            4413        6457  +2044 (+46.32%)
> bpf_xdp.o                   tail_lb_ipv6                            6876        7249    +373 (+5.42%)
> test_cls_redirect.bpf.o     cls_redirect                            4704        4799     +95 (+2.02%)
> test_tcp_hdr_options.bpf.o  estab                                    180         206    +26 (+14.44%)
> xdp_synproxy_kern.bpf.o     syncookie_tc                           21059       21485    +426 (+2.02%)
> xdp_synproxy_kern.bpf.o     syncookie_xdp                          21857       23122   +1265 (+5.79%)
> --------------------------  --------------------------------  ----------  ----------  ---------------
>
> I looked through verification log for bpf_xdp.o tail_lb_ipv4 program in
> order to identify the reason for ~50% visited states increase.

It's just a 2K increase and it is fixing a real issue, so I think it's
totally acceptable (and see below about STACK_INVALID vs STACK_MISC).
Thanks for taking the time to analyze and explain this!

> The slowdown is triggered by a difference in handling of three stack slots:
> fp-56, fp-72 and fp-80, with the main difference coming from fp-72.
> In fact the following change removes all the difference:
>
> @@ -3256,7 +3256,10 @@ static void save_register_state(struct bpf_func_state *state,
>  {
>         int i;
>
> -       copy_register_state(&state->stack[spi].spilled_ptr, reg);
> +       if ((spi == 6 /*56*/ || spi == 8 /*72*/ || spi == 9 /*80*/) && size != BPF_REG_SIZE)
> +               state->stack[spi].spilled_ptr = *reg;
> +       else
> +               copy_register_state(&state->stack[spi].spilled_ptr, reg);
>
> For fp-56 I found the following pattern for divergences between
> verification logs with and w/o this patch:
>
> - At some point insn 1862 is reached and checkpoint is created;
> - At some other point insn 1862 is reached again:
>   - with this patch:
>     - the current state is considered *not* equivalent to the old checkpoint;
>     - the reason for mismatch is the state of fp-56:
>       - current state: fp-56=????mmmm
>       - checkpoint: fp-56_rD=mmmmmmmm

I'm wondering if we should consider allowing uninitialized
(STACK_INVALID) reads from stack, in general. It feels like it's
causing more issues than is actually helpful in practice. Common code
pattern is to __builtin_memset() some struct first, and only then
initialize it, basically doing unnecessary work of zeroing out. All
just to avoid verifier to complain about some irrelevant padding not
being initialized. I haven't thought about this much, but it feels
that STACK_MISC (initialized, but unknown scalar value) is basically
equivalent to STACK_INVALID for all intents and purposes. Thoughts?

Obviously, this is a completely separate change and issue from what
you are addressing in this patch set.

Awesome job on tracking this down and fixing it! For the patch set:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>   - without this patch the current state is considered equivalent to the
>     checkpoint, the fp-56 is not present in the checkpoint.
>
> Here is a fragment of the verification log for when the checkpoint in
> question created at insn 1862:
>
> checkpoint 1862:  ... fp-56=mmmmmmmm ...
> 1862: ...
> 1863: ...
> 1864: (61) r1 = *(u32 *)(r0 +0)
> 1865: ...
> 1866: (63) *(u32 *)(r10 -56) = r1     ; R1_w=scalar(...) R10=fp0 fp-56=
> 1867: (bf) r2 = r10                   ; R2_w=fp0 R10=fp0
> 1868: (07) r2 += -56                  ; R2_w=fp-56
> ; return map_lookup_elem(&LB4_BACKEND_MAP_V2, &backend_id);
> 1869: (18) r1 = 0xffff888100286000    ; R1_w=map_ptr(off=0,ks=4,vs=8,imm=0)
> 1871: (85) call bpf_map_lookup_elem#1
>
> - Without this patch:
>   - at insn 1864 r1 liveness is set to REG_LIVE_WRITTEN;
>   - at insn 1866 fp-56 liveness is set REG_LIVE_WRITTEN mark because
>     of the direct r1 copy in save_register_state();
>   - at insn 1871 REG_LIVE_READ is not propagated to fp-56 at
>     checkpoint 1862 because of the REG_LIVE_WRITTEN mark;
>   - eventually fp-56 is pruned from checkpoint at 1862 in
>     clean_func_state().
> - With this patch:
>   - at insn 1864 r1 liveness is set to REG_LIVE_WRITTEN;
>   - at insn 1866 fp-56 liveness is *not* set to REG_LIVE_WRITTEN mark
>     because write size is not equal to BPF_REG_SIZE;
>   - at insn 1871 REG_LIVE_READ is propagated to fp-56 at checkpoint 1862.
>
> Hence more states have to be visited by verifier with this patch compared
> to current master.
>
> Similar patterns could be found for both fp-72 and fp-80, although these
> are harder to track trough the log because of a big number of insns between
> slot write and bpf_map_lookup_elem() call triggering read mark, boils down
> to the following C code:
>
>         struct ipv4_frag_id frag_id = {
>                 .daddr = ip4->daddr,
>                 .saddr = ip4->saddr,
>                 .id = ip4->id,
>                 .proto = ip4->protocol,
>                 .pad = 0,
>         };
>     ...
>     map_lookup_elem(..., &frag_id);
>
> Where:
> - .id is mapped to fp-72, write of size u16;
> - .saddr is mapped to fp-80, write of size u32.
>
> This patch-set is a continuation of discussion from [2].
>
> Changes v1 -> v2 (no changes in the code itself):
> - added analysis for the tail_lb_ipv4 verification slowdown;
> - rebase against fresh master branch.
>
> [1] git@github.com:anakryiko/cilium.git
> [2] https://lore.kernel.org/bpf/517af2c57ee4b9ce2d96a8cf33f7295f2d2dfe13.camel@gmail.com/
>
> Eduard Zingerman (2):
>   bpf: Fix to preserve reg parent/live fields when copying range info
>   selftests/bpf: Verify copy_register_state() preserves parent/live
>     fields
>
>  kernel/bpf/verifier.c                         | 25 +++++++++----
>  .../selftests/bpf/verifier/search_pruning.c   | 36 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 7 deletions(-)
>
> --
> 2.39.0
>
