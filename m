Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE7A49469F
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 05:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiATE6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 23:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiATE6h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 23:58:37 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4198C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 20:58:30 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e79so5560969iof.13
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 20:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUSs88B+D/g7McmnwpEJFRzLbLql+R+MkRCCHsKoCFA=;
        b=IA5+JsPJRkh4PF/EmKJB0CVZquRatQfgqRwdtt/S2jNEAeZjUvbxZQHt0pZo1sAikv
         R61OY9OOfLNbS7JsaDGhSmK0SxAucjpdQusViOARXNNT8gHEMKnQNW8hEBnbwH+xrQTM
         Pxd/UF0lUHks3IOAeM2nCEM0HTql139sfmusalCxYSU0tlk8CB/jPfYHLD0azftarp13
         AYVm1WjV3W0BWP7cZDfDS7SB2oLi4XvY0Mbr3J4KXpR5dYCz3uYJhogO+mmPUNcelQJR
         55XvGEfCzypFqFo793BQ4uEMlbaXmwoEHJHkD2cA+zs4pC8v8ChOGvsRkSxrcavoXm8K
         4/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUSs88B+D/g7McmnwpEJFRzLbLql+R+MkRCCHsKoCFA=;
        b=C+eJ76mIMlDGZwrWvVdRyjLIExAmYnSzf9RBIiwX+zqNe4VeDnmBZoYy0KUnZskxH4
         BqoOC0VcEuHWpgbRdHFvjywI3K92jET1O+yrq/CqTFEYmUk4uks6aY1CSqWdQCljLwCI
         wzFBfpMvCDOn07qd+J9euj187pAFcVJUIbPtFasA5ihQXCMjJUmoRPLzkoqXyybSIKAL
         FzsHya6uiFN63RUvYOes6Sydd46NR1Ogpq4+VXZVN3kOn7YkiSE3XyjUR8TCsOEm/nwR
         AMmsQl/tsH6Dj0osWW7aEvpHjUU8wRlJ4taHCgOh31EwkOzO7zr2sKMTW2nEjYAdrlz+
         EWog==
X-Gm-Message-State: AOAM531Vyd5oEaMU8Z3qfn4u7TK/7pt0RHVKF5zWU48JwKwbOULLuwv4
        eo1Uthyc1qrExbQZuvAmZOCsRPotQpoithdxuFk=
X-Google-Smtp-Source: ABdhPJwEeZQ7qad4qADx3WpSzQsTzr6BjkEnp0FdnwaP2zzRK/bPemL6lTu9ll/wgKAIeITarRDlkThMVRwKAphYj/o=
X-Received: by 2002:a02:ca03:: with SMTP id i3mr16107166jak.234.1642654709387;
 Wed, 19 Jan 2022 20:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20220119225741.2944240-1-andrii@kernel.org> <20220119225741.2944240-5-andrii@kernel.org>
 <f826dd2e-b97a-7f6c-f725-555303f02e27@fb.com>
In-Reply-To: <f826dd2e-b97a-7f6c-f725-555303f02e27@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Jan 2022 20:58:18 -0800
Message-ID: <CAEf4BzYsM_tatKi1QG-diVeuK+STHam7iXT9ROFO_9S+PVY+wg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] docs/bpf: update BPF map definition example
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 8:01 PM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 1/19/22 2:57 PM, Andrii Nakryiko wrote:
> > Use BTF-defined map definition in the documentation example.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   Documentation/bpf/btf.rst | 21 +++++++++------------
> >   1 file changed, 9 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> > index 1ebf4c5c7ddc..07165682da2b 100644
> > --- a/Documentation/bpf/btf.rst
> > +++ b/Documentation/bpf/btf.rst
> > @@ -565,18 +565,15 @@ A map can be created with ``btf_fd`` and specified key/value type id.::
> >   In libbpf, the map can be defined with extra annotation like below:
> >   ::
> >
> > -    struct bpf_map_def SEC("maps") btf_map = {
> > -        .type = BPF_MAP_TYPE_ARRAY,
> > -        .key_size = sizeof(int),
> > -        .value_size = sizeof(struct ipv_counts),
> > -        .max_entries = 4,
> > -    };
> > -    BPF_ANNOTATE_KV_PAIR(btf_map, int, struct ipv_counts);
>
> There is another bpf_map_def in btf.rst.
> Maybe convert it as well? Especially considering it's an example of
> BTF enabled pretty printing.

My bad, not sure how I missed it while grepping. I'll convert that one
as well in v2.
