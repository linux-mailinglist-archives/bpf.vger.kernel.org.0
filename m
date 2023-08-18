Return-Path: <bpf+bounces-8100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06F78132B
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 20:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5961C21690
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533461B7F5;
	Fri, 18 Aug 2023 18:59:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A96106
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 18:59:08 +0000 (UTC)
Received: from out-34.mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7F30F6
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 11:59:05 -0700 (PDT)
Message-ID: <0df5a91f-ffac-3fbe-2dfe-bbc505690107@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692385143; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6qicpX4uXS3zoKmhiDM70NVlPiebfJHVZswX4SatOw=;
	b=MmUvIOW8I1ijzHkhpzZjoJHtHnfRgdZG806HasYYd6UdbN9d7JvT9Mi5WGUzsImtGP4r09
	G50GWKTIfmZR9KvEw1Wok6SqtJrQT2BgQv1vOaAIjBo+iP/9gZ61dVyeCDV0qPKcGfduwB
	RjqHi520o35l1I+5Blp39Xhjpsby3y4=
Date: Fri, 18 Aug 2023 11:58:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 15/15] bpf: Mark
 BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated
Content-Language: en-US
To: Zvi Effron <zeffron@riotgames.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172928.1373311-1-yonghong.song@linux.dev>
 <CAC1LvL26-Gb-baphJoKUwdigR4rCqBYDz4D3JxGM+e3W9RTR+w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAC1LvL26-Gb-baphJoKUwdigR4rCqBYDz4D3JxGM+e3W9RTR+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 11:26 AM, Zvi Effron wrote:
> On Mon, Aug 14, 2023 at 10:30 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> Now 'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE + local percpu ptr'
> 
> I found this commit message very confusing until I realized there was a typo
> here. Shouldn't this be "Now 'BPF_MAP_TYPE_CGRP_STORAGE + local percpu ptr'"?

You are right. Thanks for pointing this out. Will fix in the
next revision.

> 
>> can cover all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE functionality
>> and more. So mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>> include/uapi/linux/bpf.h | 9 ++++++++-
>> tools/include/uapi/linux/bpf.h | 9 ++++++++-
>> 2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index d21deb46f49f..5d1bb6b42ea2 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -932,7 +932,14 @@ enum bpf_map_type {
>> */
>> BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>> BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
>> - BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>> + BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
>> + /* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
>> + * attaching to a cgroup. The new mechanism (BPF_MAP_TYPE_CGRP_STORAGE +
>> + * local percpu kptr) supports all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
>> + * functionality and more. So mark * BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
>> + * deprecated.
>> + */
>> + BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE = BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
>> BPF_MAP_TYPE_QUEUE,
>> BPF_MAP_TYPE_STACK,
>> BPF_MAP_TYPE_SK_STORAGE,
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index d21deb46f49f..5d1bb6b42ea2 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -932,7 +932,14 @@ enum bpf_map_type {
>> */
>> BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>> BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
>> - BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>> + BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
>> + /* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
>> + * attaching to a cgroup. The new mechanism (BPF_MAP_TYPE_CGRP_STORAGE +
>> + * local percpu kptr) supports all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
>> + * functionality and more. So mark * BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
>> + * deprecated.
>> + */
>> + BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE = BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
>> BPF_MAP_TYPE_QUEUE,
>> BPF_MAP_TYPE_STACK,
>> BPF_MAP_TYPE_SK_STORAGE,
>> --
>> 2.34.1
>>
>>
> 

