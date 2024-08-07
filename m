Return-Path: <bpf+bounces-36564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB094A5E9
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 12:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9BA1F22F09
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345711C68A4;
	Wed,  7 Aug 2024 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtRFSS36"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08401DE865;
	Wed,  7 Aug 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027278; cv=none; b=RLWWl0qfNo1ORvRkfvlwwM+hrarbjUlyigzEjGwmCEIqd4Kb7WHJt6D7yD4uTB/lyJeSUdZMksdBoPHxGlaM9J+EglbrZKYL6uG3MBlAZMTLfXScjussqzVtyzdd4b2Tt4oqPaS60IDbAUIr1JAIN1XbWHDZ4grd3Tfx2myTFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027278; c=relaxed/simple;
	bh=4VMXlW28jczmGWP0QcewU45/v/z5O2mocEIu9OUIDbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWMu7o97FwjTqjw/8720HVAQUr9m4VtRIrptynOG6BBjP1ztOcy/Sv1c+7zexDIepsEVxwpjMHgUopMfbbMkZK1A+nHbXESiXbz7Gth5iR1p6mIZ3wJMMautQDjOEA1YnMViZeBTHZR9Hjkyw7T0grYMtTAti4kvGgfzQ9wMBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtRFSS36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3ECC4AF0E;
	Wed,  7 Aug 2024 10:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027278;
	bh=4VMXlW28jczmGWP0QcewU45/v/z5O2mocEIu9OUIDbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtRFSS36ftYAtivBkt3L/ifmjh8L0z8ZZL/AeF9qqdLWl+UYCPrPrePPT3OMFTa/g
	 WCcYh9RX7Rlv+SvVAyGexD6FXwaElOUEVGLGDsWaamObJt/n5hGv68v6inj32b/UPP
	 eGeF+NEbW5GTMVSeJFrKr/0GxyphoCsxfbk1fnPPHWjSSvrqrMk+WpnMWgbsUyffd9
	 Bsr8HCEywZdcgOWb8cD1xPEILfwmysYWfyN71V73wiBVi0HmLIZSwh3qKKw7IN+SFJ
	 qOlGWyZsq2vXyKJkr1ZuOxhnXzkb4AZNCRm/TQespJOaXvLzUQbGA6SSBHVWhtq2PU
	 SnGR2GnHA33ug==
Date: Wed, 7 Aug 2024 12:41:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 30/39] convert coda_parse_fd()
Message-ID: <20240807-heimcomputer-gerochen-43b40b183307@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-30-viro@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-30-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:16AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> fdput() is followed by invalf(), which is transposable with it.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

