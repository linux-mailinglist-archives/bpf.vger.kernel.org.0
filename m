Return-Path: <bpf+bounces-8345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198B78509F
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 08:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB01C20C7E
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE179FA;
	Wed, 23 Aug 2023 06:26:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182A1FB8
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 06:26:39 +0000 (UTC)
Received: from out-20.mta1.migadu.com (out-20.mta1.migadu.com [IPv6:2001:41d0:203:375::14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44E5E76
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 23:26:12 -0700 (PDT)
Message-ID: <01367775-1be4-a344-60d7-6b2b1e48b77e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692771971; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4Tii/M6TrKlCWaEg7sZuVjf8d4+l2duPZfUJItXifs=;
	b=Dlpecxa0CYBZloxTDhbzk+/gfUWFtFtlSMrk5ZUpCYXSVxQiplIYqk2k8Twg3OngKUfWmD
	VsW22WyXI3hXxkIrxo/PQgLAwXdTLnaiKJccljjmrlZ+KZLBn4E8pKu0aPHc4WwvROcquJ
	24LMAlByDazC3UzVKFJ8eD3JTlvajhc=
Date: Tue, 22 Aug 2023 23:26:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 3/7] bpf: Use bpf_mem_free_rcu when
 bpf_obj_dropping refcounted nodes
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-4-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230821193311.3290257-4-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> This is the final fix for the use-after-free scenario described in
> commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
> non-owning refs"). That commit, by virtue of changing
> bpf_refcount_acquire's refcount_inc to a refcount_inc_not_zero, fixed
> the "refcount incr on 0" splat. The not_zero check in
> refcount_inc_not_zero, though, still occurs on memory that could have
> been free'd and reused, so the commit didn't properly fix the root
> cause.
> 
> This patch actually fixes the issue by free'ing using the recently-added
> bpf_mem_free_rcu, which ensures that the memory is not reused until
> RCU grace period has elapsed. If that has happened then
> there are no non-owning references alive that point to the
> recently-free'd memory, so it can be safely reused.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   kernel/bpf/helpers.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index eb91cae0612a..945a85e25ac5 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1913,7 +1913,11 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
>   
>   	if (rec)
>   		bpf_obj_free_fields(rec, p);

During reviewing my percpu kptr patch with link
 
https://lore.kernel.org/bpf/20230814172809.1361446-1-yonghong.song@linux.dev/T/#m2f7631b8047e9f5da60a0a9cd8717fceaf1adbb7
Kumar mentioned although percpu memory itself is freed under rcu.
But its record fields are freed immediately. This will cause
the problem since there may be some active uses of these fields
within rcu cs and after bpf_obj_free_fields(), some fields may
be re-initialized with new memory but they do not have chances
to free any more.

Do we have problem here as well?

I am thinking whether I could create another flavor of bpf_mem_free_rcu
with a pre_free_callback function, something like
   bpf_mem_free_rcu_cb2(struct bpf_mem_alloc *ma, void *ptr,
       void (*cb)(void *, void *), void *arg1, void *arg2)

The cb(arg1, arg2) will be called right before the real free of "ptr".

For example, for this patch, the callback function can be

static bpf_obj_free_fields_cb(void *rec, void *p)
{
	if (rec)
		bpf_obj_free_fields(rec, p);
		/* we need to ensure recursive freeing fields free
		 * needs to be done immediately, which means we will
		 * add a parameter to __bpf_obj_drop_impl() to
		 * indicate whether bpf_mem_free or bpf_mem_free_rcu
		 * should be called.
		 */
}

bpf_mem_free_rcu_cb2(&bpf_global_ma, p, bpf_obj_free_fields_cb, rec, p);

In __bpf_obj_drop_impl,
we need to ensure recursive freeing fields free
needs to be done immediately, which means we will
add a parameter to __bpf_obj_drop_impl() to
indicate whether bpf_mem_free or bpf_mem_free_rcu
should be called. If __bpf_obj_drop_impl is called
from bpf_obj_drop_impl(), __rcu version should be used.
Otherwise, non rcu version should be used.

Is this something we need to worry about here as well?
What do you think the above interface?


> -	bpf_mem_free(&bpf_global_ma, p);
> +
> +	if (rec && rec->refcount_off >= 0)
> +		bpf_mem_free_rcu(&bpf_global_ma, p);
> +	else
> +		bpf_mem_free(&bpf_global_ma, p);
>   }
>   
>   __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)

