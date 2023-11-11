Return-Path: <bpf+bounces-14860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BEC7E8922
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 05:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E137BB20B85
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 04:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D652263D7;
	Sat, 11 Nov 2023 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8qUTm9T"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AB63AD
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 04:29:51 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9521B1FD7
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 20:29:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so4234501a12.2
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 20:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699676988; x=1700281788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+qimNDMryS7m0ho0AvUTcm6WXYsipjT9jeYHLCi0fo=;
        b=W8qUTm9TQVgRp+jpxY98thE1Um7FCn3NPCWCxUopaACN9iuL8YGRrXxjfcwPC8jg43
         45pj1OoxJt40QOJv9j/YuaS6R0VyAf0d80K0PWig4Shx42sNUh5gQwc4T41ulgJOct84
         MzQb0PAfIMSC4g8cAxj4Qnc2M5un31G/jjTiMsDZwv8BPF2wxCQMBJz7+ZpGMVM4NgEj
         1Edn359oPRElZA3aTOdRYrRchwjmxNWjutEGaKDlGhq36nxHsXMfiicbQS4fqrnAyiOM
         B8h/E/grgHVA4cNQcddRCX1Z2RVCyTCd4b4XPkThrefJf5rNmMdybSFmcpG6pizzVA9x
         jEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699676988; x=1700281788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+qimNDMryS7m0ho0AvUTcm6WXYsipjT9jeYHLCi0fo=;
        b=w7DRVOSKiuJ3StDV1UYlW44RfvnMygSQT+aim+IDOB2Rc+t1SnPmKlvLfrV06eC032
         0/NOVXl4zu3atVyx8gpCwUd+4gcGhlFItEhRwU1mQNsauJzTQkRcYV9MgdlyQYN2BUQ7
         is0QKNvJSHLrxO3E4cgv/91XaQE2Umt3satrGkUE0gy0ArYCCpMz16eVNOGjaU9kMbad
         UNUQEnFKveQNyfr6wZRsPzfHO9IzOPm1ADIsoE8KEuGJ+bCGNdO57vqWIwN4eNkqp+B3
         MLm2JQiACMlUJIKHEzF6apDk2JCqAmUmiDmhX2Uty+luCgZQDrDvfIF84vLeqnxTOu0l
         gXBw==
X-Gm-Message-State: AOJu0Yy+d3usJTsYEOaWV2znldceK77qQIvLQipOgl54DLxSTgH7jgin
	KTQL2emDH+Bx4O5uYRxpNGzMZFmfFAifHm54pB+V/cnG97Q=
X-Google-Smtp-Source: AGHT+IEkK0FlJDc3zSVnaNm65AM9DxxCEJMbTSRV/DXhcDunACoUTmkSFCNb7uDB670CTd2sKUNaNaMGfTOYUht06l4=
X-Received: by 2002:aa7:d6c9:0:b0:542:d2c4:b423 with SMTP id
 x9-20020aa7d6c9000000b00542d2c4b423mr788599edr.30.1699676987787; Fri, 10 Nov
 2023 20:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-2-andrii@kernel.org>
 <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com>
 <CAADnVQL6_o9z3z1=8o7qGNzAD8vKMZ+OetcYYy-1huxGfCJToA@mail.gmail.com>
 <CAEf4BzaA12xjXm8KZNB1mkVDOTtVDQDDWF4nYQtQ2qRYoTip3A@mail.gmail.com>
 <CAADnVQLGn4vRuZLqTm_t_9ff3t=Hsugr0j47YLThhPsnpNrs_Q@mail.gmail.com>
 <CAEf4BzY72H_0fF4C1kGbX5_ymNu6NHYf55HAnU8i5dnaQ+f_vA@mail.gmail.com>
 <CAEf4BzYn83g6TSwWcqqdcJBPB74kRs5iX73J9Vdrt7fT6VstdA@mail.gmail.com>
 <CAADnVQ+wd0MVVxxLKgTQiNTSZ34ZwqM84jmgcj-f87F97PgqSw@mail.gmail.com> <CAEf4BzaWySecJbYQtVxqqJet=yh3aAyoW-_v9x33VjbMHH0PtA@mail.gmail.com>
In-Reply-To: <CAEf4BzaWySecJbYQtVxqqJet=yh3aAyoW-_v9x33VjbMHH0PtA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Nov 2023 20:29:35 -0800
Message-ID: <CAEf4BzaFEFV1q92qGHdWS468O+-h7NGU+vGPv=9UzH8NHAFepw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history
 across all states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 2:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 2:06=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Nov 9, 2023 at 12:39=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Nov 9, 2023 at 11:49=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Nov 9, 2023 at 11:29=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Nov 9, 2023 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > >
> > > > > > If we ever break DFS property, we can easily change this. Or we=
 can
> > > > > > even have a hybrid: as long as traversal preserves DFS property=
, we
> > > > > > use global shared history, but we can also optionally clone and=
 have
> > > > > > our own history if necessary. It's a matter of adding optional
> > > > > > potentially NULL pointer to "local history". All this is very n=
icely
> > > > > > hidden away from "normal" code.
> > > > >
> > > > > If we can "easily change this" then let's make it last and option=
al patch.
> > > > > So we can revert in the future when we need to take non-DFS path.
> > > >
> > > > Ok, sounds good. I'll reorder and put it last, you can decide wheth=
er
> > > > to apply it or not that way.
> > > >
> > > > >
> > > > > > But again, let's look at data first. I'll get back with numbers=
 soon.
> > > > >
> > > > > Sure. I think memory increase due to more tracking is ok.
> > > > > I suspect it won't cause 2x increase. Likely few %.
> > > > > The last time I checked the main memory hog is states stashed for=
 pruning.
> > > >
> > > > So I'm back with data. See verifier.c changes I did at the bottom,
> > > > just to double check I'm not missing something major. I count the
> > > > number of allocations (but that's an underestimate that doesn't tak=
e
> > > > into account realloc), total number of instruction history entries =
for
> > > > entire program verification, and then also peak "depth" of instruct=
ion
> > > > history. Note that entries should be multiplied by 8 to get the amo=
unt
> > > > of bytes (and that's not counting per-allocation overhead).
> > > >
> > > > Here are top 20 results, sorted by number of allocs for Meta-intern=
al,
> > > > Cilium, and selftests. BEFORE is without added STACK_ACCESS trackin=
g
> > > > and STACK_ZERO optimization. AFTER is with all the patches of this
> > > > patch set applied.
> > > >
> > > > It's a few megabytes of memory allocation, which in itself is proba=
bly
> > > > not a big deal. But it's just an amount of unnecessary memory
> > > > allocations which is basically at least 2x of the total number of
> > > > states that we can save. And instead have just a few reallocs to si=
ze
> > > > global jump history to an order of magnitudes smaller peak entries.
> > > >
> > > > And if we ever decide to track more stuff similar to
> > > > INSNS_F_STACK_ACCESS, we won't have to worry about more allocations=
 or
> > > > more memory usage, because the absolute worst case is our global
> > > > history will be up to 1 million entries tops. We can track some *co=
de
> > > > path dependent* per-instruction information for *each simulated
> > > > instruction* easily without having to think twice about this. Which=
 I
> > > > think is a nice liberating thought in itself justifying this change=
.
> > > >
> > > >
> > >
> > > Gmail butchered tables. See Github gist ([0]) for it properly formatt=
ed.
> > >
> > >   [0] https://gist.github.com/anakryiko/04c5a3a5ae4ee672bd11d4b7b3d83=
2f5
> >
> > I think 'peak insn history' is the one to look for, since
> > it indicates total peak memory consumption. Right?
>
> Hm... not really? Peak here is the longest sequence of recorded jumps
> from root state to any "current". I calculated that to know how big
> global history would be necessary.
>
> But it's definitely not a total peak memory consumption, because there
> will be states enqueued in a stack still to be processed, and we keep
> their jmp_history around. see push_stack() and copy_verifier_state()
> we do in that.
>
> > It seems the numbers point out a bug in number collection or
> > a bug in implementation.
>
> yeah, but accounting implementation, I suspect. I think I'm not
> handling failing states properly.
>
> I'll double check and fix it up, but basically only failing BPF
> programs should have bad accounting.

Alexei, your intuition was right! There is indeed a bug in patch #2.
What's funny, it's conceptually the same bug I just fixed in
backtracking logic ([0]). Basically, we cannot rely on checking
instruction indices for equality to make sure it's exactly the same
verified instruction (because it could be the instruction with the
same index, but earlier in verification history). I do also have a bit
of accounting imprecision for last failed state for jmp_total stat,
but I didn't bother fixing it because it's just off by few, and only
for failed validations.

The good news is that this bug actually doesn't affect results at all,
except for that one verifier_loops1.c case (for the same reason why
that bug in [0] wasn't reported earlier, it's a very rare situation
for real-world BPF programs). See updated results in [1].

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231110002638.4=
168352-3-andrii@kernel.org/
  [1] https://gist.github.com/anakryiko/4e61d28f1a2caecea4315e50e4346120

Anyways, the fix is pretty straightforward, if not the most elegant.
I'll roll it into patch #2 for next revision (it will be patch #1,
because I moved common history refactoring to be the last one, as
agreed). Still need to add tests and stuff that Eduard requested.

commit f11d05fb037f6a69eff8c7d4eff4c422374af37f (HEAD -> bpf-verif-jmp-hist=
ory)
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Fri Nov 10 20:12:05 2023 -0800

    [FIX] remember current insn hist entry to reuse for flags

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 75d9507a8a9f..42a7619dcf80 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -693,6 +693,7 @@ struct bpf_verifier_env {
         */
        char tmp_str_buf[TMP_STR_BUF_LEN];
        struct bpf_insn_hist_entry *insn_hist;
+       struct bpf_insn_hist_entry *cur_hist_ent;
        u32 insn_hist_cap;
 };

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2878077e0a54..eebda0367dca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3652,13 +3652,8 @@ static int push_insn_history(struct
bpf_verifier_env *env, struct bpf_verifier_s
        size_t alloc_size;

        /* combine instruction flags if we already recorded this instructio=
n */
-       if (cur->insn_hist_end > cur->insn_hist_start &&
-           (p =3D &env->insn_hist[cur->insn_hist_end - 1]) &&
-           p->idx =3D=3D env->insn_idx &&
-           p->prev_idx =3D=3D env->prev_insn_idx) {
-               WARN_ON_ONCE(p->flags & (INSN_F_STACK_ACCESS |
-                            INSN_F_FRAMENO_MASK | (INSN_F_SPI_MASK <<
INSN_F_SPI_SHIFT)));
-               p->flags |=3D insn_flags;
+       if (env->cur_hist_ent) {
+               env->cur_hist_ent->flags |=3D insn_flags;
                return 0;
        }

@@ -3676,6 +3671,7 @@ static int push_insn_history(struct
bpf_verifier_env *env, struct bpf_verifier_s
        p->idx =3D env->insn_idx;
        p->prev_idx =3D env->prev_insn_idx;
        p->flags =3D insn_flags;
+       env->cur_hist_ent =3D p;
        cur->insn_hist_end++;

        env->jmp_hist_peak =3D max(env->jmp_hist_peak, cur->insn_hist_end);
@@ -17408,6 +17404,9 @@ static int do_check(struct bpf_verifier_env *env)
                u8 class;
                int err;

+               /* reset current history entry on each new instruction */
+               env->cur_hist_ent =3D NULL;
+
                env->prev_insn_idx =3D prev_insn_idx;
                if (env->insn_idx >=3D insn_cnt) {
                        verbose(env, "invalid insn idx %d insn_cnt %d\n",


>
> >
> > before:
> > verifier_loops1.bpf.linked3.o peak=3D499999
> > loop3.bpf.linked3.o peak=3D111111
> >
> > which makes sense, since both tests hit 1m insn.
> > I can see where 1/2 and 1/9 come from based on asm.
> >
> > after:
> > verifier_loops1.bpf.linked3.o peak=3D25002
> > loop3.bpf.linked3.o peak=3D333335
> >
> > So the 1st test got 20 times smaller memory footprint
> > while 2nd was 3 times higher.
> >
> > Both are similar infinite loops.
> >
> > The 1st one is:
> > l1_%=3D:  r0 +=3D 1;                                        \
> >         goto l1_%=3D;                                     \
> >
> > My understanding is that there should be all 500k jmps in history with
> > or without these patches.
> >
> > So now I'm more worried about the correctness of the 1st patch.
>
> I'll look closer at what's going on and will report back.

