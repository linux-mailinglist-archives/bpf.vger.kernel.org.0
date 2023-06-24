Return-Path: <bpf+bounces-3357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6573C6A6
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6B41C213F7
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF03644;
	Sat, 24 Jun 2023 03:54:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DD7F;
	Sat, 24 Jun 2023 03:54:15 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672826A0;
	Fri, 23 Jun 2023 20:54:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qp0bM1L2jz4f3sCn;
	Sat, 24 Jun 2023 11:54:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCnEi3caJZk6p_qLg--.52521S2;
	Sat, 24 Jun 2023 11:54:07 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next 07/12] bpf: Add a hint to allocated objects.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
 <20230621023238.87079-8-alexei.starovoitov@gmail.com>
 <280a8fd5-6bc6-7924-30e3-412d5bc3c3e0@huaweicloud.com>
 <CAADnVQ+ROd__AXmHcUTy3j8zYL7zr6brA3swS9P6OmN_2BwcrQ@mail.gmail.com>
Message-ID: <73ca4152-a197-5744-1950-25c294b5b865@huaweicloud.com>
Date: Sat, 24 Jun 2023 11:54:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+ROd__AXmHcUTy3j8zYL7zr6brA3swS9P6OmN_2BwcrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCnEi3caJZk6p_qLg--.52521S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyrCr4fKF4rCF47Xw4Dtwb_yoWftFX_u3
	48C345Jr1DJ3yDta98Gr4Fga4xCryDWrn5uryftFWkJ34Yk395ZF97XryxurW0gw4aga4D
	Cw1Svw47C3y3XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/24/2023 11:42 AM, Alexei Starovoitov wrote:
> On Fri, Jun 23, 2023 at 8:28 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>                */
>>> -             obj = __llist_del_first(&c->free_by_rcu_ttrace);
>>> +             obj = llist_del_first(&c->free_by_rcu_ttrace);
>> According to the comments in llist.h, when there are concurrent
>> llist_del_first() and llist_del_all() operations, locking is needed.
> Good question.
> 1. When only one cpu is doing llist_del_first() locking is not needed.
>  This is the case here. Only this cpu is doing llist_del_first() from this 'c'.
> 2. The comments doesn't mention it, but llist_del_first() is ok on
> multiple cpus if ABA problem is addressed by other means.
Haven't checked the implementation details of lockless list. Will do
that later. "by other means" do you mean RCU ? because the reuse will be
possible only after one RCU GP.
> PS
> please trim your replies.
Sorry for the inconvenience. Will do next time.


