Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1073F23276F
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 00:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgG2WMl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 18:12:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:45276 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 18:12:40 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0uJQ-0001f4-63; Thu, 30 Jul 2020 00:12:36 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0uJQ-0006xP-0A; Thu, 30 Jul 2020 00:12:36 +0200
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
 <b6cbb797-02c4-d904-5231-54608706f99d@iogearbox.net>
 <CAEf4Bzarzp1a_XBy33ULKaYmh0muHtDAr61EZNUEd2rJrZ3j7g@mail.gmail.com>
 <f96ed8e0-66d2-fef5-14a4-8930a1ef759e@iogearbox.net>
 <CAEf4BzbD=e8x8BEBCic+5DHcCewZUfp1h3JSj5zRQ9i2KW1-dQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6177128b-bef5-7445-bf00-8051f8efa3bc@iogearbox.net>
Date:   Thu, 30 Jul 2020 00:12:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbD=e8x8BEBCic+5DHcCewZUfp1h3JSj5zRQ9i2KW1-dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25888/Wed Jul 29 16:57:45 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/30/20 12:05 AM, Andrii Nakryiko wrote:
> On Wed, Jul 29, 2020 at 2:54 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 7/29/20 11:36 PM, Andrii Nakryiko wrote:
>>> On Wed, Jul 29, 2020 at 2:01 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> On 7/29/20 6:06 AM, Andrii Nakryiko wrote:
>>>>> On Tue, Jul 28, 2020 at 2:16 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>>> On 7/28/20 9:11 PM, Andrii Nakryiko wrote:
>>>>>>> On Tue, Jul 28, 2020 at 5:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>>>>>>>
>>>>>>>> Yet another adaptation to commit 0ebeea8ca8a4 ("bpf: Restrict
>>>>>>>> bpf_probe_read{, str}() only to archs where they work") that makes more
>>>>>>>> samples compile on s390.
>>>>>>>>
>>>>>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>>>>
>>>>>>> Sorry, we can't do this yet. This will break on older kernels that
>>>>>>> don't yet have bpf_probe_read_kernel() implemented. Met and Yonghong
>>>>>>> are working on extending a set of CO-RE relocations, that would allow
>>>>>>> to do bpf_probe_read_kernel() detection on BPF side, transparently for
>>>>>>> an application, and will pick either bpf_probe_read() or
>>>>>>> bpf_probe_read_kernel(). It should be ready soon (this or next week,
>>>>>>> most probably), though it will have dependency on the latest Clang.
>>>>>>> But for now, please don't change this.
>>>>>>
>>>>>> Could you elaborate what this means wrt dependency on latest clang? Given clang
>>>>>> releases have a rather long cadence, what about existing users with current clang
>>>>>> releases?
>>>>>
>>>>> So the overall idea is to use something like this to do kernel reads:
>>>>>
>>>>> static __always_inline int bpf_probe_read_universal(void *dst, u32 sz,
>>>>> const void *src)
>>>>> {
>>>>>        if (bpf_core_type_exists(btf_bpf_probe_read_kernel))
>>>>>            return bpf_probe_read_kernel(dst, sz, src);
>>>>>        else
>>>>>            return bpf_probe_read(dst, sz, src);
>>>>> }
>>>>>
>>>>> And then use bpf_probe_read_universal() in BPF_CORE_READ and family.
>>>>>
>>>>> This approach relies on few things:
>>>>>
>>>>> 1. each BPF helper has a corresponding btf_<helper-name> type defined for it
>>>>> 2. bpf_core_type_exists(some_type) returns 0 or 1, depending if
>>>>> specified type is found in kernel BTF (so needs kernel BTF, of
>>>>> course). This is the part me and Yonghong are working on at the
>>>>> moment.
>>>>> 3. verifier's dead code elimination, which will leave only
>>>>> bpf_probe_read() or bpf_probe_read_kernel() calls and will remove the
>>>>> other one. So on older kernels, there will never be unsupoorted call
>>>>> to bpf_probe_read_kernel().
>>>>>
>>>>> The new type existence relocation requires the latest Clang. So the
>>>>> way to deal with older Clangs would be to just fallback to
>>>>> bpf_probe_read, if we detect that Clang is too old and can't emit
>>>>> necessary relocation.
>>>>
>>>> Okay, seems reasonable overall. One question though: couldn't libbpf transparently
>>>> fix up the selection of bpf_probe_read() vs bpf_probe_read_kernel()? E.g. it would
>>>> probe the kernel whether bpf_probe_read_kernel() is available and if it is then it
>>>> would rewrite the raw call number from the instruction from bpf_probe_read() into
>>>> the one for bpf_probe_read_kernel()? I guess the question then becomes whether the
>>>> original use for bpf_probe_read() was related to CO-RE. But I think this could also
>>>> be overcome by adding a fake helper signature in libbpf with a unreasonable high
>>>> number that is dedicated to probing mem via CO-RE and then libbpf picks the right
>>>> underlying helper call number for the insn. That avoids fiddling with macros and
>>>> need for new clang version, no (unless I'm missing something)?
>>>
>>> Libbpf could do it, but I'm a bit worried that unconditionally
>>> changing bpf_probe_read() into bpf_probe_read_kernel() is going to be
>>> wrong in some cases. If that wasn't the case, why wouldn't we just
>>> re-purpose bpf_probe_read() into bpf_probe_read_kernel() in kernel
>>> itself, right?
>>
>> Yes, that is correct, but I mentioned above that this new 'fake' helper call number
>> that libbpf would be fixing up would only be used for bpf_probe_read{,str}() inside
>> bpf_core_read.h.
>>
>> Small example, bpf_core_read.h would be changed to (just an extract):
>>
>> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
>> index eae5cccff761..4bddb2ddf3f0 100644
>> --- a/tools/lib/bpf/bpf_core_read.h
>> +++ b/tools/lib/bpf/bpf_core_read.h
>> @@ -115,7 +115,7 @@ enum bpf_field_info_kind {
>>     * (local) BTF, used to record relocation.
>>     */
>>    #define bpf_core_read(dst, sz, src)                                        \
>> -       bpf_probe_read(dst, sz,                                             \
>> +       bpf_probe_read_selector(dst, sz,                                                    \
>>                          (const void *)__builtin_preserve_access_index(src))
>>
>>    /*
>> @@ -124,7 +124,7 @@ enum bpf_field_info_kind {
>>     * argument.
>>     */
>>    #define bpf_core_read_str(dst, sz, src)                                            \
>> -       bpf_probe_read_str(dst, sz,                                         \
>> +       bpf_probe_read_str_selector(dst, sz,                                        \
>>                              (const void *)__builtin_preserve_access_index(src))
>>
>>    #define ___concat(a, b) a ## b
>>
>> And bpf_probe_read_{,str_}selector would be defined as e.g. ...
>>
>> static long (*bpf_probe_read_selector)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) -1;
>> static long (*bpf_probe_read_str_selector)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) -2;
>>
>> ... where libbpf would do the fix up to either 4 or 45 for insn->imm. But it's still
>> confined to usage in bpf_core_read.h when the CO-RE macros are used.
> 
> Ah, I see. Yeah, I suppose that would work as well. Do you prefer me
> to go this way?

I would suggest we should try this path given this can be used with any clang version
that has the BPF backend, not just latest upstream git.

Thanks,
Daniel
