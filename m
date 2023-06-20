Return-Path: <bpf+bounces-2925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B92736FD4
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 17:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311361C203B3
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C428174C0;
	Tue, 20 Jun 2023 15:07:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646E168CA
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 15:07:26 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44CD10E4
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:07:23 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-440954dc5fcso1649693137.2
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687273643; x=1689865643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu+Xr6h3aJ6hrDihAENTAwjE21lX4dsN0DdvvEc0zpY=;
        b=4uNSAlI4tPJM+0kDEQ3Xs8m8o+h885+DYvUyEEqM1Q3xUaL/Zkac4rYDVD5VV3k69y
         QnJ+X6pZflYUWAfDmGx3KQbOCUfSElOR8MWCOyxMQigZTQB0F5U/vXfgQz+nVHm7JgFe
         zPxHHx0QiAS6zIRh5LTna1ZDaAT0LM1d3CYeqQBXg8Lvxt+HiMz1jiJCsSLDmHtZX11G
         EpfV9JeKtWMhTkP+hF8WhgfPf+D0P5ODet5RxxWMwun9woKcQyCvPe794rr3cZawXdtp
         J25Wo4tc74aotGpx3E9VgQhnLQmyiDFwzEmS7CM7u6MHsfy/y7YIEbkaEg3cgkWmLefz
         C2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687273643; x=1689865643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nu+Xr6h3aJ6hrDihAENTAwjE21lX4dsN0DdvvEc0zpY=;
        b=XpHiGXkbVtlO0lS+/da/DeLcM1sPdu6vhB7EtkGPEb7SHXI2KJppP/HkWTPVt9AGiu
         LyVtlQGChgD1VuErnNzWwVYBR1B7JFbngftTMHfqlw3BBBHF4su58uimgKaFVnWhvrZb
         cUnmhraOHB7LOq2TyNgVr96Jy3V+VjhE6BzYTetRRbyM738eXkUdBz5MJIWZXkYyz5f/
         DhZAmw8W+bDVL9umjjvtKm2ZtWDaDOcryp0kQKV5bNSHNGxi3qn35i2XET7DNKU81pFb
         +0nxQhT4OKYis2LzBvuZ/Hgrp5gTHjhkM3jPfzDomCisVAMfdAGQU7qAD0yYQfWIC7kX
         pGxw==
X-Gm-Message-State: AC+VfDwWF8waht9VgD+upXSD8V+5Bfvm+5o2GpQbquerTDb6vOcy4oBn
	bhiVfrp2vTNHhDDBhXKRXFCTfwitj1/EDRncehRwJg==
X-Google-Smtp-Source: ACHHUZ5vngzvnC7UegKxQKg2uyHGXDbhDi5IOIg/YI2HnKU4l09bZNgBzggiucC0ZQ4lI+/z7uZrliKEuxvWJA1puIM=
X-Received: by 2002:a67:ce84:0:b0:440:b0eb:4fd7 with SMTP id
 c4-20020a67ce84000000b00440b0eb4fd7mr3963408vse.23.1687273642685; Tue, 20 Jun
 2023 08:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615145607.3469985-1-revest@chromium.org> <CAEf4BzbjCt3tKJ40tg12rMjCLXrm7UoGuOdC62vGnpTTt8-buw@mail.gmail.com>
 <CABRcYmK=yXDumZj3tdW7341+sSV1zmZw1UpQkfSF6RFgnBQjew@mail.gmail.com>
 <c26de68d-4a56-03a0-2625-25c7e2997d45@meta.com> <CAKwvOdnehNwrDNV5LvBBwM=jqPJvL7vB9HwF0YU-X5=zbByrmg@mail.gmail.com>
 <6b63301f-96b2-74b9-c156-3a34fb5ad346@meta.com>
In-Reply-To: <6b63301f-96b2-74b9-c156-3a34fb5ad346@meta.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 20 Jun 2023 11:07:10 -0400
Message-ID: <CAKwvOdna=1Sg4Aab=BE6F86H9ZE7kPRM=VTkqQuGiF-Jdze-cA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To: Yonghong Song <yhs@meta.com>
Cc: Florent Revest <revest@chromium.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, nathan@kernel.org, trix@redhat.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 10:53=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 6/20/23 7:38 AM, Nick Desaulniers wrote:
> > 3. you did not run defconfig/menuconfig to have kconfig check for
> > DWARFv5 support.
>
> Yes, I didn't run defconfig/menuconfig.

That doesn't mean the odd combo of clang+gas doesn't work.

Just like how using scripts/config is a hazard since it also doesn't
run kconfig and allows you to set incompatible configurations. Garbage
in; garbage out.

>
> >
> > The kconfigs should prevent you from selecting DWARFv5 if your
> > toolchain combination doesn't support it; if you run kconfig.
> >
> >> /tmp/video-bios-59fa52.s:4: Error: file number less than one
> >> /tmp/video-bios-59fa52.s:5: Error: junk at end of line, first
> >> unrecognized character is `"'
> >> /tmp/video-bios-59fa52.s:6: Error: junk at end of line, first
> >> unrecognized character is `"'
> >> /tmp/video-bios-59fa52.s:7: Error: junk at end of line, first
> >> unrecognized character is `"'
> >> /tmp/video-bios-59fa52.s:8: Error: junk at end of line, first
> >> unrecognized character is `"'
> >> /tmp/video-bios-59fa52.s:9: Error: junk at end of line, first
> >> unrecognized character is `"'
> >> /tmp/video-bios-59fa52.s:10: Error: junk at end of line, first
> >> unrecognized character is `"'
> >> /tmp/video-bios-59fa52.s:68: Error: junk at end of line, first
> >> unrecognized character is `"'
> >> clang: error: assembler command failed with exit code 1 (use -v to see
> >> invocation)
> >> make[4]: *** [/home/yhs/work/bpf-next/scripts/Makefile.build:252:
> >> arch/x86/realmode/rm/video-bios.o] Error 1
> >> make[4]: *** Waiting for unfinished jobs....
> >> /tmp/wakemain-88777c.s: Assembler messages:
> >> /tmp/wakemain-88777c.s:4: Error: junk at end of line, first unrecogniz=
ed
> >> character is `"'
> >> /tmp/wakemain-88777c.s:4: Error: file number less than one
> >> /tmp/wakemain-88777c.s:5: Error: junk at end of line, first unrecogniz=
ed
> >> character is `"'
> >> /tmp/wakemain-88777c.s:6: Error: junk at end of line, first unrecogniz=
ed
> >> character is `"'
> >> /tmp/wakemain-88777c.s:7: Error: junk at end of line, first unrecogniz=
ed
> >> character is `"'
> >> /tmp/wakemain-88777c.s:8: Error: junk at end of line, first unrecogniz=
ed
> >> character is `"'
> >> /tmp/wakemain-88777c.s:81: Error: junk at end of line, first
> >> unrecognized character is `"'
> >> /tmp/wakemain-88777c.s:312: Error: junk at end of line, first
> >> unrecognized character is `"'
> >> clang: error: assembler command failed with exit code 1 (use -v to see
> >> invocation)
> >>
> >> Potentially because of my local gnu assembler 2.30-120.el8 won't work
> >
> > It's recorded in lib/Kconfig.debug that 2.35.2 is required for DWARFv5
> > support if you're using GAS.  My machine has 2.40.
> >
> >> with some syntax generated by clang. Mixing clang compiler and arbitra=
ry
> >> gnu assembler are not a good idea (see the above example). It might
> >
> > I agree, but for older branches of stable which are still supported,
> > we didn't quite have clang assembler support usable.  We still need to
> > support those branches of stable.
>
> Thanks Florent pointing out 5.10 stable kernels which have this issue.

No, all kernels have this issue, when using `LLVM=3D1 LLVM_IAS=3D0`.  It's
more likely that someone is using that combination for branches of
stable that predate 4.19 (such as 4.14) but we do still try to support
that combination somewhat, even if we recommend just using `LLVM=3D1`.
Interop between toolchains is still important, even if "why would you
do that?"

> I am okay with backporting to old stable kernels if that is needed.
> But the patch going to bpf-next should not have a bug-fix tag and
> the patch commit message can be tweaked for backport to 5.10 though.
>
> >
> >> work with close-to-latest gnu assembler.
> >>
> >> To support function name like '<fname>.isra', some llvm work will be
> >> needed, and it may take some time.
> >>
> >> So in my opinion, this patch is NOT a bug fix. It won't affect distro.
> >> Whether we should backport to the old kernel, I am not sure whether it
> >> is absolutely necessary as casual build can always remove LLVM_IAS=3D0=
 or
> >> hack the kernel source itself.
> >
> >
> >



--=20
Thanks,
~Nick Desaulniers

