Return-Path: <bpf+bounces-66471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B33FEB34F26
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC07A829C
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7272BE644;
	Mon, 25 Aug 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btqCVaM1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6829D282;
	Mon, 25 Aug 2025 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161693; cv=none; b=H20kBrM7rZpJuWizQ1h/OfP+HZkzVaMtxPqzt9x+QeVROkhdPGyY1fSXtibwEX1MzQtn335v17c9/8/R/CR6J6IpdrOEpEk6/ZSa7RPeNzsZmb4kUQ0MDgpi2Q2EzXYGtWxScw2qlJJtyHL1ecNIPf4DltKgjGKD1sBqkrWiSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161693; c=relaxed/simple;
	bh=6S0O56affYuXFNGtA/LVx5GtJpAaqhKTD3uaqebypPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7DEMSf1DF4KZP6w/ezjcJA8KXLIZsedSTyfrLC2H6Lm9iS94ODBkZx8FBNfWooNt27a3xZ/V4lPzXT4UcaFm+AJSR8A2JRXmN8tH0KJqdf3JdVB4Yl3VSzcDY+mdf0jrXWjIsBeOGO/pYYH+oKEcYHGfHGmModhdnqqXCSq7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btqCVaM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B60C4CEED;
	Mon, 25 Aug 2025 22:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756161693;
	bh=6S0O56affYuXFNGtA/LVx5GtJpAaqhKTD3uaqebypPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=btqCVaM1I0E8O0HkAEcM5bt/TPQB41x6WnXYWSp6OGs8H77LOpX/lOznwW5PbNoBJ
	 C2axXqAOgboNzfFRSHvSB+bu5w63uU/+3VELseIg/aN3lzUEsbHqUPcKgX+IddP1CX
	 rEoO5EIsNJsyIL/n1MINbBwPDvDQP6YIqRshMDnELgoMFesAaLyvGfuZDIa7DAEvD6
	 aB6liAMvPvunvmUwzzzniLONORYbdEaz4Yo9v96WyV0FylOj90oJ+I0oKYn1dQckB1
	 KFk6Lp4/fMxJJEwT5BwrptkNP+TAobYcC4XZWEnVNnWjHU3KB0szqgrAqfyN3D3vaf
	 kw2Mx8wKKHfjQ==
Date: Mon, 25 Aug 2025 15:41:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com,
 kernel-team@meta.com, Gal Pressman <gal@nvidia.com>
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
Message-ID: <20250825154131.3aec6052@kernel.org>
In-Reply-To: <20250825193918.3445531-1-ameryhung@gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 12:39:11 -0700 Amery Hung wrote:
> Hi all,
> 
> This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
> pulling nonlinear xdp data. This may be useful when a driver places
> headers in fragments. When an xdp program would like to keep parsing
> packet headers using direct packet access, it can call
> bpf_xdp_pull_data() to make the header available in the linear data
> area. The kfunc can also be used to decapsulate the header in the
> nonlinear data, as currently there is no easy way to do this.
> 
> This patchset also tries to fix an issue in the mlx5e driver. The driver
> curretly assumes the packet layout to be unchanged after xdp program
> runs and may generate packet with corrupted data or trigger kernel warning
> if xdp programs calls layout-changing kfunc such as bpf_xdp_adjust_tail(),
> bpf_xdp_adjust_head() or bpf_xdp_pull_data() introduced in this set.
> 
> Tested with the added bpf selftest using bpf test_run and also on
> mlx5e with the tools/testing/selftests/drivers/net/xdp.py. mlx5e with
> striding RQ will produce xdp_buff with empty linear data.
> xdp.test_xdp_native_pass_mb would fail to parse the header before this
> patchset.
> 
> Grateful for any feedback (especially the driver part).

CC: Gal, this is the correct way to resolve the XDP not having headers
in the first frag for mlx5.

