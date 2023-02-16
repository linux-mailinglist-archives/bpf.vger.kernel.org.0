Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896C0698A69
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 03:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBPCRD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 21:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPCRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 21:17:02 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89026274BA
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 18:17:00 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PHJNs6P70zFqSL;
        Thu, 16 Feb 2023 10:12:13 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 10:16:28 +0800
Subject: Re: [PATCH bpf-next] bpf: Only allocate one bpf_mem_cache for
 bpf_cpumask_ma
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
References: <20230216024134.2094999-1-houtao@huaweicloud.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <7736864d-af8d-4f74-086b-0ec125aae2a6@huawei.com>
Date:   Thu, 16 Feb 2023 10:16:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230216024134.2094999-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry, please disregard this patch. I forgot to fix the typo in it. Will resend.

On 2/16/2023 10:41 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> The size of bpf_cpumask is fixed, so there is no need to allocate many
> bpf_mem_caches for bpf_cpumask_ma, just one bpf_mem_cache is enough.
> Also add comments for bpf_mem_alloc_init() in bpf_mem_alloc.h to prevent
> future miuse.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/bpf_mem_alloc.h | 7 +++++++
>  kernel/bpf/cpumask.c          | 6 +++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
> index 3e164b8efaa9..a7104af61ab4 100644
> --- a/include/linux/bpf_mem_alloc.h
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -14,6 +14,13 @@ struct bpf_mem_alloc {
>  	struct work_struct work;
>  };
>  
> +/* 'size != 0' is for bpf_mem_alloc which manages fixed-size objects.
> + * Alloc and free are done with bpf_mem_cache_{alloc,free}().
> + *
> + * 'size = 0' is for bpf_mem_alloc which manages many fixed-size objects.
> + * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
> + * the returned object is given by the size argument of bpf_mem_alloc().
> + */
>  int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
>  void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
>  
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index 52b981512a35..711434b556fb 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -55,7 +55,7 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
>  	/* cpumask must be the first element so struct bpf_cpumask be cast to struct cpumask. */
>  	BUILD_BUG_ON(offsetof(struct bpf_cpumask, cpumask) != 0);
>  
> -	cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
> +	cpumask = bpf_mem_cache_alloc(&bpf_cpumask_ma);
>  	if (!cpumask)
>  		return NULL;
>  
> @@ -123,7 +123,7 @@ __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
>  
>  	if (refcount_dec_and_test(&cpumask->usage)) {
>  		migrate_disable();
> -		bpf_mem_free(&bpf_cpumask_ma, cpumask);
> +		bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
>  		migrate_enable();
>  	}
>  }
> @@ -468,7 +468,7 @@ static int __init cpumask_kfunc_init(void)
>  		},
>  	};
>  
> -	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, 0, false);
> +	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sieof(struct bpf_cpumask), false);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
>  	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,

