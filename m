Return-Path: <bpf+bounces-1738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78256720A08
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D0E1C2122E
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF8A1E53E;
	Fri,  2 Jun 2023 19:51:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58C17759
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 19:51:20 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5A3194
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 12:51:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3bb395e69so3414001e87.2
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685735477; x=1688327477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6T4ZZm7vLsl8jjOfMAOmQzETFGKb2MZL7XM8cDVcyxI=;
        b=kRxpuD3L54KIg+izkbZx7dCDxX50Wvcqi2SdzMn3AYUE1l0eoSE6/APPzbQF6Fi+2+
         ybT6P0HxCNykC0U1vpu1TPfkcNf5fpNkErtyKj5Xxci4M63T5etMnM5KN4TvOADuTuVG
         /awCsLfKBYlH3MujjgW7MQXxEj/gheLcf+HxJWRzUmqQjLBhO8ZIlOkB68ofcDmIWis3
         Auf77WOE2YTnAjHydZA3WiQLdQxKq60IgTYQGxW8YVrzEQWbcWEESlbWcqwG9uCMaSEZ
         piai5vdTmUFzHaOYFynM0MXo5SLFVqXfpboby5dFngPn3xwoWU21TobmC8e7Tb5kk6m1
         ZThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685735477; x=1688327477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6T4ZZm7vLsl8jjOfMAOmQzETFGKb2MZL7XM8cDVcyxI=;
        b=BWng3l0poxm/bYnhAgDm75DTRlsoh/SCl8FFs69+qgio1O3eBNiV2JQuFFcB05olBw
         jO2aifGGPBBi+KhY9Mi8r8m76m5h+r6UzfsExsLQk4llva6nNBQ0M8QwB7cL7D9/ubeJ
         +7u2PlsoAH/oxrJOLpO+hUsIjQaEayAHdab6F8EVzSYISqXL7c0wBD7IChGm7JMrMcy0
         iXCI+rLecPgdLTpUVKwUT+wHLQiV2wSQOCquhhp0Lj+Sud9/unjReJDZu0SRRQW2mhfW
         hML7AdkFGEiZg64hZgWRomh/LWjc1too4otxP51+cigO/xUXiRq/gYfHnMIMFu9mhuFs
         KNtA==
X-Gm-Message-State: AC+VfDyKHRRcRNGNRJEPChO4jjVAbiLE4ncCy3trAdSG0kR4cUBSJAEJ
	0dv+aPpNpxh7zTMPJ0omcQ1TkyqRDYP48A==
X-Google-Smtp-Source: ACHHUZ7uCkSPsmTd9Lq6VpAA1yyzL/AoT6Ejn73JjWe9MoO32QWvotUXzwS4E/ost9NdPfvRWqQmIQ==
X-Received: by 2002:a05:651c:103a:b0:2aa:cb6c:d0dc with SMTP id w26-20020a05651c103a00b002aacb6cd0dcmr653453ljm.29.1685735476870;
        Fri, 02 Jun 2023 12:51:16 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o24-20020a2e7318000000b002b170f9bf06sm327439ljc.136.2023.06.02.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 12:51:16 -0700 (PDT)
Message-ID: <f574c204781a139a6ef448dfd3d22935eba81ce0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song
 <yhs@fb.com>
Date: Fri, 02 Jun 2023 22:51:15 +0300
In-Reply-To: <CAADnVQ+eQ2hVnspsor0nNCR-bN68BtFCZ6Q=Qf-+_ow=Z6bJHA@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
	 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local>
	 <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
	 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
	 <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
	 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
	 <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
	 <CAADnVQ+crhOPcnmC-N+CNbQ6PGdG6KKE+s5P1TEq_2KxL14iSw@mail.gmail.com>
	 <e5f82ece5f54067bf6c0514fdeb095f03636dd99.camel@gmail.com>
	 <CAADnVQ+eQ2hVnspsor0nNCR-bN68BtFCZ6Q=Qf-+_ow=Z6bJHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-06-02 at 12:43 -0700, Alexei Starovoitov wrote:
> On Fri, Jun 2, 2023 at 12:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> > > > - do a check as follows:
> > > >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> > >=20
> > > Ignoring rcur->id > 0 ? Is it safe?
> >=20
> > Well, I thought about it a bit and arrived to the following reasoning:
> > - suppose checkpoint C exists, is proven safe and has
> >   registers r6=3DPscalar(range1),id=3D0 and r7=3DPscalar(range2),id=3D0
> > - this means that C is proven safe for any value of
> >   r6 in range1 and any value of r7 in range2
> > - having same id on r6 and r7 means that r6 and r7 share same value
> > - so this is just a special case of what's already proven.
> >=20
> > But having written this down, it looks like I also need to verify
> > that range1 and range2 overlap :(
>=20
> I'm lost.
> id=3D=3D0 means there is no relationship between regs.
> with
> if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
>=20
> and r6_old->precise
> we will only do range_within(rold, rcur) && tnum_in() check
> and will ignore r6_cur->id and its relationship with some other reg in cu=
r.
> It could be ok.

Yes, but I just realized that for the following case:

  Old                      Cur
  r6=3DPscalar(range1),id=3D0  r6=3DPscalar(range1),id=3D1
  r7=3DPscalar(range2),id=3D0  r7=3DPscalar(range2),id=3D1

For 'Cur' to be a subset of 'Old' ranges range1 and range2
have to have non-empty overlap, so my new check:

  if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))

is not fully correct.

It was a "clever" attempt to ignore solo scalar IDs in Cur without modifyin=
g Cur.
I'll think a bit more, sorry for a lot of noise.

