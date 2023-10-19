Return-Path: <bpf+bounces-12735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCE07D02AC
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87701282319
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8A3C689;
	Thu, 19 Oct 2023 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceWrZrY6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2503C06D
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:43:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A3FA
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697744615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2hUdNrDnQEQbWLhZ/z1BIBPPa5zZourvuRZEYEaF1M=;
	b=ceWrZrY6suK3JAH3xJyp9hlZt3CY6h9pXF08bFm6Xuz7/GMn+TtC7r8YjQ/fA/Gt2q17SG
	D8jt4w0XTBagVCpGavnN/gnsOnvdpxwI/Uk280fR3kK/PDuUmdTtMgtspXSiGYAv7HAYF5
	dDBraTWak4GxYm2C9xCQjnrEMZi0f4M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-zfFuhXWBO_63cHZoRkQT8w-1; Thu, 19 Oct 2023 15:43:30 -0400
X-MC-Unique: zfFuhXWBO_63cHZoRkQT8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 615E33806703;
	Thu, 19 Oct 2023 19:43:28 +0000 (UTC)
Received: from [10.22.32.252] (unknown [10.22.32.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E5781121314;
	Thu, 19 Oct 2023 19:43:26 +0000 (UTC)
Message-ID: <09ff4166-bcc2-989b-97ce-a6574120eea7@redhat.com>
Date: Thu, 19 Oct 2023 15:43:26 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the cgroup
 root_list RCU safe
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
 sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-2-laoar.shao@gmail.com>
 <ZS-m3t-_daPzEsJL@slm.duckdns.org>
 <CALOAHbAd2S--=72c2267Lrcj_czkitdG9j97pai2zGqdAskvQQ@mail.gmail.com>
 <ZTF-nOb4HDvjTSca@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZTF-nOb4HDvjTSca@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 10/19/23 15:08, Tejun Heo wrote:
> On Thu, Oct 19, 2023 at 02:38:52PM +0800, Yafang Shao wrote:
>>>> -     BUG_ON(!res_cgroup);
>>>> +     WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));
>>> This doesn't work. lockdep_is_held() is always true if !PROVE_LOCKING.
>> will use mutex_is_locked() instead.
> But then, someone else can hold the lock and trigger the condition
> spuriously. The kernel doesn't track who's holding the lock unless lockdep
> is enabled.

It is actually possible to detect if the current process is the owner of 
a mutex since there is a owner field in the mutex structure. However, 
the owner field also contains additional information which need to be 
masked off before comparing with "current". If such a functionality is 
really needed, we will have to add a helper function mutex_is_held(), 
for example, to kernel/locking/mutex.c.

Cheers,
Longman


