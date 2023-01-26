Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C836567D99B
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 00:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjAZX3r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 18:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjAZX3q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 18:29:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBEA36474
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 15:29:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so4308925wma.1
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 15:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5HrUn5I9qfKZcMopHe92od24/2jGYkZVupsVLPzvQP4=;
        b=qA8hP4xJYb/OhZahIzuKeZIiLiF0ZiyBq1zEUpkPZtCNENsLOMKZAo8PEcHYNbmeIR
         6Iz0duuycDaEtDv9kmVZkWd2I6WjmO/8kh/ZkxdZ8W2EMEbSk6shRHw7riAIH6uMZtS+
         UuMnpOADf7glZuN6WLQJQbx1aKQKCHppvnPaV1JPMM4MDyHC3Iy3c/VrkxZMSLwN/gJm
         VDG8f5zNcHRSSlfS6G3vE6FeZFNmt4MloJDdHfGBJJQwjmbs8mPuF9bnUlbYQWdE+VEA
         g5QmcvhQ80PLd3eRoQKslTcJz5HqhYjPBH3M8hab3gnDSVDWBcDka77E41jziWgYY8yg
         XgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HrUn5I9qfKZcMopHe92od24/2jGYkZVupsVLPzvQP4=;
        b=GRO0OX3mFsS7l+95HVDCWF0OCLMg6uvBZNYF3Biia363rK9wNgbQpThE6KK+ICbZN4
         abQSpPPe1/Rh8XVGBxl94FlLRMR1HrONLnIK7eOItAD4n5SISKoG3sG8LcGhSUli9XlP
         cDv5a5FDJ384AumrsYHar53W0k1Q3YrdwWX/H5jOEuYuwjLNLP4l0YH2RdF93ZN4PkSM
         hK4Mz1nlSnFYriBphqRZKmaFkV4GCPOxXQoEq4WnfqDQWqVpQ6OUQf7Bn3r07B17PDRB
         GKcpFTPDPE45o74IVPdC1ttNMGiMDWRiObLILAdJ7xaykjb2KprvCfiDUbpl4BJfoVYg
         k+LQ==
X-Gm-Message-State: AFqh2kqKWGF9E9XUc3DD+1Z8Qm6e3gvaZ0OmVtctCQzW+QvoNpDMtfM1
        jkLSfEv8o05w4yDtlHrl9Iw=
X-Google-Smtp-Source: AMrXdXvx7rlYM6U8PpkQgC2CDkPlC7dPZplT020aKfJcIRzjOR3vUa0I3wNso6h40foNb7NjK8qo9g==
X-Received: by 2002:a7b:c5cb:0:b0:3da:fac4:7da3 with SMTP id n11-20020a7bc5cb000000b003dafac47da3mr36704765wmk.36.1674775783865;
        Thu, 26 Jan 2023 15:29:43 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b003db09692364sm6778139wmn.11.2023.01.26.15.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 15:29:43 -0800 (PST)
Message-ID: <aff79e80ef4ae0751f82de42b761b6f27355db1a.camel@gmail.com>
Subject: Re: [RFC bpf-next 3/5] selftests/bpf: generate boilerplate code for
 test_loader-based tests
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Fri, 27 Jan 2023 01:29:42 +0200
In-Reply-To: <CAEf4BzaKe3HMmYKvYKarcb7SKvd2Uurd22U5tLjE0RyNMgpSAg@mail.gmail.com>
References: <20230123145148.2791939-1-eddyz87@gmail.com>
         <20230123145148.2791939-4-eddyz87@gmail.com>
         <CAEf4BzaKe3HMmYKvYKarcb7SKvd2Uurd22U5tLjE0RyNMgpSAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-01-25 at 17:43 -0800, Andrii Nakryiko wrote:
> On Mon, Jan 23, 2023 at 6:52 AM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > Automatically generate boilerplate code necessary to run tests that
> > use test_loader.c.
> >=20
> > Adds a target 'prog_tests/test_loader_auto_wrappers.c' as part of
> > rulesets for 'test_progs' and 'test_progs-no_alu32'. The content of
> > this C file is generated by make and has the following structure:
> >=20
> >   #include <test_progs.h>
> >=20
> >   #include "some_test_1.skel.h"
> >   #include "some_test_2.skel.h"
> >   ...
> >=20
> >   void test_some_test_1(void) { RUN_TESTS(some_test_1); }
> >   void test_some_test_2(void) { RUN_TESTS(some_test_2); }
> >   ...
> >=20
> > Here RUN_TESTS is a macro defined in test_progs.h, it expands to a
> > code that uses test_loader.c:test_loader__run_subtests() function to
> > load tests specified by appropriate skel.h.
> >=20
> > In order to get the list of tests included in
> > 'test_loader_auto_wrappers.c' the generation script looks for
> > 'progs/*.c' files that contain a special comment:
> >=20
> >   /* Use test_loader marker */
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
>=20
> It feels like this is a bit of an overkill, tbh. There are
>=20
> $ ls verifier/*.c | wc -l
> 94
>=20
> files. We can move each migrated set of tests from verifier/xxx.c to
> progs/verifier_xxx.c. And then just have just manually maintained
> prog_tests/verifier.c file where for each converted test we have one
> #include and one void test_some_test_1(void) { RUN_TESTS(some_test_1);
> }.
>=20
> It sometimes would useful to add some extra debugging printfs in such
> a file, so having it auto generated would be actually an
> inconvenience. And that on top of further Makefile complication.
>=20
> For initial conversion we can auto-generate this file, of course. And
> then for each migrated file adding 2 lines manually doesn't seem like
> a big deal?

Ok, I'll remove the makefile changes.

>=20
>=20
>=20
> >  tools/testing/selftests/bpf/Makefile          | 34 +++++++++++++++++++
> >  .../selftests/bpf/prog_tests/.gitignore       |  1 +
> >  2 files changed, 35 insertions(+)
> >=20
>=20
> [...]

