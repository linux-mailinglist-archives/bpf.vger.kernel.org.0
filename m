Return-Path: <bpf+bounces-52915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF8A4A521
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561A13A676A
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37A51D8E12;
	Fri, 28 Feb 2025 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEg1816w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD723F38A;
	Fri, 28 Feb 2025 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778634; cv=none; b=AsHVhLMPBKG0K5A7BO6FiIHTSUxR53cNmoHMd6jPKz/cQIoLGSLxIeWTIFGU1pEJp7oHsWot1ow37XSRRV3acRaelNYUas6Tq3ZTbw+POLOXd5WOcP6TDugZertYfleCarBmA2yxOsdBNEGXHvS4XmhOZs4lb3Jfkiev5EO3gC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778634; c=relaxed/simple;
	bh=ZhhF66IDytc7d+VK5dX8uguB4k3kmoyARZcxaJrdIlY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IHpD1LR9JagOoNwMEj5kNyUyjz/cbSvBPvmZ4oS30cjwP/XABWiSCw6OgllEbKqJ4XTO4lFd/X2ORDpBrjJyx04z1YkuiC4xrCjfsE1uIoObDD37Uyz2kD0IIF3J4gGdF1hX+1QszJ3Urp8bXbJs5cUsxw8RgrKfbez8fnL9rdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEg1816w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554DCC4CED6;
	Fri, 28 Feb 2025 21:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740778633;
	bh=ZhhF66IDytc7d+VK5dX8uguB4k3kmoyARZcxaJrdIlY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=XEg1816wbeBUPBhSFNZiRo0EX1R4RVoGD4CxES+eRJGks2vzwpG3GLsSX+94m9ttI
	 zkeGcLtObhB7WsF9pe8ZZMtnEEJaCLkmHBKm7bHRw3QhHgs+UaE5qXIxcphEo0nQYI
	 ZXR4LWbNTBkqztIzSSxPRhtQX9ZmIkW5fLb75yuFGrTanj2G2HnRT9F3u7osxT8vko
	 5UFyr28wrg73kuWUMebpgcZQbjZpjEgGnJjV4x/BqwmtQxN/pr10jVGrFQh8uS41mU
	 PQTOCIVWIWs/1VYYlmLpIlGcXA0TqN+iI5zkipg2dGsT2AmvtkZNVH7jXYMPe+FCxK
	 6SRAjf8JgT3QA==
Message-ID: <cb862288-51be-443e-b770-ed2273978daa@kernel.org>
Date: Fri, 28 Feb 2025 21:37:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH] bpftool: Replace strncpy with strscpy
To: Michael Estner <michaelestner@web.de>, ast@kernel.org,
 daniel@iogearbox.net
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250228181827.90436-1-michaelestner@web.de>
Content-Language: en-GB
In-Reply-To: <20250228181827.90436-1-michaelestner@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-02-28 19:18 UTC+0100 ~ Michael Estner <michaelestner@web.de>
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy() instead and remove the manual NUL-termination.
> 
> Compile-tested only.


How? The change does _not_ compile in my case:

	$ cd tool/bpf/bpftool
	$ make -j
	[...]
	/usr/bin/ld: xlated_dumper.o: in function `print_insn_json':
	xlated_dumper.c:(.text+0x1f6): undefined reference to `strscpy'
	collect2: error: ld returned 1 exit status
	make: *** [Makefile:254: bpftool] Error 1

(Besides, this code should be rather easy to test, so running it is
appreciated.)

strscpy() has been proposed for bpftool a few times in the past, but
bpftool is a user space utility and does not currently #include header
linux/string.h. If we wanted to use strscpy(), we'd likely need to use
this header, and also to copy the definition of the function to the
GitHub mirror. Given that - as far as I know - the current use of
strncpy() is not broken, I'm not sure this is worth the effort.


> Link: https://github.com/KSPP/linux/issues/90


I note that this Issue provides a command for looking for strncpy()
instances to replace, but this command filters out occurrences that are
under tools/:

	"git grep ... | grep -vE '^(Documentation|tools|...) ..."

Thanks,
Quentin

