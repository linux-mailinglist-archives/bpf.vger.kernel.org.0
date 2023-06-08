Return-Path: <bpf+bounces-2134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C1E728669
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 19:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751E628163D
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AEC1DCBA;
	Thu,  8 Jun 2023 17:33:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC010973
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 17:33:29 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E9C2115
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:33:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51475e981f0so1526894a12.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686245606; x=1688837606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEePzKoBkAh3KucI7jg88EBA4DJMyUEER6I7p60vkEo=;
        b=KadAhwgzao1kfPTbh2oj5rJbvn2JqA0GL9F9Sm32ibgi20B7Asf5btTX+Ec7nXPZdl
         Funas33zZBMhG+HXJOas7la2Quktb5VwoWxmFMxWW2eNFthV1cgPtCRYHqTzta5Zt8R1
         gSvHdshN4cIiyO0SCRseEqjGwWsXpxHwvUmb+i/krWTSltDHe9k4Ebp3pESvdgzP7ODJ
         p/YX0UrnUgZ75AVly1RHO/LI3zMELvkPojnYWt41296Mf9J/5sbH0oG/mFPPfy4EpG/U
         WGdc7xxLA8vGWoqD51fdI+kcCrAFmxjDZhBePdUC7gGA95m09HpmPGHcIqhgALwst1OL
         novQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686245606; x=1688837606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEePzKoBkAh3KucI7jg88EBA4DJMyUEER6I7p60vkEo=;
        b=EBNkHNfbWfis5vQGDph2YqNkOr79EanfSyO8UoaLOh5eueKkAmPpJjl4iJYEuDO+Te
         chkpo4C7cClPypxnGWJNwXW7sryExBOfu2hiFzu6DImiPhHtCV41C/RGBK/7xKwE5Dx4
         eEubxoxWMiDxxF69u1DGhlXpjgkD2fysw5UbAXHXix77tWqX42oPOxkA83TYJXvV7z37
         HoTELj/u+hXfc2HalLaAie+MDVar/+N4mYVUo0f0B2cKWRmHGF7Bs2WXY5ChZ9Fa3bkn
         Ub6UKfNyc/q3gIJxfNXkwxnWy6GjR0wuGrCUSVpvDkJWGvf0T5iex3iFbayU4A6fJ3W1
         j/TQ==
X-Gm-Message-State: AC+VfDydO4N5abhQwscb6immNKTIo9+tfHbO/rSrB+9jETREwFVhcIPX
	0okDPJzs80qJs6iunOPzfVejkqtb+H0a89/cgnc=
X-Google-Smtp-Source: ACHHUZ5BKRDt9wVNETqlrViQFK8OrytCHAzdtdIny2ztOChwgT+Yx9QHK6sxpitEhX445i/PJ6sFsHPRG9Slj9maHMM=
X-Received: by 2002:a17:906:fe02:b0:974:1c90:643f with SMTP id
 wy2-20020a170906fe0200b009741c90643fmr486537ejb.18.1686245605903; Thu, 08 Jun
 2023 10:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606222411.1820404-1-eddyz87@gmail.com> <20230606222411.1820404-3-eddyz87@gmail.com>
 <CAEf4BzbLSe8H+ER6UTMgORH--bXKkn4popUsU2W0hHadSQuv1A@mail.gmail.com> <8faef9d6a31616d71b798e0d3f94c6c1946e5cad.camel@gmail.com>
In-Reply-To: <8faef9d6a31616d71b798e0d3f94c6c1946e5cad.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 10:33:13 -0700
Message-ID: <CAEf4BzaZ79t=dv0Kje-i5ngDFuE=LWbA4M=BOJF3bUfWSeVZrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] selftests/bpf: check if
 mark_chain_precision() follows scalar ids
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2023-06-07 at 14:40 -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > Check __mark_chain_precision() log to verify that scalars with same
> > > IDs are marked as precise. Use several scenarios to test that
> > > precision marks are propagated through:
> > > - registers of scalar type with the same ID within one state;
> > > - registers of scalar type with the same ID cross several states;
> > > - registers of scalar type  with the same ID cross several stack fram=
es;
> > > - stack slot of scalar type with the same ID;
> > > - multiple scalar IDs are tracked independently.
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > >  .../selftests/bpf/progs/verifier_scalar_ids.c | 324 ++++++++++++++++=
++
> > >  2 files changed, 326 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar=
_ids.c
> > >
> >
> > Great set of tests! I asked for yet another one, but this could be
> > easily a follow up. Looks great.
>
> Thanks.
>
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > [...]
> >
> > > +
> > > +/* Same as precision_same_state_broken_link, but with state /
> > > + * parent state boundary.
> > > + */
> > > +SEC("socket")
> > > +__success __log_level(2)
> > > +__msg("frame0: regs=3Dr0,r2 stack=3D before 6: (bf) r3 =3D r10")
> > > +__msg("frame0: regs=3Dr0,r2 stack=3D before 5: (b7) r1 =3D 0")
> > > +__msg("frame0: parent state regs=3Dr0,r2 stack=3D:")
> > > +__msg("frame0: regs=3Dr0,r1,r2 stack=3D before 4: (05) goto pc+0")
> > > +__msg("frame0: regs=3Dr0,r1,r2 stack=3D before 3: (bf) r2 =3D r0")
> > > +__msg("frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0")
> > > +__msg("frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255")
> > > +__msg("frame0: parent state regs=3Dr0 stack=3D:")
> > > +__msg("frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_ktime_get_=
ns")
> > > +__flag(BPF_F_TEST_STATE_FREQ)
> > > +__naked void precision_cross_state_broken_link(void)
> > > +{
> > > +       asm volatile (
> > > +       /* r0 =3D random number up to 0xff */
> > > +       "call %[bpf_ktime_get_ns];"
> > > +       "r0 &=3D 0xff;"
> > > +       /* tie r0.id =3D=3D r1.id =3D=3D r2.id */
> > > +       "r1 =3D r0;"
> > > +       "r2 =3D r0;"
> > > +       /* force checkpoint, although link between r1 and r{0,2} is
> > > +        * broken by the next statement current precision tracking
> > > +        * algorithm can't react to it and propagates mark for r1 to
> > > +        * the parent state.
> > > +        */
> > > +       "goto +0;"
> > > +       /* break link for r1, this is the only line that differs
> > > +        * compared to the previous test
> > > +        */
> >
> > not really the only line, goto +0 is that different line ;)
>
> My bad, the comment should be "... this is the only line that differs
> compared to precision_cross_state_broken()".
>
> >
> > > +       "r1 =3D 0;"
> > > +       /* force r0 to be precise, this immediately marks r1 and r2 a=
s
> > > +        * precise as well because of shared IDs
> > > +        */
> > > +       "r3 =3D r10;"
> > > +       "r3 +=3D r0;"
> > > +       "r0 =3D 0;"
> > > +       "exit;"
> > > +       :
> > > +       : __imm(bpf_ktime_get_ns)
> > > +       : __clobber_all);
> > > +}
> > > +
> > > +/* Check that precision marks propagate through scalar IDs.
> > > + * Use the same scalar ID in multiple stack frames, check that
> > > + * precision information is propagated up the call stack.
> > > + */
> > > +SEC("socket")
> > > +__success __log_level(2)
> > > +/* bar frame */
> > > +__msg("frame2: regs=3Dr1 stack=3D before 10: (bf) r2 =3D r10")
> > > +__msg("frame2: regs=3Dr1 stack=3D before 8: (85) call pc+1")
> > > +/* foo frame */
> > > +__msg("frame1: regs=3Dr1,r6,r7 stack=3D before 7: (bf) r7 =3D r1")
> > > +__msg("frame1: regs=3Dr1,r6 stack=3D before 6: (bf) r6 =3D r1")
> > > +__msg("frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1")
> > > +/* main frame */
> > > +__msg("frame0: regs=3Dr0,r1,r6 stack=3D before 3: (bf) r6 =3D r0")
> > > +__msg("frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0")
> > > +__msg("frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255")
> >
> > nice test! in this case we discover r6 and r7 during instruction
> > backtracking. Let's add another variant of this multi-frame test with
> > a forced checkpoint to make sure that all this works correctly between
> > child/parent states with multiple active frames?
>
> Because of BPF_F_TEST_STATE_FREQ new state is created at each prune
> point. Prune points are marked for each conditional target and
> sub-program entry. I skipped a lot of log lines for brevity, here is a
> bigger portion of the log:
>
>   8: (85) call pc+1
>   caller:
>      frame1: R6=3Dscalar(id=3D1,...) R7=3Dscalar(id=3D1,...) R10=3Dfp0
>   callee:
>      frame2: R1=3Dscalar(id=3D1,...) R10=3Dfp0
>   10: (bf) r2 =3D r10                     ; frame2: R2_w=3Dfp0 R10=3Dfp0
>   11: (0f) r2 +=3D r1
>   frame2: last_idx 11 first_idx 10 subseq_idx -1        <- current state
>   frame2: regs=3Dr1 stack=3D before 10: (bf) r2 =3D r10
>   frame2: parent state regs=3Dr1 stack=3D
>   frame1: parent state regs=3Dr6,r7 stack=3D                <- (I)
>   frame0: parent state regs=3Dr6 stack=3D
>
>   frame2: last_idx 8 first_idx 8 subseq_idx 10          <- parent state
>   frame2: regs=3Dr1 stack=3D before 8: (85) call pc+1
>   frame1: parent state regs=3Dr1,r6,r7 stack=3D             <- (II)
>   frame0: parent state regs=3Dr6 stack=3D
>
>   frame1: last_idx 7 first_idx 6 subseq_idx 8           <- parent state
>   frame1: regs=3Dr1,r6,r7 stack=3D before 7: (bf) r7 =3D r1
>   frame1: regs=3Dr1,r6 stack=3D before 6: (bf) r6 =3D r1
>   frame1: parent state regs=3Dr1 stack=3D
>   frame0: parent state regs=3Dr6 stack=3D
>
>   frame1: last_idx 4 first_idx 4 subseq_idx 6           <- parent state
>   frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1
>   frame0: parent state regs=3Dr1,r6 stack=3D
>
>   frame0: last_idx 3 first_idx 1 subseq_idx 4           <- parent state
>   frame0: regs=3Dr0,r1,r6 stack=3D before 3: (bf) r6 =3D r0
>   frame0: regs=3Dr0,r1 stack=3D before 2: (bf) r1 =3D r0
>   frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255
>
> At (I) frame1.r{6,7} are marked because mark_precise_scalar_ids()
> looks for all registers with frame2.r1.id in the current state.
> At (II) frame1.r1 is marked because of backtracking of call instruction.
> It looks like both ba=D1=81ktracking and cross-state propagation are test=
ed.
> Maybe I miss-understand your comment.
>

From the set of __msg() tests it's not obvious that (I) is happening.
So just maybe let's messages like below:

__msg("frame1: parent state regs=3Dr6,r7 stack=3D")

to make it more explicit?

Either way, it's minor. You are right about checkpoint after each
helper call and subprog call.


> >
> > > +__flag(BPF_F_TEST_STATE_FREQ)
> > > +__naked void precision_many_frames(void)
> > > +{
> > > +       asm volatile (
> > > +       /* r0 =3D random number up to 0xff */
> > > +       "call %[bpf_ktime_get_ns];"
> > > +       "r0 &=3D 0xff;"
> > > +       /* tie r0.id =3D=3D r1.id =3D=3D r6.id */
> > > +       "r1 =3D r0;"
> > > +       "r6 =3D r0;"
> > > +       "call precision_many_frames__foo;"
> > > +       "exit;"
> > > +       :
> > > +       : __imm(bpf_ktime_get_ns)
> > > +       : __clobber_all);
> > > +}
> > > +
> > > +static __naked __noinline __attribute__((used))
> >
> > nit: bpf_misc.h has __used macro defined, we can use that everywhere
> >
> > > +void precision_many_frames__foo(void)
> > > +{
> > > +       asm volatile (
> > > +       /* conflate one of the register numbers (r6) with outer frame=
,
> > > +        * to verify that those are tracked independently
> > > +        */
> > > +       "r6 =3D r1;"
> > > +       "r7 =3D r1;"
> > > +       "call precision_many_frames__bar;"
> > > +       "exit"
> > > +       ::: __clobber_all);
> > > +}
> > > +
> >
> > [...]
>

