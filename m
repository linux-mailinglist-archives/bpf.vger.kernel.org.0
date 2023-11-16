Return-Path: <bpf+bounces-15159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679737EDB53
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 06:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1459C280FC7
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 05:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57210CA46;
	Thu, 16 Nov 2023 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DmWs2odR"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B036CC2
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 21:53:04 -0800 (PST)
Message-ID: <5ff45ce6-f1bb-462c-9b1e-aadfb881808a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700113983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsIP/VS6rGR5s3xC9mmdYDIoDcaS13Pz0T89+vNaTAk=;
	b=DmWs2odRAbR9UXAs7DJezIyJcKyNZrvfke/ZoWgguDvL3EVnvc9GJAUc/8oKirKTmGzkGb
	a3lUpNULgGHjyON97B7BTat1mkY+y0/X6crxcTDbTUJILiffsOWt6h2C5JVl9MJL9VeJUN
	R2cERV9pyH+UfI+kJJyQCXUzDMmTBVw=
Date: Thu, 16 Nov 2023 00:52:56 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 01/13] bpf: Add support for non-fix-size
 percpu mem allocation
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152734.1995725-1-yonghong.song@linux.dev>
 <20231115153139.29313-A-hca@linux.ibm.com>
 <379ff74e-cad2-919c-4130-adbe80d50a26@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <379ff74e-cad2-919c-4130-adbe80d50a26@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/15/23 8:15 PM, Hou Tao wrote:
> Hi,
>
> On 11/15/2023 11:31 PM, Heiko Carstens wrote:
>> On Sun, Aug 27, 2023 at 08:27:34AM -0700, Yonghong Song wrote:
>>> This is needed for later percpu mem allocation when the
>>> allocation is done by bpf program. For such cases, a global
>>> bpf_global_percpu_ma is added where a flexible allocation
>>> size is needed.
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   include/linux/bpf.h   |  4 ++--
>>>   kernel/bpf/core.c     |  8 +++++---
>>>   kernel/bpf/memalloc.c | 14 ++++++--------
>>>   3 files changed, 13 insertions(+), 13 deletions(-)
>> Both Marc and Mikhail reported out-of-memory conditions on s390 machines,
>> and bisected it down to this upstream commit 41a5db8d8161 ("bpf: Add
>> support for non-fix-size percpu mem allocation").
>> This seems to eat up a lot of memory only based on the number of possible
>> CPUs.
>>
>> If we have a machine with 8GB, 6 present CPUs and 512 possible CPUs (yes,
>> this is a realistic scenario) the memory consumption directly after boot
>> is:
>>
>> $ cat /sys/devices/system/cpu/present
>> 0-5
>> $ cat /sys/devices/system/cpu/possible
>> 0-511
> Will the present CPUs be hot-added dynamically and eventually increase
> to 512 CPUs ? Or will the present CPUs rarely be hot-added ? After all
> possible CPUs are online, will these CPUs be hot-plugged dynamically ?
> Because I am considering add CPU hotplug support for bpf mem allocator,
> so we can allocate memory according to the present CPUs instead of
> possible CPUs. But if the present CPUs will be increased to all possible
> CPUs quickly, there will be not too much benefit to support hotplug in
> bpf mem allocator.

Thanks, Hou. In my development machine and also checking
some internal production machines, no suprisingly, the 'present' number
cpus is equal to the 'possible' number of cpus. I suspect in most cases,
'present' and 'possible' are the same. But it would be good that
other people can share their 'present != possible' configuration
and explain why.


