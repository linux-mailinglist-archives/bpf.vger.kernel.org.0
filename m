Return-Path: <bpf+bounces-51615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB2A3678C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4FE189292B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF051DE2A9;
	Fri, 14 Feb 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU64jC7g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963551DDA0C;
	Fri, 14 Feb 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568546; cv=none; b=GqSJiZFnGdYK87m/aRthBvieHfal/KPfB+N0EZknX7Q/DQpnweqOw6jyN6B1WroQA9clK8qjAkU2VoN5gHCgWFU4VwU2+QTJnCypm6yfp6H5hd2cBmWFW3C6+apnWFRRXxa4t7epgadiKUBQtw8x368XVqk5kZzShTdtQ1i2R3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568546; c=relaxed/simple;
	bh=tsuCtTgpS8a2QA4rGxh5SrvngWzcIGZ4nyLVNP99Zsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQWR0oisvSuOZ3Ycqa7Syr/n0DgzKeyCMMQ/wf6//kkyIleFjQ+LThH2+VEbixmpeUwaCWu1ArZWhe7izlTKRpDWTLmo0nhUJDrF6vd3eBM9Xa9F9jGrndOm5UNBaO+J1Cuk9QdqLp56g9VEw+z10evGEaSpFFxGUeLjur4lj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU64jC7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E995BC4CEDF;
	Fri, 14 Feb 2025 21:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568545;
	bh=tsuCtTgpS8a2QA4rGxh5SrvngWzcIGZ4nyLVNP99Zsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RU64jC7gLC5EiuwEbaWvQz7e57ZXOnt53Z9PnRUKUUe8Ezy79KhjN+SKjTSIKy6cr
	 Yoqhf2P9bJ15XlTk38zZafluQI5bfT7A38D/fykzoAa13980PJCRUy5x+H8Ave1QQT
	 KGGG4G3+b/ZUEgAgb0idxbID47jAa/BZZVRKmawOG//sxRgMuzTnsgt43nGBc+bk4G
	 JfbrEiWPuQSykS5VCisZFWoMOIlEh40AIgcRPTCoPaxWdnWMZAGl2M0XYipCPR1v35
	 uKU4Kru+LUo9KooKE3ieztj+9JRNlZbAaZ/H5IQV73rx0PeRUBNIO0sPeGou0iCSbY
	 YtEfUjiEtrHUw==
Date: Fri, 14 Feb 2025 11:29:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] sched/topology: Introduce for_each_node_numadist()
 iterator
Message-ID: <Z6-1nzIPYlFV60dB@slm.duckdns.org>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-5-arighi@nvidia.com>
 <Z6-yxTEbuJZUZW8f@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6-yxTEbuJZUZW8f@thinkpad>

Hello,

On Fri, Feb 14, 2025 at 04:16:53PM -0500, Yury Norov wrote:
> > Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

Yury, how do you want to route the topology updates? Do they usually go
through tip?

Thanks.

-- 
tejun

