Return-Path: <bpf+bounces-13390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E687D8E0C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 07:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5154C282301
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 05:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13785CBC;
	Fri, 27 Oct 2023 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPftb1WH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106665CBA;
	Fri, 27 Oct 2023 05:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BD1C433C7;
	Fri, 27 Oct 2023 05:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698383965;
	bh=XQx6S1LPtKxuoAI+VdCVsEjkr21diumw1bhdxB3RXdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KPftb1WHEgvkFr6xtOyAA3gn3wcaUIVDRTRHMR+Cib3pPXzXEWxbuC1OsqP6nzTQ+
	 m7BRZ87KIr8OLV/PKqBe5lIyUv4CMm7xInK6rRtoj9SN+T5dnndI4UZo2wfZ3aLOyZ
	 0sTwqYnVzm/RwN/ol5hj7lckZ3qmnhzarv9kcx7NrW1vj1+07yyDM8acDW9qSMeWX/
	 o9xUdaiKTgpNJp+xlVjEVfws3HrdlqLhZAdkI77aX6GaeUhp6SmGqrIgxzLeaJhA7i
	 a1YTep3ZcTUqBDVUM8Gv8SwNP4S8/EmWXUzBHaGwMqJ/TaPnmYsL0aZFrqU6s5SLq/
	 JY8cgzwJqz2FA==
Date: Thu, 26 Oct 2023 22:19:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2023-10-26
Message-ID: <20231026221924.2f02f9ad@kernel.org>
In-Reply-To: <20231026150509.2824-1-daniel@iogearbox.net>
References: <20231026150509.2824-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 17:05:09 +0200 Daniel Borkmann wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 51 non-merge commits during the last 10 day(s) which contain
> a total of 75 files changed, 5037 insertions(+), 200 deletions(-).

Pulled, thanks!

