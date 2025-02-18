Return-Path: <bpf+bounces-51847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232A7A3A4DE
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11813A95FB
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3BE270EC3;
	Tue, 18 Feb 2025 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g41xbn9J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64418CC15;
	Tue, 18 Feb 2025 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901707; cv=none; b=meG9e6wmSChrnUe3Rr3pwc5a0s1LZLgSwxcWAsQJZ/kT9niRgx5htJEfZIqgZs99IMh6sx5jDxP4ssPdMnpdlFAZe/WrgTW0Wgxn5Il1p0TBIYh8686W+qs8u9OaNRS/UB9CG068JsM0Mqz3ZFIJYUKQPDLuO1HtByFkkFXv/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901707; c=relaxed/simple;
	bh=IC6oa2qv9H8mxh47sZ+OqGDDdBocPm58qHoAOCSmu2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCIewRuMm0ofiyDFeCrMWA4jVlsoTh8JTfPgZLTrnetnN+OjFqr0eGj7hk3j5Y/+Hr37T/PEwEgBSAmMQaQAa1h/beZMnfrvgEDCIdk3uIzHR57ftCaHHC2hP08wYUSEHOPSLGq3P9HkgwrADsMuv7zJ5FIcXF61paorUsQgPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g41xbn9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8773CC4CEE2;
	Tue, 18 Feb 2025 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739901706;
	bh=IC6oa2qv9H8mxh47sZ+OqGDDdBocPm58qHoAOCSmu2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g41xbn9JVxrQgr0H7kGQj5w91T9GQfZtxDyv/70Va8nBOu6h09Jw+NAhd8G2MpFJP
	 gC0Hd9jek6VTsanxByDMaNMvfsStOOesAnnRWKA7kS0dwOJAzvtOHVDW+hGAdOFEEx
	 5dEa5aspNm1NrZfhOPztIRYgXVaNkS3P8Kk46rUxtKFoY+esDfqzloeWGzjW2IpmEn
	 10IZAo/Ma7Y9aZfjNwociSWsrbtzx6wNlsnI7Vil0YgILyZe7SHFjlNDn1wK+sA+E9
	 TrGZC7l3IqHlUVRILKoaq5pRwSt/azD3awdJ6flSQN7B6ll5m5s0M7Zq/ZaLp+qQ44
	 REtNVxalttumA==
Date: Tue, 18 Feb 2025 18:01:41 +0000
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Md Danish Anwar <danishanwar@ti.com>, srk@ti.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: ethernet: ti: am65_cpsw: remove cpu
 argument am65_cpsw_run_xdp
Message-ID: <20250218180141.GD1615191@kernel.org>
References: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
 <20250217-am65-cpsw-zc-prep-v1-2-ce450a62d64f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-am65-cpsw-zc-prep-v1-2-ce450a62d64f@kernel.org>

On Mon, Feb 17, 2025 at 09:31:47AM +0200, Roger Quadros wrote:
> am65_cpsw_run_xdp() can figure out the cpu id itself.
> No need to pass it around 2 functions so drop it.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


