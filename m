Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAAE129BE8
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 00:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLWXyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Dec 2019 18:54:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44608 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfLWXyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Dec 2019 18:54:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so14811575qkb.11;
        Mon, 23 Dec 2019 15:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mcgnDmPaOUoLIo0q5+kI3GIAi8x1GQTnol/ySjLHyE=;
        b=FRFXswF/v13KOQuIwVYTxNTuGoVL6iMSFUHCyGFWqLJmS29MmU+GRjSCqQtUiC7Qlp
         wOwdYFiyJB1iP1z5Nz+UEwMBoEYfQSy1xiZFUKwqNz3ZbTXSDPWdyE2+M5yPDaqwFO54
         s9Q+JuPFGb9EQUNsekfAWw2LZnjT6Ni8Ky/9MI1EDkqj24plXBhZGmzRcd62qZpjTdL0
         dy7QeOjUxnIyfMz+aovabcwp30JUqbBiFkJ+YW9ZKnPfNJh6AsUJEXEjvVhSgWdhXt8m
         dspuXqTA/6BaFJjVSTw0xhwQNUXNfMkNs1t+eFyrmblbOwOrzBxPnf7RVpV5v1+O3kI+
         qp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mcgnDmPaOUoLIo0q5+kI3GIAi8x1GQTnol/ySjLHyE=;
        b=MQCGeUfh5T+Y+IIkEfEvmRxd5GuOEFEoOWFPK2Xyanz3h56fWCX1ulLOvuK7oqynZz
         lP9yI7l2J7SV+i5A/dLvaqJBHSxYKttlVpX8ixwnGjKex8+ezqhiBIMqn8tJ94AeVipq
         jJw3ME7ElREGDDcVcKbRZ/0EqdLntgArc8fAWjWg9Bo2uTLJoU+CgbhPfZIGlfHVuh+K
         ZBIavtRcvV4I72AwYvhbLMt4GsIPvtWLKJDfnSEBUYOQz3gFaOdMQ4kMgugiuJjOs5qZ
         0ZPg36BohRpbAv9zGdgJmAlo+5h25VAjuVdO5GixNbOyZlOqgFf92ZxpQ7ZgzBqHmQRq
         G/RA==
X-Gm-Message-State: APjAAAVHiX9XqmAzDsYep4s4RtPGZ647EesKHA+xLdpQDCRXvdtUtU9m
        r6Qt/gibxVKfltu/wqKLCKQNGER/1N6XgBjQETA=
X-Google-Smtp-Source: APXvYqwQQXFsQONALOZNkTw2z4Oc5KDvM+ffjotivmCsWXmQnukgR5wiABHNoua5elFzRC2emLu2PSfIFIdC78Zy0Dw=
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr29062753qkj.36.1577145289375;
 Mon, 23 Dec 2019 15:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-5-kpsingh@chromium.org>
In-Reply-To: <20191220154208.15895-5-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 15:54:38 -0800
Message-ID: <CAEf4BzaJ7YdSofV9-_D5zGC4GrwRvdPY3xyx7p+1rPD=Km2aXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/13] bpf: lsm: Allow btf_id based attachment
 for LSM hooks
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
> Refactor and re-use most of the logic for BPF_PROG_TYPE_TRACING with a few
> changes.
>
> - The LSM hook BTF types are prefixed with "lsm_btf_"

btf_trace_ and btf_struct_ops all have btf_ first, let's keep this consistent.

> - These types do not need the first (void *) pointer argument. The verifier
>   only looks for this argument if prod->aux->attach_btf_trace is set.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  kernel/bpf/syscall.c  |  1 +
>  kernel/bpf/verifier.c | 83 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 80 insertions(+), 4 deletions(-)
>

[...]

> +
> +       t = btf_type_by_id(btf_vmlinux, btf_id);
> +       if (!t) {
> +               verbose(env, "attach_btf_id %u is invalid\n", btf_id);
> +               return -EINVAL;
> +       }
> +
> +       tname = btf_name_by_offset(btf_vmlinux, t->name_off);
> +       if (!tname) {

it can be empty, so better: !tname || !tname[0]

> +               verbose(env, "attach_btf_id %u doesn't have a name\n", btf_id);
> +               return -EINVAL;
> +       }
> +

[...]
