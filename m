Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A903A9369
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 08:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFPG7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 02:59:50 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60137 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230508AbhFPG7s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 02:59:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UcaecIg_1623826661;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UcaecIg_1623826661)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jun 2021 14:57:41 +0800
Subject: Re: How to avoid compilation errors like "error: no member named xxx
 in strut xxx"?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <756efe9a-a237-e5d1-17fc-47936e76dacc@linux.alibaba.com>
 <CAEf4Bza2ytug5PMzTcXZjggZU-Zo63XJZzmw0ZoLHJ3-erJkpg@mail.gmail.com>
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Message-ID: <05ec3172-0d79-0b65-f231-15a309c4d3af@linux.alibaba.com>
Date:   Wed, 16 Jun 2021 14:57:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bza2ytug5PMzTcXZjggZU-Zo63XJZzmw0ZoLHJ3-erJkpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/16/21 2:02 PM, Andrii Nakryiko wrote:
> On Tue, Jun 15, 2021 at 9:06 PM Shuyi Cheng
> <chengshuyi@linux.alibaba.com> wrote:
>>
>> I am trying to write a bpf program that supports multiple linux kernel
>> versions. However, there are some differences in the definition of
>> struct net in these multiple kernel versions.
>>
>> Therefore, when we include a certain kernel version of vmlinux.h, the
>> compilation error "error: no member named'proc_inum' in strut net" will
>> appear.
>>
>> However, when we include another kernel version of vmlinux.h, the
>> compilation will appear "error: no member named'ns.inum' in strut net".
>>
>> Anakryiko mentioned in the issue of libbpf/libbpf-bootstrap: vmlinux.h
>> is just a convenient way to have most of kernel types defined for you,
>> so that you don't have to re-define them manually. Link here: https:
>> //github.com/libbpf/libbpf-bootstrap/issues/31#issuecomment-861035643
>>
>> But struct net is a very huge structure, and it may be very difficult to
> 
> You don't need to declare the entire struct, it's enough to declare
> only fields that you need and use.
> 
> If the type has incompatible changes between kernel versions (e.g., if
> some field changed it's type), you can use my_type___suffix approach,
> see [0] and struct kernfs_iattrs___old example. Let me know if you
> need more concrete example (but then also provide more concrete
> explanation of what you actually need).
> 
>    [0] https://nakryiko.com/posts/bcc-to-libbpf-howto-guide/#dealing-with-compile-time-if-s-in-bcc
> 
>> add it manually. So, how can we avoid compilation errors like "error: no
>> member named'xxx' in xxx"


Thank you very much, i get it.
