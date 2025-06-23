Return-Path: <bpf+bounces-61325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F39AE5823
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 01:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AD47A8B52
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 23:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FF9230269;
	Mon, 23 Jun 2025 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKrk1ZmY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5E22B8D5;
	Mon, 23 Jun 2025 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722257; cv=none; b=dMZyeuzOAQ5LTOt+DVqEO4QQNAgrubWG5JaD4SUqaAdRELnT92AWhzDtuEFHgJ8b01IrCvJiNTqCcwHAMaF7o85RgvU0c9d+Gr3+m7UILmO3S1Ngahn7mYYH6EoflgXtJ10IVbC32kIKH/XGRzaVaWBI1DaRJCVnMqvx+1pMVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722257; c=relaxed/simple;
	bh=4alzvxQVK4jWWlPYV9BjKW2WFBd79+SJ/hF3XSWO/lk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuMjAC7vpHhKzRyDXoOCfyvXrJ5KL/tNTg1HQQGJ3lrUTlVJ9E4dnOwLRa9PEcRSHrqWotMAAoJniJ5GXplq/mINL3HQnMvKeQzF6DEnu3KcDsIZg1Ah0RAu3Q+DHNCz+S+P99xvbBCMevuEnzq137HJqFhpB98EFtN1g4S4RzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKrk1ZmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68EBC4CEEA;
	Mon, 23 Jun 2025 23:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750722257;
	bh=4alzvxQVK4jWWlPYV9BjKW2WFBd79+SJ/hF3XSWO/lk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JKrk1ZmYjY53AN1liXH1dnBijaDiG0HxRqWosVJySl9DkMR9iiDjsznjADcF/j0Rm
	 fx1jC/Uul032//mz3JjLTZopm3Lfg3kotuJO4zc6eu26SiQpCF2n+GCN1UfVFDYoHu
	 gAf+Ql97s+4YjVz8wnwGRMWbFJaX1yArGQ6QyRvv4fDX8Bjq+BpamvsTCgSTnVDlTc
	 rZqAyqYeVj0uBR+POQ9P9Xpc+z54NIzPf5oso6JgDLPSclfsq+xfkRDU3oUS+Fx5gv
	 hlD3yOKo24dGgm8hByNZ16Au7oCMO8LpzhQWsin8XS2hjd5I4Bln7dDDqReg4VsCTr
	 me8ZcrBWZxgiQ==
Date: Mon, 23 Jun 2025 16:44:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Brett Creeley <bcreeley@amd.com>
Cc: Simon Horman <horms@kernel.org>, Thomas Fourier
 <fourier.thomas@gmail.com>, Shannon Nelson <shannon.nelson@amd.com>, Brett
 Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Caleb Sander Mateos <csander@purestorage.com>,
 Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3] ethernet: ionic: Fix DMA mapping tests
Message-ID: <20250623164416.12f60d8a@kernel.org>
In-Reply-To: <8f54ae13-7943-4e45-9881-a01108a1b58f@amd.com>
References: <20250619094538.283723-2-fourier.thomas@gmail.com>
	<bb84f844-ac16-4a35-9abf-614bbf576551@amd.com>
	<20250620105114.GH194429@horms.kernel.org>
	<8f54ae13-7943-4e45-9881-a01108a1b58f@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 08:44:39 -0700 Brett Creeley wrote:
> I suspect you are right and this probably shouldn't be categorized as a 
> bug fix since the change only addresses a corner case that would happen 
> if the DMA mapping API(s) return 0 as a valid adddress, which wouldn't 
> cause a crash with/without this patch.

It's fine either way, so let me apply it and we can move on..

