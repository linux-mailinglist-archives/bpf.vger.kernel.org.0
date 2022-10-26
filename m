Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4D60D9FA
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 05:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiJZDgM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 23:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiJZDfq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 23:35:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092BA8E713
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 20:35:22 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MxvTH6Xk4z15M2g;
        Wed, 26 Oct 2022 11:30:27 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 11:35:19 +0800
Subject: Re: [PATCH bpf-next] bpf: Update max_entries for array maps
To:     Florian Lehner <dev@der-flo.net>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
References: <20221025092843.81572-1-dev@der-flo.net>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <e250349c-cd3c-ac2e-f0fd-da083aa87ceb@huawei.com>
Date:   Wed, 26 Oct 2022 11:35:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221025092843.81572-1-dev@der-flo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/25/2022 5:28 PM, Florian Lehner wrote:
> To improve memory handling and alignment max_entries is rounded up
> before using its value to allocate memory.
> This can lead to a situation where more memory is allocated than usable
> if max_entries is no adjusted accordingly. So this change updates
> max_entries in order to make the allocated memory available.
>
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>  kernel/bpf/arraymap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 832b2659e96e..9411fa255ccc 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -145,6 +145,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
>  	/* copy mandatory map attributes */
>  	bpf_map_init_from_attr(&array->map, attr);
>  	array->elem_size = elem_size;
> +	array->map.max_entries = max_entries;
>  
>  	if (percpu && bpf_array_alloc_percpu(array)) {
>  		bpf_map_area_free(array);
The override of max_entries is unnecessary and is also wrong.
bpf_array_alloc_percpu() will use array->map.max_entries to allocate per-cpu
value, and if using the rounded-up max_entries, there will be memory waste
because the extra allocated per-cpu values should not be accessible to bpf
program or user-space program.

