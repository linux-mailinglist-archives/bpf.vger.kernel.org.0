Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4525A56D5
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 00:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiH2WMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2WMM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 18:12:12 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0152D7D78B
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:12:10 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmzJ-000BdG-0b; Tue, 30 Aug 2022 00:12:09 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmzI-000Exf-R6; Tue, 30 Aug 2022 00:12:08 +0200
Subject: Re: [PATCH bpf-next v3 6/7] selftests/bpf: Add struct argument tests
 with fentry/fexit programs.
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com
References: <20220828025438.142798-1-yhs@fb.com>
 <20220828025509.145209-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7cf3de93-ae20-3d76-20d9-67242a65408b@iogearbox.net>
Date:   Tue, 30 Aug 2022 00:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220828025509.145209-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/28/22 4:55 AM, Yonghong Song wrote:
> Add various struct argument tests with fentry/fexit programs.
> Also add one test with a kernel func which does not have any
> argument to test BPF_PROG2 macro in such situation.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++++++
>   .../selftests/bpf/prog_tests/tracing_struct.c |  63 ++++++++++
>   .../selftests/bpf/progs/tracing_struct.c      | 114 ++++++++++++++++++
>   3 files changed, 225 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>   create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct.c
> 

For s390x these tests need to be deny-listed due to missing trampoline support..

   All error logs:
   test_fentry:PASS:tracing_struct__open_and_load 0 nsec
   libbpf: prog 'test_struct_arg_1': failed to attach: ERROR: strerror_r(-524)=22
   libbpf: prog 'test_struct_arg_1': failed to auto-attach: -524
   test_fentry:FAIL:tracing_struct__attach unexpected error: -524 (errno 524)
   #209     tracing_struct:FAIL
   Summary: 189/972 PASSED, 27 SKIPPED, 1 FAILED

However, looks like the no_alu32 ones on x86 fail:

   [...]
   #207     trace_printk:OK
   #208     trace_vprintk:OK
   test_fentry:PASS:tracing_struct__open_and_load 0 nsec
   test_fentry:PASS:tracing_struct__attach 0 nsec
   trigger_module_test_read:PASS:testmod_file_open 0 nsec
   test_fentry:PASS:trigger_read 0 nsec
   test_fentry:PASS:t1:a.a 0 nsec
   test_fentry:PASS:t1:a.b 0 nsec
   test_fentry:PASS:t1:b 0 nsec
   test_fentry:PASS:t1:c 0 nsec
   test_fentry:PASS:t1 nregs 0 nsec
   test_fentry:PASS:t1 reg0 0 nsec
   test_fentry:PASS:t1 reg1 0 nsec
   test_fentry:FAIL:t1 reg2 unexpected t1 reg2: actual 7327499336969879553 != expected 1
   test_fentry:PASS:t1 reg3 0 nsec
   test_fentry:PASS:t1 ret 0 nsec
   test_fentry:PASS:t2:a 0 nsec
   test_fentry:PASS:t2:b.a 0 nsec
   test_fentry:PASS:t2:b.b 0 nsec
   test_fentry:PASS:t2:c 0 nsec
   test_fentry:PASS:t2 ret 0 nsec
   test_fentry:PASS:t3:a 0 nsec
   test_fentry:PASS:t3:b 0 nsec
   test_fentry:PASS:t3:c.a 0 nsec
   test_fentry:PASS:t3:c.b 0 nsec
   test_fentry:PASS:t3 ret 0 nsec
   test_fentry:PASS:t4:a.a 0 nsec
   test_fentry:PASS:t4:b 0 nsec
   test_fentry:PASS:t4:c 0 nsec
   test_fentry:PASS:t4:d 0 nsec
   test_fentry:PASS:t4:e.a 0 nsec
   test_fentry:PASS:t4:e.b 0 nsec
   test_fentry:PASS:t4 ret 0 nsec
   test_fentry:PASS:t5 ret 0 nsec
   #209     tracing_struct:FAIL
   #210     trampoline_count:OK
   [...]
