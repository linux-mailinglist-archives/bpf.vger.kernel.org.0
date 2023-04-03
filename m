Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07E26D5543
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 01:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjDCXo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 19:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjDCXo0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 19:44:26 -0400
Received: from out-22.mta0.migadu.com (out-22.mta0.migadu.com [IPv6:2001:41d0:1004:224b::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C712E2D5A
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 16:44:18 -0700 (PDT)
Message-ID: <85e3a1d7-52e3-d2ec-fd28-f1769cf77969@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680565455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6LIEYi02jr+sinpN4GYe403wvdhtKtOEu2vvbacvUY=;
        b=nifBvUD6iZQxRdL/H0LgTl9TTnYy9PJQda6XIeGkvFm1DMb7YmKfaK3K5tqO5TsRhQVGPx
        s90F8OL5neguhtpOFekJlmirfjjAhnSmPbYKdaXyVizA33IOG+B+LFo+37eTvzDzHVhP1n
        sSGRqGwas5vsddo0Vmwr7hNY4q9vKp4=
Date:   Mon, 3 Apr 2023 16:44:11 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: Poll for receive in cg_storage_multi
 test
Content-Language: en-US
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
References: <20230403215834.26675-1-zhuyifei@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230403215834.26675-1-zhuyifei@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/3/23 2:58 PM, YiFei Zhu wrote:
> In some cases the loopback latency might be large enough, causing
> the assertion on invocations to be run before ingress prog getting
> executed. The assertion would fail and the test would flake.
> 
> This can be reliably reproduced by arbitrarily increaing the loopback
> latency (thanks to [1]):
>    tc qdisc add dev lo root handle 1: htb default 12
>    tc class add dev lo parent 1:1 classid 1:12 htb rate 20kbps ceil 20kbps
>    tc qdisc add dev lo parent 1:12 netem delay 100ms
> 
> Fix this by polling on the receive end and waiting for up to a
> second, instead of instantly returning to the assert.
> 
> [1] https://gist.github.com/kstevens715/4598301
> 
> Reported-by: Martin KaFai Lau <martin.lau@linux.dev>
> Link: https://lore.kernel.org/bpf/9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev/
> Fixes: 3573f384014f ("selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>   .../testing/selftests/bpf/prog_tests/cg_storage_multi.c  | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> index 621c57222191..3b0094a2a353 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> @@ -7,6 +7,7 @@
>   #include <test_progs.h>
>   #include <cgroup_helpers.h>
>   #include <network_helpers.h>
> +#include <poll.h>
>   
>   #include "progs/cg_storage_multi.h"
>   
> @@ -56,8 +57,9 @@ static bool assert_storage_noexist(struct bpf_map *map, const void *key)
>   
>   static bool connect_send(const char *cgroup_path)
>   {
> -	bool res = true;
>   	int server_fd = -1, client_fd = -1;
> +	struct pollfd pollfd;
> +	bool res = true;
>   
>   	if (join_cgroup(cgroup_path))
>   		goto out_clean;
> @@ -73,6 +75,11 @@ static bool connect_send(const char *cgroup_path)
>   	if (send(client_fd, "message", strlen("message"), 0) < 0)
>   		goto out_clean;
>   
> +	pollfd.fd = server_fd;
> +	pollfd.events = POLLIN;
> +	if (poll(&pollfd, 1, 1000) != 1)
> +		goto out_clean;

Thanks for the fix. The slowness explanation makes sense.

A nit. All start_server() has a 3s SO_RCVTIMEO by default. How about a read() 
here instead of a poll(). Easier to change the default read timeout for all 
tests if needed.

