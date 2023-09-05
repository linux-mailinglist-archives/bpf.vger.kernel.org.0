Return-Path: <bpf+bounces-9300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F479321F
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 00:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBF01C2095D
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 22:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71791101E3;
	Tue,  5 Sep 2023 22:49:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3688DDD7;
	Tue,  5 Sep 2023 22:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC5FC433C7;
	Tue,  5 Sep 2023 22:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693954192;
	bh=rXRSGShzmvnqZZ2Us9gU41YxRXaVN1aed92JhI/FfjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XnSjkZ0sIIrm0rfhStmWwCL+27qYJ0IORFJAx1aCgF+TED5iZRwoewOQFFgEM4qV3
	 kGACvUWhZe9XwEHab/QGYd9m+qiObgGJw9uvPSKxV3qzS78jAbeANSAAyoY+BlFc3d
	 ntfQLd/mT3KgLCRYAdpG0mb2oLzhNgjQe8qgs9nVNXUE4DExGIXMZZv3WUyc1wLL99
	 l8bSzu7zzIknHBwS6yLcO6wq+56Ty0/7AD+za95Zw4+UMwRIyeBTG3tM96tYfcBJcu
	 JeeHDFMlDCkb4ghiFmSDsUPr/nA498fc4vAPBzOt4rdXQJQfQBBXy6xJboCsBB1ttQ
	 B3n5aIwNrF14Q==
Date: Tue, 5 Sep 2023 15:49:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, martin.lau@linux.dev, krisman@suse.de,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 io-uring@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v4 00/10] io_uring: Initial support for {s,g}etsockopt
 commands
Message-ID: <20230905154951.0d0d3962@kernel.org>
In-Reply-To: <20230904162504.1356068-1-leitao@debian.org>
References: <20230904162504.1356068-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Sep 2023 09:24:53 -0700 Breno Leitao wrote:
> Patches 1-2: Modify the BPF hooks to support sockptr_t, so, these functions
> become flexible enough to accept user or kernel pointers for optval/optlen.

Have you seen:

https://lore.kernel.org/all/CAHk-=wgGV61xrG=gO0=dXH64o2TDWWrXn1mx-CX885JZ7h84Og@mail.gmail.com/

? I wasn't aware that Linus felt this way, now I wonder if having
sockptr_t spread will raise any red flags as this code flows back
to him.

