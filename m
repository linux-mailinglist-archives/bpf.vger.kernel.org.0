Return-Path: <bpf+bounces-26-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC1B6F7777
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4962280F25
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C3C121;
	Thu,  4 May 2023 20:52:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED071156F4
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 20:52:00 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05081359B
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 13:51:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-956ff2399b1so180129266b.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683233441; x=1685825441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw9lMVvxyrgvf/+3CalrDdujHZncHVdlceZjnADcpF0=;
        b=Pz3AohvgPpvvzWQxtdc9uqyAuqVkVXD4cwIr4jqAhG0NX6HCvWuCTLxqg2LL9ZWg/j
         ehn69ohVy/jKgy+m+dYIHbLykuDMKpnop6Lmm0huaSZqqROlyPPkZBJJQ8hijtGYiDoT
         ofGY8sKEUP15NwDNzCa0/bJuBcRh38oH9KZfBUu3xw6FH6mubQZlmM7CpaSZhmsgvtN0
         FjRUh3c4fk12TVP4Ygt7m4hxffre6FhP8KPVQGCzv2vpV7F7TMIG6IYCqon5kS/ivpHX
         2Fn9BzvXTNvdcJQDGFJHEVpy4Ra2jDTcrXYFLJojiczIsk+gBX0agwOV/HUUeSSdTW/k
         ST1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233441; x=1685825441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw9lMVvxyrgvf/+3CalrDdujHZncHVdlceZjnADcpF0=;
        b=BQPFbojt5Z7ssVtKB1eXkHiMex5mt4PeXroItTGXC+W7mNW4k5xxO/owDKUFh2cXOy
         C88OlE053nux3s4yZH6mG6GldkSokm839XPj+hSwBk4JZ703RXrRDGZ05+ac8f1HA6E3
         5r1fy1v6ZwzEzGg+p5aQ03K1qgeJ7vKH8lmEocvS3Y2wfKI/8d1TQXqOuR25MgPaIjtR
         rsnkBYaHpvlqNV/HX/0KHKBWOUo56ohWgY0zX+DiTYSSJQyHsP0UM4K+Z/wVVmDcwiJA
         ISohPwIxyiKf+0VRTkuvKCzgks5sd/F/91U3QBe8clkmSmgEtIsUNqQgSntv5zi9gR2M
         VlSw==
X-Gm-Message-State: AC+VfDxQ7uxeKtvxtbiXj6B9RN0EaDLLcTUK/DlASOB6HOqwbVwS6Do3
	UIGLbet5yRGKm4CxUbLGJWeiVdMOu+BBrjZeWUD6xH11
X-Google-Smtp-Source: ACHHUZ4D7M5eBPRjmDwOUVHoRrhhA7+j0xZ9awKRdqMCopWzsA4hEcJywyUcwTokQUyWKAH7pQBBLtbPuuy3DGEKlxg=
X-Received: by 2002:a17:907:a0c:b0:94e:cf98:32f2 with SMTP id
 bb12-20020a1709070a0c00b0094ecf9832f2mr114295ejc.33.1683233441224; Thu, 04
 May 2023 13:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-6-andrii@kernel.org>
 <20230504030730.expcb6z4w2l5buna@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230504030730.expcb6z4w2l5buna@dhcp-172-26-102-232.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 13:50:29 -0700
Message-ID: <CAEf4BzaUaniRdknKgCFODZCXOH=ADB7XyL=5Q4EoZD7KgRnuxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/10] bpf: maintain bitmasks across all active
 frames in __mark_chain_precision
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

On Wed, May 3, 2023 at 8:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 25, 2023 at 04:49:06PM -0700, Andrii Nakryiko wrote:
> > Teach __mark_chain_precision logic to maintain register/stack masks
> > across all active frames when going from child state to parent state.
> > Currently this should be mostly no-op, as precision backtracking usuall=
y
> > bails out when encountering subprog entry/exit.
> >
> > It's not very apparent from the diff due to increased indentation, but
> > the logic remains the same, except everything is done on specific `fr`
> > frame index. Calls to bt_clear_reg() and bt_clear_slot() are replaced
> > with frame-specific bt_clear_frame_reg() and bt_clear_frame_slot(),
> > where frame index is passed explicitly, instead of using current frame
> > number.
> >
> > We also adjust logging to emit affected frame number. And we also add
> > better logging of human-readable register and stack slot masks, similar
> > to previous patch.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c                         | 101 ++++++++++--------
> >  .../testing/selftests/bpf/verifier/precise.c  |  18 ++--
> >  2 files changed, 63 insertions(+), 56 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8faf9170acf0..0b19b3d9af65 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3703,7 +3703,7 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
> >       struct bpf_func_state *func;
> >       struct bpf_reg_state *reg;
> >       bool skip_first =3D true;
> > -     int i, err;
> > +     int i, fr, err;
> >
> >       if (!env->bpf_capable)
> >               return 0;
> > @@ -3812,56 +3812,63 @@ static int __mark_chain_precision(struct bpf_ve=
rifier_env *env, int frame, int r
> >               if (!st)
> >                       break;
> >
> > -             func =3D st->frame[frame];
> > -             bitmap_from_u64(mask, bt_reg_mask(bt));
> > -             for_each_set_bit(i, mask, 32) {
> > -                     reg =3D &func->regs[i];
> > -                     if (reg->type !=3D SCALAR_VALUE) {
> > -                             bt_clear_reg(bt, i);
> > -                             continue;
> > +             for (fr =3D bt->frame; fr >=3D 0; fr--) {
>
> I'm lost.
> 'frame' arg is now unused and the next patch passes -1 into it anyway?

Patch #3 has `bt_init(bt, frame);` which sets bt->frame =3D frame, so
since patch #3 we maintain a real frame number, it's just that the
rest of backtrack_insn() logic makes sure we never change frame (which
is why there should be no detectable change in behavior). Only in
patch #8 I add inter-frame bits propagation and generally changing
frame number with going into/out of subprog.

So it should be all good here.

> Probably this patch alone will break something and not bi-sectable?
>

I actually painstakingly compiled kernel and selftests after each
patch to make sure I'm not regressing anything (quite time consuming
effort, but necessary), so bisectability should be preserved.


> > +                     func =3D st->frame[fr];
> > +                     bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
> ..
> > diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/tes=
ting/selftests/bpf/verifier/precise.c
> > index fce831667b06..ac9be4c576d6 100644
> > --- a/tools/testing/selftests/bpf/verifier/precise.c
> > +++ b/tools/testing/selftests/bpf/verifier/precise.c
> > @@ -44,7 +44,7 @@
> >       mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 23\
> >       mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 22\
> >       mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 20\
> > -     parent didn't have regs=3D4 stack=3D0 marks:\
> > +     mark_precise: frame0: parent state regs(0x4)=3Dr2 stack(0x0)=3D:\
> >       mark_precise: frame0: last_idx 19 first_idx 10\
> >       mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 19\
> >       mark_precise: frame0: regs(0x200)=3Dr9 stack(0x0)=3D before 18\
> > @@ -55,7 +55,7 @@
> >       mark_precise: frame0: regs(0x200)=3Dr9 stack(0x0)=3D before 12\
> >       mark_precise: frame0: regs(0x200)=3Dr9 stack(0x0)=3D before 11\
> >       mark_precise: frame0: regs(0x200)=3Dr9 stack(0x0)=3D before 10\
> > -     parent already had regs=3D0 stack=3D0 marks:",
> > +     mark_precise: frame0: parent state regs(0x0)=3D stack(0x0)=3D:",
>
> The effect of the patch looks minor, so it might be correct, just super c=
onfusing.

It's intentional that there is no effect. It's a preparation for the
next patch where we do take advantage of having precision bits across
multiple frames. I didn't want to bundle these indentation shifting
changes with the logic changes.

