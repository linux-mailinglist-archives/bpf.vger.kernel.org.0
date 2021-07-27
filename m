Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF63D7D50
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 20:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhG0SSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 14:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG0SSo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 14:18:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDAFC061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 11:18:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v46so22203657ybi.3
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lOlXM4GaKVfcD3q81JH70+kQoquDoRZh1zO3lKYLHU=;
        b=jNoRbkC3G61V96PfzZT2+a///d18NeB5UYMQYWxqRts24OuSt9CjnPcRC05+AzESgU
         fYSj2cJ9Px0zvlO60x92vsdB+K1ZM0vM8w/TzMCktVTK1oNcCu6+CWBIWJxwtkCO1Vb7
         vEEzjkxaujFOzuuJH/Ki9/kiZyjYEaqmsSr3hGdTxI5L+BlRdI6gbP1pnMllPC3gxXIx
         npuxlBr0/7DpCgFKIlc0zTUj4bv2C8gHL0Jh/bJXSxSjPs0NFwiDw4jHfiO11EBpBZJy
         Z7y+6AdGowQQb91kDJvmteKCQoiJI99vUleaNjEEAD6E+0cmosPPpCNLoP1ch7VzkNHB
         GacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lOlXM4GaKVfcD3q81JH70+kQoquDoRZh1zO3lKYLHU=;
        b=J9xHo5oD8vfT9qET5aPWCYmQRioGjy1FpUQ8LQIn0I9M+K2de6bFY//ndCDlqoLAUV
         R2Z4ak0YPpRbFk47QrzqUrsIRYNIOR0lbsaXA56v70MmXXkjsmME6c0u+o6lQ5+7Cstf
         D0R2jR0jhIsIKNls4H6O/ORg22km03qlkx2MQEZEJjhLHoDjAeYN3EGFJwIH7wgy1rHO
         kBtHoZzk+Epg6TQSVBCoZO9ROtfF/l2/yZcc+bquRbcxGk96cOJNnJXjxhgJVV71IFWt
         1h32euUQlq+ilEn/J0KiT2uwPnzig59jJd6lWnKcgKZJpq0QoHq0Mq1JMkMePLz83shO
         X07Q==
X-Gm-Message-State: AOAM532UODusAJHg9JByBLUEemE4SQ7ukMjYPeDXcPSXV5bggUyeHPjl
        oURBYM7fT1bOnxqJDiFIWPD64WuO3NPFWSujGhs=
X-Google-Smtp-Source: ABdhPJyfkGHXp7UEpjE8DmnzB86NOZDhn6gql00gFzym1sxQm2ryoqtfFzZm49sO67yYuRcaFXV5Rbk/XGfqaE9Nf/Q=
X-Received: by 2002:a25:b203:: with SMTP id i3mr33470430ybj.260.1627409923978;
 Tue, 27 Jul 2021 11:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210724051256.1629110-1-hengqi.chen@gmail.com>
 <CAEf4BzaZEny+3iu6ZGqAaY8QGE27TJoky=pzMcyg934_cJ3QTg@mail.gmail.com> <db11440c-c9ce-9007-9a03-7395d6facfe7@gmail.com>
In-Reply-To: <db11440c-c9ce-9007-9a03-7395d6facfe7@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Jul 2021 11:18:32 -0700
Message-ID: <CAEf4BzajGK2To6gS_u7DKXaPwcBKTSmChVHXZYRfvNk+377zoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add libbpf_load_vmlinux_btf/libbpf_load_module_btf
 APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021 at 6:12 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 7/27/21 6:49 AM, Andrii Nakryiko wrote:
> > On Fri, Jul 23, 2021 at 10:13 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Add libbpf_load_vmlinux_btf/libbpf_load_module_btf APIs.
> >> This is part of the libbpf v1.0. [1]
> >>
> >> [1] https://github.com/libbpf/libbpf/issues/280
> >
> > Saying it's part of libbpf 1.0 effort and given a link to Github PR is
> > not really a sufficient commit message. Please expand on what you are
> > doing in the patch and why.
> >
>
> Will do.
>
> >>
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >>  tools/lib/bpf/btf.c      | 24 +++++++++++++++++++++++-
> >>  tools/lib/bpf/btf.h      |  2 ++
> >>  tools/lib/bpf/libbpf.c   |  8 ++++----
> >>  tools/lib/bpf/libbpf.map |  2 ++
> >>  4 files changed, 31 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >> index b46760b93bb4..414e1c5635ef 100644
> >> --- a/tools/lib/bpf/btf.c
> >> +++ b/tools/lib/bpf/btf.c
> >> @@ -4021,7 +4021,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
> >>                  */
> >>                 if (d->hypot_adjust_canon)
> >>                         continue;
> >> -
> >> +
> >>                 if (t_kind == BTF_KIND_FWD && c_kind != BTF_KIND_FWD)
> >>                         d->map[t_id] = c_id;
> >>
> >> @@ -4395,6 +4395,11 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
> >>   * data out of it to use for target BTF.
> >>   */
> >>  struct btf *libbpf_find_kernel_btf(void)
> >> +{
> >> +       return libbpf_load_vmlinux_btf();
> >> +}
> >> +
> >> +struct btf *libbpf_load_vmlinux_btf(void)
> >>  {
> >>         struct {
> >>                 const char *path_fmt;
> >> @@ -4440,6 +4445,23 @@ struct btf *libbpf_find_kernel_btf(void)
> >>         return libbpf_err_ptr(-ESRCH);
> >>  }
> >>
> >> +struct btf *libbpf_load_module_btf(const char *mod)
> >
> > So we probably need to allow user to pre-load and re-use vmlinux BTF
> > for efficiency, especially if they have some use-case to load a lot of
> > BTFs.
> >
>
> Should the API change to this ?
>
> struct btf *libbpf_load_module_btf(struct btf *base, const char *mod)
>
> It seems better for the use-case you mentioned.

Something like this, yeah. Let's put struct btf * as the last argument
and module name as a first one, to follow the btf__parse_split()
convention of having base_btf the last. And maybe let's call base a
"vmlinux_btf", as in this case it's pretty specific that it's supposed
to be the vmlinux BTF, not just any random BTF.

>
> >> +{
> >> +       char path[80];
> >> +       struct btf *base;
> >> +       int err;
> >> +
> >> +       base = libbpf_load_vmlinux_btf();
> >> +       err = libbpf_get_error(base);
> >> +       if (err) {
> >> +               pr_warn("Error loading vmlinux BTF: %d\n", err);
> >> +               return base;
> >
> > libbpf_err_ptr() needs to be used here, pr_warn() could have destroyed
> > errno already
> >
>
> OK.
>
> >> +       }
> >> +
> >> +       snprintf(path, sizeof(path), "/sys/kernel/btf/%s", mod);
> >> +       return btf__parse_split(path, base);
> >
> > so who's freeing base BTF in this case?
> >
>
> Sorry, missed that.
> But if we change the signature, then leave this to user.

Right, that's what I was getting at. If we make vmlinux BTF
non-optional, then user will have to own freeing it, just like we do
that for other APIs w/ base BTF.

>
> >> +}
> >> +
> >>  int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
> >>  {
> >>         int i, n, err;
> >
> > [...]
> >
