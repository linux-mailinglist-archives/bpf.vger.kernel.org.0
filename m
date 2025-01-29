Return-Path: <bpf+bounces-50031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2B9A220AE
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2408F3A8401
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 15:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B589D1DED62;
	Wed, 29 Jan 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU7xY1/z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2101DDC3A;
	Wed, 29 Jan 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165325; cv=none; b=t8BjAEIdA8K95Se/NUwzpFLs+9h2aMZ7jqTQvN21+vgBeqSToWhMKixv+2g3JiYGsGE8Dc91uUvrs7RFwgM0w5M9lKeSHO5RQ056fqAfDlsJExiobbIrzmg4gtTn7q2nZuaCMLcwjBfaDl7H6Pm7x3ihwmHcyxT392NFar5SejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165325; c=relaxed/simple;
	bh=GplWvWETMezm9d36v4eAfoqt/au1TivnkJ+SWeO2lSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nULorQv0YZ4GmJqK4IZzAGWTY1rBkCK+jAwubyKpSI91jLOlKnEOTEnd9dbZ+rvdq73BINCO5avupZfV9gmdPcrnqMn/A9wGAS9Ve9x04q6aYFHex8s4VBAz/s3flI9FM0lSJXGtt+Ui3dPN1VHeINx2+HOiWe3lwSKfaA9b/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU7xY1/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60928C4CED1;
	Wed, 29 Jan 2025 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738165324;
	bh=GplWvWETMezm9d36v4eAfoqt/au1TivnkJ+SWeO2lSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aU7xY1/zYzJuaW6w9rNm1ubl5Xt+CWFtHsWN2RKDfRYDVbS6hoIF9qvqRPP/jdC+o
	 n9sc28S2gI6BwQGNNkViJtfEuGMgf8yXViqR0bVptbi1JGdt4uZpDL3rC+zLYdD2R2
	 LvRr+oYrBTHfe0N1TI7nLfb3oLUOcNMk6jlIoAg5MOCpNzo+MotUd8JaUv3wKoon4l
	 tuVdgnNv0djOjt6DKfIc7gmEm0g5OKUWFx4Yfktshh9bhs5uK1rRKp5QLYBX+v7URg
	 lc1VdYMtw06mrr+76GOR28iAJW7U2ehBlI2qXh9oSISs4oV4/EZifWpzvEERxf1Lkt
	 yXZsdTh95S+vg==
Date: Wed, 29 Jan 2025 16:41:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-hardening@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [RFC v2 00/38] Improve ABI documentation generation
Message-ID: <20250129164157.3c7c072d@foz.lan>
In-Reply-To: <87h65i7e87.fsf@trenco.lwn.net>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
	<87h65i7e87.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 28 Jan 2025 15:42:00 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> [It's probably time to raise our minimum version again, especially now
> that current Sphinx has better performance.]

Last change was about one year ago, so it sounds fair to also
change Sphinx minimal version with about one year gap. What we have
currently is:

	2.4.4: minimal version
	3.4.3: suggested minimal version.

Looking at the relevant release dates, we have:

	Release 2.4.0 (released Feb 09, 2020)
	Release 2.4.4 (released Mar 05, 2020)
	Release 3.4.0 (released Dec 20, 2020)
	Release 3.4.3 (released Jan 08, 2021)

So, the ~one year gap is what it takes to raise the bar from 2.4.4 to
3.4.3.

In terms of Python, we're currently at 3.5:

	Python	Release date 
	3.5	2015-09-13
	3.6	2016-12-23
	3.7 	2018-06-27
	3.8 	2019-10-14
	3.9 	2020-10-05
	3.10	2021-10-04

	(according with https://en.wikipedia.org/w/index.php?title=History_of_Python) 

Python 3.6 is the first one with f-string support, with is something
that most Python programmers use those days. So, IMO, that would
be the absolute minimal version we should pick.

Yet, IMHO, we should aim to be backard-compatible with the tools 
available up to a certain date (Jan, 2021) - e. g. we'll aim to
support at least a 4 years old toolset for documentation build.

So, I'm proposing to change the minimal requirements to:
	- Sphinx 3.4.3;
	- Python 3.9

By setting Sphinx minimal version to 3.4.3, we can get rid of all
Sphinx backward-compatible code.

I have already patches with such changes for it on the top of this RFC. 
Will send it shortly as RFC, aiming to send the final version after -rc1.

Thanks,
Mauro

