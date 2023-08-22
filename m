Return-Path: <bpf+bounces-8204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2D5783793
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 03:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5861C209C6
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4741D110A;
	Tue, 22 Aug 2023 01:46:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3F10E9
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 01:46:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DF9180
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 18:46:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVBys331jz4f3jJ4
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 09:46:29 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB3TJ9yE+RklJkjBQ--.36091S2;
	Tue, 22 Aug 2023 09:46:29 +0800 (CST)
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com>
 <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
 <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
 <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com>
 <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com>
 <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com>
Date: Tue, 22 Aug 2023 09:46:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB3TJ9yE+RklJkjBQ--.36091S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4Dtw15Zw4rWw1xCryrXrb_yoW8Wr1kpF
	W8uayj9r4kJFWDZ3sIgw48XFy0yF18Wr10ka1kt3y5ZFyDur9agw48Wa1xCFyrJr1fC3y2
	qrWq934fX3y8u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/22/2023 8:58 AM, Alexei Starovoitov wrote:
> On Mon, Aug 21, 2023 at 5:55 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 8/22/2023 7:49 AM, Alexei Starovoitov wrote:
>>> On Sat, Aug 19, 2023 at 3:39 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> Hi,
>>>>
>>>> On 8/18/2023 7:00 AM, Alexei Starovoitov wrote:
>>>>> On Wed, Aug 16, 2023 at 11:35 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>>
SNIP
>>>>> If the existing bpf_map_lookup_elem() helper doesn't fit qp-tree we can
>>>>> use new kfuncs from bpf prog and LPM-like map accessors from syscall.
>>>> It is a feasible solution, but it will make qp-trie be different with
>>>> other map types. I will try to extend the APIs in bpf_map_ops first to
>>>> see how much churns it may introduce.
>>> you mean you want to try to dynamically adapt bpf_map_lookup_elem()
>>> to consider 'void *key' as a pointer to dynptr for bpf prog and
>>> lpm-like tuple for syscall?
>>> I'm afraid the verifier changes will be messy, since PTR_TO_MAP_KEY is
>>> quite special.
>> No. I didn't plan to do that. I am trying to add three new APIs in
>> bpf_map_ops to handle lookup/update/delete operation from bpf syscall
>> (e.g, map_lookup_elem_syscall). So bpf program and bpf syscall can use
>> different API to operate on qp-trie.
> How does bpf prog side api look like?
> I thought we wanted to use dynptr as a key?

Yes. bpf prog will use dynptr as the map key. The bpf program will use
the same map helpers as hash map to operate on qp-trie and the verifier
will be updated to allow using dynptr as map key for qp-trie.


