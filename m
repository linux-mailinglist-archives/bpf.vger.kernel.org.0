Return-Path: <bpf+bounces-31780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D619032DB
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE73B28A0E8
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D48C171E74;
	Tue, 11 Jun 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIMGLK/v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F99B36D;
	Tue, 11 Jun 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087819; cv=none; b=JEPnJK3WDbbvsrshghZaLyPixzgdm04F6eB35cRDcb7T7ycg9E9OuJuv6llV8M0pCyMZ/JNhGqexUyohT43mXGHJRLm6qE+Q64H9xfdG6FvL7FU5ymJ9fuFbRgDYSACNqxotVNEwGyBjjWcO63fGviMPyNADEtT3XtJrU3XWiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087819; c=relaxed/simple;
	bh=uk7YiSPzqgJ+f8Pongt0+KLAJEHGJGs6c2ZHgCqCYMQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLVf1GgXwQ+7O58GvSPQMS8pZb2yDBkn9BnM5RVoINHEw5loy08jqS2eqidQttSBP2hxlooDYtlucmS5XpDweAr9m+8+CAq/uzghfP4pcJhYDujy7+VreN/IVrR4URZwdtEE5LkUyU9UkfYKCGc2h/jWmFvaUdTrnNcCFAVVy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIMGLK/v; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2508320e62dso234724fac.3;
        Mon, 10 Jun 2024 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718087817; x=1718692617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfhuLDL1BAr022/k6N6Q978r2/H3hADfHcwSIWARwkw=;
        b=mIMGLK/v+d3u8YVEKrBZfxR6n1IUszlJjwF01p7pFAv5ecQEJCn1NdWxVB7CwqERU1
         SdOrXr1eLi6poe9TIbOgM1wr2swnfTfreFAz3n5HAAnHpjNyLuBUcoEmNO6cvotVzwvO
         Eheb/sGyjKeyG0c2To3SG1IBvj4zrGzzFm7ZwglbnVFYoiG+ENOiDVOlpCjvVraaLlL1
         oUObPKCylAjn4WTHdLHtaRhjxvRRkG7BqffRf3xoT45DObko173/8426MpdPkgGyvAlX
         kFBt5E4QvklnBQPKt1ZiAWjUFb4fzddOXgPTHHTjvFxkASWtvzodG2kp0QhdEsfArJb3
         z7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718087817; x=1718692617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfhuLDL1BAr022/k6N6Q978r2/H3hADfHcwSIWARwkw=;
        b=Qdnr43057T3i3hL4bagDv7RH348NbygWxiPs4PwKz0TbiGH68DjiOWK36/9BbpJW8U
         S1WT2ac2++k/oZlB6T23RocqZdgLIlu6aMQq50atsBIz7SO823poBfbPSVEIgIXtlT22
         uSO4tqroGc0g2LVsj2nKjSNLJ/De8vvz20J/TIhjJcKZbiDsEuexboqGH/W7QWEffxVz
         N1v8euDJzd7ZSC+1XcCyxFt6hAe1C6Us5CHruAMLCH9wuYOOf4LlnOcITm2WRwImhag4
         9teMCK9aKLviapeVTy1whsIPw3Zykdk3Z+pM/1TdfTfbgMKTcOCN/KAqWufNRxZDtg7A
         Y0xw==
X-Forwarded-Encrypted: i=1; AJvYcCWwRNvTJ2pqjzAhK3lclkp0xnchhf14WuDL6/QzTJuszl0a1rAxJt2Fhl2Ll2FMvq2wKu2VJ3bMfehg79VMO4vvZ5726Yu3JC42IXqIN44HcCezWY56Fe5oRSFqMg==
X-Gm-Message-State: AOJu0YxNMINfRx4DHEhFqB2Rtkk79O8gpGmecR6MDctc9fTh96yjrKDr
	9kLEHDS9yN865l2MgVSeoU2n7hzhltc/hUCxfnne7s6qYmRuS0Bf
X-Google-Smtp-Source: AGHT+IEOfCDeujuolu4UcyB86S1AEhtpe5hk4N0i4XuxsyubOfsZoxlMT1BKTz+5hWanUFtEAaWvOg==
X-Received: by 2002:a05:6870:fba6:b0:254:ccac:133d with SMTP id 586e51a60fabf-254ccac4530mr5094367fac.21.1718087816805;
        Mon, 10 Jun 2024 23:36:56 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de264ae01bsm7128233a12.66.2024.06.10.23.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 23:36:56 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 10 Jun 2024 23:36:54 -0700
To: Mark Wielaard <mark@klomp.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ying Huang <ying.huang@oss.cipunited.com>
Cc: Mark Wielaard <mjw@redhat.com>, Hengqi Chen <hengqi.chen@gmail.com>,
	bpf@vger.kernel.org, dwarves@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: elfutils DWARF problem was: Re: Problem with BTF generation on
 mips64el
Message-ID: <Zmfwhn6inA2m1ftm@kodidev-ubuntu>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
 <Zln1kZnu2Xxeyngj@x1>
 <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu>
 <Zl3Zp5r9m6X_i_J4@x1>
 <Zl4AHfG6Gg5Htdgc@x1>
 <20240603191833.GD4421@gnu.wildebeest.org>
 <Zl6OTJXw0LH6uWIN@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl6OTJXw0LH6uWIN@kodidev-ubuntu>

On Mon, Jun 03, 2024 at 08:47:24PM -0700, Tony Ambardar wrote:
> Hi Mark,
> 
> On Mon, Jun 03, 2024 at 09:18:33PM +0200, Mark Wielaard wrote:
> > On Mon, Jun 03, 2024 at 02:40:45PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Couldn't find a way to ask eu-readelf for more verbose output, where we
> > > could perhaps get some clue as to why it produces nothing while binutils
> > > readelf manages to grok it, Mark, do you know some other way to ask
> > > eu-readelf to produce more debug output?
> > > 
> > > I'm unsure if the netdevsim.ko file was left in a semi encoded BTF state
> > > that then made eu-readelf to not be able to process it while pahole,
> > > that uses eltuils' libraries, was able to process the first two CUs for
> > > a kernel module and all the CUs for the vmlinux file :-\
> > > 
> > > Mark, the whole thread is available at:
> > > 
> > > https://lore.kernel.org/all/Zl3Zp5r9m6X_i_J4@x1/T/#u
> > 
> > I haven't looked at the vmlinux file. But for the .ko file the issue
> > is that the elfutils MIPS backend isn't complete. Specifically MIPS
> > relocations aren't recognized (and so cannot be applied). There are
> > some pending patches which try to fix that:
> > 
> > https://patchwork.sourceware.org/project/elfutils/list/?series=31601
> 
> Earlier in the thread, Hengqi Chen pointed out the latest elfutils backend
> work for MIPS, and I locally rebuilt elfutils and then pahole from their
> respective next/main branches. For elfutils, main (935ee131cf7c) includes
> 
>   e259f126 Support Mips architecture
>   f2acb069 stack: Fix stack unwind failure on mips
>   db33cb0c backends: Add register_info, return_value_location, core_note mips
> 
> which partially applies the patchwork series but leaves out the support for
> readelf, strip, and elflint.
> 
> I believe this means the vmlinux and .ko files I shared are OK, or is there
> more backend work needed for MIPS?
> 
> The bits missing in eu-readelf would explain the blank output both Arnaldo
> and I see from "$ eu-readelf -winfo vmlinux". I tried rebuilding with the
> patchwork readelf patch locally but ran into merge conflicts.
> 
> CCing Ying Huang for any more insight.
> 
> Thanks,
> Tony

Hello all,

A short update, starting with answering my own question.

No, apparently the above commits *do not* complete the backend work. Ying
Huang submitted additional related patches since March 5: [1][2]

    strip: Adapt src/strip -o -f on mips
    readelf: Adapt src/readelf -h/-S/-r/-w/-l/-d/-a on mips
    elflint: adapt src/elflint --gnu src/nm on mips
    test: Add mips in run-allregs.sh and run-readelf-mixed-corenote.sh

Despite the titles, these patches do include core backend changes for MIPS.
I resolved the various merge conflicts [3], rebuilt elfutils, and retested
kernel builds to now find:

  - pahole is able to read DWARF[45] info and create .BTF for modules
  - resolve_btfids can successfully patch .BTF_ids in modules
  - kernel successfully loads modules with BTF and kfuncs (tested 6.6 LTS)

Huzzah!


Ying:

Thank you for developing these MIPS patches. In your view, are the MIPS
changes now complete, or do you plan further updates that might improve or
impact parsing DWARF debug/reloc info in apps like pahole?


Mark:

Given that BTF usage on Linux/MIPS is basically broken without these
patches, could I request some of your review time for them to be merged? If
it's helpful, my branch [3] includes all patches with conflicts fixed, and
I also successfully ran the elfutils self-tests (including MIPS from Ying).
Please feel free to add for these patches:

    Tested-by: Tony Ambardar <Tony.Ambardar@gmail.com>


Arnaldo:

Your stepping through DWARF/reloc diagnostics earlier was helpful. Thanks!
I reran your tests with the updated elfutils and latest pahole (pre-1.27),
and then found:

  - everything that worked before, still works
  - your observations from "btfdiff vmlinux" and 'struct dma_chan' persist
  - we now see expected output from "eu-readelf -winfo netdevsim.ko"

Regarding pahole, DWARF parsing and BTF generation now works:
(with no more die__process: error messages seen)

    kodidev:~/linux$ pahole -F dwarf netdevsim.ko |wc -l
    14504

but strangely pahole still doesn't read its own generated BTF:

    kodidev:~/linux$ pahole -F btf netdevsim.ko
    libbpf: Invalid BTF string section
    pahole: file 'netdevsim.ko' has no btf type information.

Poking inside a little further:
    
    kodidev:~/linux$ ltrace -S pahole -F btf netdevsim.ko
    [...]
    argp_parse(0x563d47da42a0, 4, 0x7ffd5e552698, 0 <unfinished ...>
    SYS_318(0x7fc385bf84d8, 8, 1, 0x7fc385ce9908)    = 8
    SYS_brk(0)                                       = 0x563d47e37000
    SYS_brk(0x563d47e58000)                          = 0x563d47e58000
    <... argp_parse resumed> )                       = 0
    dwarves__init(0x20000, 0, -4096, 213)            = 0
    dwarves__resolve_cacheline_size(0x563d47da40c0, 0, 24, 213) = 64
    cus__new(5, 0, 64, 213)                          = 0x563d47e372a0
    memset(0x563d47da44c0, ' ', 127)                 = 0x563d47da44c0
    strlen("/sys/kernel/btf/")                       = 16
    strncmp("netdevsim.ko", "/sys/kernel/btf/", 16)  = 63
    cus__load_files(0x563d47e372a0, 0x563d47da40c0, 0x7ffd5e5526b0,
    0x563d47da40c0 <unfinished ...>
    SYS_openat(0xffffff9c, 0x7ffd5e554603, 0x80000, 0) = 3
    SYS_newfstatat(3, 0x7fc385baf44f, 0x7ffd5e552210, 4096) = 0
    SYS_read(3, "\177ELF\002\001\001", 4096)         = 4096
    SYS_close(3)                                     = 0
    SYS_openat(0xffffff9c, 0x7ffd5e554603, 0x80000, 0) = 3
    SYS_fcntl(3, 1, 0, 0x7fc3859de2f0)               = 1
    SYS_newfstatat(3, 0x7fc385baf44f, 0x7ffd5e5521f0, 4096) = 0
    SYS_pread(3, 0x7ffd5e5521f0, 64, 0)              = 64
    SYS_pread(3, 0x563d47e3e470, 3520, 0x4f60c8)     = 3520
    SYS_pread(3, 0x563d47e3f240, 525, 0x4f5eb8)      = 525
    SYS_pread(3, 0x563d47e3f460, 0x45dd, 0x2b1fb6)   = 0x45dd
    SYS_write(2, "libbpf: Invalid BTF string secti"..., 35libbpf: Invalid BTF
    string section
    ) = 35
    SYS_close(3)                                     = 0
    <... cus__load_files resumed> )                  = 0xffffffff
    access("netdevsim.ko", 4 <unfinished ...>
    SYS_access("netdevsim.ko", 04)                   = 0
    <... access resumed> )                           = 0
    fprintf(0x7fc385bf26a0, "pahole: file '%s' has no %s type"...,
    "netdevsim.ko", "btf" <unfinished ...>
    SYS_write(2, "pahole: file 'netdevsim.ko' has "..., 57pahole: file
    'netdevsim.ko' has no btf type information.
    ) = 57
    <... fprintf resumed> )                          = 57
    SYS_exit_group(1 <no return ...>
    +++ exited (status 1) +++

Could you help investigate this further? Maybe a libbpf issue? For the
record, I also tried building pahole with embedded libbpf 1.4.3 without
any change. (side note: please make pahole --version also cover libbpf)


Many thanks everyone for your help,
Tony

[1]: https://patchwork.sourceware.org/project/elfutils/list/?series=31601
[2]: https://patchwork.sourceware.org/project/elfutils/list/?series=34310
[3]:
https://github.com/guidosarducci/elfutils/commits/main-fix-mips-support-reloc/

