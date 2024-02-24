Return-Path: <bpf+bounces-22637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629486227F
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 04:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CFD1F2537B
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 03:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC213125A7;
	Sat, 24 Feb 2024 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aeQlEEdv"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC53FEF
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708744847; cv=none; b=UOL74u8s3oAl9boRlEgfCz0a9bsVLnekbU/c+ImUVxrOJiE4GekbjLG2yZsi6Pp6PpZyHRnwsv8WgZw0OGz25ctVpqU3+Sxqw3c9vRKHUZI8lwgxTruWmskJ2GkoQqeD5i4uHPGo92H3/Xmgx97BaEHp34L/joomvl2Mrrmn2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708744847; c=relaxed/simple;
	bh=IA8tgFbKMZ/Etf2nrE21QU/L4TZmhWo79n8LV+yZdIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsWkqv+94nqtiQRGP8ZID1ZeFKHA04tsiBY4Ys+10QwDm1yNOHRb6LcOh91IhvrvRES/1YHWs6yUzG5G+lmLkuqUHQ74p1P40CXqZY3Sll1SaRyswMlDOX4ADdJ0ebkDMrmsRSXT0nIDdDK5YJJj5guH7TSXQTyxyRxea062ht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aeQlEEdv; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8fb3349-c27a-46f7-877d-180df9289108@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708744843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGPJoqY67TL3ie2e70l9t/4TJR9KcSCV6dvyl5pxlPc=;
	b=aeQlEEdvafM4Eii0KMdEnK0s5cydK8sAzd/maxTwe70IAGagvsED6RZG7sZ1qc/cQYU3x5
	e+mPTYF2SMm599h0t8yJ1i+CAJOsOqE/nnZmyrTaPG7xnerEO1mB94PHMkf07M5+3Ndxgc
	H7m3SjGcpaftDN+QCKtyaSvc3iYRarE=
Date: Fri, 23 Feb 2024 19:20:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240221225911.757861-1-thinker.li@gmail.com>
 <20240221225911.757861-3-thinker.li@gmail.com>
 <c59cc446-531b-4b4a-897d-3b298ac72dd2@linux.dev>
 <3e4cc350-34c9-42c1-944f-303a466022d2@gmail.com>
 <7402facf-5f2e-4506-a381-6a84fe1ba841@linux.dev>
 <25982f53-732e-4ce8-bbb2-3354f5684296@gmail.com>
 <b8bac273-27c7-485a-8e45-8825251d6d5a@linux.dev>
 <33c2317c-fde0-4503-991b-314f20d9e7f7@gmail.com>
 <c938c3b1-8cce-4563-930d-7e8150365117@gmail.com>
 <ded8001c-2437-48f4-88ff-4c0633f1da7c@linux.dev>
 <30ffb867-ee0e-4573-b9e7-9fc0f4430adb@gmail.com>
 <363c4377-f668-49fd-978d-73864c293b4e@linux.dev>
 <da7288a2-0e3e-4f46-8d09-450a4bc3978b@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <da7288a2-0e3e-4f46-8d09-450a4bc3978b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/23/24 2:06 PM, Kui-Feng Lee wrote:
> 
> 
> On 2/23/24 11:15, Martin KaFai Lau wrote:
>> On 2/23/24 11:05 AM, Kui-Feng Lee wrote:
>>>
>>>
>>>
>>> On 2/23/24 10:42, Martin KaFai Lau wrote:
>>>> On 2/23/24 10:29 AM, Kui-Feng Lee wrote:
>>>>> One thing I forgot to mention is that bpf_dummy_ops has to call
>>>>> bpf_jit_uncharge_modmem(PAGE_SIZE) as well. The other option is to move
>>>>> bpf_jit_charge_modmem() out of bpf_struct_ops_prepare_trampoline(),
>>>>> meaning bpf_struct_ops_map_update_elem() should handle the case that the
>>>>> allocation in bpf_struct_ops_prepare_trampoline() successes, but
>>>>> bpf_jit_charge_modmem() fails.
>>>>
>>>> Keep the charge/uncharge in bpf_struct_ops_prepare_trampoline().
>>>>
>>>> It is fine to have bpf_dummy_ops charge and then uncharge a PAGE_SIZE. There 
>>>> is no need to optimize for bpf_dummy_ops. Use 
>>>> bpf_struct_ops_free_trampoline() in bpf_dummy_ops to uncharge and free.
>>>
>>>
>>> Then, I don't get the point here.
>>> I agree with moving the allocation into
>>> bpf_struct_ops_prepare_trampoline() to avoid duplication of the code
>>> about flags and tlinks. It really simplifies the code with the fact
>>> that bpf_dummy_ops is still there. So, I tried to pass a st_map to
>>> bpf_struct_ops_prepare_trampoline() to keep page managements code
>>> together. But, you said to simplify the code of bpf_dummy_ops by
>>> allocating pages in bpf_struct_ops_prepare_trampoline(), do bookkeeping
>>> in bpf_struct_ops_map_update_elem(), so bpf_dummy_ops doesn't have to
>>
>> I don't think I ever mentioned to do book keeping in 
>> bpf_struct_ops_map_update_elem(). Have you looked at my earlier code in 
>> bpf_struct_ops_prepare_trampoline() which also does the memory charging also?
> 
> The bookkeeping that I am saying is about maintaining image_pages and
> image_pages_cnt.

image_pages and image_pages_cnt are in the st_map (struct_ops map) itself.
Why the bpf_struct_ops_map_update_elem() cannot keep track of the pages itself
and need  "_"bpf_struct_ops_prepare_trampoline() to handle it? It is not
like refactoring the image_pages[_cnt] handling to
_bpf_struct_ops_prepare_trampoline() and it can be reused by another caller.
bpf_struct_ops_map_update_elem() is the only one needing to keep track of
its own image_pages and image_pages_cnt.

> 
>>
>>> allocate memory. But, we have to move a bpf_jit_uncharge_modmem() to
>>> bpf_dummy_ops. For me, this trade-off that include removing an
>>> allocation and adding a bpf_jit_uncharge_modmem() make no sense.
>>
>> Which part make no sense? Having bpf_dummy_ops charge/uncharge memory also?
> 
> Simplifying bpf_dummy_ops by removing the duty of allocation but adding
> the duty of uncharge memory doesn't make sense to me in terms of
> simplification. Although the lines of code would be similar, it actually
> makes it more complicated than before.

The bpf_dummy_ops does not need to call uncharge. It does not need
to know the page is charged or not. It uses bpf_struct_ops_prepare_trampoline()
to get a prepared trampoline page and bpf_struct_ops_free_trampoline() which
does the uncharge+free. It is the alloc/free concept that you have been
proposing which fits well here.

The bpf_dummy_ops is doing arch_alloc_bpf_trampoline and
arch_free_bpf_trampoline.

The arch_alloc_bpf_trampoline will be gone (-1).

The arch_free_bpf_trampoline will be replaced (+0) by
bpf_struct_ops_free_trampoline.

Untested code:

diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 02de71719aed..a3bb89eb037f 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -89,8 +89,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
  	struct bpf_dummy_ops_test_args *args;
  	struct bpf_tramp_links *tlinks;
  	struct bpf_tramp_link *link = NULL;
+	unsigned int op_idx, image_off = 0;
  	void *image = NULL;
-	unsigned int op_idx;
  	int prog_ret;
  	s32 type_id;
  	int err;
@@ -114,12 +114,6 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
  		goto out;
  	}
  
-	image = arch_alloc_bpf_trampoline(PAGE_SIZE);
-	if (!image) {
-		err = -ENOMEM;
-		goto out;
-	}
-
  	link = kzalloc(sizeof(*link), GFP_USER);
  	if (!link) {
  		err = -ENOMEM;
@@ -130,12 +124,14 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
  	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog);
  
  	op_idx = prog->expected_attach_type;
-	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
-						&st_ops->func_models[op_idx],
-						&dummy_ops_test_ret_function,
-						image, image + PAGE_SIZE);
-	if (err < 0)
+	image = bpf_struct_ops_prepare_trampoline(tlinks, link,
+						  &st_ops->func_models[op_idx],
+						  &dummy_ops_test_ret_function,
+						  NULL, &image_off, true);
+	if (IS_ERR(image)) {
+		err = PTR_ERR(image);
  		goto out;
+	}
  
  	arch_protect_bpf_trampoline(image, PAGE_SIZE);
  	prog_ret = dummy_ops_call_op(image, args);
@@ -147,7 +143,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
  		err = -EFAULT;
  out:
  	kfree(args);
-	arch_free_bpf_trampoline(image, PAGE_SIZE);
+	if (!IS_ERR_OR_NULL(image))
+		bpf_struct_ops_free_trampoline(image);
  	if (link)
  		bpf_link_put(&link->link);
  	kfree(tlinks);


>>>>>>> void bpf_struct_ops_free_trampoline(void *image)
>>>>>>> {
>>>>>>>      bpf_jit_uncharge_modmem(PAGE_SIZE);
>>>>>>>      arch_free_bpf_trampoline(image, PAGE_SIZE);
>>>>>>> }

^^^^^^^^^^^^^^^
To be clear, this bpf_struct_ops_free_trampoline() function that
does the uncharge+free.

~~~~~~~~~~~~~~~~

Lets summarize a bit of the thread:

. I think we agree duplicating codes from
   bpf_struct_ops_prepare_trampoline() is not good.

. bpf_struct_ops_prepare_trampoline() can allocate page.

. The first concern was there is no alloc/free pairing.
   Then adding bpf_struct_ops_free_trampoline was suggested
   to do the uncharge+free together,
   while bpf_struct_ops_prepare_trampoline does the charge+alloc

. The second concern was bpf_struct_ops_prepare_trampoline()
   is not obvious that a free(page) needs to be done. It is
   more like a naming perception since returning a page is already
   a good signal that needs to be freed. However, it is open for
   a function name change if it can make the "alloc" part more obvious.

. Another concern was bpf_dummy_ops now needs to remember it
   needs to uncharge. bpf_struct_ops_free_trampoline() should
   address it also since it does uncharge+free.

. Another point brought up was having bpf_struct_ops_prepare_trampoline()
   store the allocated page in st_map->image_pages instead of
   map_update doing it itself which was covered in the first part of
   this email.

I hope the code pieces have addressed the points brought up above.
I have combined these code pieces in a patch
which is only compiler tested. Hope it will make things clearer (first patch):
https://git.kernel.org/pub/scm/linux/kernel/git/martin.lau/bpf-next.git/log/?h=struct_ops.images

