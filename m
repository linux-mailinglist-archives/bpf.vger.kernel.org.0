Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8398158E19B
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiHIVOx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 17:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiHIVO2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 17:14:28 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E661D67;
        Tue,  9 Aug 2022 14:14:23 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLWYP-000Ffb-PU; Tue, 09 Aug 2022 23:14:21 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLWYP-000A9a-Hx; Tue, 09 Aug 2022 23:14:21 +0200
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add connmark read test
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, memxor@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <cover.1660062725.git.dxu@dxuuu.xyz>
 <6436220efacfa99f343ffc451e3d5dc8b7f31f05.1660062725.git.dxu@dxuuu.xyz>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <37649bee-5eb3-93a2-ac57-56eb375ef8cd@iogearbox.net>
Date:   Tue, 9 Aug 2022 23:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6436220efacfa99f343ffc451e3d5dc8b7f31f05.1660062725.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26622/Tue Aug  9 09:53:52 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On 8/9/22 6:34 PM, Daniel Xu wrote:
> Test that the prog can read from the connection mark. This test is nice
> because it ensures progs can interact with netfilter subsystem
> correctly.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_nf.c | 3 ++-
>   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 3 +++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> index 317978cac029..7232f6dcd252 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> @@ -44,7 +44,7 @@ static int connect_to_server(int srv_fd)
>   
>   static void test_bpf_nf_ct(int mode)
>   {
> -	const char *iptables = "iptables -t raw %s PREROUTING -j CT";
> +	const char *iptables = "iptables -t raw %s PREROUTING -j CONNMARK --set-mark 42/0";
>   	int srv_fd = -1, client_fd = -1, srv_client_fd = -1;
>   	struct sockaddr_in peer_addr = {};
>   	struct test_bpf_nf *skel;
> @@ -114,6 +114,7 @@ static void test_bpf_nf_ct(int mode)
>   	/* expected status is IPS_SEEN_REPLY */
>   	ASSERT_EQ(skel->bss->test_status, 2, "Test for ct status update ");
>   	ASSERT_EQ(skel->data->test_exist_lookup, 0, "Test existing connection lookup");
> +	ASSERT_EQ(skel->bss->test_exist_lookup_mark, 43, "Test existing connection lookup ctmark");
>   end:
>   	if (srv_client_fd != -1)
>   		close(srv_client_fd);
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> index 84e0fd479794..2722441850cc 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -28,6 +28,7 @@ __be16 sport = 0;
>   __be32 daddr = 0;
>   __be16 dport = 0;
>   int test_exist_lookup = -ENOENT;
> +u32 test_exist_lookup_mark = 0;
>   
>   struct nf_conn;
>   
> @@ -174,6 +175,8 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>   		       sizeof(opts_def));
>   	if (ct) {
>   		test_exist_lookup = 0;
> +		if (ct->mark == 42)
> +			test_exist_lookup_mark = 43;

Looks like CI failed here:

   [...]
   progs/test_bpf_nf.c:178:11: error: no member named 'mark' in 'struct nf_conn'
                   if (ct->mark == 42)
                       ~~  ^
   1 error generated.
   make: *** [Makefile:521: /tmp/runner/work/bpf/bpf/tools/testing/selftests/bpf/test_bpf_nf.o] Error 1
   make: *** Waiting for unfinished jobs....
   Error: Process completed with exit code 2.

Likely due to missing CONFIG_NF_CONNTRACK_MARK for the CI instance.

>   		bpf_ct_release(ct);
>   	} else {
>   		test_exist_lookup = opts_def.error;
> 

