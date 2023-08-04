Return-Path: <bpf+bounces-7024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A217705AA
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A461282796
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4B198AB;
	Fri,  4 Aug 2023 16:11:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3671989D
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 16:11:23 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8921BDD
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 09:11:21 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63cfd6e3835so13503986d6.3
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691165481; x=1691770281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUz/F00xT7ugkiSWf6rX95nllWRBNhd9+1A0dvrpdTo=;
        b=2HDrihAGdJ7MfG1+8dsPUespfe5jeI5JTAKbQMm7RUu3pT7znehTtJYlI2HEIZMoEW
         80hUqnVlxpk3GzGqz9b8/pacgiHlKPzFqMkDCJpA+i8S2SoIQmzAkKvIAg0R3LLah3jN
         +2D3LfDn7kQ86X0ZFAH3Vug0De+inxrPJE1Ie/Kqm0mFSo8ixETdQ3SNF8agLwkAug3m
         RGzzQJH6XAJuarzhBB+WL2aLlOkcYKk8ncxPyNGHgwpHHRNYje4BcBFAE2uDvXibZW8L
         IQiLxa3yayHJFOHOOA22uu2jSL9oZjI1f4eMNs5AyXil+0Z3do7AgyLUTHE5QEmxmpgv
         RjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165481; x=1691770281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUz/F00xT7ugkiSWf6rX95nllWRBNhd9+1A0dvrpdTo=;
        b=Udeltfqdel2o3sZKLd+DSsvHvlRXY6pOx4YM7Q5i9OwI1LAHcv3CMp1a/xOwzdEnPi
         Bsuvh1nNahQ0rBSE3SZyBss36roL4V1/8wDnDA4PfECRdumhkMXg/vso2i5UzLXWil78
         OqMkOIqTdXOMPaT5W0kIBaODMHFD2g4nzcosL6w3uihcquwgyCjH3KjVHI+vDbTw/GI3
         KmpJtLZCD56Pet6cGwahlhxSk8JMO+BgTwARdKpEDG0LddnkKIO8GZYGTKCFhafjzpOf
         qd/jgTbw6INef+BiJ2XjPIsImOvR++cE858Nyb2buHFahvcIvJB2t7MVytmxAvEMqn1+
         y6fQ==
X-Gm-Message-State: AOJu0Yz+sCtm1NPKbLzt/RpDRXDAPfFvbplCBYqQJY+25dN2MyNkM5gP
	rrMx9+2+ZMa5vXIdkBCqHDxl+IgFeJ5nONXiiZxswg==
X-Google-Smtp-Source: AGHT+IFlHVI/xT5Mi4eYkWwoZ2wzHeDhtUCEOZDCwUnOxvTK/WFNztLQP67jQfTZt0Wwru0rT3bCBpGJQb5XDgkLXfI=
X-Received: by 2002:a0c:e587:0:b0:636:6205:fb01 with SMTP id
 t7-20020a0ce587000000b006366205fb01mr2062984qvm.34.1691165480664; Fri, 04 Aug
 2023 09:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
 <ZMwQivemlha+fU5i@kernel.org> <CAKwvOd=w3PFMDyZ1WL1DDx0Gyt-+sh7hYP_+8b9zEFu3uZpVXQ@mail.gmail.com>
 <afe71df3-48e4-837a-e85d-b6a6764eee62@oracle.com>
In-Reply-To: <afe71df3-48e4-837a-e85d-b6a6764eee62@oracle.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 4 Aug 2023 09:11:09 -0700
Message-ID: <CAKwvOdn93Zpdkk3faNNdDw=tnMQ6Mxo5tTVCDmrqStU95MVQqA@mail.gmail.com>
Subject: Re: FAILED: load BTF from vmlinux: Invalid argument
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, martin.lau@linux.dev, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, =?UTF-8?Q?Tomasz_Pawe=C5=82_Gajc?= <tpgxyz@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, m.seyfarth@gmail.com, 
	Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ Marcus (who also just reported seeing this
https://github.com/ClangBuiltLinux/linux/issues/1825#issuecomment-166467102=
7
and might be able to help reproduce).
+ Fangrui (because seeing dd used as a result of 90ceddcb4950 makes me shud=
der)

On Thu, Aug 3, 2023 at 3:10=E2=80=AFPM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 03/08/2023 21:50, Nick Desaulniers wrote:
> > On Thu, Aug 3, 2023 at 1:39=E2=80=AFPM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> >>
> >> Em Thu, Aug 03, 2023 at 11:02:46AM -0700, Nick Desaulniers escreveu:
> >>> Hi Martin (and BTF/BPF team),
> >>> I've observed 2 user reports with the error from the subject of this =
email.
> >>> https://github.com/ClangBuiltLinux/linux/issues/1825
> >>> https://bbs.archlinux.org/viewtopic.php?id=3D284177
> >>>
> >>> Any chance you could take a look at these reports and help us figure
> >>> out what's going wrong here?  Nathan and I haven't been able to
> >>> reproduce, but this seems to be affecting OpenMandriva (and Tomasz).
> >>>
> >>> Sounds like perhaps llvm-objcopy vs gnu objcopy might be a relevant d=
etail?
> >>
> >> Masami had a problem with new versions of compilers that was solved
> >> with:
> >>
> >> ------------------------ 8< ------------------------------------------=
--
> >>> To check that please tweak:
> >>>
> >>> =E2=AC=A2[acme@toolbox perf-tools-next]$ grep DWARF ../build/v6.2-rc5=
+/.config
> >>> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
> >>> # CONFIG_DEBUG_INFO_DWARF4 is not set
> >>> # CONFIG_DEBUG_INFO_DWARF5 is not set
> >>> =E2=AC=A2[acme@toolbox perf-tools-next]$
> >>>
> >>> i.e. disable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT and enable
> >>> CONFIG_DEBUG_INFO_DWARF4.
> >>
> >> Hm, with CONFIG_DEBUG_INFO_DWARF4, no warning were shown.
> >
> > Downgrading from the now-6-year-old DWARFv5 to now-13-year-old DWARFv4
> > is not what I'd consider a fix. Someday we can move to
> > DWARFv5...someday...
> >
> > What you describe sounds like build success, but reduction in debug inf=
o.
> >
> > The reports I'm referring to seem to result in a build failure.
> >
>
> This is a strange one. The error in question
>
> CC .vmlinux.export.o
> UPD include/generated/utsversion.h
> CC init/version-timestamp.o
> LD .tmp_vmlinux.btf
> BTF .btf.vmlinux.bin.o
> libbpf: BTF header not found
> pahole: .tmp_vmlinux.btf: Invalid argument

That's slightly different from Tomasz and Marcus' report (not sure if
that's relevant):

FAILED: load BTF from vmlinux: Invalid argument

That seems to come from
tools/bpf/resolve_btfids/main.c:529
Which seems like some failed call to btf_parse().
EINVAL is getting propagated up from btf_parse(), but that's not super
descriptive...

The hard part is that I suspect OpenMandriva (Tomasz) and Marcus are
both setting additional flags in their toolchains, which can make
reproducing tricky.

>
> ...occurs during BTF parsing when the raw size of the BTF is smaller
> than the BTF header size, which should never happen unless BTF
> is corrupted. Thing is, at that stage we shouldn't be parsing BTF,
> we should be generating it from DWARF. The only time pahole parses BTF
> is when it's creating split BTF for modules (it parses the base BTF), or
> when it's reading existing BTF, neither of which it should be doing at
> this stage.
>
> But I suspect the issue is in gen_btf() in scripts/link-vmlinux.sh.
> Prior to running pahole, we call "vmlinux_link .tmp_vmlinux.btf".
> If that went awry somehow and .tmp_vmlinux.btf wasn't created, it

Wouldn't we expect some kind of linker error though in that case?

> would explain the "Invalid argument" error:
>
> $ pahole -J nosuchfile
> pahole: nosuchfile: Invalid argument
>
> I see some clang specifics in vmlinux_link(), so I think a good
> first step would be to check if .tmp_vlinux.btf exists prior
> to running pahole. The submitter mentioned swapping linkers seems to
> help, so that seems a promising angle. If there's a kernel .config
> available I can try and reproduce the failure too. Thanks!
>
> Alan
>
> >>
> >>   LD      .tmp_vmlinux.btf
> >>   BTF     .btf.vmlinux.bin.o
> >>   LD      .tmp_vmlinux.kallsyms1
> >>
> >> And
> >>
> >> / # strings /sys/kernel/btf/vmlinux | wc -l
> >> 89921
> >> / # strings /sys/kernel/btf/vmlinux | grep -w kfree
> >> kfree
> >>
> >> It seems the BTF is correctly generated. (with DWARF5, the number of s=
ymbols
> >> are about 30000.)
> >
> >
> >



--=20
Thanks,
~Nick Desaulniers

