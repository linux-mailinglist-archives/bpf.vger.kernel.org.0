Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF4B24A7E3
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 22:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSUq7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 16:46:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38454 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725275AbgHSUq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 16:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597870017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qeaXYLzlMjRZzB79ht3RxrE8j6zqJxKY+oFWupwJ5gY=;
        b=OSZM4qfuyoEKHeZvMY0X5sQM1yPxJngM35mbSFTmlAjvLQL49bMk3wrpjIl9adOZhgY4mN
        mncVClUelU+O4Uu40PwyIi/cMjeO3W32qv4vYIvdzUnyU48CvBBBlfti1qzlq72ICZ/igl
        A4G/wGm6FWSnrcU0LTixGehVuoWFaKw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-LjuMay8bM_mZ8ieLn7wRvQ-1; Wed, 19 Aug 2020 16:46:55 -0400
X-MC-Unique: LjuMay8bM_mZ8ieLn7wRvQ-1
Received: by mail-wm1-f72.google.com with SMTP id g72so43392wme.4
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 13:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeaXYLzlMjRZzB79ht3RxrE8j6zqJxKY+oFWupwJ5gY=;
        b=PVurTFQaYm1th9cgvla4yAq0LR9+fhBvWiq7wKuOXsptphBaAdapchaf7L0YMrNdxE
         NJZ1jmVIIXd8SbyvgXt9RIXhAx0kLB+MYjxIOrbrAJMmn6nuUc2ORn+S8M1Qn/ivGyNF
         YNQi5rH/SjPVtIDcUKjOZxrfSBsJm0Hro1urVzsbDeDDuVLqJKR/zl2FGer1QiqC0qcC
         lWVJDuLlYDlClkzWP0gGfPW9DwCWT6m8fnOKigstTEzIVtrAALuormpT0UPhVP7gKqkH
         9SbBEvSCaoVPUVQhLC4IqVjQ0i1GHrQIxSTih9R+LKjNWeeCBDtQTiiIKANT6B3+ibeG
         Yx1A==
X-Gm-Message-State: AOAM5335XIo4voeRNWnEHmjkW4tTThwk9bxPvB4hjvYAek8NVMIsjM1D
        PvrQdFS07FI9SGqGUqLkS08OCALWDfaoKMf/2M41ScVTFjXYBtI6PREuXFlJt/rPPctpxepyFqM
        T8ti5IVLqo0aYwLXzOJIwhdxl/peL
X-Received: by 2002:adf:a35e:: with SMTP id d30mr28274348wrb.53.1597870014164;
        Wed, 19 Aug 2020 13:46:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAL2082kimynBu4pYfs9Sr23jdDmhST7LFHqbYGo++Ykv/XFx4+62GbdDr0uf365B8lu8+5bsJxfugL8n2dWE=
X-Received: by 2002:adf:a35e:: with SMTP id d30mr28274331wrb.53.1597870013880;
 Wed, 19 Aug 2020 13:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200819023427.267182-1-yauheni.kaliuta@redhat.com>
 <66d63f42-ce71-446a-7ee2-586ffcea160d@fb.com> <CANoWswmccdLu4mCj48iVH1_Od4zZ=BdgCHZ0CMyieYQ9WxoHPA@mail.gmail.com>
 <1518db68-6699-b261-7b6e-2d71c3d9566c@fb.com>
In-Reply-To: <1518db68-6699-b261-7b6e-2d71c3d9566c@fb.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 19 Aug 2020 23:46:37 +0300
Message-ID: <CANoWswnJ0fh_uMzwuLDyZsyWcNyiwMnx4-Unp=q22ppVe8f0-w@mail.gmail.com>
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

On Wed, Aug 19, 2020 at 5:57 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/19/20 12:05 AM, Yauheni Kaliuta wrote:
> > On Wed, Aug 19, 2020 at 8:19 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 8/18/20 7:34 PM, Yauheni Kaliuta wrote:
> >>> The error path in libbpf.c:load_program() has calls to pr_warn()
> >>> which ends up for global_funcs tests to
> >>> test_global_funcs.c:libbpf_debug_print().
> >>>
> >>> For the tests with no struct test_def::err_str initialized with a
> >>> string, it causes call of strstr() with NULL as the second argument
> >>> and it segfaults.
> >>>
> >>> Fix it by calling strstr() only for non-NULL err_str.
> >>>
> >>> The patch does not fix the test itself.
> >>
> >> So this happens in older kernel, right? Could you clarify more
> >> in which kernel and what environment? It probably no need to
> >> fix the issue for really old kernel but some clarification
> >> will be good.
> >
> > I'll test it with the very recent kernel on that architecture soon,
> > for sure. But it's not related to the patch.
>
> The above "The patch does not fix the test itself" a little bit vague.
> You can say that "The test may fail in old kernels where <why it fails
> ...> and this patch is to fix the segfault rather the test failure.".
> This way people can easily understand why and the purpose of this patch.

Ok, I'll remove it completely (as I mentioned in the follow-up email,
the test still fails for me for the Linus' HEAD).

>
> >
> >>
> >>>
> >>> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
>
> Ok, ack with the above nit and one nit below.
>     Acked-by: Yonghong Song <yhs@fb.com>
> I guess it is better to send a v2 carrying my ack.
>
> >>> ---
> >>>    tools/testing/selftests/bpf/prog_tests/test_global_funcs.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> >>> index 25b068591e9a..6ad14c5465eb 100644
> >>> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> >>> @@ -19,7 +19,7 @@ static int libbpf_debug_print(enum libbpf_print_level level,
> >>>        log_buf = va_arg(args, char *);
> >>>        if (!log_buf)
> >>>                goto out;
> >>> -     if (strstr(log_buf, err_str) == 0)
> >>> +     if ((err_str != NULL) && (strstr(log_buf, err_str) == 0))
> >>
> >> Looks good but the code can be simplified as
> >>          if (err_str && strstr(log_buf, err_str) == 0)
> >>                  found = true;
> >
> > Yes, but I prefer to use NULL explicitly when I deal with pointers. It
> > demonstrates intention better. You also can simplify strstr() == 0
> > with !. Actually, strstr() returns char *, so comparation to 0
> > (totally legal by standard) breaks my feelings too :).
>
> comparison with NULL is okay. You can just do
>     (err_str != NULL && strstr(log_buf, err_str) == 0)
> there is no need for extra parenthesis.

Ah, ok. Inconsistency with the strstr check bothers me, but it would
be unrelated change.

Thank you for review!

>
> >
> > If you insist, I'll send v2 of course.
> >
> >>>                found = true;
> >>>    out:
> >>>        printf(format, log_buf);
> >>>
> >>
> >
> >
>


-- 
WBR, Yauheni

