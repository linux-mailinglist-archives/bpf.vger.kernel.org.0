Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2996055A1BE
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 21:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiFXS5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiFXS53 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 14:57:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46E81A2B
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 11:57:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z19so4666617edb.11
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3lMUT4t8tQjDimk0Od4kUrlPf99UkXhRHQSiJIsgs8=;
        b=YalyTijXEyIInfY+o7A8ZH7e/AZVw5FQFUl8omsvK8JdOLDomWWT0B7vejumcQ1KKJ
         CiujJvjBSlZhbNQqwPkCGoAqeq/meOWXBRFATQHUuztvF6q8GiHo876L5B0oyv/lu3Ea
         qvNKFupPbsvPPPCWog+1GRoQH/ug0Ui8DVJFYfrXnX0mJccKZdmwpmpg7jHLRKAKCYGe
         LILXVzXKhV23DoTEVzr2oXBD4pRGjAMEOXfth/zxfhK9bMXdbjxwfWmT2ZKawSStn+ow
         Yd+yWJCsW9gyIp1OZ3yQng72QDqNiQ1FUCNmKD7y8DhVsA4gY15KDN3FNqO1feUxnCog
         Z2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3lMUT4t8tQjDimk0Od4kUrlPf99UkXhRHQSiJIsgs8=;
        b=c9tdQOBb2fKsRwMPwE/y1iGbZSHMQPKxQTie33sj7IIwa1VCgIJI5AdVJ3N3l/8Ftp
         g26Q7kDXKqA6o3R/BTrFFtt7NRhCLsTgRY1ZvQ2Br0U8iK+MdncDe9Q3Jbepr+QwPmJ4
         Br8ycDDd4eJDkqbKiOCN44lIu3J2SshBfZI6o6VNxziBcCx89DpeXQ0nwMGlrf3Swcop
         0RLRWjXBCxV0cbXuKLPpg2vBd45zDl38JL/txJ6P2mUByyR/hxwvszOds8+QVSoGiGEq
         zmL1oT4duqxitf5Wt7d3z8txAQCSnVHRaQK3LvpYDdi6bVOoKXY72Oxpy933TPF6png4
         b12w==
X-Gm-Message-State: AJIora8L9BpDJyhsDWlsCp97Iz3BzQH8lUP06vJjR725I+iCGzdM6IZ5
        qjtDYXtYvn3vPGkgo0mZ3CMeHPdfRv2iNK8TdCI=
X-Google-Smtp-Source: AGRyM1vN2QetLX1KO6NvDNPf7q0c9hGj+CeFndZ3UvyJObvVzhcMnXXyq4iHmyV5pUIbShOtFGB9YAnG7TDXtqpvkAo=
X-Received: by 2002:a05:6402:5309:b0:435:6431:f9dc with SMTP id
 eo9-20020a056402530900b004356431f9dcmr708796edb.14.1656097046784; Fri, 24 Jun
 2022 11:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <43f4de24e5981152b8a31d4629e199c012c4f52c.camel@gmail.com>
 <20220623031101.q7kwa5jb4e7czqso@macbook-pro-3.dhcp.thefacebook.com>
 <5c297e5009bcd4f0becf59ccd97cfd82bb3a49ec.camel@gmail.com> <20220624183918.qatsud6fdrtjj3qy@MacBook-Pro-3.local>
In-Reply-To: <20220624183918.qatsud6fdrtjj3qy@MacBook-Pro-3.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 11:57:15 -0700
Message-ID: <CAEf4BzY_E8MSL4mD0UPuuiDcbJhh9e2xQo2=5w+ppRWWiYSGvQ@mail.gmail.com>
Subject: Re: [RFC bpf-next] Speedup for verifier.c:do_misc_fixups
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 11:39 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 23, 2022 at 05:02:34PM +0300, Eduard Zingerman wrote:
> > > On Wed, 2022-06-22 at 20:11 -0700, Alexei Starovoitov wrote:
> > [...]
> > > tbh sounds scary. We had so many bugs in the patch_insn over years.
> > > The code is subtle.
> >
> > In terms of testing strategy the following could be done:
> > - use pseudo-random testing to verify that `bpf_patch_insn_data` and
> >   the mechanism suggested in my email produce identical code.
> > - use pseudo-random testing to verify that offsets after rewrite point
> >   to expected instructions (e.g. use .imm field as a unique marker for
> >   the instruction).
> > - hand-written tests for corner cases.
> >
> > Would you consider this to be sufficient?  (Probably does not sound
> > too reassuring from the person[me] who submits patches with trivial
> > use after free errors :)
> >
> > [...]
> >
> > > Before proceeding too far based on artificial test please collect
> > > the number of patches and their sizes we currently do across all progs
> > > in selftests. Maybe it's not that bad in real code.
> >
> > I will collect and share the stats on Saturday or Sunday.
> >
> > > As far as algo the patch_and_copy_insn() assumes that 'dst' insn is a branch?
> > > I guess I'm missing some parts of the proposed algo.
> >
> > Sorry, I made a mistake in the original email, the code for
> > patch_and_copy_insn() should look as follows:
> >
> > static void patch_and_copy_insn(struct bpf_patching_state *state, int pc,
> >                               struct bpf_insn *dst, struct bpf_insn *src) {
> >       memcpy(dst, src, sizeof(struct bpf_insn));
> >       // TODO: other classes
> >       // TODO: also adjust imm for calls
> >       if (BPF_CLASS(src->code) == BPF_JMP) {
> >               int new_pc = pc + lookup_delta_for_index(state, pc);
> >               int dst_pc = pc + src->off + 1;
> >               int new_dst = dst_pc + lookup_delta_for_index(state, dst_pc);
> >               dst->off = new_dst - new_pc - 1;
> >       }
> > }
> >
> >
> > The logic is as follows:
> > - compute new instruction index for the old pc
> > - compute new instruction index for the (old pc + offset)
> > - use these values to compute the new offset
> >
> > The draft implementation of this algorithm is at the end of this
> > email.
> >
> > > Instead of delaying everything maybe we can do all patching inline
> > > except bpf_adj_branches?
> > > Remember only:
> > >    int offset;             /* index inside the original program,
> > >                             * the instruction at this index would be replaced.
> > >                             */
> > >    int insns_count;        /* size of the patch */
> > >    int delta;              /* difference in indexes between original program and
> > >                             * new program after application of all patches up to
> > >                             * and including this one.
> > >                             */
> > > and do single bpf_adj_branches at the end ?
> >
> > The algorithm consists of two parts:
> > - To avoid excessive copying patches are accumulated in a separate
> >   array and size of this array is doubled each time the capacity is
> >   not sufficient to fit a new patch. This should have O(log(n))
> >   complexity in terms of copied bytes.
> > - To avoid excessive branch adjustment passes a single branch
> >   adjustment pass is performed at the end. This pass visits each
> >   instruction only once, however, for each instruction it will have
> >   to query the delta value in a sorted array. Thus the overall
> >   complexity of this pass would be O(n*log(n)). It is possible to
> >   adjust some relevant fields in `env` during this pass as well.
>
> Before jumping into coding let's explore the alternatives.
> Can we use some of the compiler techniques?
> Like:
> - split a set of insn into basic blocks (BB)
> - convert each jmp from relative offset to fixed bb index
> - perform patching of insns. No jmp adjustments are necessary.
>   Every patch applies within bb. Minimal realloc+copy of insns within bb.
> - reconstruct a set of insn from a set of bb-s.
>
> John, Yonghong, everyone,
> may be other ideas?

We've had similar discussion ages (~3 years) ago. I had much more
context at that time, but I'll link to my latest proposal ([0]) within
that thread.

Roughly the idea was along the lines of what Alexei proposed above,
but instead of a basic block we kept all instructions as individual
linked list nodes. So we'd need something like 2x of memory relative
to the current array of struct bpf_insns, but that seems totally
acceptable. And then instead of updating relative indices, we'd keep a
mapping from the original instruction index to the latest real
instruction index. All this is pretty hazy for me at this point, but I
thought I'd link to that old discussion for completeness.

  [0] https://lore.kernel.org/bpf/CAEf4BzYDAVUgajz4=dRTu5xQDddp5pi2s=T1BdFmRLZjOwGypQ@mail.gmail.com/
