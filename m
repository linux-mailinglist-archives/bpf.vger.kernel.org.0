Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113A11EC3CD
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 22:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgFBUhv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 16:37:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:58536 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgFBUhu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 16:37:50 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jgDfN-0003pZ-Ew; Tue, 02 Jun 2020 22:37:45 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jgDfN-0008hz-5w; Tue, 02 Jun 2020 22:37:45 +0200
Subject: Re: [PATCH bpf 0/2] Two fixes for make kselftest TARGETS=bpf
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <20200602175649.2501580-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fd33d451-c570-96b2-6e5d-c9945f0e465d@iogearbox.net>
Date:   Tue, 2 Jun 2020 22:37:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200602175649.2501580-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25831/Tue Jun  2 14:41:03 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/2/20 7:56 PM, Ilya Leoshkevich wrote:
> While the primary documented way to run BPF tests is by invoking
> make in tools/testing/selftests/bpf, kselftest documentation implies that
> make kselftest TARGETS=bpf from the top directory should work as well.
> This patch series contains two fixes that were neccesary to make it run:
> 
> - Patch 1: $(COMPILE.c) -> $(CC) $(CFLAGS) -c
> - Patch 2: Add CXX=$(CROSS_COMPILE)g++ default value
> 
> Ilya Leoshkevich (2):
>    tools/bpf: Don't use $(COMPILE.c)
>    selftests/bpf: Add a default $(CXX) value
> 
>   tools/bpf/Makefile                   | 6 +++---
>   tools/bpf/bpftool/Makefile           | 8 ++++----
>   tools/testing/selftests/bpf/Makefile | 1 +
>   3 files changed, 8 insertions(+), 7 deletions(-)

I've tested on x86-64 and arm64 as well, applied, thanks!
