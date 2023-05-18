Return-Path: <bpf+bounces-842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07BD707782
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 03:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4300281750
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B91389;
	Thu, 18 May 2023 01:42:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3F7E
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 01:42:16 +0000 (UTC)
Received: from out-45.mta1.migadu.com (out-45.mta1.migadu.com [IPv6:2001:41d0:203:375::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F8212F
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 18:42:13 -0700 (PDT)
Message-ID: <a453c3d4-5615-f445-17a8-92a1dc4282e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684374130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3gOJF+MXOBVq1iRu2W9W0FS9rlAZbKgdHYpF5mdLYw=;
	b=RwU0TiOxw2327F+kMmXihTAd02Cf701OOjP6FIfyfSwLCMe+5ycqEHxO7MkapmNHhUgOod
	AcQ0y+gwx7ckF42fBknrcDX8s3rp+wiyro0mZdGDtyrqe2EtxncGed5ryW6E2oxtBs5VDX
	j2+9myDtAVqH1UktlLEJFbwifSlgY7E=
Date: Wed, 17 May 2023 18:42:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
Content-Language: en-US
To: Lorenz Bauer <lmb@isovalent.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20230515121521.30569-1-lmb@isovalent.com>
 <a29c604e-5a68-eed2-b581-0ad4687fda10@linux.dev>
 <CAN+4W8hixyHYOwYRh-3WedS-a0KTQk8VQ4JxqM8y-DQY-yjsNA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAN+4W8hixyHYOwYRh-3WedS-a0KTQk8VQ4JxqM8y-DQY-yjsNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/17/23 2:01 AM, Lorenz Bauer wrote:
> On Wed, May 17, 2023 at 7:26 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 5/15/23 5:15 AM, Lorenz Bauer wrote:
>>> In commit 9b459804ff99 ("btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT, UNION, PTR")
>>> I fixed a bug that occurred during resolving of a DATASEC by strategically resetting
>>> resolve_mode. This fixes the immediate bug but leaves us open to future bugs where
>>> nested types have to be resolved.
>>
>> hmm... future bugs like when adding new BTF_KIND in the future?
> 
> It could just be refactoring of the codebase? What is the downside of
> restoring the mode when popping the item? It also makes push and pop
> symmetrical.

I can see your point to refactor it to make it work for all different BTF_KIND.

Other than BTF_KIND_DATASEC, env->resolve_mode stays the same for all other 
kinds once it is decided. It is why resolve_mode is in the "env" instead of "v". 
My concern is this will hide some bugs (existing or future) that accidentally 
changed the resolve_mode in the middle. If there is another legit case that 
could be found other than BTF_KIND_DATASEC, that will be a better time to do 
this refactoring with a proper test case considering most bpf progs need btf to 
load nowadays and probably need to veristat test also. If it came to that, might 
as well consider moving resolve_mode from "env" to "v".

btf_datasec_resolve() is acting as a very top level resolver like btf_resolve(), 
so it reset env->resolve_mode before resolving its var member like how 
btf_resolve() does. imo, together with env->resolve_mode stays the same for 
others, it is more straight forward to reason. I understand that it is personal 
preference and could argue either way.

