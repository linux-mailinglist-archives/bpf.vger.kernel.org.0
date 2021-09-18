Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659DB410760
	for <lists+bpf@lfdr.de>; Sat, 18 Sep 2021 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhIRPmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Sep 2021 11:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhIRPmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Sep 2021 11:42:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8375C061574
        for <bpf@vger.kernel.org>; Sat, 18 Sep 2021 08:41:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v24so41846045eda.3
        for <bpf@vger.kernel.org>; Sat, 18 Sep 2021 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ks0/19D0ZSXHBIrP9X046J19vM5JRA8DcUzbvk6iF2M=;
        b=QpzVfDLVYgDt/gULxtpvQ92IYQsdKIcA/v9Zhtdc2b9QXw2BhQ/URaKXZR508hCS1a
         Dh+6aTSp1jfEYYhIgs8BAiJgwyCopWAnT6UfgM+PW9sXlgvuOnAX/wWs/J81q73CqnSV
         SWrZrrjwVTD2FOo+PjGq2aNg6shSZXHJW2wA33GkvFH9qVVWqbCQsCWaavCGk9YqIdB1
         e+VCyj/YME06BtrONOcSZ7kinpxEGMxn4Clvb2fWum4tIN/+ycHm7tZxhaquA1zbUYh/
         RFwyXjcq/+53gZxj7l+pkPW+7pueM7U9ods9YdQHsFfEP0p+I3m/2UFxV9EBGk7gjtNK
         fURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ks0/19D0ZSXHBIrP9X046J19vM5JRA8DcUzbvk6iF2M=;
        b=dfCRTph6hpDkmr5mHl7DlyosEzAIvj3pyX4EoEiY/hIYnAg3cak+/53OxpK8Jqu4w7
         YEp2RLoGSkKMBaGhGABUiSQb10vEozbweFqoS/nMyHEY27UuR9fr6NCbsuh6pIoTWeo+
         gJVHzzjgeubGkYBYpQagqQ/k43wsv9DTBrLqPwyvqJUhXezrr03lRffymYjPdNj1//pn
         VL2s1Ek+VdzfQXtfwIxEUTucaH1bNgyLyJxhQ4JCFkf66w6Xp3SI4xiBlySkAhJgEhJ9
         AvolFY5PdDaoswpwe5sGjVBFAfSvCgwFIhJPLkaDniMC8BK8fXhWn/f4Z9BE8vLn7awl
         PxlA==
X-Gm-Message-State: AOAM5332bzHlWO3963s4WIXnLwgTj9hCAK43tYmA9RdMoniR13fQuffc
        /hXHCVkXBwO5tMReBluKAFb+4b3Zq8vOpw/ntmk=
X-Google-Smtp-Source: ABdhPJzxUs2Vdd34DxAsf6JKXbQua6mliF2kf+4748rykw1qBcu4QsK8OdWaY50XMnXNk4ybXRqjmrZkufXB4JmnXv8=
X-Received: by 2002:a50:9fcf:: with SMTP id c73mr18732399edf.308.1631979674143;
 Sat, 18 Sep 2021 08:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2wW-tWOT+VBOc8QjRcbhMX3dCpsvE9if4VOA8s7R2icjg@mail.gmail.com>
 <dbf6ca0a-2c06-c703-6852-760b321e7219@fb.com>
In-Reply-To: <dbf6ca0a-2c06-c703-6852-760b321e7219@fb.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Sat, 18 Sep 2021 08:41:02 -0700
Message-ID: <CAK3+h2zaFOAjf6LSLeTr0QzjRKKFhPAD17OZ6N7dgUe8kUCt6Q@mail.gmail.com>
Subject: Re: llvm-objdump bpf coredump
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 8:00 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/17/21 6:34 PM, Vincent Li wrote:
> > Hi,
> >
> > I am supposed to file a bug report in https://bugs.llvm.org/  but the
> > site requires account login, while waiting for my account setup, and
> > since this is related to BPF, I will try my luck here :)
> >
> > This is cilium environment, when I use llvm-objdump to disassemble the
> > bpf_lxc.o like below, it core dumps
> >
> > #llvm-objdump -S -D  /var/run/cilium/state/2799/bpf_lxc.o >
> > /home/bpf_lxc-5.4.txt
>
> Any particular reason you are using '-D' here?
>
> "llvm-objdump --help" gives:
>
>    --disassemble-all       Display assembler mnemonics for the machine
> instructions
>
>    --disassemble           Display assembler mnemonics for the machine
> instructions
>
>
>    -D                      Alias for --disassemble-all
>
>
>    -d                      Alias for --disassemble
>
> It gives the same description about -D and -d but actually -D tries to
> disassemble *all* sections and -d tries to disassemble *only* executable
> sections.
>
> The following is an example to disassemble a selftest bpf program
> bpf_iter_tcp4.o:
>
> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf]
> llvm-objdump -D bpf_iter_tcp4.o >& ~/log
> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf] grep
> "Disassembly of section" ~/log
> Disassembly of section .strtab:
> Disassembly of section iter/tcp:
> Disassembly of section .reliter/tcp:
> Disassembly of section license:
> Disassembly of section .rodata:
> Disassembly of section .debug_loc:
> Disassembly of section .debug_abbrev:
> Disassembly of section .debug_info:
> Disassembly of section .rel.debug_info:
> Disassembly of section .debug_ranges:
> Disassembly of section .debug_str:
> Disassembly of section .BTF:
> Disassembly of section .rel.BTF:
> Disassembly of section .BTF.ext:
> Disassembly of section .rel.BTF.ext:
> Disassembly of section .debug_frame:
> Disassembly of section .rel.debug_frame:
> Disassembly of section .debug_line:
> Disassembly of section .rel.debug_line:
> Disassembly of section .llvm_addrsig:
> Disassembly of section .symtab:
> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf]
> llvm-objdump -d bpf_iter_tcp4.o >& ~/log
> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf] grep
> "Disassembly of section" ~/log
> Disassembly of section iter/tcp:
> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf]
>
> You can see, "-D" tries to disassemble *all* sections and "-d" only
> tries to disassemble "iter/tcp" section which is the *text* section.
>
> I suspect llvm BPF backend may have some loose end which didn't handle
> well for illegal insn, which I will put up a task so we can fix it.
>
> I guess you tries to disassemble for non-text sections because you want
> to compare contents of sections with text file? If this is the case,
> you may want to compare section data directly, because disassemble
> illegal insn will result in "<unknown>" insn which may hide the
> actual data difference. In any case, it would be good to know what you
> try to do with "-D" result so we may discuss to find a proper solution.
>

Yonghong, thank you for the detail explanation, it is me not clear
about the usage of
llvm-objdump, should have read the manual or try different argument
before this post,
thought better reporting the crash dump than doing nothing :)

Vincent


> >
> > PLEASE submit a bug report to https://bugs.llvm.org/  and include the
> > crash backtrace.
> >
> > Stack dump:
> >
> > 0. Program arguments: llvm-objdump -S -D /var/run/cilium/state/2799/bpf_lxc.o
> >
> >   #0 0x00000000006336bc llvm::sys::PrintStackTrace(llvm::raw_ostream&,
> > int) (/usr/local/bin/llvm-objdump+0x6336bc)
> >
> >   #1 0x00000000006318a4 llvm::sys::RunSignalHandlers()
> > (/usr/local/bin/llvm-objdump+0x6318a4)
> >
> >   #2 0x0000000000631efd SignalHandler(int) (/usr/local/bin/llvm-objdump+0x631efd)
> >
> >   #3 0x00007f9f39a7fb20 __restore_rt (/lib64/libpthread.so.0+0x12b20)
> >
> >   #4 0x0000000000492e8b
> > llvm::BPFInstPrinter::printMemOperand(llvm::MCInst const*, int,
> > llvm::raw_ostream&, char const*)
> > (/usr/local/bin/llvm-objdump+0x492e8b)
> >
> >   #5 0x00000000004946c0 llvm::BPFInstPrinter::printInst(llvm::MCInst
> > const*, unsigned long, llvm::StringRef, llvm::MCSubtargetInfo const&,
> > llvm::raw_ostream&) (/usr/local/bin/llvm-objdump+0x4946c0)
> >
> >   #6 0x0000000000432351 (anonymous
> > namespace)::BPFPrettyPrinter::printInst(llvm::MCInstPrinter&,
> > llvm::MCInst const*, llvm::ArrayRef<unsigned char>,
> > llvm::object::SectionedAddress, llvm::formatted_raw_ostream&,
> > llvm::StringRef, llvm::MCSubtargetInfo const&, (anonymous
> > namespace)::SourcePrinter*, llvm::StringRef,
> > std::vector<llvm::object::RelocationRef,
> > std::allocator<llvm::object::RelocationRef> >*, (anonymous
> > namespace)::LiveVariablePrinter&)
> > (/usr/local/bin/llvm-objdump+0x432351)
> >
> >   #7 0x00000000004400b8 disassembleObject(llvm::Target const*,
> > llvm::object::ObjectFile const*, llvm::MCContext&,
> > llvm::MCDisassembler*, llvm::MCDisassembler*, llvm::MCInstrAnalysis
> > const*, llvm::MCInstPrinter*, llvm::MCSubtargetInfo const*,
> > llvm::MCSubtargetInfo const*, (anonymous namespace)::PrettyPrinter&,
> > (anonymous namespace)::SourcePrinter&, bool)
> > (/usr/local/bin/llvm-objdump+0x4400b8)
> >
> >   #8 0x000000000044444e disassembleObject(llvm::object::ObjectFile
> > const*, bool) (/usr/local/bin/llvm-objdump+0x44444e)
> >
> >   #9 0x00000000004454e2 dumpObject(llvm::object::ObjectFile*,
> > llvm::object::Archive const*, llvm::object::Archive::Child const*)
> > (/usr/local/bin/llvm-objdump+0x4454e2)
> >
> > #10 0x0000000000409910 main (/usr/local/bin/llvm-objdump+0x409910)
> >
> > #11 0x00007f9f3854c493 __libc_start_main (/lib64/libc.so.6+0x23493)
> >
> > #12 0x000000000042384e _start (/usr/local/bin/llvm-objdump+0x42384e)
> >
> > Segmentation fault (core dumped)
> >
> > I compiled and installed llvm and clang 12.0.1 myself
> >
