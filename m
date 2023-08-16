Return-Path: <bpf+bounces-7880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3677DB84
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 09:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EFF1C20F55
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 07:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39705C8FF;
	Wed, 16 Aug 2023 07:58:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13375D2E0
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 07:58:45 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB9A2684;
	Wed, 16 Aug 2023 00:58:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQgVC2c7Rz4f3lXm;
	Wed, 16 Aug 2023 15:57:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXUzCAgdxkdBcnAw--.32370S2;
	Wed, 16 Aug 2023 15:57:55 +0800 (CST)
Subject: Re: [PATCH bpf-next v5] libbpf: Expose API to consume one ring at a
 time
To: Adam Sindelar <adam@wowsignal.io>
Cc: bpf@vger.kernel.org, Adam Sindelar <ats@fb.com>,
 David Vernet <void@manifault.com>, Brendan Jackman <jackmanb@google.com>,
 KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Florent Revest <revest@chromium.org>
References: <20230728093346.673994-1-adam@wowsignal.io>
 <7c792532-4474-b523-08f9-f82fb57f1b09@huaweicloud.com>
 <ZNx5Meh0doxdXs4H@Momo.fritz.box>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2e224b7b-7e33-fce7-02a7-87b144d45495@huaweicloud.com>
Date: Wed, 16 Aug 2023 15:57:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZNx5Meh0doxdXs4H@Momo.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXUzCAgdxkdBcnAw--.32370S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZFy3uF45Wry7CrW5Gw4DArb_yoW8Jr4fpF
	W8Kr1Yqa4qyF1j939rtF1fXryYqayfAw15Ja15G348A3W5KF9Ygr40yw1Y9F1YkrsIgaya
	vayag3Z7A34UCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/16/2023 3:22 PM, Adam Sindelar wrote:
> On Fri, Jul 28, 2023 at 06:51:25PM +0800, Hou Tao wrote:
> Hi, sorry for potentially dumb question, but should I do anything else
> after someone acks it? This is a minor patch for a userland component,
> but it's really helpful IMO - is anything preventing this getting merged
> at this point?

According to BPF CI [0], the main reason that it was closed was due to
the failure of test_progs_no_alu32 on s390x, but it seems the failure
was due to BPF CI itself instead of the modification in the patchset, so
I think resend v5 to BPF mail list will be enough. After the pass of BPF
CI, I think the maintainer will merge it if there is no disagreement.

[0]:
https://github.com/kernel-patches/bpf/actions/runs/5829217685/job/15808898814
> Thanks,
> Adam
>
>> On 7/28/2023 5:33 PM, Adam Sindelar wrote:
>>> We already provide ring_buffer__epoll_fd to enable use of external
>>> polling systems. However, the only API available to consume the ring
>>> buffer is ring_buffer__consume, which always checks all rings. When
>>> polling for many events, this can be wasteful.
>>>
>>> Signed-off-by: Adam Sindelar <adam@wowsignal.io>
>> Acked-by: Hou Tao <houtao1@huawei.com>
>>


