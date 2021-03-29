Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83C34D601
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 19:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhC2R0t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC2R0T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 13:26:19 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAB5C061574
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 10:26:18 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g24so9864721qts.6
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R49uBtXh1BrDjgQWvlXc+89X6sjp8WeXTTBbCRqic1Q=;
        b=MT3R1Kl5pfHrMGcpGvbUjqBp/Fmk6/gyaeYwxL/4+bVySoY9TgSMAfiZo6cRiJd/sE
         SlQXYflHYdJFNq5YlG2bvosDsV9w71BTpP64L9OQK6Dg8VOt7mCrbKA33YzJIPEBi3x7
         pYwlwte5+VKyi7ZcUZLB1BPzfdsNBzv1o3urZSo3g9eLefhS57QlKeD3KZTMAgEbWUZo
         4R4WzYJSQXjwXE3y0ZydesCNc2/P9o/8DR0wQ6Ns3uDgiagC2/IP0jpmgu5c8++8eRd1
         +uDE/eA0G505aJcjBkwKyUWM+GfSL69p+5Zu+EP2Xl57RaGELXKEbThPh2w8LlwKVZFx
         0+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R49uBtXh1BrDjgQWvlXc+89X6sjp8WeXTTBbCRqic1Q=;
        b=nRyZXPNv7xK9kTHD9V6KPcY20Z82CnE5hSzdYE2O8BAtKaVJ4+3sTi7vU0Vt71cJqd
         /FZsWIIskRY5jXnQ/pBXbx/HpYbYWeiUZ5pciXJbgzVxLyOad04ATsJIi/WR0NT0eTXq
         UqzKLh1DeT9Ou68SbvvYFFBbI77HmemIANrzU7QhS+KYW1Wx4LN98ZzSjKM1HKcg03p2
         obct0vrRj362EZnt5+rYp0gk/iH27NX9zn3zwIHjI+t8zn7WqJxrLV9kJMLuUF3MQMOW
         J/6VbAYK4AdYjtdcVsIsrsl7/Fj5veJeLmciuW2xw8z0mkFl+Ac4J+iI8GjwrRAkfgxc
         +aOA==
X-Gm-Message-State: AOAM532MoPgu7t4LGp18gxb1x9gQxlixkunii47x7olpdb+PD1V2eQn8
        m4uRyFpFEMFwwifg3+35U9skYkUfL6fD8tBVee7uPqllFJc=
X-Google-Smtp-Source: ABdhPJwNUJ67Y/7R+RGiQuZC/vvzmhuHcAN+US6Bdien4Pm0v9JKze8ECQKwpDyD782FfkOxAUtaAZI4fR1D5Ugw8zg=
X-Received: by 2002:a05:622a:13cb:: with SMTP id p11mr23265907qtk.349.1617038777066;
 Mon, 29 Mar 2021 10:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210329164541.3240579-1-sdf@google.com> <CAPhsuW6fw8Zsh=jvUbwxfRrtKSCR9wwF6KXyWLb=z_xPHGVMAw@mail.gmail.com>
In-Reply-To: <CAPhsuW6fw8Zsh=jvUbwxfRrtKSCR9wwF6KXyWLb=z_xPHGVMAw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 29 Mar 2021 10:26:06 -0700
Message-ID: <CAKH8qBvTX4Q6QdjktZbA1QJ=y4R2zMrsoqx3yTh2dHwhbg1P3w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] tools/resolve_btfids: Fix warnings
To:     Song Liu <song@kernel.org>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 29, 2021 at 10:23 AM Song Liu <song@kernel.org> wrote:
>
> On Mon, Mar 29, 2021 at 9:46 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > * make eprintf static, used only in main.c
> > * initialize ret in eprintf
> > * remove unused *tmp
> > * remove unused 'int err = -1'
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > index 80d966cfcaa1..be74406626b7 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -115,10 +115,10 @@ struct object {
> >
> >  static int verbose;
> >
> > -int eprintf(int level, int var, const char *fmt, ...)
> > +static int eprintf(int level, int var, const char *fmt, ...)
> >  {
> >         va_list args;
> > -       int ret;
> > +       int ret = 0;
> >
> >         if (var >= level) {
> >                 va_start(args, fmt);
> > @@ -403,10 +403,9 @@ static int symbols_collect(struct object *obj)
> >          * __BTF_ID__* over .BTF_ids section.
> >          */
> >         for (i = 0; !err && i < n; i++) {
>                     ^^^^ This err is also not used.
Yeah, good point, let's remove that one as well. Thanks!

> > -               char *tmp, *prefix;
> > +               char *prefix;
> >                 struct btf_id *id;
> >                 GElf_Sym sym;
> > -               int err = -1;
> >
> >                 if (!gelf_getsym(obj->efile.symbols, i, &sym))
> >                         return -1;
> > --
> > 2.31.0.291.g576ba9dcdaf-goog
> >
