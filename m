Return-Path: <bpf+bounces-19393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E082B8EC
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF041F23A55
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 01:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D62A54;
	Fri, 12 Jan 2024 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDOX8QON"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13A62D;
	Fri, 12 Jan 2024 01:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB30AC433F1;
	Fri, 12 Jan 2024 01:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705021550;
	bh=uNw1UHuVNM99dXe/lhGb6iYX4yQ/3sZrmvho6L1PjbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDOX8QON96ykmRxojlRyh6gZdvFFI8YMWjSWG/ztOdH/fnb4XG7uHy4ZgP4ZT0sli
	 Ocz1+xe8AbtV6Bg5m27xs+Zfi9V1XMk/1WV69zZ1M1NfKFm8IYBWsmi7k5/i9is0ua
	 S/VYNWrCRVn1FxVzgzAdxP0ptki5EfHZAbQU9TNk2WK2AWCM0MMFenFFvS2P6X8Ktm
	 ZX1DMl6s7REjtFrvoIVerN/wf2XLmcdqi6OmzltVWbw98/SbysBPNYKW3RWV/YUVVP
	 GorDm9rPjFIodXuopL4klE/yAyZ1Dg8FoRxznuilrbTzYSDUJpIfJ8A1VoAqmd01C4
	 ndo+wxOjJ/aBQ==
Date: Thu, 11 Jan 2024 17:05:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, eadavis@qq.com, bpf@vger.kernel.org,
 borisp@nvidia.com
Subject: Re: [PATCH net 2/2] net: tls, add test to capture error on large
 splice
Message-ID: <20240111170548.59d248f6@kernel.org>
In-Reply-To: <20240110220124.452746-3-john.fastabend@gmail.com>
References: <20240110220124.452746-1-john.fastabend@gmail.com>
	<20240110220124.452746-3-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 14:01:24 -0800 John Fastabend wrote:
> +		EXPECT_EQ(splice(p[0], NULL, self->fd, NULL, send_pipe, 0xe), 1);

Any reason to use 0xe rather than the SPLICE_F_* defines for flags?

