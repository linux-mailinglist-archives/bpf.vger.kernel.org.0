Return-Path: <bpf+bounces-66488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A4CB35040
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481DD241F63
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DE1C701F;
	Tue, 26 Aug 2025 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz7at2VD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0721393DCD;
	Tue, 26 Aug 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168239; cv=none; b=DUMI7qSzkLN2CH7P6X/qLoS8pGuQbdMHtVP8YMmldwpKWZO7xVoV2yKLhEA2S5UqJEWlqDbb/ddf+cZcN08e1qnwWH6pv+TMx+rzycSqnMr8Mpe7UO2lAjjOxYH2TXbJypI9NW3rH++VIw7pJ61xDzVR+AuIC5gZM4ZBzRFDQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168239; c=relaxed/simple;
	bh=LjJ/fOO0x4Opm6yTiqQ/w5OCWIoO2LaWnmpfJylQRSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNRbvlaG5eR9pOQeJ92i1PCwdT8MgG/Aaa6cVIsGFlPao5PadokPVo2Ee431KLPSnkCYNzoZwmReegd8KOPvtdVCMAc0Z3VCIILys6Z8sJzXxJSmUdWCBzk/ZBq7d10zuWupXd7GUd15wrBW5fr1JbI40zKl/SCYFEyHVsvn5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz7at2VD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666BFC4CEED;
	Tue, 26 Aug 2025 00:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756168236;
	bh=LjJ/fOO0x4Opm6yTiqQ/w5OCWIoO2LaWnmpfJylQRSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iz7at2VDmI2CBB8Pn4Axe9eSR6WpUu0Q7J/+vETHG2mwOcqK8sIO+bnrhpWDT8Cph
	 M6XIwRfLs7JXngwZjhJcql10dM1nukgg6uSHxs6q0N3oW5Kx5+lB/Ph3Zkbvr81Qg7
	 3DoWfiulIYVm81+ShSlQN5Ts20QNtq9nWwpC3EyrWBO3Ko9KkcsFDIfV7p8CNTSF2H
	 xQLckQPTyUCS5M/yL6Jdv2vTQjQMON6EtH2ZusdIlc7c5eDj6AnGRtpFpaRFrqE7c8
	 aYjEQ2D12KoIFFSNGwQ8hZ3gOIfH2/4BSxtn9cv8AyMU/wNs1Jw4UuO2R9ddza+RJa
	 Gd0dJ1j5AuBdA==
Date: Mon, 25 Aug 2025 17:30:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
Message-ID: <20250825173035.7654531c@kernel.org>
In-Reply-To: <aKz73WdkzhOmLhjJ@mini-arch>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
	<20250825193918.3445531-4-ameryhung@gmail.com>
	<aKzVsZ0D53rhOhQe@mini-arch>
	<CAMB2axOkPx=5vseNXbwQtHQTFhdur6OSZ-HbNPUciwBmubQa1w@mail.gmail.com>
	<aKznqjd1aowjxJfK@mini-arch>
	<20250825155813.763d2a59@kernel.org>
	<aKz73WdkzhOmLhjJ@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 17:12:13 -0700 Stanislav Fomichev wrote:
> > > The unreadable frags will always be unredabale to the host. This is TCP
> > > device memory, the memory on the accelerators that is not mapped onto
> > > the CPU. Any attempts to read that memory should gracefully error out.
> > > 
> > > Can you also pls fix that other one? (not as part of the series should
> > > be ok)  
> > 
> > But we don't support mixing XDP with unreadable mem today.
> > Is the concern just for future proofing?  
> 
> Good point. I though we did add that proofing during the initial rx
> patch series, but I don't see any. Ignore me!

I could be wrong, but I think we did for skb paths only.
Perhaps you're thinking about those helpers.

