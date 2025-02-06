Return-Path: <bpf+bounces-50672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3967A2AC18
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 16:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD113A48CD
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2811EDA04;
	Thu,  6 Feb 2025 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi8+wcE1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6F1E5B9E;
	Thu,  6 Feb 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854317; cv=none; b=JWrQuFDtadCV+VTppYR01qWVRI/cX778Li29plXp9x363oz3B4odk1gA1aawbZniLAC1+iayOixgLhEVdcWmwfZqJndE3MouMDUrisLklbem5d9FNlkhq4QSurdiJZrRLgBXWosYyYjwANeCcSmnmL05Ev96anj5TB90n1K6duc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854317; c=relaxed/simple;
	bh=AVF+OBl6NdvnyfJRCSXawu1jNwQwVWV2ZYTBFZFKEmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GliI0mGRGyqJhk5cQCDr0yAUeo5dJNjL/vw0/bOGseGTy81JWiqx2yNt+bhmt5IO9PpXzreoIcQVitsqy0ZuqBWEbGQjBRsJylt4/OCpgN35WhE560CQHYZXMfo2lPtipqq4EWPhb1/LysjTLp7NUGYEYJKsJrw7wrtG8luxXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi8+wcE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4CDC4CEE5;
	Thu,  6 Feb 2025 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738854315;
	bh=AVF+OBl6NdvnyfJRCSXawu1jNwQwVWV2ZYTBFZFKEmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Vi8+wcE1RKFK9yrjLzo7EoY20c+kDBXpark5fdtKXCHSloo7Zqf4RX+puznR3rQZ6
	 gArBXG6x1Z9KVVFbCOA4JQT1+Li6qbPuuClgAr7rYy26CbKsCfRlcOsS6NPoWRDQsK
	 sCzykYaaYQn/bPcdOZuIaR+lkZqNbJLqTWOhKsPVZrT/ZCos4fgiXUBDn3gd5Lwaws
	 PwEWSYn626S8GDxI1yOthVVYcq1qj74I7pIj1Wkq/3KTNinoGcxTbSmGdXLxZHyBCe
	 VpDEm1qUdKBvwsrGXmijdHbKueliDEERRPUliyPans+M8d7oVmz1ro89j7MNY6jF8k
	 BvzX/PhvHythg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B9576184F95B; Thu, 06 Feb 2025 16:05:02 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, Hou Tao <hotforest@gmail.com>,
 bpf@vger.kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in
 hash map atomically
In-Reply-To: <cca6daf2-48f4-57b9-59a9-75578bb755b9@huaweicloud.com>
References: <20250204082848.13471-1-hotforest@gmail.com>
 <20250204082848.13471-3-hotforest@gmail.com>
 <cca6daf2-48f4-57b9-59a9-75578bb755b9@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 06 Feb 2025 16:05:02 +0100
Message-ID: <8734gr3yht.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hou Tao <houtao@huaweicloud.com> writes:

> +cc Cody Haas
>
> Sorry for the resend. I sent the reply in the HTML format.
>
> On 2/4/2025 4:28 PM, Hou Tao wrote:
>> Currently, the update of existing element in hash map involves two
>> steps:
>> 1) insert the new element at the head of the hash list
>> 2) remove the old element
>> 
>> It is possible that the concurrent lookup operation may fail to find
>> either the old element or the new element if the lookup operation starts
>> before the addition and continues after the removal.
>> 
>> Therefore, replacing the two-step update with an atomic update. After
>> the change, the update will be atomic in the perspective of the lookup
>> operation: it will either find the old element or the new element.
>> 
>> Signed-off-by: Hou Tao <hotforest@gmail.com>
>> ---
>>  kernel/bpf/hashtab.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>> 
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 4a9eeb7aef85..a28b11ce74c6 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -1179,12 +1179,14 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>  		goto err;
>>  	}
>>  
>> -	/* add new element to the head of the list, so that
>> -	 * concurrent search will find it before old elem
>> -	 */
>> -	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>> -	if (l_old) {
>> -		hlist_nulls_del_rcu(&l_old->hash_node);
>> +	if (!l_old) {
>> +		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>> +	} else {
>> +		/* Replace the old element atomically, so that
>> +		 * concurrent search will find either the new element or
>> +		 * the old element.
>> +		 */
>> +		hlist_nulls_replace_rcu(&l_new->hash_node, &l_old->hash_node);
>>  
>>  		/* l_old has already been stashed in htab->extra_elems, free
>>  		 * its special fields before it is available for reuse. Also
>> 
>
> After thinking about it the second time, the atomic list replacement on
> the update side is enough to make lookup operation always find the
> existing element. However, due to the immediate reuse, the lookup may
> find an unexpected value. Maybe we should disable the immediate reuse
> for specific map (e.g., htab of maps).

Hmm, in an RCU-protected data structure, reusing the memory before an
RCU grace period has elapsed is just as wrong as freeing it, isn't it?
I.e., the reuse logic should have some kind of call_rcu redirection to
be completely correct?

-Toke

