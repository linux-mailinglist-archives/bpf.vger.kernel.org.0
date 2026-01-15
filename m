Return-Path: <bpf+bounces-79131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 818BFD27D02
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC517300EBB2
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956D3C1FD9;
	Thu, 15 Jan 2026 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbwEz/OD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636BB3C00B2
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503265; cv=pass; b=S7PAiUHCNN1JNCy85XtmNyAmXCa5Xr9QBVh0DTFHRXo7E38kBVdxfy1yfFWKjreSettVO/sO/rbmxQ+626cG4qXIJZwilgWGfmEtpkIkc8G0V3br8QZEZy9pOfwA99mW7F8VAf4CHG3Bxk1iH26DgzNfsfxRL6YQgNjCVMHPbEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503265; c=relaxed/simple;
	bh=7dV2gC3i6v7x5QNrTKY/jnqxzJHYoS51E3vSMMeqd+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObrvE64zrI+zVz/Dk0r1gMcBd6+xoAgkaNKmmtLty3D8tEmT+dJzgulRoEvG7lOi/uApisrWfV96lKTxsbyikbNS9G8zdeuD+GRAuNdpPQ5p5xqB/zbERcDSRk2+gMrSvWkF+reBWIjt7QDDqPIK9MoKjSXs25Ykfn+h8W+5Bs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbwEz/OD; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so623980a91.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:54:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768503262; cv=none;
        d=google.com; s=arc-20240605;
        b=U5dFU3Uklz8H8PrLmlDpBNcpEhfoW3eKizAbbbo9gc7m2XKFRJK4uBV1wIDWI3UPOb
         Ct59FwGJY8S9/xJfKGIKHrRq6MXVbry+FZxLx/GiKZ+rcLHYKtNQN8LG1mjWyH3iM07n
         gdESBsKcU9eOdToGbNjryAQP51RBavfjxlTELqo6wztHqcH66ue75MHQWiXc5veTvYUc
         TEUDULPS4acyugeFyvZPq/GD1PquGXMOPq3/m42aobCZ1zpGeDqZ2nL9vOoY6u9UUgnf
         27k7dot93tbgxTXekR35CQ0dYatluykZctVc/z1soPtQcw2Jng27yniD7rskoBB+1JmT
         WzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EpbTbJbIYQW2HGVw5tfKbZOFlETWSnwKBDBmcbacs/s=;
        fh=ZxiFtdk1gZijJHgjuGmqEmMvwINyZ9W9I2Yt7MzLP2Q=;
        b=UJotV4ZkDPZZbsCRwp5Q9tSwIRx3PIUshHl2qXWRxVLl6t2mCldLZZQLyYXcveoiyn
         1M0iQ+IQo42ztx+Q8Y2ZU0mkzAMWxvFhilYwo6eAqsJTUBmnALOkER8zPoFzG45tni7N
         R9Ctm44adz43Vp/IK3Md2kUyVf5advfOXfur6oF0A/g7ob0eqqxMCo2x24IETWdUNsOP
         f2nTLL9dhe4rjhi+1mQ6uubcqF6sv0o/9lMT7fTYBkJmHKyy9KCVhxPes4Xr2eJHCzK7
         sqEEJ01kSI24I2tOlYYK+NxiiGohySY6psweKn34fdd64HMfATgzvB5Uj/PfyjXAwLDe
         khaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503262; x=1769108062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpbTbJbIYQW2HGVw5tfKbZOFlETWSnwKBDBmcbacs/s=;
        b=lbwEz/ODkoLfn+u/4BdN9MMY7c5cIpjhgEVetLD2VmTFnIF6pyWSCe91WD9eg8OpQP
         hHH0fb6rs+I488eIDqiTMGKm6XMi/mxMvAqy56YMXXgAMKNHom6SgWSP+MSdLOZ1Q+x3
         PMIgNgTmJznBrm2yT3ghk7UUEwHFQs/LjOAlh6nul2u+yjtOtjQp5YN54GCZ1l8px7qu
         bUjVxzkVbV4Yt9m3bzS87DsH55I6TYNsLTi65pXjb1/9BD5vmJLou7dpym5BaxI1pgse
         iiMztNoPe0aFSW8kEIzbZn+8ppCuiJGoTov+vC76nOb65Sf4uTjaM67CHlBj4G8+kwRv
         gV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503262; x=1769108062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EpbTbJbIYQW2HGVw5tfKbZOFlETWSnwKBDBmcbacs/s=;
        b=iXALWcgRX/yE0lL/TJO7QVIGX7GqN3QH9btuFAiDcVhfvHdWmeY1ZqJStzhFQ63MuI
         2zo13LjEQjDqgmuHI+QIu3D/Za19dQ+7K6xRLDiul5i5ChROBQ84lPYGCjNlAtQAIF6I
         0jpWRF4wkPnnXSWOQVhr+319YJLvL8RoZ1DfaEvlBWzVxtznvjX3sa1S1GZgHDV8Uz2Z
         FNwE1+KemcpgEgiV8pJuP70Mbs70by4e9z/887ffHfG198ITj3mulhgBUQ7YFbtQu1gv
         5ydTMty+aSW+aO+HW0P5ZQsi4wRrqeYZMHSXavrkPd/LDaY2RB2wIhgnje/uS+CAZkCt
         G8NA==
X-Forwarded-Encrypted: i=1; AJvYcCVCVoq887BzRwjpc5eRc9MUgXukbLAjvwvjdbUrmtC81T/hFtgB1Q5IyL/lX4NbojhnrUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIA4PTgw8Oyru3JV9W35K8EsgIZKzgEUXKODuvSJUYHUDnRk29
	zt50iivX0wkl0adCL3nWcy6Zox/4RK0Fw8sKFUhb0prGy2R0oHR+GIz3sS+DeS78Fa6mO0Hlx0F
	Su2Bbg9i7Xh0l0GB/Aa2TlrYcSkM0dto=
X-Gm-Gg: AY/fxX7DMSECnP8W2uLbAFnWuR0R+ueA8MISP5FxZbiLBH8kBvuMLl6aXKLiXcBsQpT
	ZbOLmnozkPxy+tSNVYDlJuOC39Y56IXLko+4teHYaq9A/3MPkjob63tyD9AqNveU28ZkQmZkwCQ
	x5IwIozDXPOguQ5V9Pp4BCrtUXrPtIiZV+nAf5LXyFRaWx7Zdbku3QBQSGYX+kt5cAX1MNuyEhp
	K/iNH7/px1hhPPXZ/FHHwfxa/w0Z1HDWBDO8Jsex50L25iXS3J3u5GZNh0XJApXzX2daU5IIz88
	3D5dW2oJ
X-Received: by 2002:a17:90b:2682:b0:341:88c9:ca62 with SMTP id
 98e67ed59e1d1-35272f8c54bmr287868a91.31.1768503261661; Thu, 15 Jan 2026
 10:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230145010.103439-1-jolsa@kernel.org>
In-Reply-To: <20251230145010.103439-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 10:54:09 -0800
X-Gm-Features: AZwV_QiwkBtwLCiJrqG34-zTIw_OQKLb1v72y1BxE2HMZ_jpyB1tumI3srsjTrw
Message-ID: <CAEf4BzaRU0DoM9hHtW5Bm7njodfg06JzTOe=ABAqZ6iMjAt4iQ@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 0/9] ftrace,bpf: Use single direct ops for bpf trampolines
To: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:50=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> while poking the multi-tracing interface I ended up with just one ftrace_=
ops
> object to attach all trampolines.
>
> This change allows to use less direct API calls during the attachment cha=
nges
> in the future code, so in effect speeding up the attachment.
>
> In current code we get a speed up from using just a single ftrace_ops obj=
ect.
>
> - with current code:
>
>   Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c =
true':
>
>      6,364,157,902      cycles:k
>        828,728,902      cycles:u
>      1,064,803,824      instructions:u                   #    1.28  insn =
per cycle
>     23,797,500,067      instructions:k                   #    3.74  insn =
per cycle
>
>        4.416004987 seconds time elapsed
>
>        0.164121000 seconds user
>        1.289550000 seconds sys
>
>
> - with the fix:
>
>    Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c=
 true':
>
>      6,535,857,905      cycles:k
>        810,809,429      cycles:u
>      1,064,594,027      instructions:u                   #    1.31  insn =
per cycle
>     23,962,552,894      instructions:k                   #    3.67  insn =
per cycle
>
>        1.666961239 seconds time elapsed
>
>        0.157412000 seconds user
>        1.283396000 seconds sys
>
>
>
> The speedup seems to be related to the fact that with single ftrace_ops o=
bject
> we don't call ftrace_shutdown anymore (we use ftrace_update_ops instead) =
and
> we skip the synchronize rcu calls (each ~100ms) at the end of that functi=
on.
>
> rfc: https://lore.kernel.org/bpf/20250729102813.1531457-1-jolsa@kernel.or=
g/
> v1:  https://lore.kernel.org/bpf/20250923215147.1571952-1-jolsa@kernel.or=
g/
> v2:  https://lore.kernel.org/bpf/20251113123750.2507435-1-jolsa@kernel.or=
g/
> v3:  https://lore.kernel.org/bpf/20251120212402.466524-1-jolsa@kernel.org=
/
> v4:  https://lore.kernel.org/bpf/20251203082402.78816-1-jolsa@kernel.org/
> v5:  https://lore.kernel.org/bpf/20251215211402.353056-10-jolsa@kernel.or=
g/
>
> v6 changes:
> - rename add_hash_entry_direct to add_ftrace_hash_entry_direct [Steven]
> - factor hash_add/hash_sub [Steven]
> - add kerneldoc header for update_ftrace_direct_* functions [Steven]
> - few assorted smaller fixes [Steven]
> - added missing direct_ops wrappers for !CONFIG_DYNAMIC_FTRACE_WITH_DIREC=
T_CALLS
>   case [Steven]
>

So this looks good from BPF side, I think. Steven, if you don't mind
giving this patch set another look and if everything is to your liking
giving your ack, we can then apply it to bpf-next. Thanks!

> v5 changes:
> - do not export ftrace_hash object [Steven]
> - fix update_ftrace_direct_add new_filter_hash leak [ci]
>
> v4 changes:
> - rebased on top of bpf-next/master (with jmp attach changes)
>   added patch 1 to deal with that
> - added extra checks for update_ftrace_direct_del/mod to address
>   the ci bot review
>
> v3 changes:
> - rebased on top of bpf-next/master
> - fixed update_ftrace_direct_del cleanup path
> - added missing inline to update_ftrace_direct_* stubs
>
> v2 changes:
> - rebased on top fo bpf-next/master plus Song's livepatch fixes [1]
> - renamed the API functions [2] [Steven]
> - do not export the new api [Steven]
> - kept the original direct interface:
>
>   I'm not sure if we want to melt both *_ftrace_direct and the new interf=
ace
>   into single one. It's bit different in semantic (hence the name change =
as
>   Steven suggested [2]) and I don't think the changes are not that big so
>   we could easily keep both APIs.
>
> v1 changes:
> - make the change x86 specific, after discussing with Mark options for
>   arm64 [Mark]
>
> thanks,
> jirka
>
>
> [1] https://lore.kernel.org/bpf/20251027175023.1521602-1-song@kernel.org/
> [2] https://lore.kernel.org/bpf/20250924050415.4aefcb91@batman.local.home=
/
> ---
> Jiri Olsa (9):
>       ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
>       ftrace: Make alloc_and_copy_ftrace_hash direct friendly
>       ftrace: Export some of hash related functions
>       ftrace: Add update_ftrace_direct_add function
>       ftrace: Add update_ftrace_direct_del function
>       ftrace: Add update_ftrace_direct_mod function
>       bpf: Add trampoline ip hash table
>       ftrace: Factor ftrace_ops ops_func interface
>       bpf,x86: Use single ftrace_ops for direct calls
>
>  arch/x86/Kconfig        |   1 +
>  include/linux/bpf.h     |   7 ++-
>  include/linux/ftrace.h  |  31 +++++++++-
>  kernel/bpf/trampoline.c | 259 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++---------------
>  kernel/trace/Kconfig    |   3 +
>  kernel/trace/ftrace.c   | 406 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--------
>  6 files changed, 632 insertions(+), 75 deletions(-)
>

