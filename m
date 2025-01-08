Return-Path: <bpf+bounces-48277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881EAA0640B
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3822C1888D65
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB3200BB2;
	Wed,  8 Jan 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPj+URUA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6391F37C1;
	Wed,  8 Jan 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360005; cv=none; b=gsk1uUCtHfFU0vTd8SNcvKQqkpzUL2s6fmJuIGbtOjdMLXiCAbv9Ue+tjhNxI1nZojiTbw6LNboYiGD3LsApo5rn8WihVz7O5d+CHi6HcRqjn+14hmWf9Q3Ayq/P/zkamgGPHh1V1YcvKMVWbB0y0IDnmTn9ce8PshfUQpd7V28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360005; c=relaxed/simple;
	bh=wP+gH3iVYQ17SDF3cVLizZkj9Krjt6YOA+2/nO1tOFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDohEjd2+eDgiKzfcACG4Y7H/WNdypcT1hb/SVzVp51dN6Ww+HnNiv5axheqCaiF6c9TSRdIpcg143BtYxB4DlaKnzrOvEyyQ9/bR+AcbjOCC3aHdkUmJk7C7+nC5jyNCyeJW8bm7rumH4dFR0qSamcnOHR3ZfqpeFiRrF+ywMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPj+URUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC313C4CED3;
	Wed,  8 Jan 2025 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736360005;
	bh=wP+gH3iVYQ17SDF3cVLizZkj9Krjt6YOA+2/nO1tOFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MPj+URUAM0Dahrbgo+/P311etT7s2gTQBeOougUFOJb4X7zH5+FdEAcApm0qe+uhQ
	 TaQ86fTqoTYiCOFtXXBfDzrhG7JVvdjAwqmSFhfyeSZZkxOCWQQ5ZBZzpOcrXnnGjl
	 Pdt7Y4qLq6Ei8wiELnsSRSnO7v0HDTM5F21JnE4ihLU9vhWpnZoUhf53ZI06PewhcH
	 EPnRJC1icbM7ksI7TIiLEDkI7O9s0vf5WXoj4H3E7kb8W9UIzl8JG+4b7I37ec1YCg
	 lMiTlbzOXXQBBBhhpIZd/h50aIWGyGeK2fp90NuvUw1kx63V+AIEh+IN9Netz1BWzr
	 rVu9a3Knt0mqQ==
Date: Wed, 8 Jan 2025 10:13:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Cc: netdev@vger.kernel.org, ronak.doshi@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, u9012063@gmail.com, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, alexandr.lobakin@intel.com,
 alexanderduyck@fb.com, bpf@vger.kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [PATCH net] vmxnet3: Fix tx queue race condition with XDP
Message-ID: <20250108101324.712b4457@kernel.org>
In-Reply-To: <20250108034818.46634-1-sankararaman.jayaraman@broadcom.com>
References: <20250108034818.46634-1-sankararaman.jayaraman@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jan 2025 09:18:18 +0530 Sankararaman Jayaraman wrote:
> If you received this e-mail in error, please return the e-mail to the
> sender, delete it from your computer, and destroy any printed copy of
> it.

We don't interact with patches which came in with the legal footer bs.
It's definitely possible to get rid of it within Broadcom, talk to
other people who work upstream..
-- 
pw-bot: cr

