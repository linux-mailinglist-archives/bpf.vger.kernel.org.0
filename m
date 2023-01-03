Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882C065C91A
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 23:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjACWFD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 17:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjACWFB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 17:05:01 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC5B10046
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 14:04:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk9so77413430ejc.3
        for <bpf@vger.kernel.org>; Tue, 03 Jan 2023 14:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GZL/dx+PKuDt3HxrIDDYpb3/Cy6N363lILzZU9eQqV8=;
        b=IbFGhQ3faEAvqjjFSOExhWRfp3h/qOzJwFjjh9ollOXrUioz1cRsnrMIH91MT6vuoh
         66Pb1yvgEHcLt9B/7UeZKxSs27Xyg818bfoI17PGvvw2N/zjg1j7JfJvQl4UGzGYrS5s
         bMDyfbuyLBLXPXxEPcFhTa2XAi6jsSkGsX28REPfagV4lNB5OIAXunLB9rqaVIMV5yJe
         s+7vxMaS6L735BSlpPm5OyTYz5ZmXSjkNOYVyLKnQQj/NTJKik6oFby8jv0Au9bd/rd2
         fy6Vcez8z+wRMF6K5kPbkG7czgIj1rdJpWnlWVnKS5LWo25OKvcsH8f94RRhLGGIrLsm
         A8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZL/dx+PKuDt3HxrIDDYpb3/Cy6N363lILzZU9eQqV8=;
        b=MOIGDx+ckq/b4xNWlz6H+lDJUxDRdFyFcMZd7j7AxLvoiaEGNvuqarJ0DT3MiUNUKk
         k5iSo0diLXKwFrH4ABzHGqYaWsllUFGWYt67NJE17Uh9gDofxfDiKKXrcmNNJs2tAW++
         2PHrSKiq65BGl1pOymUtcAK/PbIF1eJ2rz4toaFPW02aJml0PkW6tEcOhNwr1TQHTzhi
         tDliDW6KV+gkDapsCvDVwbhyt564A+/qBpTSRg3Prlz4mjVxtBf33AflDFVEd61OChSu
         xjZ6wv259H97+KL+RJWIPZ7tbiHcDt6rGRPdP7MvLlSaXT6bZZCQWcBnSK2Td+QfQX9d
         MgDA==
X-Gm-Message-State: AFqh2koSv4Zt6spTuXIKGyOWPexn3+Z7RnmVod3McTfKrK0VgClpGGiV
        tRbpkLReEJuOnQeeH6S1YylK9RHB0uDO/IzSgupB8OOU
X-Google-Smtp-Source: AMrXdXtbTsQ3cxDbHiYhCHfUl2AlVuaq5i5lRSHIHWKD0pRt086Cb2JiZcEXhsesxPx8LYyxqLe8bza6wNJg9dYlnTQ=
X-Received: by 2002:a17:906:f43:b0:84c:95c7:304d with SMTP id
 h3-20020a1709060f4300b0084c95c7304dmr2126365ejj.545.1672783496718; Tue, 03
 Jan 2023 14:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20221223054921.958283-1-andrii@kernel.org> <20221223054921.958283-8-andrii@kernel.org>
 <20221228020015.xquaykefotqmok7r@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzaT_kp-F3QMeGqpCf8ekhmDVjHwV4y7fYtxjWPFq1yhSg@mail.gmail.com> <20221230021917.yuvm4g7sjj7vy5qc@MacBook-Pro-6.local>
In-Reply-To: <20221230021917.yuvm4g7sjj7vy5qc@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Jan 2023 14:04:44 -0800
Message-ID: <CAEf4BzaaE1B0Xezb5jrH0p-my4_GEb7EPqfAQVBPLyLkq672=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with
 default case in regsafe()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Thu, Dec 29, 2022 at 6:19 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 29, 2022 at 01:59:49PM -0800, Andrii Nakryiko wrote:
> > On Tue, Dec 27, 2022 at 6:00 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Dec 22, 2022 at 09:49:21PM -0800, Andrii Nakryiko wrote:
> > > > Make default case in regsafe() safer. Instead of doing byte-by-byte
> > >
> > > I love the patches 1-6, but this one is not making it safer.
> > > It looks to be going less safe route.
> > > More below.
> > >
> > > > comparison, take into account ID remapping and also range and var_off
> > >
> > > ID remapping is handled by the patch 6 in regs_exact().
> > > This patch adds range and var_off check as default.
> > > Which might not be correct in the future.
> > >
> > > > checks. For most of registers range and var_off will be zero (not set),
> > > > which doesn't matter. For some, like PTR_TO_MAP_{KEY,VALUE}, this
> > > > generalized logic is exactly matching what regsafe() was doing as
> > > > a special case. But in any case, if register has id and/or ref_obj_id
> > > > set, check it using check_ids() logic, taking into account idmap.
> > >
> > > That was already done in patch 6. So the commit log is misleading.
> > > It's arguing that it's a benefit of this change while it was in the previous patch.
> >
> > True, I think I had regs_exact() and regs_equals() change in one
> > commit and split it at the last minute before submitting (I felt like
> > patch #7 will be controversial ;) ), should have proofread messages
> > more carefully. Sorry about that.
> >
> > >
> > > > With these changes, default case should be handling most registers more
> > > > correctly, and even for future register would be a good default. For some
> > > > special cases, like PTR_TO_PACKET, one would still need to implement extra
> > > > checks (like special handling of reg->range) to get better state
> > > > equivalence, but default logic shouldn't be wrong.
> > >
> > > PTR_TO_BTF_ID with var_off would be a counter example where
> > > such default of comparing ranges and var_off would lead to issues.
> > > Currently PTR_TO_BTF_ID doesn't allow var_off, but folks requested this support.
> > > The range_within() logic is safe only for types like PTR_TO_MAP_KEY/VALUE
> > > that start from zero and have uniform typeless blob of bytes.
> > > PTR_TO_BTF_ID with var_off would be wrong to do with just range_within().
> >
> > I'm trying to understand this future problem. I think this is the same
> > issue that Kumar was trying to fix before, but when I asked for more
> > specifics I didn't really get good answer of when this combined
> > var_off and range_within() would be incorrect.
> >
> > Do you mind showing (even if hypothetically) an example when
> > var_off+range_within() won't work? I'm trying to understand this. We
> > should either document why this is not safe, in general, or come to
> > conclusion that it is safe. It's second time this comes up, so let's
> > spend a bit of time getting to the bottom of this?
>
> Kumar's example was for a constant. range_within is the same as equality
> check, so we concluded it's safe for that case.
> I'm worried about non uniformity of structs with types and general
> comparison of ranges.
> I guess you're arguing that if old state had wider range than every single
> possible value from that range was already validated to be safe and
> hence new narrow range is safe too.
> It sounds logical, but it can get tricky with ranges and branch taken logic.
> Consider something like:
> R1=(min=2,max=8), R2=(min=1, max=10)
> if (R1 within R2) // bpf prog is doing its own 'within'

a bit confused what is "R1 within R2" here and what you mean "bpf prog
is doing its own 'within'"? Any sort of `R1 < R2` checks (and any
other op: <=, >=, etc) can't really kick in branch elimination because
R2_min=1 < R1_max=8, so arithmetically speaking we can't conclude that
"R1 is always smaller than R2", so both branches would have to be
examined.

But I probably misunderstood your example, sorry.

>   // branch taken kicks in
> else
>   // issues that were never checked
>
> Now new state has:
> R1=(min=4,max=6), R2=(min=5, max=5)
>
> Both R1 and R2 of new state individually range_within of old safe state,
> but together the prog may go to the unverified path.
> Not sure whether it's practical today.
> You asked for hypothetical, so here it goes :)

No problem with "hypothetical-ness". But my confusion and argument is
similarly "in principle"-like. Because if such an example above can be
constructed then this would be an issue for SCALAR as well, right? And
if you can bypass verifier's safety with SCALAR, you (hypothetically)
could use that SCALAR to do out-of-bounds memory access by adding this
SCALAR to some mem-like register.

So that's my point and my source of confusion: if we don't trust
var_off+range_within() logic to handle *all* situations correctly,
then we should be worried about SCALARs just as much as anything else
(unless, as usual, I missed something).

> More gut feel than real issue.
>
> >
> > >
> > > SCALARS and PTR_TO_BTF_ID will likely dominate future bpf progs.
> > > Keeping default as regs_exact (that does ID match) is safer default.
> >
> > It's fine, though the point of this patch set was patch #7, enabling
> > logic similar to PTR_TO_MAP_VALUE for PTR_TO_MEM and PTR_TO_BUF. I can
> > send specific fixes for that, no problem. But as I said above, I'm
> > really curious to understand what kind of situations will lead to
> > unsafety if we do var_off+range_within checks.
>
> PTR_TO_MEM and PTR_TO_BUF explicitly are likely ok despite my convoluted
> example above.
> I'm less sure about PTR_TO_BTF_ID. It could be ok.
> Just feels safer to opt-in each type explicitly.

Sure, I can just do a simple opt-in, no problem. As I said, mostly
trying to understand the issue overall.

For PTR_TO_BTF_ID specifically, I can see how we can enable
var_off+range_within for cases when we access some array, right? But
then I think we'll be enforcing that we are staying within the
boundaries of a single array field, never crossing into another field.


But just to take a step back, from my perspective var_off and
range_within are complementary and solve slightly different uses, but
should be both satisfied:
  - var_off is not precise with range boundaries (due to some bits too
coarsely marked as unknown), but it's useful to enforce having a value
being a multiple of some power-of-2 (e.g., knowing for sure that
lowest 2 bits are zero means that value is multiple of 4; I haven't
checked, but I assume we check with for various pointer accesses to
ensure we don't have misaligned reads). They can be only approximately
used for actual possible range of values.
  - range_within() can and should be used for *precise* range of value
tracking, but it can't express that alignment restriction.

So while I previously thought that we can do away without var_off, I
now think there are cases when it's necessary. But if we are sure that
we handle any SCALAR case correctly for any possible var_off +
range_within situation, it should be fine to do that for any mem-like
pointer just as much, as var_off+range_within is basically a MEM +
SCALAR combined case.

Anyways, I'm not blocked on this, but I think we'll benefit from
taking this discussion to its logical conclusion.

>
> >
> > >
> > > Having said all that the focus on safety should be balanced with focus on performance
> > > of the verifier itself.
> > > The regsafe is the hottest function.
> > > That first memcmp used to be the hottest part of the whole verifier.
> >
> > yeah, and it was done unconditionally even if not needed, which was
> > kind of weird when I started looking at this. Probably some
> > refactoring leftover.
> >
> > > I suspect this refactoring won't change the perf profile, but we can optimize it.
> > > Assuming that SCALAR, PTR_TO_BTF_ID and PTR_TO_MAP will be the majority of types
> > > we can special case them and refactor comparison to only things
> > > that matter to these types. var_off and min/max_value are the biggest part
> > > of bpf_reg_state. They should be zero for PTR_TO_BTF_ID, but we already check
> > > that in other parts of the verifier. There is no need to compare zeros again
> > > in the hottest regsafe() function.
> > > Same thing for SCALAR. Doing regs_exact() with big memcmp and then finer range_within()
> > > on the same bytes is probably wasteful and can be optimized.
> > > We might consider reshuffling bpf_reg_state fields again depending on cache line usage.
> > > I suspect doing "smart" reg comparison we will be able to significantly
> > > improve verification speed. Please consider for a follow up.
> >
> > I agree. Perf wasn't the point for me (this is a preliminary for
> > iterator stuff to improve state equivalence checks), so I didn't want
> > to spend extra time on this (especially that benchmarking this
> > properly is time consuming, as benchmarking under QEMU isn't
> > representative (from me experiences with BPF ringbuf benchmarking).
> > But I'll keep it on TODO list, either for me or anyone interested in
> > contributing.
>
> Thank you. Lorenz was pondering at it at some point, but lost interest. I guess.
> I did a bunch of perf runs with our test_verif_scale* long ago.
> The perf report used to be the same and stable for them.
> processed_insn and number of states affects both memory and speed
> and % wise have higher contribution to verifier speed, so any improvements
> there help more. Optimizing the actual regsafe() is secondary.
> Just something to put on todo list.

Sure. With veristat we can also have a more aggregated view across
multiple object files (and we can add some mode to veristat to
repeatedly load each program for N times to help with profile
collection).

>
> > >
> > > I've applied the first 6 patches.
> >
> > Cool, thanks, less patches to carry around. If you don't mind, let's
> > look at this var_off concern in details. I can send
> > PTR_TO_MEM-specific follow up fix, but if we can convince ourselves
> > that generic logic is safe and future-proof, I'd rather do a generic
> > change.
