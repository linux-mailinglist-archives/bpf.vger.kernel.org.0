Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A83A4B13
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 01:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhFKXQK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 19:16:10 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:44647 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFKXQK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 19:16:10 -0400
Received: by mail-yb1-f171.google.com with SMTP id p184so6497751yba.11
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 16:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fFeEZs9RJpJzP8TaMIEvygbFCwIoWQ5SN9Bk0JBQT0=;
        b=onIWaRDskuHfMYBkfB2vSkyXH9MIcOLKscSEtTwip+sAo/v+fbjEnBHyxH5laMIeNB
         YeXbFM6J+PugO8WkJRiJZNoBre/alVX+9q+ej02GoS4zCJ+BcEq7LYcA8aB3dMpmDDuD
         bCc/Cy1uZhM196rjxl+lTQhf+nuI9bo9S2h6Sihv4+jVSSs1tDmjz06D3SPr7M4FJAeB
         FyWXEhgG6yXlIWkceiS/fez5IaZ8ZvJP9SQ5/3q2Zkxqisd1TTzrCkmVqsnLS8pMilKD
         kYkr9dhttKqsO1JDuGRdE6XVuYRQbknVAp3l5LBJht1x0oK8x/GNKgc+2aITj/J0stSD
         0eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fFeEZs9RJpJzP8TaMIEvygbFCwIoWQ5SN9Bk0JBQT0=;
        b=BV2qK4auZXFZh41o/E2ovOljhRL/N4zPvA+Tzj810MqoC9mR2LEt2YlPbxYmEPLIDr
         buBOZhpERZJfnQ36Ul8QXH2grrNTnRteZkt7/4d7GJejhDBc47en116HwwilxN/xN5Jc
         Pd/cFfJFVq7iYAbGI7hEQJpy5kxmRVXcYgBujleLaS/u3DiT7sNmNOpm74tphj9F0HcF
         k5FeV4yZx9HugmUcm5OPUwm60pu+Gnab8B7rR2C2nu90iEKQXO0XhKUe3s++4a6jdlQx
         MqUL6kkupWdZAR/569NlY2XaTX1RvtsbJD7ghTNrn4zEIVaO8Hsy22TyyVFmAxco/80R
         CvEw==
X-Gm-Message-State: AOAM532RA1U8kv+ayIVaPZ6OAQ+kyheD/v2Sg0gM/7cubJNF54Jm9Wr0
        yMjmzPixQHF48LM+io8HkekGgAEMNk7z9x5DimHcpzPBblzg/A==
X-Google-Smtp-Source: ABdhPJz9OI/9BsMu2+mhNee/k++bpBlxzfxriiZPwmPTNLUUb9xrb8OKarZVOjiTM9IVmduUIdPbTy3G/xQnHkIvCcw=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr8851919ybr.425.1623453191509;
 Fri, 11 Jun 2021 16:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHb-xatSY=uJQw3XSFeg2_ctd05du0p-V-1YGDKhwW4voDZ11A@mail.gmail.com>
In-Reply-To: <CAHb-xatSY=uJQw3XSFeg2_ctd05du0p-V-1YGDKhwW4voDZ11A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Jun 2021 16:13:00 -0700
Message-ID: <CAEf4Bzbi86xsZQkigT3JMJH0L0DXQP2WZZdK9PUFKADYvdHDYQ@mail.gmail.com>
Subject: Re: Running libbpf + CO-RE in old kernels
To:     rainkin <rainkin1993@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 11, 2021 at 12:49 AM rainkin <rainkin1993@gmail.com> wrote:
>
> Hi,
>
> I try to run libbpf + CO-RE in old kernels (i.e., 4.19 here).
> I follow the discussion in this thread
> https://lore.kernel.org/bpf/CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com/
> and successfully run a binary which compiled in kernel v5.8 in old kernel 4.19.
>
> Basically, I just compile the linux kernel 4.19 source code and run
> pahole -J to generate a vmlinux containing .BTF sections.
> Then I copy this vmlinux file in kernel v4.19 /boot/vmlinux-xxx where
> libbpf will search vmlinux.

You've probably also seen the discussion in that thread to make such
use case better supported through libbpf API directly without you
needing to put that vmlinux BTF in a special place. If you have such
use case, please consider contributing necessary fixes. Thanks!

> Finally, I run the eBPF compiled binary and it works perfectly (I can
> get all the data I want).
>
> However, I find some error message shown by libbpf
> e.g.,
> libbpf: Error loading BTF: Invalid argument(22)
> libbpf: magic: 0xeb9f
> ...
> [10] Invalid btf_info:840000ad
> libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.
>
> Although such errors do not prevent the binary running and the binary
> works well, I still wonder what such errors mean.
> Welcome any suggestions.
>
> The following is the complete logs:
>
> libbpf: loading object 'minimal_bpf' from buffer
> libbpf: elf: section(2) raw_tp/sched_process_exec, size 280, link 0,
> flags 6, type=1
> libbpf: sec 'raw_tp/sched_process_exec': found program
> 'handle_sched_process_exec' at insn offset 0 (0 bytes), code size 35
> insns (280 bytes)
> libbpf: elf: section(3) license, size 13, link 0, flags 3, type=1
> libbpf: license of minimal_bpf is Dual BSD/GPL
> libbpf: elf: section(4) .rodata.str1.1, size 16, link 0, flags 32, type=1
> libbpf: elf: skipping unrecognized data section(4) .rodata.str1.1
> libbpf: elf: section(5) .BTF, size 23717, link 0, flags 0, type=1
> libbpf: elf: section(6) .BTF.ext, size 364, link 0, flags 0, type=1
> libbpf: elf: section(7) .symtab, size 96, link 11, flags 0, type=2
> libbpf: looking for externs among 4 symbols...
> libbpf: collected 0 externs total
> libbpf: loading kernel BTF '/boot/vmlinux-4.19.0-041900-generic': 0
> libbpf: Error loading BTF: Invalid argument(22)
> libbpf: magic: 0xeb9f
> version: 1
> flags: 0x0
> hdr_len: 24
> type_off: 0
> type_len: 14212
> str_off: 14212
> str_len: 9481
> btf_total_size: 23717
> [1] PTR (anon) type_id=2
> [2] STRUCT bpf_raw_tracepoint_args size=0 vlen=1
> args type_id=5 bits_offset=0
> [3] TYPEDEF __u64 type_id=4
> [4] INT long long unsigned int size=8 bits_offset=0 nr_bits=64 encoding=(none)
> [5] ARRAY (anon) type_id=3 index_type_id=6 nr_elems=0
> [6] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [7] ENUM (anon) size=4 vlen=1
> ctx val=1
> [8] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [9] TYPEDEF handle_sched_process_exec type_id=7
> [10] Invalid btf_info:840000ad
> libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.

it's a STRUCT with kflag set to 1, which means that it has bitfields
with encoded bit offset and bit size in offset field. libbpf doesn't
detect and sanitize such cases. But this error is just a warning and
it doesn't influence correctness, so you can ignore that. But if you'd
like to avoid this, take a look at what would it take to sanitize such
cases. If it's not too gross and complicated, we can teach libbpf to
do it automatically.


[...]
