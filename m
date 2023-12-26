Return-Path: <bpf+bounces-18667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BF081E46B
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 02:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6190B28280E
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 01:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D356A35;
	Tue, 26 Dec 2023 01:39:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6DCA28
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Szcr14JNlz4f3khr
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 09:38:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 91AC41A0855
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 09:39:00 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDniEexLopldSkREw--.499S2;
	Tue, 26 Dec 2023 09:39:00 +0800 (CST)
Subject: Re: Using BPF_MAP_TYPE_LPM_TRIE for string matching
From: Hou Tao <houtao@huaweicloud.com>
To: Dominic <d.dropify@gmail.com>, bpf@vger.kernel.org
References: <CAJxriS06VxYSaCoo0WT2LtUPPwXopyMHr=-FyR5qRoeGWguBZg@mail.gmail.com>
 <b9262f12-73e8-a090-1197-2cf380ba3cea@huaweicloud.com>
Message-ID: <72cac21d-f973-a40c-35de-cc7942ecae06@huaweicloud.com>
Date: Tue, 26 Dec 2023 09:38:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b9262f12-73e8-a090-1197-2cf380ba3cea@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDniEexLopldSkREw--.499S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW3Aw1kJF4kur1rAry7Jrb_yoW8Gr47pa
	yF9ayFyF4kJr1kKwnaq3y8Wr98ArsY9w4UAFyDGrZaq34DWF1jvF1xJw40ya47Jr1DG347
	Xa1Fv34kAa1UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/25/2023 10:24 PM, Hou Tao wrote:
> Hi,
>
> On 12/22/2023 8:05 PM, Dominic wrote:
>> Can BPF_MAP_TYPE_LPM_TRIE be used for string matching? I tried it but
>> the matching doesn't work as expected.
> Yes. LPM_TRIE will work for string matching.  Did you setup the key size
> of the map and the prefixlen field of bpf_lpm_trie_key correctly ?
> Because the unit of key_size is in-bytes and it should be the maximal
> length of these strings, but the unit of prefixlen is in-bits and it is
> the length of string expressed in bits. And could you share the steps on
> how you used it ?

Forgot to mention the trick when using LPM_TRIE for string matching.
Because LPM_TRIE uses longest prefix matching to find the target
element, so using the string abcd as key to lookup LPM_TRIE will match
the string abc saved in LPM_TRIE and it is not we wanted. To fix that,
we need to add the terminated null byte of the string to the key, so the
string abc\0 will not be the prefix of the string abcd\0. The code
snippet looks as follows.

map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, name,
sizeof(bpf_lpm_trie_key) + max_string_length + 1, value_size,
max_entries, &opts);

key.prefixlen = (strlen(str) + 1) * 8;
memcpy(key.data, str, strlen(str) + 1);
bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);

>
>> Thanks & Regards,
>> Dominic
>>
>> .
>
> .


