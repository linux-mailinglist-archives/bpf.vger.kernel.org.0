Return-Path: <bpf+bounces-68703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D653B81A87
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B82A7ADF24
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96382FC006;
	Wed, 17 Sep 2025 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV5ozcF8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510882727ED
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137819; cv=none; b=P7W9LQCzhvjFXxWfdF1U+lOx/gtoO6NGewsVplYahZjOeISE+qSiuSIqvCBzUfujmXbnIda34AQAyobY232SD17M7PmVefv8CThT+AvV1e/JkKBANqXN5kwSFoHf+rjGAHR3zqH1f4ftgCao3JkwujC9GXmw81TuRrPrLTi8v+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137819; c=relaxed/simple;
	bh=oAJwPds5TjYR2WgVnIvkCDhLWomINm9ymYWSQwoGz0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=czITjOlXtvi7v27kJDD92/2jY5xL5fjdtTk0rch1p0EJ0Gpi9SdU4e7cdnwdoUkfRn4wCINbFggf6PJJnztcpVgm7zM87CtlyJHEzAkBSxgH2uPfRG9Qp3NHCVV24Zs+/oISidw67M/2lQsuI6QpgHtQZC7oiIuK6NlGENp0Uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV5ozcF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F57C4CEE7;
	Wed, 17 Sep 2025 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137818;
	bh=oAJwPds5TjYR2WgVnIvkCDhLWomINm9ymYWSQwoGz0c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HV5ozcF8zW3sK9NeYs8YPS/2EfPtpHen2letfMn1kD2r1+Mcr4Bc+e23BWNxhpyrY
	 xQmS42Ha8gMS8AGToekQ7QWzXYW5ykm0nW8H+qwd/Iw/otW9GuGz22M9hwNkXvjBJ6
	 2PL8BnEvo1F2M9NBQCKgnaF6qQrvwEhCKrLG1Cv+LEdPXzdEkK3Y7kSQ+EYBKdHQs+
	 qINRoFNrAmLlw/odSAxp9N6AAQuHlMTve9WERmvI7ofj38QtIF1Bah9BnkOdnH6MFO
	 WkZLfLtpr9u6isThV0ZN/Fv3HEL4RMIBAkUKGEa5V8L7MAWm+OlCgXm0twgnzk448B
	 BCkpESxfbBXMA==
Message-ID: <4137d2f8-abcf-4b8c-be7b-fc271dd7a1e8@kernel.org>
Date: Wed, 17 Sep 2025 20:36:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix -Wuninitialized-const-pointer warnings with
 clang >= 21 v2
To: Tom Stellard <tstellar@redhat.com>, bpf@vger.kernel.org
References: <7949d9ee-b463-4fd4-830e-0bb74fb5b2a0@kernel.org>
 <20250917183847.318163-1-tstellar@redhat.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250917183847.318163-1-tstellar@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-17 11:38 UTC-0700 ~ Tom Stellard <tstellar@redhat.com>
> This fixes the build with -Werror -Wall.
> 
> btf_dumper.c:71:31: error: variable 'finfo' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>    71 |         info.func_info = ptr_to_u64(&finfo);
>       |                                      ^~~~~
> 
> prog.c:2294:31: error: variable 'func_info' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>  2294 |         info.func_info = ptr_to_u64(&func_info);
>       |
> 
> v2:
>   - Initialize instead of using memset.
> 
> Signed-off-by: Tom Stellard <tstellar@redhat.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!

Suggestion for next time, the "v2" should go in the prefix of your
email's subject ("[PATCH bpf-next v2] bpftool: ..."), or it risks ending
up in the commit title. But no need to resend for that.

Quentin

