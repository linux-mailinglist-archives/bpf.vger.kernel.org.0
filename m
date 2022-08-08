Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9331458CB6A
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiHHPnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHPm7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:42:59 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0010D1E8;
        Mon,  8 Aug 2022 08:42:57 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oL4u1-000GLV-Pr; Mon, 08 Aug 2022 17:42:49 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oL4u1-000SiB-FQ; Mon, 08 Aug 2022 17:42:49 +0200
Subject: Re: Fwd: [PATCH bpf] bpf: Do more tight ALU bounds tracking
To:     Kuee k1r0a <liulin063@gmail.com>, haoluo@google.com
Cc:     Alexei Starovoitov <ast@kernel.org>, john.fastabend@gmail.com,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CA+khW7iknv0hcn-D2tRt8HFseUnyTV7BwpohQHtEyctbA1k27w@mail.gmail.com>
 <20220729224254.1798-1-liulin063@gmail.com>
 <CA+khW7iLeSZPweZEz_tfP+LRtpvZbfvstZWgUbNrEDK-Ntxyxw@mail.gmail.com>
 <ccafa637-d986-b4e3-73e0-03721a940ce1@iogearbox.net>
 <CANdZH3U7axKg6zDY+iswF2d1fBYY1Xo2jeVsbgMYMoJfd1AYJg@mail.gmail.com>
 <CANdZH3V64LdfYpWrX9teQQU8LGj10_ecXpupRfnyKQ47gvtOoQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9f954e67-67fc-e3b9-d810-22bfea95d2aa@iogearbox.net>
Date:   Mon, 8 Aug 2022 17:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANdZH3V64LdfYpWrX9teQQU8LGj10_ecXpupRfnyKQ47gvtOoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26621/Mon Aug  8 09:52:38 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/8/22 5:14 PM, Kuee k1r0a wrote:
> ---------- Forwarded message ---------
> From: Kuee k1r0a <liulin063@gmail.com>
> Date: Mon, Aug 8, 2022 at 11:11 PM
> Subject: Re: [PATCH bpf] bpf: Do more tight ALU bounds tracking
> To: Daniel Borkmann <daniel@iogearbox.net>
> 
> 
> On Mon, Aug 8, 2022 at 9:25 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 7/30/22 12:48 AM, Hao Luo wrote:
>>> On Fri, Jul 29, 2022 at 3:43 PM Youlin Li <liulin063@gmail.com> wrote:
>>>>
>>>> In adjust_scalar_min_max_vals(), let 32bit bounds learn from 64bit bounds
>>>> to get more tight bounds tracking. Similar operation can be found in
>>>> reg_set_min_max().
>>>>
>>>> Also, we can now fold reg_bounds_sync() into zext_32_to_64().
>>>>
>>>> Before:
>>>>
>>>>       func#0 @0
>>>>       0: R1=ctx(off=0,imm=0) R10=fp0
>>>>       0: (b7) r0 = 0                        ; R0_w=0
>>>>       1: (b7) r1 = 0                        ; R1_w=0
>>>>       2: (87) r1 = -r1                      ; R1_w=scalar()
>>>>       3: (87) r1 = -r1                      ; R1_w=scalar()
>>>>       4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>>>>       5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0xffffffff))  <--- [*]
>>>>       6: (95) exit
>>>>
>>>> It can be seen that even if the 64bit bounds is clear here, the 32bit
>>>> bounds is still in the state of 'UNKNOWN'.
>>>>
>>>> After:
>>>>
>>>>       func#0 @0
>>>>       0: R1=ctx(off=0,imm=0) R10=fp0
>>>>       0: (b7) r0 = 0                        ; R0_w=0
>>>>       1: (b7) r1 = 0                        ; R1_w=0
>>>>       2: (87) r1 = -r1                      ; R1_w=scalar()
>>>>       3: (87) r1 = -r1                      ; R1_w=scalar()
>>>>       4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>>>>       5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0x3))  <--- [*]
>>>>       6: (95) exit
>>>>
>>>> Signed-off-by: Youlin Li <liulin063@gmail.com>
>>>
>>> Looks good to me. Thanks Youlin.
>>>
>>> Acked-by: Hao Luo <haoluo@google.com>
>>
>> Thanks Youlin! Looks like the patch breaks CI [0] e.g.:
>>
>>     #142/p bounds check after truncation of non-boundary-crossing range FAIL
>>     Failed to load prog 'Permission denied'!
>>     invalid access to map value, value_size=8 off=16777215 size=1
>>     R0 max value is outside of the allowed memory range
>>     verification time 296 usec
>>     stack depth 8
>>     processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>
>> Please take a look. Also it would be great to add a test_verifier selftest to
>> assert above case from commit log against future changes.
>>
>> Thanks,
>> Daniel
>>
>>     [0] https://github.com/kernel-patches/bpf/runs/7696324041?check_suite_focus=true
> 
> This test case fails because the 32bit boundary information is lost
> after the 11th instruction is executed:
> Before:
>      11: (07) r1 += 2147483647             ;
> R1_w=scalar(umin=70866960383,umax=70866960638,var_off=(0x1000000000;
> 0xffffffff),u32_min=2147483647,u32_max=-2147483394)
> After:
>      11: (07) r1 += 2147483647             ;
> R1_w=scalar(umin=70866960383,umax=70866960638,var_off=(0x1000000000;
> 0xffffffff))
> 
> This may be because, in previous versions of the code, when
> __reg_combine_64_into_32() was called, the 32bit boundary was
> completely deduced from the 64bit boundary, so there was a call to
> __mark_reg32_unbounded() in __reg_combine_64_into_32().
> 
> But now, before adjust_scalar_min_max_vals() calls
> __reg_combine_64_into_32() , the 32bit bounds are already calculated
> to some extent, and __mark_reg32_unbounded() will eliminate these
> information.
> 
> Simply copying a code without __mark_reg32_unbounded() should work,
> perhaps it would be more elegant to introduce a flag into
> __reg_combine_64_into_32()?
> 
> Sorry for not completing the tests because I did not 'make selftests'
> successfully, and uploaded the code that caused the error.

Under tools/testing/selftests/bpf/, you can run test_progs and test_verifier
through the vmtest script, e.g. `./vmtest.sh -- ./test_progs` should ease
running it. The whole `make selftests` is not necessary given here we care
about BPF, CI is running these where 2 failed and need investigation:

           test_progs: PASS
  test_progs-no_alu32: FAIL (returned 1)
            test_maps: PASS
        test_verifier: FAIL (returned 1)

Fwiw, for the test_verifier failure case at least, we should then adapt it
in a separate commit with an analysis explaining why it is okay to alter the
test; plus a 3rd commit adding new test cases as mentioned earlier.

Thanks a lot, Kuee!
Daniel
