Return-Path: <bpf+bounces-54705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3BA70865
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 18:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169BE1766C0
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17BD263F32;
	Tue, 25 Mar 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwb/dM3Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B414A62A;
	Tue, 25 Mar 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924710; cv=none; b=BMktMcEoH70tvyC7svvAcxfg2Z6nf85A5LoWE6eMv03WgQSSnWIQ99EwhzAARcfSpMJbymOCq3UMIk9cXMrq63rktqTWk/ASSmj6p0BLdI3PVsEDiMPtCqkceUTfmQZ5A+hTxXLTbG2bLhitSX1jGN2rZucNkeygMXm9BxCJubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924710; c=relaxed/simple;
	bh=q0lIi5oDrnHfx718FGdRuP2hOnpXoXos3x22buNIZA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7MqUXs8WEo4qmBg/SL5H5IpmFo50X2g5mdBCjJvKhYW5EPNbfHCfUYUnrV4Jb+3z+zu2Uq0+l7PdPvKeFtQpmXv8gUB6BnOe/0mJMypRtBm4w0U0PhfmlHn0s6LaXdXVHUf6ErcnJKT7Aaxw4wYWM798/PhSyFd9//uKZ6Kr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwb/dM3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE10C4CEE4;
	Tue, 25 Mar 2025 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742924709;
	bh=q0lIi5oDrnHfx718FGdRuP2hOnpXoXos3x22buNIZA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gwb/dM3QNVWGLwB1ZwIkuXjJgzv0s+l+0Mc4x1JO4DqH+Yy70Fn/VH9If2cAcOGB6
	 VnskFoo35tf/fheRfK/3tfHjo41x2vZi+J9l2J8/x4pfVDOeAg8ooCwCPNfbKwysHP
	 9EbIQsUDv5eRBpxioFLAFzOTDAbAoDkpYj6rLtHupQvmSFxGEOnWIiorgf1J2bxygR
	 YOhw63YxksWO0s2lraBp77z9fFFd9U4M2QMuX3x6ReLeR1DZt+CuQe0Hp56t9lOEgs
	 R+cZ1aPFCIQ7f2ounOrCIn8Bs0thcGfLRl9mNngAMJ9YxmMha01mqKiRLxAvqJPVLw
	 RLMytnsr4b5dA==
Date: Tue, 25 Mar 2025 10:44:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kory.maincent@bootlin.com>,
 <dan.carpenter@linaro.org>, <javier.carrasco.cruz@gmail.com>,
 <diogo.ivo@siemens.com>, <jacob.e.keller@intel.com>, <horms@kernel.org>,
 <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
 <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net-next v2 0/3] Bug fixes from XDP and perout series
Message-ID: <20250325104458.3363fb5d@kernel.org>
In-Reply-To: <20250321081313.37112-1-m-malladi@ti.com>
References: <20250321081313.37112-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 13:43:10 +0530 Meghana Malladi wrote:
> This patch series consists of bug fixes from the features which recently
> got merged into net-next, and haven't been merged to net tree yet.
> 
> Patch 2/3 and 3/3 are bug fixes reported by Dan Carpenter
> <dan.carpenter@linaro.org> using Smatch static checker.

Could you perhaps add the customary

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

tags, then?

Please also link to the reports.

