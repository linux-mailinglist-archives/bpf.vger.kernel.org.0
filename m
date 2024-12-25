Return-Path: <bpf+bounces-47602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C137D9FC2E8
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 01:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFBF164149
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97517FE;
	Wed, 25 Dec 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUQkzWAp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E7182;
	Wed, 25 Dec 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735085436; cv=none; b=ZxbEBGyqR/8dn/VndJFq14k1DP/WCmrQQwIEaTEzD4OGvGCKRSA7ZwI46YmjmJcy8Gu2XZz1KIoHZXABQoCMoBpUn0HheupjqkeUzsUaXmT4AkjP+by7NLGM7i3oj6oVI5TwqOshUNXrlJYV9D+FXIcuvDrSUxlkyu8xZdCydWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735085436; c=relaxed/simple;
	bh=KeWdysBd/wBWdvTdrSt56fyMuKfKK5hrTBfORSYZJR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZNSjOn09aldaE9BX50HIEb4+cd9K3n0thvqVPr1KxwNvp7mZfdXvpfKcs4j7knW/ZxxTG6prSEkt1M2GDOJcNbJSpNeZ9Kklif6aK+5tNNZBEt73LZv5wzpT34idx1qOSpqOoMkFdiQX2qOBwjYGvbE4bDK/mbeHV0TVpRftl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUQkzWAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A8C4CED0;
	Wed, 25 Dec 2024 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735085434;
	bh=KeWdysBd/wBWdvTdrSt56fyMuKfKK5hrTBfORSYZJR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUQkzWAp2G5EIWOmIqW7VRJyvNNs+ttiCz21Fqyr22aaqDlTo1Iig1Vd7W+fF3Aqz
	 Ok2HBidQyAZPnWjT4hRSQh5Necsn5LijVgQYP3dQvOlAM5XCLcYAx/vIETJL4dL5BF
	 NyZ08SH+lxC37Ayjzd417aeMvSDix4Q1kza+9Swamz9YR5j6mcbs7yQl9q4ajwvaNA
	 qJGviOHkgM99SngWCJafGmt/bJflwhoAX3D1fwQQn6DQUQ5wOkC+H0QwEbKCfViHOL
	 v9A76E7iaui/nnEtjXLmArrZYF4LFm9UwbwKbxw8gDQxt1sMlFH+6Z7MnY+pzA/uD5
	 AqvI9R2LWxd4A==
Date: Tue, 24 Dec 2024 14:10:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Vernet <void@manifault.com>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix dsq_local_on
 selftest
Message-ID: <Z2tNebOEpysqVBBF@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com>
 <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me>
 <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
 <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
 <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>
 <Z2MV001RfiG7DNqj@slm.duckdns.org>
 <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
 <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2tNK2oFDX1OPp8C@slm.duckdns.org>

On Tue, Dec 24, 2024 at 02:09:15PM -1000, Tejun Heo wrote:
> The dsp_local_on selftest expects the scheduler to fail by trying to
> schedule an e.g. CPU-affine task to the wrong CPU. However, this isn't
> guaranteed to happen in the 1 second window that the test is running.
> Besides, it's odd to have this particular exception path tested when there
> are no other tests that verify that the interface is working at all - e.g.
> the test would pass if dsp_local_on interface is completely broken and fails
> on any attempt.
> 
> Flip the test so that it verifies that the feature works. While at it, fix a
> typo in the info message.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
> Link: http://lkml.kernel.org/r/Z1n9v7Z6iNJ-wKmq@slm.duckdns.org

Applied to sched_ext/for-6.13-fixes.

Thanks.

-- 
tejun

