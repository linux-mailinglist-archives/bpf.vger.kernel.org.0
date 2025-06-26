Return-Path: <bpf+bounces-61663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D5AE9DC2
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 14:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E067A7B9E
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85182E11C0;
	Thu, 26 Jun 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="ldwkp6zn"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9A381AF
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941941; cv=none; b=POxER2R8fVuvPqhRJH5TAQ7fLBO/L7TtiMHquJgULBqpnMINrlgH8P47Iu1NQ4keW9mDHbvkq/jUJZ9jH+EKkz0pYXMqU4UcUrkaiB4yKzYNAXgmTlZiz0akCK/UQ0JKBynY7XqRr7/I5/nach+H0Pd7ofIwI+n0f/VwPowxLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941941; c=relaxed/simple;
	bh=7n8+uYe/ceiW2gcaLB+F/kHTPcMCFhbyFOOsnzeulUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fGxow4f/Yufcz3ZA8W37sVilr2NCTqtaq2YbMv/nqG7+gIdwbjnN3k8RIpgvoY2rAgMm9ZPmSLZvHe/HKtZw00eQtTr4phP0SSDjo7rdnEohImrBYJi+T6FUNFUWZ9LIAk7jckjmsDNteXKkT2CIzk1+RzGziRzIzlbOibtvkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=ldwkp6zn; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1750941929; bh=yBxmstZH2zOZFR9uSZYoAFbaQ1tLOkQyFz9QbROtdiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=ldwkp6znaM3O8Dh/Dz6+t4ml+J92J4GV0ANgZxvaCYnM6U85w643fvvDRFIfxbGyT
	 YkArLlF5Hhy9eLIqF5zW/H2EzLqDUjtcHVLKxF4Q3B0Ga3s5u+WerkMp0O++qtwP+7
	 CPtQ7wR2pDYDeifA8pm4QO6eC7SIE8FM6U4VuaYEW7VT79stONYyXdV7YCgL19U2Si
	 fxEzyu1FDBFP5krTshTOaDdAf6tg7LexLdRFBrLMUTkdu8CWVvRmNcU/l/rSrw2iHQ
	 nF382giviA7xGM4xgoLyQmbOWatCFewKzIaCq7qNc7wPKdIypp0Zoyf3L5p7TvWfkX
	 pKVBXEigtaWqg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bSdh94K5Rz8vpk;
	Thu, 26 Jun 2025 14:45:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from localhost (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+35OPY8lkn57l3OTWP46M8UjaXrubzJME=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bSdh657Sdz8vpN;
	Thu, 26 Jun 2025 14:45:26 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>,  bpf@vger.kernel.org,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Fix unwarranted warning on speculative path
In-Reply-To: <4266fd5de04092aa4971cbef14f1b4b96961f432.camel@gmail.com>
	(Eduard Zingerman's message of "Wed, 25 Jun 2025 15:13:27 -0700")
References: <aFw5ha9TAf84MUdR@mail.gmail.com>
	<402ecbeabdd090b81ae35d2187c344779ff926c7.camel@gmail.com>
	<aFxtazVRQQzhgfmO@mail.gmail.com>
	<4266fd5de04092aa4971cbef14f1b4b96961f432.camel@gmail.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Thu, 26 Jun 2025 14:45:26 +0200
Message-ID: <8734bmoemx.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Wed, 2025-06-25 at 23:43 +0200, Paul Chaignon wrote:
>
> [...]
>
>> > So, suppose there is a program:
>> > 
>> >      15: (18) r1 = 0x2020200005642020
>> >      17: (7b) *(u64 *)(r10 -264) = r1
>> > 
>> > Insn processing sequence would look like (starting from 15):
>> > - prev_insn_idx <- 15
>> > - do_check_insn()
>> >   - env->insn_idx <- 17
>> > - prev_insn_idx <- 17
>> > - do_check_insn():
>> >   - nospec_result <- true
>> >   - env->insn_idx <- 18
>> > - state->speculative && cur_aux(env)->nospec_result == true:
>> >   - WARN_ON_ONCE(18 != 17 + 1) // no warning
>> > 
>> > What do I miss?
>> 
>> In the if condition, "cur_aux(env)" points to the aux data of the next
>> instruction (#17 here) because we incremented "insn_idx" in
>> do_check_insn(). In my fix, "insn" points to the previous instruction
>> because we retrieved it before calling do_check_insn().
>> 
>> Therefore, the processing sequence would look like:
>> - prev_insn_idx <- 15
>> - do_check_insn()
>>   - env->insn_idx <- 17
>> - state->speculative && cur_aux(env)->nospec_result == true:
>>   - WARN_ON_ONCE(17 != 15 + 1) // warning
>
> I'm sorry, I'm a bit slow today (well, maybe not only today).
> Isn't it a slightly different bug in the original check?
> Suppose current insn is ST/STX that do_check_insn() marked as
> nospec_result. I think the intent was to stop branch processing right
> at that point, as nospec instruction would be inserted after this
> store => no need to speculate further.
> In other words, cur_aux(env)->nospec_result pointing to instruction
> after ST/STX was not anticipated. (Luis, wdyt?)

That's a very good point, nospec_result should only stop the path
analysis after the insn that has it set was analyzed. Otherwise, a
nospec required before the insn may not be added.

In reply to this you find a RFC fix and test that shows a nospec might
be missing. If this makes sense I will send a polished version.

The tests fail without the fix [1] (the offset no longer matches because
the nospec before the stack-write is missing, which is the main point),
but succeed otherwise [2].

I manually verified the fix resolves the warning in the reproducer, but
I can add a test for the polished version.

[1] https://github.com/kernel-patches/bpf/actions/runs/15901586938/job/44846011518?pr=9199#step:5:11308
[2] https://github.com/kernel-patches/bpf/pull/9198

