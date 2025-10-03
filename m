Return-Path: <bpf+bounces-70303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3069BB76EE
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8548319C2925
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2483529DB6C;
	Fri,  3 Oct 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcipUX24"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99615292B4B;
	Fri,  3 Oct 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507357; cv=none; b=AHbRNqemQtqE3s13ACCpQWYtc9U1nJWSNI0kUM4xjqW5l8FYWhD+hUeTQIls849XdvWoaWs8xgYjUoXQtA03Yy8O3qcI6mIzJ8zbCbFrbc/PcEHUjf7MxoysCN33cNtED+cHVN57gp/T0txcQUEebJ3SpaaQ0cauo02j3utIMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507357; c=relaxed/simple;
	bh=TnRqdPXkHOd250dQe1+zF4SMpWvnQW0AZqlPMfQKUCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o74aOaKS/NApg372OS9sk7t0ObkO2Hc2n1kN7eZpGlQPKUtYkG9KyYtXIPP9k4RhhILFza9c1YYXOu8fXbQZMPpr9+V7bvvpQfEchfGOmmKe8okAmzHgaV4YrQPEctlCLe6ITDo5iT2zqb/Ioi2t83Zuph0jmPEsKbY2QCDg6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcipUX24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF988C4CEF5;
	Fri,  3 Oct 2025 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759507357;
	bh=TnRqdPXkHOd250dQe1+zF4SMpWvnQW0AZqlPMfQKUCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AcipUX24Keh/3XCAOENF4a8xnMv2DEnMURqsAI4dV56nM2gdlv8WrKsJk584/Fyos
	 ikSXeQQM/krq8EE3UPrI7uqWUaALQVm368fPlhWkkD9yNK0QSDXOKvxmJZJhFiJYlV
	 0fJERoo0zB0YXGFah1RVQ8Zjs535jIzmFoj6WwLN789+e68Pk4Cl5E/Mz2rwwHguvY
	 tMaZG0eob1yrT4l36ir9ihESgbfd8Zaw3F5KZjzpsudX+0ldjHe5tEQSbCfsNOifsP
	 EkeKxZKV16cUv4uiuhCtpDeX+Pi1qmFNkuPVFkXN0LGyo3+NfjmPJSDyqBzwaoQiRi
	 7mVpkrJoRK8Uw==
Date: Fri, 3 Oct 2025 09:02:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Yusuke Suzuki
 <yusuke.suzuki@isovalent.com>, Julian Wiedmann <jwi@isovalent.com>, Martin
 KaFai Lau <martin.lau@kernel.org>, Jordan Rife <jrife@google.com>
Subject: Re: [PATCH bpf] bpf: Fix metadata_dst leak
 __bpf_redirect_neigh_v{4,6}
Message-ID: <20251003090235.09521adc@kernel.org>
In-Reply-To: <20251003073418.291171-1-daniel@iogearbox.net>
References: <20251003073418.291171-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Oct 2025 09:34:18 +0200 Daniel Borkmann wrote:
> Cilium has a BPF egress gateway feature which forces outgoing K8s Pod
> traffic to pass through dedicated egress gateways which then SNAT the
> traffic in order to interact with stable IPs outside the cluster.

Nice! The warning Stan added at work?

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

