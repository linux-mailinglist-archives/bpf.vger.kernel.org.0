Return-Path: <bpf+bounces-6849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965676EA59
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 15:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986B31C20FE8
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 13:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C31F18E;
	Thu,  3 Aug 2023 13:29:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221817FF6
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 13:29:43 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE65B46A6
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 06:29:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqRt32dPz4f3nyG
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 21:28:42 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXMBuJq8tkAMiuOg--.6270S2;
	Thu, 03 Aug 2023 21:28:43 +0800 (CST)
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
From: Hou Tao <houtao@huaweicloud.com>
To: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Joanne Koong <joannelkoong@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
Message-ID: <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com>
Date: Thu, 3 Aug 2023 21:28:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXMBuJq8tkAMiuOg--.6270S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1DXr48CFy8WFW8Zr47urg_yoW8ArW3pa
	y0ga4jqrykta42yrWDWw4xAFZYva9Fgr17G34Ut3y5CryDZry3urW8Way5uanxCry7G3yq
	gFW0vwnxWw13ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/2023 9:19 PM, Hou Tao wrote:
> Hi,
>
> I am preparing for qp-trie v4, but I need some help on how to support
> variable-sized key in bpf syscall. The implementation of qp-trie needs
> to distinguish between dynptr key from bpf program and variable-sized
> key from bpf syscall. In v3, I added a new dynptr type:
> BPF_DYNPTR_TYPE_USER for variable-sized key from bpf syscall [0], so
> both bpf program and bpf syscall will use the same type to represent the
> variable-sized key, but Andrii thought ptr+size tuple was simpler and
> would be enough for user APIs, so in v4, the type of key for bpf program
> and syscall will be different. One way to handle that is to add a new
> parameter in .map_lookup_elem()/.map_delete_elem()/.map_update_elem() to
> tell whether the key comes from bpf program or syscall or introduce new
> APIs in bpf_map_ops for variable-sized key related syscall, but I think
> it will introduce too much churn. Considering that the size of
> bpf_dynptr_kern is 8-bytes aligned, so I think maybe I could reuse the
> lowest 1-bit of key pointer to tell qp-trie whether or not it is a
> bpf_dynptr_kern or a variable-sized key pointer from syscall. For
> bpf_dynptr_kern, because it is 8B-aligned, so its lowest bit must be 0,
> and for variable-sized key from syscall, I could allocated a 4B-aligned
> pointer and setting the lowest bit as 1, so qp-trie can distinguish
> between these two types of pointer. The question is that I am not sure
> whether the idea above is a good one or not. Does it sound fragile ? Or
> is there any better way to handle that ?
Forgot to add the URL for [0]:

[0]:
https://lore.kernel.org/bpf/CAEf4BzZyfUOfGkQP67urmG9=7pqUF-5E9LjZf-Y0sL9nbcHFww@mail.gmail.com/
>
> Regards
>
>
>
> .


