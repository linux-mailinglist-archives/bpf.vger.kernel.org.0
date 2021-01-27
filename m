Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436F43067E0
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 00:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhA0X1j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 18:27:39 -0500
Received: from www62.your-server.de ([213.133.104.62]:59422 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbhA0XZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 18:25:13 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l4uAp-0000k3-Tq; Thu, 28 Jan 2021 00:24:31 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1l4uAp-000Ma9-Q5; Thu, 28 Jan 2021 00:24:31 +0100
Subject: Re: [PATCH bpf-next] selftest/bpf: testing for multiple logs on
 REJECT
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf@vger.kernel.org
References: <20210124190532.428065-1-andreimatei1@gmail.com>
 <7d33b412-260f-f4d6-2ed0-b5076dc37179@iogearbox.net>
 <CABWLset0EgvNF5nCdYHNMaqYFg8MYZfqpHren41EuRP1Azax-w@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <82196381-fcd3-c70d-2df3-1515d2a4dd24@iogearbox.net>
Date:   Thu, 28 Jan 2021 00:24:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CABWLset0EgvNF5nCdYHNMaqYFg8MYZfqpHren41EuRP1Azax-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26062/Wed Jan 27 13:26:15 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/27/21 3:31 AM, Andrei Matei wrote:
> On Tue, Jan 26, 2021 at 6:21 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 1/24/21 8:05 PM, Andrei Matei wrote:
>>> This patch adds support to verifier tests to check for a succession of
>>> verifier log messages on program load failure. This makes the
>>> errstr field work uniformly across REJECT and VERBOSE_ACCEPT checks.
>>>
>>> This patch also increases the maximum size of an accepted series of
>>> messages to test from 80 chars to 200 chars. This is in order to keep
>>> existing tests working, which sometimes test for messages larger than 80
>>> chars (which was accepted in the REJECT case, when testing for a single
>>> message, but ironically not in the VERBOSE_ACCEPT case, when testing for
>>> possibly multiple messages).
>>> And example of such a long, checked message is in bounds.c:
>>> "R1 has unknown scalar with mixed signed bounds, pointer arithmetic with
>>> it prohibited for !root"
>>>
>>> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
>>> ---
>>>    tools/testing/selftests/bpf/test_verifier.c | 15 ++++++++++++---
>>>    1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
>>> index 59bfa6201d1d..69298bf8ee86 100644
>>> --- a/tools/testing/selftests/bpf/test_verifier.c
>>> +++ b/tools/testing/selftests/bpf/test_verifier.c
>>> @@ -88,6 +88,9 @@ struct bpf_test {
>>>        int fixup_map_event_output[MAX_FIXUPS];
>>>        int fixup_map_reuseport_array[MAX_FIXUPS];
>>>        int fixup_map_ringbuf[MAX_FIXUPS];
>>> +     /* Expected verifier log output for result REJECT or VERBOSE_ACCEPT. Can be a
>>> +      * tab-separated sequence of expected strings.
>>> +      */
>>>        const char *errstr;
>>>        const char *errstr_unpriv;
>>>        uint32_t insn_processed;
>>> @@ -995,9 +998,11 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
>>>        return 0;
>>>    }
>>>
>>> +/* Returns true if every part of exp (tab-separated) appears in log, in order.
>>> + */
>>>    static bool cmp_str_seq(const char *log, const char *exp)
>>>    {
>>> -     char needle[80];
>>> +     char needle[200];
>>>        const char *p, *q;
>>>        int len;
>>>
>>> @@ -1015,7 +1020,7 @@ static bool cmp_str_seq(const char *log, const char *exp)
>>>                needle[len] = 0;
>>>                q = strstr(log, needle);
>>>                if (!q) {
>>> -                     printf("FAIL\nUnexpected verifier log in successful load!\n"
>>> +                     printf("FAIL\nUnexpected verifier log!\n"
>>>                               "EXP: %s\nRES:\n", needle);
>>>                        return false;
>>>                }
>>> @@ -1130,7 +1135,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>>>                        printf("FAIL\nUnexpected success to load!\n");
>>>                        goto fail_log;
>>>                }
>>> -             if (!expected_err || !strstr(bpf_vlog, expected_err)) {
>>> +             if (!expected_err) {
>>> +                     printf("FAIL\nTestcase bug; missing expected_err\n");
>>> +                     goto fail_log;
>>
>> Do we have an in-tree case like this?
> 
> You're asking if there are tests with expected_res == REJECT and
> expected_err == NULL?
> There are no such test cases, and the intention of this "testcase bug"
> check was to keep it that way.
> I can simply fold it into the test failure below, as you're suggesting.

Yeah, I would just fold it given such issue would be visible there as well.

>> Given this would also be visible below with 'EXP:'
>> being (null), I might simplify and just replace the strstr() with cmp_str_seq().
>>
>> Also, could you elaborate on which test cases need the cmp_str_seq() conversion?
> 
> There are VERBOSE_ACCEPT tests that you a tab-separated list of
> expected messages; see precise.c.
> There are no such REJECT tests yet. I was about to introduce one in
> another patch that's inflight, but I ended
> up not needing to. Still, I figured that unifying the capabilities of
> .errstr between VERBOSE_ACCEPT and REJECT
> is a good idea.
I think unifying seems reasonable, lets do then.

Thanks,
Daniel
