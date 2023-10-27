Return-Path: <bpf+bounces-13521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9307DA3A7
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 00:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A90C1C211C8
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 22:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4CE3FB02;
	Fri, 27 Oct 2023 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzrjaEBE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BC38DF5;
	Fri, 27 Oct 2023 22:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08947C433C8;
	Fri, 27 Oct 2023 22:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698446441;
	bh=2rCIRtKFM+3RMPf0ZVAQKOeUDSTXWIOHQEyehpzPDsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IzrjaEBEkG0Xr84XrZyxlM92yU5kvrfPjNlirqcNGfPwVB8TrAG9V8DgOvpXBR57R
	 UDRhz4p0tOe9MTFTUoRPkTnzuOnNWCDJtWj2+6RKOz1LLf9Pt0DDDv/q839q+9rBnd
	 eSTMvp7fDmb0SVCmVQwSfMU9w/PHq7sN0pt65bBHiK798Wf8ybEHMuUdwucNsxScV3
	 kjBX7BgZCqR6q88chkGsLqhFV73/SMLfy/i4HgufpkQISoCPJUPgKIBUVm7uqgkle4
	 zGMg7cpLZwmR1hNJNpMa8pGDVMdYanqAS/YLtfBoOlkU1LZhjLgoNx/ulLsaOekk5G
	 XQv6mPx1pfWUg==
Date: Fri, 27 Oct 2023 15:40:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, sharmaajay@microsoft.com, hawk@kernel.org,
 tglx@linutronix.de, shradhagupta@linux.microsoft.com,
 linux-kernel@vger.kernel.org, Konstantin Taranov <kotaranov@microsoft.com>
Subject: Re: [PATCH net-next] Use xdp_set_features_flag instead of direct
 assignment
Message-ID: <20231027154040.58e5b09d@kernel.org>
In-Reply-To: <1698430011-21562-1-git-send-email-haiyangz@microsoft.com>
References: <1698430011-21562-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 11:06:51 -0700 Haiyang Zhang wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch uses a helper function for assignment of xdp_features.
> This change simplifies backports.

Generally making backports is not a strong enough reason to change
upstream code, but using the helper seems like a good idea.

I touched up the white space and title when applying, thanks!
-- 
pw-bot: applied

