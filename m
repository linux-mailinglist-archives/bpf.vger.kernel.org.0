Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEDD618DA6
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 02:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKDBaC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 21:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKDBaB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 21:30:01 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B2823E9B
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 18:30:00 -0700 (PDT)
Message-ID: <0dc6d45a-8e0c-46d6-511e-d15eebe684c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667525398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPRFuz4A7+bR6T+UBVLiNE8ztr+lCaN/0fIsw66qecA=;
        b=I1iGrPu4T5WjGLGiO4QONMUdKv41ScCvUYJmj8R37PsMynbQBVgrHfYYf3Q5xcepgHH8ij
        7wxl7Ci+WY8GV1KUOSZcCjoJ92T8yiDDf4q2cB8gS5oJuDk18axI7Fs0LaaTgrOOrxJ/WX
        MkxZ1yfp/dyXkArutCSGts3naMHZ6aU=
Date:   Thu, 3 Nov 2022 18:29:47 -0700
MIME-Version: 1.0
Subject: Re: [bpf-next 08/11] bpf/selftests: convert tcp_hdr_options test to
 ASSERT_* macros
Content-Language: en-US
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, delyank@fb.com, zhudi2@huawei.com,
        jakub@cloudflare.com, kuba@kernel.org, kuifeng@fb.com,
        deso@posteo.net, zhuyifei@google.com, hengqi.chen@gmail.com
References: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
 <1664169131-32405-9-git-send-email-wangyufen@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <1664169131-32405-9-git-send-email-wangyufen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/25/22 10:12 PM, Wang Yufen wrote:
> @@ -497,26 +481,20 @@ static void misc(void)
>   		/* MSG_EOR to ensure skb will not be combined */
>   		ret = send(sk_fds.active_fd, send_msg, sizeof(send_msg),
>   			   MSG_EOR);
> -		if (CHECK(ret != sizeof(send_msg), "send(msg)", "ret:%d\n",
> -			  ret))
> +		if (!ASSERT_EQ(ret, sizeof(send_msg), "send(msg)"))
>   			goto check_linum;
>   
>   		ret = read(sk_fds.passive_fd, recv_msg, sizeof(recv_msg));
> -		if (CHECK(ret != sizeof(send_msg), "read(msg)", "ret:%d\n",
> -			  ret))
> +		if (ASSERT_EQ(ret, sizeof(send_msg), "read(msg)"))

Thanks for the clean up.  However, this looks wrong...

>   			goto check_linum;
>   	}
>   
>   	if (sk_fds_shutdown(&sk_fds))
>   		goto check_linum;
>   
> -	CHECK(misc_skel->bss->nr_syn != 1, "unexpected nr_syn",
> -	      "expected (1) != actual (%u)\n",
> -		misc_skel->bss->nr_syn);
> +	ASSERT_EQ(misc_skel->bss->nr_syn, 1, "unexpected nr_syn");
>   
> -	CHECK(misc_skel->bss->nr_data != nr_data, "unexpected nr_data",
> -	      "expected (%u) != actual (%u)\n",
> -	      nr_data, misc_skel->bss->nr_data);
> +	ASSERT_EQ(misc_skel->bss->nr_data, nr_data, "unexpected nr_data");
>   
>   	/* The last ACK may have been delayed, so it is either 1 or 2. */
>   	CHECK(misc_skel->bss->nr_pure_ack != 1 &&
> @@ -525,12 +503,10 @@ static void misc(void)
>   	      "expected (1 or 2) != actual (%u)\n",
>   		misc_skel->bss->nr_pure_ack);
>   
> -	CHECK(misc_skel->bss->nr_fin != 1, "unexpected nr_fin",
> -	      "expected (1) != actual (%u)\n",
> -	      misc_skel->bss->nr_fin);
> +	ASSERT_EQ(misc_skel->bss->nr_fin, 1, "unexpected nr_fin");
>   
>   check_linum:
> -	CHECK_FAIL(check_error_linum(&sk_fds));
> +	ASSERT_FALSE(check_error_linum(&sk_fds), "check_error_linum");
>   	sk_fds_close(&sk_fds);
>   	bpf_link__destroy(link);
>   }
> @@ -555,15 +531,15 @@ void test_tcp_hdr_options(void)
>   	int i;
>   
>   	skel = test_tcp_hdr_options__open_and_load();
> -	if (CHECK(!skel, "open and load skel", "failed"))
> +	if (!ASSERT_OK_PTR(skel, "open and load skel"))
>   		return;
>   
>   	misc_skel = test_misc_tcp_hdr_options__open_and_load();
> -	if (CHECK(!misc_skel, "open and load misc test skel", "failed"))
> +	if (!ASSERT_OK_PTR(misc_skel, "open and load misc test skel"))
>   		goto skel_destroy;
>   
>   	cg_fd = test__join_cgroup(CG_NAME);
> -	if (CHECK_FAIL(cg_fd < 0))
> +	if (ASSERT_GE(cg_fd, 0, "join_cgroup"))

...and at least this one also.  Have your tested it?

Here is some quick checks that will be useful.

Before this patch:
#> ./test_progs -t tcp_hdr_options
#197/1   tcp_hdr_options/simple_estab:OK
#197/2   tcp_hdr_options/no_exprm_estab:OK
#197/3   tcp_hdr_options/syncookie_estab:OK
#197/4   tcp_hdr_options/fastopen_estab:OK
#197/5   tcp_hdr_options/fin:OK
#197/6   tcp_hdr_options/misc:OK
#197     tcp_hdr_options:OK
Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED

#> ./test_progs -v -t tcp_hdr_options |& egrep PASS | wc -l
123

After this patch:
#> ./test_progs -t tcp_hdr_options
#197     tcp_hdr_options:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

#> ./test_progs -v -t tcp_hdr_options |& egrep PASS | wc -l
4

Please check all the changes in this set.
