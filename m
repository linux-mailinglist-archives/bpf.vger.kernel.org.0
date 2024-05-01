Return-Path: <bpf+bounces-28328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D508B8B26
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF121F22A1A
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F5F12E1D1;
	Wed,  1 May 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUlKzNyC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3E80BEC;
	Wed,  1 May 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570015; cv=none; b=Lq3yUq1WL7RA1l7Bzi0aX4bI+sQgiwQSyW/hgnj4FwRcJq5ikAzZFFUf7G0TlXtCzizUtDyZf+t22ba/Gx2LLNybb3SkT/+QTGMRiRc/xRWy0QowcuOio+F7xso187K7XOcasYxKE9LIPCahp9JGFBGygPFVjdi1Nejg84rXbPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570015; c=relaxed/simple;
	bh=fnbRykZBbCXxmETKh5yzbpToIkxW2eRTG33Vqk3lVuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swHzI9l+xFVhryUoS3eHsuUz/MASlbwN181Nn6Fds21GKnT4cYazcfyv0gVzyue8F20fKrV+wUycRRUvxKujUT3bTfo6q5ht+fq9hjleyOgA8rPK3QVR/90wRclJQ60fqobMMkH+gKkShz+pPwORZ8P4eHBkK1DhN7/RZv82vV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUlKzNyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4801C113CC;
	Wed,  1 May 2024 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714570015;
	bh=fnbRykZBbCXxmETKh5yzbpToIkxW2eRTG33Vqk3lVuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mUlKzNyCbRBlBY0nRtNxZ09lGrvKjK1seskIAN49XY+MLEDKLZobHzwO5GzJO41Rd
	 M5zbGL5gfZdqJlijhlNqEvmGRSf+7BMarDoPubokXvVQoEtqWZLQj8htjFNQeMWIWR
	 0CWiVY+yc0lFPhNCrVkItetFvHZWfNRZTmzrC/0SUEBpVaCizCscZrB9z+nE30V0f0
	 3BpzDSoShRIi5oUxShohZwatqwfLTW5NQUd4N3w08d8m4FPtt5dmuo6JSnmJINmcwq
	 pm5OxsGBxJ71DoTb/wVSmcAt/cZgjcu89JRdT4BzhS/k/wzeAxqjDejA1dnUEIrffr
	 X1Tx/gzPQKfaQ==
Date: Wed, 1 May 2024 06:26:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miao Xu <miaxu@meta.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin Lau <kafai@meta.com>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] Add new args for cong_control in
 tcp_congestion_ops
Message-ID: <20240501062653.09abec31@kernel.org>
In-Reply-To: <20240501074338.362361-1-miaxu@meta.com>
References: <20240501074338.362361-1-miaxu@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 00:43:36 -0700 Miao Xu wrote:
> This patch adds two new arguments for cong_control of struct
> tcp_congestion_ops:
>  - ack
>  - flag
> These two arguments are inherited from the caller tcp_cong_control in
> tcp_intput.c. One use case of them is to update cwnd and pacing rate
> inside cong_control based on the info they provide. For example, the
> flag can be used to decide if it is the right time to raise or reduce a
> sender's cwnd.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> --

three dashes here ---

> Changes in v2:
> * Split the v1 patch into 2 separate patches. In particular, spin out
> bpf_tcp_ca.c as a separate patch because it is bpf specific.
> 
> Signed-off-by: Miao Xu <miaxu@meta.com>

This goes after Eric's review tag.

Looks like you need to adjust one of the BPF selftests:

Error: #29/14 bpf_tcp_ca/tcp_ca_kfunc
  Error: #29/14 bpf_tcp_ca/tcp_ca_kfunc
  libbpf: extern (func ksym) 'bbr_main': func_proto [213] incompatible with vmlinux [48152]
  libbpf: failed to load object 'tcp_ca_kfunc'
  libbpf: failed to load BPF skeleton 'tcp_ca_kfunc': -22
  test_tcp_ca_kfunc:FAIL:tcp_ca_kfunc__open_and_load unexpected error: -22

