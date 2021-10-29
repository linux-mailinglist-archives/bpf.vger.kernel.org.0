Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF443F45A
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 03:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhJ2BcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 21:32:19 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51542 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231269AbhJ2BcT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 21:32:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uu3vgjq_1635470989;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0Uu3vgjq_1635470989)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 09:29:49 +0800
Subject: Re: err: math between fp pointer and register with unbounded min
 value is not allowed
To:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <be2520e1-527e-92ca-95fe-62e895519e02@linux.alibaba.com>
 <73129388-21ba-5e39-3115-c4af1665edad@fb.com>
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Cc:     Mao Wenan <wenan.mao@linux.alibaba.com>
Message-ID: <61c1565f-e356-ba0a-0dcb-a35e74f5e710@linux.alibaba.com>
Date:   Fri, 29 Oct 2021 09:29:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <73129388-21ba-5e39-3115-c4af1665edad@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/28/21 10:56 PM, Yonghong Song wrote:
> 
>> 251: (7b) *(u64 *)(r10 -80) = r1
>> 252: (85) call bpf_get_current_pid_tgid#14
>> 253: (77) r0 >>= 32
>> 254: (63) *(u32 *)(r10 -324) = r0
>> 255: (bf) r1 = r10
>> 256: (07) r1 += -320
>> 257: (b7) r2 = 16
>> 258: (85) call bpf_get_current_comm#16
>> 259: (79) r1 = *(u64 *)(r10 -80)
>> 260: (07) r1 += 20
>> 261: (7b) *(u64 *)(r10 -80) = r1
>> 262: (bf) r7 = r10
>> 263: (07) r7 += -344
>> 264: (0f) r7 += r1
>> math between fp pointer and register with unbounded min value is not 
>> allowed
> 
> You probably used an old kernel.
> The value "r1" is restored from stack location r10 - 80 which
> stores a constant. The verifier needs to transfer the "const" state
> from spill to register.
> 

Thank you very much for your answers. The root cause is that when the 
value is restored from the stack to the register, the verifier of the 
old kernel loses its state. So, which patch of the higher version of the 
kernel solves this problem?

Thank you very much!

>>
>>
>> Thank you very much!
