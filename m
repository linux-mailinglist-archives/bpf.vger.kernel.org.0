Return-Path: <bpf+bounces-69307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F2B93D51
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557AA2E1D84
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF5221FCA;
	Tue, 23 Sep 2025 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncwkQD38"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85E522F;
	Tue, 23 Sep 2025 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590632; cv=none; b=kp8L284+OHmrAoM3xSX+RAX0lwcvwGhIJ6tpqanXEAyHgrNf4GebBMOhUfZttfrzu/7jJ0yyrzHdfy7QOEKvMmog47rUNsN34oBb6fs/DA4+cRhc1e02Yn0tGjW8JV/fOdrY8opSqVwZkZntoAb95W9ExBDKCDCmbtqrVy9OwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590632; c=relaxed/simple;
	bh=Ay70jNSyk7SCiP7Eu2jk7muhLdtNGtdNXgPmR475aEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6aRuSsM2BipuNmgHpaKGeyUHcv+CtT5WreLf2w4so71tnONHvAhBs1Wbs979ke8uO19lGeKXYhsEexdo51htrPbh76lWfStkEjNJQhtQD5kORCp+Bnih8cyMpGvv6AI1mLqjloIRxIjRlWQDsHkvq75nUZMNe3gNJhhO3UQchI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncwkQD38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A022C4CEF0;
	Tue, 23 Sep 2025 01:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758590632;
	bh=Ay70jNSyk7SCiP7Eu2jk7muhLdtNGtdNXgPmR475aEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ncwkQD38uklX894fV/rNXalmA0Egdsagl1bwANWvQ7+W0F0q3lXxW2x/nfhl+XF6x
	 fMTdF/5ZFeB2KmdRlJatl7wU+V5kVkc81YCY/edcl00hgltI6vJjWbSw703z63+Ort
	 SDK+izNNYY3AR+o72T7n8yNXPql2L96yKIQ9+hX9ldpZEP7auCutIZEqLMOMfBPlo6
	 IDlyiuIwTES+7pqv5hSwWOr9DpLFHSNh3rUVD9TiOtb0fOXqEetbYNdLM/ePJjS/4+
	 pmDVIyTXAsR3f4KTBlkVp5GXTijm0f/+8f1Tgaul/x8FHJKOa0lyzynVWh2/q01K+i
	 AT3jT2Hn0JbBQ==
Date: Mon, 22 Sep 2025 18:23:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 04/20] net: Add ndo_{peer,unpeer}_queues
 callback
Message-ID: <20250922182350.4a585fff@kernel.org>
In-Reply-To: <20250919213153.103606-5-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
	<20250919213153.103606-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 23:31:37 +0200 Daniel Borkmann wrote:
> Add ndo_{peer,unpeer}_queues() callback which can be used by virtual drivers
> that implement rxq mapping to a real rxq to update their internal state or
> exposed capability flags from the set of rxq mappings.

Why is this something that virtual drivers implement?
I'd think that queue forwarding can be almost entirely implemented 
in the core.

