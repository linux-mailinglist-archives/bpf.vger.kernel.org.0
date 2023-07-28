Return-Path: <bpf+bounces-6272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221DA767854
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF59228275C
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 22:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9D21FB3E;
	Fri, 28 Jul 2023 22:02:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2AF23B8
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 22:02:40 +0000 (UTC)
Received: from out-113.mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C02D7D
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 15:02:31 -0700 (PDT)
Message-ID: <266ab56e-ae83-7ddc-618e-3af228df81bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690581747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hWvaYfIn7U7DdQhxoUICMLRNRgSRaJIOm4Ba5/IrXM=;
	b=WdVTItCTD9ygpob4ihOR+/GOrZVv2IJlkxrw21VRkyQgnRjcam5YMd5HHNBToM2Fj52wGy
	d63P3UDnhS7hVxUvDfwgGmkgLcg78W1sDnP8lyY4VTL8ADsM6fRrb8FOnFs2aa7Gu7ZlEn
	qwjI3sZklIivyKGi+AVTXfYJpoIZiJs=
Date: Fri, 28 Jul 2023 15:02:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Content-Language: en-US
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>,
 Markus Elfring <Markus.Elfring@web.de>, Jakub Sitnicki <jakub@cloudflare.com>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/25/23 6:08 PM, Yan Zhai wrote:
> skb_do_redirect returns various of values: error code (negative),
> 0 (success), and some positive status code, e.g. NET_XMIT_CN,
> NET_RX_DROP. Commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel
> infrastructure") didn't check the return code correctly, so positive
> values are propagated back along call chain:
> 
>    ip_finish_output2
>      -> bpf_xmit
>        -> run_lwt_bpf
>          -> skb_do_redirect

 From looking at skb_do_redirect, the skb_do_redirect should have consumed the 
skb except for the -EAGAIN return value. afaik, -EAGAIN could only happen by 
using the bpf_redirect_peer helper. lwt does not have the bpf_redirect_peer 
helper available, so there is no -EAGAIN case in lwt. iow, skb_do_redirect 
should have always consumed the skb in lwt. or did I miss something?

If that is the case, it feels like the fix should be in run_lwt_bpf() and the 
"if (ret == 0)" test in run_lwt_bpf() is unnecessary?

			ret = skb_do_redirect(skb);
			if (ret == 0)
				ret = BPF_REDIRECT;





> 
> Inside ip_finish_output2, redirected skb will continue to neighbor
> subsystem as if LWTUNNEL_XMIT_CONTINUE is returned, despite that this
> skb could have been freed. The bug can trigger use-after-free warning
> and crashes kernel afterwards:
> 
> https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48


