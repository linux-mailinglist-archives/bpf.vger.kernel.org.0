Return-Path: <bpf+bounces-18242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AE0817DFA
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 00:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600671C21935
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 23:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D8760B1;
	Mon, 18 Dec 2023 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2cOYxYI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986454C3B2;
	Mon, 18 Dec 2023 23:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E4EC433C7;
	Mon, 18 Dec 2023 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702941427;
	bh=9NPpjjGdr4FE4YAQV7We+AqNV5E8KFdD9TC+YKaSMKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D2cOYxYI0Uml5DbWzJUXd9jVYt/t2IKdKso8LEzlLzZMiuLlLbf44z9Nh2TTZpCHv
	 bvLaDGnfAsBuExWqTFTTXQ20QaP+SakFMmIOSZ1IkYo6ahCBWIKIOkt5Pya0ywtk3C
	 6MdOw2Vp9RlKGHR47pdTLlCdAMl18AEMRR9b72Qv+sd5a8dQeMKi4eS7uPHnhNfJ0O
	 N5iRoZ2goQPyWIdPJLX346liF4Ykf9mhHe4nrTTpNttz7wVktYvIRJy9Ow1dVWyOXW
	 v4PIgRnzoebcyokOHEber5wV40H5saplrV4/jY3I3jpPGS4qcw1CAW5DkXgw6F+p63
	 7MTUqm2RLjvIQ==
Date: Mon, 18 Dec 2023 15:17:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+f43a23b6e622797c7a28@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 keescook@chromium.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in
 nla_find
Message-ID: <20231218151705.7861913d@kernel.org>
In-Reply-To: <000000000000cdad2b060cc9c542@google.com>
References: <000000000000cdad2b060cc9c542@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 06:43:26 -0800 syzbot wrote:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc4/0x620 mm/kasan/report.c:475
>  kasan_report+0xda/0x110 mm/kasan/report.c:588
>  nla_ok include/net/netlink.h:1230 [inline]
>  nla_find+0x120/0x130 lib/nlattr.c:746
>  nla_find_nested include/net/netlink.h:1260 [inline]
>  ____bpf_skb_get_nlattr_nest net/core/filter.c:209 [inline]

This needs nla_ok() instead of playing with nla_len directly.
Will send a fix soon..

