Return-Path: <bpf+bounces-30600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3788CF09A
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2D8B20FBA
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C624127B7A;
	Sat, 25 May 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbiZeKhk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894581272CA
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659433; cv=none; b=cIm3LZOigg/12NLJDabCOq40BRbExi8oCUkzJkNcweh/ml9n2630BD5UEF20ghy5t2CO+S/Ci9XTPmDNG7lq1j4xm4ywr4VFzNKXYuiEM7gqucB3kU2nDBjg0kKVUYiVhqmvWoLrNw/rJoazszWVX+peiWO+5gTrhF8cVI2DOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659433; c=relaxed/simple;
	bh=+ktR1nHQEAC2KI1WA5Mxdglcfwp9LwIfb5PqDUUBb7k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZObNw5uUCOWlCQmxL/9C7PrGEhWSdtRW/ojjhqI4I+6fkshkv9m2hE0/cwTfPeRf0uNaFIwRVk9AcnCUO6ttgFJ2Bc1eqlFu9v8unzh7/hJKcAaM+GDWKlL1GEsQptHfabb8V864V979yvlYW5bQXkvyF1V+HvAbHVQOGc32L44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbiZeKhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E5C4C4AF0D;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659433;
	bh=+ktR1nHQEAC2KI1WA5Mxdglcfwp9LwIfb5PqDUUBb7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IbiZeKhk+DsEjmIPw3xm9YqhwcxN5Gd3prqPGH4gVNe8TlI0qqZSuESNy2L5BQfGt
	 3a6UaiXuPmj4oOkW4M7OPCzjEIq1PUwKyzgUrRl0A0S5pNslOyYvAas8jw5Vv6oFHf
	 DUD1Lyevzjbafb7E5pXRFr61tpAqjjFWS+/4bsiI+2O39UvtrfJtiD4+i7ZTq6XMZd
	 kUXtTgDriOZQJhaALDRJ7zZPZuI+oldnddp9A9c8XeuWlhmpqHaaqogrmdBC3EbDJs
	 eg10vN9Y2JncjHrsF7xrrlShw/Y4OPQLYDG9U3zU+iHO3BM5emdGuQv2Yfitf53gMd
	 HPHqF9Qecfu4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 326AFC43617;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: Use RFC 2119 language for ISA requirements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171665943320.11416.15306710552463401207.git-patchwork-notify@kernel.org>
Date: Sat, 25 May 2024 17:50:33 +0000
References: <20240517165855.4688-1-dthaler1968@gmail.com>
In-Reply-To: <20240517165855.4688-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 May 2024 09:58:55 -0700 you wrote:
> Per IETF convention and discussion at LSF/MM/BPF, use MUST etc.
> keywords as requested by IETF Area Director review.  Also as
> requested, indicate that documenting BTF is out of scope of this
> document and will be covered by a separate IETF specification.
> 
> Added paragraph about the terminology that is required IETF boilerplate
> and must be worded exactly as such.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Use RFC 2119 language for ISA requirements
    https://git.kernel.org/bpf/bpf-next/c/a985fdca5e7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



