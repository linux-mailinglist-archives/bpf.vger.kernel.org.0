Return-Path: <bpf+bounces-21085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E95847BB9
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C01F2A19E
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F3B839F3;
	Fri,  2 Feb 2024 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/s7f4Ai"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270281758
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909997; cv=none; b=ZuqUW1uRegfmIlmbxu9x5KFYh66HdUVLBDdLUI7p4kT9dgDMfM40uAkyWnsYuDq+xCFgYpvYeNKMc4GKo55FzlG7rz9bsV1Llon4T1fptQUQCWSkA9/bPUx4kzbsI0u5pVuW6nrrG4LXkiVpVv2lmKmP0A685JM3KzEMGMABLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909997; c=relaxed/simple;
	bh=u87EoTBm2k1F2J5bC8yPRph1/m+MC1GEadbvtiMIToA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irxc3bv+t6zQoHLMR1ncE2PfPP0D0WCxrxXq137CU4SMSPev7tNzdttGlAW1NNDPXdrru5gvTSVpfR1UUGjze+YrmGiPs7BNuR/pbtmewSX9lu4GCz2hrLh4tqOMePvUf/rsRCzOCX3lIYtzCYDby643w11lE/QDvrKbGno7S/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/s7f4Ai; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da9c834646so1905744b3a.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 13:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706909995; x=1707514795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mm4iRa+WsoVut0pn02w9RTFB+I45goQsVzjbrXKE+hU=;
        b=S/s7f4AiPtcvgKWYPcfIzVTI6FR8wmJuFW9R0f6ruhQRbbX3jp+GZJaInALz482DmE
         sPEatKbvNsFTzz1xjhYiNpjD+1gRqCoGe1EpbjxiYIOIa7Djzs/21E6bqUX+VWG96q1R
         2WZhLRJ8BQ/Sfalu8XPj8rKsw07ia2P8qjbMr3QTPk88PFuUqPQbisBQgdMNqxx2Vzdg
         6tCBCiH7MrYPNM74DWcC0zqQYAPNedG8gVnkSB16rVqAVp0nSmge+DlQVLESjKJA83hv
         UuE+RVQt+kiBJV6u/ieZQhzhiOUlOpHgZPntKWGC7v+2ApuFoy85cOV4hO7oAw5hg4Sn
         tkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909995; x=1707514795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm4iRa+WsoVut0pn02w9RTFB+I45goQsVzjbrXKE+hU=;
        b=qFjMoqkKtB/5SOWIYge+tXfyLb4xRUST6F3tku/302cDZMDlsC7ej8gKg5ARps88sS
         XcGq+GamDk6pMZzc54uvA1gGnDTxQmrKZfXHHYY8kWcw+8ww2bDHhLqsSu31kQk3ATDn
         l0ar4UJKKiRUm6Xf5FZSyTb+GT8pdgtD+J8kUrmYk+DN/YUo/H0w1ADOdsIT/H4zP/TQ
         SLVWijugoWUjlFNbvD1KVlkDLx97hssfm+dpoYngxmAwzcVCQ2mCg0FIrJ26GkKjb1vb
         7Y1CwGyarx/GzGdTCfqj363M2pdSaMxk5THMid+Nc9yjwMP5QEMAhF76Gts+oLLSYJrh
         rW/Q==
X-Gm-Message-State: AOJu0YxCPuyfppTvvupBszlzwu+bWwc9f/+Mw2zCZFZAOYJx9ygd9hp0
	CwqG35CoEcIb8uR8u/4mpxy2M9CeEKNMYfZTcNPe3f3tGdHfi2eEwoT8ptK4TWXg70iQOJpNUp7
	MpV5Mr0mxfT147kd2AOX/YNEnpXs=
X-Google-Smtp-Source: AGHT+IE/y5xw3knNh3wt0EUSTyvoCqzdrfrUOC/ec3/SD9WUiC5/eodCSurW7LGQaYKxZ0vAD7TvFpSjU4/jOZQqW80=
X-Received: by 2002:a05:6a20:d807:b0:19e:367a:2caa with SMTP id
 iv7-20020a056a20d80700b0019e367a2caamr3564940pzb.8.1706909995122; Fri, 02 Feb
 2024 13:39:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131162003.962665-1-alan.maguire@oracle.com>
In-Reply-To: <20240131162003.962665-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Feb 2024 13:39:43 -0800
Message-ID: <CAEf4BzbeBiNj2GHJkDBAWASwLMy6nDNMbmqtQGOABZsRGAEytQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/2] libbpf Userspace Runtime-Defined Tracing (URDT)
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:20=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Adding userspace tracepoints in other languages like python and
> go is a very useful for observability.  libstapsdt [1]
> and language bindings like python-stapsdt [2] that rely on it
> use a clever scheme of emulating static (USDT) userspace tracepoints
> at runtime.  This involves (as I understand it):
>
> - fabricating a shared library
> - annotating it with ELF notes that describe its tracepoints
> - dlopen()ing it and calling the appropriate probe fire function
>   to trigger probe firing.
>
> bcc already supports this mechanism (the examples in [2] use
> bcc to list/trigger the tracepoints), so it seems like it
> would be a good candidate for adding support to libbpf.
>
> However, before doing that, it's worth considering if there
> are simpler ways to support runtime probe firing.  This
> small series demonstrates a simple method based on USDT
> probes added to libbpf itself.
>
> The suggested solution comprises 3 parts
>
> 1. functions to fire dynamic probes are added to libbpf itself
>    bpf_urdt__probeN(), where N is the number of probe arguemnts.
>    A sample usage would be
>         bpf_urdt__probe3("myprovider", "myprobe", 1, 2, 3);
>
>    Under the hood these correspond to USDT probes with an
>    additional argument for uniquely identifying the probe
>    (a hash of provider/probe name).
>
> 2. we attach to the appropriate USDT probe for the specified
>    number of arguments urdt/probe0 for none, urdt/probe1 for
>    1, etc.  We utilize the high-order 32 bits of the attach
>    cookie to store the hash of the provider/probe name.
>
> 3. when urdt/probeN fires, the BPF_URDT() macro (which
>    is similar to BPF_USDT()) checks if the hash passed
>    in (identifying provider/probe) matches the attach
>    cookie high-order 32 bits; if not it must be a firing
>    for a different dynamic probe and we exit early.

I'm sorry Alan, but I don't see this being added to libbpf. This is
nothing else than USDT with a bunch of extra conventions bolted on.
And those conventions might not work for many environments. It is
completely arbitrary that libbpf is a) assumed to be a dynamic library
and b) provides USDT hooks that will be triggered. Just because it
will be libbpf that will be used to trace those USDT hooks doesn't
mean that libbpf has to define those hooks. Just because libbpf can
trace USDTs it doesn't mean that libbpf should provide those
STAP_PROBEx() macros to define and trigger USDTs within some
application. Applications that define USDTs and applications that
attach to those USDTs are completely separate and independent. Same
here, there might be an overlap in some cases, but conceptually it's
two separate sides of the solution.

Overall, this is definitely a useful overall approach, to have a
single system-wide .so library that can be attached to trace some
USDTs, and we've explored this approach internally at Meta as well.
But I don't believe it should be part of libbpf. From libbpf's
standpoint it's just a standard USDT probe to attach to.


>
> Auto-attach support is also added, for example the following
> would add a dynamic probe for provider:myprobe:
>
> SEC("udrt/libbpf.so:2:myprovider:myprobe")
> int BPF_URDT(myprobe, int arg1, char *arg2)
> {
>  ...
> }
>
> (Note the "2" above specifies the number of arguments to
> the probe, otherwise it is identical to USDT).
>
> The above program can then be triggered by a call to
>
>  BPF_URDT_PROBE2("myprovider", "myprobe", 1, "hi");
>
> The useful thing about this is that by attaching to
> libbpf.so (and firing probes using that library) we
> can get system-wide dynamic probe firing.  It is also
> easy to fire a dynamic probe - no setup is required.
>
> More examples of auto and manual attach can be found in
> the selftests (patch 2).
>
> If this approach appears to be worth pursing, we could
> also look at adding support to libstapsdt for it.
>
> Alan Maguire (2):
>   libbpf: add support for Userspace Runtime Dynamic Tracing (URDT)
>   selftests/bpf: add tests for Userspace Runtime Defined Tracepoints
>     (URDT)
>
>  tools/lib/bpf/Build                           |   2 +-
>  tools/lib/bpf/Makefile                        |   2 +-
>  tools/lib/bpf/libbpf.c                        |  94 ++++++++++
>  tools/lib/bpf/libbpf.h                        |  94 ++++++++++
>  tools/lib/bpf/libbpf.map                      |  13 ++
>  tools/lib/bpf/libbpf_internal.h               |   2 +
>  tools/lib/bpf/urdt.bpf.h                      | 103 +++++++++++
>  tools/lib/bpf/urdt.c                          | 145 +++++++++++++++
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  tools/testing/selftests/bpf/prog_tests/urdt.c | 173 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_urdt.c | 100 ++++++++++
>  .../selftests/bpf/progs/test_urdt_shared.c    |  59 ++++++
>  12 files changed, 786 insertions(+), 3 deletions(-)
>  create mode 100644 tools/lib/bpf/urdt.bpf.h
>  create mode 100644 tools/lib/bpf/urdt.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/urdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_urdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_urdt_shared.c
>
> --
> 2.39.3
>

