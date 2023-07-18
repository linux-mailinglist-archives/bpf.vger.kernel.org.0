Return-Path: <bpf+bounces-5190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7324775886E
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6C7281188
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAFA17AAB;
	Tue, 18 Jul 2023 22:29:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD61772E
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 22:29:04 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C79B1992;
	Tue, 18 Jul 2023 15:29:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so96538271fa.0;
        Tue, 18 Jul 2023 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689719340; x=1692311340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNw+miDO+/vr2NteE7yqKqsKfjVHHAqT8sK5QSW7byk=;
        b=a2pYDJsFUytmjoOLHzZ3DLS49W/e3L2DLHxvs19CPUjUXpJGPXa1kBPo9kbCok3E2N
         rleryHy3KrwhRqfZfuMCFFA0CwpSm9SoD9EftpqygB90ifNsixKTV28ce8pZArirwEO7
         45fx7Sunj4GM22bsLBHa6g/vljqN5bHzR52W0CCXsFYMNvlSyLih4Y/zmsDc6i2LR9nd
         IUDwqYwbYbsHzszrtkn4gMm7g5SWt2b+G8s5KyQV5iRXv/OYbN5dYl/UV3Zc/yXtBII/
         5GM00/htoFgEP1lnUEQbH3CqyXSt7e2ZaZIyAjSuFi9bpm4gGqwhmzvuYNKRYVOwHyK2
         6BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689719340; x=1692311340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNw+miDO+/vr2NteE7yqKqsKfjVHHAqT8sK5QSW7byk=;
        b=CEqSs9Z2cty0tgBwTxILDvHfaMq9v28s7wFoInYGvGs588LevWBjFo5W+12L26+8GH
         ZDcNDBXc0I2Pt44RB39D3RNKjCcQ3nBvSjBZ+UFYr0ywl1upEMfjmzceqh6/ckqaAJOf
         etwhhzLp7cIjWgQbaXPcYkH4UeB4jvvrup5uxWorpjKpOnzBFw84StlJhG3YQpwW0VrH
         g5/9liUZHauluHgzTT44FR+wyxxZyF2AsOTfaxUoqUDPQ1sjzEq4sKQsNbQzI5D7Padd
         hpvzeNWNCbynsUQFiHHio53Ul53dRcbRK/JV8X9pTwzLakUF85d7qujWzRAul7Lmkm5J
         LY1A==
X-Gm-Message-State: ABy/qLadviuv1KT799yTWKlLrdUC2+YOEnzJ1AL7jcEQhxkIyplKF8HF
	Mk4pWEJjsYKoS57YOuGaVV/MeSc9ZVHsXh6LeJ0=
X-Google-Smtp-Source: APBJJlH4etfU3dbNOp+Zve/q7ONO5kOmWFyi1Rdgcn0iBh8HYYbXtTuVVyfCGgwEE65eHBq0Fz2kzddf7rIaR5oqS00=
X-Received: by 2002:a2e:9b82:0:b0:2b6:a827:164f with SMTP id
 z2-20020a2e9b82000000b002b6a827164fmr450914lji.10.1689719339348; Tue, 18 Jul
 2023 15:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <168926677665.316237.9953845318337455525.stgit@ahduyck-xeon-server.home.arpa>
 <ce15b171-897f-bf2e-2897-c0b2b912e709@huaweicloud.com>
In-Reply-To: <ce15b171-897f-bf2e-2897-c0b2b912e709@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jul 2023 15:28:48 -0700
Message-ID: <CAADnVQK7+cUi2BvwNc+zdYj1SN1iMMe7Vgc5TkE+_MCATAuzUQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, arm64: Fix BTI type used for freplace attached functions
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 15, 2023 at 2:03=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 7/14/2023 12:49 AM, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > When running an freplace attached bpf program on an arm64 system w were
> > seeing the following issue:
> >    Unhandled 64-bit el1h sync exception on CPU47, ESR 0x000000003600000=
3 -- BTI
> >
> > After a bit of work to track it down I determined that what appeared to=
 be
> > happening is that the 'bti c' at the start of the program was somehow b=
eing
> > reached after a 'br' instruction. Further digging pointed me toward the
> > fact that the function was attached via freplace. This in turn led me t=
o
> > build_plt which I believe is invoking the long jump which is triggering
> > this error.
> >
> > To resolve it we can replace the 'bti c' with 'bti jc' and add a commen=
t
> > explaining why this has to be modified as such.
> >
> > Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for ar=
m64")
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > ---
> >   arch/arm64/net/bpf_jit_comp.c |    8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_com=
p.c
> > index 145b540ec34f..ec2174838f2a 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -322,7 +322,13 @@ static int build_prologue(struct jit_ctx *ctx, boo=
l ebpf_from_cbpf)
> >        *
> >        */
> >
> > -     emit_bti(A64_BTI_C, ctx);
> > +     /* bpf function may be invoked by 3 instruction types:
> > +      * 1. bl, attached via freplace to bpf prog via short jump
> > +      * 2. br, attached via freplace to bpf prog via long jump
> > +      * 3. blr, working as a function pointer, used by emit_call.
> > +      * So BTI_JC should used here to support both br and blr.
> > +      */
> > +     emit_bti(A64_BTI_JC, ctx);
>
> LGTM. Thanks for the fixes.
>
> Acked-by: Xu Kuohai <xukuohai@huawei.com>

Applied. Thanks

