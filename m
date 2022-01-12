Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F8948CAC6
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356069AbiALSPe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 13:15:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56988 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356092AbiALSPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 13:15:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7F061990
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 18:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CD1C36AEF
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642011319;
        bh=ugSQf4ebuen2eDPDEx7UAqoM0tcCG/uNaB1wpfVX1cU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ntj1yx5LRecRjMJyiYsMhAcryV3MK4oG4RP17rErriNncf0X9Roof0p5V1Bip5sPG
         MHjI8QNJ3+WbPLcp2eRL/kreA0+PQPK5UfKJlpebdXrReH57S9OLcQJNvS7THcnOgr
         NDU6vtSQv3RrNvO9eiN6L+PkBcP4uDrtt89+Rfzr8tPShNIK4n3makRIZguLbQeHSk
         mh2hB84izScogrd5f6787rlCKPWg5drY67FhTf+FbCyfVWje63dN2OhqgwkJfUOmnt
         ds5PO5LnF6orXz3XioA6QzHuo06qHsS5NOGEzHadAgu3Boz8JvlHVvdNX6aZx/1FRi
         6EjTyaVEI11tQ==
Received: by mail-yb1-f181.google.com with SMTP id c6so8011876ybk.3
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 10:15:19 -0800 (PST)
X-Gm-Message-State: AOAM533Vx2SQCdJgSYMv9lemkRAkWu7AzwHrVLqaawceUfkgK1vlX7VO
        50LUK7MqHEN1rmY9vZF+6Dt5xPNQHL7LcC9aGh8=
X-Google-Smtp-Source: ABdhPJwGhOj7+FPOMaXL/UZgM0SHkUBzWWdZa/wVWHIJC2JiKZQnqAqEvxxFC2Y6ECTxyAK4bbWIL2blQVpMOuITpqM=
X-Received: by 2002:a25:287:: with SMTP id 129mr1165423ybc.670.1642011318630;
 Wed, 12 Jan 2022 10:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20220112114953.722380-1-usama.arif@bytedance.com> <6586be41-1ceb-c9d3-f9ea-567f51dbab49@isovalent.com>
In-Reply-To: <6586be41-1ceb-c9d3-f9ea-567f51dbab49@isovalent.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 12 Jan 2022 10:15:07 -0800
X-Gmail-Original-Message-ID: <CAPhsuW73qDOOrp2tSEZav_i2ySarUH91RRBhZjFwOtrwEGzREw@mail.gmail.com>
Message-ID: <CAPhsuW73qDOOrp2tSEZav_i2ySarUH91RRBhZjFwOtrwEGzREw@mail.gmail.com>
Subject: Re: [PATCH v6] bpf/scripts: raise an exception if the correct number
 of helpers are not generated
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Usama Arif <usama.arif@bytedance.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, joe@cilium.io,
        fam.zheng@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 12, 2022 at 4:15 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> 2022-01-12 11:49 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
> > Currently bpf_helper_defs.h and the bpf helpers man page are auto-generated
> > using function documentation present in bpf.h. If the documentation for the
> > helper is missing or doesn't follow a specific format for e.g. if a function
> > is documented as:
> >  * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
> > instead of
> >  * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
> > (notice the extra space at the start and end of function arguments)
> > then that helper is not dumped in the auto-generated header and results in
> > an invalid call during eBPF runtime, even if all the code specific to the
> > helper is correct.
> >
> > This patch checks the number of functions documented within the header file
> > with those present as part of #define __BPF_FUNC_MAPPER and raises an
> > Exception if they don't match. It is not needed with the currently documented
> > upstream functions, but can help in debugging when developing new helpers
> > when there might be missing or misformatted documentation.
> >
> > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks!
