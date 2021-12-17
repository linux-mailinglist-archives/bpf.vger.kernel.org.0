Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42814479278
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 18:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhLQRKI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 12:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbhLQRKH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 12:10:07 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4574C061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 09:10:07 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g17so8200505ybe.13
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 09:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NXI5t6aoXhcKhTIxJdzLfmmJ5dydU4kcM0avMhBjUw=;
        b=jq5PFymXdHvj1Xp1Cffm9xVIFcKC5mE71HZBkbC6d9Ql1zNRZXGESCOcnXEUOhoaRn
         PsTkkRvfYLobcA4iz+1rlBHe1b0Oa/E7DW1Oc+UMqa+FVIvQi3VU69DVQRf7jisjvwTn
         lR0LXkQAPdFnSdrkTg0e03VG28nmkQPtyEgUCfTZI0SdZWkHlyDl0j//EKZoDzNrnh/4
         43tCWpNIjdaJpBYf7ngc9Ex773qPL3hPTuv6FXa+T71+rh3qiJI151JJjVYePW0oNdEV
         +0pleB9yzO9IPzYuLfbMn/kRe4AHMX0sTsE3XcuvqV80yc02UVJNfW9TUqe3V9/WYVoJ
         keTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NXI5t6aoXhcKhTIxJdzLfmmJ5dydU4kcM0avMhBjUw=;
        b=BCfDQipDE8F8cdtzlKnqXAN7L1ZIxvJxJUbrYeDZ7N8kvEVlQ50ZqLfkFfC85ns6TC
         Tmyso55Ebj9itHw+uDjJhyDWzaD48jkgz3hk5Vv3/xkhvaFWCm6HueVjMTUYeMzPhdNE
         MF6mArixHjWrDI0DhbYeT0fKTlSTAQgjYrzr5bqHMnzpCFOqxliFQtEg0UzzbkFZ/0Ye
         EzxiV0uGmMuW0o9zdAkIURUGTfq9yL/P4cCWtN//NVyrYEVaSnbvj+oiRjkuu5cdCFNk
         aB5TdfnTPw5HCfaBS3y9217Ed4/riSThUhwTSAKTm7VDtGy1AUYqGFCgv+fiVhU8Os3f
         rVUw==
X-Gm-Message-State: AOAM531udoAaQeS+q/bzQO/ELdMrrbWjGLtjy5q1941e/oPtGubNUpVy
        Hm2921s+SpG5MAa79EMcK1ur5xkmm6kpUEGGX8S9SrBeztwJ6Q==
X-Google-Smtp-Source: ABdhPJzefFXjDIn7NnphWKmOBoxPO+Kg2Aykn+f7XG0iAug82nleUcUpPp9RcV5wk/RHfcoLElGQ9Km3VsYRbN7f/PU=
X-Received: by 2002:a25:2a89:: with SMTP id q131mr6025990ybq.436.1639761006933;
 Fri, 17 Dec 2021 09:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20211216070442.1492204-1-andrii@kernel.org> <20211216070442.1492204-3-andrii@kernel.org>
 <b183b2b8-3bff-f647-678f-40b479c9c5c5@fb.com> <CAEf4BzZydhBisHacU9Rjf1ZWik1_aUeiy6ANRfaUkebo7cYq5Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZydhBisHacU9Rjf1ZWik1_aUeiy6ANRfaUkebo7cYq5Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Dec 2021 09:09:55 -0800
Message-ID: <CAEf4BzaDJOj-7B_OvUzLvhVTgcMrZ-QLRBKNXMa3p+2WXzrEQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: add libbpf feature-probing
 API selftests
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 4:42 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 16, 2021 at 4:21 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > On 12/16/21 2:04 AM, Andrii Nakryiko wrote:
> > > Add selftests for prog/map/prog+helper feature probing APIs. Prog and
> > > map selftests are designed in such a way that they will always test all
> > > the possible prog/map types, based on running kernel's vmlinux BTF enum
> > > definition. This way we'll always be sure that when adding new BPF
> > > program types or map types, libbpf will be always updated accordingly to
> > > be able to feature-detect them.
> > >
> > > BPF prog_helper selftest will have to be manually extended with
> > > interesting and important prog+helper combinations, it's easy, but can't
> > > be completely automated.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> >
> > [...]
> >
> > > +     for (e = btf_enum(t), i = 0, n = btf_vlen(t); i < n; e++, i++) {
> > > +             const char *prog_type_name = btf__str_by_offset(btf, e->name_off);
> > > +             enum bpf_prog_type prog_type = (enum bpf_prog_type)e->val;
> > > +             int res;
> > > +
> > > +             if (prog_type == BPF_PROG_TYPE_UNSPEC)
> > > +                     continue;
> > > +
> > > +             if (!test__start_subtest(prog_type_name))
> > > +                     continue;
> > > +
> > > +             res = libbpf_probe_bpf_prog_type(prog_type, NULL);
> > > +             ASSERT_EQ(res, 1, prog_type_name);
> > > +     }
> >
> > I like how easy BTF makes this.
> > Maybe worth trying to probe one-past-the-end of enum to confirm it fails as
> > expected?
> >
>
> Yeah, sure, not a bad idea, I'll add in v2.

Couldn't do it :( Because selftest is using running kernel's BTF to
find out maximum BPF map type. But that maximum on a slightly outdated
kernel could be something that libbpf actually knows about and
supports (because it was compiled against the latest kernel UAPI
headers). So at run time libbpf returns 0 (correct answer, not
map/prog is not supported), but not the expected -EOPNOTSUPP. And I
don't want to hardcode the maximum enum values (like
BPF_MAP_TYPE_BLOOM_FILTER, as of now), because every time we add new
map we'll need to fix selftests in the same patch, which is a bit
annoying, I think.

If we had equivalents of __BPF_FUNC_MAX_ID for bpf_map_type and
bpf_prog_type, we could have just used those constants, so maybe we
should do that instead?

Regardless, I'm sending selftests as they are right now and we can
follow up with UAPI additions and selftests improvements separately.

>
> > Regardless,
> >
> > Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
> >
> > > +cleanup:
> > > +     btf__free(btf);
> > > +}
> >
> > [...]
