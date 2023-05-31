Return-Path: <bpf+bounces-1537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFB3718ADB
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC5D2815AF
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04D3C0A6;
	Wed, 31 May 2023 20:13:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264D19E61
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:13:12 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACBF126
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:13:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so250888a12.1
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685563990; x=1688155990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XcQCXp9J1JUCRspYUylWDsmfxHe5mo7OmyRXBdTins=;
        b=fu5YxftJ6/t6Qcors3PletwjM5r4tEeS9QxQpzAr542Lj4Lm6gK3s5sPlCN4MlWusf
         gRNxhKH8HqVz5BuxwiO2lRppYXChs70K25fPKkyQEqJjFpz9IeaNuAVjB0V4j6sVM5+T
         Qn8LqG4JOyNHeTXtxep7UXzh4WNJTdjGpaePcOrVYwvMY2FV9hwWH0MBNbvLbTgZH6qP
         WKlI6l7U+on6jEWR3abLb+UPYREu/EiUyn5NeNGB8CfSYYrfeII/IbfBsptWVnKKeDG0
         uaoOf+3h+ocsLBu9hDl2qpgwzGWgm9Dadjb1oVE5r05W4sG8HwQpexZA00hC/C9M/Nz0
         YxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685563990; x=1688155990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XcQCXp9J1JUCRspYUylWDsmfxHe5mo7OmyRXBdTins=;
        b=PQazDYG/rWJsY70XoiJ/bcLl1k7/e8hayITMcIR4VY75RetMyaryXClfiaaZvVVJ+b
         SjGJZ3z6/BphxTfI+HZEboiM3nJcnHyssuF1R4zBNIpxZXYecc4Z4yUmrptl/DF8IFeg
         uGsRyVN2J0FgYtjLL7x4+ktomih/i8wDuZ2KhjMJtCPx6PBwzI4egI00ozb2R7q4TbSh
         GJEezdFDWRixU1lXdOAKoHQ3owxv+JhRlQXR32z/JxRx8sDzWvoSCBdugmkzOUHjGNCH
         ZWB+4ImFoCRc9kgLnfltuWyOODXvwTbNM8xpv7HMnPCfbKPxcGecTAjuks0bKctikrUA
         4Kaw==
X-Gm-Message-State: AC+VfDx+IIY8KbSt3UoZOVyVa8njFyrl5B06dXuJH+CP+sT7cWu1CBUi
	7G0DShFpZmTv+L3+xM0sHoNAa3YMw91wLvnE5Z4=
X-Google-Smtp-Source: ACHHUZ5XZbCGEyI/lJvf2keXWuugAJGCLa/TaHGoOYyrCfYelvPowG2gvicNaCgqf7oNb41ahUQkKOtqQ4FkYE9lIO0=
X-Received: by 2002:a05:6402:3446:b0:514:9d3f:7a60 with SMTP id
 l6-20020a056402344600b005149d3f7a60mr4368769edc.14.1685563989541; Wed, 31 May
 2023 13:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
 <f2abf39bcd4de841a89bb248de9e242a880aaa93.camel@gmail.com>
 <CAEf4BzYjvjbm9g1N9Z04kXV1N3+KH+dZ_sq_0NWuhyuJ+A18UQ@mail.gmail.com> <a13ee48ac037d0dbb6796c7ea5965140ec7ef726.camel@gmail.com>
In-Reply-To: <a13ee48ac037d0dbb6796c7ea5965140ec7ef726.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 May 2023 13:12:57 -0700
Message-ID: <CAEf4BzYE_7m3FNc6dtZeKb6tNbW4xkhz6SVdV6KetD5reSer6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
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

On Wed, May 31, 2023 at 12:30=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2023-05-31 at 11:29 -0700, Andrii Nakryiko wrote:
> > On Wed, May 31, 2023 at 10:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Tue, 2023-05-30 at 14:37 -0700, Andrii Nakryiko wrote:
> > > [...]
> > > > Also, it might make sense to drop SCALAR register IDs as soon as we
> > > > have only one instance of it left (e.g., if "paired" register was
> > > > overwritten already). I.e., aggressively drop IDs when they become
> > > > useless. WDYT?
> > >
> > > I added modification which resets sole scalar IDs to zero before
> > > states comparison, it shows some speedup but is still slow:
> > >
> > >   Filter        | Number of programs | Number of programs
> > >                 | patch #1           | patch #1 + sole scalar ID prun=
ing
> > >   -------------------------------------------------------------------=
---
> > >   states_pct>10 | 40                 | 40
> > >   states_pct>20 | 20                 | 19
> > >   states_pct>30 | 15                 | 13
> > >   states_pct>40 | 11                 | 8
> > >
> > > (Out of 177 programs).
> > >
> > > I'll modify mark_chain_precision() to propagate precision marks for
> > > find_equal_scalars(), so that it could be compared to current patch #=
3
> > > in terms of code complexity and verification performance.
> > >
> > > If you have any thoughts regarding my previous email, please share.
> > >
> >
> > Yep, I do. Given SCALAR registers with the same ID are meant to "share
> > the destiny", shouldn't it be required that when we mark r6 as precise
> > we should automatically mark linked r7 as precise at the same point.
> > So in your example:
> >
> > 7: r9 +=3D r6
> >
> > should be where we request both r6 and r7 (and whatever other register
> > has the same ID) to be marked as precise. It should be very easy to
> > implement, especially given my recent refactoring with
> > mark_chain_precision_batch.
>
> Ok, I'll modify the `struct backtrack_state` as follows:
>
>   struct backtrack_state {
>         struct bpf_verifier_env *env;
>         u32 frame;
>         u32 reg_masks[MAX_CALL_FRAMES];
> +       u32 reg_ids[MAX_CALL_FRAMES];
>         u64 stack_masks[MAX_CALL_FRAMES];
> +       u64 stack_ids[MAX_CALL_FRAMES];
>   };
>
> And add corresponding logic to backtrack_insn().

I don't see why you need to change anything about backtrack_state at
all, so we are not on the same page.

What I propose is that in mark_chain_precision(), when given regno, go
over all *current* registers with the same ID, and set all of them as
"to be marked precise". And then call mark_chain_precision_batch().
See propagate_precision() for how we do similar stuff for bulk
precision propagation.

backtrack_state shouldn't need to know about IDs, unless I'm missing someth=
ing

>
> > The question I have (and again, haven't spent any time thinking about
> > any other corner cases, sorry) is whether that alone would be a proper
> > fix?
>
> As far as I understand, in terms of correctness it would be a proper fix.
> In terms of performance, I hope that it would be enough but we will see.

ok, let's try that then, before we commit to u32_hashset stuff

>
> > As for this u32_hashset, it just feels like a big overkill, tbh. If we
> > have to do something like that, wouldn't it be better to, say, set
> > highest bit in reg->id (for all linked registers, of course) to mark
> > it as "used for range checks" instead of maintaining a separate check?
>
> Unfortunately no, because this ID change would have to be propagated
> backwards. It was the first implementation I tried.
>
> > But just the whole idea of keeping track of some special circumstances
> > under which IDs are meaningful seems wrong... All this logic is
> > complicated, now we are adding another layer of complexity on top. And
> > the complexity is not in the code, it's in thinking about all possible
> > scenarios and their interactions.
>
> I agree that adding more layers is a complication in itself.
> Thank you for your input.
>
> > > [...]
>

