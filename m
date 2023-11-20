Return-Path: <bpf+bounces-15416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BF67F1FCE
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A75528235E
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6A39840;
	Mon, 20 Nov 2023 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr8uLlw0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90C38FB6
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 21:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89452C433C8;
	Mon, 20 Nov 2023 21:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700517482;
	bh=Gt/9aEvNd7PeLB7ZuAGREL9Pn8AN9OJdMfZ06sQd5JU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hr8uLlw0436vK//W6exITKhCqiQyeCORSoKyIpauzA0y11+DDj4poEle6zB+ZsAUw
	 yXoYsCjCfxqujTZdkxng5xK0j1za9CRKUB679iJk6VgLF1045dithF56iEuMKTNH4s
	 hAeYk3EJLaKKe8NJ2+FNWKC5MSiTZ4ysHiMUHThA0vdzZQC6wxx6PzCHYTK7nMNoX0
	 WmFLR+sMerSFWbBcUXnNnW4NZUi6Tan/4XqGFllP9tln3QRj+YeWH16lCHEpQQ0wdF
	 u8XNx6WvnhJRpmZhCGBi+doPc0kpMzNc0wkyGeHMqngpMeMF7q+v1fbCLicJxmerkf
	 ZhyVhuX7HCJGA==
Date: Mon, 20 Nov 2023 13:58:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, Dipendra Khadka <kdipendra88@gmail.com>,
 syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next 1/2] netdevsim: don't accept device bound
 programs
Message-ID: <20231120135800.0abca396@kernel.org>
In-Reply-To: <20231114045453.1816995-2-sdf@google.com>
References: <20231114045453.1816995-1-sdf@google.com>
	<20231114045453.1816995-2-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 20:54:52 -0800 Stanislav Fomichev wrote:
> Commit 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> introduced device-bound programs by largely reusing existing
> offloading infrastructure. This changed the semantics of
> 'prog->aux->offload' a bit. Now, it's non-null for both
> offloaded and device-bound programs.
> 
> Instead of looking at 'prog->aux->offload' let's call
> bpf_prog_is_offloaded which should be true iff the program
> is offloaded and not merely device-bound.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

