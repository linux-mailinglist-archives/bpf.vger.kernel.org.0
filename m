Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A524781BA
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhLQAmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhLQAmV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:42:21 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7694C061748
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:42:20 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e136so1791980ybc.4
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nE3vvxgudTTgKMVrFPkk1p8pl5FsaIahz4HSTwiqNZg=;
        b=IElBe/kXZKJioH3tpwOJksi8ryFBugPpQzGb2lNvIz6uTuUgNYAy2KKEB63vGOnW/i
         BvcNUVprhmZ1hjE/k0af/lr04X8f0RK7oPUmlmMqd8MzJaiNvK7R2SdQeUpLd09bzxFJ
         xBo+4ohrmMpnToijMtW538AUHII7DWoL5wKMnSG3qTmk9lcAQR/C6bISrSsXakIaIyuR
         xfbBbw1mGczUqFYe5iAoqvFlkbsWypobOmjUDJ82xRReqmE84h0fx0Y1FS4n9GXOuCuQ
         E6uHVtmPqFg6v0qu3AqUsz4iuIDNevNsPa6HAYDWno5VthRUhynZrymSJYQAX31qcfLe
         s7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nE3vvxgudTTgKMVrFPkk1p8pl5FsaIahz4HSTwiqNZg=;
        b=G3vwgM3RMqiuU2IioO7SRGxi+0n/lP1o5zPOicaZjmz0IV3eew+1Sr8eSkUpfYl54w
         gvWiCBFuh1FkBrDubnpvRXxhumbhnUS26y++e4HV+K8a1ZKwLd79Uo+BCNvX/cHnTEh2
         wlea0PBAMxU5Lgfl/PepoZgaYhPaPLQHju2Mt5kZHjpFX4TcPV2muxDSUJmXThRGrgVY
         Jr8PZaHUHxD3PuaeJori/7EholOgkuIQgyJic0sCttPXWx4+gJkgnO4QbOPd8UefcDBE
         DLR64jnefrWoStLCcl6oBthf/yrS3h4PfKWd+QbOwLhM7nHdY78ZcHmh+dZgmhb04drA
         3yeg==
X-Gm-Message-State: AOAM530rmqjrRZ3bhYofKBMFWgeCsn2zWYqPJSfmSZlRkmGoanlTGJdJ
        2X7eQAmbaLePjeir6HtKzwMqc62uXAPySOhgbzA=
X-Google-Smtp-Source: ABdhPJw+qcEn6VUhV2/mZC6Bo2ww3lCRctX0BHklrS9Yn+nqfaL9V2rbYqa1US0L4058kk/CoE3vimUf900XRabmADY=
X-Received: by 2002:a25:4cc5:: with SMTP id z188mr985087yba.248.1639701739905;
 Thu, 16 Dec 2021 16:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20211216070442.1492204-1-andrii@kernel.org> <20211216070442.1492204-3-andrii@kernel.org>
 <b183b2b8-3bff-f647-678f-40b479c9c5c5@fb.com>
In-Reply-To: <b183b2b8-3bff-f647-678f-40b479c9c5c5@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Dec 2021 16:42:08 -0800
Message-ID: <CAEf4BzZydhBisHacU9Rjf1ZWik1_aUeiy6ANRfaUkebo7cYq5Q@mail.gmail.com>
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

On Thu, Dec 16, 2021 at 4:21 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 12/16/21 2:04 AM, Andrii Nakryiko wrote:
> > Add selftests for prog/map/prog+helper feature probing APIs. Prog and
> > map selftests are designed in such a way that they will always test all
> > the possible prog/map types, based on running kernel's vmlinux BTF enum
> > definition. This way we'll always be sure that when adding new BPF
> > program types or map types, libbpf will be always updated accordingly to
> > be able to feature-detect them.
> >
> > BPF prog_helper selftest will have to be manually extended with
> > interesting and important prog+helper combinations, it's easy, but can't
> > be completely automated.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> [...]
>
> > +     for (e = btf_enum(t), i = 0, n = btf_vlen(t); i < n; e++, i++) {
> > +             const char *prog_type_name = btf__str_by_offset(btf, e->name_off);
> > +             enum bpf_prog_type prog_type = (enum bpf_prog_type)e->val;
> > +             int res;
> > +
> > +             if (prog_type == BPF_PROG_TYPE_UNSPEC)
> > +                     continue;
> > +
> > +             if (!test__start_subtest(prog_type_name))
> > +                     continue;
> > +
> > +             res = libbpf_probe_bpf_prog_type(prog_type, NULL);
> > +             ASSERT_EQ(res, 1, prog_type_name);
> > +     }
>
> I like how easy BTF makes this.
> Maybe worth trying to probe one-past-the-end of enum to confirm it fails as
> expected?
>

Yeah, sure, not a bad idea, I'll add in v2.

> Regardless,
>
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
>
> > +cleanup:
> > +     btf__free(btf);
> > +}
>
> [...]
