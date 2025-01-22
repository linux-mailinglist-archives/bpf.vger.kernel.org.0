Return-Path: <bpf+bounces-49426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88159A189A1
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536F0188B69C
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 01:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6333D136347;
	Wed, 22 Jan 2025 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QppKBeHK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E37462;
	Wed, 22 Jan 2025 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737510036; cv=none; b=JogfyCEe6A58b9Xg+MjU6LgJ6Yh4a6HdhW67q8TeSX7IZf3JmfvbSN8/PbGsuDWYQwH4tmrwBxbicO3QGqpPv9Jy7RtfD9O6eTNPL5vFdSbReQqiZjW1UZLocq5kzUBc+ey/N1ek3rKSBkN2qCXuwmuvtq12RvRJzOxQ2u1CE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737510036; c=relaxed/simple;
	bh=y47CIGGCJT89PF3xKW62QwwBKZRmBNcJcXEXXw65DrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8/6YitW1kkAlmlyVOIq1490kofVrL+USDiosaNppt8sSeJpLs+yWBUQKH6lE0bggGWCNA8SuAYaJj1mk6CfMgh1cF9U5xh5FbZ9Yxcv77TR2ljaUhemHpn5fM26C5SAFN+mni7tkikJmphtUBhoB/E52B/Kk3babKCffp4WHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QppKBeHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE34C4CEDF;
	Wed, 22 Jan 2025 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737510036;
	bh=y47CIGGCJT89PF3xKW62QwwBKZRmBNcJcXEXXw65DrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QppKBeHKvGLVXO77i52GnocnOwRLNJ5Gv97vFnEdbm7EXmVSLv3v8EDYKFFixNI3m
	 dcnzNi/XEzrkmJAoCmXKzMJm4Fz8Z9sM6Zdklla2ZOVOQu8V+djL6j/Bc9cyb9gCQs
	 Rg7eo/4czdt527dRtSPL/0uOY57svoIoXTZ3YaQyHb0YS51gzcWcchx2ZGfpfGmtNU
	 tltwgbbTmpSP6kCNatn8R+Fzdg6kc2HBp+vf9+5/JQiwvGNzBuxhmcsGw1v+01JGwy
	 T1MvjP1bIC4d1vkscrcHPFZgndlOq0n5KeeNCDPTQVB7kB7OAoMreSH1wimEi9fWJb
	 G/jyeQSugjR4w==
Date: Tue, 21 Jan 2025 15:40:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix dsq_local_on
 selftest
Message-ID: <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com>
 <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me>
 <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
 <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
 <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>
 <Z2MV001RfiG7DNqj@slm.duckdns.org>
 <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
 <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
 <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>

Hello, sorry about the delay.

On Wed, Jan 15, 2025 at 11:50:37PM +0000, Ihor Solodrai wrote:
...
>     2025-01-15T23:28:55.8238375Z [    5.334631] sched_ext: BPF scheduler "dsp_local_on" disabled (runtime error)
>     2025-01-15T23:28:55.8243034Z [    5.335420] sched_ext: dsp_local_on: SCX_DSQ_LOCAL[_ON] verdict target cpu 1 not allowed for kworker/u8:1[33]

That's a head scratcher. It's a single node 2 cpu instance and all unbound
kworkers should be allowed on all CPUs. I'll update the test to test the
actual cpumask but can you see whether this failure is consistent or flaky?

Thanks.

-- 
tejun

