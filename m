Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A700B12CD2F
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 07:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfL3G25 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 01:28:57 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44942 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727140AbfL3G25 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Dec 2019 01:28:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TmFK7y0_1577687333;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TmFK7y0_1577687333)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Dec 2019 14:28:53 +0800
Subject: Re: [PATCH] libbpf: Use $(SRCARCH) for include path
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191227024156.150419-1-shile.zhang@linux.alibaba.com>
 <CAEf4BzaKz9CiJh5FVn8+Mg2K+nVJ5RBfZmz6X0C0LH_dcdt0bQ@mail.gmail.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <5fed3c68-b43f-3b27-bf69-322d26d0dd13@linux.alibaba.com>
Date:   Mon, 30 Dec 2019 14:29:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaKz9CiJh5FVn8+Mg2K+nVJ5RBfZmz6X0C0LH_dcdt0bQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2019/12/30 13:21, Andrii Nakryiko wrote:
> On Thu, Dec 26, 2019 at 6:42 PM Shile Zhang
> <shile.zhang@linux.alibaba.com> wrote:
>> To include right x86 centric include path for ARCH=x86_64.
>>
>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>> ---
>>   tools/lib/bpf/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> index defae23a0169..197d96886303 100644
>> --- a/tools/lib/bpf/Makefile
>> +++ b/tools/lib/bpf/Makefile
>> @@ -59,7 +59,7 @@ FEATURE_USER = .libbpf
>>   FEATURE_TESTS = libelf libelf-mmap bpf reallocarray
>>   FEATURE_DISPLAY = libelf bpf
>>
>> -INCLUDES = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/uapi -I$(srctree)/tools/include/uapi
>> +INCLUDES = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
> Is this breaking anything at all right now? I just tried removing
> arch-specific include and everything still compiled successfully. So
> maybe instead let's just drop arch-specific include path?
>

No compile error/warning, but just include wrong (non-existed) include path.
I think it's OK to drop it if that path is needless.

Thanks!

>>   FEATURE_CHECK_CFLAGS-bpf = $(INCLUDES)
>>
>>   check_feat := 1
>> --
>> 2.24.0.rc2
>>

