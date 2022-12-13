Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1764B86E
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 16:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLMPao (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 10:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiLMPal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 10:30:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 537461DA65;
        Tue, 13 Dec 2022 07:30:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A74D62F4;
        Tue, 13 Dec 2022 07:31:20 -0800 (PST)
Received: from [10.57.9.141] (unknown [10.57.9.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E9843F71E;
        Tue, 13 Dec 2022 07:30:38 -0800 (PST)
Message-ID: <634087f2-1a7a-0f61-51e8-9e6068d59e9d@arm.com>
Date:   Tue, 13 Dec 2022 15:30:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/4] Add VG register attr test with kernel version and
 feature detection
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20221213114739.2312862-1-james.clark@arm.com>
 <Y5iRhKrIb5pXOaKk@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y5iRhKrIb5pXOaKk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 13/12/2022 14:51, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 13, 2022 at 11:47:35AM +0000, James Clark escreveu:
>> I didn't get any feedback on the RFC version of this that I posted a
>> while back [1]. I'd still like to add the test, especially now that
>> 6.1 has been released with this new feature, so I've rebased it onto
>> perf/core and double checked that it's still working.
>>
>> Applies to perf/core (0c3852adae83)
> 
> I'm applying this locally, would this be testable on a Firefly (roc-rk3399-pc):

Thanks Arnaldo. It doesn't look like rk3399 has SVE, so
test-record-user-regs-no-sve-aarch64 will run to check that the kernel
won't give you the new register. So I suppose the answer to the question
is partially.

For test-record-user-regs-sve-aarch64, I've been running it on a
Graviton 3 on AWS which has SVE:

  ubuntu@ip-10-252-130-213:~/linux$ head /proc/cpuinfo
  processor	: 0
  BogoMIPS	: 2100.00
  Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
asimdhp cpuid asimdrdm jscvt fcma lrcpc dcpop sha3 sm3 sm4 asimddp
sha512 sve asimdfhm dit uscat ilrcpc flagm ssbs paca pacg dcpodp svei8mm
svebf16 i8mm bf16 dgh rng
  CPU implementer	: 0x41
  CPU architecture: 8
  CPU variant	: 0x1
  CPU part	: 0xd40
  CPU revision	: 1

  processor	: 1

> 
> acme@roc-rk3399-pc:~$ head /proc/cpuinfo
> processor	: 0
> BogoMIPS	: 48.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> CPU implementer	: 0x41
> CPU architecture: 8
> CPU variant	: 0x0
> CPU part	: 0xd03
> CPU revision	: 4
> 
> processor	: 1
> acme@roc-rk3399-pc:~$
> 
> - Arnaldo
>  
>> Thanks
>> James
>>
>> [1]: https://lore.kernel.org/bpf/20220927154104.869029-1-james.clark@arm.com/
>>
>> James Clark (4):
>>   perf test: Add ability to test exit code for attr tests
>>   perf test: Add mechanism for skipping attr tests on auxiliary vector
>>     values
>>   perf test: Add mechanism for skipping attr tests on kernel versions
>>   perf test arm64: Add attr tests for new VG register
>>
>>  tools/perf/tests/attr.py                      | 71 +++++++++++++++++--
>>  .../attr/test-record-user-regs-no-sve-aarch64 |  9 +++
>>  .../test-record-user-regs-old-sve-aarch64     | 10 +++
>>  .../attr/test-record-user-regs-sve-aarch64    | 14 ++++
>>  4 files changed, 99 insertions(+), 5 deletions(-)
>>  create mode 100644 tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
>>  create mode 100644 tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64
>>  create mode 100644 tools/perf/tests/attr/test-record-user-regs-sve-aarch64
>>
>> -- 
>> 2.25.1
> 
