Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA845571A0
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 06:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiFWEjy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 00:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiFWDLG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 23:11:06 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897029C9B
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 20:11:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id n12so10889811pfq.0
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 20:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dTs5RDVeqdri7iFfplfQ4lwLSUwY9+XSgGGFaAkxqys=;
        b=DR6QNYvo9BV/hJb0lK0LqsFg3VtEHBhhQScF07B3GZMdGFRF+Nh5b2/pH3zjLzspMn
         adv2Pt+sQh7qoPSNV7HIdHcfc7uW2elr9EUHXNbObttVoT3wCgEZsiJI1qClUHe07H68
         n+otDRJyAByQNl40yHf3PAQyf2IFG6SIwkNrsErFRpIxDhnEDSrtErJ8RbKhI8ZFkQjH
         EEX/ANs2+lNyG8I9Am28QMLbeGjosXfmVonfMp+7Do4WO/IHJspyrE1Hk2A1ceO8cojB
         KCFB6OOqS15WOLHyAIQc93dmBGteJep06MPIQ2F58u7L4Qsevdk+g8E+gjm7qAc2nulo
         mrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dTs5RDVeqdri7iFfplfQ4lwLSUwY9+XSgGGFaAkxqys=;
        b=jvd5+4uqNezZoQgKBSvf1Wbj41v9q+aZQ4pUO0vxU7sIMc2mywRd1JOslYh9wR42Qn
         /ZoL9OSr+Sb0EgsNcg1Hwdqy36hiDV4s1XyQ7i2rj5+N0XLa8yI1BSWiBhQOg3b75Elg
         d5jm0oMOYJQnkoBHkDLiTkmgfnQYDw0x2wy2BNcBvEc/4siSOcfk7BgHFxA0uGP+/AZ0
         fVbzj8VP9fgFzY3pRTP2ITV+nX62F9LBz7hVHUkTWLJ5Ir9NLM0NjTAzNlCAS0DuvS0E
         yWdzXW9/L/ypefX6ZLiII7s0laGsJVQKImCwqciTyVUwoEkV0v04PuOGiXr160FQkUdz
         Zsjw==
X-Gm-Message-State: AJIora895U924yHBP0znU6aNKAa88T9tE3iYdxqCWydJAElljwZE2fMa
        CRRPq1cNqnplB4KsqWqT0b4=
X-Google-Smtp-Source: AGRyM1sa/1LRX9oeCIVmtcLD9gQ3yexCeAS56QATvTGDpv9wnYuEd+UO2NzXLvO5AYjaFkiMZ0b77Q==
X-Received: by 2002:a63:3fcb:0:b0:40c:4da1:555a with SMTP id m194-20020a633fcb000000b0040c4da1555amr5738414pga.3.1655953864321;
        Wed, 22 Jun 2022 20:11:04 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b0016892555955sm13455881plh.179.2022.06.22.20.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:11:03 -0700 (PDT)
Date:   Wed, 22 Jun 2022 20:11:01 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [RFC bpf-next] Speedup for verifier.c:do_misc_fixups
Message-ID: <20220623031101.q7kwa5jb4e7czqso@macbook-pro-3.dhcp.thefacebook.com>
References: <43f4de24e5981152b8a31d4629e199c012c4f52c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f4de24e5981152b8a31d4629e199c012c4f52c.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 02:30:21AM +0300, Eduard Zingerman wrote:
> Hi Everyone,
> 
> Below I describe a scenario when function `verifier.c:do_misc_fixups`
> exhibits O(n**2) performance for certain BPF programs. I also describe
> a possible adjustment for the `verifier.c:do_misc_fixups` to avoid
> such behavior. I can work on this adjustment in my spare time for a
> few weeks if the community is interested.
> 
> The function `verifier.c:do_misc_fixups` uses
> `verifier.c:bpf_patch_insn_data` to replace single instructions with a
> series of instructions. The `verifier.c:bpf_patch_insn_data` is a
> wrapper for the function `core.c:bpf_patch_insn_single`. The latter
> function operates in the following manner:
> - allocates new instructions array of size `old size + patch size`;
> - copies old instructions;
> - copies patch instructions;
> - adjusts offset fields for all instructions.
> 
> This algorithm means that for pathological BPF programs the
> `verifier.c:do_misc_fixups` would demonstrate running time
> proportional to the square of the program length.
> An example of such program looks as follows:
> 
> BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64);
> ... N times ...
> BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64);
> BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
> BPF_EXIT_INSN();
> 
> `verifier.c:do_misc_fixups` replaces each call to jiffies by 3
> instructions. Hence the code above would lead to the copying of
> (N + N+2 + N+4 ... + N+2N) bytes, which is O(n**2).
> 
> Experimental results confirm this observation.  Here is the output of
> the demo program:
> 
>   prog len     verif time usec
>        128          1461
>        256 x2       4132 x2.8
>        512 x2      12510 x3.0
>       1024 x2      44022 x3.5
>       2048 x2     170479 x3.9
>       4096 x2     646766 x3.8
>       8192 x2    2557379 x4.0
> 
> The source code for this program is at the end of this email.
> 
> The following technique could be used to improve the running time of
> the `verifier.c:do_misc_fixups`:
> - patches are not applied immediately but are accumulated;
> - patches are stored in the intermediate array; the size of this array
>   is doubled when the capacity for the new patch is insufficient;
> - patches are applied at once at the end of the `verifier.c:do_misc_fixups`;
> - intermediate data structure is constructed to efficiently map
>   between old and new instruction indexes;
> - instruction offset fields are updated using this data structure.
> 
> In terms of the C code, this could look as follows:
> 
> /* Describes a single patch:
>  * BPF instruction at index `offset` is replaced by
>  * a series of the instructions pointed to by `insns`.
>  */
> struct bpf_patch {
>   int offset;             /* index inside the original program,
>                            * the instruction at this index would be replaced.
>                            */
>   int insns_count;        /* size of the patch */
>   int delta;              /* difference in indexes between original program and
>                            * new program after application of all patches up to
>                            * and including this one.
>                            */
>   struct bpf_insn *insns; /* patch instructions */
> };
> 
> /* Used to accumulate patches */
> struct bpf_patching_state {
>   struct bpf_patch *patches; /* array of all patches*/
>   int patches_count;         /* current amount of patches */
>   int patches_capacity;      /* total capacity of the patches array */
>   struct bpf_insn *insns;    /* array of patch instructions,
>                               * bpf_patch::insns points to the middle of this array
>                               */
>   int insns_count;           /* first free index in the instructions array */
>   int insns_capacity;        /* total capacity of the instructions array */
> };
> 
> /* Allocates `patches` and `insns` arrays with some initial capacity */
> static int init_patching_state(struct bpf_patching_state *state)
> { ... }
> 
> /* Adds a patch record to the `bpf_patching_state::patches` array.
>  * If array capacity is insufficient, its size is doubled.
>  * Copies `insns` to the end of the `bpf_patching_state::insns`.
>  * If array capacity is insufficient, its size is doubled.
>  *
>  * It is assumed that patches are added in increasing order of
>  * the `bpf_patch::offset` field.
>  */
> static int add_patch(struct bpf_patching_state *state,
>                      int offset,
>                      int insns_count,
>                      struct bpf_insn *insns)
> { ... }
> 
> /* - fills in the `bpf_patch::delta` fields for all patches in `state`.
>  * - allocates new program
>  * - copies program and patch instructions using the `patch_and_copy_insn` function
>  */
> static struct bpf_insn* apply_patches(struct bpf_patching_state *state,
>                                       struct bpf_insn *prog,
>                                       int *prog_size) {
> {
>   int delta = 0;
>   for (int i = 0; i < state->patches_count; ++i) {
>     delta += state->patches[i].insns_count - 1;
>     state->patches[i].delta = delta;
>   }
>   ...
> }
> 
> /* Uses binary search to find `bpf_patch::delta` corresponding to `index`.
>  * `index` stands for the index of instruction in the original program.
>  * Looks for the closest `state->patches[?]->offset <= index` and returns it's `delta`.
>  */
> static int lookup_delta_for_index(struct bpf_patching_state *state, int index)
> { ... }
> 
> /* Copies instruction at `src` to instruction at `dst` and adjusts `dst->off` field.
>  * `pc` stands for the instruction index of `src` in the original program.
>  */
> static void patch_and_copy_insn(struct bpf_patching_state *state,
>                                 int pc,
>                                 struct bpf_insn *dst,
>                                 struct bpf_insn *src)
> {
>   int new_pc = pc + lookup_delta_for_index(state, pc);
>   int new_dst = pc + dst->off + lookup_delta_for_index(state, pc + dst->off);
> 
>   memcpy(dst, src, sizeof(struct bpf_insn));
>   dst->off = new_dst - new_pc;
> }
> 
> Please let me know what you think about this change and whether or not
> it should be implemented.

tbh sounds scary. We had so many bugs in the patch_insn over years.
The code is subtle.
The main overhead is from bpf_adj_branches() as you noticed.
We might even do it twice for programs larger than S16_MAX resulting
in O(n^3) behavior.
There is also bpf_adj_linfo, adjust_insn_aux_data, adjust_subprog_starts,
adjust_poke_descs.
Every time we patch.
It's certainly something worth optimizing if we can.
Before proceeding too far based on artificial test please collect
the number of patches and their sizes we currently do across all progs
in selftests. Maybe it's not that bad in real code.

As far as algo the patch_and_copy_insn() assumes that 'dst' insn is a branch?
I guess I'm missing some parts of the proposed algo.

Instead of delaying everything maybe we can do all patching inline
except bpf_adj_branches?
Remember only:
   int offset;             /* index inside the original program,
                            * the instruction at this index would be replaced.
                            */
   int insns_count;        /* size of the patch */
   int delta;              /* difference in indexes between original program and
                            * new program after application of all patches up to
                            * and including this one.
                            */
and do single bpf_adj_branches at the end ?
