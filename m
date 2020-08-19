Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48824965F
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 09:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHSHFv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 03:05:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgHSHFZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 03:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597820724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDEssFALNsUBVnWrO0xd1mdGMgS4szyJpG5ERQNITG8=;
        b=IS0Ym/g46gQ6zZMJtXG0FO3qrGGYZJ0lWhjjb2LfIc3hwRjowXTeFQOffwJt4VeHVIUFyv
        gHoZ8c3Qg0Xvrkc2MAH/Gce+J6gyKLo2rJ2JAqMSGbo9PZYO9Fon28lyFF8ih2ba1Kec1R
        ufBoTiCoackRrAJ3AjedklzuU4oHR/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-XYk5AhP2Ola9MAJCjIEJEw-1; Wed, 19 Aug 2020 03:05:22 -0400
X-MC-Unique: XYk5AhP2Ola9MAJCjIEJEw-1
Received: by mail-wm1-f71.google.com with SMTP id d22so576582wmd.2
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 00:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDEssFALNsUBVnWrO0xd1mdGMgS4szyJpG5ERQNITG8=;
        b=pQTy+dDrBX3Nk5KqmATnVXsGXRfNW7kbogCksHzjIZg4/hDWRW7Yl1LtQelKDs0a+9
         9IMStEEiwh8aAwZnMdo+zxML69QRknDx1SNfbXHUbxHOclfaTYQlE47+TVTcmnUP7C+p
         EX+ke0T9q2KW7AErSqJfU4KIe7KWTYDDtZIsVoGQ+k7UX/zIB8/v01JZcfGFn+LvOk2J
         m2r2kHDMe7RX8MdQB2sFAt/25UxHvNUMwlIZ74rp8wIX2djxypbLANmzGnvkhZwh4nAJ
         mkfSmP9hxtNemXfcE5sWv8ejEEkNVdOWuAYvx8+gin+RRCCJQaGmMkq0/qkHg0xYLP4b
         iwVA==
X-Gm-Message-State: AOAM532DhVGdTP78xLyJ5wPIxHDSMJTeIWT+NQJzWSK8si1GxAQFld9H
        M0Zo4RGc5OZUmFgUam+K5hi0txWRBKjwZym/vrK0+pVbCMIPzTuIfvW+aaN9nTo5qwREFJiHEX6
        3LsyjRYh5mgOazzIP307E6aiouzoA
X-Received: by 2002:a5d:414e:: with SMTP id c14mr25441636wrq.57.1597820720876;
        Wed, 19 Aug 2020 00:05:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe0MkAIlnGQmwEZ6u5bg5PB9f2iVNtd91UyfBT+Vp4DmyoUm+vGARd1h4lUd5H5nEnZVfezkKIOBqotlXd+WA=
X-Received: by 2002:a5d:414e:: with SMTP id c14mr25441609wrq.57.1597820720644;
 Wed, 19 Aug 2020 00:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200819023427.267182-1-yauheni.kaliuta@redhat.com> <66d63f42-ce71-446a-7ee2-586ffcea160d@fb.com>
In-Reply-To: <66d63f42-ce71-446a-7ee2-586ffcea160d@fb.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 19 Aug 2020 10:05:04 +0300
Message-ID: <CANoWswmccdLu4mCj48iVH1_Od4zZ=BdgCHZ0CMyieYQ9WxoHPA@mail.gmail.com>
Subject: Re: [PATCH] bpf: selftests: global_funcs: check err_str before strstr
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 8:19 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/18/20 7:34 PM, Yauheni Kaliuta wrote:
> > The error path in libbpf.c:load_program() has calls to pr_warn()
> > which ends up for global_funcs tests to
> > test_global_funcs.c:libbpf_debug_print().
> >
> > For the tests with no struct test_def::err_str initialized with a
> > string, it causes call of strstr() with NULL as the second argument
> > and it segfaults.
> >
> > Fix it by calling strstr() only for non-NULL err_str.
> >
> > The patch does not fix the test itself.
>
> So this happens in older kernel, right? Could you clarify more
> in which kernel and what environment? It probably no need to
> fix the issue for really old kernel but some clarification
> will be good.

I'll test it with the very recent kernel on that architecture soon,
for sure. But it's not related to the patch.

>
> >
> > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > ---
> >   tools/testing/selftests/bpf/prog_tests/test_global_funcs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> > index 25b068591e9a..6ad14c5465eb 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> > @@ -19,7 +19,7 @@ static int libbpf_debug_print(enum libbpf_print_level level,
> >       log_buf = va_arg(args, char *);
> >       if (!log_buf)
> >               goto out;
> > -     if (strstr(log_buf, err_str) == 0)
> > +     if ((err_str != NULL) && (strstr(log_buf, err_str) == 0))
>
> Looks good but the code can be simplified as
>         if (err_str && strstr(log_buf, err_str) == 0)
>                 found = true;

Yes, but I prefer to use NULL explicitly when I deal with pointers. It
demonstrates intention better. You also can simplify strstr() == 0
with !. Actually, strstr() returns char *, so comparation to 0
(totally legal by standard) breaks my feelings too :).

If you insist, I'll send v2 of course.

> >               found = true;
> >   out:
> >       printf(format, log_buf);
> >
>


-- 
WBR, Yauheni

