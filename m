Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAE25BF97A
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiIUIix (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 04:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiIUIiw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 04:38:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5885FB1
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 01:38:50 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXWtT731fzlW0D;
        Wed, 21 Sep 2022 16:34:41 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:38:48 +0800
Subject: Re: [PATCH v7 bpf-next 1/4] bpf: Export 'bpf_dynptr_get_data,
 bpf_dynptr_get_size' helpers
To:     Shmulik Ladkani <shmulik@metanetworks.com>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
 <20220911122328.306188-2-shmulik.ladkani@gmail.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <0c606d51-685d-9874-7155-c21d2fe06320@huawei.com>
Date:   Wed, 21 Sep 2022 16:38:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220911122328.306188-2-shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/11/2022 8:23 PM, Shmulik Ladkani wrote:
> This allows kernel code dealing with dynptrs obtain dynptr's available
> size and current (w. proper offset) data pointer.
>
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
SNIP
> +
> +static inline void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr)
> +{
> +	return ptr->data ? ptr->data + ptr->offset : NULL;
> +}
Have one dummy question here. Is ptr->data == NULL is possible ? According to
the function prototype of bpf_dynptr_from_mem(), data can not be NULL. And IMO
in order to simplify the usage of bpf_dynptr_kernel, we need to ensure ptr->data
should be not NULL, else will need to add a NULL checking for every access of
bpf_dynptr_kernel in kernel.
>  
>  #ifdef CONFIG_BPF_LSM
>  void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fc08035f14ed..824864ac82d1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1408,7 +1408,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
>  	ptr->size |= type << DYNPTR_TYPE_SHIFT;
>  }
>  
> -static u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
> +u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
>  {
>  	return ptr->size & DYNPTR_SIZE_MASK;
>  }

