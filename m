Return-Path: <bpf+bounces-8871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B5578BC06
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 02:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC8280F22
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 00:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784F7E8;
	Tue, 29 Aug 2023 00:23:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD1368
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 00:23:54 +0000 (UTC)
Received: from out-252.mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9357E107
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:23:52 -0700 (PDT)
Message-ID: <879c818e-f26c-b1b4-8ccb-f77967282f91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693268630; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/M81VZVi4nT9/+lGra52KWFw+ktk7l7eeq8mXN5gdIU=;
	b=aNlwWqOkaPkOtseEGOy/t4GYw3uCD4r0+oAvaNK5bFhfpadtWrCzwJxn+mPl+LXrVcK/rK
	0gRCQ6s1C/jP6VQu2mAw/EeJQon+rk2A9rjYx5Qdzg8Eep/HyPWBZknbMJBSJhLx1JHSVL
	pvEbQ8qluN7IbPLngUu59EcCo5l3J+Y=
Date: Mon, 28 Aug 2023 20:23:44 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Prevent inlining of bpf_fentry_test7()
Content-Language: en-US
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20230826200843.2210074-1-yonghong.song@linux.dev>
 <a741f4ed-4da5-8481-236e-236d2f702ccd@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a741f4ed-4da5-8481-236e-236d2f702ccd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/28/23 12:26 AM, Alan Maguire wrote:
> On 26/08/2023 21:08, Yonghong Song wrote:
>> With latest clang18, I hit test_progs failures for the following test:
>>    #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
>>    #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
>>    #13      bpf_cookie:FAIL
>>    #75      fentry_fexit:FAIL
>>    #76/1    fentry_test/fentry:FAIL
>>    #76      fentry_test:FAIL
>>    #80/1    fexit_test/fexit:FAIL
>>    #80      fexit_test:FAIL
>>    #110/1   kprobe_multi_test/skel_api:FAIL
>>    #110/2   kprobe_multi_test/link_api_addrs:FAIL
>>    #110/3   kprobe_multi_test/link_api_syms:FAIL
>>    #110/4   kprobe_multi_test/attach_api_pattern:FAIL
>>    #110/5   kprobe_multi_test/attach_api_addrs:FAIL
>>    #110/6   kprobe_multi_test/attach_api_syms:FAIL
>>    #110     kprobe_multi_test:FAIL
>>
>> For example, for #13/2, the error messages are
>>    ...
>>    kprobe_multi_test_run:FAIL:kprobe_test7_result unexpected kprobe_test7_result: actual 0 != expected 1
>>    ...
>>    kprobe_multi_test_run:FAIL:kretprobe_test7_result unexpected kretprobe_test7_result: actual 0 != expected 1
>>
>> clang17 does not have this issue.
>>
>> Further investigation shows that kernel func bpf_fentry_test7(), used
>> in the above tests, is inlined by the compiler although it is
>> marked as noinline.
>>
>>    int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>>    {
>>          return (long)arg;
>>    }
>>
>> It is known that for simple functions like the above (e.g. just returning
>> a constant or an input argument), the clang compiler may still do inlining
>> for a noinline function. Adding 'asm volatile ("")' in the beginning of the
>> bpf_fentry_test7() can prevent inlining.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> 
> Fixes: d923021c2ce12 ("bpf: Add tests for PTR_TO_BTF_ID vs. null
> comparison")
> 
> ...might help this land in stable trees too. Thanks!

I didn't put a Fixes tag since the issue is caused by upgrading
clang compiler. The commit d923021c2ce12 does not have any issues
at its patch-applying time.

Since this is not a core kernel functionality bug and it is due
to upgrading clang compiler, I think backport is optional. But
if maintainers think I should add Fixes tag, I can do it
in the next revision.

> 
>> ---
>>   net/bpf/test_run.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index 57a7a64b84ed..0841f8d82419 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -543,6 +543,7 @@ struct bpf_fentry_test_t {
>>   
>>   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>>   {
>> +	asm volatile ("");
>>   	return (long)arg;
>>   }
>>   
> Is there a risk bpf_fentry_test8/9 might get inlined too?

So far, not. I cannot predict in the future. But if this
happens with more complicated expressions got inlined for
a non-inline function, I can discuss with upstream.

