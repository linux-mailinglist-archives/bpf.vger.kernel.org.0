Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8271C435653
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 01:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTXQw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 19:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhJTXQw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 19:16:52 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816EAC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 16:14:37 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id t127so21659289ybf.13
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 16:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kL5A35aXr98DxVhOnO4biEdFIkfecS8nWq3dsirE6yg=;
        b=VeZYR7GCNrLEmm2ymw8gwaA0bNI6boOXtaj0Oo+pPF4TGoT/3BSe8hd4g2JNxHgWn6
         +cXwLj5/uu7baH8i3+yg1zVoEgyR5Kk04krlrX1sK3SIBiAYaBNKmJbfqVYqafAfCoQM
         VlGkw8//th5UYWkcP5CpC/lPDPH89VlJQEradnHcJ9Pg7d646G4X/YmyDGkj/A7SqrHs
         sS9gkY3t8M1GKnUOiU6KYDHrCAmLEeQwR5D39p7sV9/zME5a8iwZ96k21uIhefM2T94h
         q0Ekq0dhzzgnWlidtKvCs+xISx7k2SHD0lAKFLHfl1ATatJvw05N7XG3/cxHaL/asDGs
         8pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kL5A35aXr98DxVhOnO4biEdFIkfecS8nWq3dsirE6yg=;
        b=G/5uEQAPtTLafGxcDjMQo515gPYTQ4MZR5HL6UWFSIcpYB/sUgmqriYYh/dwrLXFZH
         V3zehLCAkxXaQUEJj7AVFBI589Rx/yiU+467Jqtf1wt5YXzxwPbNMN+Gkoz3/PLeraY9
         p/q1aiDU7ULKez2VcGvz4cidNurEL7MvZw4oJeVDqhf5vjm2jLHYGm2yRzN32PdeMvH3
         o2y18wGwaS046aNgbJcbylsi4t8aPkC9q2eUMjmTVGbakBlGB+E1ol4rJrPq9bSaH+j/
         yfr1b5sVawdopUvRagSfU6HW8dGHpN7GhwW0Mp+RZ6Ja2zKZ09y/zTUnPWU5netcTWrN
         G82Q==
X-Gm-Message-State: AOAM531poIcM3h0wJ6r/kVCe0DYVALuPDxQKR7pNpP2vURe06rz6CNM2
        kLl+0gymRx5356X0XAYXKDBEK4wmZpLOiDM72b2JhC/uTMw=
X-Google-Smtp-Source: ABdhPJzUZqXSuPic73HMdSC//9D2+Su0ibWbwx/S85tO1XI6enPq+MsIqY9jYFuoLBMKfY1pTzJ6dBvGZSL375blJZ4=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr1924284ybh.267.1634771676685;
 Wed, 20 Oct 2021 16:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211009150029.1746383-1-hengqi.chen@gmail.com>
 <20211009150029.1746383-2-hengqi.chen@gmail.com> <CAEf4BzZyjoaRATpKHuYFFmZ1u5WnEh4nBdOOpSO+OZi7MH=cHg@mail.gmail.com>
 <fc764766-e4fd-dc0a-c042-5af92373a461@gmail.com>
In-Reply-To: <fc764766-e4fd-dc0a-c042-5af92373a461@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 16:14:25 -0700
Message-ID: <CAEf4BzY9q1md3Q6Z6q5EJ=JEp9keq-cOa6S3jOoo8i+WRhJFxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add btf__type_cnt() and
 btf__raw_data() APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 6:51 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2021/10/20 1:48 AM, Andrii Nakryiko wrote:
> > On Sat, Oct 9, 2021 at 8:01 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Add btf__type_cnt() and btf__raw_data() APIs and deprecate
> >> btf__get_nr_type() and btf__get_raw_data() since the old APIs
> >> don't follow the libbpf naming convention for getters which
> >> omit 'get' in the name.[0] btf__raw_data() is just an alias to
> >
> > nit: this ".[0]" looks out of place, please use it as a reference in a
> > sentence, e.g.,:
> >
> > omit 'get' in the name (see [0]).
> >
> > So that it reads naturally and fits the overall commit message.
> >
> >
>
> Got it. Will do.
>
> >> the existing btf__get_raw_data(). btf__type_cnt() now returns
> >> the number of all types of the BTF object including 'void'.
> >>
> >>   [0] Closes: https://github.com/libbpf/libbpf/issues/279
> >>
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >>  tools/lib/bpf/btf.c      | 36 ++++++++++++++++++++++--------------
> >>  tools/lib/bpf/btf.h      |  4 ++++
> >>  tools/lib/bpf/btf_dump.c |  8 ++++----
> >>  tools/lib/bpf/libbpf.c   | 32 ++++++++++++++++----------------
> >>  tools/lib/bpf/libbpf.map |  2 ++
> >>  tools/lib/bpf/linker.c   | 28 ++++++++++++++--------------
> >>  6 files changed, 62 insertions(+), 48 deletions(-)
> >>
> >
> > [...]
> >
> >> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> >> index 864eb51753a1..49397a22d72b 100644
> >> --- a/tools/lib/bpf/btf.h
> >> +++ b/tools/lib/bpf/btf.h
> >> @@ -131,7 +131,9 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
> >>                                    const char *type_name);
> >>  LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
> >>                                         const char *type_name, __u32 kind);
> >> +LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__type_cnt() instead")
> >
> > it has to be scheduled to 0.7 to have a release with new API
> > (btf__type_cnt) before we deprecate btf__get_nr_types(). It's probably
> > worth mentioning in the deprecation message that btf__type_cnt()
> > return is +1 from btf__get_nr_types(). Maybe something like:
> >
>
> I am a little confused about this scheduling. You mentioned that
> we can deprecate old API on the development version (0.6). See [0].

If we add some new API and deprecate old API (but recommend to use new
API instead), we need to make sure that new API is there in at least
one released libbpf version. Only then we can mark old API as
deprecated in the next released libbpf version. In this case
btf__type_cnt() has to go into v0.6 and btf__get_nr_types() can be
deprecated in v0.7, not in v0.6.

Previous case in [0] was different, there was no new API we had to
wait for, so we could deprecate the old API immediately.

>
>
> > LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__type_cnt() instead; note that
> > btf__get_nr_types() == btf__type_cnt() - 1")
> >
>
> Will take this in v2.
>
> >>  LIBBPF_API __u32 btf__get_nr_types(const struct btf *btf);
> >> +LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
> >>  LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
> >>  LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
> >>                                                   __u32 id);
> >> @@ -144,7 +146,9 @@ LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
> >>  LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
> >>  LIBBPF_API int btf__fd(const struct btf *btf);
> >>  LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
> >> +LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__raw_data() instead")
> >
> > same, 0.7+
> >
> >>  LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
> >> +LIBBPF_API const void *btf__raw_data(const struct btf *btf, __u32 *size);
> >>  LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
> >>  LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
> >>  LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
> >
> > [...]
> >
>
>   [0] https://lore.kernel.org/all/CAEf4BzZ_JB1VLAF0=7gu=2M0M735aXava=nPL8m8ewQWdS3m8g@mail.gmail.com/
