Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AFF45288D
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 04:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhKPDav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 22:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbhKPD3h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 22:29:37 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358E5C0F26D2
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 15:54:45 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 193so18702534qkh.10
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 15:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+/bouhr0g6roUEU7Fddd7LC5VyrkOdz3lZQw0/47D8=;
        b=X285JdSttOtPBvl6Z1jxhKa4UksVYcC6cheVD+x7w8JTfkR+g4zcNetpvvcOddfAjJ
         g4AEppYcYULq+CtMLNAdIkevdKqI2PMjIyS6zeDmOISVyGNTmG6wYRflgFP5uoXfixKr
         1y6JSteSx62JQX/z1uXe+Rp77T15dFPUpUWnD7t6Lraglg+sOtKkT827sEs6Y4bJjSix
         D4ahoQJIBL83k18eg1yXjk/74Qe9U0HpVjC1ny5lBAtR/V8RGvW8qqEvoiuZsb3Re97w
         Uk1cMeADoPiw9AEogBLlXGHr08UNVUnrbDWlmctlIzHkNla6W+PpHvTiY+XzWOAUF6ro
         DXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+/bouhr0g6roUEU7Fddd7LC5VyrkOdz3lZQw0/47D8=;
        b=IM/Y3720ENzO5a/XawLH9rMECarA/Cfqc2oBbExk1eBWfw5qZGpeS0aeA1T7X9gRxV
         9piu0+QCVb7c3C+aVCSlDW2tK7TSC/lHKkmZcKTqeSdzwo7sd89A+Eg+Qfm1vdjOzkXJ
         7/wqUvYphop1Sg66CyxMKlpcIzBb2sXOumflbMrTTbz4+BRpGIr0CApIDV5veAcDHfhG
         eXOAkadKahnMbe+/LH2NInCqYW+22UxR6mqCz3RqYhHRjnHOORF7nqGm2NC3y2VNaqhC
         jICihj6knbftGGvBe1FdgURmOEidX2giLicvBUd9MTS3H2Qt+52XGVWb8ncf6iDmWsmU
         o5jw==
X-Gm-Message-State: AOAM530F4uKHV7EC56tD1EcjHMrXz4cLFx7/eZ7Nzfcc+pym6kTKH8Wq
        8YI2SnyjTYEBBq7coOdvysRG+RL4gGLutS7yAF3klQ==
X-Google-Smtp-Source: ABdhPJzGnE/SBFJQSV7oGw6VVY2cWccREW/J1N/VsQZTOZgOwA2NJT3EYn7c5y6wyikTxrdQNRMsQMpNbo+Grp95vQ0=
X-Received: by 2002:a37:2750:: with SMTP id n77mr2587387qkn.490.1637020484118;
 Mon, 15 Nov 2021 15:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20211115193105.1952656-1-sdf@google.com> <CACdoK4L0YOKXbKdLdBgGpZd_nrVq39wiZ+KoWUtAHP2CsR6RCg@mail.gmail.com>
In-Reply-To: <CACdoK4L0YOKXbKdLdBgGpZd_nrVq39wiZ+KoWUtAHP2CsR6RCg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 15 Nov 2021 15:54:33 -0800
Message-ID: <CAKH8qBtR6tYXLWpnO4W69DxnxmEXZTad5H2oM7YT_DE0OHu+vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: add current libbpf_strict mode to
 version output
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 15, 2021 at 3:34 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On Mon, 15 Nov 2021 at 19:31, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > + bpftool --legacy --version
> > bpftool v5.15.0
> > features: libbfd, skeletons
> > + bpftool --version
> > bpftool v5.15.0
> > features: libbfd, libbpf_strict, skeletons
> >
> > + bpftool --legacy --help
> > Usage: bpftool [OPTIONS] OBJECT { COMMAND | help }
> >        bpftool batch file FILE
> >        bpftool version
> >
> >        OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }
> >        OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--legacy} |
> >                     {-V|--version} }
> > + bpftool --help
> > Usage: bpftool [OPTIONS] OBJECT { COMMAND | help }
> >        bpftool batch file FILE
> >        bpftool version
> >
> >        OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }
> >        OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--legacy} |
> >                     {-V|--version} }
> >
> > + bpftool --legacy
> > Usage: bpftool [OPTIONS] OBJECT { COMMAND | help }
> >        bpftool batch file FILE
> >        bpftool version
> >
> >        OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }
> >        OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--legacy} |
> >                     {-V|--version} }
> > + bpftool
> > Usage: bpftool [OPTIONS] OBJECT { COMMAND | help }
> >        bpftool batch file FILE
> >        bpftool version
> >
> >        OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }
> >        OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--legacy} |
> >                     {-V|--version} }
> >
> > + bpftool --legacy version
> > bpftool v5.15.0
> > features: libbfd, skeletons
> > + bpftool version
> > bpftool v5.15.0
> > features: libbfd, libbpf_strict, skeletons
> >
> > + bpftool --json --legacy version
> > {"version":"5.15.0","features":{"libbfd":true,"libbpf_strict":false,"skeletons":true}}
> > + bpftool --json version
> > {"version":"5.15.0","features":{"libbfd":true,"libbpf_strict":true,"skeletons":true}}
> >
> > v2:
> > - fixes for -h and -V (Quentin Monnet)
> >
> > Suggested-by: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> The behaviour will change in a few cases where both the help and
> version commands and/or options are provided, e.g. "bpftool -h
> version" used to print the help and will do the version instead,
> "bpftool -V help" changes in an opposite fashion. Given that there's
> no practical interest in having both commands/options, and that the
> behaviour was not really consistent so far, I consider that this is
> not an issue.
>
> However, we now have "bpftool --version" returning -1 (instead of 0).
> Any chance we can fix that? Maybe simply something like the change
> below instead?

That works as well. I didn't want to special case it, but agreed that
changing exit value might not be a good idea (I was assuming they
already return -1 and didn't check).
Will resend shortly with your version.
