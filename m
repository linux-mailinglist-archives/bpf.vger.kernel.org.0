Return-Path: <bpf+bounces-8026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE3780140
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 00:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792DE1C21531
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 22:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF6107B4;
	Thu, 17 Aug 2023 22:45:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17C100B3
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 22:45:40 +0000 (UTC)
Received: from out-61.mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3D35B1
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:45:34 -0700 (PDT)
Message-ID: <5f061b5f-89a0-fadd-7233-e5bb877e680d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692312332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5cm9AFLUSjvLg/Q5Q1zFGOnGqPEazcej1e5Ponp9Lk=;
	b=Hvo9WyrqqLdmBrOmgLICRjw0tfxyKAXp19sK4HUy9JuFjgU6UDqZvkuaim2+EfOYZTBP3N
	FMmjmAuA0584Vu48WojIMChntVTusQl6F2OginhdNT8qfG79Wn9S1paXXbhmfTlp5WL45C
	EjHhXLdhOQJckjf91YfcKNStXRU/tXg=
Date: Thu, 17 Aug 2023 15:45:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 4/5] bpf: Add a new dynptr type for
 CGRUP_SOCKOPT.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Song Liu <song@kernel.org>, Kernel Team <kernel-team@meta.com>,
 Andrii Nakryiko <andrii@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <sinquersw@gmail.com>,
 Kui-Feng Lee <kuifeng@meta.com>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-5-thinker.li@gmail.com>
 <20230817012518.erfkm4tgdm3isnks@MacBook-Pro-8.local>
 <f903808f-13c3-c440-c720-2051fe6ec4fe@linux.dev>
 <CAADnVQKpiJE1aJNS=OP7GF+M9fm5ipOfO6tbKo-6yjdZMJ6YxQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQKpiJE1aJNS=OP7GF+M9fm5ipOfO6tbKo-6yjdZMJ6YxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/23 2:46 PM, Alexei Starovoitov wrote:
>> To avoid other potential optname cases that may run into similar situation and
>> requires the bpf prog work around it again like the above, it needs a way to
>> track whether a bpf prog has changed the optval in runtime. If it is not
>> changed, use the result from the kernel set/getsockopt. If reading/writing to
>> optval is done through a kfunc, this can be tracked. The kfunc can also directly
>> read/write the user memory in optval, avoid the pre-alloc kernel memory and the
>> PAGE_SIZE limit but this is a minor point.
> so I'm still not following what sleepable progs that can access everything
> would help the existing situation.
> I agree that sleepable bpf sockopt should be free from old mistakes,
> but people might still write old-style non-sleeptable bpf sockopt and
> might repeat the same mistakes.
> I'm missing the value of the new interface. It's better, sure, but why?
> Do we expect to rewrite existing sockopt progs in sleepable way?
> It might not be easy due to sleepable limitations like maps and whatever else.

so far our sockopt progs only uses sk local storage that can support sleepable 
and we can all move to the sleepable way to avoid any future quirk.

Agree that others may have sockopt prog that has hard dependency on 
non-sleepable. If the existing non-sleepable and sleepable inter-leaved 
together, it would end up hitting similar issue.

Lets drop the idea of this set.

