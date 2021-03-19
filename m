Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543CF34143F
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 05:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCSEg7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 00:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSEgu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 00:36:50 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17FEC06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 21:36:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id c131so4924934ybf.7
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 21:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jqnYKbGiH3h2lUpJqvNIE5MUwtPFLnPoQXOjLXSyJBQ=;
        b=IgzNpG66RQgCG7djbAmATFDswb8QcjsrHciJ0WEjfM+4neZZavQoxYf7bN6ZtQepDF
         85+/46EpsGhlq9MiEY8lNNZn1+9aUvo6gHPOelbZirpAO7eGJ0R66H/n3ydpQaMmAdXU
         c6byGhNOUnCdSK8yo4O4ZMHOHzEnuBv0Mm3t7u7zSQ62ObGWbjaDT+pIsjW8f8KgY158
         7KDOMU5ep5Qb/p7PUv+ZdtCidyjfzpsD6V6nyvlOnFP5klPuNAwoZNFG3l3NKar9iUl6
         mWPQIJ+R0+aMC/AX0tyzYYFvpWFqOvQgiFvwYpz+LW5VVPNsqpY17GCZl48Md/LKefFC
         2rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jqnYKbGiH3h2lUpJqvNIE5MUwtPFLnPoQXOjLXSyJBQ=;
        b=CXMW6pH9JGzH6lDAhgdIysp2lWR4hOqBrlahN3vHZOwFBTbhEBPUYf/GBsKZzvJmhg
         b8kvY9KxKctlDzLpHCxr8xaVpwYXjooR5n1kNq4EEzEdlTQm8fbCdicRnGLrqXllsN9b
         fbp1PpeVrDv9vPoRUnzk6ngxsP9zN7FKswSrKmZxZgEhZ4aqpGtHBajvd9EVSqKN2HS9
         8IiMo1xFNTeKDwpDtl8s74uE3MVFuKCAK8lyKdKd5X4ZuoE6HIHRZxoksMSFtAidVQ11
         Wpsm485J+CYUeZkXjsZo/JKPO63F9ZGnRhnoL8GR8d+OnFdGl9SlzzmbUL0QBudkse8K
         NejA==
X-Gm-Message-State: AOAM532JIDQiertRy4Ok/wOj3wnC4QFQqc/GvRpZgUYwjfSK9nT19yp0
        X2w57LO5uSxHjW80nn2nTXfAomYmsSBt1Y4fafA=
X-Google-Smtp-Source: ABdhPJzd3QTftDcJscyuMrwBrRyL/gGwPtcdbSt7y5u5DKxK9VlTqSoTE3OAszy57LHy7WdAeyQ8CHg5UKP1Wrbwwas=
X-Received: by 2002:a25:4982:: with SMTP id w124mr3778182yba.27.1616128609042;
 Thu, 18 Mar 2021 21:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com> <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
 <043B1B9B-EEF7-49CD-88AF-29A2A3E97304@ubuntu.com> <67E3C788-2835-4793-8A9C-51C5D807C294@ubuntu.com>
 <CAEf4BzaPytBkMqDh15eLPskOj_+FQa0ta2G+BToEn1pSwMGpfA@mail.gmail.com>
 <7BEF1010-5D4A-4C6F-8059-BD18A4A9EA6F@ubuntu.com> <CAEf4BzYDNQwTBmd_gG5isqfy0JPrW+ticu=NUvqhvbYmLOWC-g@mail.gmail.com>
 <CFD47A17-D20D-49FB-A357-5476C8EE02AF@ubuntu.com> <B4B873B5-464D-46D7-A0DC-841B08FA34AD@ubuntu.com>
In-Reply-To: <B4B873B5-464D-46D7-A0DC-841B08FA34AD@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Mar 2021 21:36:38 -0700
Message-ID: <CAEf4Bza0g--Pdt8rYEY+HrzB7_YBuzudyVSR3em-7JQDzcSY3w@mail.gmail.com>
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 17, 2021 at 7:31 AM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
>
> >>
> >>>> From what I see all the CO-RE relocations applied successfully (even
> >>>> though all the offsets stayed the same, so presumably you compiled
> >>>> your BPF program with vmlinux.h from the exact same kernel you are
> >>>> running it on?). Are you sure that vmlinux image you are providing
> >>>> corresponds to the actual kernel you are running on?
> >
> > FOUND the cause of the issue=E2=80=A6
> >
>
> ...
>
> >
> > bpf_check():
> >
> > if (log->len_total < 128 || log->len_total > UINT_MAX >> 8 || !log->lev=
el
> > || !log->ubuf)
> >
> > and a simple change in libbpf (mitigation of course):
> >
> >   attr.log_buf =3D 0;
> >   attr.log_level =3D 0;
> >   attr.log_size =3D 0;
> >
> > before
> >
> > fd =3D sys_bpf_prog_load(&attr, sizeof(attr));
>
> With instrumented kernel=E2=80=A6 no changes to libbpf or code:
>
> attr.log_buf =3D (nil)
> attr.log_level =3D 0
> attr.log_size =3D 0
> load_attr.log_buf =3D 0x7fd1c0a92010
> load_attr.log_level =3D 0
> load_attr.log_size =3D 16777215
> libbpf: load bpf program failed: Invalid argument
> libbpf: failed to load program 'ip_set_create'
> libbpf: failed to load object 'mine_bpf'
> libbpf: failed to load BPF skeleton 'mine_bpf': -22
> failed to load BPF object: -22
>
> [   27.857858] MINE: BPF_PROG_TYPE_KPROBE KERNEL VERSION ISSUE
> [   27.857993] MINE: LINUX_VERSION_CODE: 266002
> [   27.858131] MINE: YOUR VERSION: 265984
>
> 2 problems here:
>
> 0) attr.kern_version
>
> - looks like for some reason attr.kern_version is different from
> the one running
>
> - bypassing kernel BPF_KPROBE version check, I get:
>
> 1) load_attr has log_buf and log_size but not log_level for some reason.
>
> - this triggers an issue in bpf_check() within kernel IF I bypass
> the BPF_KPROBE version check (kerne 4.15).
>
> NOW, If I hard-code attr.kern_version in bpf.c to:
>
> attr.kern_version =3D 266002;
> fd =3D sys_bpf_prog_load(&attr, sizeof(attr));
>
> then
>
> attr.log_buf =3D (nil)
> attr.log_level =3D 0
> attr.log_size =3D 0
> load_attr.log_buf =3D (nil)
> load_attr.log_level =3D 0
> load_attr.log_size =3D 0
> Tracing... Hit Ctrl-C to end.
>
> I don=E2=80=99t have the 2 problems, as log_level is zeroed, together wit=
h
> log_buf and log_size.
>
> Any clue on why this happens ?

So seems like you figured out kernel_version check, right? And it
seems like log_buf is not really a problem as well? Or it still
causing issues?

>
> Thank you!
>
> -rafaeldtinoco
>
