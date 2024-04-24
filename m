Return-Path: <bpf+bounces-27606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EADF8AFD57
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C816D281D8D
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413973C3C;
	Wed, 24 Apr 2024 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPoyV2KM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B21C36
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918465; cv=none; b=J7VTKpiXDubI6bgxhc87xa10RpwjAjwmTfJdxhRBmiP1LC4Dr8tmaW/D6T7DYwlocBwiye5XgCMzFePna7GAQkpIy+Gs8lQiDiemJZW7E7K2mYCwwZbg5V7Nsp+DvaReGGp33vIbheK07AGJNyn44kZcXgs+OLN7vuO9kC00OTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918465; c=relaxed/simple;
	bh=1RBr1vFM5epeU7JbZ2XjqD0PRwYH8E+aGA9EBOVmWik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTSaBru0TudrpAIV0vEMGPWUlFsb0YLyyxcuoyqN0iJJBO2QvGxYLOsGLhXPvKFe18XYBCrAf6z7+Y6b0zKGMHtJLvyO4/ECnNxiH3eXuXePTF5NvGRWE7sRrIyRpU8UKMzqCdjyxOpMzwdgjfA5g6Ty3nLzyO8Xv7cXaKOnK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPoyV2KM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ae6c8745ffso1460360a91.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713918464; x=1714523264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fWpaG7XV2kzRrnN34vNApgWmSCWXCA4sxdE1B1zQdY=;
        b=GPoyV2KMog6TBJoF8kbojyuRrbzsuLrnurD2R5Vc0M32EB/WLishJwPEnPDkKwXUGI
         O2FYyc26dHTeyqsCWCPS3Hj10oXVnbKeRbXpigufRFB7QqGUG/lKgq6NtblLhYivFNGw
         UcK9a+B8sCS/MoYYk30L8q+xfoVtMjZd8wj6h/D8g5y7X1KzEc2Zb+N5bex2MZs1xpPZ
         kBVy/OvVp8dFGKQiQ+SRZkufzGwFQUtc86MojI7d2YxAKvnWYZlFgsnafCigaMGr2A9K
         PHWPrGEyWIabpzhNB9W4tc4RCWhLpDOEB4F5AmI/sOg3Zimp4IVqki+nDRnSsH3qVTf7
         6ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918464; x=1714523264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fWpaG7XV2kzRrnN34vNApgWmSCWXCA4sxdE1B1zQdY=;
        b=fq/gIwgCWU1twS/4CFoc3JqxRF+hunYl/X1roVbn+H5oUlTls9fW+Q/xlll/3/EJ8V
         9Nfq9ntIvDWbGWwTVt6zi0F1AlZiO7H7RlHhhg+QYNUOWgQxuUktDQGhPn3k2SGkH2XH
         kwc90FTtrNc3kChYXQo9h7RrHcDUwBbKnWlnGPz47XAMRCpluD7CC8/tLrzD5JViHXXU
         auF5b45w9AQRHXxrT2SYWoSbPX0epzq8uPbRkoKl51QJdd7SxsJey3uZ1bqsdYapAsE5
         PEj2JxTdKECqmXbotcCBsNaaBkMW/mXTJIp2dvyHUvkf6Q+yRteaUHE5y1DxT8tuzGCc
         GQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCVe9bef2xmYZ4phiunbTn1egs3qc0HKYjTYdQWxbykc4x7+Tg9PtIdJYqThKQN77Ss9/ZLOHL1sVTAOIv2KXKDtusCW
X-Gm-Message-State: AOJu0YxMBkPQleuiI94KKPtcr0CbCmy0ldC6HmUlj3g+X3iUlla91FzW
	QXSDU+RCZay5gjy/o3WGWJf0XjK9R7cDk2ehhAPimHsPvpoJSdO7DhnxMt29dgq/WWvqhhaDvD4
	HRGUETRThbXOxUB5llRGjTwFgu9Y=
X-Google-Smtp-Source: AGHT+IF4atr/+0yUJILQc109H9p0JtCmvYggdDTt6HbvsuFg/2+6nc4pKYpvKfT5eMUbJwoe7Bjo/3WuXoIAC+3HATw=
X-Received: by 2002:a17:90b:3a83:b0:2a5:d978:31a9 with SMTP id
 om3-20020a17090b3a8300b002a5d97831a9mr875028pjb.31.1713918463725; Tue, 23 Apr
 2024 17:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422121241.1307168-1-jolsa@kernel.org>
In-Reply-To: <20240422121241.1307168-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Apr 2024 17:27:31 -0700
Message-ID: <CAEf4BzbAjGcrqLi4+rjU5JALHPF5CjAww4fexassr3vWe4FaZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf: Introduce kprobe_multi session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:12=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> adding support to attach kprobe program through kprobe_multi link
> in a session mode, which means:
>   - program is attached to both function entry and return
>   - entry program can decided if the return program gets executed
>   - entry program can share u64 cookie value with return program
>
> The initial RFC for this was posted in [0] and later discussed more
> and which ended up with the session idea [1]
>
> Having entry together with return probe for given function is common
> use case for tetragon, bpftrace and most likely for others.
>
> At the moment if we want both entry and return probe to execute bpf
> program we need to create two (entry and return probe) links. The link
> for return probe creates extra entry probe to setup the return probe.
> The extra entry probe execution could be omitted if we had a way to
> use just single link for both entry and exit probe.
>
> In addition the possibility to control the return program execution
> and sharing data within entry and return probe allows for other use
> cases.
>
> Changes from last RFC version [1]:
>   - changed wrapper name to session
>   - changed flag to adding new attach type for session:
>       BPF_TRACE_KPROBE_MULTI_SESSION
>     it's more convenient wrt filtering on kfuncs setup and seems
>     to make more sense alltogether
>   - renamed bpf_kprobe_multi_is_return to bpf_session_is_return
>   - added bpf_session_cookie kfunc, which actually already works
>     on current fprobe implementation (not just fprobe-on-fgraph)
>     and it provides the shared data between entry/return probes [Andrii]
>
>     we could actually make the cookie size configurable.. thoughts?
>     (it's 8 bytes atm)
>

Attach cookie is fixed at 8 bytes and that works pretty well. I think
beyond 8 bytes there is no clearly "right" size. A common case would
be to capture arguments in kprobe to handle in kretprobe, and there
you might need at least 40+ bytes, which seems wasteful. So I want to
say that it's probably good to hard-code it to just 8 bytes (enough to
store timestamp and you can even fit in some flags if you reduce
timestamp precision from nanoseconds to microseconds), or use it as an
index into array or some other data structure.

let's keep it simple?



>   - better attach setup conditions changes [Andrii]
>   - I'm not including uprobes change atm, because it needs extra
>     uprobe change so I'll post it separately
>
> Also available at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   bpf/session_data
>
> thanks,
> jirka
>
>
> [0] https://lore.kernel.org/bpf/20240207153550.856536-1-jolsa@kernel.org/
> [1] https://lore.kernel.org/bpf/20240228090242.4040210-1-jolsa@kernel.org=
/
> ---
> Jiri Olsa (7):
>       bpf: Add support for kprobe multi session attach
>       bpf: Add support for kprobe multi session context
>       bpf: Add support for kprobe multi session cookie
>       libbpf: Add support for kprobe multi session attach
>       libbpf: Add kprobe session attach type name to attach_type_name
>       selftests/bpf: Add kprobe multi session test
>       selftests/bpf: Add kprobe multi wrapper cookie test
>
>  include/uapi/linux/bpf.h                                        |   1 +
>  kernel/bpf/btf.c                                                |   3 ++=
+
>  kernel/bpf/syscall.c                                            |   7 ++=
+++-
>  kernel/bpf/verifier.c                                           |   7 ++=
++++
>  kernel/trace/bpf_trace.c                                        | 106 ++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
----------
>  tools/include/uapi/linux/bpf.h                                  |   1 +
>  tools/lib/bpf/bpf.c                                             |   1 +
>  tools/lib/bpf/libbpf.c                                          |  41 ++=
++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h                                          |   4 ++=
+-
>  tools/testing/selftests/bpf/bpf_kfuncs.h                        |   3 ++=
+
>  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c      |  84 ++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/kprobe_multi_session.c        | 100 ++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c |  56 ++=
++++++++++++++++++++++++++++++++++++++++++++
>  13 files changed, 396 insertions(+), 18 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sessio=
n.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sessio=
n_cookie.c

