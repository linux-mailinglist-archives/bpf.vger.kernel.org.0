Return-Path: <bpf+bounces-60390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C8AD615D
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD0C3AB668
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD21723AB81;
	Wed, 11 Jun 2025 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="NnK48SlU"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF191C8632;
	Wed, 11 Jun 2025 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677555; cv=none; b=YvQfQjvbCYWfspTo8qSvvP1GKy3pceN1zDqmoIobcwWMaWzpJrR7Q+SfnjjWwDLrsGQ9iQuaUZKI7W8Q3+M+JW+Bl6th8JsqWVR0hig6bQftrDiJK2TORit1kFN9kjL80Au1ta5Wg6oGB+l11t8vUFIDZjfkI4qZ7H0+lx12SLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677555; c=relaxed/simple;
	bh=M20sO39sYxTyK6D5pEluUSUaJR341uYSo1s7urocdwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbft2g+yy0+QZNJU4CSVyWJBT2KIj85B53PlE6SL/TeVmIVLGPIUQrBaJzu6OChxQ/PtuA1SrUlZ/ViYXljl04dMnDTyBalbgB82era8s4xoyoadQFy8VUBVV74zASg27dUWyOSeOE0hesmwqwZ9Z7KNLf360OyOIu9M5AzLxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=NnK48SlU; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1749677549; bh=aIbK56pMyMT9UiC8X8/dnyzVoOnjpQYtsfIzj6mxIDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=NnK48SlUlQlylM+/e43Ujl8MpND5H8bvnmIs1S6cvafFIQW5pF4fowpyH9fQy0l/0
	 y2oyDhrYqwXuyPfO8JuddZQp+KtDCQXcUWq3FwDs1R53ydDdus0Yndob2xX2K0G8xx
	 cHO/zTg9kU+vLkUSgK9GYjvf3/AIjYP9CFu2wFPnIRzH1Z9EpbHvGMjJ7TredeEKb2
	 RcDbznFaFODfnPt7dYBwDI1REQKXx7eGUEAN6mXlvQIQiD1Yi8v3jPQFgKxImOMDgy
	 Axke7jyxnm7lcWBKbNrRKhdvIjskRFe8R8EU9f7d3l8VZu7dVyMCpoD20xRTHF7V0I
	 K/RDlxO3jqq6A==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bHf594DHnz1y9M;
	Wed, 11 Jun 2025 23:32:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3626:500:39da:8819:39bd:1255
Received: from localhost (unknown [IPv6:2001:9e8:3626:500:39da:8819:39bd:1255])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18QGhsARh+4uVnCO71vtG3f9XgeRQIcBgU=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bHf563dxCz1y8r;
	Wed, 11 Jun 2025 23:32:26 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org,  ast@kernel.org,  bpf@vger.kernel.org,
  daniel@iogearbox.net,  haoluo@google.com,  john.fastabend@gmail.com,
  jolsa@kernel.org,  kpsingh@kernel.org,  linux-kernel@vger.kernel.org,
  martin.lau@linux.dev,  sdf@fomichev.me,  song@kernel.org,
  syzkaller-bugs@googlegroups.com,  yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in do_check
In-Reply-To: <b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com>
	(Eduard Zingerman's message of "Wed, 11 Jun 2025 10:20:40 -0700")
References: <68497853.050a0220.33aa0e.036a.GAE@google.com>
	<38862a832b91382cddb083dddd92643bed0723b8.camel@gmail.com>
	<87frg6gysw.fsf@fau.de>
	<b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 11 Jun 2025 23:32:25 +0200
Message-ID: <87plfa3qxi.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Wed, 2025-06-11 at 16:03 +0200, Luis Gerhorst wrote:
>> Eduard Zingerman <eddyz87@gmail.com> writes:
>> 
>> > Either 'state = env->cur_state' is needed after 'do_check_insn()' or
>> > error path should not free env->cur_state (seems logical).

[...]

>> The latter might also be possible, but I guess it would require more
>> significant changes.
>
> do_check_common() has the following logic:
>
>    out:
>          /* check for NULL is necessary, since cur_state can be freed inside                                                                                                                                                                                                                           
>           * do_check() under memory pressure.                                                                                                                                                                                                                                                          
>           */
>          if (env->cur_state) {
>                  free_verifier_state(state: env->cur_state, free_self: true);
>                  env->cur_state = NULL;
>          }
>          while (!pop_stack(env, prev_insn_idx: NULL, insn_idx: NULL, pop_log: false));
>          if (!ret && pop_log)
>                  bpf_vlog_reset(log: &env->log, new_pos: 0);
>          free_states(env);
>          return ret;
>
> Same cleanup cycles are done in push_stack() and push_async_cb(),
> both functions are only reachable from do_check_common() via
> do_check() -> do_check_insn().
>
> Hence, I think that cur state should not be freed in push_*()
> functions and pop_stack() loop there is not needed.

Ah, yes I agree. I sent a patch separate from the fix [2].

>> state->speculative does not make sense if the error path of push_stack()
>> ran. In that case, `state->speculative &&
>> error_recoverable_with_nospec(err)` as a whole should already never
>> evaluate to true (because all cases where push_stack() fails also return
>> a non-recoverable error -ENOMEM/-EFAULT).

I noticed the was not really true yet, I had to fix the call for
sanitize_ptr_alu() to return -ENOMEM while [3] is not landed yet.

>> Alternatively to adding `state = env->cur_state` and `state &&`, turning
>> the check around would avoid the use-after-free. However, I think your
>> idea is better because it is more explicit compared to this:
>> 
>> 	if (error_recoverable_with_nospec(err) && state->speculative) ...
>> 
>> Does this make sense to you? If yes I can send the fix later today.
>
> I think this flip makes perfect sense and should be done.

I sent the fix [1], let me know if it is as desired.

[1] https://lore.kernel.org/all/20250611210728.266563-1-luis.gerhorst@fau.de/
[2] https://lore.kernel.org/all/20250611211431.275731-1-luis.gerhorst@fau.de/
[3] https://lore.kernel.org/all/20250603213232.339242-1-luis.gerhorst@fau.de/

