Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE714102B6
	for <lists+bpf@lfdr.de>; Sat, 18 Sep 2021 03:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhIRBf7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 21:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhIRBf7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 21:35:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92135C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 18:34:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg28so13555007edb.1
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 18:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ixQFwDISudLOsDinycaJ9+lDV1YjNSdipvWTNkBmR8c=;
        b=D3DLxr83ghoJMK6JkdVafEU0E0hkIN0DcyqgAD2Q3/sSISe7Ed8zaaK6kurQUPWbI4
         oMLODTpmJgVKx5t15YOaO9VdC9bNTZ+xh1K+2mhnjIGMTg4fhkljz4v/JRYXLo7unxE9
         Opn/9fx4ARzlr3joLpmK60SvF3wkwO9mefpo3OHmC0DX9wCtI1OkzHwtv0g/hUU4fIJT
         YyaJHJVRJ1+76DJUY1K21h09QbTjmfLapj5+YMveHu6y/t0sg/YoF2BoaAXbdZO+w0ff
         yHyz962+ntfZqYZXKFBkF0SYj+Dpiq9EG8k6NExsIKP+74NplOx8/AEXL6uB14w+/LQ/
         OWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ixQFwDISudLOsDinycaJ9+lDV1YjNSdipvWTNkBmR8c=;
        b=5g1fdPHRE5w3rg1gmuh0tCQfik6DG+iMHpWaf7GxB/sNqXVba07KVN2RdHfj5dKb1v
         JjiA9kaCInl4m+asOg36aqZOyzeaJp5kXmecMLYpEJAqeIjQqISNR0VfCJzo/aHIFcx+
         ogfDuyTvuOryHDN7gY1HPNiHBArZmrRicn/PCFWVxWdOYHOGOK8mRSo/7Gy4rkCwBRtV
         uESsCDl7d2FyHVC4pkDM9wGjwb/OLPooqHArhVt92uJxpmv2jqSTsxNEhH/er4YHZVkR
         6VYrLOtRRIzpxcDpjRm7GcL5SsL4GiYidw4jJ1PCI9YKpJHifown8FUOo0AfM/qVONOb
         ZLoQ==
X-Gm-Message-State: AOAM533anKZZDkp2juSUNZ2eHIpv8x+Y/Li1I/x00caanZduHBhp/4Km
        jEOe2y9gFnQS6mYf7avJ5mnfaWbxEmcXv1LYnhZrSv/ArIg=
X-Google-Smtp-Source: ABdhPJwTsV28VrxnWlQbYK7HR9WI+aokjYkrWUc+WLhDAPCAAn757EK1WFjFHf7TgJOsOZkTubl9cmiK0CYQ2c8Uf5o=
X-Received: by 2002:a50:e004:: with SMTP id e4mr16211827edl.164.1631928874911;
 Fri, 17 Sep 2021 18:34:34 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Fri, 17 Sep 2021 18:34:23 -0700
Message-ID: <CAK3+h2wW-tWOT+VBOc8QjRcbhMX3dCpsvE9if4VOA8s7R2icjg@mail.gmail.com>
Subject: llvm-objdump bpf coredump
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I am supposed to file a bug report in https://bugs.llvm.org/ but the
site requires account login, while waiting for my account setup, and
since this is related to BPF, I will try my luck here :)

This is cilium environment, when I use llvm-objdump to disassemble the
bpf_lxc.o like below, it core dumps

#llvm-objdump -S -D  /var/run/cilium/state/2799/bpf_lxc.o >
/home/bpf_lxc-5.4.txt

PLEASE submit a bug report to https://bugs.llvm.org/ and include the
crash backtrace.

Stack dump:

0. Program arguments: llvm-objdump -S -D /var/run/cilium/state/2799/bpf_lxc.o

 #0 0x00000000006336bc llvm::sys::PrintStackTrace(llvm::raw_ostream&,
int) (/usr/local/bin/llvm-objdump+0x6336bc)

 #1 0x00000000006318a4 llvm::sys::RunSignalHandlers()
(/usr/local/bin/llvm-objdump+0x6318a4)

 #2 0x0000000000631efd SignalHandler(int) (/usr/local/bin/llvm-objdump+0x631efd)

 #3 0x00007f9f39a7fb20 __restore_rt (/lib64/libpthread.so.0+0x12b20)

 #4 0x0000000000492e8b
llvm::BPFInstPrinter::printMemOperand(llvm::MCInst const*, int,
llvm::raw_ostream&, char const*)
(/usr/local/bin/llvm-objdump+0x492e8b)

 #5 0x00000000004946c0 llvm::BPFInstPrinter::printInst(llvm::MCInst
const*, unsigned long, llvm::StringRef, llvm::MCSubtargetInfo const&,
llvm::raw_ostream&) (/usr/local/bin/llvm-objdump+0x4946c0)

 #6 0x0000000000432351 (anonymous
namespace)::BPFPrettyPrinter::printInst(llvm::MCInstPrinter&,
llvm::MCInst const*, llvm::ArrayRef<unsigned char>,
llvm::object::SectionedAddress, llvm::formatted_raw_ostream&,
llvm::StringRef, llvm::MCSubtargetInfo const&, (anonymous
namespace)::SourcePrinter*, llvm::StringRef,
std::vector<llvm::object::RelocationRef,
std::allocator<llvm::object::RelocationRef> >*, (anonymous
namespace)::LiveVariablePrinter&)
(/usr/local/bin/llvm-objdump+0x432351)

 #7 0x00000000004400b8 disassembleObject(llvm::Target const*,
llvm::object::ObjectFile const*, llvm::MCContext&,
llvm::MCDisassembler*, llvm::MCDisassembler*, llvm::MCInstrAnalysis
const*, llvm::MCInstPrinter*, llvm::MCSubtargetInfo const*,
llvm::MCSubtargetInfo const*, (anonymous namespace)::PrettyPrinter&,
(anonymous namespace)::SourcePrinter&, bool)
(/usr/local/bin/llvm-objdump+0x4400b8)

 #8 0x000000000044444e disassembleObject(llvm::object::ObjectFile
const*, bool) (/usr/local/bin/llvm-objdump+0x44444e)

 #9 0x00000000004454e2 dumpObject(llvm::object::ObjectFile*,
llvm::object::Archive const*, llvm::object::Archive::Child const*)
(/usr/local/bin/llvm-objdump+0x4454e2)

#10 0x0000000000409910 main (/usr/local/bin/llvm-objdump+0x409910)

#11 0x00007f9f3854c493 __libc_start_main (/lib64/libc.so.6+0x23493)

#12 0x000000000042384e _start (/usr/local/bin/llvm-objdump+0x42384e)

Segmentation fault (core dumped)

I compiled and installed llvm and clang 12.0.1 myself
