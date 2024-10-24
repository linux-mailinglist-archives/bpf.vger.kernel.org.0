Return-Path: <bpf+bounces-43064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA989AECFE
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F7E1C22F5D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5491FAEE1;
	Thu, 24 Oct 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB7ZhEVE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592F1F81B8;
	Thu, 24 Oct 2024 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789169; cv=none; b=h2Ui8Hc+DfAXFQXjhx7max0SfNThtyiRXHp8EgYgIgMspWS7ls5/y9LKsuGYRsaFOP2ssXxZd5gcfSTsaMzCk9cMGG+yGjlt73BsR9eqh4K/OSmcW2oOyUaGfeVqxIhzO/Poag0ErVrDG2WQ4bougqnPD2TI2Cj0ZoFJU7j6Ixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789169; c=relaxed/simple;
	bh=20C9WNRaFYEtGjXoIBEl+oOKzqpiDir1V+cedDMBf3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCVFEiIKahjWk8Smg4DxrGU5uyC8A+mfkEHumBGRqGz/9N2ixPoqkZ1s1VuzgwFzrbNqrA73r9Ry2CoFZ6+Oe6twl3DhElHw4p+MU5Yaa3dXOXVY1202eyEe7WmDomCv/onq1fWiFo+tPL5L2fyW2szUnnNgtpi9sW8vEzykF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB7ZhEVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05736C4CEC7;
	Thu, 24 Oct 2024 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729789167;
	bh=20C9WNRaFYEtGjXoIBEl+oOKzqpiDir1V+cedDMBf3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dB7ZhEVETSBrIqxhuGZPB2rHTe1j1w9iz0C9/339teTaYs112XVkYJqjUnE1Jv+EB
	 oZA4+V03WIh98jKTFSBSvdCkPzK+nJtUxuRZiUmwhecetwP4/xVlq8wXrY/7Dl0GVC
	 riXk8X9sGI6chloBLh4IfnrlEuyM3RlOLzyFq5ctXlu+4uAoT4oIan6fz6fEAhE1gj
	 dHs9oH4x0WZKyRN42q9PGclJ4pjE8nf5E9YpbQeyHSsf226Gi2Kg/lCLOCSKDy8byR
	 ClpsFnuyqkNB6v9cFKdSL3ZcIB2d/cnT8+0qYJaXokQwD/rEr/eFsB8gsjmX6ZX7Rf
	 /jhYupShek7uQ==
Date: Thu, 24 Oct 2024 06:59:26 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, kernel-team@meta.com,
	sched-ext@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.13 1/2] sched_ext: Rename CFI stubs to
 names that are recognized by BPF
Message-ID: <Zxp87iS56NmvyBZj@slm.duckdns.org>
References: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>

On Wed, Oct 23, 2024 at 02:54:41PM -1000, Tejun Heo wrote:
> CFI stubs can be used to tag arguments with __nullable (and possibly other
> tags in the future) but for that to work the CFI stubs must have names that
> are recognized by BPF. Rename them.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>

Applied 1-2 to sched_ext/for-6.13.

Thanks.

-- 
tejun

