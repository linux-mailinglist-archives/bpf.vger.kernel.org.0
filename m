Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27783F5BDC
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 00:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKHXhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 18:37:55 -0500
Received: from www62.your-server.de ([213.133.104.62]:58128 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHXhz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 18:37:55 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iTDp8-0002Zv-03; Sat, 09 Nov 2019 00:37:50 +0100
Received: from [178.197.248.27] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iTDp7-0007vU-Mo; Sat, 09 Nov 2019 00:37:49 +0100
Subject: Re: Fw: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures
 using eBPF JIT
To:     Wang YanQing <udknight@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
References: <20191108075711.115a5f94@hermes.lan>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <08b98fbd-f295-3a94-8b3e-70790179290c@iogearbox.net>
Date:   Sat, 9 Nov 2019 00:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191108075711.115a5f94@hermes.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25627/Fri Nov  8 11:02:39 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ Cc Wang (x86_32 BPF JIT maintainer) ]

On 11/8/19 4:57 PM, Stephen Hemminger wrote:
> 
> Begin forwarded message:
> 
> Date: Fri, 08 Nov 2019 07:35:59 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures using eBPF JIT
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=205469
> 
>              Bug ID: 205469
>             Summary: x86_32: bpf: multiple test_bpf failures using eBPF JIT
>             Product: Networking
>             Version: 2.5
>      Kernel Version: 4.19.81 LTS
>            Hardware: i386
>                  OS: Linux
>                Tree: Mainline
>              Status: NEW
>            Severity: normal
>            Priority: P1
>           Component: Other
>            Assignee: stephen@networkplumber.org
>            Reporter: itugrok@yahoo.com
>                  CC: itugrok@yahoo.com
>          Regression: No
> 
> Created attachment 285829
>    --> https://bugzilla.kernel.org/attachment.cgi?id=285829&action=edit
> test_bpf failures: kernel 4.19.81/x86_32 (OpenWrt)
> 
> Summary:
> ========
> 
> Running the 4.19.81 LTS kernel on QEMU/x86_32, the standard test_bpf.ko
> testsuite generates multiple errors with the eBPF JIT enabled:
> 
>    ...
>    test_bpf: #32 JSET jited:1 40 ret 0 != 20 46 FAIL
>    test_bpf: #321 LD_IND word positive offset jited:1 ret 0 != -291897430 FAIL
>    test_bpf: #322 LD_IND word negative offset jited:1 ret 0 != -1437222042 FAIL
>    test_bpf: #323 LD_IND word unaligned (addr & 3 == 2) jited:1 ret 0 !=
> -1150890889 FAIL
>    test_bpf: #326 LD_IND word positive offset, all ff jited:1 ret 0 != -1 FAIL
>    ...
>    test_bpf: Summary: 373 PASSED, 5 FAILED, [344/366 JIT'ed]
> 
> However, with eBPF JIT disabled (net.core.bpf_jit_enable=0) all tests pass.
> 
> 
> Steps to Reproduce:
> ===================
> 
>    # sysctl net.core.bpf_jit_enable=1
>    # modprobe test_bpf
>    <Kernel log with failures and test summary>
> 
> 
> Affected Systems Tested:
> ========================
> 
>    OpenWrt master on QEMU/pc-q35(x86_32) [LTS kernel 4.19.81]
> 
> 
> Kernel Logs:
> ============
> 
> Boot log with test results is attached.
> 

