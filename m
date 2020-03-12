Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C544418351B
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 16:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgCLPjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 11:39:00 -0400
Received: from www62.your-server.de ([213.133.104.62]:43016 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgCLPi7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 11:38:59 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jCPvE-0007yR-DW; Thu, 12 Mar 2020 16:38:56 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jCPvE-0005Ms-4o; Thu, 12 Mar 2020 16:38:56 +0100
Subject: Re: [PATCH bpf-next v2] bpftool: use linux/types.h from source tree
 for profiler build
To:     Quentin Monnet <quentin@isovalent.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20200312105335.10465-1-tklauser@distanz.ch>
 <20200312130330.32239-1-tklauser@distanz.ch>
 <a01e3ca9-0787-2537-3cb4-91a869929aaf@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <883244e7-a077-528f-ddb1-5bdf169947ec@iogearbox.net>
Date:   Thu, 12 Mar 2020 16:38:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a01e3ca9-0787-2537-3cb4-91a869929aaf@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25749/Thu Mar 12 14:09:06 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/12/20 3:15 PM, Quentin Monnet wrote:
> 2020-03-12 14:03 UTC+0100 ~ Tobias Klauser <tklauser@distanz.ch>
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
> 
> Looks good, thanks!
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Applied, thanks (compiles fine over here as well now)!
