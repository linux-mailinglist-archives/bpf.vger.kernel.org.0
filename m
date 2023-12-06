Return-Path: <bpf+bounces-16894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D08075D5
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F81B28208D
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F64495E5;
	Wed,  6 Dec 2023 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dADRBsZE"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [IPv6:2001:41d0:203:375::bd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB48D5B
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 08:53:55 -0800 (PST)
Message-ID: <3eafcd8e-3637-4e7a-8d6b-fe8ff86dd5ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701881633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWc36HdEpIHZkGbN+Jfe9ruxwmJlZbuWpOgW68j1Kuc=;
	b=dADRBsZEC14DYrE96EVeaF8omgxBQY4mQxKCcEX0UKdnALq3mT5ZwFHLh80YwFCh44b2aF
	FYvksmGiWab8dRpcI7Ggc1QzyG8sSVKY8ODhjoDIlqqi6vpiDAwOHjAV9DUgdH5eVWuIBs
	3Ex/EmGN971c87KXwfkMC9HdW+QoPiM=
Date: Wed, 6 Dec 2023 08:53:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Test the release of map btf
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231206110625.3188975-1-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231206110625.3188975-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/6/23 6:06 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> When there is bpf_list_head or bpf_rb_root field in map value, the free
> of map btf and the free of map value may run concurrently and there may
> be use-after-free problem, so add two test cases to demonstrate it.
>
> The first test case tests the racing between the free of map btf and the
> free of array map. It constructs the racing by releasing the array map in
> the end after other ref-counter of map btf has been released. But it is
> still hard to reproduce the UAF problem, and I managed to reproduce it
> by queuing multiple kworkers to stress system_unbound_wq concurrently.
>
> The second case tests the racing between the free of map btf and the
> free of inner map. Beside using the similar method as the first one
> does, it uses bpf_map_delete_elem() to delete the inner map and to defer
> the release of inner map after one RCU grace period. The UAF problem can
> been easily reproduced by using bpf_next tree and a KASAN-enabled kernel.

Thanks, Hou. I will use your test cases as well during debugging
besides my kernel mdeley() hack.

>
> The reason for using two skeletons is to prevent the release of outer
> map and inner map in map_in_map_btf.c interfering the release of bpf
> map in normal_map_btf.c.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> Hi,
>
> I was also working on the UAF problem caused by the racing between the
> free map btf and the free map value. However considering Yonghong posted
> the patch first [1], I decided to post the selftest for the problem. The
> reliable reproduce of the problem depends on the "Fix the release of
> inner map" patch-set in bpf-next.
>
> [1]: https://lore.kernel.org/bpf/20231205224812.813224-1-yonghong.song@linux.dev/
>
>   .../selftests/bpf/prog_tests/map_btf.c        | 88 +++++++++++++++++++
>   .../selftests/bpf/progs/map_in_map_btf.c      | 73 +++++++++++++++
>   .../selftests/bpf/progs/normal_map_btf.c      | 56 ++++++++++++
>   3 files changed, 217 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/map_btf.c
>   create mode 100644 tools/testing/selftests/bpf/progs/map_in_map_btf.c
>   create mode 100644 tools/testing/selftests/bpf/progs/normal_map_btf.c

[...]


