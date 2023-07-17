Return-Path: <bpf+bounces-5129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17951756AA5
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C853F281116
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0295BA3A;
	Mon, 17 Jul 2023 17:32:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E41FD7
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 17:32:46 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C417BBD
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:32:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so70739501fa.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689615140; x=1692207140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upR4wRh4Hg74cuc5P0Y7t9kgJBoN9yKIt3UsfUP1DC4=;
        b=mm7EjFtNAtInoNGT11it/+V1nNrDXP5u6x4MIWAPXtyA8yifVQX1iB1bGFII9kWXde
         2C0Lonw+5oKs5l7qDvByTvJCzAODAoOxQLYI91utmMISg4jC3LqRi1jMXnalLZem00ei
         76IZaevVrLPE7hliXJ5+R/r6EcALmKOQ9XSwTm1R9IZo+DsEM5hgiDbKrxipegdeFB/o
         k76bmJJrlZkxi52l4LfQvI1NRhtfqqwUGSPKC93RB9t/JC1AbgFTBtWvlvleT+NSnRAN
         XpGTB567xXgi4kMQrqXlzzgw6Y+SCXVpRZNq5wPanhd5V/S2k4sZuntlWpcQz2qmfSF7
         FYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689615140; x=1692207140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upR4wRh4Hg74cuc5P0Y7t9kgJBoN9yKIt3UsfUP1DC4=;
        b=b9Lsa3AWeFdiVTtgZBo3VS6kYmZnU9Pe55ZbBLUlJXjTirCR1vwbYXMGNzEz7xX/Q+
         qrbs88F+1Q0S+C2uBDEFIu7akY0nJFT+BWw58d72+n+aNk+od+Ab7NLaAmcR4X5Vq5/u
         WTMF0WM5A9prLCOw1oeHn58WOaQqDuukn9iFiQPQi+lsA5f8NGedeDtaqCR+nvJjnV7X
         TjdTvE1WnnxuMj8xMJuLgWWQZlXTcB/P1QDMt8PFJNsnDpASuJglI0R6sIzzHAFMV68W
         6QaaBQjWWVX6ilt7iRgUqGu9Itie/GxbDX9h7gxgUYwvWVR1A4GtfsPFmrrtp/kvH+oS
         FzdQ==
X-Gm-Message-State: ABy/qLZkdRWGsHjXtpvr7k+Fz5/d3hQnC7ialNSi/O81s2FABSA8o5KC
	WhEcaRR6RQ7pnTJOl5lkgD1ueu+LFtSE1eqgusk=
X-Google-Smtp-Source: APBJJlGIK+k2HWDpS4CVxdtGC4KFvEBmzzK61NQFbw5EAkOhnX3nn7b716Oc2+1J1iuUkdpGICfhqmZQDoekrdkXOjs=
X-Received: by 2002:a2e:a40e:0:b0:2b7:2ea:33c3 with SMTP id
 p14-20020a2ea40e000000b002b702ea33c3mr10631146ljn.22.1689615139644; Mon, 17
 Jul 2023 10:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-7-memxor@gmail.com>
 <20230714223409.lfro5autichrkvvu@MacBook-Pro-8.local> <CAP01T76JRcOxdiU50C33Dnw+eApDOAg=mHQn9kUX7Qg_sHM7uQ@mail.gmail.com>
In-Reply-To: <CAP01T76JRcOxdiU50C33Dnw+eApDOAg=mHQn9kUX7Qg_sHM7uQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Jul 2023 10:32:08 -0700
Message-ID: <CAADnVQKSBS8upAObZCB8k=kJ5n+6cpaHdDKi-twPBNx8FAqFEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/10] bpf: Implement bpf_throw kfunc
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 9:44=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> > >
> > > -static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
> > > +static void push_callee_regs(u8 **pprog, bool *callee_regs_used, boo=
l force)
> > >  {
> > >       u8 *prog =3D *pprog;
> > >
> > > -     if (callee_regs_used[0])
> > > +     if (callee_regs_used[0] || force)
> > >               EMIT1(0x53);         /* push rbx */
> > > -     if (callee_regs_used[1])
> > > +     if (force)
> > > +             EMIT2(0x41, 0x54);   /* push r12 */
> >
> > let's make r12 push/pop explicit. In addition to push_callee_regs.
> >
>
> Ack (I'm understanding you mean adding a push/pop_r12 and using that).

I mean keep push_callee_regs() as saving bpf callee regs only and
add other helpers to save/restore r12.
Or just open code push/pop of r12.

