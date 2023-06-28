Return-Path: <bpf+bounces-3608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F674072E
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A95281143
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 00:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38140110B;
	Wed, 28 Jun 2023 00:24:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F07EA;
	Wed, 28 Jun 2023 00:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8F1C433C8;
	Wed, 28 Jun 2023 00:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687911888;
	bh=kNj6AorbsM1YciTdwmI1fpkirwD9mi885PoKVJqM0Q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TcVAY72nXw9KX8BaBPGUEd9Y5wOnDqWkYWeXfrAgMNUdudOg8boIKjWTAj+hjb53j
	 cuATadt7B9u7VCjz1zU1cCYYZnFQ6nRoLe9+2B9ThAZh6IuWrH39wFEIZEzHXNEQEJ
	 ow2wbu6eySWIq+I1z6FZQTCzZMErq3zddWjhhO+sqVr+jFknMY+j3aNHF3zMHWOvXJ
	 /tXH85OvvMCePnIxfmqgWeuP3tlYBV9+xgKfZnk8BpzF6J3fuRykOSX393zGEmijxc
	 2Bt9BJFc+tXcV+4VUwZrlYQ9/s+jccstDTGWcicj+I/IRd2zkp7gkUm0Q8jb0pw5bt
	 IacrvXegkM4HQ==
Date: Tue, 27 Jun 2023 17:24:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.5
Message-ID: <20230627172446.5d42f023@kernel.org>
In-Reply-To: <20230627115925.4e55f199@kernel.org>
References: <20230627184830.1205815-1-kuba@kernel.org>
	<20230627115925.4e55f199@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 11:59:25 -0700 Jakub Kicinski wrote:
> On Tue, 27 Jun 2023 11:48:30 -0700 Jakub Kicinski wrote:
> > WiFi 7 and sendpage changes are the biggest pieces of work for
> > this release. The latter will definitely require fixes but
> > I think that we got it to a reasonable point.  
> 
> I forgot to mention a conflict, there's a trivial one because of
> adjacent changes in fs/splice.c. Stephen has the resolution:
> https://lore.kernel.org/all/20230613125939.595e50b8@canb.auug.org.au/

Another one will surface once you pull asm-generic from Arnd:
https://lore.kernel.org/all/20230609104037.56648990@canb.auug.org.au/

