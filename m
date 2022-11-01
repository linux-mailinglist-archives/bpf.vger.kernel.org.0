Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E260614CED
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 15:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKAOmk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiKAOmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 10:42:37 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EE1120B8
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 07:42:36 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1opsAY-0006E7-QX; Tue, 01 Nov 2022 15:23:10 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1opsAY-0009SD-GJ; Tue, 01 Nov 2022 15:23:10 +0100
Subject: Re: [PATCH bpf-next] selftests: fix test group SKIPPED result
To:     Mykola Lysenko <mykolal@meta.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Martin Lau <kafai@meta.com>, Kernel Team <Kernel-team@fb.com>
References: <20221028175530.1413351-1-cerasuolodomenico@gmail.com>
 <635c64abe004c_b1ba20850@john.notmuch>
 <DC4AB44C-734B-46BC-A9E2-9A24C56F7F9A@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7cedf721-0438-ba98-1e9a-7a07985d88b1@iogearbox.net>
Date:   Tue, 1 Nov 2022 15:23:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <DC4AB44C-734B-46BC-A9E2-9A24C56F7F9A@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26706/Tue Nov  1 08:52:34 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Mykola, hi Domenico,

On 11/1/22 12:44 AM, Mykola Lysenko wrote:
> Hi John,
> 
> Test FAILs when there is an unexpected condition during test/subtest execution, developer does not control it. Hence we propagate FAIL subtest result to be the test result, test_progs result and consequently CI result.
> On the other hand, SKIP state is fully controlled by us. E.g. we decide when particular subtest/test should be skipped. We do not propagate SKIP state to the test_progs result. test_progs result can either be OK or FAIL. Also, SKIPPED subtest is not an indication of a problem in a test. Hence, I do not think one SKIPPED subtest should mark the whole test as SKIPPED.
> 
> For example, core_reloc_btfgen has 77 subtests (https://github.com/kernel-patches/bpf/actions/runs/3349035937/jobs/5548924891#step:6:4895). Some of them are skipped right now. However, most of them are passing. It is a normal state. For me, marking core_reloc_btfgen as SKIP would mean that something is not right with the whole test. Also, I do not think we are reviewing SKIP tests / subtests right now. Maybe we should. But this would be orthogonal discussion to this patch.

I think parts of the above should probably be incorporated into the below
commit description to better explain the rationale for the change.

>> On Oct 28, 2022, at 4:24 PM, John Fastabend <john.fastabend@gmail.com> wrote:
>>
>> Domenico Cerasuolo wrote:
>>> From: Domenico Cerasuolo <dceras@meta.com>
>>>
>>> When showing the result of a test group, if one
>>> of the subtests was skipped, while still having
>>> passing subtets, the group result was marked as

nit: subtets

>>> SKIPPED.
>>>
>>> #223/1   usdt/basic:SKIP
>>> #223/2   usdt/multispec:OK
>>> #223     usdt:SKIP
>>>
>>> With this change only if all of the subtests
>>> were skipped the group test is marked as SKIPPED.
>>>
>>> #223/1   usdt/basic:SKIP
>>> #223/2   usdt/multispec:OK
>>> #223     usdt:OK
>>
>> I'm not sure don't you want to know that some of the tests
>> were skipped? With this change its not knowable from output
>> if everything passed or one passed.
>>
>> I would prefer the behavior: If anything fails return
>> FAIL, else if anything is skipped SKIP and if _everything_
>> passes mark it OK.
>>
>> My preference is to drop this change.

I guess for manual testing you could just grep for usdt and see all subtest
results. I think changing from SKIP to OK is fine, but could we indicate e.g.
"usdt:OK (SKIP:1/2)" to differ from "usdt:OK" where nothing had to be skipped?
Presumably this would address John's concern, too.

>>> Signed-off-by: Domenico Cerasuolo <dceras@meta.com>
>>> ---
>>> tools/testing/selftests/bpf/test_progs.c | 11 +++++++++--
>>> 1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
>>> index 0e9a47f97890..14b70393018b 100644
>>> --- a/tools/testing/selftests/bpf/test_progs.c
>>> +++ b/tools/testing/selftests/bpf/test_progs.c
>>> @@ -222,6 +222,11 @@ static char *test_result(bool failed, bool skipped)
>>> 	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
>>> }
>>>
>>> +static char *test_group_result(int tests_count, bool failed, int skipped)
>>> +{
>>> +	return failed ? "FAIL" : (skipped == tests_count ? "SKIP" : "OK");
>>> +}
>>> +
>>> static void print_test_log(char *log_buf, size_t log_cnt)
>>> {
>>> 	log_buf[log_cnt] = '\0';
>>> @@ -308,7 +313,8 @@ static void dump_test_log(const struct prog_test_def *test,
>>> 	}
>>>
>>> 	print_test_name(test->test_num, test->test_name,
>>> -			test_result(test_failed, test_state->skip_cnt));
>>> +			test_group_result(test_state->subtest_num,
>>> +				test_failed, test_state->skip_cnt));
>>> }
>>>
>>> static void stdio_restore(void);
>>> @@ -1071,7 +1077,8 @@ static void run_one_test(int test_num)
>>>
>>> 	if (verbose() && env.worker_id == -1)
>>> 		print_test_name(test_num + 1, test->test_name,
>>> -				test_result(state->error_cnt, state->skip_cnt));
>>> +				test_group_result(state->subtest_num,
>>> +					state->error_cnt, state->skip_cnt));
>>>
>>> 	reset_affinity();
>>> 	restore_netns();
>>> -- 
>>> 2.30.2
>>>
>>
>>
> 

