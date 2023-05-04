Return-Path: <bpf+bounces-48-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40F6F7959
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782551C210C6
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B3CC158;
	Thu,  4 May 2023 22:48:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAAA156FB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:48:50 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128D59DB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:48:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so70650a12.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240527; x=1685832527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS27JP5nFste8cV/VrcVBfl9EOGzzSlhcugHkIcXHg4=;
        b=o8IShQYlDmw6nB0vym/WD89I/xXlnvt5CBSJR0xG32pksfSTwVgWE9Ds9Qf5+0SGo2
         W/E3u+xxw9xWaRyKq6BkazhaqJ24spM8W6HqwqhZLLBrvwSbswrSpx0b4r3670gFUmLW
         NVJL2pG1C7d+ZOLz5852xyDuHrTEFCznmb2MAmsBxJ5kvKPSqU5DvN7+bJZIdRKZ5bhO
         qYizW3Kd2qx629vJrSxofLh4ZcLmMfu3WZ3rZAitNK0PAs4BOV1/lBYEhbBi/U6jnt5J
         T8g7aTUWlccnyOeMeONWlmXw1z4FELN2+89FQFpXMBsH/KH9+EjxZgUp6i6BrRFfcRaH
         t5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240527; x=1685832527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS27JP5nFste8cV/VrcVBfl9EOGzzSlhcugHkIcXHg4=;
        b=aDpKvkg2i7JCJ6cQYcGL17hZX++MBxqsUQA89yS2644d2FZxm4APjqmEUP5u0wljIS
         3QvgWVPE6ZxahljvjUggPOHDNVQ6gLEu5oAb0eaQYZLxOgqs7Yl7VudqbHTAZA7LQXVm
         aGibLUf3tg0Vj6cOuw+bfiSXZDpJYBzqBTCMXzhkNHdf71w4WY+91PXtqfPcuyWoCwZC
         af1UYQEXpQDOeI6Vt5PJ6A6CUXN54iIdBlRl02EEQWLIQGSm28HagUNTb9Ur1iyH8JPj
         MuijN/j0IAA8Oq/TRm8xLNM5tPDmq9B2k9zUv5pL7Lpbiwqqz9Rhcv0JtstNU4VV1DPW
         48fg==
X-Gm-Message-State: AC+VfDzFxleDEZPk8weupVmJ34Hsb+NV1r8h213MIhLeJhIRoa06kvp4
	Jlgd3QUfC2wZEd7QIUqUpK7Becg9qRJt2MiON20=
X-Google-Smtp-Source: ACHHUZ6LJXoQtkm3eFKMpli2fkJqj5K/vmubxyC4jbxEul7LkSju3OEDyWrphTJOi8/eB2vsJl1V3Q2L5wsess+e5SI=
X-Received: by 2002:a17:907:97c6:b0:965:bb14:f964 with SMTP id
 js6-20020a17090797c600b00965bb14f964mr470889ejc.15.1683240526823; Thu, 04 May
 2023 15:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-9-andrii@kernel.org>
 <20230504194058.uhnyup7xang5mq5i@MacBook-Pro-6.local> <CAEf4Bzb9bjNXu4axm7C39i+6PBRibXuPMT0TOo30hBFt2WRYCQ@mail.gmail.com>
 <20230504224437.zyhmazsyxnsuyxsd@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230504224437.zyhmazsyxnsuyxsd@dhcp-172-26-102-232.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 15:48:34 -0700
Message-ID: <CAEf4Bzb83m9Nq9L=HQc57bvzoQE02dXABdxEO3GhR1HjS+i89Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/10] bpf: support precision propagation in the
 presence of subprogs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 3:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 04, 2023 at 03:19:08PM -0700, Andrii Nakryiko wrote:
> > On Thu, May 4, 2023 at 12:41=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Apr 25, 2023 at 04:49:09PM -0700, Andrii Nakryiko wrote:
> > > >       if (insn->code =3D=3D 0)
> > > >               return 0;
> > > > @@ -3424,14 +3449,72 @@ static int backtrack_insn(struct bpf_verifi=
er_env *env, int idx,
> > > >               if (class =3D=3D BPF_STX)
> > > >                       bt_set_reg(bt, sreg);
> > > >       } else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
> > > > -             if (opcode =3D=3D BPF_CALL) {
> > > > -                     if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> > > > -                             return -ENOTSUPP;
> > > > -                     /* BPF helpers that invoke callback subprogs =
are
> > > > -                      * equivalent to BPF_PSEUDO_CALL above
> > > > +             if (bpf_pseudo_call(insn)) {
> > > > +                     int subprog_insn_idx, subprog;
> > > > +                     bool is_global;
> > > > +
> > > > +                     subprog_insn_idx =3D idx + insn->imm + 1;
> > > > +                     subprog =3D find_subprog(env, subprog_insn_id=
x);
> > > > +                     if (subprog < 0)
> > > > +                             return -EFAULT;
> > > > +                     is_global =3D subprog_is_global(env, subprog)=
;
> > > > +
> > > > +                     if (is_global) {
> > >
> > > could you add a warn_on here that checks that jmp history doesn't hav=
e insns from subprog.
> >
> > wouldn't this be very expensive to go over the entire jmp history to
> > check that no jump point there overlaps with the global function? Or
> > what do you have in mind specifically for this check?
>
> recalling how jmp_history works and reading this comment when we process =
any call:
>         /* when we exit from subprog, we need to record non-linear histor=
y */
>         mark_jmp_point(env, t + 1);
>
> so for static subprog the history will be:
> call
>   jmps inside subprog
> insn after call.
>
> for global it will be:
> call
> insn after call.
>
> I was thinking that we can do simple check that call + 1 =3D=3D subseq_id=
x for globals.
> For statics that should never be the case.

Got it. Yes, I think you are right, and it's simple to check and
enforce. Will add.

>
> We don't have to do it. Mostly checking my understanding of patches and j=
mp history.
>
> >
> > >
> > > > +                             /* r1-r5 are invalidated after subpro=
g call,
> > > > +                              * so for global func call it shouldn=
't be set
> > > > +                              * anymore
> > > > +                              */
> > > > +                             if (bt_reg_mask(bt) & BPF_REGMASK_ARG=
S)
> > > > +                                     return -EFAULT;
> > >
> > > This shouldn't be happening, but backtracking is delicate.
> > > Could you add verbose("backtracking bug") here, so we know why the pr=
og got rejected.
> > > I'd probably do -ENOTSUPP, but EFAULT is ok too.
> >
> > Will add verbose(). EFAULT because valid code should never use r1-r5
> > after call. Invalid code should be rejected before that, and if not,
> > then it is really a bug and best to bail out.
> >
> >
> > >
> > > > +                             /* global subprog always sets R0 */
> > > > +                             bt_clear_reg(bt, BPF_REG_0);
> > > > +                             return 0;
> > > > +                     } else {
> > > > +                             /* static subprog call instruction, w=
hich
> > > > +                              * means that we are exiting current =
subprog,
> > > > +                              * so only r1-r5 could be still reque=
sted as
> > > > +                              * precise, r0 and r6-r10 or any stac=
k slot in
> > > > +                              * the current frame should be zero b=
y now
> > > > +                              */
> > > > +                             if (bt_reg_mask(bt) & ~BPF_REGMASK_AR=
GS)
> > > > +                                     return -EFAULT;
> > >
> > > same here.
> >
> > ack
> >
> > >
> > > > +                             /* we don't track register spills per=
fectly,
> > > > +                              * so fallback to force-precise inste=
ad of failing */
> > > > +                             if (bt_stack_mask(bt) !=3D 0)
> > > > +                                     return -ENOTSUPP;
> > > > +                             /* propagate r1-r5 to the caller */
> > > > +                             for (i =3D BPF_REG_1; i <=3D BPF_REG_=
5; i++) {
> > > > +                                     if (bt_is_reg_set(bt, i)) {
> > > > +                                             bt_clear_reg(bt, i);
> > > > +                                             bt_set_frame_reg(bt, =
bt->frame - 1, i);
> > > > +                                     }
> > > > +                             }
> > > > +                             if (bt_subprog_exit(bt))
> > > > +                                     return -EFAULT;
> > > > +                             return 0;
> > > > +                     }
> > > > +             } else if ((bpf_helper_call(insn) &&
> > > > +                         is_callback_calling_function(insn->imm) &=
&
> > > > +                         !is_async_callback_calling_function(insn-=
>imm)) ||
> > > > +                        (bpf_pseudo_kfunc_call(insn) && is_callbac=
k_calling_kfunc(insn->imm))) {
> > > > +                     /* callback-calling helper or kfunc call, whi=
ch means
> > > > +                      * we are exiting from subprog, but unlike th=
e subprog
> > > > +                      * call handling above, we shouldn't propagat=
e
> > > > +                      * precision of r1-r5 (if any requested), as =
they are
> > > > +                      * not actually arguments passed directly to =
callback
> > > > +                      * subprogs
> > > >                        */
> > > > -                     if (insn->src_reg =3D=3D 0 && is_callback_cal=
ling_function(insn->imm))
> > > > +                     if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS)
> > > > +                             return -EFAULT;
> > > > +                     if (bt_stack_mask(bt) !=3D 0)
> > > >                               return -ENOTSUPP;
> > > > +                     /* clear r1-r5 in callback subprog's mask */
> > > > +                     for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
> > > > +                             bt_clear_reg(bt, i);
> > > > +                     if (bt_subprog_exit(bt))
> > > > +                             return -EFAULT;
> > > > +                     return 0;
> > >
> > > jmp history will include callback insn, right?
> > > So skip of jmp history is missing here ?
> >
> > This is, say, `call bpf_loop;` instruction. Which means we just got
> > out of bpf_loop's callback's jump history (so already "skipped" them,
> > except we didn't skip, we properly processed them). So there is
> > nothing to skip anymore. We are in the parent program already.
>
> Got it. Makes sense now.

