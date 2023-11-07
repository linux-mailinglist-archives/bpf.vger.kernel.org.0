Return-Path: <bpf+bounces-14379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95AA7E3557
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 07:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37409280F69
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013ABA3B;
	Tue,  7 Nov 2023 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b7eTa45Q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAAC126
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:44:54 +0000 (UTC)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA2510F
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 22:44:52 -0800 (PST)
Message-ID: <6b66f9ab-d100-4a9a-9f78-31eb37e6819d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699339490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vy7Vs9SXWPIGAfSkZsvVxYgkVFEzTQmOxN2dKlmndYQ=;
	b=b7eTa45QefkpwJPTxSShXLXivPJBUHkgB2CDWhxcgIpLcO0g1l44Gn9cym7TlGdzAXeODY
	64PiJT0CJv6RCaPhBP7s13sK0nV+RC7iIrToQfTioKeqiFGXBEUzLQ5oUE6Sj0u4Pwthvi
	8Y1MAMCYVyPflQj2fopoX0zQwqqp87I=
Date: Mon, 6 Nov 2023 22:44:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: Add tail padding check for
 LIBBPF_OPTS_RESET macro
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231105185358.1036619-1-yonghong.song@linux.dev>
 <CAEf4BzaerjXW7v6D-29h_yBGL=wWcoyP96FjetKe9AYT1pVt5g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaerjXW7v6D-29h_yBGL=wWcoyP96FjetKe9AYT1pVt5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/6/23 11:47 AM, Andrii Nakryiko wrote:
> On Sun, Nov 5, 2023 at 10:54 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Martin reported that there is a libbpf complaining of non-zero-value tail
>> padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modified
>> to have a 4-byte tail padding. This only happens to clang compiler.
>> The commend line is: ./test_progs -t tc_netkit_multi_links
>> Martin and I did some investigation and found this indeed the case and
>> the following are the investigation details.
>>
>> Clang 18:
>>    clang version 18.0.0 (https://github.com/llvm/llvm-project.git e00d32afb9d33a1eca48e2b041c9688436706c5b)
>>    <I tried clang15/16/17 and they all have similar results>
>>
>> tools/lib/bpf/libbpf_common.h:
>>    #define LIBBPF_OPTS_RESET(NAME, ...)                                      \
>>          do {                                                                \
>>                  memset(&NAME, 0, sizeof(NAME));                             \
>>                  NAME = (typeof(NAME)) {                                     \
>>                          .sz = sizeof(NAME),                                 \
>>                          __VA_ARGS__                                         \
>>                  };                                                          \
>>          } while (0)
>>
>>    #endif
>>
>> tools/lib/bpf/libbpf.h:
>>    struct bpf_netkit_opts {
>>          /* size of this struct, for forward/backward compatibility */
>>          size_t sz;
>>          __u32 flags;
>>          __u32 relative_fd;
>>          __u32 relative_id;
>>          __u64 expected_revision;
>>          size_t :0;
>>    };
>>    #define bpf_netkit_opts__last_field expected_revision
>> In the above struct bpf_netkit_opts, there is no tail padding.
>>
>> prog_tests/tc_netkit.c:
>>    static void serial_test_tc_netkit_multi_links_target(int mode, int target)
>>    {
>>          ...
>>          LIBBPF_OPTS(bpf_netkit_opts, optl);
>>          ...
>>          LIBBPF_OPTS_RESET(optl,
>>                  .flags = BPF_F_BEFORE,
>>                  .relative_fd = bpf_program__fd(skel->progs.tc1),
>>          );
>>          ...
>>    }
>>
>> Let us make the following source change, note that we have a 4-byte
>> tailing padding now.
>>    diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>>    index 6cd9c501624f..0dd83910ae9a 100644
>>    --- a/tools/lib/bpf/libbpf.h
>>    +++ b/tools/lib/bpf/libbpf.h
>>    @@ -803,13 +803,13 @@ bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
>>     struct bpf_netkit_opts {
>>          /* size of this struct, for forward/backward compatibility */
>>          size_t sz;
>>    -       __u32 flags;
>>          __u32 relative_fd;
>>          __u32 relative_id;
>>          __u64 expected_revision;
>>    +       __u32 flags;
>>          size_t :0;
>>     };
>>    -#define bpf_netkit_opts__last_field expected_revision
>>    +#define bpf_netkit_opts__last_field flags
>>
>> The clang 18 generated asm code looks like below:
>>      ;       LIBBPF_OPTS_RESET(optl,
>>      55e3: 48 8d 7d 98                   leaq    -0x68(%rbp), %rdi
>>      55e7: 31 f6                         xorl    %esi, %esi
>>      55e9: ba 20 00 00 00                movl    $0x20, %edx
>>      55ee: e8 00 00 00 00                callq   0x55f3 <serial_test_tc_netkit_multi_links_target+0x18d3>
>>      55f3: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0(%rbp)
>>      55fe: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
>>      5605: 48 8b 78 18                   movq    0x18(%rax), %rdi
>>      5609: e8 00 00 00 00                callq   0x560e <serial_test_tc_netkit_multi_links_target+0x18ee>
>>      560e: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
>>      5614: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
>>      561e: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(%rbp)
>>      5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
>>      5633: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
>>      563a: 48 89 45 98                   movq    %rax, -0x68(%rbp)
>>      563e: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
>>      5645: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
>>      5649: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
>>      5650: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
>>      5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
>>      565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
>>      ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);
>>
>> At -O0 level, the clang compiler creates an intermediate copy.
>> We have below to store 'flags' with 4-byte store and leave another 4 byte
>> in the same 8-byte-aligned storage undefined,
>>      5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
>> and later we store 8-byte to the original zero'ed buffer
>>      5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
>>      565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
>>
>> This caused a problem as the 4-byte value at [%rbp-0x2dc, %rbp-0x2e0)
>> may be garbage.
>>
>> gcc (gcc 11.4) does not have this issue as it does zeroing struct first before
>> doing assignments:
>>    ;       LIBBPF_OPTS_RESET(optl,
>>      50fd: 48 8d 85 40 fc ff ff          leaq    -0x3c0(%rbp), %rax
>>      5104: ba 20 00 00 00                movl    $0x20, %edx
>>      5109: be 00 00 00 00                movl    $0x0, %esi
>>      510e: 48 89 c7                      movq    %rax, %rdi
>>      5111: e8 00 00 00 00                callq   0x5116 <serial_test_tc_netkit_multi_links_target+0x1522>
>>      5116: 48 8b 45 f0                   movq    -0x10(%rbp), %rax
>>      511a: 48 8b 40 18                   movq    0x18(%rax), %rax
>>      511e: 48 89 c7                      movq    %rax, %rdi
>>      5121: e8 00 00 00 00                callq   0x5126 <serial_test_tc_netkit_multi_links_target+0x1532>
>>      5126: 48 c7 85 40 fc ff ff 00 00 00 00      movq    $0x0, -0x3c0(%rbp)
>>      5131: 48 c7 85 48 fc ff ff 00 00 00 00      movq    $0x0, -0x3b8(%rbp)
>>      513c: 48 c7 85 50 fc ff ff 00 00 00 00      movq    $0x0, -0x3b0(%rbp)
>>      5147: 48 c7 85 58 fc ff ff 00 00 00 00      movq    $0x0, -0x3a8(%rbp)
>>      5152: 48 c7 85 40 fc ff ff 20 00 00 00      movq    $0x20, -0x3c0(%rbp)
>>      515d: 89 85 48 fc ff ff             movl    %eax, -0x3b8(%rbp)
>>      5163: c7 85 58 fc ff ff 08 00 00 00 movl    $0x8, -0x3a8(%rbp)
>>    ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);
>>
>> It is not clear how to resolve the compiler code generation as the compiler
>> generates correct code w.r.t. how to handle unnamed padding in C standard.
>> So this patch changed LIBBPF_OPTS_RESET macro by adding a static_assert
>> to complain if there is a non-zero-byte tailing padding. This will effectively
>> enforce all *_opts struct used by LIBBPF_OPTS_RESET must have zero-byte tailing
>> padding.
>>
>> With the above changed bpf_netkit_opts layout, building the selftest with
>> clang compiler, the following error will occur:
>>
>>    .../bpf-next/tools/testing/selftests/bpf/prog_tests/tc_netkit.c:331:2: error:
>>      static assertion failed due to requirement 'sizeof (optl) == (__builtin_offsetof(struct bpf_netkit_opts, flags)
>>        + sizeof ((((struct bpf_netkit_opts *)0)->flags)))': Unexpected tail padding
>>    331 |         LIBBPF_OPTS_RESET(bpf_netkit_opts, optl,
>>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    332 |                 .flags = BPF_F_BEFORE,
>>        |                 ~~~~~~~~~~~~~~~~~~~~~~
>>    333 |                 .relative_fd = bpf_program__fd(skel->progs.tc1),
>>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    334 |         );
>>        |         ~
>>    .../bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:98:4: note: expanded from macro 'LIBBPF_OPTS_RESET'
>>     98 |                         sizeof(NAME) == offsetofend(struct TYPE,            \
>>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     99 |                                                     TYPE##__last_field),    \
>>        |                                                     ~~~~~~~~~~~~~~~~~~~
>>    .../bpf-next/tools/testing/selftests/bpf/prog_tests/tc_netkit.c:331:2: note: expression evaluates to '32 == 28'
>>    331 |         LIBBPF_OPTS_RESET(bpf_netkit_opts, optl,
>>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    332 |                 .flags = BPF_F_BEFORE,
>>        |                 ~~~~~~~~~~~~~~~~~~~~~~
>>    333 |                 .relative_fd = bpf_program__fd(skel->progs.tc1),
>>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    334 |         );
>>        |         ~
>>    .../bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:98:17: note: expanded from macro 'LIBBPF_OPTS_RESET'
>>     98 |                         sizeof(NAME) == offsetofend(struct TYPE,            \
>>        |                         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     99 |                                                     TYPE##__last_field),    \
>>
>> Note that this patch does not provide a C++ version of changed LIBBPF_OPTS_RESET macro.
>> It looks C++ complaining about offsetof()
>>    #define offsetof(type, member)    ((unsigned long)&((type *)0)->member)
>> to be used in static_assert.
>>
>> Cc: Martin KaFai Lau <martin.lau@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> This patch is adding detection of a potential issue, but doesn't
> suggest the solution. Did you have a proposed solution in mind for
> cases when we do have padding at the end?

This patch is kind of ONE possible solution in the sense it tries to
warn people if the tail padding exists when using LIBBPF_OPTS_RESET
macro. But later I realized that this may not be the best since
it is possible LIBBPF_OPTS_RESET may use some other existing *_opts
struct and if those opts have tail padding, then user will get
struck since they need to modify that *_opts struct which is not
good. So best way is still to fix LIBBPF_OPTS_RESET to avoid
uninitialized tail padding.

After some further thought, I found a solution. See v2:
https://lore.kernel.org/bpf/20231107062936.2537338-1-yonghong.song@linux.dev/

>
>>   tools/lib/bpf/libbpf_common.h                 |   7 +-
>>   .../selftests/bpf/prog_tests/tc_links.c       |  70 ++++-----
>>   .../selftests/bpf/prog_tests/tc_netkit.c      |   4 +-
>>   .../selftests/bpf/prog_tests/tc_opts.c        | 144 +++++++++---------
>>   4 files changed, 115 insertions(+), 110 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
>> index b7060f254486..f74e5f3cde9c 100644
>> --- a/tools/lib/bpf/libbpf_common.h
>> +++ b/tools/lib/bpf/libbpf_common.h
>> @@ -77,8 +77,13 @@
>>    * syntax as varargs can be provided as well to reinitialize options struct
>>    * specific members.
>>    */
>> -#define LIBBPF_OPTS_RESET(NAME, ...)                                       \
>> +#define LIBBPF_OPTS_RESET(TYPE, NAME, ...)                                 \
> We can't do this. It's both backwards incompatible and will breaks
> existing users. And it also hurts usability a lot to have to specify
> the name of the struct.

The original thinking is LIBBPF_OPTS_RESET is introduced in 6.6, so
we only need to backport to 6.6.

>
>>          do {                                                                \
>> +               _Static_assert(                                             \
>> +                       sizeof(NAME) == offsetofend(struct TYPE,            \
> you coun't use typeof(NAME) here?

Yes, we can. The key thing is TYPE usage in the below line so TYPE has to be added to
macro definition.

>
>> +                                                   TYPE##__last_field),    \
>> +                       "Unexpected tail padding"                           \
>> +               );                                                          \
> I don't see why this static assert has to be inside
> LIBBPF_OPTS_RESET() macro. We can just add it next to each opts type
> declaration, if we want to enforce this.

I found another solution without assert. See v2.


>
>>                  memset(&NAME, 0, sizeof(NAME));                             \
>>                  NAME = (typeof(NAME)) {                                     \
>>                          .sz = sizeof(NAME),                                 \
> [...]

