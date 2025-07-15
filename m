Return-Path: <bpf+bounces-63389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C0B06A11
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 01:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDE77A7031
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 23:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B252D77F5;
	Tue, 15 Jul 2025 23:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a987uHj8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3FA2253FE;
	Tue, 15 Jul 2025 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623357; cv=none; b=B9xMXuDpPUPcMVg6jS7W74TkN77bGLtn7TKbOKArfjmo7aOx2rZBrAY+9oiYRBtJwJK1bW6T0Pk1zQJ6iyA8oInMznE7CPvIlTNwl+motl/nlXOIhiBF5LiaSLvjoDrRhWo8lq3KIEYytpdaVzPP1bwzT4VG4+fqJ/C+MgYOXlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623357; c=relaxed/simple;
	bh=rTwjNk2XHUB+TgCQDxch8dh4VWi/8YBRQJzUHMoyxjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhbYcY1LHVA67MT0pcRXxJaVajA4wB8oih1MUnxuBEY2Vz5IWkydKbWbgk+IIHg4vsPqKj4pCId1WQdyoCCVaUgdzFodZLKQmnzS7MYHITI3MjM1qu25+laa5sg6YjJRxlAAwAarPOZvPSB/85bMDyaS8BqQ/YgXXlATQVtrE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a987uHj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44DCC4CEE3;
	Tue, 15 Jul 2025 23:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752623354;
	bh=rTwjNk2XHUB+TgCQDxch8dh4VWi/8YBRQJzUHMoyxjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a987uHj8xrtN0EATfTVGQYerXdJF1RaVdYjMsZIxbK/PEW6T0Ow+c2XR4XswiFP+S
	 CFoKSUxO8gxYKMgihEWfKXVMbGHWPZ5aiav1vk+ZP7ua0qN8FLSh6CVucnNjczq46h
	 1Hg8onNCAtSG9T2XzvWdkUdZ8yC3ljlqiaNuxuBCio4ZXcmFQS3karUEpV0U5MpYTI
	 kgJJZYvOA3OLsYy6toXbm0a5tlRDJvgbJizYR58UVdLQv4rBXolKtoXtMQTSYGASgw
	 sOl8wcRI2QbUKOkxp1TPev2NQIfXx7zPT67NhRj9sbaJXarPSK4BOXq5FuA5+O/DrJ
	 h5mcpUUIzZYeQ==
Date: Tue, 15 Jul 2025 16:49:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next,v4 1/1] doc: clarify XDP Rx metadata handling
 and driver requirements
Message-ID: <20250715164913.3ed08273@kernel.org>
In-Reply-To: <20250715071502.3503440-1-yoong.siang.song@intel.com>
References: <20250715071502.3503440-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 15:15:02 +0800 Song Yoong Siang wrote:
> -An XDP program can store individual metadata items into this ``data_meta``
> +Certain devices may utilize the ``data_meta`` area for specific purposes.

Calling headroom "``data_meta`` area" is confusing, IMO. I'd say:

  Certain devices may prepend metadata to received packets.

And the rest of this paragraph can stay as is.

> +Drivers for these devices must move any hardware-related metadata out from the
> +``data_meta`` area before presenting the frame to the XDP program. This ensures
> +that the XDP program can store individual metadata items into this ``data_meta``

