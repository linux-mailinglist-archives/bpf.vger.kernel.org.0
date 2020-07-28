Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9623147D
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 23:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgG1VQT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 17:16:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:33730 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1VQS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 17:16:18 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0WxL-0003eG-8X; Tue, 28 Jul 2020 23:16:15 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0WxL-0004KJ-26; Tue, 28 Jul 2020 23:16:15 +0200
Subject: Re: [PATCH bpf-next 3/3] libbpf: Use bpf_probe_read_kernel
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20200728120059.132256-1-iii@linux.ibm.com>
 <20200728120059.132256-4-iii@linux.ibm.com>
 <CAEf4BzaSJp-fOn2MG_8Fc2mo9ji5gZBLn2xCGyCiAmPbHkqSQQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bea74a32-746c-c310-67c8-477dcd442fb3@iogearbox.net>
Date:   Tue, 28 Jul 2020 23:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaSJp-fOn2MG_8Fc2mo9ji5gZBLn2xCGyCiAmPbHkqSQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25887/Tue Jul 28 17:44:20 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/28/20 9:11 PM, Andrii Nakryiko wrote:
> On Tue, Jul 28, 2020 at 5:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>
>> Yet another adaptation to commit 0ebeea8ca8a4 ("bpf: Restrict
>> bpf_probe_read{, str}() only to archs where they work") that makes more
>> samples compile on s390.
>>
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> Sorry, we can't do this yet. This will break on older kernels that
> don't yet have bpf_probe_read_kernel() implemented. Met and Yonghong
> are working on extending a set of CO-RE relocations, that would allow
> to do bpf_probe_read_kernel() detection on BPF side, transparently for
> an application, and will pick either bpf_probe_read() or
> bpf_probe_read_kernel(). It should be ready soon (this or next week,
> most probably), though it will have dependency on the latest Clang.
> But for now, please don't change this.

Could you elaborate what this means wrt dependency on latest clang? Given clang
releases have a rather long cadence, what about existing users with current clang
releases?

>>   tools/lib/bpf/bpf_core_read.h | 51 ++++++++++++++++++-----------------
>>   tools/lib/bpf/bpf_tracing.h   | 15 +++++++----
>>   2 files changed, 37 insertions(+), 29 deletions(-)
>>
> 
> [...]
> 

