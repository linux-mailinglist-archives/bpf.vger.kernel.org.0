Return-Path: <bpf+bounces-15158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFFE7EDB1A
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 06:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2875C1C2095F
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 05:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052544430;
	Thu, 16 Nov 2023 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fV8F4q5t"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [IPv6:2001:41d0:203:375::bd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEDC18A
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 21:16:43 -0800 (PST)
Message-ID: <9dfbc7ce-49cc-4519-88cf-93d6b72e5ff6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700111801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8j/xxx3Ow28uXIiT4hsoM+04dPycL4vVSYm73xYPFAY=;
	b=fV8F4q5t5hh7h24d7bU0o1bWZTS+MOK3/tAqiXgt6+mjZcrfemOPyZm0/LFrj0kBgHBOwO
	WbfkagNrdf2dXoLdRs3vTYLtccXBLcCCn56fMBmJiiA0DxTh35FRzHW4ecXYWhOTL02HwF
	gh6NzQAnUeoOuHAQhyXidtXLYVLM9LU=
Date: Thu, 16 Nov 2023 00:16:34 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] bpf: bpf_iter_task_next: use next_task(kit->task)
 rather than next_task(kit->pos)
Content-Language: en-GB
To: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@fb.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20231114163239.GA903@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231114163239.GA903@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> This looks more clear and simplifies the code. While at it, remove the
> unnecessary initialization of pos/task at the start of bpf_iter_task_new().
>
> Note that we can even kill kit->task, we can just use pos->group_leader,
> but I don't understand the BUILD_BUG_ON() checks in bpf_iter_task_new().

Let us keep kit->task, which is used in later function
bpf_iter_task_next(). The patch looks good to me.

>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


