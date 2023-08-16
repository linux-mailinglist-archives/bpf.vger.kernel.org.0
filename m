Return-Path: <bpf+bounces-7939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3C77EDDF
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 01:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE631281CD7
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE71BF10;
	Wed, 16 Aug 2023 23:40:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646917ADC
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 23:40:47 +0000 (UTC)
Received: from out-52.mta0.migadu.com (out-52.mta0.migadu.com [IPv6:2001:41d0:1004:224b::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BDC2720
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 16:40:45 -0700 (PDT)
Message-ID: <dfda56d6-8327-e6f8-e061-017d5db6a0b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692229240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZkrYekTL1tZX+xZhSLnPPYWXb6/hiDL0gW+OFBeb1c=;
	b=Uq0NDzfzGJg5sOXn+TzmrCPmVVgTFIhZzVc29JSd4gLN515AxeUvErZ+uuQDFFM7JleGry
	MfOEF0/1yYUCdkoWY9Nn4kdZpr76IT//Q5AWfUNI3YmJiJRUr/XSvzxNnflDT1GttUNnut
	X0Fvcqra8QIrseCWBnq4OYUrF3oPIKQ=
Date: Wed, 16 Aug 2023 19:40:35 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: Support triple-underscore flavors
 for kfunc relocation
Content-Language: en-US
To: David Vernet <void@manifault.com>,
 David Marchevsky <david.marchevsky@linux.dev>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230816165813.3718580-1-davemarchevsky@fb.com>
 <20230816173731.GA814797@maniforge>
 <b88ef926-bf7f-b2db-5047-9ab1e7f112e4@linux.dev>
 <20230816192816.GA1295964@maniforge>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20230816192816.GA1295964@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/23 3:28 PM, David Vernet wrote:
> On Wed, Aug 16, 2023 at 03:01:10PM -0400, David Marchevsky wrote:
>> On 8/16/23 1:37 PM, David Vernet wrote:
>>> On Wed, Aug 16, 2023 at 09:58:12AM -0700, Dave Marchevsky wrote:
>>>> The function signature of kfuncs can change at any time due to their
>>>> intentional lack of stability guarantees. As kfuncs become more widely
>>>> used, BPF program writers will need facilities to support calling
>>>> different versions of a kfunc from a single BPF object. Consider this
>>>> simplified example based on a real scenario we ran into at Meta:
>>>>
>>>>   /* initial kfunc signature */
>>>>   int some_kfunc(void *ptr)
>>>>
>>>>   /* Oops, we need to add some flag to modify behavior. No problem,
>>>>     change the kfunc. flags = 0 retains original behavior */
>>>>   int some_kfunc(void *ptr, long flags)
>>>>
>>>> If the initial version of the kfunc is deployed on some portion of the
>>>> fleet and the new version on the rest, a fleetwide service that uses
>>>> some_kfunc will currently need to load different BPF programs depending
>>>> on which some_kfunc is available.
>>>>
>>>> Luckily CO-RE provides a facility to solve a very similar problem,
>>>> struct definition changes, by allowing program writers to declare
>>>> my_struct___old and my_struct___new, with ___suffix being considered a
>>>> 'flavor' of the non-suffixed name and being ignored by
>>>> bpf_core_type_exists and similar calls.
>>>>
>>>> This patch extends the 'flavor' facility to the kfunc extern
>>>> relocation process. BPF program writers can now declare
>>>>
>>>>   extern int some_kfunc___old(void *ptr)
>>>>   extern int some_kfunc___new(void *ptr, int flags)
>>>>
>>>> then test which version of the kfunc exists with bpf_ksym_exists.
>>>> Relocation and verifier's dead code elimination will work in concert as
>>>> expected, allowing this pattern:
>>>>
>>>>   if (bpf_ksym_exists(some_kfunc___old))
>>>>     some_kfunc___old(ptr);
>>>>   else
>>>>     some_kfunc___new(ptr, 0);
>>>>
>>>> Changelog:
>>>>
>>>> v1 -> v2: https://lore.kernel.org/bpf/20230811201346.3240403-1-davemarchevsky@fb.com/
>>>>   * No need to check obj->externs[i].essent_name before zfree (Jiri)
>>>>   * Use strndup instead of replicating same functionality (Jiri)
>>>>   * Properly handle memory allocation falure (Stanislav)
>>>>
>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>> ---
>>>>  tools/lib/bpf/libbpf.c | 20 +++++++++++++++++++-
>>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index b14a4376a86e..8899abc04b8c 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -550,6 +550,7 @@ struct extern_desc {
>>>>  	int btf_id;
>>>>  	int sec_btf_id;
>>>>  	const char *name;
>>>> +	char *essent_name;
>>>>  	bool is_set;
>>>>  	bool is_weak;
>>>>  	union {
>>>> @@ -3770,6 +3771,7 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
>>>>  	struct extern_desc *ext;
>>>>  	int i, n, off, dummy_var_btf_id;
>>>>  	const char *ext_name, *sec_name;
>>>> +	size_t ext_essent_len;
>>>>  	Elf_Scn *scn;
>>>>  	Elf64_Shdr *sh;
>>>>  
>>>> @@ -3819,6 +3821,14 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
>>>>  		ext->sym_idx = i;
>>>>  		ext->is_weak = ELF64_ST_BIND(sym->st_info) == STB_WEAK;
>>>>  
>>>> +		ext_essent_len = bpf_core_essential_name_len(ext->name);
>>>> +		ext->essent_name = NULL;
>>>> +		if (ext_essent_len != strlen(ext->name)) {
>>>> +			ext->essent_name = strndup(ext->name, ext_essent_len);
>>>> +			if (!ext->essent_name)
>>>> +				return -ENOMEM;
>>>> +		}
>>>> +
>>>>  		ext->sec_btf_id = find_extern_sec_btf_id(obj->btf, ext->btf_id);
>>>>  		if (ext->sec_btf_id <= 0) {
>>>>  			pr_warn("failed to find BTF for extern '%s' [%d] section: %d\n",
>>>> @@ -7624,7 +7634,8 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>>>>  
>>>>  	local_func_proto_id = ext->ksym.type_id;
>>>>  
>>>> -	kfunc_id = find_ksym_btf_id(obj, ext->name, BTF_KIND_FUNC, &kern_btf, &mod_btf);
>>>> +	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
>>>> +				    &mod_btf);
>>>>  	if (kfunc_id < 0) {
>>>>  		if (kfunc_id == -ESRCH && ext->is_weak)
>>>>  			return 0;
>>>> @@ -7642,6 +7653,9 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>>>>  		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s [%d]\n",
>>>>  			ext->name, local_func_proto_id,
>>>
>>> Should we do ext->essent_name ?: ext->name here or in the below pr's as
>>> well? Hmm, maybe it would be more clear to keep the full name.
>>>
>>
>> Yeah, I agree that the full name should be used in this warning for clarity.
>> So won't change.
>>
>>>>  			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
>>>> +
>>>> +		if (ext->is_weak)
>>>> +			return 0;
>>>
>>> Could you clarify why we want this check? Don't we want to fail if the
>>> prototype of the actual (essent) symbol we resolve to doesn't match
>>> what's in the BPF prog? If we do want to keep this, should we do the
>>> check above the pr_warn()?
>>>
>>
>> Actually this if-and-return was initially above the pr_warn while I was
>> developing the patch. I moved it down here to confirm via './test_progs -vv'
>> that the pseudo-failure cases in the selftests were going down the codepaths
>> I expected, and left it b/c better to err on the side of too much logging
>> when doing this ___flavor trickery.
> 
> Normally I'd agree, but this is also a pr_warn(), so it goes a bit
> beyond logging IMO. FWIW, I'd vote for erring on the side of matching
> the existing behavior of other __weak special symbol resolution.
> 
> Edit: Saw your other comment below, which I've responded to more
> substantively below as well.
> 

I will respond down there too.

>>
>> In re: "clarify why we want this check?" and subsequent question, IIUC, with an
>> extern decl like
>>
>>   struct task_struct *bpf_task_acquire___one(struct task_struct *task) __ksym __weak;
>>
>> if we removed __weak from the declaration, symbol resolution would happen during
>> compilation + linking, at which point there would be no opportunity to do
>> our ___flavor trickery. But __weak is already used to express "if this kfunc
>> doesn't exist at all, it's not a problem, don't fail loading the program". So
> 
> To clarify -- I wasn't asking why we need to specify __weak, I was
> asking why you added an additional check for __weak on this branch. The
> original check on the find_ksym_btf_id() path made sense to me:
> 
> kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
> 			    &mod_btf);
> if (kfunc_id < 0) {
> 	if (kfunc_id == -ESRCH && ext->is_weak)
> 		return 0;
> 

Ah nice catch, I didn't notice that behavior right up there.
Will match existing behavior.

> If the symbol isn't found, it's weak, so it's OK. This next check is
> saying if the symbol is found BUT it doesn't match the BTF type that the
> kernel expects, that it's OK if it's weak. I wasn't understanding why
> __weak would apply here (usually __weak is intended to mean "it's OK to
> override this symbol with another symbol with the exact same
> declaration", though in practice I don't think symbol resolution works
> that way in every dynamic linker). After thinking about it some more, I
> guess it's necessary to accommodate the case of e.g.
> bpf_task_acquire___three() not matching the BTF signature in the kernel,
> and allowing another symbol like bpf_task_acquire___one() to be resolved
> on another pass?
> 

Yeah precisely, before I added the return 0, any failing
bpf_core_types_are_compat match would cause the file to fail
compilation+link step. If the patch was applied without that
test-and-return, the ___flavor behavior could have only be
used to call the 'correct' func signature matching what's in running kernel
by multiple names.

Re: "usually __weak is intended to mean 'it's OK to override this symbol with
another symbol with the same exact declaration'" - with the caveat that I
didn't really use __weak in "normal" C, most docs that I came across when
googling __weak symbol usage show this pattern:

  if (&some_unresolved_weak_symbol)
    some_unresolved_weak_symbol(arg);

(note that bpf_ksym_exists is essentially !this test + static assert)

So presumably the "optionally use it if defined" scenario is roughly as common
as the "override" scenario. The special ___flavor name logic is the only
thing libbpf C is doing here that's new.

>> as of this version of the code, it's not possible to express "one of
>> bpf_task_acquire___{one,two,three} must resolve, otherwise fail to
>> load" - that check would have to be done at runtime like
>>
>>   if (!(bpf_ksym_exists(bpf_task_acquire___one) ||
>>         bpf_ksym_exists(bpf_task_acquire___two) ||
>>         bpf_ksym_exists(bpf_task_acquire___three)) {
>>     /* communicate failure to userspace runner via global var or something */
>>     return 0;
>>   }
>>
>> Maybe something like BTF tags could be used to group a set of __weak
>> kfunc declarations together such that one (probably _only_ one) of them
>> must resolve at load time. This would obviate the need for such a runtime
>> check without causing compile+link step to fail. But also seems overly
>> complex for now.
> 
> This does sound indeed useful. As explained above, I wasn't intending to
> imply that we didn't need __weak, but regardless this sounds like a nice
> to have at some point down the line.
> 
>> Feels useful to have "incompatible resolution" log message even if it doesn't
>> stop loading process. But because __weak ties ___flavor trickery to "not a 
>> problem if kfunc doesn't exist at all", probably more accurate to make the
>> pr_warn a pr_debug if ___flavor AND ext->is_weak. Adding the logic to do that
>> felt like it would raise more questions than answers to a future reader of the
>> code, so I didn't add it. Now that I'm writing this out, I think it's better
>> to add it along with a comment.
> 
> Yeah, I agree with you -- in my experience, it's common for automation
> to be setup that does nothing other than search for logs with level >=
> warn and raise some alert if any is encountered. I think it's best to
> keep the warn namespace relegated to logging actual error states for
> that reason. So I agree with you that I think this is the proper way
> forward, though IMHO I wouldn't even bother with the pr_debug() here,
> just like we don't with the find_ksym_btf_id() case above. It's fine if
> you want to add it though, I don't feel strongly either way.
> 
> Thanks,
> David

