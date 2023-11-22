Return-Path: <bpf+bounces-15694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A27F4FC8
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0BA1C20A75
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F91F188;
	Wed, 22 Nov 2023 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lvmebIko"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [IPv6:2001:41d0:203:375::b1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C54492
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:40:56 -0800 (PST)
Message-ID: <20c42052-8cb7-4b8b-a7f8-d9311e37479d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700678454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POgwYlHJWugxMWQc2iXyXTfQgLlq3kyj4NTmbpwqOFI=;
	b=lvmebIkoSQTcbgHV35q4mLtMw/9aZgQlEy7sUTHMnnB3PFKSitdHbUQan3MgSNU4Mh72oW
	aHjN97q06ZZu77I3DyL5R4TiDhgWMFX/yD1rFh5OqpOFxefeViWzjEhbDrLuxTVPdqoNew
	OWJYDH0au4mggGRP33pe9zIQwB4RJ3c=
Date: Wed, 22 Nov 2023 10:40:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpf: bring back removal of dev-bound id from
 idr
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20231114045453.1816995-1-sdf@google.com>
 <20231114045453.1816995-3-sdf@google.com>
 <49538852-1ca0-49bb-86c2-cb1b95739b91@linux.dev>
 <b4854a4b-a692-8164-5684-4315939966f3@iogearbox.net>
 <ZV5C7099HylvusQO@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZV5C7099HylvusQO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/22/23 10:05 AM, Stanislav Fomichev wrote:
>>>> Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
>>>> and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
>>>> idr when the offloaded/bound netdev goes away. I was supposed to
>>>> take a look and check in [0], but apparently I did not.
>>>>
>>>> The purpose of idr removal is to avoid BPF_PROG_GET_NEXT_ID returning
>>>> stale ids for the programs that have a dead netdev. This functionality
>>>
>>> What may be wrong if BPF_PROG_GET_NEXT_ID returns the id?
>>> e.g. If the prog is pinned somewhere, it may be useful to know a prog is still loaded in the system.
> 
> bpftool is a bit spooked by those prog ids currently: calling GET_INFO_BY_ID
> on those programs returns ENODEV. So we can keep those ids around, but
> need some tweaks on the bpftool in this case. LMK if any of you prefer
> this option.

I think it is in general useful to improve 'bpftool prog show' to keep going for 
the next prog id if possible. May be print an error message after the prog id 
and then keep going for the next prog id?

