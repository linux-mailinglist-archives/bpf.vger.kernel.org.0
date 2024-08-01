Return-Path: <bpf+bounces-36206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA999441DC
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 05:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061AD1C22649
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BAC142E77;
	Thu,  1 Aug 2024 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MD/XkjgV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF21428F0
	for <bpf@vger.kernel.org>; Thu,  1 Aug 2024 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722482577; cv=none; b=u/TxxawmNHFhHdqds7LqwoI10MVsMLJgmldnJ39kvPeEzBvfhly0oWBlPrfxOM1XsY8b0mAjzCBqi+2c/3TvHoU052Co0A57C3uNM7XirFIHvonGXhFDndd+U0KzC2fA8DRyfuvuIFYIieavm4tJorzSc2PGgKi1B//MgkjuaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722482577; c=relaxed/simple;
	bh=kaWU0UtEMwQ1O7iXzGFMx10qiNwA/UUpCQN/mZbLUYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jscb9uI3LOEE64uWfqkX4XxAeQf2gYT9Dbgb5+qnnJj4e2xQraAB3YuWdLBkb3OINU7F52o79yBsIKV4xCzJcaEHNLxk5KD/t3wKir/IZxJArIDmPUwkwWzW4fwhKtecHYuPMR9S/wVWtk5kSYu5Bvkjkqez9gyoQmrto9NwpOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MD/XkjgV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722482574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSRz3A6ElKt7l6qd6qwvIoB/IVcQJsavNnaNqcf8XME=;
	b=MD/XkjgVtyEa7j+heKOmJsNG/u9nJ3xQsDGbuAm80f5XlbYAegIqJTIIhQ003BtQL+s8q0
	mhYOCYRMiPoJsPMqR5fQhFKI/4WDfksIeFshFF50uXOfB0SK1uWT7NMFtb3y26j3uh+n2O
	IMZzaAapsUCTzyZ6klB6ch7avIfyInw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-DZ8zIapOM3CnhW-bjWuYAw-1; Wed,
 31 Jul 2024 23:22:49 -0400
X-MC-Unique: DZ8zIapOM3CnhW-bjWuYAw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B90D719560B0;
	Thu,  1 Aug 2024 03:22:47 +0000 (UTC)
Received: from [10.2.16.2] (unknown [10.2.16.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABAD4300019E;
	Thu,  1 Aug 2024 03:22:45 +0000 (UTC)
Message-ID: <6a79b50a-ad74-4b1b-a98c-7da8ef341b24@redhat.com>
Date: Wed, 31 Jul 2024 23:22:44 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Do not clear xcpus when clearing
 cpus
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731092102.2369580-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240731092102.2369580-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/31/24 05:21, Chen Ridong wrote:
> After commit 737bb142a00d ("cgroup/cpuset: Make cpuset.cpus.exclusive
> independent of cpuset.cpus"), cpuset.cpus.exclusive and cpuset.cpus
> became independent. However we found that cpuset.cpus.exclusive.effective
> is cleared when cpuset.cpus is clear. To fix this issue, just remove xcpus
> clearing when cpuset.cpus is being cleared.
>
> It can be reproduced as below:
> cd /sys/fs/cgroup/
> mkdir test
> echo +cpuset > cgroup.subtree_control
> cd test
> echo 3 > cpuset.cpus.exclusive
> cat cpuset.cpus.exclusive.effective
> 3
> echo > cpuset.cpus
> cat cpuset.cpus.exclusive.effective // was cleared
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a9b6d56eeffa..248c39bebbe9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2523,10 +2523,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	 * that parsing.  The validate_change() call ensures that cpusets
>   	 * with tasks have cpus.
>   	 */
> -	if (!*buf) {
> +	if (!*buf)
>   		cpumask_clear(trialcs->cpus_allowed);
> -		cpumask_clear(trialcs->effective_xcpus);
> -	} else {
> +	else {
>   		retval = cpulist_parse(buf, trialcs->cpus_allowed);
>   		if (retval < 0)
>   			return retval;

Yes, that is a corner case bug that has not been properly handled.

Reviewed-by: Waiman Long <longman@redhat.com>


