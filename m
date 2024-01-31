Return-Path: <bpf+bounces-20815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971B843CED
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 11:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A884FB2B126
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA8E69DE7;
	Wed, 31 Jan 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fac5OTkB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939F69D0B;
	Wed, 31 Jan 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697507; cv=none; b=nwszzqrUdQpJMOj/Nh4mutYbdYykB4aN+oxC9yXHueO/JWbZdB5qiGJo0DHiC7l9oWbSlhhTHkZACPbxaJ75BIXpT1j2mhiz3y6EJmOFE4R5GFlGpcztAWwsNSHlf51wThuNye2nUk6lYN3HdRH4rxs+jUSOouO0W3rMkDUO9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697507; c=relaxed/simple;
	bh=G1xb+7GcuqoR3Hpne3zc8YgCg5SYmrqCTtVXVrZG2fU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GKVi2uzth66Y48lpOrs2HhSlpdmCLeGeO/E3piEg4NeH5SzPfDaywY6hCdTitxM7eHBjBFjyJnXm6n5k8wNVdrh8yLuKHI50QmIo3LJt2C+ne9yVCG8w46ISX28ybzloZuWBEgd8GhoL+O5dSbPzyi+USLPyspP5lMC0Pa1XXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fac5OTkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098B5C433F1;
	Wed, 31 Jan 2024 10:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706697507;
	bh=G1xb+7GcuqoR3Hpne3zc8YgCg5SYmrqCTtVXVrZG2fU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fac5OTkBkRLA1DX3YIghuHVctzb5epHMKkDNS7/diRvKR/BH9srNwyhkx0/srNYGG
	 9PxW0AupX9Wa5lwUZegOvAvz0y1h+cBbPBhwlbu2IwX+jJP8Z0tJd/OYvqmnKiPYHc
	 t5/vCrZgAtB1guCN76Xw2MJrnkhUT55lUamWj8yu0kRBhYTA01ylcq8iRqBoj5n6ey
	 M/sqzrRKCNXO45Dpv/aCKTjpNE3KALzNxY5Ec/LT2G4GiXX2gNOMHFkmltEYVLoJBb
	 5YcUmaFEs+Ls3Z1X6UIsxeBx0VXk1cceWkYjUUsZ9UC/fy7vgLCBsVcrMESA/0liT5
	 T+8wXiqUCuxWw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20240124-b4-hid-bpf-fixes-v2-0-052520b1e5e6@kernel.org>
References: <20240124-b4-hid-bpf-fixes-v2-0-052520b1e5e6@kernel.org>
Subject: Re: [PATCH v2 0/3] HID: bpf: couple of upstream fixes
Message-Id: <170669750476.304575.17277174965193688582.b4-ty@kernel.org>
Date: Wed, 31 Jan 2024 11:38:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Wed, 24 Jan 2024 12:26:56 +0100, Benjamin Tissoires wrote:
> This is the v2 of this series of HID-BPF fixes.
> I have forgotten to include a Fixes tag in the first patch
> and got a review from Andrii on patch 2.
> 
> And this first patch made me realize that something was fishy
> in the refcount of the hid devices. I was not crashing the system
> even if I accessed the struct hid_device after hid_destroy_device()
> was called, which was suspicious to say the least. So after some
> debugging I found the culprit and realized that I had a pretty
> nice memleak as soon as one HID-BPF program was attached to a HID
> device.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.8/upstream-fixes), thanks!

[1/3] HID: bpf: remove double fdget()
      https://git.kernel.org/hid/hid/c/7cdd2108903a
[2/3] HID: bpf: actually free hdev memory after attaching a HID-BPF program
      https://git.kernel.org/hid/hid/c/89be8aa5b0ec
[3/3] HID: bpf: use __bpf_kfunc instead of noinline
      https://git.kernel.org/hid/hid/c/764ad6b02777

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


