Return-Path: <bpf+bounces-32854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3BB913CC1
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 18:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AD82830E3
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1F183063;
	Sun, 23 Jun 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGRAI641"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD811822F1
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719160117; cv=none; b=eRkdq2i9wiNCHMm9Sj6HFbv4pJGfxB8tJ0HcX21IRbFhrukANQTyS9knm2S4Bt/WiPo3MKuxNxkFfriv56R0Ne+3EVNL2YFWTKh5FJqkTY07Q1j9nYI5kZMVLt3/zfbgtPIS2rIC4w5HTEgGIVvmrX78nbkZTKq+6fVW6o+IGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719160117; c=relaxed/simple;
	bh=j+G1rCF0ZlMASY55SFj/LvYvFeRAYxy7y8hu/Ng565E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSz9dP1g4oiyuw7jMnjsGdo0SXv7RmRyN5Rx++wMWj858tVizN2k+qPqLpavyJ0ry4KckIbJCDNZjqPiagxfLZB5yR7iixkaNLEvtAh9ctE/yeoVYdKOv2naTCivrgEtAMM6iUhV7Kcf02Yaj+lo0MBvEtV5fkuNsM4J+RiiSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGRAI641; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719160114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gnaWRD8ylcnmm1NRbcxG/FfvDBQo2p7E7YoZdMGokg=;
	b=WGRAI641pUftnNjHmJ3VVrBwAZUjm2q9Nbp/fonCxQRDgEdIQfsBDSO6jANyfDTCbuCu6u
	Q2hOaGP8i0iTPlWlRLbbR5Gt4aJEIiQ6SbeZslmI5TrSlw0y72SrhmQEFrfs0h+MUpSndY
	nB5kG6IWIUlPebBWyQTcxeaokpw19pc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-N4HFNCRaMSSY4mqaRN6-hA-1; Sun,
 23 Jun 2024 12:28:27 -0400
X-MC-Unique: N4HFNCRaMSSY4mqaRN6-hA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2994D195608B;
	Sun, 23 Jun 2024 16:28:25 +0000 (UTC)
Received: from [10.22.16.52] (unknown [10.22.16.52])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3B1A1956087;
	Sun, 23 Jun 2024 16:28:22 +0000 (UTC)
Message-ID: <dc0b2650-4c0d-4f52-8c60-b9afbe728103@redhat.com>
Date: Sun, 23 Jun 2024 12:28:21 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
To: Markus Elfring <Markus.Elfring@web.de>,
 Chen Ridong <chenridong@huawei.com>, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall
 <julia.lawall@inria.fr>, Peter Zijlstra <peterz@infradead.org>
References: <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
 <b8792fb5-9efe-4dfc-ab61-6fa55a4b0d51@web.de>
 <2c70eff8-c79a-4c99-b8db-491ce25745a0@redhat.com>
 <f40c4a72-0c6c-4846-a926-ba1eb2763697@web.de>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <f40c4a72-0c6c-4846-a926-ba1eb2763697@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 6/23/24 02:18, Markus Elfring wrote:
>>> …
>>>> +++ b/kernel/cgroup/cpuset.c
>>> …
>>>> @@ -5051,10 +5066,12 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>>>>        if (!buf)
>>>>            goto out;
>>>>
>>>> +    mutex_lock(&cpuset_mutex);
>>>>        css = task_get_css(tsk, cpuset_cgrp_id);
>>>>        retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>>>>                    current->nsproxy->cgroup_ns);
>>>>        css_put(css);
>>>> +    mutex_unlock(&cpuset_mutex);
>>> …
>>>
>>> Under which circumstances would you become interested to apply a statement
>>> like “guard(mutex)(&cpuset_mutex);”?
>>> https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h#L196
>> A mutex guard will be more appropriate if there is an error exit case that needs to be handled.
> Lock guards can help to reduce and improve source code another bit,
> can't they?

For simple lock critical section, there isn't too much difference in 
term of readability between using lock guard and normal lock/unlock 
call. If there are multiple exit points in the critical section, lock 
guard can help to simplify the code. For those situations, I will 
certain try to use lock guard.

Another reason that I go with normal lock/unlock is that none of the 
cpuset_mutex lock/unlock sites in cpuset.c has used lock guard yet and 
there is no good reason in introduce something different from other call 
sites.

Cheers,
Longman



