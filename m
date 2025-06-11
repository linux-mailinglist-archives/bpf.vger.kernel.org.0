Return-Path: <bpf+bounces-60325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F1AD5847
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCB6188D90E
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4164295502;
	Wed, 11 Jun 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="jrbUQog9"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6AA2253E8;
	Wed, 11 Jun 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651249; cv=none; b=GkJCdrWcYH28p03TdeMRqqUbKhYpZxJ6kS0+o/eU+n5RJUV1gnM7ttgH/sfXcM8rlu04xtfuFxlO+KVesj2xXfT5LJyqci85QoQtzcspYy/QgJ+qC0iiZLyZlCv8dqNzKiORve8NGnrBuPJm6mpYAkq7pe3rhs0jcokZT0owZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651249; c=relaxed/simple;
	bh=jwlEb9ApPh5TY4JhPoXeYC7ccEQS1p8l4dqq+cESvoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JxhSGbd9GDsAZP6jhC424pfaq1+zPIG/9zSsSJjNPVu8p7StKXzOEyEJxo78DJ1Gqo/OkULAbYafD9MibSbmdCNGcDvpUPlCuooS1DeWJSC/zGtPeYqcbEaodziMMCz+vdMxEYvt/Xa6Bd0UDjvqfpMtZPCAgI5/yc3emHU1+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=jrbUQog9; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1749650643; bh=DmSXTFFqNu+tSRSDtP3K415illKbtXwDagR+sb8PWSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=jrbUQog9z+HQ/Dp8kigG9nQddbldTgzkGJpnK8R3LEp5sueblPULIGXu3rrBgx9V2
	 /Ex8J3jFh9zxcEQIvyUH/XBELAgpzRmq51NcyqHgig4FQ74Smm5FlkuVQluwfheuuF
	 4GfQ5THwT8Y5W1K5HW28bEKB7WXozWULCD6QGJONSNrnw8/yCtK2b9pkImjXSjnKRF
	 mu6hjphxfw0NAs7O0wHE/HvOKbqMvfHr0xfpHNDQPfCcJkCklbe/+9T6a3aj/ciA4l
	 1OY1yf35bmh7pMei0j2QC26MxXiDUieru8kKZ/z63Ztl7tJPPjdZxweZLFyWZTBsag
	 dp7SgfJjQWOYQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bHS7l1DmQz1yBD;
	Wed, 11 Jun 2025 16:04:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from localhost (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18wRjiQhny3JMlHlBPKhYTTZ8dQUFezhPw=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bHS7g31Hyz1xw7;
	Wed, 11 Jun 2025 16:03:59 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org,  ast@kernel.org,  bpf@vger.kernel.org,
  daniel@iogearbox.net,  haoluo@google.com,  john.fastabend@gmail.com,
  jolsa@kernel.org,  kpsingh@kernel.org,  linux-kernel@vger.kernel.org,
  martin.lau@linux.dev,  sdf@fomichev.me,  song@kernel.org,
  syzkaller-bugs@googlegroups.com,  yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in do_check
In-Reply-To: <38862a832b91382cddb083dddd92643bed0723b8.camel@gmail.com>
	(Eduard Zingerman's message of "Wed, 11 Jun 2025 06:02:55 -0700")
References: <68497853.050a0220.33aa0e.036a.GAE@google.com>
	<38862a832b91382cddb083dddd92643bed0723b8.camel@gmail.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 11 Jun 2025 16:03:59 +0200
Message-ID: <87frg6gysw.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> Accessed memory is freed at an error path in push_stack():
>
>   static struct bpf_verifier_state *push_stack(...)
>   {
>   	...
>   err:
>   	free_verifier_state(env->cur_state, true); // <-- KASAN points here
>   	...
>   }
>
> And is accessed after being freed here:
>
>   static int do_check(struct bpf_verifier_env *env)
>   {
>   	...
> 		err = do_check_insn(env, &do_print_state);
> KASAN -->	if (state->speculative && error_recoverable_with_nospec(err)) ...
>   	...
>   }
>   
> [...]
>
> Either 'state = env->cur_state' is needed after 'do_check_insn()' or
> error path should not free env->cur_state (seems logical).

Sorry, this was my error from [1]. Thanks for the pointer.

Yes, I think the former makes sense (with the respective `state &&`
added to the if).

The latter might also be possible, but I guess it would require more
significant changes.

state->speculative does not make sense if the error path of push_stack()
ran. In that case, `state->speculative &&
error_recoverable_with_nospec(err)` as a whole should already never
evaluate to true (because all cases where push_stack() fails also return
a non-recoverable error -ENOMEM/-EFAULT).

Alternatively to adding `state = env->cur_state` and `state &&`, turning
the check around would avoid the use-after-free. However, I think your
idea is better because it is more explicit compared to this:

	if (error_recoverable_with_nospec(err) && state->speculative) ...

Does this make sense to you? If yes I can send the fix later today.

I will also check that all other paths calling free_verifier_state() are
sane. So far it looks good.

The later

	if (state->speculative && cur_aux(env)->nospec_result) {

should already be fine, because !env->cur_state should imply that the
previous if raises the error.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=d6f1c85f22534d2d9fea9b32645da19c91ebe7d2

