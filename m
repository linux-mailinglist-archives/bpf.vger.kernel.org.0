Return-Path: <bpf+bounces-6614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9766B76BE59
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF3B1C20832
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27177263A5;
	Tue,  1 Aug 2023 20:14:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CE25170
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:14:33 +0000 (UTC)
Received: from out-110.mta1.migadu.com (out-110.mta1.migadu.com [95.215.58.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F9326AA
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:14:30 -0700 (PDT)
Message-ID: <b7116732-653d-d701-304e-7897bb450e89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690920868; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DthQhsSpjK7nk6JW0vl0oTm4CxIDfFfQKboa502bjwM=;
	b=UwE0ia46mg8QiXQ+DQ4pBjveOzK/8RePpc8f4NOPyExAo+1hjF6YNk3HGNQh6xAIByORgJ
	lXazfGGJu2JGa9SLtXFO6I1dw8ZqwJTjMyxQr5+1Vsie7AwcNe87gCS+0qZ+b3kHFicu2w
	qck17G/t2WkIzH9jUsKU/+MYnnBpoSw=
Date: Tue, 1 Aug 2023 13:14:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf] selftests/bpf: fix static assert compilation issue
 for test_cls_*.c
Content-Language: en-US
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
 Colm Harrington <colm.harrington@oracle.com>
References: <20230801102942.2629385-1-alan.maguire@oracle.com>
 <be06d3c7-fe77-cef0-f3d2-780c6c1e90b3@linux.dev>
 <79d0f187-a876-3065-070b-d518ac5854ed@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <79d0f187-a876-3065-070b-d518ac5854ed@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 10:57 AM, Alan Maguire wrote:
> On 01/08/2023 18:09, Yonghong Song wrote:
>>
>>
>> On 8/1/23 3:29 AM, Alan Maguire wrote:
>>> commit bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to
>>> work with CO-RE")
>>>
>>> ...was backported to stable trees such as 5.15. The problem is that
>>> with older
>>> LLVM/clang (14/15) - which is often used for older kernels - we see
>>> compilation
>>> failures in BPF selftests now:
>>>
>>> In file included from progs/test_cls_redirect_subprogs.c:2:
>>> progs/test_cls_redirect.c:90:2: error: static assertion expression is
>>> not an integral constant expression
>>>           sizeof(flow_ports_t) !=
>>>           ^~~~~~~~~~~~~~~~~~~~~~~
>>> progs/test_cls_redirect.c:91:3: note: cast that performs the
>>> conversions of a reinterpret_cast is not allowed in a constant expression
>>>                   offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>>>                   ^
>>> progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
>>>           (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>>>            ^
>>> tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33:
>>> note: expanded from macro 'offsetof'
>>>                                    ^
>>> In file included from progs/test_cls_redirect_subprogs.c:2:
>>> progs/test_cls_redirect.c:95:2: error: static assertion expression is
>>> not an integral constant expression
>>>           sizeof(flow_ports_t) !=
>>>           ^~~~~~~~~~~~~~~~~~~~~~~
>>> progs/test_cls_redirect.c:96:3: note: cast that performs the
>>> conversions of a reinterpret_cast is not allowed in a constant expression
>>>                   offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>>>                   ^
>>> progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
>>>           (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>>>            ^
>>> tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33:
>>> note: expanded from macro 'offsetof'
>>>                                    ^
>>> 2 errors generated.
>>> make: *** [Makefile:594:
>>> tools/testing/selftests/bpf/test_cls_redirect_subprogs.bpf.o] Error 1
>>>
>>> The problem is the new offsetof() does not play nice with static asserts.
>>> Given that the context is a static assert (and CO-RE relocation is not
>>> needed at compile time), offsetof() usage can be replaced by
>>> __builtin_offsetof(), and all is well.  Define __builtin_offsetofend()
>>> to be used in static asserts also, since offsetofend() is also defined in
>>> bpf_util.h and is used in userspace progs, so redefining offsetofend()
>>> in test_cls_redirect.h won't work.
>>>
>>> Fixes: bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to
>>> work with CO-RE")
>>> Reported-by: Colm Harrington <colm.harrington@oracle.com>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---
>>>    tools/testing/selftests/bpf/progs/test_cls_redirect.c | 11 ++++-------
>>>    tools/testing/selftests/bpf/progs/test_cls_redirect.h |  3 +++
>>>    .../selftests/bpf/progs/test_cls_redirect_dynptr.c    | 11 ++++-------
>>>    3 files changed, 11 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>>> b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>>> index 66b304982245..e68e0544827c 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>>> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>>> @@ -28,9 +28,6 @@
>>>    #define INLINING __always_inline
>>>    #endif
>>>    -#define offsetofend(TYPE, MEMBER) \
>>> -    (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>>> -
>>>    #define IP_OFFSET_MASK (0x1FFF)
>>>    #define IP_MF (0x2000)
>>>    @@ -88,13 +85,13 @@ typedef struct {
>>>      _Static_assert(
>>>        sizeof(flow_ports_t) !=
>>> -        offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>>> -            offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
>>> +        __builtin_offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>>> +        __builtin_offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
>>>        "flow_ports_t must match sport and dport in struct
>>> bpf_sock_tuple");
>>>    _Static_assert(
>>>        sizeof(flow_ports_t) !=
>>> -        offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>>> -            offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
>>> +        __builtin_offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>>> +        __builtin_offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
>>>        "flow_ports_t must match sport and dport in struct
>>> bpf_sock_tuple");
>>>      typedef int ret_t;
>>> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
>>> b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
>>> index 76eab0aacba0..1de0b727a3f6 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
>>> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
>>> @@ -12,6 +12,9 @@
>>>    #include <linux/ipv6.h>
>>>    #include <linux/udp.h>
>>>    +#define __builtin_offsetofend(TYPE, MEMBER) \
>>> +    (__builtin_offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>>
>> I think this can be simplified to undef and re-define offsetof like below:
>>
>> #ifdef offsetof
>> #undef offsetof
>> #define offsetof(type, member) __builtin_offsetof(type, member)
>> #endif
>>
>> Then other changes in this patch become unnecessary.
>>
>> You can add comments for the above code to explain
>> why you want to redefine 'offsetof'.
>>
> 
> That's one way to solve it alright, but then other instances of
> offsetof() in the BPF code (that are not part of static asserts) aren't
> CO-RE-safe. Probably not a big concern for a test case that is usually

There are no CORE relocation here. vmlinux.h is not involved
and no explicit CORE relocation requests in the related C code.
Also I checked all offsetof usage in related C files
(test_cls_redirect.c, test_cls_redirect_dynptr.c) and the
offsetof only operates on uapi headers so CORE relocation
for them are not needed.

> run against the same kernel, but it's perhaps worth retaining the
> distinction between compile-time and run-time needs?
> 
> Alan
> 
>>
>>> +
>>>    struct gre_base_hdr {
>>>        uint16_t flags;
>>>        uint16_t protocol;
>>> diff --git
>>> a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>>> b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>>> index f41c81212ee9..463b0513f871 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>>> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>>> @@ -23,9 +23,6 @@
>>>    #include "test_cls_redirect.h"
>>>    #include "bpf_kfuncs.h"
>>>    -#define offsetofend(TYPE, MEMBER) \
>>> -    (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>>> -
>>>    #define IP_OFFSET_MASK (0x1FFF)
>>>    #define IP_MF (0x2000)
>>>    @@ -83,13 +80,13 @@ typedef struct {
>>>      _Static_assert(
>>>        sizeof(flow_ports_t) !=
>>> -        offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>>> -            offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
>>> +        __builtin_offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>>> +        __builtin_offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
>>>        "flow_ports_t must match sport and dport in struct
>>> bpf_sock_tuple");
>>>    _Static_assert(
>>>        sizeof(flow_ports_t) !=
>>> -        offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>>> -            offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
>>> +        __builtin_offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>>> +        __builtin_offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
>>>        "flow_ports_t must match sport and dport in struct
>>> bpf_sock_tuple");
>>>      struct iphdr_info {

