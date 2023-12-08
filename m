Return-Path: <bpf+bounces-17219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D8180AB88
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 19:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8A21C20A99
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF71341C91;
	Fri,  8 Dec 2023 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="coFJ9gz9"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D6F9
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 10:02:01 -0800 (PST)
Message-ID: <11643bd3-94ac-4e3e-8a85-1d4559eb6c1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702058519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gr97RKZTha99Jz+7LyD7vks2Px9UaDdI6c7bCNsPGS0=;
	b=coFJ9gz92mPOvjyDmNJySKWrpIILP9a9wJqs5lY90VMbotmOpuGa0qQ1pB2YneMfOsJhFO
	D/iirjx9CJfOyLUL00NpNa4FoI7yAv893weH8+5FZEm2SGNCJmVvOTLAUnhF5aru3zf7zp
	BJ/d+/VWIMdI2wEktReVIEf7yvw2pv8=
Date: Fri, 8 Dec 2023 10:01:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next 2/2] bpf: Use GFP_KERNEL in
 bpf_event_entry_gen()
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
 <20231208103357.2637299-3-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231208103357.2637299-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/8/23 2:33 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> rcu_read_lock() is no longer held when invoking bpf_event_entry_gen()
> which is called by perf_event_fd_array_get_ptr(), so using GFP_KERNEL
> instead of GFP_ATOMIC to reduce the possibility of failures due to
> out-of-memory.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


