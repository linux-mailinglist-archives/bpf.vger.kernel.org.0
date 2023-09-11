Return-Path: <bpf+bounces-9695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08379C13E
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 02:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7081C20ACD
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 00:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035641843;
	Tue, 12 Sep 2023 00:43:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04217EA
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:43:18 +0000 (UTC)
Received: from out-221.mta0.migadu.com (out-221.mta0.migadu.com [IPv6:2001:41d0:1004:224b::dd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA210D8
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:29:38 -0700 (PDT)
Message-ID: <6c275fdc-4468-7573-a33c-35fc442c61c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694470312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WZ2X8irrYsMGdmTvsQZf0PGkIQMT/5DkX5HnLljfQ8=;
	b=ksuZ7e4VDPtO/M0sq4SoEmPgUxuphDQdLi3vp7XB2pwWn78JCtUG/NIfu6+L/J3nD9pVGW
	GBsCTpeSBNFNq5Ew8ZcuJHRDdlNOfC/RatIsxSOwNln3ftALuKg12iJHT8iz7XTC0ZucRT
	HMGllfDSiSYv7jm8WTUQTP7ptsnWL/0=
Date: Mon, 11 Sep 2023 15:11:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: expose information about supported xdp
 metadata kfunc
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
References: <20230908225807.1780455-1-sdf@google.com>
 <20230908225807.1780455-3-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230908225807.1780455-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/23 3:58 PM, Stanislav Fomichev wrote:
> @@ -12,15 +13,24 @@ static int
>   netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
>   		   const struct genl_info *info)
>   {
> +	u64 xdp_rx_meta = 0;
>   	void *hdr;
>   
>   	hdr = genlmsg_iput(rsp, info);
>   	if (!hdr)
>   		return -EMSGSIZE;
>   
> +#define XDP_METADATA_KFUNC(_, flag, __, xmo) \
> +	if (netdev->xdp_metadata_ops->xmo) \

A NULL check is needed for netdev->xdp_metadata_ops.

> +		xdp_rx_meta |= flag;
> +XDP_METADATA_KFUNC_xxx
> +#undef XDP_METADATA_KFUNC
> +


