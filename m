Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504B8740BEB
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 10:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjF1IyR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 04:54:17 -0400
Received: from dggsgout12.his.huawei.com ([45.249.212.56]:11132 "EHLO
        dggsgout12.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjF1Ikv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 04:40:51 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QrWWg39Mxz4f3sYL;
        Wed, 28 Jun 2023 14:14:39 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDXPyrNz5tkaxUVMA--.39125S2;
        Wed, 28 Jun 2023 14:14:41 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 01/13] bpf: Rename few bpf_mem_alloc fields.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
        andrii@kernel.org, void@manifault.com, paulmck@kernel.org
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-2-alexei.starovoitov@gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <8edc494b-1399-da6e-5e7c-4410d7fe8723@huaweicloud.com>
Date:   Wed, 28 Jun 2023 14:14:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230628015634.33193-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDXPyrNz5tkaxUVMA--.39125S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw48KF4rCr4kJFWUXw45Awb_yoWfGFb_CF
        4jvw18Cr13CanavF15GF12q34fCw4qqF43ur4Yqa4kJwn0g39Yva92yry7C34IqrsaqFyD
        Gwn7JayDtFsxtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/28/2023 9:56 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Rename:
> -       struct rcu_head rcu;
> -       struct llist_head free_by_rcu;
> -       struct llist_head waiting_for_gp;
> -       atomic_t call_rcu_in_progress;
> +       struct llist_head free_by_rcu_ttrace;
> +       struct llist_head waiting_for_gp_ttrace;
> +       struct rcu_head rcu_ttrace;
> +       atomic_t call_rcu_ttrace_in_progress;
> ...
> -	static void do_call_rcu(struct bpf_mem_cache *c)
> +	static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>
> to better indicate intended use.
>
> The 'tasks trace' is shortened to 'ttrace' to reduce verbosity.
> No functional changes.
>
> Later patches will add free_by_rcu/waiting_for_gp fields to be used with normal RCU.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>

