Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A320FDBC
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 22:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgF3Ufc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 16:35:32 -0400
Received: from www62.your-server.de ([213.133.104.62]:41026 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgF3Ufc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 16:35:32 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jqMyX-0007NP-Tk; Tue, 30 Jun 2020 22:35:29 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jqMyX-000Aod-Jw; Tue, 30 Jun 2020 22:35:29 +0200
Subject: Re: [PATCH bpf 1/2] bpf: fix an incorrect branch elimination by
 verifier
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>
References: <20200630171240.2523628-1-yhs@fb.com>
 <20200630171240.2523722-1-yhs@fb.com>
 <CAEf4BzaTS3gQf0L_KhMu8b-asa3=Pq8H5f_sH=JjbWxy0Q70cQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <64bec9ba-1211-9412-3c34-c8c95ba364b9@iogearbox.net>
Date:   Tue, 30 Jun 2020 22:35:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaTS3gQf0L_KhMu8b-asa3=Pq8H5f_sH=JjbWxy0Q70cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25859/Tue Jun 30 15:38:05 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/30/20 9:18 PM, Andrii Nakryiko wrote:
> On Tue, Jun 30, 2020 at 11:46 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Wenbo reported an issue in [1] where a checking of null
>> pointer is evaluated as always false. In this particular
>> case, the program type is tp_btf and the pointer to
>> compare is a PTR_TO_BTF_ID.
>>
>> The current verifier considers PTR_TO_BTF_ID always
>> reprents a non-null pointer, hence all PTR_TO_BTF_ID compares
>> to 0 will be evaluated as always not-equal, which resulted
>> in the branch elimination.
>>
>> For example,
>>   struct bpf_fentry_test_t {
>>       struct bpf_fentry_test_t *a;
>>   };
>>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>>   {
>>       if (arg == 0)
>>           test7_result = 1;
>>       return 0;
>>   }
>>   int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
>>   {
>>       if (arg->a == 0)
>>           test8_result = 1;
>>       return 0;
>>   }
>>
>> In above bpf programs, both branch arg == 0 and arg->a == 0
>> are removed. This may not be what developer expected.
>>
>> The bug is introduced by Commit cac616db39c2 ("bpf: Verifier
>> track null pointer branch_taken with JNE and JEQ"),
>> where PTR_TO_BTF_ID is considered to be non-null when evaluting
>> pointer vs. scalar comparison. This may be added
>> considering we have PTR_TO_BTF_ID_OR_NULL in the verifier
>> as well.
>>
>> PTR_TO_BTF_ID_OR_NULL is added to explicitly requires
>> a non-NULL testing in selective cases. The current generic
>> pointer tracing framework in verifier always
>> assigns PTR_TO_BTF_ID so users does not need to
>> check NULL pointer at every pointer level like a->b->c->d.
>>
>> We may not want to assign every PTR_TO_BTF_ID as
>> PTR_TO_BTF_ID_OR_NULL as this will require a null test
>> before pointer dereference which may cause inconvenience
>> for developers. But we could avoid branch elimination
>> to preserve original code intention.
>>
>> This patch simply removed PTR_TO_BTD_ID from reg_type_not_null()
>> in verifier, which prevented the above branches from being eliminated.
>>
>>   [1]: https://lore.kernel.org/bpf/79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb.com/T/
>>
>> Fixes: cac616db39c2 ("bpf: Verifier track null pointer branch_taken with JNE and JEQ")
>> Cc: Andrii Nakryiko <andriin@fb.com>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: Wenbo Zhang <ethercflow@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> You missed Reported-by: tag, please add.

Agree, fixed up manually (and also pulled in your ACKs, Andrii).

Thanks,
Daniel
