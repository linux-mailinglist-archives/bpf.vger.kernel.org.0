Return-Path: <bpf+bounces-6732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A1E76D48A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD41281AA2
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C488DDDA;
	Wed,  2 Aug 2023 17:02:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEA79FF
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 17:02:30 +0000 (UTC)
Received: from out-113.mta1.migadu.com (out-113.mta1.migadu.com [IPv6:2001:41d0:203:375::71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1620B1712
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 10:02:24 -0700 (PDT)
Message-ID: <e068f3ee-d4c1-ed59-5c28-d3adfc9c340b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690995742; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y93HcvzB9hu+IjyVr+QG22qbeupADAUQOJFBtjxWMPs=;
	b=rUqqXhVyrKDnZtJwrWGbbZeV7deAqoNi5VR2yw4L7kRu5lx7/uCfqVkMteeMOc8/I9RQSq
	sOT02sehj3/RvYiDp2qAOl89yLSzTyIiPafH7qhfQikpxU99KFG0FuryITfW89zu4eO9iT
	B5oQWLI6OzZsh5vqMoDNZ+GPlV11AAQ=
Date: Wed, 2 Aug 2023 10:02:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next] libbpf: Use local includes inside the library
Content-Language: en-US
To: Sergey Kacheev <s.kacheev@gmail.com>
Cc: bpf@vger.kernel.org
References: <CAJVhQqW6nvWFozMOVQ=_sUTRwVjsQL+G2yCyd91c0bjsc7PcGA@mail.gmail.com>
 <2e44382b-13a0-5346-c914-be0ae0c7edcd@linux.dev>
 <CAJVhQqXQfcO8Y_uZK-9ShEjQp9RTEZtHndHBoWdeb_d9qLBzrg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAJVhQqXQfcO8Y_uZK-9ShEjQp9RTEZtHndHBoWdeb_d9qLBzrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/2/23 8:55 AM, Sergey Kacheev wrote:
> In our monrepo, we try to minimize special processing when importing
> (aka vendor) third-party source code. Ideally, we try to import
> directly from the repositories with the code without changing it, we
> try to stick to the source code dependency instead of the artifact
> dependency. In the current situation, a patch has to be made for
> libbpf to fix the includes in bpf headers so that they work directly
> from libbpf/src.
> I made this patch only because I believe that it will not harm the
> quality of the library code in any way and will not break current
> users, if this is not the case, please tell me what I'm missing and
> what can break?

Your change looks okay to me. I agree that this should not
break existing libbpf users. Please add the above description
to your commit message to make it clear why you want to make
this change and resubmit.

> 
> Thanks!
> 
> On Wed, Aug 2, 2023 at 5:44 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 8/2/23 1:05 AM, Sergey Kacheev wrote:
>>> This patch makes it possible to import the header files of the bpf
>>> part directly from the source tree.
>>
>> Could you describe more about your workflow why this patch
>> is necessary? I would like to understand whether this is a bug
>> fix for your workflow or something else.
>>
>>>
>>> Signed-off-by: Sergey Kacheev <s.kacheev@gmail.com>
>>> ---
>>> Changes from v1:
>>> - Replaced the patch for github/libpf with a patch for bpf-next Linux
>>> source tree
>>> Reference:
>>> - v1: https://lore.kernel.org/bpf/CAJVhQqXomJeO_23DqNWO9KUU-+pwVFoae0Xj=8uH2V=N0mOUSg@mail.gmail.com/
>>> ---
>>>    tools/lib/bpf/bpf_tracing.h | 2 +-
>>>    tools/lib/bpf/usdt.bpf.h    | 4 ++--
>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>>> index be076a404..3803479db 100644
>>> --- a/tools/lib/bpf/bpf_tracing.h
>>> +++ b/tools/lib/bpf/bpf_tracing.h
>>> @@ -2,7 +2,7 @@
>>>    #ifndef __BPF_TRACING_H__
>>>    #define __BPF_TRACING_H__
>>>
>>> -#include <bpf/bpf_helpers.h>
>>> +#include "bpf_helpers.h"
>>>
>>>    /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
>>>    #if defined(__TARGET_ARCH_x86)
>>> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
>>> index 0bd4c135a..f6763300b 100644
>>> --- a/tools/lib/bpf/usdt.bpf.h
>>> +++ b/tools/lib/bpf/usdt.bpf.h
>>> @@ -4,8 +4,8 @@
>>>    #define __USDT_BPF_H__
>>>
>>>    #include <linux/errno.h>
>>> -#include <bpf/bpf_helpers.h>
>>> -#include <bpf/bpf_tracing.h>
>>> +#include "bpf_helpers.h"
>>> +#include "bpf_tracing.h"
>>>
>>>    /* Below types and maps are internal implementation details of libbpf's USDT
>>>     * support and are subjects to change. Also, bpf_usdt_xxx() API helpers should
>>> --
>>> 2.39.2
>>>
> 

