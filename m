Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76F3B3646
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 10:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfIPIOk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 04:14:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:43652 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfIPIOk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 04:14:40 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i9m9c-000889-6e; Mon, 16 Sep 2019 10:14:36 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i9m9b-000XT4-VQ; Mon, 16 Sep 2019 10:14:35 +0200
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add bpf-gcc support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20190912160543.66653-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b45776ba-1f5c-65b4-ca27-d4f4b4c706b0@iogearbox.net>
Date:   Mon, 16 Sep 2019 10:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190912160543.66653-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25573/Sun Sep 15 10:22:02 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/12/19 6:05 PM, Ilya Leoshkevich wrote:
> Now that binutils and gcc support for BPF is upstream, make use of it in
> BPF selftests using alu32-like approach. Share as much as possible of
> CFLAGS calculation with clang.
> 
> Fixes only obvious issues, leaving more complex ones for later:
> - Use gcc-provided bpf-helpers.h instead of manually defining the
>    helpers, change bpf_helpers.h include guard to avoid conflict.
> - Include <linux/stddef.h> for __always_inline.
> - Add $(OUTPUT)/../usr/include to include path in order to use local
>    kernel headers instead of system kernel headers when building with O=.
> 
> In order to activate the bpf-gcc support, one needs to configure
> binutils and gcc with --target=bpf and make them available in $PATH. In
> particular, gcc must be installed as `bpf-gcc`, which is the default.
> 
> Right now with binutils 25a2915e8dba and gcc r275589 only a handful of
> tests work:
> 
> 	# ./test_progs_bpf_gcc
> 	# Summary: 7/39 PASSED, 1 SKIPPED, 98 FAILED
> 
> The reason for those failures are as follows:
> 
> - Build errors:
>    - `error: too many function arguments for eBPF` for __always_inline
>      functions read_str_var and read_map_var - must be inlining issue,
>      and for process_l3_headers_v6, which relies on optimizing away
>      function arguments.
>    - `error: indirect call in function, which are not supported by eBPF`
>      where there are no obvious indirect calls in the source calls, e.g.
>      in __encap_ipip_none.
>    - `error: field 'lock' has incomplete type` for fields of `struct
>      bpf_spin_lock` type - bpf_spin_lock is re#defined by bpf-helpers.h,
>      so its usage is sensitive to order of #includes.
>    - `error: eBPF stack limit exceeded` in sysctl_tcp_mem.
> - Load errors:
>    - Missing object files due to above build errors.
>    - `libbpf: failed to create map (name: 'test_ver.bss')`.
>    - `libbpf: object file doesn't contain bpf program`.
>    - `libbpf: Program '.text' contains unrecognized relo data pointing to
>      section 0`.
>    - `libbpf: BTF is required, but is missing or corrupted` - no BTF
>      support in gcc yet.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> v1->v2: Use bpf-helpers.h, fix a few obvious compatibility problems.

I think it's a good starting point unblocking Jose and others to run the BPF test
suite against bpf-gcc. Longer term we might want to do further refactoring to really
cleanly split llvm vs gcc dependency, and compare test results back to back to make
sure it's consistent behavior. Anyway, applied, thanks!
