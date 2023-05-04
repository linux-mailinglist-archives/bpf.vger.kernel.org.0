Return-Path: <bpf+bounces-45-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868006F794D
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4C4280F40
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DDCC156;
	Thu,  4 May 2023 22:44:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8F156FB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:44:42 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E23E4D
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:44:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaf21bb427so7874255ad.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240280; x=1685832280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3pGe5lNupjkLmdRAoiJDkJBRhTKcM+8tQgMjupnw4g=;
        b=X2IeAzrlMemmv8vapMu2pEpzoAA4r+oHSg/3B0USC1B+LvD4eQxPzUEtg9k+DI11uX
         Z25WXvhBy9jWIKcTGTRL5oDjx3a1NoKyIj4TF57stywc82/ZAoj5yK1CAWZqJK5BIjcB
         q11dMQY26K0AiZFRajjk7lojVDfnKJZFa5uJHpet5GJ3S5tYqwrOWq5YJZpROJXtWP1O
         kkirnv/uwqf3ny8GBZJlvbiKpRRJBu7pefGniQCYlpU9Z6sjj3XlEYGO6UCOXdT8nOg0
         2UNeAWl57zdKUJlXyOEtR06oiUFxSWgPxNeN2JIOJ7Jo18nV0mzF4eXuTY87I1cnPUR9
         tW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240280; x=1685832280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3pGe5lNupjkLmdRAoiJDkJBRhTKcM+8tQgMjupnw4g=;
        b=QayFZ5LV5bzjFaQoxzyqxbDhM+mEUxr11z9eUGODYSFFep4ks8dzB45tPg5px4UOwm
         DdrLkGgE+m+PjSnoakWXYKwLHvAmzunRh4+YB2b4y7T0+KiCKY6chN0Ap3wyEv3RowEt
         xcsq1+4SN4yQdhK5Fv3ZszcxWhbY11DmTzxv7M8S/05HBQ8u5BANLpLa/tX/62x2v0P9
         Vh9IEgPwQHYWBJklD1WWxYJz3uZ4f+cGO6bfZXEqvHhuFrtvEp7OfnwPr8vGkEA+8F4l
         cTAaGboQZOavjEKngpsPJqVxngIpdxv+SM3BT9RGpHv6cPBmTPx37q5O6eW38U7C/7sv
         TcMw==
X-Gm-Message-State: AC+VfDwD/nt2dDmoL6lsrwAufELuzzSu2iVkwP6RjrWPgK0RcoKsOk4l
	+20yP883Lp0xsDh8nje2yFXzuhZIQYM=
X-Google-Smtp-Source: ACHHUZ4Z1wzHGWyaVRYwXTVwL7S8FOUs8NEVNHLD0vFj3dZl1O2BR9pEpSZ+UefJeV49vM93/Ok+nw==
X-Received: by 2002:a17:902:f544:b0:1a6:45e5:a26a with SMTP id h4-20020a170902f54400b001a645e5a26amr6482483plf.27.1683240280267;
        Thu, 04 May 2023 15:44:40 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:cce7])
        by smtp.gmail.com with ESMTPSA id ja3-20020a170902efc300b001a1a8e98e93sm23636plb.287.2023.05.04.15.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:44:39 -0700 (PDT)
Date: Thu, 4 May 2023 15:44:37 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 08/10] bpf: support precision propagation in the
 presence of subprogs
Message-ID: <20230504224437.zyhmazsyxnsuyxsd@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-9-andrii@kernel.org>
 <20230504194058.uhnyup7xang5mq5i@MacBook-Pro-6.local>
 <CAEf4Bzb9bjNXu4axm7C39i+6PBRibXuPMT0TOo30hBFt2WRYCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb9bjNXu4axm7C39i+6PBRibXuPMT0TOo30hBFt2WRYCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 03:19:08PM -0700, Andrii Nakryiko wrote:
> On Thu, May 4, 2023 at 12:41 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 25, 2023 at 04:49:09PM -0700, Andrii Nakryiko wrote:
> > >       if (insn->code == 0)
> > >               return 0;
> > > @@ -3424,14 +3449,72 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
> > >               if (class == BPF_STX)
> > >                       bt_set_reg(bt, sreg);
> > >       } else if (class == BPF_JMP || class == BPF_JMP32) {
> > > -             if (opcode == BPF_CALL) {
> > > -                     if (insn->src_reg == BPF_PSEUDO_CALL)
> > > -                             return -ENOTSUPP;
> > > -                     /* BPF helpers that invoke callback subprogs are
> > > -                      * equivalent to BPF_PSEUDO_CALL above
> > > +             if (bpf_pseudo_call(insn)) {
> > > +                     int subprog_insn_idx, subprog;
> > > +                     bool is_global;
> > > +
> > > +                     subprog_insn_idx = idx + insn->imm + 1;
> > > +                     subprog = find_subprog(env, subprog_insn_idx);
> > > +                     if (subprog < 0)
> > > +                             return -EFAULT;
> > > +                     is_global = subprog_is_global(env, subprog);
> > > +
> > > +                     if (is_global) {
> >
> > could you add a warn_on here that checks that jmp history doesn't have insns from subprog.
> 
> wouldn't this be very expensive to go over the entire jmp history to
> check that no jump point there overlaps with the global function? Or
> what do you have in mind specifically for this check?

recalling how jmp_history works and reading this comment when we process any call:
        /* when we exit from subprog, we need to record non-linear history */
        mark_jmp_point(env, t + 1);

so for static subprog the history will be:
call
  jmps inside subprog
insn after call.

for global it will be:
call
insn after call.

I was thinking that we can do simple check that call + 1 == subseq_idx for globals.
For statics that should never be the case.

We don't have to do it. Mostly checking my understanding of patches and jmp history.

> 
> >
> > > +                             /* r1-r5 are invalidated after subprog call,
> > > +                              * so for global func call it shouldn't be set
> > > +                              * anymore
> > > +                              */
> > > +                             if (bt_reg_mask(bt) & BPF_REGMASK_ARGS)
> > > +                                     return -EFAULT;
> >
> > This shouldn't be happening, but backtracking is delicate.
> > Could you add verbose("backtracking bug") here, so we know why the prog got rejected.
> > I'd probably do -ENOTSUPP, but EFAULT is ok too.
> 
> Will add verbose(). EFAULT because valid code should never use r1-r5
> after call. Invalid code should be rejected before that, and if not,
> then it is really a bug and best to bail out.
> 
> 
> >
> > > +                             /* global subprog always sets R0 */
> > > +                             bt_clear_reg(bt, BPF_REG_0);
> > > +                             return 0;
> > > +                     } else {
> > > +                             /* static subprog call instruction, which
> > > +                              * means that we are exiting current subprog,
> > > +                              * so only r1-r5 could be still requested as
> > > +                              * precise, r0 and r6-r10 or any stack slot in
> > > +                              * the current frame should be zero by now
> > > +                              */
> > > +                             if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS)
> > > +                                     return -EFAULT;
> >
> > same here.
> 
> ack
> 
> >
> > > +                             /* we don't track register spills perfectly,
> > > +                              * so fallback to force-precise instead of failing */
> > > +                             if (bt_stack_mask(bt) != 0)
> > > +                                     return -ENOTSUPP;
> > > +                             /* propagate r1-r5 to the caller */
> > > +                             for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
> > > +                                     if (bt_is_reg_set(bt, i)) {
> > > +                                             bt_clear_reg(bt, i);
> > > +                                             bt_set_frame_reg(bt, bt->frame - 1, i);
> > > +                                     }
> > > +                             }
> > > +                             if (bt_subprog_exit(bt))
> > > +                                     return -EFAULT;
> > > +                             return 0;
> > > +                     }
> > > +             } else if ((bpf_helper_call(insn) &&
> > > +                         is_callback_calling_function(insn->imm) &&
> > > +                         !is_async_callback_calling_function(insn->imm)) ||
> > > +                        (bpf_pseudo_kfunc_call(insn) && is_callback_calling_kfunc(insn->imm))) {
> > > +                     /* callback-calling helper or kfunc call, which means
> > > +                      * we are exiting from subprog, but unlike the subprog
> > > +                      * call handling above, we shouldn't propagate
> > > +                      * precision of r1-r5 (if any requested), as they are
> > > +                      * not actually arguments passed directly to callback
> > > +                      * subprogs
> > >                        */
> > > -                     if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
> > > +                     if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS)
> > > +                             return -EFAULT;
> > > +                     if (bt_stack_mask(bt) != 0)
> > >                               return -ENOTSUPP;
> > > +                     /* clear r1-r5 in callback subprog's mask */
> > > +                     for (i = BPF_REG_1; i <= BPF_REG_5; i++)
> > > +                             bt_clear_reg(bt, i);
> > > +                     if (bt_subprog_exit(bt))
> > > +                             return -EFAULT;
> > > +                     return 0;
> >
> > jmp history will include callback insn, right?
> > So skip of jmp history is missing here ?
> 
> This is, say, `call bpf_loop;` instruction. Which means we just got
> out of bpf_loop's callback's jump history (so already "skipped" them,
> except we didn't skip, we properly processed them). So there is
> nothing to skip anymore. We are in the parent program already.

Got it. Makes sense now.

