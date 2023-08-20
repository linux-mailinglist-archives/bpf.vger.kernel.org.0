Return-Path: <bpf+bounces-8129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A04781C49
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 05:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64281C208C2
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 03:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7A3ED1;
	Sun, 20 Aug 2023 03:51:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A4EA9
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 03:51:11 +0000 (UTC)
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35F100
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 20:45:48 -0700 (PDT)
Message-ID: <9393aeed-55d8-e4d6-b2dc-33999eaf2a4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692503146; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enJ3zSuzPQpCmUTuHBuI6Oxu770azdfVKIq2o/s+PdI=;
	b=VdqqAqSKJSDC/Ba+xL5foP24xZsnrE+7liOnact900fHoyZdocas2etJiA5gSHUgxEXt1y
	YXDyXBMATw2bwAygOP15CI0suWJS3NLkntg7a3NGY9zlh2gtlOWfbQc0dYepaRpyjl908o
	4kj0vKQ9GBKObN3cJJULLZBQ21fXR2c=
Date: Sat, 19 Aug 2023 20:45:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 02/15] bpf: Add BPF_KPTR_PERCPU_REF as a field
 type
Content-Language: en-US
To: David Marchevsky <david.marchevsky@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172820.1362751-1-yonghong.song@linux.dev>
 <ee360b23-9768-9187-4eb0-d43b67bcd07c@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ee360b23-9768-9187-4eb0-d43b67bcd07c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 11:37 AM, David Marchevsky wrote:
> On 8/14/23 1:28 PM, Yonghong Song wrote:
>> BPF_KPTR_PERCPU_REF represents a percpu field type like below
>>
>>    struct val_t {
>>      ... fields ...
>>    };
>>    struct t {
>>      ...
>>      struct val_t __percpu *percpu_data_ptr;
>>      ...
>>    };
>>
>> where
>>    #define __percpu __attribute__((btf_type_tag("percpu")))
> 
> nit: Maybe this should be __percpu_kptr (and similar for the actual tag)?
> 
> I don't feel strongly about this. It's certainly less concise, but given that
> existing docs mention kptrs a few times, and anyone using percpu kptrs can
> probably be expected to have some familiarity with "normal" kptrs, making
> it more clear to BPF program writers that their existing mental model of
> what a kptr is and how it should be used seems beneficial.

Thanks for suggestion. As Alexei suggested later as well,
__percpu_kptr is better than __percpu so users won't be confused
with kernel __percpu tag.

> 
>>
>> While BPF_KPTR_REF points to a trusted kernel object or a trusted
>> local object, BPF_KPTR_PERCPU_REF points to a trusted local
>> percpu object.
>>
>> This patch added basic support for BPF_KPTR_PERCPU_REF
>> related to percpu field parsing, recording and free operations.
>> BPF_KPTR_PERCPU_REF also supports the same map types
>> as BPF_KPTR_REF does.
>>
>> Note that unlike a local kptr, it is possible that
>> a BPF_KTPR_PERCUP_REF struct may not contain any
> 
> nit: typo here ("BPF_KTPR_PERCUP_REF" -> "BPF_KPTR_PERCPU_REF")

Ack. Thanks!

> 
>> special fields like other kptr, bpf_spin_lock, bpf_list_head, etc.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h  | 18 ++++++++++++------
>>   kernel/bpf/btf.c     |  5 +++++
>>   kernel/bpf/syscall.c |  7 ++++++-
>>   3 files changed, 23 insertions(+), 7 deletions(-)
>>
[...]

