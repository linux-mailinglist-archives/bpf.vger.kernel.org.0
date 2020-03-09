Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95D717ECA8
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 00:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgCIX3t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 19:29:49 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:44954 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgCIX3s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 19:29:48 -0400
Received: by mail-qk1-f169.google.com with SMTP id f198so11025167qke.11
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dmsqdq+N9uKlrxjutqakGp20IHk1agEKP8A2ZFVPPdw=;
        b=iXwpewjl2oBCJ/19fKYYs92ghCXJd1TZudLtwR9coKkwF7U47T1v6ky/1lrxkVXbHl
         7ag3IMz+gmrf215wHA41YPKmIWbSnVFUGbL0zAnQ3ZM9uyqbQM2yRl6qWEOWkS7wDBZ+
         ojaIX2/2EePr+Bvp88O4wBrJR4h92YuQHVVcwfmf1/Ou33GLkwSvtqi8KiU8kYnvtUt1
         DHHpW5EznzQ/XMSWaqs/kb9N6WBCBdH8/iEQd9k3wgal8BuHqJNrIfFCwHI6Q9N8op/M
         G6VNH3kfP7tbNpLNmdV7xwEFVZXYaA4ZTZEgK4oeDby/6VFjXz82FTXHIzd+iHI8YoyQ
         v7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dmsqdq+N9uKlrxjutqakGp20IHk1agEKP8A2ZFVPPdw=;
        b=T5SBKLql/vqNyEW9zIdZgYRjOTPp5num18nfcT7k9ILXAv7l2L1qbZjFIrhVDkYSiY
         rL+dhJr6+SAwavLKTvA006+y3/J4WeTb1NlkFGadeOpBvqD0DGLIufDMv418uxXmhTHP
         3BMMYemmIebIfwMfI3lZx0n5LuyTG98V1tXUFu+AJoyMxm5LpR4VwoK60XY6+bBErchB
         OscHSVJPnMgPhxWD1HHN7iAYIQh7znos7oR2qTwBhpyA20F7iL0A2kCLZlrkoQKpUZxG
         gS44hYZAOKLNsc24IoQ2izkT4Z/AnslLjtrXQk9pDadSiTqVozbcd4oFol9lGt4Oap47
         iDfw==
X-Gm-Message-State: ANhLgQ14vf71geWl6nzzXdVcRQPEpFQ2PacJlA44PSnGmoQDmMAnbDKF
        ggq7W5/TeakW4o6a1E4hGQcoMJx8PS6EwRUzEHEF2f11
X-Google-Smtp-Source: ADFU+vvTNCtD4iSS9vshN2poCb0ls3qGQbX05UACHBXs8s7GSMJcwXUg2n3xEslVd5GtCN7e4RaK2SLaamIWh0ZJzo8=
X-Received: by 2002:ae9:c011:: with SMTP id u17mr15629709qkk.92.1583796586595;
 Mon, 09 Mar 2020 16:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAKRbtyVJ2bq5Tafmyd-Juo7Tu2yneLUdbPJ7w13c5wvJih9bBQ@mail.gmail.com>
In-Reply-To: <CAKRbtyVJ2bq5Tafmyd-Juo7Tu2yneLUdbPJ7w13c5wvJih9bBQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Mar 2020 16:29:35 -0700
Message-ID: <CAEf4BzYe0WS-aixmxp06reoQoEmFms_wkyxR_bYN3+_gPYMS-g@mail.gmail.com>
Subject: Re: LIBBPF Bugs
To:     eric@regit.org
Cc:     bpf <bpf@vger.kernel.org>, Benjamin Nilsen <bcnilsen@ucdavis.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 6, 2020 at 1:50 AM Benjamin Nilsen <bcnilsen@ucdavis.edu> wrote:
>
> Hello,
>
> Here is a follow up to the previous email with a more in-depth look at the bugs.  I should have some more in the following days that detail the bugs found earlier and some new ones as well.
>
> Attached is a C class and some binary files to trigger the corresponding bugs.
> (These methods may be called in an unconventional way as I designed it with a fuzzer in mind).
>
> The terminal output should be useful in tracing the bug.
>
> To run, compile C program and run: ./executable id:000000
>
>
> Regards,
> Ben
>

Thanks Benjamin!

Eric, you seem to have done most work on netlink-related parts of
libbpf. Do you mind taking a look at these bug reports?

> Bug 1: error with libbpf_nla_dump_errormsg()
> The binary file: "id:000000" causes this crash.
>
> From terminal:
>
> Calling libbpf_nla_dump_errormsg
>
>
> Value of nla_len = 13619
>
> AddressSanitizer:DEADLYSIGNAL
>
> =================================================================
>
> ==28356==ERROR: AddressSanitizer: stack-overflow on address 0x7ffe555d74c0 (pc 0x55f1f9765b38 bp 0x7f20ebfb6c24 sp 0x7ffe555d3da0 T0)
>
>     #0 0x55f1f9765b37 in nla_ok /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c
>
>     #1 0x55f1f9765b37 in libbpf_nla_parse /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:112
>
>     #2 0x55f1f97674df in libbpf_nla_dump_errormsg /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:183:6
>
>     #3 0x55f1f9767c82 in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:249:1
>
>     #4 0x7f20eabddb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
>     #5 0x55f1f96332d9 in _start (/home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.fast+0x272d9)
>
>
> SUMMARY: AddressSanitizer: stack-overflow /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c in nla_ok
>
> ==28356==ABORTING
>
>
>
>
>
>
>
> Bug 2: error with libbpf_nla_parse_nested()
>
> The binary file "id:000001" causes this crash.
>
>
> From Terminal:
>
> libbpf_nla_parse_nested
>
> =================================================================
>
> ==51153==ERROR: AddressSanitizer: negative-size-param: (size=-2952410560)
>
>     #0 0x563779c9bdf1 in __asan_memset /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cc:27:3
>
>     #1 0x563779d274ea in libbpf_nla_parse /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:110:2
>
>     #2 0x563779d29d2a in libbpf_nla_parse_nested /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:153:9
>
>     #3 0x563779d29d2a in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:253
>
>     #4 0x7f85e283fb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
>     #5 0x563779bf52d9 in _start (/home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.fast+0x272d9)
>
>
> Address 0x7ffe120ab478 is located in stack of thread T0 at offset 56 in frame
>
>
>
>
> Bug 3: error with libbpf_nla_dump_errormsg()
> The binary file "id:000003" causes this crash.
>
> From Terminal:
>
> Calling libbpf_nla_dump_errormsg
>
>
> AddressSanitizer:DEADLYSIGNAL
>
> =================================================================
>
> ==31841==ERROR: AddressSanitizer: SEGV on unknown address 0x7ffe6a8e1e51 (pc 0x55e81517d505 bp 0x7ffe083b3e80 sp 0x7ffe083b3dc0 T0)
>
> ==31841==The signal is caused by a READ memory access.
>
>     #0 0x55e81517d504 in nla_ok /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c
>
>     #1 0x55e81517d504 in libbpf_nla_parse /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:112
>
>     #2 0x55e81517f4df in libbpf_nla_dump_errormsg /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:183:6
>
>     #3 0x55e81517fc82 in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:249:1
>
>     #4 0x7f887b165b96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
>     #5 0x55e81504b2d9 in _start (/home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.fast+0x272d9)
>
>
> AddressSanitizer can not provide additional info.
>
> SUMMARY: AddressSanitizer: SEGV /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c in nla_ok
>
> ==31841==ABORTING
>
>
>
>
> Bug 4: error with libbpf_nla_parse_nested()
> The binary file "id:000004" causes this crash.
>
> From Terminal:
>
> Calling libbpf_nla_dump_errormsg
>
>
> Value of nla_len = 1
>
> Kernel error message: (null)
>
> libbpf_nla_parse_nested
>
> =================================================================
>
> ==5753==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fffb86702f8 at pc 0x55f5e071fedf bp 0x7fffb8670230 sp 0x7fffb866f9e0
>
> WRITE of size 206576 at 0x7fffb86702f8 thread T0
>
>     #0 0x55f5e071fede in __asan_memset /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cc:27:3
>
>     #1 0x55f5e07ab4ea in libbpf_nla_parse /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:110:2
>
>     #2 0x55f5e07add2a in libbpf_nla_parse_nested /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:153:9
>
>     #3 0x55f5e07add2a in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:253
>
>     #4 0x7f634d278b96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
>     #5 0x55f5e06792d9 in _start (/home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.fast+0x272d9)
>
>
> Address 0x7fffb86702f8 is located in stack of thread T0 at offset 88 in frame
>
>     #0 0x55f5e07ad9ff in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:200
>
>
>   This frame has 1 object(s):
>
>     [32, 88) 'pta' (line 219) <== Memory access at offset 88 overflows this variable
>
> HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
>
>       (longjmp and C++ exceptions *are* supported)
>
> SUMMARY: AddressSanitizer: stack-buffer-overflow /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cc:27:3 in __asan_memset
>
> Shadow bytes around the buggy address:
>
>   0x1000770c6000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>   0x1000770c6010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>   0x1000770c6020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>   0x1000770c6030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>   0x1000770c6040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> =>0x1000770c6050: 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 00 00[f3]
>
>   0x1000770c6060: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>
>   0x1000770c6070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>   0x1000770c6080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>   0x1000770c6090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>   0x1000770c60a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>
>
>
>
>
> Bug 5:
> The binary file "id:000006" causes this crash.
>
> From Terminal:
>
> Calling libbpf_nla_dump_errormsg
>
>
> Value of nla_len = 64
>
> Value of nla_len = 32765
>
> Attribute of type 0 found multiple times in message, previous attribute is being ignored.
>
> AddressSanitizer:DEADLYSIGNAL
>
> =================================================================
>
> ==55647==ERROR: AddressSanitizer: stack-overflow on address 0x7ffdf2ecd6cc (pc 0x55f55cc87b38 bp 0x7fc57936bc24 sp 0x7ffdf2ec54a0 T0)
>
>     #0 0x55f55cc87b37 in nla_ok /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c
>
>     #1 0x55f55cc87b37 in libbpf_nla_parse /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:112
>
>     #2 0x55f55cc894df in libbpf_nla_dump_errormsg /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:183:6
>
>     #3 0x55f55cc89c82 in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:249:1
>
>     #4 0x7fc577f92b96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
>     #5 0x55f55cb552d9 in _start (/home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.fast+0x272d9)
>
>
>
> Bug 6: error with libbpf_nla_parse()
> The binary file "id:000009" causes this crash.
>
> From Terminal:
>
> Calling libbpf_nla_dump_errormsg
>
>
> libbpf_nla_parse_nested
>
> Value of nla_len = 64052
>
> libbpf_nla_parse
>
> Value of nla_len = 13619
>
> AddressSanitizer:DEADLYSIGNAL
>
> =================================================================
>
> ==45753==ERROR: AddressSanitizer: stack-overflow on address 0x7ffd12cc54fe (pc 0x556d02baeb38 bp 0x7f80f4a19c24 sp 0x7ffd12cc1f20 T0)
>
>     #0 0x556d02baeb37 in nla_ok /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c
>
>     #1 0x556d02baeb37 in libbpf_nla_parse /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:112
>
>     #2 0x556d02bb0da9 in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:257:1
>
>     #3 0x7f80f3640b96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
>     #4 0x556d02a7c2d9 in _start (/home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.fast+0x272d9)
>
>
>
> Bug 7:
>
> The binary file "id:000014" causes this crash.
>
>
> From Terminal:
>
> Calling libbpf_nla_dump_errormsg
>
>
> Value of nla_len = 51253
>
> Kernel error message: (null)
>
> libbpf_nla_parse_nested
>
> =================================================================
>
> ==56762==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffd9f8521b8 at pc 0x55585aa85edf bp 0x7ffd9f8520f0 sp 0x7ffd9f8518a0
>
> WRITE of size 224 at 0x7ffd9f8521b8 thread T0
>
>     #0 0x55585aa85ede in __asan_memset /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cc:27:3
>
>     #1 0x55585ab114ea in libbpf_nla_parse /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:110:2
>
>     #2 0x55585ab13d2a in libbpf_nla_parse_nested /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:153:9
>
>     #3 0x55585ab13d2a in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:253
>
>     #4 0x7f5b104b9b96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
>     #5 0x55585a9df2d9 in _start (/home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.fast+0x272d9)
>
>
> Address 0x7ffd9f8521b8 is located in stack of thread T0 at offset 88 in frame
>
>     #0 0x55585ab139ff in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:200
>
>
>   This frame has 1 object(s):
>
>     [32, 88) 'pta' (line 219) <== Memory access at offset 88 overflows this variable
>
>
>
>
> Bug 8: Error with validate_nla
> The binary file "id:000019" causes this crash.
>
> From Terminal:
>
> Calling libbpf_nla_dump_errormsg
>
>
> Value of nla_len = 0
>
> Kernel error message: (null)
>
> libbpf_nla_parse_nested
>
> Value of nla_len = 54375
>
> libbpf_nla_parse
>
> Value of nla_len = 2758
>
> Value of nla_len = 0
>
> validate_nla
>
> AddressSanitizer:DEADLYSIGNAL
>
> =================================================================
>
> ==16614==ERROR: AddressSanitizer: stack-overflow on address 0x7ffddbaa8ac2 (pc 0x55af14a70660 bp 0x7fee9b192c24 sp 0x7ffddba98c70 T0)
>
>     #0 0x55af14a7065f in validate_nla /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:57:10
>
>     #1 0x55af14a71dfb in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:261:1
>
>     #2 0x7fee99db9b96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
>     #3 0x55af1493d2d9 in _start (/home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.fast+0x272d9)
>
>
> SUMMARY: AddressSanitizer: stack-overflow /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:57:10 in validate_nla
>
> ==16614==ABORTING
>
>
>
> Bug 9:
>
> The binary file "id:000023" causes this crash.
>
> From Terminal:
>
> Calling libbpf_nla_dump_errormsg
>
>
> Value of nla_len = 1519
>
> Value of nla_len = 0
>
> Kernel error message:
>
> libbpf_nla_parse_nested
>
> =================================================================
>
> ==78237==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffed48f3398 at pc 0x55e8e9a61edf bp 0x7ffed48f32d0 sp 0x7ffed48f2a80
>
> WRITE of size 30033832 at 0x7ffed48f3398 thread T0
>
>     #0 0x55e8e9a61ede in __asan_memset /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cc:27:3
>
>     #1 0x55e8e9aed4ea in libbpf_nla_parse /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:110:2
>
>     #2 0x55e8e9aefd2a in libbpf_nla_parse_nested /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:153:9
>
>     #3 0x55e8e9aefd2a in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:253
>
>     #4 0x7f593cf0eb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
>     #5 0x55e8e99bb2d9 in _start (/home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.fast+0x272d9)
>
>
> Address 0x7ffed48f3398 is located in stack of thread T0 at offset 88 in frame
>
>     #0 0x55e8e9aef9ff in main /home/bcnilsen/bcc/src/cc/libbpf/srcRemote/nlattrFuzz.c:200
>
>
>   This frame has 1 object(s):
>
>     [32, 88) 'pta' (line 219) <== Memory access at offset 88 overflows this variable
>
>
>
>
>
