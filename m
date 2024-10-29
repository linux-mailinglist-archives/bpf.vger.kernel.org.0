Return-Path: <bpf+bounces-43365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC49B4005
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E9F1C21617
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEF9187560;
	Tue, 29 Oct 2024 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="linWcco/"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426A15B0F7
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167048; cv=none; b=M+Vj9PWXonUepdKNCp9d9tfU+Vs4zDvFhSh/CeCfzS5e8PNwCwAEov31RXwTqliaufz+NeBENLk//QOYeism09xh/IUnaygsDV7mKQzCVDpOh/knUmHxT5sHdc4kWRsflQFLjt0SckjkXyCCyuVnZ5JYU2RNQNd4chgPCFjaZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167048; c=relaxed/simple;
	bh=/tujiYzgtKmI3GSqINSf7T3bKHcHjtY8O0SMEAWycN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9NITPeKVObjdvcOf7InkYIziDF7MJgTeSrU41zjtqGvFM2PvuekS6wG12KjAoqR70U4kz9mchObb9GxdJMB6P+5nTavZNanCp1HS2lnJw2sEkZamIVMzNBhidmR0ElteDQKyj9P2Mp6py8uGGfF/IWExzdBysN9IwjzkvcWNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=linWcco/; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e15a5de1-5a82-4137-8422-78306ba567e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730167039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAD6i5c523zoovdUZiZJpfCrFrr5SaagsomRSKrpuxM=;
	b=linWcco/YYNlTHHAaSnwsfxdMcRHndRIO4JXG75HiPncD4XvheOkDyIYnv65mgB0fqrQ/M
	w6SPSypnDnO2yrq/2gzwfeBY3yDcDTlGxDEwAQx80DZcwboQbdqMyOa498frGX/xsYyVj5
	h3f3YcskBIZ3hHkpIhygTCDswlfLbDc=
Date: Mon, 28 Oct 2024 18:57:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch bpf] sock_map: fix a NULL pointer dereference in
 sock_map_link_update_prog()
To: Yonghong Song <yonghong.song@linux.dev>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 Ruan Bonan <bonan.ruan@u.nus.edu>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org
References: <20241026185522.338562-1-xiyou.wangcong@gmail.com>
 <9117f014-3ad3-4d9a-9357-4b57d376c660@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <9117f014-3ad3-4d9a-9357-4b57d376c660@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/27/24 10:58 PM, Yonghong Song wrote:
> 
> On 10/26/24 11:55 AM, Cong Wang wrote:
>> From: Cong Wang <cong.wang@bytedance.com>
>>
>> The following race condition could trigger a NULL pointer dereference:
>>
>> sock_map_link_detach():        sock_map_link_update_prog():
>>     mutex_lock(&sockmap_mutex);
>>     ...
>>     sockmap_link->map = NULL;
>>     mutex_unlock(&sockmap_mutex);
>>                        mutex_lock(&sockmap_mutex);
>>                    ...
>>                    sock_map_prog_link_lookup(sockmap_link->map);
>>                    mutex_unlock(&sockmap_mutex);
>>     <continue>
>>
>> Fix it by adding a NULL pointer check. In this specific case, it makes
>> no sense to update a link which is being released.
>>
>> Reported-by: Ruan Bonan <bonan.ruan@u.nus.edu>
>> Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb progs")
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: Jakub Sitnicki <jakub@cloudflare.com>
>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>> ---
>>   net/core/sock_map.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 07d6aa4e39ef..9fca4db52f57 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -1760,6 +1760,10 @@ static int sock_map_link_update_prog(struct bpf_link 
>> *link,
>>           ret = -EINVAL;
>>           goto out;
>>       }
>> +    if (!sockmap_link->map) {
>> +        ret = -EINVAL;
> 
> Thanks for the fix. Maybe we should use -ENOENT as the return error code?
> In this case, update_prog failed due to sockmap_link->map == NULL which is
> equivalent to no 'entry' to update.

The fix lgtm. Regarding the error value, the tcx/bpf_struct_ops/cgroup's 
update_prog uses -ENOLINK. I changed it to -ENOLINK for consistency. Applied. 
Thanks.

> 
>> +        goto out;
>> +    }
>>       ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
>>                       sockmap_link->attach_type);
> 


