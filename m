Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2949B48A2B6
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 23:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345397AbiAJW0N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 17:26:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58610 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbiAJW0N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 17:26:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FAF8B8180F
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 22:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC27C36AF2
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641853570;
        bh=Yy9vhvdSWUoAdkNq1RqvMXdUU+tXDUzwGivddfPXKGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NJLR9PsHwHEgk4+Xq8bQwH9aPOzzeM2KrGoOtYNw5lSLc+tRRp92rHeVtGFrGsU8c
         Kb49Ksjk75fyzX0GcvkXUz7NXriSpFLQi5Xt8wWHbaDl3u/4Fe4YPKYXYCqPb8GLED
         VtDiibVGZ7mXQGYDTo+pT8+PduvceJqGqnbDW40DjQaJX+UhjZ7YXcki+O6NNxl/aI
         a8yQ3nEOZH7PBh+DZsmL0kp2kFVo4eQtJ51Qu46CFFAsraTYBDkw03dJ3G/Q1rrRKp
         67Pbnnr7DAewhqHmbQhUIQkbArMxgt5wMWJDw3PD7MLwiNL5ceypkCnAPC93aWDdkH
         z6UNlWRqMWGrA==
Received: by mail-yb1-f179.google.com with SMTP id i3so42046467ybh.11
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:26:10 -0800 (PST)
X-Gm-Message-State: AOAM530qZCT/DEtZA9cmKQolL+dYDBu7G2wQGuOUMoNo9JZpkAEtm5SE
        AyIWUWfOqEdLKOLHTJhrrIcuKRb7wSgiAQ3IlFM=
X-Google-Smtp-Source: ABdhPJwHZrP4areBByLUi5wU6zQFagixPhet5WFjwLaQ1Qick+FRij+TPfEhXB/JZaYX+J7LpWKrIelnWC/6LCOhnBo=
X-Received: by 2002:a05:6902:1106:: with SMTP id o6mr2713172ybu.195.1641853569738;
 Mon, 10 Jan 2022 14:26:09 -0800 (PST)
MIME-Version: 1.0
References: <202201060848.nagWejwv-lkp@intel.com> <20220108005854.658596-1-christylee@fb.com>
 <CAPhsuW5FQTLfs4P4GqMKxsakP82KuPGOrEcqX+zvAH1+VLf7aQ@mail.gmail.com> <CAPqJDZqf8-4DCe9J1jr7KekxqfBac3JBc+hx7a6qW4hoF6xPUQ@mail.gmail.com>
In-Reply-To: <CAPqJDZqf8-4DCe9J1jr7KekxqfBac3JBc+hx7a6qW4hoF6xPUQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 10 Jan 2022 14:25:58 -0800
X-Gmail-Original-Message-ID: <CAPhsuW747JiykdZRj4ReJfTMfdSbvZBCkyO2Fiiri5uVrt4jbw@mail.gmail.com>
Message-ID: <CAPhsuW747JiykdZRj4ReJfTMfdSbvZBCkyO2Fiiri5uVrt4jbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix incorrect integer literal used for marking
 scratched registers in verifier logs
To:     Christy Lee <christyc.y.lee@gmail.com>
Cc:     Christy Lee <christylee@fb.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        kbuild@lists.01.org, Linux-MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 10, 2022 at 2:13 PM Christy Lee <christyc.y.lee@gmail.com> wrote:
>
> On Mon, Jan 10, 2022 at 1:52 PM Song Liu <song@kernel.org> wrote:
> >
> > On Fri, Jan 7, 2022 at 4:59 PM Christy Lee <christylee@fb.com> wrote:
> > >
> > > env->scratched_stack_slots is a 64-bit value, we should use ULL
> > > instead of UL literal values.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Christy Lee <christylee@fb.com>
> >
> > The fix looks good to me. Thus:
> >
> > Acked-by: Song Liu <songliubraving@fb.com>
> >
> > However, the patch looks corrupted. Also, the subject is probably too
> > long (./scripts/checkpatch.pl should complain about it).
> >
>
> I just checked that even with an absurdly long subject (more than 200
> characters), ./scripts/checkpatch.pl doesn't complain. It only complains
> when the commit message body has longer than 75 characters but not the
> subject line.  What's the maximum subject line length?

Hmm..  you are right. I somehow thought there was a limit by checkpatch.
I would personally limit it to 75 characters though.
