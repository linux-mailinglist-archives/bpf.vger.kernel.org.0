Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493AA1838D0
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 19:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCLSjF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 14:39:05 -0400
Received: from www62.your-server.de ([213.133.104.62]:47438 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCLSjF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 14:39:05 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jCSjU-0007c9-Uk; Thu, 12 Mar 2020 19:39:00 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jCSjU-000JbU-KP; Thu, 12 Mar 2020 19:39:00 +0100
Subject: Re: [PATCH bpf-next v2] bpftool: use linux/types.h from source tree
 for profiler build
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20200312105335.10465-1-tklauser@distanz.ch>
 <20200312130330.32239-1-tklauser@distanz.ch>
 <CAEf4BzakzbN4+PVa4TFsOhH=Pnt_4mhPknH74kwsRkOApkKhOg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <40a2c6fc-6bea-21d2-b285-04b319eccea6@iogearbox.net>
Date:   Thu, 12 Mar 2020 19:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzakzbN4+PVa4TFsOhH=Pnt_4mhPknH74kwsRkOApkKhOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25749/Thu Mar 12 14:09:06 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/12/20 6:59 PM, Andrii Nakryiko wrote:
> On Thu, Mar 12, 2020 at 6:04 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>>
>> When compiling bpftool on a system where the /usr/include/asm symlink
>> doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
>> the build fails with:
>>
>>      CLANG    skeleton/profiler.bpf.o
>>    In file included from skeleton/profiler.bpf.c:4:
>>    In file included from /usr/include/linux/bpf.h:11:
>>    /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
>>    #include <asm/types.h>
>>             ^~~~~~~~~~~~~
>>    1 error generated.
>>    make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
>>
>> This indicates that the build is using linux/types.h from system headers
>> instead of source tree headers.
>>
>> To fix this, adjust the clang search path to include the necessary
>> headers from tools/testing/selftests/bpf/include/uapi and
>> tools/include/uapi. Also use __bitwise__ instead of __bitwise in
>> skeleton/profiler.h to avoid clashing with the definition in
>> tools/testing/selftests/bpf/include/uapi/linux/types.h.
>>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Song Liu <songliubraving@fb.com>
>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Cc: Quentin Monnet <quentin@isovalent.com>
>> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
>> ---
>>   tools/bpf/bpftool/Makefile            |  5 ++++-
>>   tools/bpf/bpftool/skeleton/profiler.h | 17 ++++++++---------
>>   2 files changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index 20a90d8450f8..f294f6c1e795 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -120,7 +120,10 @@ $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
>>          $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(_OBJS) $(LIBS)
>>
>>   skeleton/profiler.bpf.o: skeleton/profiler.bpf.c
>> -       $(QUIET_CLANG)$(CLANG) -I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
>> +       $(QUIET_CLANG)$(CLANG) \
>> +               -I$(srctree)/tools/include/uapi/ \
>> +               -I$(srctree)/tools/testing/selftests/bpf/include/uapi \
> 
> Seems like I'm spoiling all the fun today :) But why are we ok with
> bpftool build depending on selftests? This just makes it even harder
> to have a stand-alone bpftool build eventually (similar to libbpf's
> Github).

I suspect the Github copy of bpftool would have its own include infra like
in case of libbpf [0]?

Agree in any case that it's not an optimal situation with this dependency;
I suspect we might need the tools/testing/selftests/bpf/include/uapi/ under
tools/include/uapi/ in a proper way.

   [0] https://github.com/libbpf/libbpf/tree/master/include
