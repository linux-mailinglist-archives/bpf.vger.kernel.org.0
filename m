Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078EE302950
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 18:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbhAYRut (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 12:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbhAYRuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 12:50:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75BF622EBD
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611596979;
        bh=zuyRHftsqVWCQjq18XklCtmYkyBWLlstKHGMnVWyIhU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NtztpnmERvAG+Cu5ZQgPtvxJnbhIc0D5b2rZxAfyC7FjfqSf9U7aW+mGY/epm3Mx2
         9HgkT+7I7QMHsq01AmYpqYRUnfNRwPAbF7neKs67HnHmdC0rbr5bxTf/+rvujufQE3
         AbZAHOViddhFAZNq9mlwTOapAnzvJeyDc1v1GlgsDeOmFpTlrDFRMQbJA46DXiDKGX
         W9Y1c8raPjWgA+cVc8qsqeOHlUf1+BhH7iB276EpqCGkUcknlPOR+jeDMwtgsTdy8S
         i3yXlVRXDyXYnRz4PkPPlwVTgs/31UxDbWc5lDoGg0Y9+EGvWUuvT7hp5BzSDlA4hJ
         LTwUDemWDExWQ==
Received: by mail-lj1-f178.google.com with SMTP id t8so9033135ljk.10
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 09:49:39 -0800 (PST)
X-Gm-Message-State: AOAM530FsRTYjMC5FkKOEvgvB8XV4IJh6Hn4rHoozq4A9J/FXuvk5Xqh
        c1+3n0MkUe2KDHg8+zZZmSJMF9YOmY4sTuH9mmEg7A==
X-Google-Smtp-Source: ABdhPJzCKGQ60lMer0NxdTG1QVtvRZKsUtiEFk5qlpzoTCsaG5EwRDumBYPDFKvTostFYe0kM9lQRf1vMb8y2QQgCiU=
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr693442ljs.468.1611596977707;
 Mon, 25 Jan 2021 09:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20210122123003.46125-1-mikko.ylinen@linux.intel.com>
 <CACYkzJ6sMBvZ_ZG9++jwpQ+JQL3PL02okhD0O5Ftz4Hd7jEC3Q@mail.gmail.com>
 <CACYkzJ5i6DNxY3D3SqiO_LO2HBbA-EgPFdK8ZBcFNmTVWweucg@mail.gmail.com> <YA5rXLwy4mcgcvLx@outtakka>
In-Reply-To: <YA5rXLwy4mcgcvLx@outtakka>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 25 Jan 2021 18:49:26 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6q53qwEvTjvNP_d5O+ytQM=jFVRQ9PV2+ie6Ah5VDnRA@mail.gmail.com>
Message-ID: <CACYkzJ6q53qwEvTjvNP_d5O+ytQM=jFVRQ9PV2+ie6Ah5VDnRA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Drop disabled LSM hooks from the sleepable set
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 7:55 AM Mikko Ylinen
<mikko.ylinen@linux.intel.com> wrote:
>
> On Sat, Jan 23, 2021 at 12:50:21AM +0100, KP Singh wrote:
> > On Fri, Jan 22, 2021 at 11:33 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > On Fri, Jan 22, 2021 at 1:32 PM Mikko Ylinen
> > > <mikko.ylinen@linux.intel.com> wrote:
> > > >
> > > > Networking LSM hooks are conditionally enabled and when building the new
> > > > sleepable BPF LSM hooks with the networking LSM hooks disabled, the
> > > > following build error occurs:
> > > >
> > > > BTFIDS  vmlinux
> > > > FAILED unresolved symbol bpf_lsm_socket_socketpair
> > > >

[...]

>
> Agree, a way to get the set automatically created makes sense. But the
> extra parameter to LSM_HOOK macro would be BPF specific, right?
>

The information about whether the hook "must not sleep" has been
mentioned sporadically in comments and

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/lsm_hooks.h#n920
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/lsm_hooks.h#n594

I think it would be generally useful for the framework to actually provide this
in the definition in the hook and then ensure (by calling
might_sleep() for hooks
that can sleep).

- KP

> -- Regards, Mikko
