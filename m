Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212F943A6C8
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhJYWqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 18:46:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:48192 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhJYWqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 18:46:40 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mf8hR-000FhX-QT; Tue, 26 Oct 2021 00:44:13 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mf8hR-0007ku-KZ; Tue, 26 Oct 2021 00:44:13 +0200
Subject: Re: [PATCH bpf-next v2 1/5] libbpf: Use __BYTE_ORDER__
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211025131214.731972-1-iii@linux.ibm.com>
 <20211025131214.731972-2-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <167b9b31-2568-4d7f-9e08-f8fc93ea04b4@iogearbox.net>
Date:   Tue, 26 Oct 2021 00:44:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211025131214.731972-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26333/Mon Oct 25 10:29:40 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/25/21 3:12 PM, Ilya Leoshkevich wrote:
> __BYTE_ORDER is supposed to be defined by a libc, and __BYTE_ORDER__ -
> by a compiler. bpf_core_read.h checks __BYTE_ORDER == __LITTLE_ENDIAN,
> which is true if neither are defined, leading to incorrect behavior on
> big-endian hosts if libc headers are not included, which is often the
> case.
> 
> Instead of changing just this particular location, replace all
> occurrences of __BYTE_ORDER with __BYTE_ORDER__ in libbpf code for
> consistency.

ACK, that is definitely broken as is - we had similar issue back then with the
bpf_{htons,ntohs}() helpers, details: 78a5a93c1eeb ("bpf, tests: fix endianness
selection").

The bpf_core_read.h change I would split out as a separate commit along with a
proper Fixes tag so it could potentially be cherry-picked easier (since the
remainder in here is a cleanup for consistency and not used out of the BPF prog
where this issue exists).

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/lib/bpf/bpf_core_read.h |  2 +-
>   tools/lib/bpf/btf.c           |  4 ++--
>   tools/lib/bpf/btf_dump.c      |  8 ++++----
>   tools/lib/bpf/libbpf.c        |  4 ++--
>   tools/lib/bpf/linker.c        | 12 ++++++------
>   tools/lib/bpf/relo_core.c     |  2 +-
>   6 files changed, 16 insertions(+), 16 deletions(-)

Thanks,
Daniel
