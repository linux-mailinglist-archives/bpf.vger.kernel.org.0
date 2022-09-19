Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9445BD4B8
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 20:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiISSZx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 14:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiISSZw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 14:25:52 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE9DDEAA
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 11:25:51 -0700 (PDT)
Message-ID: <3797ccec-6fe1-acc9-02f0-2f5ee0e8b7d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663611949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMWa2Q/VwcVhnSlyv8sedeSVoPde3nc1GqSsJhJIxog=;
        b=aZUon3bK14pY39AU99djGBrOdGJJCGNJdDGTcreieyfX0kiFwb0ZPG6OGBHbrBmuWkcp3Z
        9L2tQ3CPu/vcN2PxgLtoWBSSL0zcV/4Jn9iRpad5+LFeuop5blQILcZ5F0IrFScdt6uGte
        M3GHmLCnrf3a1x4Me+ma4rjDhwHdvY0=
Date:   Mon, 19 Sep 2022 11:25:42 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test result messages for
 test_task_storage_map_stress_lookup
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com,
        bpf@vger.kernel.org
References: <20220919035714.2195144-1-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20220919035714.2195144-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/18/22 8:57 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Add test result message when test_task_storage_map_stress_lookup()
> succeeds or is skipped. The test case can be skipped due to the choose
> of preemption model in kernel config, so export skips in test_maps.c and
> increase it when needed.
> 
> The following is the output of test_maps when the test case succeeds or
> is skipped:
> 
>    test_task_storage_map_stress_lookup:PASS
>    test_maps: OK, 0 SKIPPED
> 
>    test_task_storage_map_stress_lookup SKIP (no CONFIG_PREEMPT)
>    test_maps: OK, 1 SKIPPED
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Applied with a Fixes tag,
Fixes: 73b97bc78b32 ("selftests/bpf: ......

Please remember to add it next time for fixes.

Also, ...


> ---
>   tools/testing/selftests/bpf/map_tests/task_storage_map.c | 6 +++++-
>   tools/testing/selftests/bpf/test_maps.c                  | 2 +-
>   tools/testing/selftests/bpf/test_maps.h                  | 2 ++
>   3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
> index 1adc9c292eb2..aac08c85240b 100644
> --- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
> +++ b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
> @@ -77,8 +77,11 @@ void test_task_storage_map_stress_lookup(void)
>   	CHECK(err, "open_and_load", "error %d\n", err);
>   
>   	/* Only for a fully preemptible kernel */
> -	if (!skel->kconfig->CONFIG_PREEMPT)
> +	if (!skel->kconfig->CONFIG_PREEMPT) {
> +		printf("%s SKIP (no CONFIG_PREEMPT)\n", __func__);
> +		skips++;

I noticed it is missing a read_bpf_task_storage_busy__destroy() here. 
Please fix.

