Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A941E12D3C8
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 20:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfL3TP0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 14:15:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38007 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfL3TP0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 14:15:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so8669580oii.5
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 11:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8VNPmQpB/nhZUKa/jEyRPflBQQk4BiG2bU5Mb23sZI=;
        b=TrUeJBtYQrhGzh9bo/B1sO67yNnIt1G5Zq9WRF6nvkZcUR6pWDDa+fWAGu0DWTCQ58
         tzBhNoxl1KdV90x1wXcm/AHv9kB5yLfnupfaa3D+qkb9LQ3CZJGqdf11DZWsGdFwG8FK
         N+79hxkfhaRxWj4KVx6cNl5Wg6kABBwrGJM7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8VNPmQpB/nhZUKa/jEyRPflBQQk4BiG2bU5Mb23sZI=;
        b=ePy/N9MfdKbuMf6LiSZECwbPV8tFwyf/qAw32UUywapJaZle42IrgeUHzW6Neh9UGv
         Jo26SI8p6dCI5z1J/2ezjPclr2mEqzPEbC5JN8PDilE4gvtM1SJ3FLk+rJbPz7fA+VNN
         nfQ+Uab1USV+hEScB5kUeHPx/ezNyPN6UPzso4ICf+6zdMGqtIvvWKB1TaclYuXAZwVu
         wkrqx4FaDNYm3s0C6laXwJaPwMNPCf3VMW7uJg1fRqF3nHuvTTbzVKy8pbmQ2uAbOb5N
         2tgHUJ37TbsahXqBtPjSL5ZIZMLIRv47noR2mqUuxhoDkTVgUIMr/UZxzpkTb2E/H32C
         AX1A==
X-Gm-Message-State: APjAAAUoB5Uxsp2k5FcpmwnE4b1EFfbpX83YfFrJPAgXdDOCqkzdOH5M
        zE/umbPASirThSGEGP5nUzJYJJPtRO4=
X-Google-Smtp-Source: APXvYqzHMhG2XB4gSSLkVkurcTS/kbf5+0VXeJOTvIqteere+/f7siDcsi2gN/gxmI1SnlIUiZ5MEQ==
X-Received: by 2002:aca:4c15:: with SMTP id z21mr282394oia.8.1577733325313;
        Mon, 30 Dec 2019 11:15:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w8sm15888580ote.80.2019.12.30.11.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:15:24 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:15:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
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
Message-ID: <201912301112.A1A63A4@keescook>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com>
 <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 06:38:45PM +0100, KP Singh wrote:
> Hi Casey,
> 
> Thanks for taking a look!
> 
> On Fri, Dec 20, 2019 at 6:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 12/20/2019 7:41 AM, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > This patch series is a continuation of the KRSI RFC
> > > (https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/)
> > >
> > > # Motivation
> > >
> > > Google does rich analysis of runtime security data collected from
> > > internal Linux deployments (corporate devices and servers) to detect and
> > > thwart threats in real-time. Currently, this is done in custom kernel
> > > modules but we would like to replace this with something that's upstream
> > > and useful to others.
> > >
> > > The current kernel infrastructure for providing telemetry (Audit, Perf
> > > etc.) is disjoint from access enforcement (i.e. LSMs).  Augmenting the
> > > information provided by audit requires kernel changes to audit, its
> > > policy language and user-space components. Furthermore, building a MAC
> > > policy based on the newly added telemetry data requires changes to
> > > various LSMs and their respective policy languages.
> > >
> > > This patchset proposes a new stackable and privileged LSM which allows
> > > the LSM hooks to be implemented using eBPF. This facilitates a unified
> > > and dynamic (not requiring re-compilation of the kernel) audit and MAC
> > > policy.
> > >
> > > # Why an LSM?
> > >
> > > Linux Security Modules target security behaviours rather than the
> > > kernel's API. For example, it's easy to miss out a newly added system
> > > call for executing processes (eg. execve, execveat etc.) but the LSM
> > > framework ensures that all process executions trigger the relevant hooks
> > > irrespective of how the process was executed.
> > >
> > > Allowing users to implement LSM hooks at runtime also benefits the LSM
> > > eco-system by enabling a quick feedback loop from the security community
> > > about the kind of behaviours that the LSM Framework should be targeting.
> > >
> > > # How does it work?
> > >
> > > The LSM introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
> > > program type, BPF_PROG_TYPE_LSM, which can only be attached to a LSM
> > > hook.  All LSM hooks are exposed as files in securityfs. Attachment
> > > requires CAP_SYS_ADMIN for loading eBPF programs and CAP_MAC_ADMIN for
> > > modifying MAC policies.
> > >
> > > The eBPF programs are passed the same arguments as the LSM hooks and
> > > executed in the body of the hook.
> >
> > This effectively exposes the LSM hooks as external APIs.
> > It would mean that we can't change or delete them. That
> > would be bad.
> 
> Perhaps this should have been clearer, we *do not* want to make LSM hooks
> a stable API and expect the eBPF programs to adapt when such changes occur.
> 
> Based on our comparison with the previous approach, this still ends up
> being a better trade-off (w.r.t. maintenance) when compared to adding
> specific helpers or verifier logic for  each new hook or field that
> needs to be exposed.

Given the discussion around tracing and stable ABI at the last kernel
summit, Linus's mandate is mainly around "every day users" and not
around these system-builder-sensitive cases where everyone has a strong
expectation to rebuild their policy when the kernel changes. i.e. it's
not "powertop", which was Linus's example of "and then everyone running
Fedora breaks".

So, while I know we've tried in the past to follow the letter of the
law, it seems Linus really expects this only to be followed when it will
have "real world" impact on unsuspecting end users.

Obviously James Morris has the final say here, but as I understand it,
it is fine to expose these here for the same reasons it's fine to expose
the (ever changing) tracepoints and BPF hooks.

-Kees

-- 
Kees Cook
