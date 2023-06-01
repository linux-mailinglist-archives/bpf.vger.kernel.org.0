Return-Path: <bpf+bounces-1599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2EE71EF3E
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08291C21092
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988319BB4;
	Thu,  1 Jun 2023 16:40:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3613AC3
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:40:26 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B955BE40
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 09:39:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af278ca45eso14977241fa.1
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685637595; x=1688229595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C74qpQ5TxQyWXlRaZMu4bIpAUcZDhoUA9OOfWkjtjDY=;
        b=HHj3UhHgNpunKwLxWyoCYfyGNGWMyA3Zv/NgaQdmddWzYUYLtf1hsoBFX1l+tTMn7c
         a7h+7F002Qqen8pGupn7CcRiMFI50agkQqT6ESR/un2BIWkQvS9r0l2WvDOqZHh2TonY
         UD+CdfQmskVkdxwqiAlN0UtGTtn2G/+7rhluOuKtege6117xksgSjh5JcXTJN27wE/rG
         7U0EQdKlQNS6ovfSKJVMLLalPJqyvbFayfUe3VTIgZpY7jEdR0rLA8YWBm8MhyxlpOvi
         9y17CA/X29+IH/65OY9VO/iBXNLlzTQv9+GAoG7CHc0t8uVYZvpDtChHgnhs2Q8d5gEy
         tMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637595; x=1688229595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C74qpQ5TxQyWXlRaZMu4bIpAUcZDhoUA9OOfWkjtjDY=;
        b=TNoh33DX3/rbqSCJ5UK2Qu4wtuwM7260KVU6GoEbpeMS4lnwOTHqLktU3NH2tp4+EJ
         5A98NoqanmO/e/KgvaAda8aSeuzZ2ExBOuMbqRGW40pZLNgEoCTa5YmQ2SLlSvPmaK2Z
         4CSjX8E+3vcG9BS2fGDpUI138NN0ih963Oltelyx8dRPQTaiW4N6W4WqHMESxDW8INH7
         IitxE89f/yNnyoHb6yRwYo5HymzIrSi7bmJ2SUnEs9CJMR7FxJyg9XRvaBPLptgYTNNr
         3uSLGWGM71LwDxnHzfLwdhJxDi6are8+eLvEcxjfi1+Froc4Q39Scn5yoV5ktoy9UqSn
         Ejfw==
X-Gm-Message-State: AC+VfDx94RynNOEGtbpuCl5Jf3OA/UC42qfcmpAOv5mtrwm3wRE5yKYR
	/P12jITwUoNjQ4fYoG9xgzNc1Yz9InBFZHC6JyI=
X-Google-Smtp-Source: ACHHUZ7TVbGFi8ykxzq2jHmRHo/7ttJ5wQKn9Tc+el+aKumo74gHWTu+NQMt8QVGyftIOc+nir/zFXXSHiUWF4XhBso=
X-Received: by 2002:a2e:808f:0:b0:2ae:cf05:5bae with SMTP id
 i15-20020a2e808f000000b002aecf055baemr22130ljg.3.1685637594359; Thu, 01 Jun
 2023 09:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531110511.64612-1-aspsk@isovalent.com> <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local> <ZHhJUN7kQuScZW2e@zh-lab-node-5>
In-Reply-To: <ZHhJUN7kQuScZW2e@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Jun 2023 09:39:43 -0700
Message-ID: <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf <bpf@vger.kernel.org>, Joe Stringer <joe@isovalent.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 1, 2023 at 12:30=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On Wed, May 31, 2023 at 11:24:29AM -0700, Alexei Starovoitov wrote:
> > On Wed, May 31, 2023 at 11:05:10AM +0000, Anton Protopopov wrote:
> > >  static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *=
l)
> > >  {
> > >     htab_put_fd_value(htab, l);
> > >
> > > +   dec_elem_count(htab);
> > > +
> > >     if (htab_is_prealloc(htab)) {
> > >             check_and_free_fields(htab, l);
> > >             __pcpu_freelist_push(&htab->freelist, &l->fnode);
> > >     } else {
> > > -           dec_elem_count(htab);
> > >             htab_elem_free(htab, l);
> > >     }
> > >  }
> > > @@ -1006,6 +1024,7 @@ static struct htab_elem *alloc_htab_elem(struct=
 bpf_htab *htab, void *key,
> > >                     if (!l)
> > >                             return ERR_PTR(-E2BIG);
> > >                     l_new =3D container_of(l, struct htab_elem, fnode=
);
> > > +                   inc_elem_count(htab);
> >
> > The current use_percpu_counter heuristic is far from perfect. It works =
for some cases,
> > but will surely get bad as the comment next to PERCPU_COUNTER_BATCH is =
trying to say.
> > Hence, there is a big performance risk doing inc/dec everywhere.
> > Hence, this is a nack: we cannot decrease performance of various maps f=
or few folks
> > who want to see map stats.
>
> This patch adds some inc/dec only for preallocated hashtabs and doesn't c=
hange
> code for BPF_F_NO_PREALLOC (they already do incs/decs where needed). And =
for
> preallocated hashtabs we don't need to compare counters,

exactly. that's why I don't like to add inc/dec that serves no purpose
other than stats.

> so a raw (non-batch)
> percpu counter may be used for this case.

and you can do it inside your own bpf prog.

> > If you want to see "pressure", please switch cilium to use bpf_mem_allo=
c htab and
> > use tracing style direct 'struct bpf_htab' access like progs/map_ptr_ke=
rn.c is demonstrating.
> > No kernel patches needed.
> > Then bpf_prog_run such tracing prog and read all internal map info.
> > It's less convenient that exposing things in uapi, but not being uapi i=
s the point.
>
> Thanks for the pointers, this makes sense. However, this doesn't work for=
 LRU
> which is always pre-allocated. Would it be ok if we add non-batch percpu
> counter for !BPF_F_NO_PREALLOC case and won't expose it directly to users=
pace?

LRU logic doesn't kick in until the map is full.
If your LRU map is not full you shouldn't be using LRU in the first place.

