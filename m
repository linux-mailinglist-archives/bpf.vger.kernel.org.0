Return-Path: <bpf+bounces-72714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66A2C19DCC
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 11:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5261D1CC2124
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751633507B;
	Wed, 29 Oct 2025 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyzysFL+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2E3115BD
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734437; cv=none; b=gxWr1VRxpFpKipFAvoA4tCvwKg9N9SGiw/mKPh9lBu+w4QqkyRfCDEfwsItBkw/msC/HeZ+XljJw+Bs2AqxbK27s9IWk5OYWFllx+Ot79BL+cMXRa/0n3kJXmjGY6VHXQk7VAjR8bbmXEDYdy+8JMCQCgUWcRb28b6W5nEwzb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734437; c=relaxed/simple;
	bh=aK7R54AWyZUMIiJpnPGJaMZtAjTA4T4B+xQ5JFJuAYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLzv3aPLiCCh9KpyqZhCXr0X4PzVkMrQPyIccGYe7GP7ZtzHZm6G/aTe0yp4zp+WTHFt0/OcnSTbGIB3ZUyvqGGW4z8j12MA6gTPbXAtR4k3joWzJ7nqT9UiAnIXFeU3CUQmwBfoz9kR6fX+346DUEaQjEhtBX6uMTe7rkrcmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyzysFL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A7EC4CEFD;
	Wed, 29 Oct 2025 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761734436;
	bh=aK7R54AWyZUMIiJpnPGJaMZtAjTA4T4B+xQ5JFJuAYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jyzysFL+u5offpLB7AL2riprKVxVjKxLx8mPjo9mc20K+98HmfwEVzrKHvgOLNwEK
	 3FsneCunBkf5tfH+LZoFCLPJSdCq7Qhm8zmlCLNbgXd8PdLQi2cIPFTGmeQkl8V0Eg
	 +vNqrtpyK4fmhGa+G/4L4k8vDzLOdAEYQhmCL21EWIoltz8mLiqCAUwLzBZ4qMkb0n
	 oJrXXJpu214uWwq9BzWqef8h5eXiScZ/MMJ4k5EbnIQp0SRJfBENI4mWQTvnneG3hV
	 h9IB7EWH8qS0c1boAlpUN0JMneD2pIyfNz+u1X9GjLST/bbUI1BLNW3+ePZVDKnA3N
	 aINBs/OCiwKHw==
Message-ID: <fb2fd1cd-239d-4783-8b24-66af0e754a47@kernel.org>
Date: Wed, 29 Oct 2025 11:40:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 2/2] bpftool: Use libcrypto feature test to
 optionally support signing
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, terrelln@fb.com,
 dsterba@suse.com, acme@redhat.com, irogers@google.com, leo.yan@arm.com,
 namhyung@kernel.org, tglozar@redhat.com, blakejones@google.com,
 yuzhuo@google.com, charlie@rivosinc.com, ebiggers@kernel.org,
 bpf@vger.kernel.org
References: <20251029094631.1387011-1-alan.maguire@oracle.com>
 <20251029094631.1387011-3-alan.maguire@oracle.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20251029094631.1387011-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-10-29 09:46 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
> New libcrypto test verifies presence of openssl3 needed for BPF
> signing; use that feature to conditionally compile signing-related
> code so bpftool build will not break in the absence of libcrypto v3.


Hi Alan, thanks for this work!


> 
> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> Suggested-by: Quentin Monnet <qmo@kernel.org>


This is not exactly what I suggested, I mentioned adding such a feature
check and printing a more user-friendly error message at build time if
the dependency is missing, not leaving out the program signing feature.

I've got reservations about the current approach: my concern is that
people packaging bpftool may prefer to compile and ship it without
program signing, if their build environment does not include the OpenSSL
dependency. But it seems to me that it will be an important feature
going forward, and that bpftool should ship with it.

Regarding the OpenSSL v3 vs. older version concern (from the build
failure report thread):

> One issue here is that some distros package openssl v3 such that the
> #include files are in /usr/include/openssl3 and libraries in
> /usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
> figure out a feature test that handles that too?

In that case, we should have a feature probe that gives us the right
build parameters to ensure that v3, and not some older version, is
picked when building bpftool? (We could imagine falling back to an older
version, but I see v3.0 is now the oldest OpenSSL supported version so
it's probably not worth it?)

Best regards,
Quentin

