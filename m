Return-Path: <bpf+bounces-17408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C177C80CEC8
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20E01C212B1
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC6495FF;
	Mon, 11 Dec 2023 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J/AmX1cc"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192CD8E
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 06:58:15 -0800 (PST)
Message-ID: <0415f445-4dff-4b64-bd87-f4de08b94bb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702306693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Fjr+jZvGir5p2a8zjnDAuuC+t//ch3MQUuMLRI2udE=;
	b=J/AmX1ccTFypQqU1yusbK26xcmFLBCP226ycSXfq5WNscx0/gYqJ6N4aCVbVaQfCKUrrus
	QJbQMrsHTQ+R0a1pfEHYXt6WcwjV3ACoS4IX5t6E42r/XjuHUU+wVhk2IrCQCARHnIFlMh
	JZ9aimP6CdNqyeWGsGTSeXN2heT9ZAQ=
Date: Mon, 11 Dec 2023 06:58:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Update the comments in
 maybe_wait_bpf_programs()
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231211083447.1921178-1-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231211083447.1921178-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/11/23 12:34 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Since commit 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in
> sleepable programs"), sleepable BPF program can also use map-in-map, but
> maybe_wait_bpf_programs() doesn't handle it accordingly. The main reason
> is that using synchronize_rcu_tasks_trace() to wait for the completions
> of these sleepable BPF programs may incur a very long delay and
> userspace may think it is hung, so the wait for sleepable BPF programs
> is skipped. Update the comments in maybe_wait_bpf_programs() to reflect
> the reason.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>



