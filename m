Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0599E38DF4C
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 04:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhEXCkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 May 2021 22:40:36 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40916 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231867AbhEXCkf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 May 2021 22:40:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UZqFhm._1621823946;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UZqFhm._1621823946)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 May 2021 10:39:07 +0800
Subject: Re: Why does bpf_probe_read also release relocation information?
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
References: <4b600d5b-c92b-878f-1306-d15909b56c3e@linux.alibaba.com>
 <04c59931-2b42-2994-8080-582beca40427@fb.com>
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Message-ID: <a58f3050-3a8b-89ce-f1e8-a326cb03455d@linux.alibaba.com>
Date:   Mon, 24 May 2021 10:39:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <04c59931-2b42-2994-8080-582beca40427@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/24/21 10:34 AM, Yonghong Song wrote:
> 
> 
> On 5/23/21 7:24 PM, Shuyi Cheng wrote:
>> Hello everyone,
>>
>> I would like to ask a question. The question is: Why does 
>> bpf_probe_read not use __builtin_preserve_access_index and also 
>> release relocation information?
>>
>> The following document is from: 
>> https://github.com/libbpf/libbpf/blob/57375504c6c9766d23f178c40f71bf5e8df9363d/src/libbpf_internal.h#L414 
>>
>>
>>   * Such relocation is emitted when using 
>> __builtin_preserve_access_index()
>>   * Clang built-in, passing expression that captures field address, e.g.:
>>   *
>>   * bpf_probe_read(&dst, sizeof(dst),
>>   *          __builtin_preserve_access_index(&src->a.b.c));
>>   *
>>   * In this case Clang will emit field relocation recording necessary 
>> data to
>>   * be able to find offset of embedded `a.b.c` field within `src` struct.
>>
>>
>> This document clearly explains the function of 
>> __builtin_preserve_access_index. However, I did a small test. The test 
>> results show that only using bpf_probe_read and not using 
>> __builtin_preserve_access_index will also be relocated.The specific 
>> test content is as follows:
>>
>> // The bpf program.
>> SEC("kprobe/kfree_skb")
>> int BPF_PROG(kprobe__kfree_skb,struct sk_buff *skb)
>> {
>>      unsigned char *data;
>>      bpf_probe_read(&data,sizeof(data),&skb->data);
>>      return 0;
>> }
>>
>> // The debug log.
>> libbpf: CO-RE relocating [0] struct sk_buff: found target candidate 
>> [3057] struct sk_buff in [vmlinux]
>> libbpf: CO-RE relocating [0] struct sk_buff: found target candidate 
>> [23925] struct sk_buff in [vmlinux]
>> libbpf: prog 'kprobe__kfree_skb': relo #0: matching candidate #0 
>> [3057] struct sk_buff.data (0:77 @ offset 240)
>> libbpf: prog 'kprobe__kfree_skb': relo #0: matching candidate #1 
>> [23925] struct sk_buff.data (0:77 @ offset 240)
>> libbpf: prog 'kprobe__kfree_skb': relo #0: patched insn #0 (ALU/ALU64) 
>> imm 240 -> 240
> 
> Did you include "vmlinux.h" in your program? The "vmlinux.h" contains
> 
> #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> #pragma clang attribute push (__attribute__((preserve_access_index)), 
> apply_to = record)
> #endif
> 
> which will put preserve_access_index to all record (struct/union) 
> definitions. So the above "sk_buff" member access will be relocated
> automatically by libbpf.
>

Yes, i inclue "vmlinux.h". I understand, Thank you very much for 
answering my doubts.:-)

>>
>> Thanks in advance for your help,
>> Cheng
>>
>>
