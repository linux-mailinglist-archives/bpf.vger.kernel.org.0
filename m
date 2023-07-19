Return-Path: <bpf+bounces-5347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E438759C49
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7082819C3
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397CD1FB5C;
	Wed, 19 Jul 2023 17:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D21FB38;
	Wed, 19 Jul 2023 17:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADB5C433C8;
	Wed, 19 Jul 2023 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689787236;
	bh=ReZr05hGtYFAqQyuT2Yq3u5ZwenymCSJPjnkOpUwobQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lVWYh4TdGKcoScOHDzBbnK82DhTbhVrt2wy1GNt8edOtH2sKspWSCcrNQfIofEJfr
	 K22HZYWM6/8PZsPGRPqyrWUEoL7btdwWeTOjn9ge5P6i8RpCtgif1/OdZckFGAGHWr
	 Wvaq+OXwVmPgDgmtg/jV3v4djWVHprzT3AFP6YZmAp1pwVKOdjX5orjSrXStZHm6A2
	 1n0R7zCF/iBsyometbjj2c4ZcCwfJZUfEIfB4lzIQ4I0JrJUygUzbA4s3VaQhjItil
	 8CDdhK8u7bsxJFk0EHaIagVv9Sqb6G01/fqikhPM2OLHVLbFECRYy6uZYzlMkA3Q5R
	 Txto+pxF4it2A==
Date: Wed, 19 Jul 2023 10:20:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf, net: Introduce skb_pointer_if_linear().
Message-ID: <20230719102035.4710b202@kernel.org>
In-Reply-To: <20230718234021.43640-1-alexei.starovoitov@gmail.com>
References: <20230718234021.43640-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 16:40:21 -0700 Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Network drivers always call skb_header_pointer() with non-null buffer.
> Remove !buffer check to prevent accidental misuse of skb_header_pointer().
> Introduce skb_pointer_if_linear() instead.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

