Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E25512D155
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 16:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfL3PE3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 10:04:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfL3PE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 10:04:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so32896572wrm.11
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8+MR8QpDYRl1K4CKbQs7az/sCFuxDTT5Mi/1afsWgo4=;
        b=Y3AiIw0VpkhEo5XfGpafqapJfq3WnOagdT57zYHbZqyED5lbTT1s7kqb8CcN1h3Kjk
         3UNGbVf5Os5EyNc4IQTTde2lxLW5qbfC5rlmFd29UfLuXDnR6Q/7hxhl9anA3of4XDfz
         uaIBWT8pF5eFFXHD2GXEPrMrLXoC78nEEJv9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8+MR8QpDYRl1K4CKbQs7az/sCFuxDTT5Mi/1afsWgo4=;
        b=uUOg41YQl9GFBthPf9llWaOfrqiprZO6RFLF7g2blL8B1Qt1AI4l9a8dbFMEWOy0UQ
         GFLt++1MKhFV1G5SQHgWG6gwJV8mxY8jwq5sMVFgRHq25JcNFQYVUD0dK+ya/0kQw7Nx
         wSNL6FxvpXeCGIVu8H1C6+UBZK1Fr41dVLSGmdQinIMzXhuM0KxRhJqKPXqyKu1A0hh4
         aRP1XaKuEiK2u7N6hJzUFvD+xAV0BqIhFFQ4vntyu+oYic0lG3CNEGl2pqqyLYHlhpaL
         PEqLUbisOEHtIOdxu20i4ZNPb8nWUku4Meo/tYwUyxXkt4D3q+r9CzbwUm6zUKRSChKB
         dHqw==
X-Gm-Message-State: APjAAAWN345MPhllxRmwqDxbHp6U0CsQ+cfpi6sS+UZOYS8wRPuaKpwB
        yX7ERK7AIxBKPilAZCFCN4VIRg==
X-Google-Smtp-Source: APXvYqyRETMke4ntb1hP/F2ZQWDMdwJ3pOihAaK17lB88wFxNFcfzWHy8NTG46xLtLWvIc6NBVQo1g==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr72512584wrp.17.1577718267244;
        Mon, 30 Dec 2019 07:04:27 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id c15sm46419168wrt.1.2019.12.30.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 07:04:26 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 30 Dec 2019 16:04:24 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
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
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
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
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20191230150424.GB70684@google.com>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <CAEf4BzYiUZtSJKh-UBL0jwyo6d=Cne2YtEyGU8ONykmSUSsuNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYiUZtSJKh-UBL0jwyo6d=Cne2YtEyGU8ONykmSUSsuNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23-Dec 22:51, Andrii Nakryiko wrote:
> On Fri, Dec 20, 2019 at 7:42 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > This patch series is a continuation of the KRSI RFC
> > (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/)
> >
> 
> [...]
> 
> > # Usage Examples
> >
> > A simple example and some documentation is included in the patchset.
> >
> > In order to better illustrate the capabilities of the framework some
> > more advanced prototype code has also been published separately:
> >
> > * Logging execution events (including environment variables and arguments):
> > https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> > * Detecting deletion of running executables:
> > https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c
> > * Detection of writes to /proc/<pid>/mem:
> > https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> 
> Are you planning on submitting these examples for inclusion into
> samples/bpf or selftests/bpf? It would be great to have more examples
> and we can review and suggest nicer ways to go about writing them
> (e.g., BPF skeleton and global data Alexei mentioned earlier).

Eventually, yes and in selftest/bpf.

But these examples depend on using security blobs and some non-atomic
calls in the BPF helpers which are not handled as a part of the
initial patch-set.

Once we have the initial framework finalized, I will update the
examples and the helpers they are based on and send these separate
patch-sets on the list for review.

- KP

> 
> >
> > We have updated Google's internal telemetry infrastructure and have
> > started deploying this LSM on our Linux Workstations. This gives us more
> > confidence in the real-world applications of such a system.
> >
> > KP Singh (13):
> >   bpf: Refactor BPF_EVENT context macros to its own header.
> >   bpf: lsm: Add a skeleton and config options
> >   bpf: lsm: Introduce types for eBPF based LSM
> >   bpf: lsm: Allow btf_id based attachment for LSM hooks
> >   tools/libbpf: Add support in libbpf for BPF_PROG_TYPE_LSM
> >   bpf: lsm: Init Hooks and create files in securityfs
> >   bpf: lsm: Implement attach, detach and execution.
> >   bpf: lsm: Show attached program names in hook read handler.
> >   bpf: lsm: Add a helper function bpf_lsm_event_output
> >   bpf: lsm: Handle attachment of the same program
> >   tools/libbpf: Add bpf_program__attach_lsm
> >   bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
> >   bpf: lsm: Add Documentation
> >
> 
> [...]
