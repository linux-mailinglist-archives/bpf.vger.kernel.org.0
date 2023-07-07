Return-Path: <bpf+bounces-4380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22BA74A895
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDBC2815F3
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FAE15B6;
	Fri,  7 Jul 2023 01:45:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7117F;
	Fri,  7 Jul 2023 01:45:22 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7D91BDB;
	Thu,  6 Jul 2023 18:45:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qxx6j1vs1z4f3jYq;
	Fri,  7 Jul 2023 09:45:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBHZjArbqdkkI6mMg--.50539S2;
	Fri, 07 Jul 2023 09:45:17 +0800 (CST)
Subject: Re: [PATCH v4 bpf-next 12/14] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
 andrii@kernel.org, void@manifault.com, paulmck@kernel.org
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-13-alexei.starovoitov@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2c09b7d7-b91c-c561-3fd6-b8483aab01dc@huaweicloud.com>
Date: Fri, 7 Jul 2023 09:45:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230706033447.54696-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBHZjArbqdkkI6mMg--.50539S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryfGw1fJF1UJFyUKF48JFb_yoWfJwb_WF
	WkXF1rAr47GFWvqw1rCF4xAa15G3W5Ja409ry5XFyDGF15Wr98AF4xXry3Aayktw4SqF1U
	J34rJa1DKrnxZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
> objects into free_by_rcu_ttrace list where they are waiting for RCU
> task trace grace period to be freed into slab.
>
> The life cycle of objects:
> alloc: dequeue free_llist
> free: enqeueu free_llist
> free_rcu: enqueue free_by_rcu -> waiting_for_gp
> free_llist above high watermark -> free_by_rcu_ttrace
> after RCU GP waiting_for_gp -> free_by_rcu_ttrace
> free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Hou Tao <houtao1@huawei.com>


