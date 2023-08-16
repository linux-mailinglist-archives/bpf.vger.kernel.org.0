Return-Path: <bpf+bounces-7850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F8B77D722
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 02:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F18D2816B3
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 00:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07DE631;
	Wed, 16 Aug 2023 00:39:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3538D
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 00:39:16 +0000 (UTC)
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [IPv6:2001:41d0:1004:224b::10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1062128
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:39:13 -0700 (PDT)
Message-ID: <eeaa1ec2-37a0-2784-c4cd-6c1fdab95b2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692146351; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpRr/i40BylCrxiFvMtBM9NAvhaZDGLzIWbe8a60l6c=;
	b=aC+heiGTXuXtjdHA/W4Rnb8JCVNBW/fNDddoUsURGgnXGEAoe7Wf5JjcNKXqV7rAD/0vzI
	Vtvlr6HieX6HgymR6r1pAkOxVAJqbLiy8zljqxI3pRVmSA8unBoDBnJfS0LgNIe3947nWf
	qkQrM9gHVyxzCU46qV7EK0qeXI8XK/8=
Date: Tue, 15 Aug 2023 17:39:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [Question] test_skeleton selftest build failure on LLVM main
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com
References: <1c33c4e5866c36ae5cec80df77f05009c95f078a.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1c33c4e5866c36ae5cec80df77f05009c95f078a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/15/23 4:20 PM, Eduard Zingerman wrote:
> Hi Yonghong, Jose,
> 
> I've noticed today that LLVM main started producing an error when
> compiling selftest test_skeleton.c:
> 
>      progs/test_skeleton.c:46:20: error: 'in_dynarr_sz' causes a section type conflict with 'in_dynarr'
>         46 | const volatile int in_dynarr_sz SEC(".rodata.dyn");
>            |                    ^
>      progs/test_skeleton.c:47:20: note: declared here
>         47 | const volatile int in_dynarr[4] SEC(".rodata.dyn") = { -1, -2, -3, -4 };
>            |                    ^
>      1 error generated.
>        CLNG-BPF [test_maps] test_sk_storage_trace_itself.bpf.o
>      make: *** [Makefile:594: /home/eddy/work/bpf-next/tools/testing/selftests/bpf/test_skeleton.bpf.o] Error 1
> 
> The code in question looks as follows:
> 
>      ...
>      const volatile int in_dynarr_sz SEC(".rodata.dyn");
>      const volatile int in_dynarr[4] SEC(".rodata.dyn") = { -1, -2, -3, -4 };
>      ...
> 
> In fact, it could be simplified to the following example:
> 
>      #define SEC(n) __attribute__((section(n)))
> 
>      const int with_init SEC("foo") = 1;
>      const int no_init SEC("foo");
> 
> And error is reported for x86 build as well:
> 
>      $ clang -c t.c -o /dev/null
>      t.c:4:11: error: 'no_init' causes a section type conflict with 'with_init'
>          4 | const int no_init SEC("foo");
>            |           ^
>      t.c:3:11: note: declared here
>          3 | const int with_init SEC("foo") = 1;
>            |           ^
>      1 error generated.
> 
> The error occurs because clang infers "read only" attribute for
> section "foo" when `with_init` is processed and "read/write"
> attributes for section "foo" when `no_init` is processed.
> The attributes do not match and error is reported.
> (See Sema::UnifySection, `diag::err_section_conflict` diagnostic).
> 
> The culprit is revision [1] which landed today. The main focus of that
> revision is C++ and handling of structure fields marked as `mutable`.
> However, it also adds a new requirement: for global value to be
> considered "read only" it must have an initializer
> (the `var->hasInit()` check in [2]).
> 
> GCC can handle the example above w/o any issues.
> The relevant part of the C standard [3] is "6.7.3 Type qualifiers",
> but it does not discuss sections, the only section-related sentence
> that I found is:
> 
>> 160) The implementation can place a const object that is not
>>       volatile in a read-only region of storage. Moreover, the
>>       implementation need not allocate storage for such an object if
>>       its address is never used.
> 
> Which does not make example at hand invalid.
> 
> Although `const` values w/o initializer do seem strange they might
> have some sense if, say, linker materializes these definitions with
> something useful.
> 
> Thus, it appears to me that:
> - test_skeleton.c is ok and should not be changed;
> - revision [1] introduced a bug and I should bring it up with upstream.

Thanks Eduard.
Please go ahead bringing the issue to upstream as a comment on [1].
Although the issue can be trivial fixed by add '= 0' initialization,
it will be still good to clarify with upstream.

I remember that we discussed 'const volatile' thing with gcc as well
and agreed it should be put into .rodata section. But I lost that
email communication. I am not sure how initialization will change this.

>    
> What do you think?
> 
> Thanks,
> Eduard
> 
> [1] https://reviews.llvm.org/D156726
> [2] https://github.com/llvm/llvm-project/compare/main...llvm-premerge-tests:llvm-project:phab-diff-550097#diff-edac6256ac508912a16d0165b2f8cf37123dc2f40a147dca49a34c33f1db13ddR14366
> [3] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf
> 
> 

