Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0844446765
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 17:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhKEQ6f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhKEQ6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 12:58:35 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87CEC061714
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 09:55:55 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e136so21093132ybc.4
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xm6p2TPoLkcezYPeHVT1TduSqKJLSegBj7Y2luxctLo=;
        b=DBZRdIZendH7vZXki7OhAY8AvYcWlz1yhNr9N+pposexvq5uyfRVJpCCPBeCZ9CUzv
         WPcALAO+l8fu2lYnG/v8D9J3kiM+r3qtHLHVSpRtlJq/utjX9ZvRM+CPNpU3suFQ/AI8
         4M+qnl6Ta7upnzNiyOAQYSUwtum75jIJQSOgcvnRkRP/X07fLSFhyOunDXF0lRT23FPt
         nJFKJXVFgYFzc1NglXOqNlQ2MDC9wk8jgQgvcaow1bIKj28haWfmOheFtbkjhCr8PzeD
         lQ0aXLNQeJvwRgubJLgJ46Z+tq0lDYVjIyen/Lyp8OdXZz7WEnqCCGGus4SVeOb+R5yB
         ck8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xm6p2TPoLkcezYPeHVT1TduSqKJLSegBj7Y2luxctLo=;
        b=kcTr29rBsTTCoopvkTkM/8Eh3NteMzsEMGQl2N2un9U9O8wkRcoYAANef/8rX4h54C
         yPpxr0vkVWaUFsla345moktB3Bu8kqcdzS84pr5KspUlomKf7Dp7uYXQMyXSgzt+A7Jh
         TpqDFeH7D5PeBNF63yPKeX0OF6ttresqtT6KW+mTJFYw8GaW9LcJwoEgwaYFfi5uHWNR
         NuPnmcSEMdb0Bke7bEoqWcr4duR8kUhGeY0unv92LCzzcLBoPZGqaVllWhjQVab32J/8
         A480aUopvizgFxCma1q/rh1PVxtXB9EPg92JEVXWBQ36NUIBJ1JUmXOvzG1nzJKXgvLT
         HfMg==
X-Gm-Message-State: AOAM531O5R0BeZQCBQPxE0KvY3TddFC7DKljZhAYmC1wzZLwl8uUQ8WD
        UxmRl5765UkLqSCpcAiwoMGAGgkwvDgXfKIRmZ9fUhOzRns=
X-Google-Smtp-Source: ABdhPJw0ZXcMM6ODrWA4Cxi5F9B+75YrbpcugqaEgjQSKfJD56Kg/khs16VEx91jx2/3sqtsGDvORaVETpq0PXUqfJo=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr63509880ybf.114.1636131355031;
 Fri, 05 Nov 2021 09:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211103220845.2676888-1-andrii@kernel.org> <20211103220845.2676888-12-andrii@kernel.org>
 <3b6d0dc7-d43d-8e1d-a302-311e946fd47c@fb.com>
In-Reply-To: <3b6d0dc7-d43d-8e1d-a302-311e946fd47c@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 5 Nov 2021 09:55:43 -0700
Message-ID: <CAEf4BzZPqrzemG_qexXKMTnacM4QfkSrptQzLUb2eKPqAy4cNw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 11/12] selftests/bpf: use explicit
 bpf_prog_test_load() calls everywhere
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 5, 2021 at 12:36 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 11/3/21 6:08 PM, Andrii Nakryiko wrote:
> > -Dbpf_prog_load_deprecated=bpf_prog_test_load trick is both ugly and
> > breaks when deprecation goes into effect due to macro magic. Convert all
> > the uses to explicit bpf_prog_test_load() calls which avoid deprecation
> > errors and makes everything less magical.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 5588c622d266..2016c583ed20 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -24,7 +24,6 @@ SAN_CFLAGS  ?=
> >  CFLAGS += -g -O0 -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)           \
> >         -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> >         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)                      \
> > -       -Dbpf_prog_load_deprecated=bpf_prog_test_load                 \
> >         -Dbpf_load_program=bpf_test_load_program
> >  LDLIBS += -lcap -lelf -lz -lrt -lpthread
> >
>
> I'm glad that this magic is going away, it's very unintuitive.
>
> That said, I wonder if there's some way to complain loudly if a prog_test uses
> bpf_prog_load instead of bpf_prog_test_load. Otherwise will have to manually
> guard against it slipping in in some test. This comment applies to patch 12
> as well for bpf_load_program.
>

bpf_prog_test_load() shouldn't really be used going forward.
bpf_object__open() + bpf_object__load() is a way to go. Better yet,
stick to skeletons.

As for bpf_test_load_program(), the only reason for it is
BPF_F_TEST_RND_HI32 flag, and I think we have and have had enough
coverage for that, so there is no need to want to keep using it for
new code.

So I think it's good as is.


> > @@ -207,6 +206,7 @@ $(OUTPUT)/test_lirc_mode2_user: testing_helpers.o
> >  $(OUTPUT)/xdping: testing_helpers.o
> >  $(OUTPUT)/flow_dissector_load: testing_helpers.o
> >  $(OUTPUT)/test_maps: testing_helpers.o
> > +$(OUTPUT)/test_verifier: testing_helpers.o
>
> [...]
>
