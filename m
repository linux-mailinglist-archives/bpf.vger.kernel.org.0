Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539A05258E3
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358835AbiEMAK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 20:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358421AbiEMAKz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 20:10:55 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8BB186E1
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:10:52 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id x21so2605506uan.13
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCM9tzpaoYZCWjQGcYyn7smRlnkB6ORMRPPDiqvvcoA=;
        b=iSSWyB5McMp+jGBA7XxyXI8Y7g1WBxp9bkRVc0hReuY4kK7bR3/dNxSLOhRznwfkTu
         hP7KFo2wHURJPLnzAXbVCojkOxMU6e9LvVAC+03Nsw6wB6bBDvLgGqtIUQl8n9T7JNUI
         4dbnepezKLBGuWgOrZXbCYIAsoMZ1RQYSfwyxTWZTPQz42yvKEyQ0niRFv1M8jsHJ3Jy
         vBTqIR0XO8fWyGjL2+GJeppP663bVTsjLTh1S1JRcFwIv7fMGOPzL1vGVGwO2oDXGkw7
         kWxxV/nrTwuBJ/QSKGFI/Hu6aJoIECSKYPeEm+EQqc+Z0rvDDcvcjtA+cEimcEPS9B1o
         rC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCM9tzpaoYZCWjQGcYyn7smRlnkB6ORMRPPDiqvvcoA=;
        b=M/a/sMKmdZCVAFKnXea+AJXFYhHCK8D5vr/OOuT42Z3dcg5wPBBKrWWOUzjAXdU5vN
         HIG5q1NDqcdQbDe4OnHxddG3a3Cal4zriBvoq0IsrbDlxtjSC2OLh52O0smHQpIS/Y9m
         8fS7t2veFeos/cDqKpSvJaZ+eU3aSiHbzdyGFCuhP7ycBlAeTC6nrxxDBP6hAd5lMLay
         GWXEySaJjweBCeko93GmyuMFyOsG0HJryoA9OlCQGKvCBwjZzShJtJ+HrlD7s1Zvdfuh
         bCeJVsowNuxHWxPgRunqC2tNI1fP3jyhmAkT0GX69ctKPV5qrqgLooCfIJQauDSkusl5
         x28A==
X-Gm-Message-State: AOAM531ibDzKMf0n9MqwDGhjd9alKgJI56Cy39e0qh8wijFT9uTj/5E1
        XHgN6qMNpmkUnBwqVj+hBTiJG5P50WwpbgZggruY7xfl
X-Google-Smtp-Source: ABdhPJzQoZRfniQ5VfKfIWmc/g1mtEo6moWpdzH5lVTAMVta6QoVUcsAzOW4x/8xDn+fqPyS4KEn6ZNrqSSsc52Bhtc=
X-Received: by 2002:ab0:1343:0:b0:362:9e6c:74f5 with SMTP id
 h3-20020ab01343000000b003629e6c74f5mr1396396uae.15.1652400651244; Thu, 12 May
 2022 17:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220511194654.765705-1-memxor@gmail.com> <20220511194654.765705-4-memxor@gmail.com>
 <CAEf4BzZm2rVt3Xxahah4cDur3o1LtUU399KYe5+ZzOaDck+cGA@mail.gmail.com> <20220512235828.pmzwufm7wzmqss42@apollo.legion>
In-Reply-To: <20220512235828.pmzwufm7wzmqss42@apollo.legion>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 May 2022 17:10:40 -0700
Message-ID: <CAEf4BzbLybOwDw1i5+xNF7=X_s5K41BnPvuF38UgJHPv46AEHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add negative C tests for kptrs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 4:57 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 08:38:16AM IST, Andrii Nakryiko wrote:
> > On Wed, May 11, 2022 at 12:46 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > This uses the newly added SEC("?foo") naming to disable autoload of
> > > programs, and then loads them one by one for the object and verifies
> > > that loading fails and matches the returned error string from verifier.
> > > This is similar to already existing verifier tests but provides coverage
> > > for BPF C.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/map_kptr.c       |  87 +++-
> > >  .../selftests/bpf/progs/map_kptr_fail.c       | 418 ++++++++++++++++++
> > >  2 files changed, 504 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_fail.c
> > >
> >
> > [...]
> >
> > > +
> > > +static void test_map_kptr_success(void)
> > >  {
> > >         struct map_kptr *skel;
> > >         int key = 0, ret;
> > > @@ -35,3 +113,10 @@ void test_map_kptr(void)
> > >
> > >         map_kptr__destroy(skel);
> > >  }
> > > +
> > > +void test_map_kptr(void)
> > > +{
> > > +       if (test__start_subtest("success"))
> > > +               test_map_kptr_success();
> > > +       test_map_kptr_fail();
> >
> > I think the intent for this was to be another subtest, right? Worth
> > fixing in a follow up?
> >
>
> No, instead I am calling test__start_subtest inside it for each program name
> that is failing, to make them the subtest. In that case, it should be alright?

Ah, ok, it's quite confusing to have test__start_subtest in different
functions (though not illegal, I suppose). I'd rather have that test
loop right here in test_map_kptr() function, but it's no big deal

>
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> > > new file mode 100644
> > > index 000000000000..05e209b1b12a
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> > > @@ -0,0 +1,418 @@
> >
> > [...]
>
> --
> Kartikeya
