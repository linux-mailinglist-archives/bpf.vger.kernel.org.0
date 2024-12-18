Return-Path: <bpf+bounces-47271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC549F6D70
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 19:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA0C16875C
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3C21FBCBE;
	Wed, 18 Dec 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3mQW5U9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7811F63EE;
	Wed, 18 Dec 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546900; cv=none; b=RJSGZlop+2LgSY5kC9vuE6/lQOS0ZEd4yA2XcDTK/UredzAgh5Dtm4wWdNCcvuA49ZBcwWCHVupVRXv57HSY8CpXZxqEI6V4ncgNsnOh53J23jxCu5NIySgj+TbJnoA3Q4IyykIYXCTUwwDjQTvOE1rl6EgbwNRtTC/RorIN0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546900; c=relaxed/simple;
	bh=tXsBzvVsky3h6EGc9QycdpBimHZ4phdBDcHZzLE09nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djzihEVdzVQK9pWUVvPBm9TDArdIXBk5wlnb/8XZFbw/SrCzKFjSAGRRgvMVYxd7QxLSa9xnI1LKq4pjnq4qYLhYnaLsyNKobJQGfeypwLWrNNB8vdCN0y/CBnLyAo9PC6sIJgdy2TssBmk5VKAMpe7eB8/8Xlnt2ZTFnE0KpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3mQW5U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05234C4CECD;
	Wed, 18 Dec 2024 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734546900;
	bh=tXsBzvVsky3h6EGc9QycdpBimHZ4phdBDcHZzLE09nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3mQW5U9ElLt5T/GZvO2dN0ceDdBcl/BH6WD7hm89FEhn5/0G3HFkvu9hCmqggiOt
	 FCYWryIJzapnCbVOcaEUb6cbIaXZ8jNn7ZKtMA95SQtWS0aWejecjD6TcjOJ3BBfw/
	 CcFPPwj9Y/nsk9YWOP9qdifXZmostMqz0Tx2zmoycOj3WRgprMcRGb6pg+nFOq9KTK
	 u8w0KFHwtmIaQYhibpxlZhljYV6omQobCA9+GiFhr64smGQ0W4Hc0hKPjD/whEaksz
	 jnl8uBMoR16IXfTlQIAlm1qxJxGgUMgoMWpvHklY3ZjztachIutMHyvu1itCv2DxCQ
	 jI1I9cjcayjFA==
Date: Wed, 18 Dec 2024 08:34:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Vernet <void@manifault.com>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix invalid irq
 restore in scx_ops_bypass()
Message-ID: <Z2MV001RfiG7DNqj@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com>
 <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me>
 <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
 <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
 <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>

Hello,

On Tue, Dec 17, 2024 at 11:44:08PM +0000, Ihor Solodrai wrote:
> I re-enabled selftests/sched_ext on BPF CI today. The kernel on CI
> includes this patch. Sometimes there is a failure on attempt to attach
> a dsp_local_on scheduler.
> 
> Examples of failed jobs:
> 
>   * https://github.com/kernel-patches/bpf/actions/runs/12379720791/job/34555104994
>   * https://github.com/kernel-patches/bpf/actions/runs/12382862660/job/34564648924
>   * https://github.com/kernel-patches/bpf/actions/runs/12381361846/job/34560047798
> 
> Here is a piece of log that is present in failed run, but not in
> a successful run:
> 
> 2024-12-17T19:30:12.9010943Z [    5.285022] sched_ext: BPF scheduler "dsp_local_on" enabled
> 2024-12-17T19:30:13.9022892Z ERR: dsp_local_on.c:37
> 2024-12-17T19:30:13.9025841Z Expected skel->data->uei.kind == EXIT_KIND(SCX_EXIT_ERROR) (0 == 1024)
> 2024-12-17T19:30:13.9256108Z ERR: exit.c:30
> 2024-12-17T19:30:13.9256641Z Failed to attach scheduler
> 2024-12-17T19:30:13.9611443Z [    6.345087] smpboot: CPU 1 is now offline
> 
> Could you please investigate?

The test prog is wrong in assuming all possible CPUs to be consecutive and
online but I'm not sure whether that's what's making the test flaky. Do you
have dmesg from a failed run?

Thanks.

-- 
tejun

