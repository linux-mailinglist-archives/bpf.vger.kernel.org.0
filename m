Return-Path: <bpf+bounces-37660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ACD959155
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 01:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA1E1C22359
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 23:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624F91C8FD5;
	Tue, 20 Aug 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X94LOzhv"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963110A24
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724197525; cv=none; b=VFIk5sXk0hRwufDHHPjOdvppa942VjGE9+07jsUgqoarYW1uYdx+xBPJzj3YEVC1kkAiF0c2lpb7q9v7q8xm4pJxTIqYm8Dr+vH2dBeFG/Co3YcpI050/ewEz3UVbDbaA2UWaOVzyobeu6vsudkf6FvxTuOcujlv51u7oL53ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724197525; c=relaxed/simple;
	bh=7ygrf7pk+qqh/taYw3aR0+XAuH6nI4qlY7LlbL2goN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsQz/bSMH8johjYnaMzJvPGYW4xpZ7p53Fc2vpVv13IO6RMjWckyov/t1oJ83rDmvZUySt0kFAEUuPh2PzegeDSlTWsPmcB4hcbFp7P+butr/oiN6uXoW4weGqv8gwxnUBqSgidy3Gli9cToSAdbgd+dha4terN+odLQ8Ft4uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X94LOzhv; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <026dc2a7-7f43-43a3-b138-3a4fedf41a5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724197521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOMk6nKdU/OadJM5Jw+DEbKFriLlwrQLkyoJvB74aPU=;
	b=X94LOzhvuUUoTZgkLED1+PiitTkGsST+HZTDpWuzpeOQsXTT6ZRaisAB7H3hrXL4qQoXWU
	DD8twRI/XnTQbiw2ooE5Fn/mO4A9pZwCxzsxqe+h4YHFHMsrI4SudfCt6PL+/1t6H6BEK1
	ltR4LozCn02uw5ZUxyOD+9Ug/Xdpe+Q=
Date: Tue, 20 Aug 2024 16:45:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] net/socket: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt()
To: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 bobule.chang@mediatek.com, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Yanghui Li <yanghui.li@mediatek.com>,
 Cheng-Jui Wang <cheng-jui.wang@mediatek.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240820092942.16654-1-Tze-nan.Wu@mediatek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240820092942.16654-1-Tze-nan.Wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/20/24 2:29 AM, Tze-nan Wu wrote:
> The return value from `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` can change
> between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`.
> 
> If `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` changes from "false" to
> "true" between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`, `BPF_CGROUP_RUN_PROG_GETSOCKOPT` will
> receive an -EFAULT from `__cgroup_bpf_run_filter_getsockopt(max_optlen=0)`
> due to `get_user()` was not reached in `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`.
> 
> Scenario shown as below:
> 
>             `process A`                      `process B`
>             -----------                      ------------
>    BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
>                                              enable CGROUP_GETSOCKOPT
>    BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)
> 
> To prevent this, invoke `cgroup_bpf_enabled()` only once and cache the
> result in a newly added local variable `enabled`.
> Both `BPF_CGROUP_*` macros in `do_sock_getsockopt` will then check their
> condition using the same `enabled` variable as the condition variable,
> instead of using the return values from `cgroup_bpf_enabled` called by
> themselves as the condition variable(which could yield different results).
> This ensures that either both `BPF_CGROUP_*` macros pass the condition
> or neither does.
> 
> Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
> Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
> Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>

Please tag bpf in the subject and add a Fixes tag.

[cc: Stanislav]

pw-bot: cr


