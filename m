Return-Path: <bpf+bounces-19171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D7B8265D4
	for <lists+bpf@lfdr.de>; Sun,  7 Jan 2024 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC3F1C20C14
	for <lists+bpf@lfdr.de>; Sun,  7 Jan 2024 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FAE111AD;
	Sun,  7 Jan 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGOqaVcf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB611193;
	Sun,  7 Jan 2024 19:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBB5C433C7;
	Sun,  7 Jan 2024 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704656757;
	bh=gSlznq4olxK9A2WPNrVM+qYDTnJ+RwLQQfZhg3Yn9JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGOqaVcfB8y4bPFEmpUsH6Ufas2IOJtS0uLx7dlxgR7I8bjnIrvGtaB8NBw5I6Qu0
	 njYntRhX5tFwF/9JTcqKqnyd79ItroizueEnr7RYqYkG4e0zALs4n2K1yZxoNQwLP0
	 no/dvbMpcCUkTc9d9OKrH4k2rHKwfL2jWWUTL01b4aHL7X0xCy9GEaQ9OF7SKzzUJR
	 7gmE+dkcVB77fXffDS9K1m1/LKqiqr6Dtal7VuwRYZsxlTiC7p+9Sa4vXS1y60/1AG
	 D3RTwDV43+33ydEI4qKZTqcmRCtfQXWbdyt5RCQ9LxUQoMkz5+c3Ze9gnJMwrfARIA
	 J9rVWPAus5aEQ==
Date: Sun, 7 Jan 2024 19:45:51 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, patches@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next] net: filter: fix spelling mistakes
Message-ID: <20240107194551.GA132648@kernel.org>
References: <20240106065545.16855-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106065545.16855-1-rdunlap@infradead.org>

On Fri, Jan 05, 2024 at 10:55:45PM -0800, Randy Dunlap wrote:
> Fix spelling errors as reported by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
> base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> 
>  net/core/filter.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks Randy,

These changes look good to me.
And I now only see false positives flagged by codespell for filter.c.

Reviewed-by: Simon Horman <horms@kernel.org>


