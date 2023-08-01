Return-Path: <bpf+bounces-6513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F276A720
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 04:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B511C20E2C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3161375;
	Tue,  1 Aug 2023 02:43:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE87E;
	Tue,  1 Aug 2023 02:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9319AC433C8;
	Tue,  1 Aug 2023 02:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690857818;
	bh=n4dsEw0hO1hhcpvbUzRfjMJlHkCbxkrsloRNUT6H/t4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=akFDDuctuT3hHiEMB/+rQBPuCORBi0BotJ2zv0hr8+Wuk4y98aTP6CmXMw6z7tc8v
	 EL423fcpqi+iEBQYH7tcO8+SIRVpRo2F+x2CsiEQDr2AnrnBEbzBqkiq/IH4MqOrkQ
	 17mCW9HJ70Mwb+iISagAUZix/g5dHrWRvX/XuRkUOrhstxgByzP5dnkbHVBByl5L1R
	 CsPlzcwctPldJb77u/+Cs4VNzfoTovj+QB8JJOKxmmhnNePn83SFgoiv6UzPIcMun4
	 3b4YyJoT8mG8OQ6xCNaVS0iGqWPhvOWyFQRjgGGsgTLZkzSm05xdpXa+4+/tAhmY6m
	 gFrcg2qMBADWg==
Date: Mon, 31 Jul 2023 19:43:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com, shuah@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf, xdp: Add tracepoint to xdp
 attaching failure
Message-ID: <20230731194336.5b4bd065@kernel.org>
In-Reply-To: <20230730114951.74067-2-hffilwlqm@gmail.com>
References: <20230730114951.74067-1-hffilwlqm@gmail.com>
	<20230730114951.74067-2-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jul 2023 19:49:50 +0800 Leon Hwang wrote:
> @@ -9472,6 +9473,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  	struct bpf_link_primer link_primer;
>  	struct bpf_xdp_link *link;
>  	struct net_device *dev;
> +	struct netlink_ext_ack extack;

This is not initialized. Also, while fixing that, move it up 
to maintain the line order by decreasing line length.

>  	int err, fd;
>  
>  	rtnl_lock();
> @@ -9497,12 +9499,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  		goto unlock;
>  	}
>  
> -	err = dev_xdp_attach_link(dev, NULL, link);
> +	err = dev_xdp_attach_link(dev, &extack, link);
>  	rtnl_unlock();
>  
>  	if (err) {
>  		link->dev = NULL;
>  		bpf_link_cleanup(&link_primer);
> +		trace_bpf_xdp_link_attach_failed(extack._msg);

