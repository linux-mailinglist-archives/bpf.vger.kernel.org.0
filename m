Return-Path: <bpf+bounces-51169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07949A3139D
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 18:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60751679A5
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40681E32D6;
	Tue, 11 Feb 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C67pVyZB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B459261564;
	Tue, 11 Feb 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296713; cv=none; b=ZiBoF2vVshVk/eP56yIm8m5RT/p0uWtAjqYgTibd/h9b5jrRA5I9Q1Q5eRB47VpCvD/71qclMWxdT+hRnbSEyCQCcKiiVIE0kC6P7nWSEavsnONLDcUY+egEDUBP8hU+9EIE6CCXKJRWIwKThqga5vot2p9tAPnYoK5hY+rCVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296713; c=relaxed/simple;
	bh=bRERXSicUMrVh0dCJtwXiFjKT0CmQHRa5YGEfmVl990=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/q4Ismnjv8fsZWljeKo6J9xNtbP6JZmoCR61jXXPWzxVA6pg9fCjf0QpZhFR0pvQUKVue7uZ0jLDB2wGh3v2HRfKtVYLGSxi8DDP0wZOLyrCw8Vo1Dc5IyjKNPdc1NopOhOJAks+TgptiXQYa2H4TnCOg2H/Qaua4psRt2yGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C67pVyZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE46C4CEDD;
	Tue, 11 Feb 2025 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739296712;
	bh=bRERXSicUMrVh0dCJtwXiFjKT0CmQHRa5YGEfmVl990=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C67pVyZBZZTgua8Pq5LsqsoVuyCJfFs0i0ur+JMvhHSAf6/tX+wbW5N+ycWBAda/x
	 ZYiVSX8BqoZyfF52FxEUsE8Jy2MErltm3xPx4RdMDU3DzGs+8IW2iUHyZJjsoSINtU
	 YWbzhQneoTTyJd/xPtl0v6QfFNzRgoAM4gwvYnyuyoNFOYiIy1dU2sUTrNJfuUttMv
	 VnUbhiSTM93mAlZgxmkW/L7LenZY42+GOPvWxjyOKn+hpAlSeRedBgHcaI5p43kuVu
	 dl1yvVai6zAhi4+x9q1Rke4JsX1vH9utgf/aaT/Ir3MjLB3FT8a9zBQVcuJbOecG7N
	 Ux8LuJHfwIUMA==
Date: Tue, 11 Feb 2025 09:58:32 -0800
From: Kees Cook <kees@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, bpf@vger.kernel.org,
	llvm@lists.linux.dev, workflows@vger.kernel.org
Subject: Re: [PATCH 0/4] Raise the bar with regards to Python and Sphinx
 requirements
Message-ID: <202502110954.31FD25D8A7@keescook>
References: <cover.1739254187.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739254187.git.mchehab+huawei@kernel.org>

On Tue, Feb 11, 2025 at 07:19:00AM +0100, Mauro Carvalho Chehab wrote:
> This series  increases the minimal requirements for Sphinx and Python, and
> drop some backward-compatible code from Sphinx extension.
> 
> Looking at Sphinx release dates:
> 
> 	Release 2.4.0 (released Feb 09, 2020)
> 	Release 2.4.4 (released Mar 05, 2020) (current minimal requirement)
> 	Release 3.4.0 (released Dec 20, 2020)
> 	Release 3.4.3 (released Jan 08, 2021)
> 
> 	(https://www.sphinx-doc.org/en/master/changes/index.html)

(And those are positively ancient versions, too! 8.1.3 is current...)

> And Python release dates, we have:
> 
> 	Python	Release date 
> 	3.5	2015-09-13    (current minimal requirement)
> 	3.6	2016-12-23
> 	3.7 	2018-06-27
> 	3.8 	2019-10-14
> 	3.9 	2020-10-05
> 	3.10	2021-10-04
> 
> 	(according with https://en.wikipedia.org/w/index.php?title=History_of_Python)
> 
> The new minimal requirements are now compatible with the toolset available on Jan, 2021,
> e.g.:
> 	- Sphinx 3.4.3;
> 	- Python 3.9

I just did a quick sanity check against Ubuntu releases, and it all
looks fine: Ubuntu 20.04 had sphinx 1.8.5, so it already can't build the
docs. Ubuntu 22.04 has sphinx 4.3.2, so all good. Ubuntu 22.04 also has
Python 3.10, so also okay.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

