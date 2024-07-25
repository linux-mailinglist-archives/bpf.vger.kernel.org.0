Return-Path: <bpf+bounces-35640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DFB93C315
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 15:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9039A2833E9
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5E19B3D7;
	Thu, 25 Jul 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvkIQukz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A841991C2;
	Thu, 25 Jul 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914256; cv=none; b=OsBdkM1dyIf2OMnFs6wqkZJhiulRushQYvFzkkKVU2j8/uLQ0natW85TazhOgCd3rOUctNoaQaDKQe0NLvTc8Z1e/tK7jmY+GQIWuTPvpjsvoAKHHKbSvKEoIOS3qSRcWMuoOk/SCTSRT1oMZhroNrXChszJdzWY2GT3p/rRH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914256; c=relaxed/simple;
	bh=P3eEGO6WJVHL/6FRedqgnF5UFgz3V6FKYvYv3CZGFVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPzsBiMnWEmS3ksa2uGZM84l4xZzVNnglAEEd5SywBIS8+U10SrhKle9LW6QNU46ygZKfu2GHs7J1RWOUf196M/0QtNvkfeTQGODV/s11YmGlqnDX9YYCFt3tXMSbwYX4aXR1I30Noo6lttjpB1Nz9pcmtoiB2L8y8MwactohdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvkIQukz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC4AC4AF0A;
	Thu, 25 Jul 2024 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721914255;
	bh=P3eEGO6WJVHL/6FRedqgnF5UFgz3V6FKYvYv3CZGFVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvkIQukzXqLhkxNG2L+J/bd7zSR7kE4IqVjYm4wOABADjcwggjlzREF/zVkBoHzIv
	 5JQP8ucxaNXOzNZx4zJggFMrALrRkOovRHyNZZjC2cnxKGq+5mcSNUZbPBBfz3n5k2
	 CKU39MlpQkM+LhzsQbjnfFPKSg0UJCVHLAc0PzwVYjSqtBcr3knMdbx3h88GKl1tWX
	 fMbujcf49rEbsd1T7PoiAQ2NxWbw/Hn6cVkcs7PoayCirCMsJYoo9L9nzb0O3/wpFe
	 uvapiWXKCsAjkYFlxM//SwLMAGPX/PfhKsHUgZO0CysTCvAzqDSTy0BCeskh/Wei7s
	 htty2kjjuu7qg==
Date: Thu, 25 Jul 2024 06:30:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2024-07-25
Message-ID: <20240725063054.0f82cff5@kernel.org>
In-Reply-To: <20240725114312.32197-1-daniel@iogearbox.net>
References: <20240725114312.32197-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 13:43:12 +0200 Daniel Borkmann wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,

While I have you, is this a known in BPF CI problem?

 ar: libLLVM.so.19.0: cannot open shared object file: No such file or directory

Looks like our BPF CI builds are failing since 8pm PST yesterday.

