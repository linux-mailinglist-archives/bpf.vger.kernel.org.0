Return-Path: <bpf+bounces-1979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F17253CF
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 08:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83441C2084D
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 06:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB44693;
	Wed,  7 Jun 2023 06:01:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71F1845
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 06:01:58 +0000 (UTC)
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F171083
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 23:01:56 -0700 (PDT)
Message-ID: <77d8aaef-5c63-641e-6019-dec1f3f078d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1686117714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJHmElMhJDI7omEzVcdVwFHfgV/eYZwC5z1Jii0KtMM=;
	b=Pv0QXSxcRi1N+gepK4HboOCY24zW0g90r0BcA7tp+NBCTtssdZ/+kVdp7EKpTeqkvSIgDF
	yh62bc7MC9yyVmlwfyBHBLEJmaZONex5gktq4WVYYWw3TLtbk0Y0GYNqay6/quB1ocyyVx
	xs3OaLLWTB3WFp69D18Ss09fbZg4myE=
Date: Wed, 7 Jun 2023 14:01:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] libbpf: kprobe.multi: Filter with
 available_filter_functions
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 bpf@vger.kernel.org, liuyun01@kylinos.cn
References: <ZG8f7ffghG7mLUhR@krava>
 <20230525102747.68708-1-liu.yun@linux.dev>
 <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
 <b2273217-5adb-8ec6-288b-4f8703a56386@linux.dev>
 <CAEf4BzbGtZJvS-8=6i3g5A9uJm9_LHVRRbye-OLTdgeWZtdrsw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <CAEf4BzbGtZJvS-8=6i3g5A9uJm9_LHVRRbye-OLTdgeWZtdrsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii.

在 2023/6/3 01:27, Andrii Nakryiko 写道:
> On Thu, May 25, 2023 at 6:38 PM Jackie Liu <liu.yun@linux.dev> wrote:
>>
>> Hi Andrii.
>>
>> 在 2023/5/26 04:43, Andrii Nakryiko 写道:
>>> On Thu, May 25, 2023 at 3:28 AM Jackie Liu <liu.yun@linux.dev> wrote:
>>>>
>>>> From: Jackie Liu <liuyun01@kylinos.cn>
>>>>
>>>> When using regular expression matching with "kprobe multi", it scans all
>>>> the functions under "/proc/kallsyms" that can be matched. However, not all
>>>> of them can be traced by kprobe.multi. If any one of the functions fails
>>>> to be traced, it will result in the failure of all functions. The best
>>>> approach is to filter out the functions that cannot be traced to ensure
>>>> proper tracking of the functions.
>>>>
>>>> Use available_filter_functions check first, if failed, fallback to
>>>> kallsyms.
>>>>
>>>> Here is the test eBPF program [1].
>>>> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867
>>>>
>>>> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>> ---
>>>>    tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++++-----
>>>>    1 file changed, 83 insertions(+), 9 deletions(-)
>>>>
>>>
>>> Question to you and Jiri: what happens when multi-kprobe's syms has
>>> duplicates? Will the program be attached multiple times? If yes, then
>>> it sounds like a problem? Both available_filters and kallsyms can have
>>> duplicate function names in them, right?

I don't have any idea, I tested it on my own device, and they don't have
duplicate functions.

╭─jackieliu@jackieliu-PC ~/gitee/ketones/src
╰─➤ sudo cat /sys/kernel/debug/tracing/available_filter_functions | awk 
-F' ' '{print $1}' | wc -l 

81882
╭─jackieliu@jackieliu-PC ~/gitee/ketones/src
╰─➤ sudo cat /sys/kernel/debug/tracing/available_filter_functions | awk 
-F' ' '{print $1}' | uniq | wc -l 

81882

>>
>> If I understand correctly, there should be no problem with repeated
>> function registration, because the bottom layer is done through fprobe
>> registration addrs, kprobe.multi itself does not do this work, but
>> fprobe is based on ftrace, it will register addr by makes a hash,
>> that is, if it is the same address, it should be filtered out.
>>
> 
> Looking at kernel code, it seems kernel will actually return error if
> user specifies multiple duplicated names. Because kernel will
> bsearch() to the first instance, and never resolve the second
> duplicated instance. And then will assume that not all symbols are
> resolved.

I wrote a test program myself, but it cannot be attached normally, and
an error will be reported.

const char *sysms[] = {
     "vfs_read",
     "vfs_write",
     "vfs_read",
};

when attach_kprobe_multi, -3 returned.

> 
> So, it worries me that we'll switch from kallsyms to available_filters
> by default, because that introduces new failure modes.

In fact, this is not a new problem introduced by switching from kallsyms
to available_filters. If kallsyms also has duplicate functions, then
this problem will also exist before.

> 
> Either way, let's add a selftest that uses a duplicate function name
> and see what happens?

Hi Jiri, Do you mind write a self-test program for duplicate function? I
saw that it has been written before.
for some reason, I failed to compile kselftest/bpf successfully on
fedora38 and Ubuntu2004. :<


> 
>> The main problem here is not the problem of repeated registration of
>> functions, but some functions are not allowed to hook. For example, when
>> I track vfs_*, vfs_set_acl_prepare_kgid and vfs_set_acl_prepare_kuid are
>> not allowed to hook. These exist under kallsyms, but
>> available_filter_functions does not, I have observed for a while,
>> matching through available_filter_functions can effectively prevent this
>> from happening.
> 
> Yeah, I understand that. My point above is that a)
> available_filter_functions contains duplicates and b) doesn't contain
> addresses. So we are forced to rely on kernel string -> addr
> resolution, which doesn't seem to handle duplicate entries well (let's
> test).

Yes, the test for repeated functions reports errors. If there is an
interface similar to available_filter_functions, which contains the
function name and function address, and ensures that it is not 
duplicate, then it is a good speedup for eBPF program, because using
'strdup' to record the function name consumes a certain amount of
startup time.

> 
> So it's a regression to switch to that without taking any other precautions.
> 

Yes, agree.

-- 
BR, Jackie Liu
>>
>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index ad1ec893b41b..3dd72d69cdf7 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -10417,13 +10417,14 @@ static bool glob_match(const char *str, const char *pat)
>>>>    struct kprobe_multi_resolve {
>>>>           const char *pattern;
>>>>           unsigned long *addrs;
>>>> +       const char **syms;
>>>>           size_t cap;
>>>>           size_t cnt;
>>>>    };
>>>>
> 
> [...]

