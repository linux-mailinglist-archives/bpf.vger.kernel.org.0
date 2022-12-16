Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C5264E93D
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLPKPX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 05:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiLPKPW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 05:15:22 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8512631
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 02:15:21 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NYQ1k49swz16LfQ;
        Fri, 16 Dec 2022 18:14:18 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 18:15:18 +0800
Subject: Re: [bpf-next 1/2] bpf: hash map, avoid deadlock with suitable hash
 mask
To:     <xiangxia.m.yue@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <2e2dc326-69ad-1228-c425-357dcdb6bfcd@huawei.com>
Date:   Fri, 16 Dec 2022 18:15:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 12/14/2022 6:38 PM, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>
> The deadlock still may occur while accessed in NMI and non-NMI
> context. Because in NMI, we still may access the same bucket but with
> different map_locked index.
>
> For example, on the same CPU, .max_entries = 2, we update the hash map,
> with key = 4, while running bpf prog in NMI nmi_handle(), to update
> hash map with key = 20, so it will have the same bucket index but have
> different map_locked index.
>
> To fix this issue, using min mask to hash again.
>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/hashtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 5aa2b5525f79..8b25036a8690 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -152,7 +152,7 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>  {
>  	unsigned long flags;
>  
> -	hash = hash & HASHTAB_MAP_LOCK_MASK;
> +	hash = hash & min(HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
There is warning for kernel test robot and it seems that min_t(...) is required
here.

Otherwise, this patch looks good to me, so:

Acked-by: Hou Tao <houtao1@huawei.com>
>  
>  	preempt_disable();
>  	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
> @@ -171,7 +171,7 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>  				      struct bucket *b, u32 hash,
>  				      unsigned long flags)
>  {
> -	hash = hash & HASHTAB_MAP_LOCK_MASK;
> +	hash = hash & min(HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
>  	raw_spin_unlock_irqrestore(&b->raw_lock, flags);
>  	__this_cpu_dec(*(htab->map_locked[hash]));
>  	preempt_enable();

