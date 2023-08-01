Return-Path: <bpf+bounces-6632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C5C76C021
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 00:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97387281BEA
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1203D275BD;
	Tue,  1 Aug 2023 22:08:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2A275A8;
	Tue,  1 Aug 2023 22:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9F7C433C8;
	Tue,  1 Aug 2023 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927708;
	bh=Fprg9A7lqx6rZCFEElImiV0nfq2ndvAMquua7Y1GBYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VmtF1xVixlC/10SuowzThM4JnSZSyoXyeMnbPfptuZbeTUxYWK/VHQfsuEeEsuFzT
	 xN7SdwW3xB1/LvEe/Ysdla9MnFDqFltreJv0u4N1uWW/6ZD2CWTuHKYxnGdh3QjbPw
	 WgnfCbAve7ahVq3DLbGxj/JriRkOzYNv1uqba6jZwd9wF3Ko8PGRxRHWcoSBPZUdjL
	 k8B5SvYOj5cONSg2muK3wzWASNO1R1cC6RKPdy2XgVCupYwvfYtxEiz52Y83CFTfED
	 at7ot5/TcMBi26kaOhEUgAxt3OQiyksvAUfC5i2TouuUtZhyEkkIZCA2UMGn4kup3Y
	 HWr6qnmWazCWA==
Date: Tue, 1 Aug 2023 15:08:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com, shuah@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/2] bpf, xdp: Add tracepoint to xdp
 attaching failure
Message-ID: <20230801150826.6f617919@kernel.org>
In-Reply-To: <20230801142621.7925-2-hffilwlqm@gmail.com>
References: <20230801142621.7925-1-hffilwlqm@gmail.com>
	<20230801142621.7925-2-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Aug 2023 22:26:20 +0800 Leon Hwang wrote:
> When error happens in dev_xdp_attach(), it should have a way to tell
> users the error message like the netlink approach.
> 
> To avoid breaking uapi, adding a tracepoint in bpf_xdp_link_attach() is
> an appropriate way to notify users the error message.
> 
> Hence, bpf libraries are able to retrieve the error message by this
> tracepoint, and then report the error message to users.

Whatevered-by: Jakub Kicinski <kuba@kernel.org> ?

