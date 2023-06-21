Return-Path: <bpf+bounces-2961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DD737894
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 03:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDED28144D
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 01:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77BE15A9;
	Wed, 21 Jun 2023 01:07:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B69EC3
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 01:07:34 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656DA10CE;
	Tue, 20 Jun 2023 18:07:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qm52R28sDz4f3nqt;
	Wed, 21 Jun 2023 09:07:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA3khxNTZJkokwILg--.41910S2;
	Wed, 21 Jun 2023 09:07:29 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next v5 2/2] bpf: Call
 rcu_momentary_dyntick_idle() in task work periodically
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 Hou Tao <houtao1@huawei.com>
References: <20230619143231.222536-1-houtao@huaweicloud.com>
 <20230619143231.222536-3-houtao@huaweicloud.com>
 <CAADnVQLPpnTT2W1Ev6Q5g2h2qk6aoFa9uFsuc7Q6Xb36e4YV3w@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <88a55864-d279-d004-e134-fa9a57c37bc7@huaweicloud.com>
Date: Wed, 21 Jun 2023 09:07:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLPpnTT2W1Ev6Q5g2h2qk6aoFa9uFsuc7Q6Xb36e4YV3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA3khxNTZJkokwILg--.41910S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5ArWkJr18JFyxAFy8uFg_yoW8Gw17pa
	yfGrW3trWjyFs7u392yw4DAr98Krs5Xas2kFyjka98G393Xr1vqF92gFyxZ3s8Cr4kGry7
	ZF1jy347Z34rCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/21/2023 12:15 AM, Alexei Starovoitov wrote:
> On Mon, Jun 19, 2023 at 7:00 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> +static void bpf_rcu_gp_acc_work(struct callback_head *head)
>> +{
>> +       struct bpf_rcu_gp_acc_ctx *ctx = container_of(head, struct bpf_rcu_gp_acc_ctx, work);
>> +
>> +       local_irq_disable();
>> +       rcu_momentary_dyntick_idle();
>> +       local_irq_enable();
> We discussed this with Paul off-line and decided to go a different route.
"A different route" means the method used to reduce the memory footprint
is different or the method to do reuse-after-rcu-gp is different ?
> Paul prepared a patch for us to expose rcu_request_urgent_qs_task().
> I'll be sending the series later this week.
Do you plan to take over the reuse-after-rcu-gp patchset ?

I did a quick test, it showed that the memory footprint is smaller and
the performance is similar when using rcu_request_urgent_qs_task()
instead of rcu_momentary_dyntick_idle().

overwrite:
Summary: per-prod-op   27.25 ±    0.08k/s, memory usage   29.52 ±   
1.60MiB, peak memory usage   37.84MiB

batch_add_batch_del:
Summary: per-prod-op   45.84 ±    0.29k/s, memory usage   24.18 ±   
1.44MiB, peak memory usage   30.38MiB

add_del_on_diff_cpu:
Summary: per-prod-op   13.09 ±    0.33k/s, memory usage   32.48 ±   
3.51MiB, peak memory usage   53.54MiB




