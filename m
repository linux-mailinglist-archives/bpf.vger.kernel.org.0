Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4B16A0A67
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 14:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjBWNWi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 08:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjBWNWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 08:22:37 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1855071
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 05:22:34 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PMtt735s8z16NsB;
        Thu, 23 Feb 2023 21:19:59 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 23 Feb 2023 21:22:29 +0800
Subject: Re: [PATCH v3] blk-ioprio: Introduce promote-to-rt policy
To:     Hou Tao <houtao@huaweicloud.com>, <bpf@vger.kernel.org>
CC:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        David Vernet <void@manifault.com>
References: <20230223134852.3745349-1-houtao@huaweicloud.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <5916b106-b4f2-6a0e-4cb9-a60238d85a52@huawei.com>
Date:   Thu, 23 Feb 2023 21:22:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230223134852.3745349-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Please disregard the patch. I should send it to block mail list instead of bpf
mail list. Sorry for the noise.

On 2/23/2023 9:48 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Since commit a78418e6a04c ("block: Always initialize bio IO priority on
> submit"), bio->bi_ioprio will never be IOPRIO_CLASS_NONE when calling
> blkcg_set_ioprio(), so there will be no way to promote the io-priority
> of one cgroup to IOPRIO_CLASS_RT, because bi_ioprio will always be
> greater than or equals to IOPRIO_CLASS_RT.
>
> It seems possible to call blkcg_set_ioprio() first then try to
> initialize bi_ioprio later in bio_set_ioprio(), but this doesn't work
> for bio in which bi_ioprio is already initialized (e.g., direct-io), so
> introduce a new promote-to-rt policy to promote the iopriority of bio to
> IOPRIO_CLASS_RT if the ioprio is not already RT.
>
> For none-to-rt policy, although it doesn't work now, but considering
> that its purpose was also to override the io-priority to RT and allowing
> for a smoother transition, just keep it and treat it as an alias of
> the promote-to-rt policy.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> v3:
>  * Use 'non-RT' instead of 'no-RT' in document (from Bagas)
>  * Remove repeated sentence in commit message
>  * Add Reviewed-by and Acked-by tags
>  
> v2: https://lore.kernel.org/linux-block/20230220135428.2632906-1-houtao@huaweicloud.com
>
>  * Simplify the implementation of promote-to-rt (from Bart)
>  * Make none-to-rt to work again by treating it as an alias of
>    the promote-to-rt policy (from Bart & Jan)
>  * fix the style of new content in cgroup-v2.rst (from Bagas)
>  * set the default priority level to 4 instead of 0 for promote-to-rt
>
> v1: https://lore.kernel.org/linux-block/20230201045227.2203123-1-houtao@huaweicloud.com
>
>  Documentation/admin-guide/cgroup-v2.rst | 42 ++++++++++++++-----------
>  block/blk-ioprio.c                      | 23 ++++++++++++--
>  2 files changed, 44 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index f67c0829350b..7544ce00e0cb 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2024,31 +2024,33 @@ that attribute:
>    no-change
>  	Do not modify the I/O priority class.
>  
> -  none-to-rt
> -	For requests that do not have an I/O priority class (NONE),
> -	change the I/O priority class into RT. Do not modify
> -	the I/O priority class of other requests.
> +  promote-to-rt
> +	For requests that have a non-RT I/O priority class, change it into RT.
> +	Also change the priority level of these requests to 4. Do not modify
> +	the I/O priority of requests that have priority class RT.
>  
>    restrict-to-be
>  	For requests that do not have an I/O priority class or that have I/O
> -	priority class RT, change it into BE. Do not modify the I/O priority
> -	class of requests that have priority class IDLE.
> +	priority class RT, change it into BE. Also change the priority level
> +	of these requests to 0. Do not modify the I/O priority class of
> +	requests that have priority class IDLE.
>  
>    idle
>  	Change the I/O priority class of all requests into IDLE, the lowest
>  	I/O priority class.
>  
> +  none-to-rt
> +	Deprecated. Just an alias for promote-to-rt.
> +
>  The following numerical values are associated with the I/O priority policies:
>  
> -+-------------+---+
> -| no-change   | 0 |
> -+-------------+---+
> -| none-to-rt  | 1 |
> -+-------------+---+
> -| rt-to-be    | 2 |
> -+-------------+---+
> -| all-to-idle | 3 |
> -+-------------+---+
> ++----------------+---+
> +| no-change      | 0 |
> ++----------------+---+
> +| rt-to-be       | 2 |
> ++----------------+---+
> +| all-to-idle    | 3 |
> ++----------------+---+
>  
>  The numerical value that corresponds to each I/O priority class is as follows:
>  
> @@ -2064,9 +2066,13 @@ The numerical value that corresponds to each I/O priority class is as follows:
>  
>  The algorithm to set the I/O priority class for a request is as follows:
>  
> -- Translate the I/O priority class policy into a number.
> -- Change the request I/O priority class into the maximum of the I/O priority
> -  class policy number and the numerical I/O priority class.
> +- If I/O priority class policy is promote-to-rt, change the request I/O
> +  priority class to IOPRIO_CLASS_RT and change the request I/O priority
> +  level to 4.
> +- If I/O priorityt class is not promote-to-rt, translate the I/O priority
> +  class policy into a number, then change the request I/O priority class
> +  into the maximum of the I/O priority class policy number and the numerical
> +  I/O priority class.
>  
>  PID
>  ---
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index 055529b9b92b..4051fada01f1 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -23,25 +23,28 @@
>  /**
>   * enum prio_policy - I/O priority class policy.
>   * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
> - * @POLICY_NONE_TO_RT: modify IOPRIO_CLASS_NONE into IOPRIO_CLASS_RT.
> + * @POLICY_PROMOTE_TO_RT: modify no-IOPRIO_CLASS_RT to IOPRIO_CLASS_RT.
>   * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
>   *		IOPRIO_CLASS_BE.
>   * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
> + * @POLICY_NONE_TO_RT: an alias for POLICY_PROMOTE_TO_RT.
>   *
>   * See also <linux/ioprio.h>.
>   */
>  enum prio_policy {
>  	POLICY_NO_CHANGE	= 0,
> -	POLICY_NONE_TO_RT	= 1,
> +	POLICY_PROMOTE_TO_RT	= 1,
>  	POLICY_RESTRICT_TO_BE	= 2,
>  	POLICY_ALL_TO_IDLE	= 3,
> +	POLICY_NONE_TO_RT	= 4,
>  };
>  
>  static const char *policy_name[] = {
>  	[POLICY_NO_CHANGE]	= "no-change",
> -	[POLICY_NONE_TO_RT]	= "none-to-rt",
> +	[POLICY_PROMOTE_TO_RT]	= "promote-to-rt",
>  	[POLICY_RESTRICT_TO_BE]	= "restrict-to-be",
>  	[POLICY_ALL_TO_IDLE]	= "idle",
> +	[POLICY_NONE_TO_RT]	= "none-to-rt",
>  };
>  
>  static struct blkcg_policy ioprio_policy;
> @@ -189,6 +192,20 @@ void blkcg_set_ioprio(struct bio *bio)
>  	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
>  		return;
>  
> +	if (blkcg->prio_policy == POLICY_PROMOTE_TO_RT ||
> +	    blkcg->prio_policy == POLICY_NONE_TO_RT) {
> +		/*
> +		 * For RT threads, the default priority level is 4 because
> +		 * task_nice is 0. By promoting non-RT io-priority to RT-class
> +		 * and default level 4, those requests that are already
> +		 * RT-class but need a higher io-priority can use ioprio_set()
> +		 * to achieve this.
> +		 */
> +		if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) != IOPRIO_CLASS_RT)
> +			bio->bi_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 4);
> +		return;
> +	}
> +
>  	/*
>  	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
>  	 * correspond to a lower priority. Hence, the max_t() below selects

