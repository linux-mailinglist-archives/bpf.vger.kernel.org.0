Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881552A4F7F
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 19:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgKCS7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 13:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgKCS7V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 13:59:21 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A1C0617A6
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 10:59:20 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id f9so23683911lfq.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yyz56LcDgE7MQ3P04W5uenRAxGknrqGGYLnUXqlXhlc=;
        b=OtsGcoUDGZrMZFYe0h9FmnR27BjPtYKNbzVr5SK58kdl/KCOM7OXW/ORkfWFkSG/a1
         gKqaqdvofNdsCPg+TMabv/xetMpSCObEnkjatwOBfdRZUFD7qNHPEvWgpsHHgoWKV3vS
         fHMcVijigA1xn50yT2L8FNPDm9EhxPXU4C8/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yyz56LcDgE7MQ3P04W5uenRAxGknrqGGYLnUXqlXhlc=;
        b=mPwECiVZY8cFc4wiTwmxm3Y4D9nX8aXYT3Tdo9FndSEh9OwpVInBYPdifurwgYGRLY
         /WjjCwnWZ3mAseGL/Q407cdTAoq9ISeUlWPkOGNbJi+e7NdUOLEVJjtWjEwgwzUCjPkA
         6qx04zvAWUoDQohg2YZhjM0mTtUAulNUycUdXEhEaaw/d/USH3sSXm+6PGmPKLI5ARPS
         oiFOblJhbfbfL5yrTgPg3+hcctVZXUv9guxJhpxhT+iGp9DLgOB1G5zKd8g4/Y7Vz7Yo
         Vs+LSeaUHolVtVd/GvyQPgDKa3W5DhyRCSqG9Vkn7zH4v37NJj5GXcxrCwVekuyhdqlY
         +oDg==
X-Gm-Message-State: AOAM532L1ywCDmIoR4qc0j28cukZGNREqQww9QyN50NuVTH5gdvyajPr
        wp4rKei5ZOPQk9BYvJBBte0F7bfMx6MNtLzG/RqHyQ==
X-Google-Smtp-Source: ABdhPJyU30GePaCOZy+p7IfzsvlaI4Kvz28/Isfz/jxGnRjVONlFEQHG7xFeMt5Pv3h+rq7v3ayxBh+WKQrOkBEwo/0=
X-Received: by 2002:a19:c80a:: with SMTP id y10mr8993128lff.329.1604429959075;
 Tue, 03 Nov 2020 10:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-8-kpsingh@chromium.org> <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 3 Nov 2020 19:59:08 +0100
Message-ID: <CACYkzJ6A5GrQhBhv7GC8aeeLpoc7bnN=6Rn2UoM1P90odLZZ=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 3, 2020 at 7:47 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 03, 2020 at 04:31:31PM +0100, KP Singh wrote:
> > +
> > +struct storage {
> > +     void *inode;
> > +     unsigned int value;
> > +     /* Lock ensures that spin locked versions of local stoage operations
> > +      * also work, most operations in this tests are still single threaded
> > +      */
> > +     struct bpf_spin_lock lock;
> > +};
>
> I think it's a good idea to test spin_lock in local_storage,
> but it seems the test is not doing it fully.
> It's only adding it to the storage, but the program is not accessing it.

I added it here just to check if the offset calculations (map->spin_lock_off)
are correctly happening for these new maps.

As mentioned in the updates, I do intend to generalize
tools/testing/selftests/bpf/map_tests/sk_storage_map.c which already has
 the threading logic to exercise bpf_spin_lock in storage maps.

Hope this is an okay plan?
