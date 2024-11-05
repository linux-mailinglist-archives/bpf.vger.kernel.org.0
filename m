Return-Path: <bpf+bounces-44017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C819BC619
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 07:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64AEB22192
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 06:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8221FCF4D;
	Tue,  5 Nov 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1q+Ip/v0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E521F5857;
	Tue,  5 Nov 2024 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789707; cv=none; b=koBmnan9EvK+m45+186MTVpWLdRmzVHVTjDXpU4V+qS3gY/eBFbyXGRDhCzasmg1SPTUh+3CXUb+u7npOGhktZkxoWYLDTUsbi/CXsa4FBuE47lOkK0gLHnCnySrpL5dXxLam75LRhXM0MSx+7Al2e3BTqoO36Z0fGRKW4uTuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789707; c=relaxed/simple;
	bh=4vTPaPmuaaNrcMy/tfb4WIzJTT/0CeVPT8e97fnLOQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOfEBZQ4b94h8mZ7ZcIJeDzkF9960CCeZmW2usvOEhv3CcnrH5cnfvbjirgcDdK6jrf5FXmlybOSxBSJC1kwUTQbr2gnkxsZRO1QpfXp1G/QBq3TPx9h1duoRLOzE2qSCTby0e3xU7EFCW3dWfo/qjG7E+myZd60R/LLJFyZmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1q+Ip/v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040DBC4CECF;
	Tue,  5 Nov 2024 06:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730789706;
	bh=4vTPaPmuaaNrcMy/tfb4WIzJTT/0CeVPT8e97fnLOQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1q+Ip/v0gpXJRuiLa4vQPiVMraG/xDRGieWtZR5qsVW1016Vl+jis9+SJ2bSSCMKh
	 i1fV62sIkOpGcv+Nml+rgpSIhHOgbSp5gdqBBySjIalCTxScuq0PdKFlTzWoqyaQn8
	 nary4t+vlh0oPsuQ45E876SN60we4EA657LyKcTY=
Date: Tue, 5 Nov 2024 07:54:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <2024110536-agonizing-campus-21f0@gregkh>
References: <20241104175256.2327164-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104175256.2327164-1-jolsa@kernel.org>

On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> hi,
> sending fix for buildid parsing that affects only stable trees
> after merging upstream fix [1].
> 
> Upstream then factored out the whole buildid parsing code, so it
> does not have the problem.

Why not just take those patches instead?

thanks,

greg k-h

