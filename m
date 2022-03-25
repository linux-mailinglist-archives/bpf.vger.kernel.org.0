Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00724E756E
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356699AbiCYOyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356285AbiCYOyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:54:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBBC5DA46
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:52:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id i11so8280187plr.1
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rqUlUlNj6xqfFIQVPbbTN5Kp8hbAyVfHMuqJiY4fols=;
        b=OPMReG6E7wYMZhearkPg2mZxbh0lO4DxuJcTuBdQLFczVe9HrHbyZbgv5ne00Dp3p4
         zdJjp/O1hhkAVj0fDIwERsg6vYYt1IfZRRsFUN2+n73OxhYLAsZxRfo4bHsyx0bBW6in
         GSHBM/cGyS+3VEuk5q0fF3H7KRBqjt7q3ieVO8jC5uUyE6qcp/kjPvldg9lfs6LO5NNb
         B4sIu/qD80xrh5oebOB/dI/VWjlO231nCMhKHAgTfAbgl4qFKOMgvbYDxYOJUgeUSAUO
         c4uwhSny+S8St/AzUMOoU21cK7sOvTK4IKfDlWrbLf8YyV/9VhfdWckbcay1inyTcxVZ
         2KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rqUlUlNj6xqfFIQVPbbTN5Kp8hbAyVfHMuqJiY4fols=;
        b=GuZLf0UnvPq0pgnCO4WtZ+5d/P+auxRMDvWayxnGZL5kHJjLYoAU9VPRbqztH28j0J
         BoxR1UpZagQMY+it+cYzi4ajfWCzO02JKVMBqMCYlvxfLGDXJcbR0jIWMbxNifABG4V/
         PvAluBBwakcqMdYkh5yyenoKYZXZYAkJOhYlrgRhMhGCnAMWcJWUtZh+RxG5Y6uylov0
         xi309xFRWJs3E9Yx6bBOQDFIIEz8mWDQp0+/stwfK3+IsQWtoZoH7jXg2DHcP5Dz0gbd
         fLrBKv5gdZx+OWAeNE5GJ0D2YfSfQ2yS7rsr1g/4khuQKmZ8N7llvtPB0GmchB4m+4zI
         ExxA==
X-Gm-Message-State: AOAM531oeyGTkHC+r+WqzLbp3+4d7VFUqrDnjdpWSmCFNxrWcWOb6LL2
        3YzaiKRn2/VWUbZ+Jv0Km3w=
X-Google-Smtp-Source: ABdhPJzOUMycYGAvwHNXzo90XZYfDs7gbmHSl9IqUCvFebyn6NRliRjot/4zf3fZnKeaDjmINGxH/g==
X-Received: by 2002:a17:902:d3c5:b0:154:a3b5:d918 with SMTP id w5-20020a170902d3c500b00154a3b5d918mr11912077plb.91.1648219965741;
        Fri, 25 Mar 2022 07:52:45 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id 123-20020a620681000000b004fa7c20d732sm6910049pfg.133.2022.03.25.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:52:45 -0700 (PDT)
Date:   Fri, 25 Mar 2022 20:22:43 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 12/13] selftests/bpf: Add C tests for kptr
Message-ID: <20220325145243.ddmznz3xoczx35rw@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-13-memxor@gmail.com>
 <CAEf4BzauqNj1xfipPUFx3nBMQKEQ_WD_RWOKsxCLcV5zecsCtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzauqNj1xfipPUFx3nBMQKEQ_WD_RWOKsxCLcV5zecsCtw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 23, 2022 at 02:30:57AM IST, Andrii Nakryiko wrote:
> On Sun, Mar 20, 2022 at 8:56 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > This uses the __kptr and __kptr_ref macros as well, and tries to test
> > the stuff that is supposed to work, since we have negative tests in
> > test_verifier suite. Also include some code to test map-in-map support,
> > such that the inner_map_meta matches the kptr_off_tab of map added as
> > element.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/map_kptr.c       |  20 ++
> >  tools/testing/selftests/bpf/progs/map_kptr.c  | 194 ++++++++++++++++++
> >  2 files changed, 214 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/map_kptr.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> > new file mode 100644
> > index 000000000000..688732295ce9
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +
> > +#include "map_kptr.skel.h"
> > +
> > +void test_map_kptr(void)
> > +{
> > +       struct map_kptr *skel;
> > +       char buf[24];
> > +       int key = 0;
> > +
> > +       skel = map_kptr__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
> > +               return;
> > +       ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.hash_map), &key, buf, 0),
> > +                 "bpf_map_update_elem hash_map");
> > +       ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.hash_malloc_map), &key, buf, 0),
> > +                 "bpf_map_update_elem hash_malloc_map");
>
>
> nit: it's quite messy and verbose, please do the operation outside of
> ASSERT_OK() and just validate error:
>
> err = bpf_map_update_elem(...);
> ASSERT_OK(err, "hash_map_update");
>
> And keep those ASSERT_XXX() string descriptors relatively short (see
> how they are used internally in ASSERT_XXX() macros).
>

Ok.

> > +       map_kptr__destroy(skel);
> > +}
>
> [...]
>
> > +
> > +extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
> > +extern struct prog_test_ref_kfunc *
> > +bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
> > +extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> > +
> > +static __always_inline
>
> nit: no need for __always_inline everywhere, just `static void` will
> do the right thing.
>

Ok, will drop.

> > +void test_kptr_unref(struct map_value *v)
> > +{
> > +       struct prog_test_ref_kfunc *p;
> > +
> > +       p = v->unref_ptr;
> > +       /* store untrusted_ptr_or_null_ */
> > +       v->unref_ptr = p;
> > +       if (!p)
> > +               return;
> > +       if (p->a + p->b > 100)
> > +               return;
> > +       /* store untrusted_ptr_ */
> > +       v->unref_ptr = p;
> > +       /* store NULL */
> > +       v->unref_ptr = NULL;
> > +}
> > +
>
> [...]

--
Kartikeya
