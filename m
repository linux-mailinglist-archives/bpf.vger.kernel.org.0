Return-Path: <bpf+bounces-12630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F408F7CECB6
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA01C20C5A
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B3385;
	Thu, 19 Oct 2023 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi1nzjBs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6317E;
	Thu, 19 Oct 2023 00:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7E5C433C7;
	Thu, 19 Oct 2023 00:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697674845;
	bh=6mkAdLVLxxj7Xv3eDlTxWghk2v1vUqjiipEg5azs62c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oi1nzjBsLq/buGnHUgogCnUHbtfYpxvg1o0LSse9LWwgv13hdLFVVu9aGGox2h4XW
	 YNly5QO5nO3SivjfcEJ/VTeY/Ma/dodZxNG7w7knPmc0rdSUSCCmRrLKLxRnFiTVtD
	 UIhe0o4KuM+2GtuNE5vtZX7/O0V35JLAEuYXyit0N2byQIDWYiCwH+9jOTv9Oluddr
	 8OpbNuvxLYXVx3Fiq+DHt6IEehmRu7sjZqX3o46MWrGbjvoGkssKp68P+cgo0VY8Q5
	 KwE8LFj0hXTRMkWDxO82S7abZbu4PS7hdxoZ+QcjVTByhhobpMY9B+PomZKoc9Qzgp
	 2VWb41EQeOC8w==
Date: Wed, 18 Oct 2023 17:20:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com, martin.lau@linux.dev,
 krisman@suse.de, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 io-uring@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, Alexander
 Mikhalitsyn <alexander@mihalicyn.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v7 04/11] net/socket: Break down __sys_getsockopt
Message-ID: <20231018172044.008dab81@kernel.org>
In-Reply-To: <20231016134750.1381153-5-leitao@debian.org>
References: <20231016134750.1381153-1-leitao@debian.org>
	<20231016134750.1381153-5-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 06:47:42 -0700 Breno Leitao wrote:
> Split __sys_getsockopt() into two functions by removing the core
> logic into a sub-function (do_sock_getsockopt()). This will avoid
> code duplication when doing the same operation in other callers, for
> instance.
> 
> do_sock_getsockopt() will be called by io_uring getsockopt() command
> operation in the following patch.
> 
> The same was done for the setsockopt pair.

Acked-by: Jakub Kicinski <kuba@kernel.org>

