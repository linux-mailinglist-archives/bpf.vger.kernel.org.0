Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84498196812
	for <lists+bpf@lfdr.de>; Sat, 28 Mar 2020 18:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgC1RSo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Mar 2020 13:18:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:59694 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RSo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 13:18:44 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jIF6V-0003Gg-PG; Sat, 28 Mar 2020 18:18:39 +0100
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jIF6V-000AXW-CO; Sat, 28 Mar 2020 18:18:39 +0100
Subject: Re: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200327192854.31150-1-kpsingh@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
Date:   Sat, 28 Mar 2020 18:18:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200327192854.31150-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25765/Sat Mar 28 14:16:42 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey KP,

On 3/27/20 8:28 PM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> # v7 -> v8
> 
>    https://lore.kernel.org/bpf/20200326142823.26277-1-kpsingh@chromium.org/
> 
> * Removed CAP_MAC_ADMIN check from bpf_lsm_verify_prog. LSMs can add it
>    in their own bpf_prog hook. This can be revisited as a separate patch.
> * Added Andrii and James' Ack/Review tags.
> * Fixed an indentation issue and missing newlines in selftest error
>    a cases.
> * Updated a comment as suggested by Alexei.
> * Updated the documentation to use the newer libbpf API and some other
>    fixes.
> * Rebase
> 
> # v6 -> v7
> 
>    https://lore.kernel.org/bpf/20200325152629.6904-1-kpsingh@chromium.org/
> 
[...]
> KP Singh (8):
>    bpf: Introduce BPF_PROG_TYPE_LSM
>    security: Refactor declaration of LSM hooks
>    bpf: lsm: provide attachment points for BPF LSM programs
>    bpf: lsm: Implement attach, detach and execution
>    bpf: lsm: Initialize the BPF LSM hooks
>    tools/libbpf: Add support for BPF_PROG_TYPE_LSM
>    bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
>    bpf: lsm: Add Documentation

I was about to apply, but then I'm getting the following selftest issue on
the added LSM one, ptal:

# ./test_progs
[...]
#65/1 test_global_func1.o:OK
#65/2 test_global_func2.o:OK
#65/3 test_global_func3.o:OK
#65/4 test_global_func4.o:OK
#65/5 test_global_func5.o:OK
#65/6 test_global_func6.o:OK
#65/7 test_global_func7.o:OK
#65 test_global_funcs:OK
test_test_lsm:PASS:skel_load 0 nsec
test_test_lsm:PASS:attach 0 nsec
test_test_lsm:PASS:exec_cmd 0 nsec
test_test_lsm:FAIL:bprm_count bprm_count = 0
test_test_lsm:FAIL:heap_mprotect want errno=EPERM, got 22
#66 test_lsm:FAIL
test_test_overhead:PASS:obj_open_file 0 nsec
test_test_overhead:PASS:find_probe 0 nsec
test_test_overhead:PASS:find_probe 0 nsec
test_test_overhead:PASS:find_probe 0 nsec
test_test_overhead:PASS:find_probe 0 nsec
test_test_overhead:PASS:find_probe 0 nsec
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x31)[0x56100f25eb51]
/lib/x86_64-linux-gnu/libpthread.so.0(+0x12890)[0x7f9d8d225890]
/lib/x86_64-linux-gnu/libc.so.6(+0x18ef2d)[0x7f9d8cfb0f2d]
/lib/x86_64-linux-gnu/libc.so.6(__libc_calloc+0x372)[0x7f9d8cebc3a2]
/usr/local/lib/libelf.so.1(+0x33ce)[0x7f9d8d85a3ce]
/usr/local/lib/libelf.so.1(+0x3fb2)[0x7f9d8d85afb2]
./test_progs(btf__parse_elf+0x15d)[0x56100f27a141]
./test_progs(libbpf_find_kernel_btf+0x169)[0x56100f27ee83]
./test_progs(+0x43906)[0x56100f266906]
./test_progs(bpf_object__load_xattr+0xe5)[0x56100f26e93c]
./test_progs(bpf_object__load+0x47)[0x56100f26eafd]
./test_progs(test_test_overhead+0x252)[0x56100f24a922]
./test_progs(main+0x212)[0x56100f22f772]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f9d8ce43b97]
./test_progs(_start+0x2a)[0x56100f22f8fa]
Segmentation fault (core dumped)
#

(Before the series, it runs through fine on my side.)

Thanks,
Daniel
