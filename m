Return-Path: <bpf+bounces-1739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED536720A1F
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81DB281A79
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC61F163;
	Fri,  2 Jun 2023 20:03:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A61E53C
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 20:03:53 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB8E1A2
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:03:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so4656567e87.1
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685736230; x=1688328230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRUo+eTeERg3zwEOD4Zvne31Ow9Q051HIi8CtLXJ+dU=;
        b=CPwqTXS+dRArMzwJ8NAK5ukv9IwoQGCj7BJbhb3xz8BGRESWdWrRNr1m3jZZgUvmuD
         GtqeTM9qYFeEbQvROQybF1t5H84btGj5oNSJPwyvQHcGXWYCUgJLVOh8g6esnwrZnNWl
         b99XsUCMXX9UpHrJOzoqFDF2QvgKSXaTvfN2sdKaOjsZm+4Bq7B2kxnYklbuNhFmCOi5
         axD3m/vlARW4wT0RS8UKFUpQvlQHNYy5brIZdd9esTK4crZAsRad1btf8S/LKrQuSJUn
         46geTPJ223dpFpj63kvOmGIg5XJ6nN1K2N98qVE/UXZANMu/zjJmNxaordVrCfVeCR7q
         V4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685736230; x=1688328230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRUo+eTeERg3zwEOD4Zvne31Ow9Q051HIi8CtLXJ+dU=;
        b=AVnnDZcL0s/PLF+3ikolG9Wq6cPuwVebU+MROkP8qijFdLuVGsIVYRm4N8bJmo/EHa
         e1Ofdixk9wPDP7OiOQBj6ziCRUhEh4VwQzL9WlAcNjxWWqOVY5e3TotWBfUnhRjO9Jb8
         G6kK9uB3ONNfgwCkiUH4Gr6fMI4arDQJrLOXJrTJ/i2ZSeuVA5GRlIlDL4XzSPcla5dr
         HJopTUwJV93+fm0MleGE4y6O0ywNbJOQ4XdU/wPVgNVVozsykJtctC82vmuizfxYHuvs
         ZYUopmN0koMzPLY8lMsKlCt5/hdAqdex5jjEhL4wE4T9m/AEUM1ihDY9jONen12cCi/E
         62VA==
X-Gm-Message-State: AC+VfDxl+hprf4l1p4rUUiTiQ2kHMGOqqQh8nPNkw/c6zjRdknbYZXOp
	PozVRNk5wcs7wUQy0snT9PtNZ0oMC7fYd6APZ5w=
X-Google-Smtp-Source: ACHHUZ7OS4aTM9FO8sJ5/AaOIoSPbGnDAiy+6PALUCeRDXCGnOZDQoNkHsbrgKlYBmSjlJCzzEXiuRblncsSaijO92g=
X-Received: by 2002:a2e:9d45:0:b0:2b0:8632:238d with SMTP id
 y5-20020a2e9d45000000b002b08632238dmr176596ljj.15.1685736229769; Fri, 02 Jun
 2023 13:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local> <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
 <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
 <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
 <CAADnVQ+crhOPcnmC-N+CNbQ6PGdG6KKE+s5P1TEq_2KxL14iSw@mail.gmail.com>
 <e5f82ece5f54067bf6c0514fdeb095f03636dd99.camel@gmail.com>
 <CAADnVQ+eQ2hVnspsor0nNCR-bN68BtFCZ6Q=Qf-+_ow=Z6bJHA@mail.gmail.com> <f574c204781a139a6ef448dfd3d22935eba81ce0.camel@gmail.com>
In-Reply-To: <f574c204781a139a6ef448dfd3d22935eba81ce0.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jun 2023 13:03:38 -0700
Message-ID: <CAADnVQLtPzDiPxTXk=s9NC4bO-wrDe7+F=3oEcWkLtbGr+p_yA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 12:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-06-02 at 12:43 -0700, Alexei Starovoitov wrote:
> > On Fri, Jun 2, 2023 at 12:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > > > > - do a check as follows:
> > > > >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> > > >
> > > > Ignoring rcur->id > 0 ? Is it safe?
> > >
> > > Well, I thought about it a bit and arrived to the following reasoning=
:
> > > - suppose checkpoint C exists, is proven safe and has
> > >   registers r6=3DPscalar(range1),id=3D0 and r7=3DPscalar(range2),id=
=3D0
> > > - this means that C is proven safe for any value of
> > >   r6 in range1 and any value of r7 in range2
> > > - having same id on r6 and r7 means that r6 and r7 share same value
> > > - so this is just a special case of what's already proven.
> > >
> > > But having written this down, it looks like I also need to verify
> > > that range1 and range2 overlap :(
> >
> > I'm lost.
> > id=3D=3D0 means there is no relationship between regs.
> > with
> > if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> >
> > and r6_old->precise
> > we will only do range_within(rold, rcur) && tnum_in() check
> > and will ignore r6_cur->id and its relationship with some other reg in =
cur.
> > It could be ok.
>
> Yes, but I just realized that for the following case:
>
>   Old                      Cur
>   r6=3DPscalar(range1),id=3D0  r6=3DPscalar(range1),id=3D1
>   r7=3DPscalar(range2),id=3D0  r7=3DPscalar(range2),id=3D1
>
> For 'Cur' to be a subset of 'Old' ranges range1 and range2
> have to have non-empty overlap, so my new check:

In theory. yes. and most likely that _was_ the case for 'old',
but 'cur' doesn't need to do that check.
'old' was successful already and 'cur' ranges just need to be within.

so

>   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
>
> is not fully correct.

still looks correct.

>
> It was a "clever" attempt to ignore solo scalar IDs in Cur without modify=
ing Cur.
> I'll think a bit more, sorry for a lot of noise.

