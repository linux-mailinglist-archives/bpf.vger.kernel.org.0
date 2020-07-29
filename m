Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06223268E
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 23:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgG2VBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 17:01:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:35100 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 17:01:43 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0tCk-0003Tx-0g; Wed, 29 Jul 2020 23:01:38 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0tCj-00039R-Px; Wed, 29 Jul 2020 23:01:37 +0200
Subject: Re: [PATCH bpf-next 3/3] libbpf: Use bpf_probe_read_kernel
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20200728120059.132256-1-iii@linux.ibm.com>
 <20200728120059.132256-4-iii@linux.ibm.com>
 <CAEf4BzaSJp-fOn2MG_8Fc2mo9ji5gZBLn2xCGyCiAmPbHkqSQQ@mail.gmail.com>
 <bea74a32-746c-c310-67c8-477dcd442fb3@iogearbox.net>
 <CAEf4BzZtsOF0iuWrtBn7Up2zZFv79PvF5TC1RukBxQBxpN4pFQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b6cbb797-02c4-d904-5231-54608706f99d@iogearbox.net>
Date:   Wed, 29 Jul 2020 23:01:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZtsOF0iuWrtBn7Up2zZFv79PvF5TC1RukBxQBxpN4pFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25888/Wed Jul 29 16:57:45 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/29/20 6:06 AM, Andrii Nakryiko wrote:
> On Tue, Jul 28, 2020 at 2:16 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 7/28/20 9:11 PM, Andrii Nakryiko wrote:
>>> On Tue, Jul 28, 2020 at 5:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>>>
>>>> Yet another adaptation to commit 0ebeea8ca8a4 ("bpf: Restrict
>>>> bpf_probe_read{, str}() only to archs where they work") that makes more
>>>> samples compile on s390.
>>>>
>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>
>>> Sorry, we can't do this yet. This will break on older kernels that
>>> don't yet have bpf_probe_read_kernel() implemented. Met and Yonghong
>>> are working on extending a set of CO-RE relocations, that would allow
>>> to do bpf_probe_read_kernel() detection on BPF side, transparently for
>>> an application, and will pick either bpf_probe_read() or
>>> bpf_probe_read_kernel(). It should be ready soon (this or next week,
>>> most probably), though it will have dependency on the latest Clang.
>>> But for now, please don't change this.
>>
>> Could you elaborate what this means wrt dependency on latest clang? Given clang
>> releases have a rather long cadence, what about existing users with current clang
>> releases?
> 
> So the overall idea is to use something like this to do kernel reads:
> 
> static __always_inline int bpf_probe_read_universal(void *dst, u32 sz,
> const void *src)
> {
>      if (bpf_core_type_exists(btf_bpf_probe_read_kernel))
>          return bpf_probe_read_kernel(dst, sz, src);
>      else
>          return bpf_probe_read(dst, sz, src);
> }
> 
> And then use bpf_probe_read_universal() in BPF_CORE_READ and family.
> 
> This approach relies on few things:
> 
> 1. each BPF helper has a corresponding btf_<helper-name> type defined for it
> 2. bpf_core_type_exists(some_type) returns 0 or 1, depending if
> specified type is found in kernel BTF (so needs kernel BTF, of
> course). This is the part me and Yonghong are working on at the
> moment.
> 3. verifier's dead code elimination, which will leave only
> bpf_probe_read() or bpf_probe_read_kernel() calls and will remove the
> other one. So on older kernels, there will never be unsupoorted call
> to bpf_probe_read_kernel().
> 
> The new type existence relocation requires the latest Clang. So the
> way to deal with older Clangs would be to just fallback to
> bpf_probe_read, if we detect that Clang is too old and can't emit
> necessary relocation.

Okay, seems reasonable overall. One question though: couldn't libbpf transparently
fix up the selection of bpf_probe_read() vs bpf_probe_read_kernel()? E.g. it would
probe the kernel whether bpf_probe_read_kernel() is available and if it is then it
would rewrite the raw call number from the instruction from bpf_probe_read() into
the one for bpf_probe_read_kernel()? I guess the question then becomes whether the
original use for bpf_probe_read() was related to CO-RE. But I think this could also
be overcome by adding a fake helper signature in libbpf with a unreasonable high
number that is dedicated to probing mem via CO-RE and then libbpf picks the right
underlying helper call number for the insn. That avoids fiddling with macros and
need for new clang version, no (unless I'm missing something)?

> If that's not an acceptable plan, then one can "parameterize"
> BPF_CORE_READ macro family by re-defining bpf_core_read() macro. Right
> now it's defined as:
> 
> #define bpf_core_read(dst, sz, src) \
>      bpf_probe_read(dst, sz, (const void *)__builtin_preserve_access_index(src))
> 
> Re-defining it in terms of bpf_probe_read_kernel is trivial, but I
> can't do it for BPF_CORE_READ, because it will break all the users of
> bpf_core_read.h that run on older kernels.
> 
> 
>>
>>>>    tools/lib/bpf/bpf_core_read.h | 51 ++++++++++++++++++-----------------
>>>>    tools/lib/bpf/bpf_tracing.h   | 15 +++++++----
>>>>    2 files changed, 37 insertions(+), 29 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>

