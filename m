Return-Path: <bpf+bounces-54697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF139A70674
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D37166B83
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8EA25BADA;
	Tue, 25 Mar 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtUQMttc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43E255E20;
	Tue, 25 Mar 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919228; cv=none; b=KZoQBHEk1372QUGAcFACwIyYZV5oMZHHyxE941vdJRyimHrcuYZRMnklmp3c1Y0884OIprfrF3Zzc+2Q8JafMQqbIGgEsOr+DNAAxhkQ70z1vpjOr5wWGs9Cy4wBAfeWMKo8gaVAnyvt+kuzLm3Kj4B+P8fmCjkux4F8dAmcrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919228; c=relaxed/simple;
	bh=o5iqLNYHvWWuh4+BP/whWUchWJw/jZnSjKIg78yGgxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNF4YWkJtX7YxqTIkoXjkpg3ME/7cx5hZ9q3HpTY1H1etUDGaMZJGnxaaC0ueRKx33wU5NQh880nYIyIQSYMq/ypj3w7U/kxBFuK3CpUxcu2R+r0mjx5a547nOGCtTEYf8NxNrII7yJHBqj7QkXo3etlhg7I5Je5giNcR4WyCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtUQMttc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DF7C4CEEA;
	Tue, 25 Mar 2025 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919228;
	bh=o5iqLNYHvWWuh4+BP/whWUchWJw/jZnSjKIg78yGgxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GtUQMttceRLoiK2pJwHCsiI50LMlR1+GN74eCrv2d/6gppnHAOFgvWuqWCPZ5hP0f
	 lcwSpzatYgn3WKwxjcwuR8T8EVWiOM6TNGzG9sB3FprVFTQCfWNVKmfRg6bsvVuIDx
	 q/qS+w/zAgrX7xgvrVvfxCd35LDOJVaa+86Yh4Lbj3Qx22rel36fYbZi2+FHvk3CLb
	 jOpiUzUG9uQpM8k6Ni2r+qeiMx0Im4aTXYekEpJpf3SZvnghy2HToSsQGRprTfvtTI
	 tiOAxCXtkx5dGpGVNhgUc2DIHA8Ul5zDasnJ4itO0wej6IpJoOl7Cq7r0MwMUJKa/w
	 +cK4K3yYIty4Q==
Date: Tue, 25 Mar 2025 09:13:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: mana: Switch to page pool for jumbo frames
Message-ID: <20250325091335.6833ed27@kernel.org>
In-Reply-To: <1742605475-26937-1-git-send-email-haiyangz@microsoft.com>
References: <1742605475-26937-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 18:04:35 -0700 Haiyang Zhang wrote:
> Since commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
> page_frag_alloc_align()"), the netdev_alloc_frag() no longer works for
> fragsz > PAGE_SIZE. And, this behavior is by design.

This is inaccurate, AFAIU. The user of frag allocator with fragsz >
PAGE_SIZE has _always_ been incorrect. It's just that it fails in
a more obvious way now? Please correct the commit message.
-- 
pw-bot: cr

