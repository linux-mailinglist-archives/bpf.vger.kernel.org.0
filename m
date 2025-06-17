Return-Path: <bpf+bounces-60850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D9ADDD05
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D781883ED8
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F52EFDA5;
	Tue, 17 Jun 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6rbbaad"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220C2EFD83;
	Tue, 17 Jun 2025 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191179; cv=none; b=HyZOD1NleWR48cYQgKhLA8aabrau7ouIc1+GbvpJEWCTTPq21YiFiBbaAgHWJyUv29H3nkhA7CluFQEGI8PdThK+GvGxgE6HGVpn90wmKvhC86I0yV9p4smfQmc1ll03Kc7sxo+vqcobNkNC0h26QvQMIUXBql0ssQI1Ov5Q8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191179; c=relaxed/simple;
	bh=784haAvSi3ddkWBbU9OQ1gTPRYLDDFaqTjjqpscFNnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1cwGjaT2C1TXTSxK1z+UP36cIdzrAKzJf5odZmoCHBnND6rQ/OXgECi4C28BJ417fU9PkeQsYR2+hpF/vZru6MJfYmbfthFsDSRJrpk1+Z8SlDP98DJzJ21YJaWI8W/QDzc+PWR8IzsFVb1OV6KKz+/yrZocg2yLkGaVafq5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6rbbaad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B646C4CEE3;
	Tue, 17 Jun 2025 20:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750191178;
	bh=784haAvSi3ddkWBbU9OQ1gTPRYLDDFaqTjjqpscFNnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6rbbaadHnS4Qw+wR4NfxTVey7DxkCYPJbVk3/WU6cM9WXz44J1b4w4H/ZUJ9uLMN
	 1Diz5CTo7nM4+gsXhYg6cmIBDsmS8nLYxCFeAcZ1FN22KeKioNx2xd8OJa8MknPqiB
	 oOB/pHHwSzPZ5aprj0L1vI1gIK3kYWtPNSODVCsEaRm4ffCitG1MdrfJtXpISU4TOg
	 o6EaIHkj7mmoLtbWsjBP/IQlcdnGBhN6XvS+Tgig8HlImHhw28Q9Qlm0hKfkD5J0IY
	 ROMtQ/S+YmW3SFix3KEFdq4maC1NTTw7VeC3baMP8SINaKiKeeyaKsZc63BGhLgHxK
	 8CFaffi86//tQ==
Date: Tue, 17 Jun 2025 10:12:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v3 0/4] cgroup: nmi safe css_rstat_updated
Message-ID: <aFHMScVY-4mFmUZa@slm.duckdns.org>
References: <20250617195725.1191132-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617195725.1191132-1-shakeel.butt@linux.dev>

On Tue, Jun 17, 2025 at 12:57:21PM -0700, Shakeel Butt wrote:
> Shakeel Butt (4):
>   cgroup: support to enable nmi-safe css_rstat_updated
>   cgroup: make css_rstat_updated nmi safe
>   cgroup: remove per-cpu per-subsystem locks
>   memcg: cgroup: call css_rstat_updated irrespective of in_nmi()

Applied to cgroup/for-6.17.

Thanks.

-- 
tejun

