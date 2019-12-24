Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922F7129E40
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 07:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfLXGwA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Dec 2019 01:52:00 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41505 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXGwA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Dec 2019 01:52:00 -0500
Received: by mail-qv1-f68.google.com with SMTP id x1so7165943qvr.8;
        Mon, 23 Dec 2019 22:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FiFs5c//TsPMpAtCEnFYceuoC6j/d/tXyUmG5GN0MI=;
        b=RJSWRglUT8sjanJ6gOTOiSGTeN28TU8bhPDg44fzSvrbSNTeNQRCUltg6gXVCJHEDB
         PaXMWRk/kd6CVUfS6bhL35GSDTFn/z6xiZ69kqT9Bt31JBELPNbiesGmrBRltEmqyFwl
         GnGbPAhIyrWIgiPc5aBj5wGk1tSEdmLJklHE09mY7q4tDCFo8vZ2xgO8gxwEoaT4Q0Ac
         6THgzf1HXYVM4KtKNVsbpCSyKLJ38MppiqgMvx69i57kSm2PLglHyDWfU/LR+QhXfjfN
         UA/UL7xVLxA9yNDGkexyv5Gm+77k807l8sYR9/95dX2GKG8HhWaF5GD8khF2605AsSRu
         HKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FiFs5c//TsPMpAtCEnFYceuoC6j/d/tXyUmG5GN0MI=;
        b=LWfJKa6nc02uhrNt8nPSfSU8Y/AbYYsHZMDRGT4w8djfLwMCLGKZjyKkq98LXZi6Mz
         +o+Q3a5ypV2uHbKL0XHP9g6T9lL06FTDiqepXwhCcbZZaz3LdY54E4TASe9phmrX3yBc
         gZwH4B9KTuIhCbHgOWMlKyE4R+pOp6iFFjGj4ZjNvTs+gL1tKJx8JsnF+Tb7TzL+VVeh
         0fPbWfhotqu9JyCsxieU0ax30RmXS/bROldCLmw8L+vDDCebXh6LqY+z36/5XDiZNlHF
         YGvvfOyjSrY8Vio9xcEnF/zGavwzk8ltctXvU4Mc8I5g2R5FLT3ji518Fd9zAHQH1+Fc
         HYMQ==
X-Gm-Message-State: APjAAAWrElITEVZsjdaDx3+jSHGYHra22nP2p2zImSozBE98lEu99kfn
        Yit3ywQAgaUWhD51ngZUvhl++TL584sVOGEMsjg=
X-Google-Smtp-Source: APXvYqxLV+P+/PLkhwN2nIhsav78E8rWy2Nk3RBdEOJrEJa5lB2tOH8SP21hDONloLtiK778n0nM49S9sbc3W2eXjYg=
X-Received: by 2002:a05:6214:38c:: with SMTP id l12mr27595725qvy.224.1577170319418;
 Mon, 23 Dec 2019 22:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org>
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 22:51:48 -0800
Message-ID: <CAEf4BzYiUZtSJKh-UBL0jwyo6d=Cne2YtEyGU8ONykmSUSsuNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 7:42 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> This patch series is a continuation of the KRSI RFC
> (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/)
>

[...]

> # Usage Examples
>
> A simple example and some documentation is included in the patchset.
>
> In order to better illustrate the capabilities of the framework some
> more advanced prototype code has also been published separately:
>
> * Logging execution events (including environment variables and arguments):
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> * Detecting deletion of running executables:
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c
> * Detection of writes to /proc/<pid>/mem:
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c

Are you planning on submitting these examples for inclusion into
samples/bpf or selftests/bpf? It would be great to have more examples
and we can review and suggest nicer ways to go about writing them
(e.g., BPF skeleton and global data Alexei mentioned earlier).

>
> We have updated Google's internal telemetry infrastructure and have
> started deploying this LSM on our Linux Workstations. This gives us more
> confidence in the real-world applications of such a system.
>
> KP Singh (13):
>   bpf: Refactor BPF_EVENT context macros to its own header.
>   bpf: lsm: Add a skeleton and config options
>   bpf: lsm: Introduce types for eBPF based LSM
>   bpf: lsm: Allow btf_id based attachment for LSM hooks
>   tools/libbpf: Add support in libbpf for BPF_PROG_TYPE_LSM
>   bpf: lsm: Init Hooks and create files in securityfs
>   bpf: lsm: Implement attach, detach and execution.
>   bpf: lsm: Show attached program names in hook read handler.
>   bpf: lsm: Add a helper function bpf_lsm_event_output
>   bpf: lsm: Handle attachment of the same program
>   tools/libbpf: Add bpf_program__attach_lsm
>   bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
>   bpf: lsm: Add Documentation
>

[...]
