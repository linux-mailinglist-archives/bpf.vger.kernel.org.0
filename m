Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1166251F0
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 04:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiKKDxX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 22:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKKDxW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 22:53:22 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A809267F41
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 19:53:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u6so3250165plq.12
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 19:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSURtCN1UggPbkBn4QxhZJcNzyV2Z+XMSNo4/7DrXvA=;
        b=ToVFlZr0h2iO5+oEArTsEbIw04BWLZEu22qnnjBGadSngF8Xd+hiVxnzFfTLeSUOzb
         VJGXUwcw+uOSR8nazxgWYdyrcl8Eo+ICBd1RdLbxTGh0DDvy/SNrhbVFiioh5H4kZM1Z
         Cz0de2EG4fOFg3t31w8Q86fxMYH7baREo/AfRC6QmDlBialTwPBNPJz/+VBbGr3cSQgV
         HleoxKF8aIG+nTemXzBBTlM/WthqUTv/+AIuBipaxvKshd0Lwmwty9sD7CWnCOtxhQgd
         6z4M4qUPiAkxbBBg+D+iX0+Avm0ItuXbf5AVS1IbEQEgHAia+nVVOEsXeRR1y19RlVPY
         OxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSURtCN1UggPbkBn4QxhZJcNzyV2Z+XMSNo4/7DrXvA=;
        b=jKMFiJ0YwBg4k8gfXpOOhPa/7p78oTUb9g6gxBOtfxP9j49alEjMSuoHBSEUSphGoB
         vn0l+8mSVYuLawkRgI/jL8O/tHVd+igqLUXJa+lkfFTaggvY5EvG4b/I5QmMyIXsPPbd
         8I+/gNdx9464vWB/ABMp9ngEP7BjW5OLW0oHDhni2kBz5FATlwk/G4ZB+evUR+zNHkev
         Q/BTYVDX6O+SmLLrGktrYmfYIQqS85Mkjl85oHx1yeb9SpjvPD1c0soZieuDzaYQgpeg
         L2ptSZTmlHnAh4F9n17VM84+/PS1g1vJaPbX/Ml+phTdFVZc3sk58gGeZhhQFoccO9Fp
         Txdg==
X-Gm-Message-State: ACrzQf27YIkE9JlglYuMEdSo4IVycP6A9uFgHT48mRnoJVhjlQPhNIC2
        27O8gcw4sAeBBbqFWqW14bdWjQ==
X-Google-Smtp-Source: AMsMyM7NzkaExPqYOf0TbKdsq4OxB5FkNzbCRzwBicmvZ3W7J2y5XCfO/JdV3zPyJJ7dJA4E0VN+7Q==
X-Received: by 2002:a17:90b:3d8d:b0:212:ccda:88bc with SMTP id pq13-20020a17090b3d8d00b00212ccda88bcmr3402947pjb.212.1668138801175;
        Thu, 10 Nov 2022 19:53:21 -0800 (PST)
Received: from [10.251.254.250] ([103.136.221.54])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186abb95bfdsm500371plr.25.2022.11.10.19.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 19:53:20 -0800 (PST)
Message-ID: <83161e5e-5aa4-acdc-630b-95274bfb47d3@bytedance.com>
Date:   Fri, 11 Nov 2022 11:53:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v4] bpf: Initialize same number of free nodes for
 each pcpu_freelist
Content-Language: en-US
To:     Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221110122128.105214-1-xukuohai@huawei.com>
From:   wuqiang <wuqiang.matt@bytedance.com>
In-Reply-To: <20221110122128.105214-1-xukuohai@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/11/10 20:21, Xu Kuohai wrote:
> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
> free nodes for some CPUs, and then possibly one CPU with fewer nodes,
> followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
> and num_possible_cpus() == 32, CPU 0~27 each gets 9 free nodes, CPU 28 gets
> 4 free nodes, CPU 29~31 get 0 free nodes, while in fact each CPU should get
> 8 nodes equally.
> 
> This patch initializes nr_elems / num_possible_cpus() free nodes for each
> CPU firstly, then allocates the remaining free nodes by one for each CPU
> until no free nodes left.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> v4: Remove unneeded min()
> v3: Simplify code as suggested by Andrii
> v2: Update commit message and add Yonghong's ack
> ---
>   kernel/bpf/percpu_freelist.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> index b6e7f5c5b9ab..27f2c4aff623 100644
> --- a/kernel/bpf/percpu_freelist.c
> +++ b/kernel/bpf/percpu_freelist.c
> @@ -100,22 +100,22 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>   			    u32 nr_elems)
>   {
>   	struct pcpu_freelist_head *head;
> -	int i, cpu, pcpu_entries;
> +	unsigned int cpu, cpu_idx, i, j, n, m;
>   
> -	pcpu_entries = nr_elems / num_possible_cpus() + 1;
> -	i = 0;
> +	n = nr_elems / num_possible_cpus();
> +	m = nr_elems % num_possible_cpus();
> +
> +	cpu_idx = 0;
>   
>   	for_each_possible_cpu(cpu) {
> -again:
> -		head = per_cpu_ptr(s->freelist, cpu);
> -		/* No locking required as this is not visible yet. */
> -		pcpu_freelist_push_node(head, buf);
> -		i++;
> -		buf += elem_size;
> -		if (i == nr_elems)
> -			break;
> -		if (i % pcpu_entries)
> -			goto again;
> +		j = n + (cpu_idx < m ? 1 : 0);
> +		for (i = 0; i < j; i++) {
> +			head = per_cpu_ptr(s->freelist, cpu);

Better move it out of "i-loop", and rename "j" to a meaningful name to avoid
possible misuse.

> +			/* No locking required as this is not visible yet. */
> +			pcpu_freelist_push_node(head, buf);
> +			buf += elem_size;
> +		}
> +		cpu_idx++;
>   	}
>   }
>   

