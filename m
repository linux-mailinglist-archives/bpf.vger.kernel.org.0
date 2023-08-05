Return-Path: <bpf+bounces-7086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FAB77105F
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 17:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179D6282331
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08833C2E5;
	Sat,  5 Aug 2023 15:42:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5830A945
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 15:42:16 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6448139
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 08:42:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52227884855so4247444a12.1
        for <bpf@vger.kernel.org>; Sat, 05 Aug 2023 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691250133; x=1691854933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5oPGlPcQoIGdgM0VCxXAjsaz8qStZCqVt1y/O55TbU4=;
        b=UFweuQbNV4JurJGWQjoD+wJciMB9H3KlN8C1Y2VUFPBhhX6sVGKaCkW/MpCIXVN5nt
         C57P3lZvHzg6z7lZfEc0RlmRA84cp4S5Hjisry90yGZXE/65jiumw6IQ3Yj8/pQAtgDO
         SVlRG8vFPinL6F8dfRcJ7HJqOltipBzNMqu6ojC3bOh1G/G17kqW1OBLh59zF1Fgs58m
         eKNGsfz5xyfTBWvtcCgiAgB3qDR500YrTPgCCktVMPfVsnkvEv/9x2UOgmqVBhF/ykFU
         j/Kb0PWVVbUk4R9mjelzdwVJOssYMyUsmQpUdHOdzCfhG7ivezmQnTfRHzT8rzjIqLFb
         glxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691250133; x=1691854933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oPGlPcQoIGdgM0VCxXAjsaz8qStZCqVt1y/O55TbU4=;
        b=ZcsDLQWS/Xtl0jUzgytj5ehXHxOpIDkkz4us6l9K7V5w4AEJveHiogpz+6vZhECPlN
         rmGPk6x4QIGiFNe4JGXN7j3v3UUPu1a5aOqRy1+rdR5Ph7F/t/JM22A1SfiJTQblpSKR
         z83sL5qdWSyriAZPB9GjLXXCqVqLCota//GnoK3BmNShFT0UbKp3KZ3fkpAk2uBPLizU
         YOwZdRMMllqLrETOb4GdZxb9JfRYMlmv35JDnWAwoDdftjfAzijzmwMAF3pHLjSyTZuF
         W5+p4kp8UHVOQdFG7jdeCoaUFDqcq6tXlQqCvncsTXFHWWUyEF+sGfAYmx+CcpEd4PRV
         s+tw==
X-Gm-Message-State: AOJu0YwXk8hLi2BjywHlJwAHzNpqJD0ZuU+kYjK+HPT1BW+adwUXPb98
	OTB9HEYfD4ZO+YHwfDNYPM4=
X-Google-Smtp-Source: AGHT+IE/HMWsULhkXl7ttOYIT+mNc+J9SfE66Ad1bnDfnLmrAudP21AMWaSGDN8uiPVJYZvTnqkSOA==
X-Received: by 2002:a05:6402:78a:b0:522:5980:ae08 with SMTP id d10-20020a056402078a00b005225980ae08mr4206668edy.18.1691250132873;
        Sat, 05 Aug 2023 08:42:12 -0700 (PDT)
Received: from krava ([83.240.60.134])
        by smtp.gmail.com with ESMTPSA id j2-20020a50ed02000000b005223e54d1edsm2780976eds.20.2023.08.05.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 08:42:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 5 Aug 2023 17:42:10 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, martin.lau@linux.dev,
	bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>,
	Tomasz =?utf-8?B?UGF3ZcWC?= Gajc <tpgxyz@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, m.seyfarth@gmail.com,
	Fangrui Song <maskray@google.com>
Subject: Re: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <ZM5t0mMODRtvpi1c@krava>
References: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
 <ZMwQivemlha+fU5i@kernel.org>
 <CAKwvOd=w3PFMDyZ1WL1DDx0Gyt-+sh7hYP_+8b9zEFu3uZpVXQ@mail.gmail.com>
 <afe71df3-48e4-837a-e85d-b6a6764eee62@oracle.com>
 <CAKwvOdn93Zpdkk3faNNdDw=tnMQ6Mxo5tTVCDmrqStU95MVQqA@mail.gmail.com>
 <7eea26c2-e3c9-d212-1688-21d448649e07@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7eea26c2-e3c9-d212-1688-21d448649e07@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 11:03:03PM +0100, Alan Maguire wrote:
> On 04/08/2023 17:11, Nick Desaulniers wrote:
> > + Marcus (who also just reported seeing this
> > https://github.com/ClangBuiltLinux/linux/issues/1825#issuecomment-1664671027
> > and might be able to help reproduce).
> > + Fangrui (because seeing dd used as a result of 90ceddcb4950 makes me shudder)
> > 
> > On Thu, Aug 3, 2023 at 3:10 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>
> >> On 03/08/2023 21:50, Nick Desaulniers wrote:
> >>> On Thu, Aug 3, 2023 at 1:39 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>>>
> >>>> Em Thu, Aug 03, 2023 at 11:02:46AM -0700, Nick Desaulniers escreveu:
> >>>>> Hi Martin (and BTF/BPF team),
> >>>>> I've observed 2 user reports with the error from the subject of this email.
> >>>>> https://github.com/ClangBuiltLinux/linux/issues/1825
> >>>>> https://bbs.archlinux.org/viewtopic.php?id=284177
> >>>>>
> >>>>> Any chance you could take a look at these reports and help us figure
> >>>>> out what's going wrong here?  Nathan and I haven't been able to
> >>>>> reproduce, but this seems to be affecting OpenMandriva (and Tomasz).
> >>>>>
> >>>>> Sounds like perhaps llvm-objcopy vs gnu objcopy might be a relevant detail?
> >>>>
> >>>> Masami had a problem with new versions of compilers that was solved
> >>>> with:
> >>>>
> >>>> ------------------------ 8< --------------------------------------------
> >>>>> To check that please tweak:
> >>>>>
> >>>>> ⬢[acme@toolbox perf-tools-next]$ grep DWARF ../build/v6.2-rc5+/.config
> >>>>> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> >>>>> # CONFIG_DEBUG_INFO_DWARF4 is not set
> >>>>> # CONFIG_DEBUG_INFO_DWARF5 is not set
> >>>>> ⬢[acme@toolbox perf-tools-next]$
> >>>>>
> >>>>> i.e. disable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT and enable
> >>>>> CONFIG_DEBUG_INFO_DWARF4.
> >>>>
> >>>> Hm, with CONFIG_DEBUG_INFO_DWARF4, no warning were shown.
> >>>
> >>> Downgrading from the now-6-year-old DWARFv5 to now-13-year-old DWARFv4
> >>> is not what I'd consider a fix. Someday we can move to
> >>> DWARFv5...someday...
> >>>
> >>> What you describe sounds like build success, but reduction in debug info.
> >>>
> >>> The reports I'm referring to seem to result in a build failure.
> >>>
> >>
> >> This is a strange one. The error in question
> >>
> >> CC .vmlinux.export.o
> >> UPD include/generated/utsversion.h
> >> CC init/version-timestamp.o
> >> LD .tmp_vmlinux.btf
> >> BTF .btf.vmlinux.bin.o
> >> libbpf: BTF header not found
> >> pahole: .tmp_vmlinux.btf: Invalid argument
> > 
> > That's slightly different from Tomasz and Marcus' report (not sure if
> > that's relevant):
> > 
> > FAILED: load BTF from vmlinux: Invalid argument
> > 
> > That seems to come from
> > tools/bpf/resolve_btfids/main.c:529
> > Which seems like some failed call to btf_parse().
> > EINVAL is getting propagated up from btf_parse(), but that's not super
> > descriptive...
> > 
> Okay, that makes more sense. Basically the stage where we read vmlinux
> BTF to do BTF id resolution (BTFIDS) is finding an empty BTF section.

+1, looks like pahole failed to generate the BTF section, the BTFIDS
is just follow up error.. we might want to consider special error
output for missing BTF data ;-)

I can't reproduce this on my setup with either gcc or clang and trying
DWARF4/5 config options and latest and 1.24 pahole version

> 
> > The hard part is that I suspect OpenMandriva (Tomasz) and Marcus are
> > both setting additional flags in their toolchains, which can make
> > reproducing tricky.
> >
> 
> I tried falling back to the config referenced in the earlier bug report
> 
> https://github.com/ClangBuiltLinux/linux/files/10050200/config_bpf.txt

hum, I did not find this in the report.. are there more kernel configs
related to this issue? seems like more people hit this

thanks,
jirka

> 
> ...but still couldn't reproduce it with LLVM 17 + pahole v1.24. That
> config did specify DWARF5; if we can reproduce this, it would probably
> be good to vary between forcing DWARF4 and DWARF5 to see if that is a
> contributing factor as Arnaldo suggested.
> 
> Alan
> 
> >>
> >> ...occurs during BTF parsing when the raw size of the BTF is smaller
> >> than the BTF header size, which should never happen unless BTF
> >> is corrupted. Thing is, at that stage we shouldn't be parsing BTF,
> >> we should be generating it from DWARF. The only time pahole parses BTF
> >> is when it's creating split BTF for modules (it parses the base BTF), or
> >> when it's reading existing BTF, neither of which it should be doing at
> >> this stage.
> >>
> >> But I suspect the issue is in gen_btf() in scripts/link-vmlinux.sh.
> >> Prior to running pahole, we call "vmlinux_link .tmp_vmlinux.btf".
> >> If that went awry somehow and .tmp_vmlinux.btf wasn't created, it
> > 
> > Wouldn't we expect some kind of linker error though in that case?
> > 
> >> would explain the "Invalid argument" error:
> >>
> >> $ pahole -J nosuchfile
> >> pahole: nosuchfile: Invalid argument
> >>
> >> I see some clang specifics in vmlinux_link(), so I think a good
> >> first step would be to check if .tmp_vlinux.btf exists prior
> >> to running pahole. The submitter mentioned swapping linkers seems to
> >> help, so that seems a promising angle. If there's a kernel .config
> >> available I can try and reproduce the failure too. Thanks!
> >>
> >> Alan
> >>
> >>>>
> >>>>   LD      .tmp_vmlinux.btf
> >>>>   BTF     .btf.vmlinux.bin.o
> >>>>   LD      .tmp_vmlinux.kallsyms1
> >>>>
> >>>> And
> >>>>
> >>>> / # strings /sys/kernel/btf/vmlinux | wc -l
> >>>> 89921
> >>>> / # strings /sys/kernel/btf/vmlinux | grep -w kfree
> >>>> kfree
> >>>>
> >>>> It seems the BTF is correctly generated. (with DWARF5, the number of symbols
> >>>> are about 30000.)
> >>>
> >>>
> >>>
> > 
> > 
> > 
> 

