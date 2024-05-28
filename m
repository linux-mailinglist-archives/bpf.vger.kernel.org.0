Return-Path: <bpf+bounces-30767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3758D245F
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C94BB237BF
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D1E17837E;
	Tue, 28 May 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmoNzAPG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C8171E59;
	Tue, 28 May 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923370; cv=none; b=dkdwX7QwUdPq1zV25EX13kHlsR04gFeDwZdocqJ0hy8aHnDCNt9EyC37lNom/ApUrz3CmiSq/E/BLf1dtf4mYS4wBXJ3eDjtxGJOS2t3kqFa6chEKaXGyhLRxN65TDQi1zTEC/TvjXfPrw5kY1eIDIxRO7U49VQXbEol3PLxdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923370; c=relaxed/simple;
	bh=TXpIOoXYGmt2pBtqg047ViZFwCKWKQ4ykKIKvnN77vU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CluQqAarjvuFy96NwUe7KkYyXlFnhfY778xo/8d/VEgo+4fykMm84kzs8y98jROO5jcypKf3tpdD43LaK2vBrUoAkeRCgbwgV2cJSrzCQ1tMS33wKfzt5hlf6Luf1MwrJ7O06oZZCXNu4aCHx8CEcLvZH7FlwRj7Wx9Xh0XyPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmoNzAPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94BEC3277B;
	Tue, 28 May 2024 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716923369;
	bh=TXpIOoXYGmt2pBtqg047ViZFwCKWKQ4ykKIKvnN77vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AmoNzAPG5OwWLUnUTGJZOanCQpM32jwGBiGV4Kj4DqPwhtvLBjX7A3wqKxlxsCTWE
	 4YlTKJUUMXV5uh6+0WPRfwCkH273a1cf0bd5KJpsqdkMUyjI6Vgtfz1tnOzv9bb0IH
	 pMIQ8j+lj9q4gKVtxV33VbBEs7s44f0JV+UutHCBHJeOxjqLgUm1R9HpH/wGhKV05q
	 Tr3TqW24CFEenXZNnu4wZ5SQQw1yk33QrWKJC/VFE/kzwHVqEjPvoMDBH3Bh/1I71B
	 V7tsnBW37DNfRz4Y/6LLe430oK/3rEAzLFnvf7ROuluDFMibMDvOjr8B9MyGzvce2H
	 RwlYJMYFmJ7FQ==
Date: Tue, 28 May 2024 12:09:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>, amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org,
 nouveau@lists.freedesktop.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 6dc544b66971c7f9909ff038b62149105272d26a
Message-ID: <20240528120928.633cca9d@kernel.org>
In-Reply-To: <202405290242.YsJ4ENkU-lkp@intel.com>
References: <202405290242.YsJ4ENkU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 02:19:47 +0800 kernel test robot wrote:
> |   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)

Is there a way for us to mark this as false positive?

