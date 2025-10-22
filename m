Return-Path: <bpf+bounces-71839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082BDBFDDF7
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550F53A750C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A3434D4EA;
	Wed, 22 Oct 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPZh0c4b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880E29992E;
	Wed, 22 Oct 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158292; cv=none; b=EkuI5+f8sfgjoAbUmcWcL65wd25kJfuSqFT8tvWDUTV1OTSe3FEfo3e/VOVItjEvKfmr8h8gTjINQrrNKIbg0PaK2rmxCkIbAmJamkMjnto6RTFRC4D8x97+Y6lNoW6CDwX/PQe0yQyUglZOocvxlapWR8/AygzWIa4Wor3nXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158292; c=relaxed/simple;
	bh=ja2sOY4s5M8ozmUkNV0ArqPYMzvED+LHVt6LViI5SP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsFrH3rlUUuCuPGUDiDNROE+2FNpypz48Gyni6ueZTq3qmaL9UGl00JRJjOOrAow79A4qBWe2L/+P6zyh7OkxUHqzT9078SttqJi8oIORNxzNwlhDA45smBK+czraouBgdOkuNrcVTuLDlsCb6QS3n4CF6rkHu5CFMYGXleNXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPZh0c4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1A2C4CEF7;
	Wed, 22 Oct 2025 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761158291;
	bh=ja2sOY4s5M8ozmUkNV0ArqPYMzvED+LHVt6LViI5SP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPZh0c4bDpq7Am+Tvhrz/JqACSA+nEsXuxznHZAmNj5G7xrnLNEPo9kuZ2/cmBBI8
	 06ZyTniHD3MJaKA6wtFxFlWPcW1Z2WDo3cY/X06b3BndygTiFIo44dYInoN0EIobll
	 DzlGCzlsLNPuRAx8WmwDkqVrzFmSmQcfWuGMR077XcXLmz/Wn8Otf57fpDWygo0G0a
	 F9my5q1hgz6RhX8/mIj5gdgcCrpat2qJhtlY/zG8aal8KOVMbHQEE7uWDdcwTPAA5E
	 PiZszWlQzitgFOw6swGKGDigybHmCOEFTfwQAl0CB9jzehYONLgUEsCoMIVVzu4lco
	 7trntVpQ5N4Vg==
Date: Wed, 22 Oct 2025 08:38:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: sched_ext: Fix SCX_KICK_WAIT to work reliably
Message-ID: <aPkkkp3foe1NoLfL@slm.duckdns.org>
References: <20251021210354.89570-1-tj@kernel.org>
 <20251021210354.89570-3-tj@kernel.org>
 <20251022080346.GH4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022080346.GH4067720@noisy.programming.kicks-ass.net>

On Wed, Oct 22, 2025 at 10:03:46AM +0200, Peter Zijlstra wrote:
> >  			while (smp_load_acquire(wait_pnt_seq) == pseqs[cpu])
> >  				cpu_relax();
> 
> You could consider using:
> 
> 			smp_cond_load_acquire(wait_pnt_seq, VAL !+ pseqs[cpu]);
> 
> that's the fancy way of doing a spin wait and allows architectures to
> optimize (mostly arm64 at this point).

Will do. Thanks.

-- 
tejun

