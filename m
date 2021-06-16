Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCFD3AA293
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFPRnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 13:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhFPRnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 13:43:03 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF5AC061574;
        Wed, 16 Jun 2021 10:40:57 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g142so4165611ybf.9;
        Wed, 16 Jun 2021 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gFQIbthgDL9kFR7z0ls3/0K8b9CI35QF/o7QJi13Y0=;
        b=CPUMIwUK0F1GNkltwAzFo/Fx4eHWgVgLbDR87nyML3jefAopNXfWvWfpkKjLvAo0Sc
         Ifg3qVD5E+xnIn+hKb8sUeE3JiO11P4H8yh5seGJJWS5SLGHkfMD8Ie9zcYBIDngh64n
         I1PaB7MZvcieDnV+/MS9dkObrKTzg9nbekjjxfdC7s0Dx9vrAoAiej65Fb3i8uC1bUet
         GCEvez25xjibRMUa21w3J6/LKKzY1aVvMvyjZM+S0/iOhQDUCxaNwSBY27tI56xG493o
         bzPF9iVqAIpdZxQ9lHxpQTvLY6ZC8W3L7cDQSK3nB36oveDPkPMMXIK1r84jZBsi8BZw
         NYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gFQIbthgDL9kFR7z0ls3/0K8b9CI35QF/o7QJi13Y0=;
        b=EFogBV1PyS/ZMWebYYR7zlcVIPMMGNHpqt9YkLdfD9okzJ36cFdcc33DyO1Hm9L0+w
         SfvKjttoZgIswHLj3+QULPgTOnXEbZ36NITbCCD1ISQDtIx/DO4w6SFo4lJbkcnqCb76
         w1qRsiNQKS5uM6ocdURad/OZqRS4Aq2Sq1AKPlwKdY/qx9UZxd8pUA5yyT2wcBnKG/zi
         5ueriiFGJinvQW6lo44pxI8VB/yLI9U/04I7qEKu+gZWmZMG9eCkQTdqvwwKvjAcamWW
         9iRQ9eXb0d4ERgV9UAT64L1dPwVgEjv45bCYazfD3v4nY8W+Nee1a/Qy4yJ1goK9hCQD
         JaFg==
X-Gm-Message-State: AOAM5323OEmu5voN/8qGOkGb9oV+XAqeGURqk70hTlRTeAdQq/XsDRFP
        +708OLdJ3DyfQDTUAsio164vdhlTtRD+7l6maPI=
X-Google-Smtp-Source: ABdhPJxVXYBw/fVZrIzO5zWE3tVWcAxtk3I2BLnNoi9pMj+D3FAwXrp/ozMuRP589fkOvh2GYSYlg9ZxEOBxcH8q1aE=
X-Received: by 2002:a25:6612:: with SMTP id a18mr210145ybc.347.1623865256720;
 Wed, 16 Jun 2021 10:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org>
In-Reply-To: <YMoRBvTdD0qzjYf4@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Jun 2021 10:40:45 -0700
Message-ID: <CAEf4BzZ7KDcsViCY8MbUZuWu2BdkjymkgJtyVUMBrCaiimUCxQ@mail.gmail.com>
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 7:56 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Jun 15, 2021 at 04:30:03PM -0700, Andrii Nakryiko escreveu:
> > Hey Arnaldo,
> >
> > Seems like de3a7f912559 ("btf_encoder: Reduce the size of encode_cu()
> > by moving function encoding to separate method") break two selftests
> > in libbpf CI (see [0]). Please take a look. I suspect some bad BTF,
> > because both tests rely on kernel BTF info.
> >
> > You've previously asked about staging pahole changes. Did you make up
> > your mind about branch names and the process overall? Seems like a
> > good chance to bring this up ;-P
> >
> >   [0] https://travis-ci.com/github/libbpf/libbpf/jobs/514329152
>
> Ok, please add tmp.master as the staging branch, I'll move things to
> master only after it passing thru CI.
>

So I'm thinking about what's the best setup to catch pahole staging
problems, but not break main libbpf CI and kernel-patches CI flows.

How about we keep all the existing CI jobs to use pahole's master.
Then add a separate job to do full kernel build with pahole built from
staging branch. And mark it as non-critical (or whatever the
terminology), so it doesn't mark the build red. I'd do that as a cron
job that runs every day. That way if you don't have anything urgent,
next day you'll get staging tested automatically. If you need to test
right now, there is a way to re-trigger previous build and it will
re-fetch latest staging (so there is a way for you to proactively
test).

Basically, I want broken staging pahole to not interrupt anything we
are doing. WDYT?

> Now looking at that code, must be something subtle...
>
> - Arnaldo
