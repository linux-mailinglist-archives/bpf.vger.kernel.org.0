Return-Path: <bpf+bounces-6897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74D76F43B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 22:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5AF282302
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A04925923;
	Thu,  3 Aug 2023 20:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C82590E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 20:50:24 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC844226
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 13:50:14 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63d30554eefso8243716d6.3
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691095813; x=1691700613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXEBAyFJFbYeh0GfNg35wWnEZbFECcO5ZYIOzORkkp0=;
        b=2lzRkoN3T98wTMebW/2Qq42a7bMP88a8JdxhWr9S2uN8aa5XW4HKJ49SmbYwRnvC9L
         Iy/GgOi0bdIZtrdCSDZEffaAwJ1tiMWXNd/p5tQ3aPm2r7/XYXxBCAVVG4H2oUjv5GHQ
         E/vBMomX2egESgjpYIk5y1dy4NKRLeTSKX2Slbb63Y19wXZBz2l4drVZFunV/GMgsNIL
         w2NycADenBYqkYH/EjZlhHZHqEd1HGRG1PoWhodJieSXT+BmrS79+yF+FOnkeIpzcfvc
         jEoM8gzXKXcYzjWoAdcXNMRFmgXUyTqmoSB1kSTTA0V6m+rnzVMVOR4yeqCkulaKmJhK
         CPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691095813; x=1691700613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXEBAyFJFbYeh0GfNg35wWnEZbFECcO5ZYIOzORkkp0=;
        b=KHeug+9QsskbmELyra0R7za6o5Mr0p2RPX8HR++ovDQUSLCE1fbpVBbob6dgT8Yngx
         gxkss30IdhGG2BxZqqgdRyXzmXyaI0iKHIbIS1H3bQ2eA0EUwE02ek4E335OiQ0k/fCv
         3U3hVdD1ZPp5YD1GByyUjXJD+1PU+iCDGbbmVDmnXVurapx6yGvXPRbcvqiK+3TYnEDy
         us6lSYBr8wpgGO0oy74aACJHofJe6Dec/jrbMDmGmDgiYoMhbYzTjCwtaHPOBlTZYy0y
         8YuDxq5UlMjzHwsJSooOUlSettjwA464qSPexK6cvTEcd0lOuz4XAvrInU6vEI2NmHQv
         9qfQ==
X-Gm-Message-State: ABy/qLbE10WK5CfLqTSuBD0WMYdgQK+AVJ4Nkq74rEcNh4GBaAtkJA8B
	qYqXl2CJBwbeNOg90kRLzT2JtarK51lKUgwMuYYXRQ==
X-Google-Smtp-Source: APBJJlEi+U0yRbR0xEFEgBiTrvPcZqH73Ed2f0Qner5SKRDMXME9DMZGWe7025604sPpX6v4/jfihlkQxm4FFQfngPs=
X-Received: by 2002:ad4:5226:0:b0:62b:49e1:4946 with SMTP id
 r6-20020ad45226000000b0062b49e14946mr19387212qvq.21.1691095813103; Thu, 03
 Aug 2023 13:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
 <ZMwQivemlha+fU5i@kernel.org>
In-Reply-To: <ZMwQivemlha+fU5i@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 3 Aug 2023 13:50:02 -0700
Message-ID: <CAKwvOd=w3PFMDyZ1WL1DDx0Gyt-+sh7hYP_+8b9zEFu3uZpVXQ@mail.gmail.com>
Subject: Re: FAILED: load BTF from vmlinux: Invalid argument
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: martin.lau@linux.dev, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, =?UTF-8?Q?Tomasz_Pawe=C5=82_Gajc?= <tpgxyz@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 1:39=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Thu, Aug 03, 2023 at 11:02:46AM -0700, Nick Desaulniers escreveu:
> > Hi Martin (and BTF/BPF team),
> > I've observed 2 user reports with the error from the subject of this em=
ail.
> > https://github.com/ClangBuiltLinux/linux/issues/1825
> > https://bbs.archlinux.org/viewtopic.php?id=3D284177
> >
> > Any chance you could take a look at these reports and help us figure
> > out what's going wrong here?  Nathan and I haven't been able to
> > reproduce, but this seems to be affecting OpenMandriva (and Tomasz).
> >
> > Sounds like perhaps llvm-objcopy vs gnu objcopy might be a relevant det=
ail?
>
> Masami had a problem with new versions of compilers that was solved
> with:
>
> ------------------------ 8< --------------------------------------------
> > To check that please tweak:
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ grep DWARF ../build/v6.2-rc5+/=
.config
> > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > # CONFIG_DEBUG_INFO_DWARF5 is not set
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > i.e. disable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT and enable
> > CONFIG_DEBUG_INFO_DWARF4.
>
> Hm, with CONFIG_DEBUG_INFO_DWARF4, no warning were shown.

Downgrading from the now-6-year-old DWARFv5 to now-13-year-old DWARFv4
is not what I'd consider a fix. Someday we can move to
DWARFv5...someday...

What you describe sounds like build success, but reduction in debug info.

The reports I'm referring to seem to result in a build failure.

>
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
>   LD      .tmp_vmlinux.kallsyms1
>
> And
>
> / # strings /sys/kernel/btf/vmlinux | wc -l
> 89921
> / # strings /sys/kernel/btf/vmlinux | grep -w kfree
> kfree
>
> It seems the BTF is correctly generated. (with DWARF5, the number of symb=
ols
> are about 30000.)



--=20
Thanks,
~Nick Desaulniers

