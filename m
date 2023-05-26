Return-Path: <bpf+bounces-1335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52209712CE3
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 20:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3442817B7
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 18:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C78328C3E;
	Fri, 26 May 2023 18:54:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E728C07
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 18:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6055DC433D2;
	Fri, 26 May 2023 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1685127261;
	bh=Urg86fkvb89N1W4EU22LaP2G2rEesdWCWKmXrLhixPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+nYEZTgiX0csmwuA4GsCM/V/trUTp+2wIJY1+q0YXr3lfeWIc0JQ8XaLhi81frAG
	 u5uFSqDQBRakCBxnbiR7o/6J2w7YB5QmbfVH0JJuATcydi0/Flu1+0Cw/T1dtCz6Mr
	 OHf5lqgpAN9lXal0ddy1I44pvXiYtrIseirqKkY8=
Date: Fri, 26 May 2023 19:54:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Andrii Nakryiko <andrii@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?iso-8859-1?Q?Mah=E9?= Tardy <mahe.tardy@isovalent.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH stable 5.4 0/8] bpf: Fix
 bpf_probe_read/bpf_probe_read_str helpers
Message-ID: <2023052646-magnetize-equate-2b24@gregkh>
References: <20230522203352.738576-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522203352.738576-1-jolsa@kernel.org>

On Mon, May 22, 2023 at 10:33:44PM +0200, Jiri Olsa wrote:
> hi,
> we see broken access to user space with bpf_probe_read/bpf_probe_read_str
> helpers on arm64 with 5.4 kernel. The problem is that both helpers try to
> read user memory by calling probe_kernel_read, which seems to work on x86
> but fails on arm64.

Has this ever worked on arm64 for the 5.4 kernel tree?  If not, it's not
really a regression, and so, why not use a newer kernel that has this
new feature added to it there?

In other words, what requires you to use the 5.4.y tree and requires
feature parity across architectures?

thanks,

greg k-h

