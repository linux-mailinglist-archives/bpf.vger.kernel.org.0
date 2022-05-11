Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CBA523D05
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241692AbiEKTHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 15:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbiEKTHB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 15:07:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5418F694BD
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:06:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c9so2804337plh.2
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OQ2DJoEMb9WJyctGe+oZoLFB0Yfp9azM45Or20+78So=;
        b=BPGKqi9SpUDloK3pw9C06D25Yr8C+rCEUhPtdwI2afNkmmE3rVaHoWCWRkNSyTBkg0
         lFqjnvmBiI/ebtIs9F7Sl/I9FpfgACzBws8TBe1cjcYlkKrj9kKce25ZzamG2q0lUJwk
         mJVap3942fSz7YOUybyHN+sdtzNMgcyhuCNaUh+F2SVa4iH1CpkOwK8dAZAaxw4TsnEE
         6D+yfdQFT4Rbh4gaQNHA+mELfelD+QZjLjsrMRcuT4BBAUxF6VRY/P63ZQyjNdzLWMPP
         krykyd2HwYHWtR32V53Ci03hp+p22OPbjTSC/F2ftwg0klfInKkZCC+TwDDyZwyCJ+Kq
         tHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OQ2DJoEMb9WJyctGe+oZoLFB0Yfp9azM45Or20+78So=;
        b=fvprwuEqDfEOn3wLD1l/Q6ft85QBtY8tHw5rH4cPYrh6dUUK7sfLkBoAxI77QiFSNE
         rccGD7Ov23FlXo50hDMtuqDHVqnJgdRNNrsTuyImD0fdTi5x3JEgFsfXFqeSva57Q/zi
         R7KcaHdJlT9CBGbksPsVwHZ/uR9qdrgf8vwaD/rbjXgUEArdp4SeX04X0RSBAjg/sn/K
         otR2SmJdfTyUMSSMR4eCtbHrAfJrCUyNHFxFUYxphtpO9kLniaT5iJrQ1bxY8LeZDt2y
         aP43oQsmYlBwCSG0fIjb1Ni3fJvJjmAH/nclZTcIiIFgtU3TRLpdNfNqg1VADopjbF0c
         v5Pg==
X-Gm-Message-State: AOAM532MEAJtJBO7L91sdr+OQ3RwXcg/V4Hn0Sy4WpCwlYJQttFuEw3A
        R+1xHp6qmLQoeuob2XrH+oU=
X-Google-Smtp-Source: ABdhPJzMcgEKgrGgNQd+vTh0XKbF9nKrTfuinINc+ntadcI8RHEj1kr21bgz/uJTwadiZWvGxKvZEg==
X-Received: by 2002:a17:902:ab5c:b0:15c:ea3a:9437 with SMTP id ij28-20020a170902ab5c00b0015cea3a9437mr26874206plb.9.1652296017639;
        Wed, 11 May 2022 12:06:57 -0700 (PDT)
Received: from localhost ([112.79.166.171])
        by smtp.gmail.com with ESMTPSA id c18-20020a63d512000000b003c2677c9c9esm215206pgg.67.2022.05.11.12.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:06:54 -0700 (PDT)
Date:   Thu, 12 May 2022 00:37:24 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Prepare prog_test_struct kfuncs for
 runtime tests
Message-ID: <20220511190724.bphqd57s22qrbobu@apollo.legion>
References: <20220510211727.575686-1-memxor@gmail.com>
 <20220510211727.575686-3-memxor@gmail.com>
 <CAADnVQ+WFGc4yEAGVuxzbWkXsj2G+U2nN4YmEzMh7SHbHdknjA@mail.gmail.com>
 <20220511060233.x2ew422zqnoj2itc@apollo.legion>
 <CAADnVQKi8mSMv5FMxyptFkAeJetpMgY5oqZz-n-y+WyXiCDbyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKi8mSMv5FMxyptFkAeJetpMgY5oqZz-n-y+WyXiCDbyg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 11:23:59PM IST, Alexei Starovoitov wrote:
> On Tue, May 10, 2022 at 11:01 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed, May 11, 2022 at 10:07:35AM IST, Alexei Starovoitov wrote:
> > > On Tue, May 10, 2022 at 2:17 PM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > In an effort to actually test the refcounting logic at runtime, add a
> > > > refcount_t member to prog_test_ref_kfunc and use it in selftests to
> > > > verify and test the whole logic more exhaustively.
> > > >
> > > > To ensure reading the count to verify it remains stable, make
> > > > prog_test_ref_kfunc a per-CPU variable, so that inside a BPF program the
> > > > count can be read reliably based on number of acquisitions made. Then,
> > > > pairing them with releases and reading from the global per-CPU variable
> > > > will allow verifying whether release operations put the refcount.
> > >
> > > The patches look good, but the per-cpu part is a puzzle.
> > > The test is not parallel. Everything looks sequential
> > > and there are no races.
> > > It seems to me if it was
> > > static struct prog_test_ref_kfunc prog_test_struct = {..};
> > > and none of [bpf_]this_cpu_ptr()
> > > the test would work the same way.
> > > What am I missing?
> >
> > You are not missing anything. It would work the same. I just made it per-CPU for
> > the off chance that someone runs ./test_progs -t map_kptr in parallel on the
> > same machine. Then one or both might fail, since count won't just be inc/dec by
> > us, and reading it would produce something other than what we expect.
>
> I see. You should have mentioned that in the commit log.
> But how per-cpu helps in this case?
> prog_run is executed with cpu=0, so both test_progs -t map_kptr
> will collide on the same cpu.

Right, I was thinking bpf_prog_run disabled preemption, so that would prevent
collisions, but it seems my knowledge is now outdated (only migration is
disabled). Also, just realising, we rely on observing a specific count across
test_run invocations, which won't be protected against for parallel runs
anyway.

> At the end it's the same. one or both might fail?
>
> In general all serial_ tests in test_progs will fail in
> parallel run.
> Even non-serial tests might fail.
> The non-serial tests are ok for test_progs -j.
> They're parallel between themselves, but there are no guarantees
> that every individual test can be run parallel with itself.
> Majority will probably be fine, but not all.
>

I'll drop it and go with a global struct.

> > One other benefit is getting non-ref PTR_TO_BTF_ID to prog_test_struct to
> > inspect cnt after releasing acquired pointer (using bpf_this_cpu_ptr), but that
> > can also be done by non-ref kfunc returning a pointer to it.
>
> Not following. non-ref == ptr_untrusted. That doesn't preclude

By non-ref PTR_TO_BTF_ID I meant normal (not untrusted) PTR_TO_BTF_ID with
ref_obj_id = 0.

bpf_this_cpu_ptr returns a normal PTR_TO_BTF_ID, not an untrusted one.

> bpf prog from reading refcnt directly, but disallows passing
> into helpers.
> So with non-percpu the following hack
>  bpf_kfunc_call_test_release(p);
>  if (p_cpu->cnt.refs.counter ...)
> wouldn't be necessary.
> The prog could release(p) and read p->cnt.refs.counter right after.

release(p) will kill p, so that won't work. I have a better idea, since
p->next points to itself, just loading that will give me a pointer I can
read after release(p).

As an aside, do you think we should change the behaviour of killing released
registers and skip it for refcounted PTR_TO_BTF_ID (perhaps mark it as untrusted
pointer instead, with ref_obj_id reset to zero)? So loads are allowed into it,
but passing into the kernel isn't, wdyt?

p = acq();	  // p.type = PTR_TO_BTF_ID, ref_obj_id=X
foo(p);		  // works
bar(p->a + p->b); // works
rel(p);		  // p.type = PTR_TO_BTF_ID | PTR_UNTRUSTED, ref_obj_id=0
		  // Instead of mark_reg_unknown(p)

There is still the case where you can do:
p2 = p->next;
rel(p);
p3 = p->next;

Now p2 is trusted PTR_TO_BTF_ID, while p3 is untrusted, but this is a separate
problem which requires a more general fix, and needs more discussion.

A bit of a digression, but I would like to know what you and other BPF
developers think.

So far my thinking (culminating towards an RFC) is this:

For a refcounted PTR_TO_BTF_ID, it is marked as trusted.

When loading from it, by default all loads yield untrusted pointers, except
those which are specifically marked with some annotation ("bpf_ptr_trust") which
indicates that parent holds reference to member pointer. This is a loose
description to mean that for the lifetime of trusted parent pointer, member
pointer may also be trusted. If lifetime can end (due to release), trusted
member pointers will become untrusted. If it cannot (e.g. function arguments),
it remains valid.

This will use BTF tags.
Known cases in the kernel which are useful and safe can be whitelisted.

Such loads yield trusted pointers linked to refcounted PTR_TO_BTF_ID. Linked
means the source refcounted PTR_TO_BTF_ID owns it.

When releasing PTR_TO_BTF_ID, all registers with same ref_obj_id, and all linked
PTR_TO_BTF_ID are marked as untrusted.

As an example:

struct foo {
	struct bar __ref *br;
	struct baz *bz;
};

struct foo *f = acq(); // f.type = PTR_TO_BTF_ID, ref_obj_id=X
br = f->br;	       // br.type = PTR_TO_BTF_ID, linked_to=X
bz = f->bz;	       // bz.type = PTR_TO_BTF_ID | PTR_UNTRUSTED
rel(f);		       // f.type = PTR_TO_BTF_ID | PTR_UNTRUSTED
		       // and since br.linked_to == f.ref_obj_id,
		       // br.type = PTR_TO_BTF_ID | PTR_UNTRUSTED

For trusted loads from br, linked_to will be same as X, so they will also be
marked as untrusted, and so on.

For tp_btf/LSM programs, pointer arguments will be non-refcounted trusted
PTR_TO_BTF_ID. All rules as above apply, but since it cannot be released,
trusted pointers obtained from them remain valid till BPF_EXIT.

I have no idea how much backwards compat this will break, or how much of it can
be tolerated.

> While with per-cpu approach you had to do
> p_cpu = bpf_this_cpu_ptr(&prog_test_struct);
> hack and rely on intimate knowledge of the kernel side.
>
> > If you feel it's not worth it, I will drop it in the next version.
>
> So far I see the downsides.
> Also check the CI. test_progs-no_alu32 fails:
> test_map_kptr_fail_prog:PASS:map_kptr__load must fail 0 nsec
> test_map_kptr_fail_prog:FAIL:expected error message unexpected error: -22
> Expected: Unreleased reference id=5 alloc_insn=18
> Verifier: 0: R1=ctx(off=0,imm=0) R10=fp0

Yes, noticed that. It is because alloc_insn= is different for no_alu32. I'll
drop the matching on specific insn idx number.

Thanks for your feedback.

--
Kartikeya
