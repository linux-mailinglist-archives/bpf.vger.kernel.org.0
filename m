Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA81270D4
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 23:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSWl3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 17:41:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45862 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSWl2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 17:41:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so6016393qkl.12
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70AoCw7gR/ANBDfALYHWvs5rEExyH90S86seDrQcu0Y=;
        b=iISSv5wgM/XpaX0RDpzDfmT0RcdgGp7sB4jESAawd+o0BoRU4w5RPkuV4fOfRStLe7
         DJ7LKxPoJeHjufMLvNY7l2iP/rWQTXC4rDpoj/o7q/ET2qTfO0v6cS+rJ0jBCBtvqKAQ
         /A5tQY01WrB4m8Vdz5B3zlPjKLj/gUYD14aInA7aEy2S0+aZAOrVSaR/PsD7NgTVZ2OU
         2eF0uSen9xQSLmFxENXk7rK97jn2OlV0gXVUVGVYI1tX7j16TNo0oY0GIrEdKPaRBW5q
         DAmFPqLNLz8jMnzS9XbaEuT34j3tpVaTFoiibdCcAJZUCuIJzYaM2/oGUcdIb2djBgFN
         9ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70AoCw7gR/ANBDfALYHWvs5rEExyH90S86seDrQcu0Y=;
        b=qdWKHWzk3wqw91md/vvX5XcdmRv0xA5udvhOvZGv0hOs+7Hn6XHt3uaXbwhPS6mKnI
         QSosvnQ6pq7a7LluV1FOEFRKtygPyGBDu+GO6DOGLluHFxuq5x6VkLoRVe7ZgTGtvTQB
         pHvhU1xSxqAG/KnJurC5Ua+pZaPTla40ydLyfcoxQOWj0v5VRSWTS47OcbhTPUGOWXfV
         i5vuApI/CFyPlCvkiTkuA1UGwr7V3IVYwBqRNV7HwRwKT4mbAy7GEa+W1X0OHHPqGUKm
         akQnXZ79nP7JeqCruOGq/RKfAzPy9ttK3aAjyvVNaLkgF9MVGZpavoUZnS7Tn8E05zUX
         omgA==
X-Gm-Message-State: APjAAAW51HzRagoZfCIrkU51eXq9kNAvwyQjV1dTFyDQf4kkx5dLMyUl
        F//zlZ0EoqwnkxQ8CqF/9FOAsa05SMtcFxrbkUNAZjBt
X-Google-Smtp-Source: APXvYqyRQJeCjtep4nRdALFOOawBRVV3x8DY6cEgZnMwmYXj2Jt/PtgPgUJ3CS/LNaCYOiLN2LXIeNyTNQBIheIi870=
X-Received: by 2002:a05:620a:5ae:: with SMTP id q14mr10865787qkq.437.1576795287863;
 Thu, 19 Dec 2019 14:41:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576741281.git.rdna@fb.com> <30cd850044a0057bdfcaaf154b7d2f39850ba813.1576741281.git.rdna@fb.com>
In-Reply-To: <30cd850044a0057bdfcaaf154b7d2f39850ba813.1576741281.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Dec 2019 14:41:16 -0800
Message-ID: <CAEf4BzaBE3dowJ4ZtO3YxoSMuAYDLz9mejcmhS78iHoUH=Ke7Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/6] bpf: Support replacing cgroup-bpf program
 in MULTI mode
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 11:45 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> The common use-case in production is to have multiple cgroup-bpf
> programs per attach type that cover multiple use-cases. Such programs
> are attached with BPF_F_ALLOW_MULTI and can be maintained by different
> people.
>
> Order of programs usually matters, for example imagine two egress
> programs: the first one drops packets and the second one counts packets.
> If they're swapped the result of counting program will be different.
>
> It brings operational challenges with updating cgroup-bpf program(s)
> attached with BPF_F_ALLOW_MULTI since there is no way to replace a
> program:
>
> * One way to update is to detach all programs first and then attach the
>   new version(s) again in the right order. This introduces an
>   interruption in the work a program is doing and may not be acceptable
>   (e.g. if it's egress firewall);
>
> * Another way is attach the new version of a program first and only then
>   detach the old version. This introduces the time interval when two
>   versions of same program are working, what may not be acceptable if a
>   program is not idempotent. It also imposes additional burden on
>   program developers to make sure that two versions of their program can
>   co-exist.
>
> Solve the problem by introducing a "replace" mode in BPF_PROG_ATTACH
> command for cgroup-bpf programs being attached with BPF_F_ALLOW_MULTI
> flag. This mode is enabled by newly introduced BPF_F_REPLACE attach flag
> and bpf_attr.replace_bpf_fd attribute to pass fd of the old program to
> replace
>
> That way user can replace any program among those attached with
> BPF_F_ALLOW_MULTI flag without the problems described above.
>
> Details of the new API:
>
> * If BPF_F_REPLACE is set but replace_bpf_fd doesn't have valid
>   descriptor of BPF program, BPF_PROG_ATTACH will return corresponding
>   error (EINVAL or EBADF).
>
> * If replace_bpf_fd has valid descriptor of BPF program but such a
>   program is not attached to specified cgroup, BPF_PROG_ATTACH will
>   return ENOENT.
>
> BPF_F_REPLACE is introduced to make the user intent clear, since
> replace_bpf_fd alone can't be used for this (its default value, 0, is a
> valid fd). BPF_F_REPLACE also makes it possible to extend the API in the
> future (e.g. add BPF_F_BEFORE and BPF_F_AFTER if needed).
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> ---

Looks good.

Acked-by: Andrii Narkyiko <andriin@fb.com>

>  include/linux/bpf-cgroup.h     |  4 +++-
>  include/uapi/linux/bpf.h       | 10 ++++++++++
>  kernel/bpf/cgroup.c            | 30 ++++++++++++++++++++++++++----
>  kernel/bpf/syscall.c           |  4 ++--
>  kernel/cgroup/cgroup.c         |  5 +++--
>  tools/include/uapi/linux/bpf.h | 10 ++++++++++
>  6 files changed, 54 insertions(+), 9 deletions(-)
>

[...]
