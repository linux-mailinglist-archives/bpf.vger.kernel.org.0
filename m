Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DE132B32F
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhCCDtD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:49:03 -0500
Received: from www62.your-server.de ([213.133.104.62]:58404 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbhCBLPw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 06:15:52 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lH2z9-0006Sz-FQ; Tue, 02 Mar 2021 12:14:39 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lH2z9-000BzG-B4; Tue, 02 Mar 2021 12:14:39 +0100
Subject: Re: [PATCH] bpf: selftests: test_verifier: mask bpf_csum_diff()
 return value to 16 bits
To:     Yonghong Song <yhs@fb.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        bpf@vger.kernel.org
Cc:     toke@redhat.com
References: <20210228103017.320240-1-yauheni.kaliuta@redhat.com>
 <acf00517-6129-869b-cd2a-03715de5fc61@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <db5684bf-3757-3fdf-2581-002191f7a899@iogearbox.net>
Date:   Tue, 2 Mar 2021 12:14:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <acf00517-6129-869b-cd2a-03715de5fc61@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26095/Mon Mar  1 13:10:16 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/1/21 6:18 AM, Yonghong Song wrote:
> On 2/28/21 2:30 AM, Yauheni Kaliuta wrote:
>> The verifier test labelled "valid read map access into a read-only array
>> 2" calls the bpf_csum_diff() helper and checks its return value.
>> However, architecture implementations of csum_partial() (which is what
>> the helper uses) differ in whether they fold the return value to 16 bit
>> or not. For example, x86 version has:
>>
>>     if (unlikely(odd)) {
>>         result = from32to16(result);
>>         result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
>>     }
>>
>> while generic lib/checksum.c does:
>>
>>     result = from32to16(result);
>>     if (odd)
>>         result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
>>
>> This makes the helper return different values on different
>> architectures, breaking the test on non-x86. To fix this, add an
> 
> I remember there is a previous discussion for this issue, csum_diff()
> returns different results for different architecture? Daniel?
> Any conclusion how to deal with this?

I took in the test case fix for now. After getting cascading work for !x86-64,
we can always revert this one again. Plan of action to resume this work was
to at least update the other 64-bit archs successively to a no-fold variant as
well, so their arch specific implementations can mimic what x86-64 is doing.

>> additional instruction to always mask the return value to 16 bits, and
>> update the expected return value accordingly.
>>
>> Fixes: fb2abb73e575 ("bpf, selftest: test {rd, wr}only flags and direct value access")
>> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
>> ---
>>   tools/testing/selftests/bpf/verifier/array_access.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/verifier/array_access.c b/tools/testing/selftests/bpf/verifier/array_access.c
>> index bed53b561e04..1b138cd2b187 100644
>> --- a/tools/testing/selftests/bpf/verifier/array_access.c
>> +++ b/tools/testing/selftests/bpf/verifier/array_access.c
>> @@ -250,12 +250,13 @@
>>       BPF_MOV64_IMM(BPF_REG_5, 0),
>>       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
>>                BPF_FUNC_csum_diff),
>> +    BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffff),
>>       BPF_EXIT_INSN(),
>>       },
>>       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>>       .fixup_map_array_ro = { 3 },
>>       .result = ACCEPT,
>> -    .retval = -29,
>> +    .retval = 65507,
>>   },
>>   {
>>       "invalid write map access into a read-only array 1",
>>

