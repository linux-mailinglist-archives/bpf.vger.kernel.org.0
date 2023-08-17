Return-Path: <bpf+bounces-7940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E49677EE25
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 02:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB400281D21
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF02A37A;
	Thu, 17 Aug 2023 00:17:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF418F
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 00:17:34 +0000 (UTC)
X-Greylist: delayed 2209 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Aug 2023 17:17:32 PDT
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E3D10F
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 17:17:32 -0700 (PDT)
Message-ID: <f06506b5-b4b7-3588-7c78-1b23929f9e0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692231450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6owE7O1+eXjkUzatTsHBzylCK9vGQRAnlBqa6D3AiTM=;
	b=mpA8XGiUi0AL9LI9kEeZ63m6Y68wSmpbf764U+N2ubrLkR9lUsy+8vrJR5lLTqjIMqtVQX
	Khu09Jl+WhKvscVLBnsrxsTxnr4wnss2HEEpzaCsz9MhyU5zlsh5m1uo6ihCBpoCW1eC1v
	Xm3UQBnMhY/KtDBulDdK1oRgzZfj6Ig=
Date: Wed, 16 Aug 2023 20:17:27 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add CO-RE relocs kfunc
 flavors tests
Content-Language: en-US
To: David Vernet <void@manifault.com>,
 David Marchevsky <david.marchevsky@linux.dev>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230816165813.3718580-1-davemarchevsky@fb.com>
 <20230816165813.3718580-2-davemarchevsky@fb.com>
 <20230816174455.GB814797@maniforge>
 <2ce292e0-f9e5-b1ea-0de3-735670139cb9@linux.dev>
 <20230816193942.GB1295964@maniforge>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20230816193942.GB1295964@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/23 3:39 PM, David Vernet wrote:
> On Wed, Aug 16, 2023 at 03:10:23PM -0400, David Marchevsky wrote:
>> On 8/16/23 1:44 PM, David Vernet wrote:
>>> On Wed, Aug 16, 2023 at 09:58:13AM -0700, Dave Marchevsky wrote:
>>>> This patch adds selftests that exercise kfunc flavor relocation
>>>> functionality added in the previous patch. The actual kfunc defined in
>>>> kernel/bpf/helpers.c is
>>>>
>>>>   struct task_struct *bpf_task_acquire(struct task_struct *p)
>>>>
>>>> The following relocation behaviors are checked:
>>>>
>>>>   struct task_struct *bpf_task_acquire___one(struct task_struct *name)
>>>>     * Should succeed despite differing param name
>>>>
>>>>   struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *ctx)
>>>>     * Should fail because there is no two-param bpf_task_acquire
>>>>
>>>>   struct task_struct *bpf_task_acquire___three(void *ctx)
>>>>     * Should fail because, despite vmlinux's bpf_task_acquire having one param,
>>>>       the types don't match
>>>>
>>>> Changelog:
>>>> v1 -> v2: https://lore.kernel.org/bpf/20230811201346.3240403-2-davemarchevsky@fb.com/
>>>>   * Change comment on bpf_task_acquire___two to more accurately reflect
>>>>     that it fails in same codepath as bpf_task_acquire___three, and to
>>>>     not mention dead code elimination as thats an implementation detail
>>>>     (Yonghong)
>>>>
>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>> ---
>>>>  .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
>>>>  .../selftests/bpf/progs/task_kfunc_success.c  | 37 +++++++++++++++++++
>>>>  2 files changed, 38 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>>>> index 740d5f644b40..99abb0350154 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>>>> @@ -79,6 +79,7 @@ static const char * const success_tests[] = {
>>>>  	"test_task_from_pid_current",
>>>>  	"test_task_from_pid_invalid",
>>>>  	"task_kfunc_acquire_trusted_walked",
>>>> +	"test_task_kfunc_flavor_relo",
>>>>  };
>>>>  
>>>>  void test_task_kfunc(void)
>>>> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
>>>> index b09371bba204..ffbe3ff72639 100644
>>>> --- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
>>>> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
>>>
>>> Do you think it's worth it to also add a failure case for if there's no
>>> correct bpf_taks_acquire___one(), to verify e.g. that we can't resolve
>>> bpf_task_acquire___three(void *ctx) __ksym __weak?
>>>
>>
>> IIUC you're asking about whether it's possible to fail loading the program
>> entirely if _none_ of the three variants resolve successfully? If so, I
>> sent out a response to another email in this round of your comments that should
>> address it.
> 
> Sorry, that was unclear in the way I worded it. I understand that the
> program will still load if none of the variants resolve succesfully. I
> was asking whether we should add a test that verifies that the wrong
> variant won't be resolved if a correct one isn't present. Maybe that's
> overkill? Seems prudent to add just in case, though. Something like
> this:
> 
> SEC("tp_btf/task_newtask")
> int BPF_PROG(test_task_kfunc_flavor_relo_not_found,
> 	     struct task_struct *task, u64 clone_flags)
> {
> 	/* Neither symbol should resolve successfully. */
>         if (bpf_ksym_exists(bpf_task_acquire___two))
>                 err = 1;
>         else if (bpf_ksym_exists(bpf_task_acquire___three))
>                 err = 2;
> 	
> 	return 0;
> }
> 


I was leaning towards pushing back here, but agree with you after digging and
seeing:

  * weak symbols aren't discussed in the C99 standard at all and are an ELF
    specification concept
  * my previous bullet point isn't really relevant to what you're saying here
    as you're talking about the linkage process more generally
  * Then I started digging in the C99 standard and realized that even if there
    was something in there that would allow me to say "well by definition I 
    don't need to test for this", would be too obscure and I should just add the
    test

>>
>>>> @@ -18,6 +18,13 @@ int err, pid;
>>>>   */
>>>>  
>>>>  struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __weak;
>>>> +
>>>> +struct task_struct *bpf_task_acquire___one(struct task_struct *task) __ksym __weak;
>>>> +/* The two-param bpf_task_acquire doesn't exist */
>>>> +struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *ctx) __ksym __weak;
>>>> +/* Incorrect type for first param */
>>>> +struct task_struct *bpf_task_acquire___three(void *ctx) __ksym __weak;
>>>> +
>>>>  void invalid_kfunc(void) __ksym __weak;
>>>>  void bpf_testmod_test_mod_kfunc(int i) __ksym __weak;
>>>>  
>>>> @@ -55,6 +62,36 @@ static int test_acquire_release(struct task_struct *task)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +SEC("tp_btf/task_newtask")
>>>> +int BPF_PROG(test_task_kfunc_flavor_relo, struct task_struct *task, u64 clone_flags)
>>>> +{
>>>> +	struct task_struct *acquired = NULL;
>>>> +	int fake_ctx = 42;
>>>> +
>>>> +	if (bpf_ksym_exists(bpf_task_acquire___one)) {
>>>> +		acquired = bpf_task_acquire___one(task);
>>>> +	} else if (bpf_ksym_exists(bpf_task_acquire___two)) {
>>>> +		/* Here, bpf_object__resolve_ksym_func_btf_id's find_ksym_btf_id
>>>> +		 * call will find vmlinux's bpf_task_acquire, but subsequent
>>>> +		 * bpf_core_types_are_compat will fail
>>>> +		 */
>>>> +		acquired = bpf_task_acquire___two(task, &fake_ctx);
>>>> +		err = 3;
>>>> +		return 0;
>>>> +	} else if (bpf_ksym_exists(bpf_task_acquire___three)) {
>>>> +		/* bpf_core_types_are_compat will fail similarly to above case */
>>>> +		acquired = bpf_task_acquire___three(&fake_ctx);
>>>> +		err = 4;
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	if (acquired)
>>>> +		bpf_task_release(acquired);
>>>
>>> Might be slightly simpler to do the release + return immediately in the
>>> bpf_task_acquire___one branch, and then to just do the following here
>>> without the if / else:
>>>
>>> err = 5;
>>> return 0;
>>>
>>> What do you think?
>>>
>>
>> Eh, I like this form more because it's easier to visually distinguish that the
>> bpf_task_acquire___one case above is not a 'failure' case and should
>> successfully resolve, whereas the other two bail out early.
>>
>>>> +	else
>>>> +		err = 5;
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  SEC("tp_btf/task_newtask")
>>>>  int BPF_PROG(test_task_acquire_release_argument, struct task_struct *task, u64 clone_flags)
>>>>  {
>>>> -- 
>>>> 2.34.1
>>>>
>>>>

