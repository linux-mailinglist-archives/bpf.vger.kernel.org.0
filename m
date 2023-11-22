Return-Path: <bpf+bounces-15628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAA87F3D4D
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 06:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA4B21709
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 05:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A111C9F;
	Wed, 22 Nov 2023 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1pw6u3H"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF638D6C
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 21:28:47 -0800 (PST)
Message-ID: <4f832b6f-97b1-45b1-a210-b497ee6e55d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700630925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hD50C65SyRlfrZivQBcgQbDNXXMp17iahMqbitu/UDs=;
	b=t1pw6u3HRRqNnLREfeSsRTYPDZzQ0FK4D1UpJYO48npsJYtMWOxVYqwNHDl8A0Mt6wOayM
	qPUIMOhMBqYRN61DKxUeCsLmVNccHvZYXn3a/52mT7Hl6CtgpmCi2tsRYCCT61J1N65pKC
	4UKp+utudAI/k0rhIwQda6mq0jqUZ6M=
Date: Tue, 21 Nov 2023 21:28:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] bpf: test_run: fix WARNING in format_decode
Content-Language: en-GB
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.lau@kernel.org, martin.lau@linux.dev, mhiramat@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
References: <0000000000004b6de5060ab1545b@google.com>
 <tencent_884D1773977426D9D3600371696883B6A405@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_884D1773977426D9D3600371696883B6A405@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/21/23 7:50 PM, Edward Adam Davis wrote:
> Confirm that skb->len is not 0 to ensure that skb length is valid.
>
> Fixes: 114039b34201 ("bpf: Move skb->len == 0 checks into __bpf_redirect")
> Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Stan, Could you take a look at this patch?


> ---
>   net/bpf/test_run.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index c9fdcc5cdce1..78258a822a5c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -845,6 +845,9 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
>   {
>   	struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
>   
> +	if (!skb->len)
> +		return -EINVAL;
> +
>   	if (!__skb)
>   		return 0;
>   

