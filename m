Return-Path: <bpf+bounces-73465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889FC324FC
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 735184E2B6E
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F233B949;
	Tue,  4 Nov 2025 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c1Z4IqLx"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF626CE17
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277000; cv=none; b=bFQimyZpsKywMYAv6fpN+0npRuXVrNFB6+4Fc9fdK8Cl5A+ZwQmh0FRH4KzQsXveJ1ypIaZqyTipZNmv8MhzRGvyJHVvSF4/ysJ+s2JKp2uDaHmm+jHGCrb5aumPVQGRDFO2w1XgeHjSmRtkus+8qcgT+Tyq2gIXOrSekHdECkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277000; c=relaxed/simple;
	bh=C8AmJj3ClxjTOOEVOO/5YJqxORb8ISHIWhYAHLSuzP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juQfn0Moo9EWI/eevO7oAZE66wUehOi5k9jW56E4u8ItcQKKsMujwt8P6wrzGM+ni+G/NTtlPOl1oU2mMF2h1s+mcZl5E4OguRxSujM4laIT3lYlp9HvOGKDwA67eorJ0XBC+ssIMCSMusefVndhUZQ4KfU39pnwVfICWxL+a0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c1Z4IqLx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <529b54a3-c534-4760-9bec-ed1214e82819@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762276990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4JXg9p/ygic1OVGMwWqUaOER+D1TpxCFPECm6BeFwE=;
	b=c1Z4IqLxfT5W32CM+45bbXLmExvENITJgZcuEQMY0eZmdEIGM0VViZBMnmZoPJbvXK+yqR
	ph8juWgeKFxK13aLsIK0TqM1b6z8N1o4u0XsAW4Ai0H5kNvW+w62cBsY1S7qlTN+ArEEo8
	i3k99iUHjNPi9UakaFR2SH8EjI4RtzQ=
Date: Tue, 4 Nov 2025 09:23:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 0/2] bpf: add _impl suffix for kfuncs with implicit
 args
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251104-implv2-v2-0-6dbc35f39f28@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251104-implv2-v2-0-6dbc35f39f28@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/4/25 7:29 AM, Mykyta Yatsenko wrote:
> We’re introducing support for implicit kfunc arguments and need to
> rename new kfuncs to comply with the naming convention.
> This new feature, will for each kfunc of the form:
> 
> `bpf_foo_impl(args..., aux__prog)`
> 
> generate a public BTF type:
> 
> `bpf_foo(args...)`
> 
> and the verifier will resolve calls to bpf_foo() to bpf_foo_impl(),
> supplying a valid struct bpf_prog_aux via aux__prog.

Hi Mykyta, thank you for submitting this.

The explanation in this cover is inaccurate. There were a few
discussions, and the "implicit" feature is in active development, so
it is confusing... Let me try to elaborate.

Currently if a kfunc needs access to struct bpf_prog_aux data, it must
have an explicit void *aux__prog argument in its declaration. Then on
BPF side the users must pass a dummy value (conventionally NULL).

In the v6.18-rc4 these 4 functions are using aux__prog argument:
  * bpf_wq_set_callback_impl (note existing _impl suffix)
  * bpf_task_work_schedule_signal
  * bpf_task_work_schedule_resume
  * bpf_stream_vprintk

The goal of the KF_IMPLICIT_ARGS feature is to hide this argument from
BPF programs, as it is supplied by the verifier.

With it, the kfuncs still require an explicit argument in the
kernel declaration, for example:

    __bpf_kfunc int bpf_foo(int arg, struct bpf_prog_aux *aux__implicit);

In order to hide it from the BPF users, the following functions will
be produced in BTF from the above declaration:

    /* no aux arg for BPF interface kfunc */
    __bpf_kfunc int bpf_foo(int arg);

    /* no kfunc decl_tag for _impl function */
    int bpf_foo_impl(int arg, struct bpf_prog_aux *aux__implicit);

Now the problem with existing aux__prog users that you're renaming in
this patchset is that because they don't have an _impl suffix, their
prototype will change, breaking binary compatibility with existing BPF
programs. If we simply mark them as KF_IMPLICIT_ARGS, then they lose 
an argument in BTF, for example:

    bpf_task_work_schedule_signal(task, tw, map__map, callback, aux__prog);

becomes

    bpf_task_work_schedule_signal(task, tw, map__map, callback);

However, if we rename it to "bpf_task_work_schedule_signal_impl", then
after KF_IMPLICIT_ARGS feature is implemented, we can *add a new
kfunc* "bpf_task_work_schedule_signal" with an implicit arg.

This way we can avoid breaking BPF progs calling this kfunc, although 
renaming is still a disruption of course.

See links to previous discussions:
* https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
* https://lore.kernel.org/bpf/20250924211716.1287715-1-ihor.solodrai@linux.dev/
* https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@linux.dev/

> 
> Three kfuncs added in 6.18 don’t follow this *_impl convention and
> therefore won’t participate in the new mechanism:
>  * bpf_task_work_schedule_resume()
>  * bpf_task_work_schedule_signal()
>  * bpf_stream_vprintk()
> 
> Rename them to align with the implicit-arg flow:
> bpf_task_work_schedule_resume() -> bpf_task_work_schedule_resume_impl()
> bpf_task_work_schedule_signal() -> bpf_task_work_schedule_signal_impl()
> bpf_stream_vprintk() -> bpf_stream_vprintk_impl()
> 
> The implicit-arg mechanism is not in tree yet, so callers must switch to
> the *_impl names for now. Once the new mechanism lands, the plain
> names (without _impl) will be reintroduced as BTF-visible entry points
> and will resolve to the _impl versions automatically.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
> Changes in v1:
> - Split commit into 2
> - Rebase on the correct branch
> - Link to v1: https://lore.kernel.org/all/20251103232319.122965-1-mykyta.yatsenko5@gmail.com/
> 
> ---
> Mykyta Yatsenko (2):
>       bpf:add _impl suffix for bpf_task_work_schedule* kfuncs
>       bpf:add _impl suffix for bpf_stream_vprintk() kfunc
> 
>  kernel/bpf/helpers.c                               | 26 +++++++++++---------
>  kernel/bpf/stream.c                                |  3 ++-
>  kernel/bpf/verifier.c                              | 12 +++++-----
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  2 +-
>  tools/lib/bpf/bpf_helpers.h                        | 28 +++++++++++-----------
>  tools/testing/selftests/bpf/progs/stream_fail.c    |  6 ++---
>  tools/testing/selftests/bpf/progs/task_work.c      |  6 ++---
>  tools/testing/selftests/bpf/progs/task_work_fail.c |  8 +++----
>  .../testing/selftests/bpf/progs/task_work_stress.c |  4 ++--
>  9 files changed, 50 insertions(+), 45 deletions(-)
> ---
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> change-id: 20251104-implv2-d6c4be255026
> 
> Best regards,


