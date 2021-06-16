Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C523A95B1
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 11:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhFPJQZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 05:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFPJQZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 05:16:25 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6115C061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 02:14:19 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id h15so1984726ybm.13
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0PyYr2JlYgV+LRWomc11inO/CxpIexR5+XBNM7/dLI=;
        b=Qy6k6VmEmMwCVNaomjjcF2ripDMhwiSgwG4JKxhOHlgjWu/Tnm43hnQcJ4MJY52tp5
         iX3Mdza4uiN2uNZ/542PzQaC/jkbUrttUREPfZFISl155/30s0L0ffElOlB9wYlHDYlD
         pxmQMEULyihXMaqSeNgZoz6fz5Kcjgkq+980vWRH0g1FTApHRNRwbAfPtelulfjYXltx
         NpPah1u/3iuG3mGPZZAiktuzPL+PZox5AlFRUKiTVB1LJ8SPW+iAr/iw3W7NBLl4pTm4
         5l04vwnatJPgB0CpD+k4nsWfZLdfEkOhDfGWPNOsOM1m5Afo/DnDMml0K2iYNwpTS4fj
         TU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0PyYr2JlYgV+LRWomc11inO/CxpIexR5+XBNM7/dLI=;
        b=Xqdvv1A+tpac/uICmvUBNpeGMyhTBXNtowuGJx9vfK5Ke6BEWaUQfDza3+056ZUMRP
         lMOeWxQn6oG/if5RACs6K6KNrhguTLpYlPGZXSdPJDIN3Els/Sh6bpyVM3kAEBm8oLcX
         fLKA1dxU8rJE57o82PUdkPs/ZhsV+ds0tLN+XtPahsMhr5Vl4J9ki4i8ICEUnJrnu7Qf
         wOK2i8SiURCz1o8GubbpPzi3TekZP5urdWPyzrnMKD0nrpSeBZmdUyvv+Q8fnTDZ601K
         pRKX67v6pTo6qbm8N3uMevw+YEBonl2wmKbSMeZq0QdB6ZB8pj9cW7Wxg+9TZjvVR7KB
         4V0g==
X-Gm-Message-State: AOAM531T2v5lCIQKQSKRv0P/tn1928sFZqw7SnB/Wv5S9aS/OS5s3W0U
        RBqr2BePziVEqTVq62GsCU+p0VnPw6sDwzissC8=
X-Google-Smtp-Source: ABdhPJxXE4dHhk/OfVS96La4o9MMEDSHfl1KZhTBCJsNNEL6fc2xMWCuLxQ/1aAiLqIHpEjAy5+0sL29dMzHtMBFXyc=
X-Received: by 2002:a25:4182:: with SMTP id o124mr4806452yba.27.1623834859009;
 Wed, 16 Jun 2021 02:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHb-xatSY=uJQw3XSFeg2_ctd05du0p-V-1YGDKhwW4voDZ11A@mail.gmail.com>
 <CAEf4Bzbi86xsZQkigT3JMJH0L0DXQP2WZZdK9PUFKADYvdHDYQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzbi86xsZQkigT3JMJH0L0DXQP2WZZdK9PUFKADYvdHDYQ@mail.gmail.com>
From:   rainkin <rainkin1993@gmail.com>
Date:   Wed, 16 Jun 2021 17:13:43 +0800
Message-ID: <CAHb-xaurgV1ukr4OMNQM1DVPXN5Gavd8qvYmVpus74uG+mKyxw@mail.gmail.com>
Subject: Re: Running libbpf + CO-RE in old kernels
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
> On Fri, Jun 11, 2021 at 12:49 AM rainkin <rainkin1993@gmail.com> wrote:
> >
> > Hi,
> >
> > I try to run libbpf + CO-RE in old kernels (i.e., 4.19 here).
> > I follow the discussion in this thread
> > https://lore.kernel.org/bpf/CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com/
> > and successfully run a binary which compiled in kernel v5.8 in old kernel 4.19.
> >
> > Basically, I just compile the linux kernel 4.19 source code and run
> > pahole -J to generate a vmlinux containing .BTF sections.
> > Then I copy this vmlinux file in kernel v4.19 /boot/vmlinux-xxx where
> > libbpf will search vmlinux.
>
> You've probably also seen the discussion in that thread to make such
> use case better supported through libbpf API directly without you
> needing to put that vmlinux BTF in a special place. If you have such
> use case, please consider contributing necessary fixes. Thanks!
>
> > Finally, I run the eBPF compiled binary and it works perfectly (I can
> > get all the data I want).
> >
> > However, I find some error message shown by libbpf
> > e.g.,
> > libbpf: Error loading BTF: Invalid argument(22)
> > libbpf: magic: 0xeb9f
> > ...
> > [10] Invalid btf_info:840000ad
> > libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.
> >
> > Although such errors do not prevent the binary running and the binary
> > works well, I still wonder what such errors mean.
> > Welcome any suggestions.
> >
> > The following is the complete logs:
> >
> > libbpf: loading object 'minimal_bpf' from buffer
> > libbpf: elf: section(2) raw_tp/sched_process_exec, size 280, link 0,
> > flags 6, type=1
> > libbpf: sec 'raw_tp/sched_process_exec': found program
> > 'handle_sched_process_exec' at insn offset 0 (0 bytes), code size 35
> > insns (280 bytes)
> > libbpf: elf: section(3) license, size 13, link 0, flags 3, type=1
> > libbpf: license of minimal_bpf is Dual BSD/GPL
> > libbpf: elf: section(4) .rodata.str1.1, size 16, link 0, flags 32, type=1
> > libbpf: elf: skipping unrecognized data section(4) .rodata.str1.1
> > libbpf: elf: section(5) .BTF, size 23717, link 0, flags 0, type=1
> > libbpf: elf: section(6) .BTF.ext, size 364, link 0, flags 0, type=1
> > libbpf: elf: section(7) .symtab, size 96, link 11, flags 0, type=2
> > libbpf: looking for externs among 4 symbols...
> > libbpf: collected 0 externs total
> > libbpf: loading kernel BTF '/boot/vmlinux-4.19.0-041900-generic': 0
> > libbpf: Error loading BTF: Invalid argument(22)
> > libbpf: magic: 0xeb9f
> > version: 1
> > flags: 0x0
> > hdr_len: 24
> > type_off: 0
> > type_len: 14212
> > str_off: 14212
> > str_len: 9481
> > btf_total_size: 23717
> > [1] PTR (anon) type_id=2
> > [2] STRUCT bpf_raw_tracepoint_args size=0 vlen=1
> > args type_id=5 bits_offset=0
> > [3] TYPEDEF __u64 type_id=4
> > [4] INT long long unsigned int size=8 bits_offset=0 nr_bits=64 encoding=(none)
> > [5] ARRAY (anon) type_id=3 index_type_id=6 nr_elems=0
> > [6] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
> > [7] ENUM (anon) size=4 vlen=1
> > ctx val=1
> > [8] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > [9] TYPEDEF handle_sched_process_exec type_id=7
> > [10] Invalid btf_info:840000ad
> > libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.
>
> it's a STRUCT with kflag set to 1, which means that it has bitfields
> with encoded bit offset and bit size in offset field. libbpf doesn't
> detect and sanitize such cases. But this error is just a warning and
> it doesn't influence correctness, so you can ignore that. But if you'd
> like to avoid this, take a look at what would it take to sanitize such
> cases. If it's not too gross and complicated, we can teach libbpf to
> do it automatically.
>
>
> [...]

Thanks! I will take a look and fix it if possible.
Rainkin
