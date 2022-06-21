Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B88553855
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351476AbiFURAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352058AbiFURAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 13:00:40 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5622526ADD
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 10:00:39 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o3hEz-0009MA-8M; Tue, 21 Jun 2022 19:00:37 +0200
Received: from [2a02:168:f656:0:d16a:7287:ccf0:4fff] (helo=localhost.localdomain)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1o3hEz-000S10-2O; Tue, 21 Jun 2022 19:00:37 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix rare segfault in sock_fields
 prog test
To:     =?UTF-8?Q?J=c3=b6rn-Thorben_Hinz?= <jthinz@mailbox.tu-berlin.de>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
References: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6f2b2c24-22e8-9fbe-10d3-9347be3ac067@iogearbox.net>
Date:   Tue, 21 Jun 2022 19:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26579/Tue Jun 21 10:15:30 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/21/22 9:01 AM, Jörn-Thorben Hinz wrote:
> test_sock_fields__detach() got called with a null pointer here when one
> of the CHECKs or ASSERTs up to the test_sock_fields__open_and_load()
> call resulted in a jump to the "done" label.
> 
> A skeletons *__detach() is not safe to call with a null pointer, though.
> This led to a segfault.
> 
> Go the easy route and only call test_sock_fields__destroy() which is
> null-pointer safe and includes detaching.
> 
> Came across this while looking[1] to introduce the usage of
> bpf_tcp_helpers.h (included in progs/test_sock_fields.c) together with
> vmlinux.h.
> 
> [1] https://lore.kernel.org/bpf/629bc069dd807d7ac646f836e9dca28bbc1108e2.camel@mailbox.tu-berlin.de/
> 
> Fixes: 8f50f16ff39d ("selftests/bpf: Extend verifier and bpf_sock tests for dst_port loads")
> Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
> ---
>   tools/testing/selftests/bpf/prog_tests/sock_fields.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> index 9d211b5c22c4..7d23166c77af 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> @@ -394,7 +394,6 @@ void serial_test_sock_fields(void)
>   	test();
>   
>   done:
> -	test_sock_fields__detach(skel);
>   	test_sock_fields__destroy(skel);
>   	if (child_cg_fd >= 0)
>   		close(child_cg_fd);
> 

Great catch! I think we have similar detach & destroy pattern in a number
of places in selftests.

Should we rather just move the label, like:

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
index 9d211b5c22c4..e8a947241e37 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
@@ -393,8 +393,8 @@ void serial_test_sock_fields(void)

         test();

-done:
         test_sock_fields__detach(skel);
+done:
         test_sock_fields__destroy(skel);
         if (child_cg_fd >= 0)
                 close(child_cg_fd);
