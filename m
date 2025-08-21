Return-Path: <bpf+bounces-66253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF0B302D2
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 21:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70EBC1BC52F5
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C6E34AB00;
	Thu, 21 Aug 2025 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="e89V9QoO"
X-Original-To: bpf@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BDF1D2F42;
	Thu, 21 Aug 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804153; cv=none; b=WVXUyYGVr130XPz4RtbcgAtN4hdtxk3WF4Ldo+BW0tuE2RvZPQi4RX26CnbSk8QjX/DHs4pJyEIOjh7Ygeu6nkz0HuLNvQt0oOIYSVwhCRjrtFmwmI2/QxeRHTcwgQRYZKELbYEz8zbr2smoZxrk2pjvbQAFnFFmaSLJtBfKfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804153; c=relaxed/simple;
	bh=eqpxT8Akg9rcLVQcFKQxNoaLgF9UucXwjbEfd9RDP3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZabZ+9juvwGn7nDAdUwhmiJUo0DSBK35P57cTiMR/WK0V1ymQzBGWBkNmGroWoXP542ppQ13VE5WvIcmbB9HHJj8Cp3cr9qweHrYXNJ+KCetpDTgutsXv7y0k+pREnOBAZyTbtuKcKVUhkAfm23jpgPTADWak6XMr8p0Unkf4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=e89V9QoO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 56A4D40AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755804150; bh=eqpxT8Akg9rcLVQcFKQxNoaLgF9UucXwjbEfd9RDP3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=e89V9QoONR1oGXET/xBFAg5fplIG8liCmjMcP5AA0rKkcivqA/AUGgG4GZZ7SiENJ
	 ylA5e1x7t2JV5bmZtfqLhNRAQmU7875IecbxlNEkZbLrWPs7f670RF4fNW9dDt58fO
	 ddus703JdI239uRnXhsd38ZUpC1+TCCyP0ddHEUmNOO9md7QlxAqnXup/0HljaLAXX
	 /FJXeLHlG6vxK3CTjnkvFFMTuCi6Y7zZJHWJ3TOBVt/Sb2wfvb20sY1zf4nHzdtjtD
	 ySl4oTXy/uH0kXmh7nIMJmx4guqcM/0L5D0+l1tJUgZMxvhbvgTkVoH55Dmx/9l6Qf
	 2Y9WchpEPswQA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 56A4D40AD5;
	Thu, 21 Aug 2025 19:22:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Andreas Hindborg <mchehab+huawei@kernel.org>,
 Benno Lossin <mchehab+huawei@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Danilo Krummrich <mchehab+huawei@kernel.org>, Gary
 Guo <gary@garyguo.net>, Miguel Ojeda <mchehab+huawei@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, bpf@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Fix PDF doc builds on major distros
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
Date: Thu, 21 Aug 2025 13:22:29 -0600
Message-ID: <87zfbs5vka.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> Here it is the second version of the PDF series. I opted to split one of
> the patches in 3, to have a clearer changelog and description.

OK, in the hopes of pushing through some of this stuff, I have gone
ahead and applied this set; if things need tweaking, we can tweak in the
coming weeks.

Thanks,

jon

