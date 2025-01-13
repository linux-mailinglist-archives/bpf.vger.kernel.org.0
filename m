Return-Path: <bpf+bounces-48709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1555CA0BFBD
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 19:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55A77A2B78
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946F01C07ED;
	Mon, 13 Jan 2025 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saignraF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBA1BB6B3;
	Mon, 13 Jan 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792678; cv=none; b=d5WPwLbBab7q3KeYAYsJJDHwKElvdX5vV3xQkDo3nz9F/+SUtCxtUamSwbEaLTrFeS45AxZrhH+6tCESoePgwDHLOsqr8egONs1hvziJknegdivYhTlrdjd1Prmoe6W9WxoIX6F8nvzuWCHthPSO2zFHa1HdHg2yJUbY7CbvPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792678; c=relaxed/simple;
	bh=CDLe+vpW/lg9LKVikamSBtDtJJ+jom+4AZjNVjNw34c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyIoQ+PhjjaOHgdus6Z9S1BuHqwDiaJQAcykh6ane1mUzr0JZiRcWXa9iAUEO9IX4KAzmUKOHcxPe98gOGncNOyeY44rja/Uny5E3N8I03Ws8rQhq0DQ7wF6wA+uWdhFAyOEDVP+XsvAcvLc93n9xgzcYCcUyIL6dlURYsmh0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saignraF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F3BC4CED6;
	Mon, 13 Jan 2025 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736792677;
	bh=CDLe+vpW/lg9LKVikamSBtDtJJ+jom+4AZjNVjNw34c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saignraFluy6aaxvpCc3e8x5vR1IGESlrKbnZ7IRocshwRhX7cM/pRgFSHDbKYnZs
	 vRj36wRgPcyF+u/BCXVGpGi2fX3T9Qbu9812LLZzJhYaqrD1h2WqaCueVlMvBCrk2W
	 xeaF0JGIZwRtxjt/FvqhvyTdYVR5yqWKVv+h1GW64JCi4Z2Y8tO2M3iIgAqu2cuP1d
	 0pfT2Bvg7eKJTWbrGsRQOqWZYuFyjCoqOwp7OJDA+NaprhGqvAEPWa5d7QVPSsCZOt
	 HWgGy4MxTOEDd07eG4QfLdWSUcmgEBczhmm/0hCugOBM4b/C39KArIha8CwRXSDr3q
	 uVh/O1Z1LDPGg==
Date: Mon, 13 Jan 2025 08:24:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: fix kernel-doc warnings
Message-ID: <Z4VaZB5VkwzCG_va@slm.duckdns.org>
References: <20250111063136.910862-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111063136.910862-1-rdunlap@infradead.org>

On Fri, Jan 10, 2025 at 10:31:36PM -0800, Randy Dunlap wrote:
> Use the correct function parameter names and function names.
> Use the correct kernel-doc comment format for struct sched_ext_ops
> to eliminate a bunch of warnings.

Applied to sched_ext/for-6.14.

Thanks.

-- 
tejun

