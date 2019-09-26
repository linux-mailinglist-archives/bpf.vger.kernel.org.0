Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31552BEA5B
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2019 04:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfIZCBZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Sep 2019 22:01:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727403AbfIZCBZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Sep 2019 22:01:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 919A7CA8ED39B53B4CE1;
        Thu, 26 Sep 2019 10:01:21 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 10:01:17 +0800
Subject: Re: [PATCH 30/32] tools lib bpf: Renaming pr_warning to pr_warn
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Petr Mladek <pmladek@suse.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Whitcroft <apw@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Martin KaFai Lau" <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-31-wangkefeng.wang@huawei.com>
 <CAEf4BzbD98xeU2dSrXYkVi+mK=kuq+5DsroNDZwOzBGYbMH1-w@mail.gmail.com>
 <20190923082039.GA2530@pc-63.home>
 <20190923110306.hrgeqwo5ogd55vfo@pathway.suse.cz>
 <20190923133550.GA9880@pc-63.home>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <82fe3d04-2985-7844-31bb-269655c83873@huawei.com>
Date:   Thu, 26 Sep 2019 10:01:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190923133550.GA9880@pc-63.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2019/9/23 21:35, Daniel Borkmann wrote:
> On Mon, Sep 23, 2019 at 01:03:06PM +0200, Petr Mladek wrote:
>> On Mon 2019-09-23 10:20:39, Daniel Borkmann wrote:
>>> On Sun, Sep 22, 2019 at 02:07:21PM -0700, Andrii Nakryiko wrote:
>>>> On Fri, Sep 20, 2019 at 10:06 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>>> For kernel logging macro, pr_warning is completely removed and
>>>>> replaced by pr_warn, using pr_warn in tools lib bpf for symmetry
>>>>> to kernel logging macro, then we could drop pr_warning in the
>>>>> whole linux code.
>>>>>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> ---
>>>>>  tools/lib/bpf/btf.c             |  56 +--
>>>>>  tools/lib/bpf/btf_dump.c        |  20 +-
>>>>>  tools/lib/bpf/libbpf.c          | 652 ++++++++++++++++----------------
>>>>>  tools/lib/bpf/libbpf_internal.h |   2 +-
>>>>>  tools/lib/bpf/xsk.c             |   4 +-
>>>>>  5 files changed, 363 insertions(+), 371 deletions(-)
>>>> Thanks! This will allow to get rid of tons warnings from checkpatch.pl.
>>>>
>>>> Alexei, Daniel, can we take this through bpf-next tree once it's open?
>>> I'd be fine with that, in fact, it probably should be in order to avoid
>>> merge conflicts since pr_warn{ing}() is used all over the place in libbpf.
>> The entire patchset modifies many files all over the tree.
>> This is from https://lkml.kernel.org/r/20190920062544.180997-1-wangkefeng.wang@huawei.com
>>
>>     120 files changed, 882 insertions(+), 927 deletions(-)
>>
>> Would it make sense to push everything at the end of the merge window
>> or for 5.4-rc2 after master settles down?
> If all over the tree it would probably make more sense for e.g. Andrew Morton to
> pick it up if there are no other objections, and try to merge it during mentioned
> time frame.

Hi Andrew，could you pick them up if no objections, and I could resend all with comment fixed

with better time frame(rc1 or rc2 ), is it OK？

Thanks.

>
> Thanks,
> Daniel
>
> .
>

