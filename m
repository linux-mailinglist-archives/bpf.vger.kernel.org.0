Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194016461D8
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLGTqR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 14:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGTqQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:46:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32910716D3
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:46:15 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id t17so16529372eju.1
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cPNsp3wZavW5a7i9rOyiN1uHHd+20LTSuQwM+kR0bys=;
        b=BmVJlZwzQ3FMtlLyE8uBnZadwWgjd/l/bN1TyNsa17jGL6aSQ6HNEM/Xicf6C1eH/H
         A/n4uGNgHP6W+2XGni8umOWHU09/JmzhLyTRNtQ2jyZJcXybfAr3rArvlnG01nxWzmIh
         jKJEZMhIY6wyTXQGTUk5iSW73Dp9aIashR6GYne5rM64HbVRgT1TQ8fuXrfn/6qvbmST
         fkO2Ltk73Dw80vbDoEoVBu4Pu+O5JTVuO7Co5/iIRlEGuslZ09HDNdNLJbY6FAXvnDWL
         MRD6zmGPeopMDsvgJGkrfbm8b8ElKCOITNVK5qFbHnEF3AUgv8BKL1mhJ/8QL09dhnxf
         c9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPNsp3wZavW5a7i9rOyiN1uHHd+20LTSuQwM+kR0bys=;
        b=b2MRV5INekHpIwyq2bLgmuVjK4Hdq8A4WC4EFTdFTNFR6SfZHnQ5fa1nCGHfzQ6l6Z
         fH0G01E/pFDkT127iy4VEOqgkLjd0e54VTnopUtpGmOT9VS4xy+9EJSxXFcyHp47m3Ec
         De5JkhG41KPOasqSpO/fAX0iuFyHXVk6b9yz9/5vGa42KBeqHTw8mCX+MqyPodmB866z
         GZEnMoej2MG7O3pHQWtOda0NKRt9mIadI7itRAWuR1eTzQNaHlmP0TaSxRNf2+evHoUT
         gOcEUM8nE2H2ppoLRJwuyY9XVa22Xg7i87ZkJj+6dUrZHFjboWYi4nGMuJpvNqPRRM+k
         jKkQ==
X-Gm-Message-State: ANoB5pnJ5dMN0iI9bOWIW2CXzIWsQihn6Dl2yQ8xHUQxkOG1hXHnR188
        buUr6I6utlFhu5eZVH1C4FX2ttFqm40mETm3cj8KFP5Y
X-Google-Smtp-Source: AA0mqf5T4sDtC7SiFLxOeXnvURd/GsIy8+dnhtr9SBu24/VLgbV3k7ZFc4470agSIpzfG4Y9Lq5cpgMA8QIlZ/oIetk=
X-Received: by 2002:a17:906:180e:b0:7a2:6d38:1085 with SMTP id
 v14-20020a170906180e00b007a26d381085mr61516303eje.114.1670442373467; Wed, 07
 Dec 2022 11:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20221206011159.1208452-1-andrii@kernel.org> <Y5AZ5hpE/66KJzUS@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <Y5AZ5hpE/66KJzUS@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Dec 2022 11:46:01 -0800
Message-ID: <CAEf4BzaucaD7VuKknxWK0QXh94urjEJsoihDVBi5UTX9O-8OCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: add generic BPF program
 verification tester
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 6, 2022 at 8:43 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 05, 2022 at 05:11:58PM -0800, Andrii Nakryiko wrote:
> > +
> > +
> > +typedef const void *(*skel_elf_bytes_fn)(size_t *sz);
> > +
> > +extern void verification_tester__run_subtests(struct verification_tester *tester,
> > +                                           const char *skel_name,
> > +                                           skel_elf_bytes_fn elf_bytes_factory);
> > +
> > +extern void tester_fini(struct verification_tester *tester);
> > +
> > +#define RUN_VERIFICATION_TESTS(skel) ({                                             \
> > +     struct verification_tester tester = {};                                \
> > +                                                                            \
> > +     verification_tester__run_subtests(&tester, #skel, skel##__elf_bytes);  \
> > +     tester_fini(&tester);                                                  \
> > +})
>
> Looking great, but couldn't resist to bikeshed a bit here.
> It looks like generic testing facility. Maybe called RUN_TESTS ?

Sure, I will rename it to RUN_TESTS.

>
> > +
> > +#endif /* __TEST_PROGS_H */
> > diff --git a/tools/testing/selftests/bpf/verifier_tester.c b/tools/testing/selftests/bpf/verifier_tester.c
>
> verifier_tester name also doesn't quite fit imo.
> These tests not necessarily trying to test just the verifier.
> They test BTF, kfuncs and everything that kernel has to check during the loading.
>

verifier_tester is bad name, I was intending it as
verification_testing, because it's testing BPF program loading
(verification). But you are right, we most probably will extend it to
allow doing attach/prog_test_run for successful cases (I just didn't
have time to implement that yet).

> In other words they test this:
> > +             err = bpf_object__load(tobj);
> > +             if (spec.expect_failure) {
> > +                     if (!ASSERT_ERR(err, "unexpected_load_success")) {
> > +                             emit_verifier_log(tester->log_buf, false /*force*/);
> > +                             goto tobj_cleanup;
> > +                     }
> > +             } else {
> > +                     if (!ASSERT_OK(err, "unexpected_load_failure")) {
> > +                             emit_verifier_log(tester->log_buf, true /*force*/);
> > +                             goto tobj_cleanup;
> > +                     }
> > +             }
>
> maybe call it
>  +struct test_loader {
>  +      char *log_buf;
>  +      size_t log_buf_sz;
>  +
>  +      struct bpf_object *obj;
>  +};
> ?
> and the file test_loader.c ?
> Nicely shorter than verification_tester__ prefix...

sure, test_loader sounds fine to me, will rename
