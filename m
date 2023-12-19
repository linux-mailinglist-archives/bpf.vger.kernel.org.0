Return-Path: <bpf+bounces-18249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F274817F15
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB9B23EE5
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 00:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57F715AC;
	Tue, 19 Dec 2023 00:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1gxcjfj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBC620;
	Tue, 19 Dec 2023 00:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFF8C433C7;
	Tue, 19 Dec 2023 00:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702947314;
	bh=NwQ+utlQPPxCR9JaKOeCMutWi6lSD/GOgjgSWIvzDQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p1gxcjfjtwzK9Hh6DSguCSby7dl4DrM+pCrqGjPsl3Ldm5p4PYscizFapKeFu+8mr
	 bQRM9Es9Fu5ttuI4O9X/WPoQLWp0BhX/T1OePcGv+ecqwVVtPyVXV8GtgghAmkyFSf
	 QWNQ9Edd/VYNXxxIvDQLSRvhXZql1xPAqYKIMekd3+VdnhDATXvsdL8dVoadz3UCGw
	 58udqY6fRr/4oy/9Yivx8so3Bm8ekKON+GcO+kZ0X/mzr0ajnhYBVw6a1T5D36SlGF
	 h1P1E0APS6iNPAkSVyi5EHVQFv2cBRVwVXrOo8rPOHf68s6VUmXCgoSSTZ9zaPbvaH
	 QAG0OQWlxoeug==
Date: Mon, 18 Dec 2023 16:55:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linuxfoundation.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, daniel@iogearbox.net,
 andrii@kernel.org, peterz@infradead.org, brauner@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
 linux-kernel@vger.kernel.org
Subject: Re: pull-request: bpf-next 2023-12-18
Message-ID: <20231218165513.24717ec1@kernel.org>
In-Reply-To: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 16:05:20 -0800 Alexei Starovoitov wrote:
> 2) Introduce BPF token object, from Andrii Nakryiko.
> It adds an ability to delegate a subset of BPF features from privileged daemon
> (e.g., systemd) through special mount options for userns-bound BPF FS to a
> trusted unprivileged application. The design accommodates suggestions from
> Christian Brauner and Paul Moore.
> Example:
> $ sudo mkdir -p /sys/fs/bpf/token
> $ sudo mount -t bpf bpffs /sys/fs/bpf/token \
>              -o delegate_cmds=prog_load:MAP_CREATE \
>              -o delegate_progs=kprobe \
>              -o delegate_attachs=xdp

LGTM, but what do I know about file systems.. Adding LKML to the CC
list, if anyone has any late comments on the BPF token come forward
now, petty please?

