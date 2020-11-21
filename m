Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045A22BBAC8
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 01:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgKUAVJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 19:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgKUAVJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 19:21:09 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A840C061A04
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 16:21:08 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id f11so15929144lfs.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 16:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drZa5velgen67wbuhgWCwO4H5ccjjMv2YMhC3r+McB0=;
        b=cRoBALPFmUDu+Z0/0D5ewnX7flXktvF13PyVjt5u+qRieTP0Df9B5Q4xmQWEdFtQwz
         TJP7P8SsG14kLwr778JOBowdh/blCruw5yQw9tafpanLY7lU392StpA1oIirOPMZdBjV
         3C9V7nVaotQBG4KcuwA02LzpTjj4j5IefgW4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drZa5velgen67wbuhgWCwO4H5ccjjMv2YMhC3r+McB0=;
        b=EJ7UOb4WfbdqWFopHIkZpOw8AIWBh+JUb1UgLUwtpfGcvM4WX/Tr6V3B0UWPx2udf/
         muEAeB5OxJMQdb35VekrhNq/1AFdJnJZMLw8hYuHnebMztheXA5DyfsqUp2kGG3aP3Sl
         pziQ8wS94BYnD+yGbO39TSb6zPIE/TS6t1OIQMwaX/cwRzDn3pF4arTrr0iXCD3lE784
         Xw1WFhmUZdlqyao5SQWxwurHvFpLlWHAThrBbvXuO/q1qVg+aXClPTeRUQMKa8qy04RR
         RR9A0DvDuj0Etfbay60thS7xEjhOjuFoV7A8ONKFVgRu1QDmwh7EOPgwnvoab6vopwFU
         mc/A==
X-Gm-Message-State: AOAM530sBb9WYF3avU/hErbdPtILTEGiXFNz+AF8WcQkZ5iEfMr+NzVA
        nAd5jClem9CERdgqks1DY8gyJCzJLMyH1Wyuv58tRw==
X-Google-Smtp-Source: ABdhPJwj+FDMobw209UyLNKnz1dkYYaf/t6WrekVSol8Lb45lO3K3r2Nggoos7syItRduEXQP1UCDn97j7XbeZ0JV8c=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr9118329lfg.167.1605918066950;
 Fri, 20 Nov 2020 16:21:06 -0800 (PST)
MIME-Version: 1.0
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-3-kpsingh@chromium.org> <cad0ea25-8567-368a-1f99-b4adc7440a7f@fb.com>
In-Reply-To: <cad0ea25-8567-368a-1f99-b4adc7440a7f@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Sat, 21 Nov 2020 01:20:56 +0100
Message-ID: <CACYkzJ7doNURahGQn=0d8k73USH85owoZ8yDdwtG48oQLNHYaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
To:     Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 20, 2020 at 7:11 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/20/20 5:17 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > - Update the IMA policy before executing the test binary (this is not an
> >    override of the policy, just an append that ensures that hashes are
> >    calculated on executions).
> >
> > - Call the bpf_ima_inode_hash in the bprm_committed_creds hook and check
> >    if the call succeeded and a hash was calculated.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
>
> LGTM with a few nits below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   tools/testing/selftests/bpf/config            |  3 ++

[...]

> >   }
> >
> [...]
> > +
> >   void test_test_lsm(void)
> >   {
> >       struct lsm *skel = NULL;
> > @@ -66,6 +88,10 @@ void test_test_lsm(void)
> >       if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
> >               goto close_prog;
> >
> > +     err = update_ima_policy();
> > +     if (CHECK(err != 0, "update_ima_policy", "error = %d\n", err))
> > +             goto close_prog;
>
> "err != 0" => err?
> "error = %d" => "err %d" for consistency with other usage in this function.

Done.

>
> > +
> >       err = exec_cmd(&skel->bss->monitored_pid);
> >       if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
> >               goto close_prog;
> > @@ -83,6 +109,12 @@ void test_test_lsm(void)

[...]

> >   int mprotect_count = 0;
> >   int bprm_count = 0;
> > +int ima_hash_ret = -1;
>
> The helper returns type "long", but "int" type here should be fine too.

Changed it to long for correctness.
