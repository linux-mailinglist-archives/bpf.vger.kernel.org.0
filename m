Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3254CA7337
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2019 21:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfICTJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Sep 2019 15:09:37 -0400
Received: from www62.your-server.de ([213.133.104.62]:34664 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Sep 2019 15:09:37 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i5EBI-0005WE-3F; Tue, 03 Sep 2019 21:09:32 +0200
Received: from [178.197.249.19] (helo=pc-63.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i5EBH-000N7R-Rc; Tue, 03 Sep 2019 21:09:31 +0200
Subject: Re: [PATCH bpf v4 0/4] selftests/bpf: fix endianness issues in
 test_sysctl
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Song Liu <liu.song.a23@gmail.com>,
        Yonghong Song <yhs@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20190830110732.8966-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <adcfdc73-3e4a-4dea-7959-7598acaa8942@iogearbox.net>
Date:   Tue, 3 Sep 2019 21:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190830110732.8966-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25561/Tue Sep  3 10:24:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/30/19 1:07 PM, Ilya Leoshkevich wrote:
> Patch 1 is a preparatory commit, which introduces 64-bit endianness
> conversion functions.
> 
> Patch 2 fixes reading the wrong byte of an int.
> 
> Patch 3 improves error reporting.
> 
> Patch 4 uses the new conversion functions to fix wrong endianness of
> immediates.
> 
> v1->v2: Use bpf_ntohl and bpf_be64_to_cpu, drop __bpf_le64_to_cpu.
> v2->v3: Split bpf_be64_to_cpu introduction into a separate patch.
>          Use the new functions in test_lwt_seg6local.c and
> 	test_seg6_loop.c.
> v3->v4: Improved commit message, split fixes that are not related to
>          each other into separate patches.
> 
> Ilya Leoshkevich (4):
>    selftests/bpf: introduce bpf_cpu_to_be64 and bpf_be64_to_cpu
>    selftests/bpf: fix "ctx:write sysctl:write read ok" on s390
>    selftests/bpf: improve unexpected success reporting in test_syctl
>    selftests/bpf: fix endianness issues in test_sysctl
> 
>   tools/testing/selftests/bpf/bpf_endian.h      |  14 ++
>   .../selftests/bpf/progs/test_lwt_seg6local.c  |  16 +--
>   .../selftests/bpf/progs/test_seg6_loop.c      |   8 +-
>   tools/testing/selftests/bpf/test_sysctl.c     | 130 ++++++++++++------
>   4 files changed, 107 insertions(+), 61 deletions(-)
> 

Applied, thanks!
