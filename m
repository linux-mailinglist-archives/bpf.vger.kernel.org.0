Return-Path: <bpf+bounces-10513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBED17A9080
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F7A1C20B2F
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1FE17EC;
	Thu, 21 Sep 2023 01:31:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D198136A
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:31:54 +0000 (UTC)
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A6E6
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:31:51 -0700 (PDT)
Message-ID: <d05b61ca-0575-de1e-8638-9815ad67f597@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695259909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Se3QHvx+0KbxWJk2rlomxi3505dCw05Pzp565Tom9L8=;
	b=sX0eLkc7uyvQV9ZufBCe11nkqWtMADCYnYf8eXp9rSvqtxdF8bCVydomGLSOtEtrbVhgf4
	APrJpWmAvbhCXV71UlnyTy/TjmaiK35TdPTviXHirjjYPHqJ+25H0BEA+T1Pss67kyMtjH
	I9IPQRKTPhNpuxVqXIwo1Eh0NVtdOJc=
Date: Wed, 20 Sep 2023 18:31:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf, sockmap: fix deadlocks in the sockhash and sockmap
Content-Language: en-US
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Kui-Feng Lee <sinquersw@gmail.com>, Ma Ke <make_ruc2021@163.com>,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20230918093620.3479627-1-make_ruc2021@163.com>
 <dc84f39f-5b13-4a7d-a26c-598227fd9a42@gmail.com>
 <650b34ca2b41c_4e8122080@john.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <650b34ca2b41c_4e8122080@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 11:07 AM, John Fastabend wrote:
>>> pay much attention to their deletion. Compared with hash
>>> maps, sockhash only provides spin_lock_bh protection.
>>> This causes it to appear to have self-locking behavior
>>> in the interrupt context, as CVE-2023-0160 points out.
> 
> CVE is a bit exagerrated in my opinion. I'm not sure why
> anyone would delete an element from interrupt context. But,
> OK if someone wrote such a thing we shouldn't lock up.

This should only happen in tracing program?
not sure if it will be too drastic to disallow tracing program to use 
bpf_map_delete_elem during load time now.

A followup question, if sockmap can be accessed from tracing program, does it 
need an in_nmi() check?

>>>    	hash = sock_hash_bucket_hash(key, key_size);
>>>    	bucket = sock_hash_select_bucket(htab, hash);
>>>    
>>> -	spin_lock_bh(&bucket->lock);
>>> +	spin_lock_irqsave(&bucket->lock, flags);
> 
> The hashtab code htab_lock_bucket also does a preempt_disable()
> followed by raw_spin_lock_irqsave(). Do we need this as well
> to handle the PREEMPT_CONFIG cases.

iirc, preempt_disable in htab is for the CONFIG_PREEMPT but it is for the 
__this_cpu_inc_return to avoid unnecessary lock failure due to preemption, so 
probably it is not needed here. The commit 2775da216287 ("bpf: Disable 
preemption when increasing per-cpu map_locked")

If map_delete can be called from any tracing context, the raw_spin_lock_xxx 
version is probably needed though. Otherwise, splat (e.g. 
PROVE_RAW_LOCK_NESTING) could be triggered.

