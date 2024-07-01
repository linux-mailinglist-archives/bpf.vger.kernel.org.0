Return-Path: <bpf+bounces-33507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A9891E4FB
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42886281CB9
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1361316D4F2;
	Mon,  1 Jul 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UtbmvxYo"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FF1EB2A;
	Mon,  1 Jul 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850367; cv=none; b=SXJv64cRaq9gmWYoas+7zdulyrsbFqy6/SkuvLUSX5QptTYzyjtwzNw4Y9HnGd3ASRWvMTLaelp0viLV2AfMWSD7CJGIgQJNR43ATOILfjbNC1X7Hb1M2WbvhYjk9apHh7UyN7apovhRRiS9gZKvyFAf/ofW2ViH1few/c389/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850367; c=relaxed/simple;
	bh=ZEiVj/tAvxFh9LGWCB+Yae8iScB6svgmnvBd6QXlO/Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fTf4Hsyz+nPYlJslLmZTzKo7k39tiskgBNUOScAteMeZ3r10235DpTFD/v+nY+whmKBQwE/a+dZfTiavlSRtJV3bUqlJxtwHHcS0aGBWkJU3GDwl69/PIDbJWuZM2GO7ouBKoIrudm8sjN1TZRRq7+LhuDXWu9mmbf00n+hnEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UtbmvxYo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aG2Ey7jvL4aM2MYaJc+dWiRsq9Q1mGDmKGglVh3DZ/M=; b=UtbmvxYo/tWt9oA+GAjyv4gXsJ
	R14zaX7NCHROVjqSJTE/bOO7o2MtqdTsuR7Tq+6CoVJ3w4wZJ1R+P15YPZoPBZIYBlfDoJsge5jBH
	Npwbqd1kJ6y5hYCYdhvl3dPPNyCNDKW3/MNgCzkYpQ3CEEfPwLPyjrvzMkwh2tdVY/73f1Btpgeox
	gsLeC/+vQoygWBWUpmFO3ZHp4yq8EPEo4yXx8CQ/mejT/kYgXnIu8SJC2rGPG5jDiu5csRj7HDJk+
	3X5cjkqeVFWGX0I73YMsU6JEBCcGSwXcbmLSh1Ffa/XN33lgirsV4M7MldRPaScH/rFlv74pLLYb6
	rCiZKW6Q==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sOJdr-000LNO-VJ; Mon, 01 Jul 2024 18:12:35 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sOJdq-000Cwd-1i;
	Mon, 01 Jul 2024 18:12:34 +0200
Subject: Re: [PATCH RESEND bpf-next v4 2/3] selftests/bpf: Factor out many
 args tests from tracing_struct
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
References: <20240622022129.3844473-1-pulehui@huaweicloud.com>
 <20240622022129.3844473-3-pulehui@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2bbced4a-1022-aace-52b4-e0abe426347b@iogearbox.net>
Date: Mon, 1 Jul 2024 18:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240622022129.3844473-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27323/Mon Jul  1 10:40:06 2024)

On 6/22/24 4:21 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Factor out many args tests from tracing_struct and rename some function
> names to make more sense.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
[...]
> diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
> new file mode 100644
> index 000000000000..8bd696dc81d9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2024. Huawei Technologies Co., Ltd */

Overall looks good and ready to land, one small request: lets drop the copyright
comment here since this commit is only moving the existing tests out to its own
file which have been added originally via 5e9cf77d81f9 ("selftests/bpf: add testcase
for TRACING with 6+ arguments").

Thanks,
Daniel

