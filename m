Return-Path: <bpf+bounces-10424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C6B7A6FF6
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 03:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C31C2096F
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA8417CD;
	Wed, 20 Sep 2023 01:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2FA49
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 01:00:34 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03287AB
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 18:00:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so784039a12.1
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695171630; x=1695776430; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=09CY5SwSHF/SrDzdOna0vPyDHEJTcAh9i7QpJ77CmJE=;
        b=BZzaOSYaToToIkvrCcPZSOGCRG0gT1DHSJACovNbM03cCmCZIeaWHQwQDLj7Gk7qpQ
         Hsw+xM4cVpDvnyBNuIB/pQP+DFBkM3ianClD7APSxvRVx5f9dJCPr/6p4/7k504lvQGs
         lzmi1fjUls1TNvNAoyAd6IsurNcMGjF6YpEIAF3IEkndOhDZhJ+KcrNo1Sdum/xbAuS2
         TDuIj9/K5FfoPB/S+essuauCsUsOtm57RsJIA/VtZVnaJfy7oBIAmfiUXDvLZAVETwrL
         i3wUnbkBZCoQrDJCOjreciip/Q1NEd/PjVymaDPBrHugqpTZk6iycs/JXL2TRvPFfkQg
         Lbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695171630; x=1695776430;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09CY5SwSHF/SrDzdOna0vPyDHEJTcAh9i7QpJ77CmJE=;
        b=DX1WJrlw0M4J2Il7ktf9TgqNq9mlrX1XJPZigam4CajC/sz8uOE4K3F/HNMF2sOFrh
         EmCBAd5NnRcUf0Mc/gKlYb7hNWL2IPPwqwhfMK9O95EphY7fK+jCWebatPE7BaldARcX
         wR0WDdZKwGQpcRUFnLLX39YjHjCbOC7yPYmQst+0ekE1q8KwqA7qDIVbCjToHj/p/Ux5
         hMY8UWd7stDgNmhXQ3uegmTQ5abpyGkrb8exTQWzfY3j529PuMVI8uSz5gJDPzIxt8Cs
         Mi9afnKoq4rSMAxjv8bhoAU8l3EjhJhyFcW3SokNgLyn0SIlHvr7vDqSwgwXVtDJGxZP
         6GTQ==
X-Gm-Message-State: AOJu0YyxhtUDlYSEgr/ULcW9Hp/hDePGTWfcgWcuQsd+a/JX9NJUGXvM
	EXs72Ju+XDwP1dVy1lxref5kmqByeo//kQ==
X-Google-Smtp-Source: AGHT+IHx4K0FgFT9j9frcVMYybb2TEf2jC2KkotkPIf/njbsxTR7PwASxRV+Q/OtIcCrKWiz2Mz9bA==
X-Received: by 2002:a50:ed03:0:b0:52a:38c3:1b4b with SMTP id j3-20020a50ed03000000b0052a38c31b4bmr1649167eds.15.1695171630161;
        Tue, 19 Sep 2023 18:00:30 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a3-20020aa7cf03000000b0052e1959db1csm8083723edy.20.2023.09.19.18.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 18:00:29 -0700 (PDT)
Message-ID: <3c0703abeec622f9b7747c0385cc83752d578af3.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: unconditionally reset backtrack_state masks on
 global func exit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team
 <kernel-team@meta.com>, Chris Mason <clm@meta.com>
Date: Wed, 20 Sep 2023 04:00:28 +0300
In-Reply-To: <CAEf4BzYYm8enhZBw3QYxpPYGQEJTJ_0onDVAH4N8CvCsoxY+=A@mail.gmail.com>
References: <20230918210110.2241458-1-andrii@kernel.org>
	 <CAADnVQ+w4e2K06tPdV8J-TuEvY6ysGv_45PJZe2AkOpYFrx7Og@mail.gmail.com>
	 <CAEf4BzY9_0RCfXQdPL65W182jaQ3uHo7RUEkZ3JQaOfA5NXXMg@mail.gmail.com>
	 <CAEf4BzYYm8enhZBw3QYxpPYGQEJTJ_0onDVAH4N8CvCsoxY+=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-19 at 13:56 -0700, Andrii Nakryiko wrote:
> On Tue, Sep 19, 2023 at 11:59=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >=20
> > On Tue, Sep 19, 2023 at 2:06=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >=20
> > > On Mon, Sep 18, 2023 at 2:01=E2=80=AFPM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> > > >=20
> > > > In mark_chain_precision() logic, when we reach the entry to a globa=
l
> > > > func, it is expected that R1-R5 might be still requested to be mark=
ed
> > > > precise. This would correspond to some integer input arguments bein=
g
> > > > tracked as precise. This is all expected and handled as a special c=
ase.
> > > >=20
> > > > What's not expected is that we'll leave backtrack_state structure w=
ith
> > > > some register bits set. This is because for subsequent precision
> > > > propagations backtrack_state is reused without clearing masks, as a=
ll
> > > > code paths are carefully written in a way to leave empty backtrack_=
state
> > > > with zeroed out masks, for speed.
> > > >=20
> > > > The fix is trivial, we always clear register bit in the register ma=
sk, and
> > > > then, optionally, set reg->precise if register is SCALAR_VALUE type=
.
> > > >=20
> > > > Reported-by: Chris Mason <clm@meta.com>
> > > > Fixes: be2ef8161572 ("bpf: allow precision tracking for programs wi=
th subprogs")
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  kernel/bpf/verifier.c | 8 +++-----
> > > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index bb78212fa5b2..c0c7d137066a 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -4047,11 +4047,9 @@ static int __mark_chain_precision(struct bpf=
_verifier_env *env, int regno)
> > > >                                 bitmap_from_u64(mask, bt_reg_mask(b=
t));
> > > >                                 for_each_set_bit(i, mask, 32) {
> > > >                                         reg =3D &st->frame[0]->regs=
[i];
> > > > -                                       if (reg->type !=3D SCALAR_V=
ALUE) {
> > > > -                                               bt_clear_reg(bt, i)=
;
> > > > -                                               continue;
> > > > -                                       }
> > > > -                                       reg->precise =3D true;
> > > > +                                       bt_clear_reg(bt, i);
> > > > +                                       if (reg->type =3D=3D SCALAR=
_VALUE)
> > > > +                                               reg->precise =3D tr=
ue;
> > >=20
> > > Looks good, but is there a selftest that can demonstrate the issue?
> >=20
> > I'll see if I can write something small and reliable.
>=20
> I give up. It seems like lots of conditions have to come together to
> trigger this. In production it was an application that happened to
> finish global func validation with that r1 set as precise in
> backtrack_state, and then proceeded to have some equivalent state
> matched immediately, which triggered propagate_precision() ->
> mark_chain_precision_batch(), but doing propagation of r9. Then with
> this bug we were looking to propagate r1 and r9, but the code path
> under verification didn't have any instruction touching r1 until we
> bubbled back up to helper call instruction, where verifier complained
> about r1 being required to be precise right after helper call (which
> is illegal, as r1-r5 are clobbered).
>=20
> Few simple tests I tried failed to set up all the necessary conditions
> to trigger this in the exact sequence necessary. The fix is simple and
> well understood, I'd vote for landing it, given crafting a test is
> highly non-trivial.

I agree with this change and it does not cause any issues when tested local=
ly.
As far as I understand, to make a test case one needs to:
- make a special async callback that would leave some garbage "r1-r5"
  bits set in frame zero;
- trick verifier to check the async callback first and then jump to a
  state where precision marks on "r1-r5" are forbidden, e.g. a point
  right after pseudo call, so that backtrack_insn would jump to
  BPF_EXIT and complain.
Crafting such testcase sounds tricky and it might be fragile.

It appears to me that from time to time we get to situations when
having kunit tests would be beneficial =C2=AF\_(=E3=83=84)_/=C2=AF.

