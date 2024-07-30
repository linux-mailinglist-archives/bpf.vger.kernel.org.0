Return-Path: <bpf+bounces-36068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBE19414E0
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6582A1F2405E
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B6A1A2566;
	Tue, 30 Jul 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWbP96v3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C78CA6B;
	Tue, 30 Jul 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351310; cv=none; b=MFlcYozpZMCr34qWIkJHpbdD8MC5WSsCcf2axegArAAazf0HvYWPq+AljkHjNpEXwbLEulIRpnRFgQljx+x+meR3uK8XVsQfMXLyLWtvJAmo1g/6fhrnYQuhPWM5OvTzFkdLjcdIYqvuRamne28ES623K7fzb1L56vvxzsgxiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351310; c=relaxed/simple;
	bh=yTFuW1zZ0h5VOsw/16TAkTrWhwKTT7NDMXQBE9DcRrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5qKVtcWzNNgHcxObbkxHQFhYyidWFg2ibtCPhNMCDtHlEYSV97zPT4KhBjy7F8oIgk+sgErA8pJf71XHkScKDAD7bBg2zcMaKyYDp8szKviuCtYTdlmRgQY/ldiFTwgqv1qBbQXX01g/NWTA9ILWUIsWwQTsMpTK3S3VHfdWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWbP96v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2983C4AF0C;
	Tue, 30 Jul 2024 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722351309;
	bh=yTFuW1zZ0h5VOsw/16TAkTrWhwKTT7NDMXQBE9DcRrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WWbP96v33470og1PQG5/a/iPCkO4o1YDteo3goQhYpVhVnbi6Uixvw+2Q/4Z4Eg+T
	 l2hYwqzkSxfUH53kNtL6dApvsIlv66ATHQOMGh+s95E6V/LUugE+Ic7J4gDELIhszz
	 GqFPUjKq9Jw2U2ihSwiutwviqXB2WAYu4fAtKzhOAgnKBWlpekj+wdAcTttpmIwsh3
	 veSeyYAcjKG0rb1QC80/MXtO+ikY1b2NZ4WNV90buWKyfSPrnKVFO8DNfjeF2zE/au
	 mQrnFtQJGezT7pL7RVQbXgXYm5xo556KhTu3jOio4wUJGSlxxxzagoT9QSe3aRh6Br
	 ks5nce1/xL8Ng==
Date: Tue, 30 Jul 2024 07:55:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Jonathan Corbet <corbet@lwn.net>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Shinas Rasheed
 <srasheed@marvell.com>, Kevin Tian <kevin.tian@intel.com>, Brett Creeley
 <brett.creeley@amd.com>, Blanco Alcaine Hector
 <hector.blanco.alcaine@intel.com>, Joshua Hay <joshua.a.hay@intel.com>,
 Sasha Neftin <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH iwl-next,v1 0/3] Add Default Rx Queue Setting for igc
 driver
Message-ID: <20240730075507.7cf8741f@kernel.org>
In-Reply-To: <20240730012212.775814-1-yoong.siang.song@intel.com>
References: <20240730012212.775814-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 09:22:12 +0800 Song Yoong Siang wrote:
> This patch set introduces the support to configure default Rx queue during runtime.
> A new sysfs attribute "default_rx_queue" has been added, allowing users to check
> and modify the default Rx queue.

Why the extra uAPI.. a wildcard rule directing traffic to the "default"
queue should do.

