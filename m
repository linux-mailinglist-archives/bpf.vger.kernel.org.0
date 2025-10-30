Return-Path: <bpf+bounces-72961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F8FC1E053
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 02:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454A24012C8
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1AA273816;
	Thu, 30 Oct 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hQJpEoua"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4541F270EC1;
	Thu, 30 Oct 2025 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787569; cv=none; b=YzWpl3Y+OjUMCdATNgWSRXvuvFzJxNS3dXy9m9rY6Q61qJOHKtdzuxEcG+TVAZmH3/nReJeK+DGSoGzLnY+TulJ61rqco8j2OVVmKB/Xx+jL8vaYjyP6bx1ytNHFQggwiea7vM7vamQHJYb56609wbFyS2bXwAIe2eZ2TMhE7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787569; c=relaxed/simple;
	bh=84kPkXhUTbe6LhLgk38kZ2juDmsQcTp5ZsiWx3+UrxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMZ4aaqo1+nSujzztwbXzBCFY5d5b75vto1dmarzKrC8ozfnkoQrTN4JCq4h0WDzXvfVUUS+lVk2fr6VpzxEoQcc5scMuruOuj06KKKBEtTqTxcdM/rHHAfG9W4JPOSoULngVXsi9a6tOJn5kckUpQ7kkDlGKXDB/8LAiilLKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hQJpEoua; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DE4GUUSn7PS/fQa45gakfgN1Qyd0uWMtlpLL22+fJDs=; b=hQJpEouaCKg43OLB9uIUt5Si6r
	LtknmQMFhhEP/mVrtGiYO1NoiHxI9p4Gf3BDkBxLfwv1ZTzvQvOycpYmpbSOsl/ChsST/5JMhAo8J
	tV7jZPw6dPB1NS0ERA8r1xP6FvxC0NqZbvFZxGuAyar/yoAK//vfwz1DjBB+myOwODjXVP2/JFk5N
	2sB5qCrtSHdrpU0VC1MC8ilNFJFomczGx6Z/gV1DoSY0rH/DxQZxr4GUbaF0WJdYmm9PxFplliaEY
	9nhK/JbPV+gza/9FNZhrD9vS4MmgFzeUNEGHbOyALmrui/YC1zx0H/9gsSHVeeU3fUSc2YJtLe9Zx
	iI/yLEFw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEHQR-00000003Ke3-1sDF;
	Thu, 30 Oct 2025 01:26:03 +0000
Message-ID: <b585fa87-b804-4f7c-844d-86645c61b2ca@infradead.org>
Date: Wed, 29 Oct 2025 18:26:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Reorganize networking documentation toctree
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20251028113923.41932-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251028113923.41932-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/25 4:39 AM, Bagas Sanjaya wrote:
> Current netdev docs has one large, unorganized toctree that makes
> finding relevant docs harder like a needle in a haystack. Split the
> toctree into four categories: networking core; protocols; devices; and
> assorted miscellaneous.
> 
> While at it, also sort the toctree entries and reduce toctree depth.

Hm, I was going to ask how they are sorted, but I see that it's by
file name -- chapter headings aren't sorted. E.g., under Protocols,


ARCnet
AX.25
Bare UDP Tunnelling Module Documentation
CAIF
SocketCAN - Controller Area Network
The UCAN Protocol
DCTCP (DataCenter TCP)
The Linux kernel GTP tunneling module
Identifier Locator Addressing (ILA)
IPsec
IPv6

These are sorted by file name. I'm not complaining, just
making an observation.

Another observation: I find the heading
  Softnet Driver Issues
confusing, since I can't find anything in
Documentation/networking/ that tells me what Softnet means.
(and yes, I know, you didn't add this, just moved it)


I like the organization. Someone might quibble over a few
entries and which section heading they should be in, but
that can be changed any time. (mostly items under
Miscellaneous; e.g. RDS is a protocol)


The size of the new index page is nice (about 3 screens on my
laptop). But I miss seeing the next level of headings
(:maxdepth: 2 instead of 1). And I don't see any way to find
that. It would be nice if I could click on a hamburger menu
somewhere to see finer detailed TOC/index. Or if the
sidebar TOC could be expanded by clicking on a heading.


And I don't think that the line "Contents:" at the top is doing
any good.

So I tried this patch with :maxdepth: 2. There is still too much
TOC info there IMO, so using :maxdepth: 1 is good.
I just wish there was a way to see individual (page) TOCs on demand.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/networking/index.rst | 241 ++++++++++++++++-------------
>  1 file changed, 136 insertions(+), 105 deletions(-)
> 
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index c775cababc8c17..ca86e544c5c8e2 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -5,138 +5,169 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.


-- 
~Randy

