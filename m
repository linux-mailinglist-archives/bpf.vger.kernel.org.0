Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC65740BE8
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 10:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjF1IyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 04:54:12 -0400
Received: from dggsgout12.his.huawei.com ([45.249.212.56]:11134 "EHLO
        dggsgout12.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbjF1Ipu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 04:45:50 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QrWbZ1lpxz4f3whP;
        Wed, 28 Jun 2023 14:18:02 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgD3FTCZ0JtkAUQVMA--.39130S2;
        Wed, 28 Jun 2023 14:18:04 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 03/13] bpf: Let free_all() return the number
 of freed elements.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
        andrii@kernel.org, void@manifault.com, paulmck@kernel.org
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-4-alexei.starovoitov@gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <f63e161a-9189-9ca9-cae4-0ca34345e7f0@huaweicloud.com>
Date:   Wed, 28 Jun 2023 14:18:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230628015634.33193-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgD3FTCZ0JtkAUQVMA--.39130S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw48KF4rCr1xKryrAFWrKrg_yoWfAFg_uF
        WkGrWfZr4agFsFqw18ta1xtwn0krsxXrWxWr1UX3s7GFyfJwn8ZF42gr43ArWxtw1kXF9r
        t34xAFZaqrWavjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
        UGYL9UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/28/2023 9:56 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Let free_all() helper return the number of freed elements.
> It's not used in this patch, but helps in debug/development of bpf_mem_alloc.
>
> For example this diff for __free_rcu():
> -       free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
> +       printk("cpu %d freed %d objs after tasks trace\n", raw_smp_processor_id(),
> +       	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size));
>
> would show how busy RCU tasks trace is.
> In artificial benchmark where one cpu is allocating and different cpu is freeing
> the RCU tasks trace won't be able to keep up and the list of objects
> would keep growing from thousands to millions and eventually OOMing.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>

