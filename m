Return-Path: <bpf+bounces-4133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC52749221
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 02:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A771C20BEA
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 00:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E099464;
	Thu,  6 Jul 2023 00:02:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AF9445
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:02:58 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FBA199E
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 17:02:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so1009585e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 17:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688601774; x=1691193774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuK25cxfzJ1BZgISYCN+CcLUdK2MTk+/Vh6nlnT0ork=;
        b=B8HpxE62HsOCGIPiho4SL4sf3gVz6mRMNVfuLXZaiK1KUqplJPX8brdDuvESC6RPw2
         Lk3w7tBWeyTBgWm1xQABZs+gJ0LathEMMRKzKsMWw1aeci15R3kbe/CyPuLueNUMC3eG
         2pEdFQjE49s2uQVNEMj7IskOKxAHqNIYfdkF1dRuDFV2zzKSW2ZpN6/mljaT5xCfz8Zk
         tTILowM9U1z3CEubTP89efdOmMOsQa+McNonMziEXLyD+L8bJGuyf0oQrW5OvOOnniBT
         B8rjwSx/AqH9BzMptVvkA8GoNrgx61ie8ykpl0B09qC99ksKhF1w0Vf9XhuHVpxLB5i2
         goCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688601774; x=1691193774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuK25cxfzJ1BZgISYCN+CcLUdK2MTk+/Vh6nlnT0ork=;
        b=aHEc5Byz/BMplKHN+r+Yn1dOTiEC5IMYv0q+egORr+jN/fge5dAGZ92jMLTYtlhjUa
         1OGIncgLcgBx6YTMg4xP3LKJaObTxrrETHQZLxjCSUUAk/XhhZ64p0Bv/JphTx2PFIWo
         IKMtpmyWKRrq1oDPaYFappP5/wByqzsshLJG2GWXffa40OEB1AcWWT5FJtFnXuF1V3fw
         l/fDGiyo0d8m08nTJMJFuHuAELvO3Fl93MWaPBN9XlF4fuuPJ/J9efvU+PKxZ7tobQQx
         +l2Mq/xDNiS7TclTvcxvxPM5yQPnTuZmZRzsn+mAIXp3pSPcxgX8qtmzEYuidGnqIon7
         VOig==
X-Gm-Message-State: ABy/qLaR1C8m/xEu13lTzdQT3aNdBFzchn0DMqXYsh4KE2Bz0BOWa+H9
	em+v4I+Zxy/vxssxqpeh4QJY3/vvrAVRPz6P75x/lJaYVuk=
X-Google-Smtp-Source: APBJJlGNAXHjRApTsI6l1N5fbLVZVOKUI4dTn76UL+78IYHvoo/3eUpQZ3zBozL4t3HsVB6X86UrNnXGYeH3iAyv8AM=
X-Received: by 2002:a7b:c458:0:b0:3fa:98f8:225f with SMTP id
 l24-20020a7bc458000000b003fa98f8225fmr111485wmi.26.1688601774485; Wed, 05 Jul
 2023 17:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zg4as04i.fsf@oracle.com>
In-Reply-To: <87zg4as04i.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jul 2023 17:02:42 -0700
Message-ID: <CAEf4BzagYTGu3eTVtrY+72-CSHDgrBiM3qeeFR8COc9MUYA9HA@mail.gmail.com>
Subject: Re: CO-RE builtins purity and other compiler optimizations
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, cupertino.miranda@oracle.com, david.faust@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 11:07=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> Hello BPF people!
>
> We are still working in supporting the pending CO-RE built-ins in GCC.
> The trick of hooking in the parser to avoid constant folding, as
> discussed during LSFMMBPF, seems to work well.  Almost there!
>
> So, most of the CO-RE associated C built-ins have the side effect of
> emiting a CO-RE relocation in the .BTF.ext section.  This is for example
> the case of __builtin_preserve_enum_value.
>
> Like calls to regular functions, calls to C built-ins are also
> candidates to certain optimizations.  For example, given this code:
>
> : int a =3D __builtin_preserve_enum_value(*(typeof(enum E) *)eB, BPF_ENUM=
VAL_VALUE);
> : int b =3D __builtin_preserve_enum_value(*(typeof(enum E) *)eB, BPF_ENUM=
VAL_VALUE);
>
> The compiler may very well decide to optimize out the second call to the
> built-in if it is to be considered "pure", i.e. given exactly the same
> arguments it produces the same results.
>
> We observed that clang indeed seems to optimize that way.  See
> https://godbolt.org/z/zqe9Kfrrj.
>
> That kind of optimizations have an impact on the number of CO-RE
> relocations emitted.
>
> Question:
>
> Is the BPF loader, the BPF verifier or any other core component sensible
> in any way to the number (and ordering) of CO-RE relocations for some
> given BPF C program?  i.e. compiling the same BPF C program above with
> and without that optimization, will it work in both cases?

Yes, it should.

>
> If no, then perfect!  Different compilers can optimize slightly

Did you mean "if yes, then perfect"? Because otherwise it makes no sense :)

> differently (or not optimize at all) and we can mark these built-ins as
> pure in GCC as well, benefiting from optimizations without worrying to
> have to emit exactly what clang emits.

Yes, it should be fine, as long as the compiler doesn't assume any
specific value returned by CO-RE relocation (and doesn't perform any
optimizations based on that assumed value). From the BPF verifier
side, it's just a constant, so the BPF verifier itself doesn't care.
From the libbpf/BPF loader standpoint, all that matters is that there
is CO-RE relocation information that specifies how some BPF
instruction needs to be adjusted to match the host kernel properly.
Whether CO-RE relocation is repeated many times, or performed just
once and that constant value is just reused in the code many times,
shouldn't matter at all.

>
> If yes, wouldn't it be better to disable that kind of optimization in
> all C BPF compilers, i.e. to make the compilers aware of the side-effect
> so they will not optimize built-in calls out (or replicate them.) and to
> make this mandatory in the CO-RE spec?  Making a compiler to optimize
> exactly like another compiler is difficult and sometimes even not
> feasible.
>
> Thanks in advance for the clarification/info!
>

