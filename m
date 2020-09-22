Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9147273855
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 04:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgIVCGs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 22:06:48 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48033 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728884AbgIVCGs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Sep 2020 22:06:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U9izIkU_1600740404;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U9izIkU_1600740404)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Sep 2020 10:06:44 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [bpf-next 2/3] sample/bpf: Add log2 histogram function support
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf <bpf@vger.kernel.org>, Wenbo Zhang <ethercflow@gmail.com>
References: <20200920144547.56771-1-xhao@linux.alibaba.com>
 <20200920144547.56771-3-xhao@linux.alibaba.com>
 <5f68dfdc66b63_1737020879@john-XPS-13-9370.notmuch>
 <CAEf4BzaMCUfVWcp0ScSre47TDMtqQd=yoUfb+w0QXWf=_952dQ@mail.gmail.com>
Message-ID: <275b1dbc-938e-626f-fc6c-5bbb6f76c270@linux.alibaba.com>
Date:   Tue, 22 Sep 2020 10:06:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaMCUfVWcp0ScSre47TDMtqQd=yoUfb+w0QXWf=_952dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2020/9/22 上午5:40, Andrii Nakryiko 写道:
> On Mon, Sep 21, 2020 at 10:18 AM John Fastabend
> <john.fastabend@gmail.com> wrote:
>> Xin Hao wrote:
>>> The relative functions is copy from bcc tools
> you probably meant relevant, not relative?
Yes
>
>>> source code: libbpf-tools/trace_helpers.c.
>>> URL: https://github.com/iovisor/bcc.git
>>>
>>> Log2 histogram can display the change of the collected
>>> data more conveniently.
>>>
>>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>>> ---
>>>   samples/bpf/common.h | 67 ++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 67 insertions(+)
>>>   create mode 100644 samples/bpf/common.h
>>>
>>> diff --git a/samples/bpf/common.h b/samples/bpf/common.h
>>> new file mode 100644
>>> index 000000000000..ec60fb665544
>>> --- /dev/null
>>> +++ b/samples/bpf/common.h
>>> @@ -0,0 +1,67 @@
>>> +/* SPDX-License-Identifier: GPL-2.0
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of version 2 of the GNU General Public
>>> + * License as published by the Free Software Foundation.
>>> + */
>>> +
>> nit, for this patch and the last one we don't need the text. Just the SPDX
>> identifier should be enough. Its at least in line with everything we have
>> elsewhere.
Thanks, i will change it.
>>
>> Also if there is a copyright on that original file we should pull it over
>> as far as I understand it. I don't see anything there though so maybe
>> not.
> There no copyright, it follow dual-licensed as (LGPL-2.1 OR BSD-2-Clause)
>
> Original code is dual-licensed as (LGPL-2.1 OR BSD-2-Clause), probably
> leaving a comment with original location and mentioning the original
> license would be ok?
Ok, thanks
>
> I've also CC'ed original author (Wenbo Zhang), just for visibility.
Thanks
>
>>> +#define min(x, y) ({                          \
>>> +     typeof(x) _min1 = (x);                   \
>>> +     typeof(y) _min2 = (y);                   \
>>> +     (void) (&_min1 == &_min2);               \
>>> +     _min1 < _min2 ? _min1 : _min2; })
>> What was wrong with 'min(a,b) ((a) < (b) ? (a) : (b))' looks like
>> below its just used for comparing two unsigned ints?
>>
>> Thanks.
  I do not chang any codes, That's what the original code looks like

>>
>>> +
> [...]

-- 
Best Regards!
Xin Hao

