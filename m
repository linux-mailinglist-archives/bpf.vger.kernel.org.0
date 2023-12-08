Return-Path: <bpf+bounces-17218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C154180AB80
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 19:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698F01F2134C
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E28041C8E;
	Fri,  8 Dec 2023 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YVRI/OVg"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015AFF9
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 10:00:21 -0800 (PST)
Message-ID: <ffbf2ab9-91c6-4fb9-9f56-533d6c85dd91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702058420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgjY9jJN9jmuhTIpwU+oAxTTmRdACbqy9UaZxPdYkDM=;
	b=YVRI/OVg5gewIj1NZMqXw2o1V5aKHRe4LAxsqgQ9t39qAagcIerOxBHiRtfeZ3vwY0xajd
	8tdfgp8ziKFMJh8GGK7eF+3MwkpOQEZBQR0afhEzpm/SaXqnLZA8gYWvwZB3lJ51BwMIA7
	u82xg9Jw8E4noiilAM7/RqYi9wDMjwM=
Date: Fri, 8 Dec 2023 10:00:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next 1/2] bpf: Reduce the scope of
 rcu_read_lock when updating fd map
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231208103357.2637299-1-houtao@huaweicloud.com>
 <20231208103357.2637299-2-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231208103357.2637299-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/8/23 2:33 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
> callbacks.
>
> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't need
> rcu-read-lock because array->ptrs will not be freed until the map-in-map
> is released. For bpf_fd_htab_map_update_elem(), htab_map_update_elem()
> requires rcu-read-lock to be held, so only use rcu_read_lock() during
> the invocation of htab_map_update_elem().
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>



