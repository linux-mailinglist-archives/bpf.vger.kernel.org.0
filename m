Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAF67C27E
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 02:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjAZBoK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 20:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAZBoJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 20:44:09 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB14C6D6
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:44:08 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw16so1429036ejc.10
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oUFdRMtG08Wy16Kkd7CGJc41p6cBcl1ykR/VwJwxaOs=;
        b=Sm4r4XAPVwn3PpL6Noj0sz1cIb7D0uefNtkMaFfW6hgYO9yrwkVlpn6evTCadRt7yN
         Dsf3XDdhT35R39Q446cf5JSAYw5Oyb5H3tKsZ68gIz1m5V/P1VOo8jtbqfLeHRj9HueM
         NcEXGKdmIZbM4umToH3fHLoSR4fVWFoG7kDx0zOFbf5CCp4nkkFseweQEJIe2/0C3p9M
         S6Bl5rN+Bkodq2nmhGqjdkOJktv9XGH9BbfXVUiagjcYqvWJGUiSLvvNnnq16Fa7lu2t
         +MVyAT0oUiHUKS5LvTAzRS6VhrgWpSBlm724TywKFOZzNdlrZRc27TzzLQCZ/P26wPjR
         DHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUFdRMtG08Wy16Kkd7CGJc41p6cBcl1ykR/VwJwxaOs=;
        b=ADMqk9Iw0QMSu6jpMDWt2wAjsXSMEao9PorOdrZ/peG2eux51huaN0zx80Ir4gPPGu
         xNZ1tzQ9g+rYYfal1SlwCJBxy02PxZ/TUtd6hRVnBYtnffwzttllpVePekg5bylTrzX0
         vIP6ug6mAT+SIz7wxh+kYFML3n9tjaKNzaF/9dsnVGxLzeBtJaDLlM9EeBFmZvCAiIDN
         viFCKihlbdYKF3WcLmdYws/7+w41bdYfmlYfcF8eMRYnKu/mUNRqXIBLJIOWMYeiLD0u
         5Pn90WNxeRfPnymfjFnEI0w9lmSycAIdtmcOfptebA0aK6M5+kCgXvIFdkccIMWk9WUj
         c5Zw==
X-Gm-Message-State: AFqh2kqyuau5uAD1Pl10Bx6+bAOqweT24Dr+nIZTI1mFxLogkfRb+6Al
        JVr4EwZmcox82V3+9lE9ax5lP1zp3zQXCeg0kT0=
X-Google-Smtp-Source: AMrXdXvI7n733dAqcqPj2m3bQIy3D/GZGx29oMXo0ozUSB/gB1QEN59l6xmzmOlPeMLZ/WVLhRkUNt+e0HCWlis6Ws0=
X-Received: by 2002:a17:906:ecb9:b0:86d:97d4:9fea with SMTP id
 qh25-20020a170906ecb900b0086d97d49feamr5533384ejb.141.1674697446901; Wed, 25
 Jan 2023 17:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20230123145148.2791939-1-eddyz87@gmail.com> <20230123145148.2791939-4-eddyz87@gmail.com>
In-Reply-To: <20230123145148.2791939-4-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Jan 2023 17:43:54 -0800
Message-ID: <CAEf4BzaKe3HMmYKvYKarcb7SKvd2Uurd22U5tLjE0RyNMgpSAg@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/5] selftests/bpf: generate boilerplate code for
 test_loader-based tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Mon, Jan 23, 2023 at 6:52 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Automatically generate boilerplate code necessary to run tests that
> use test_loader.c.
>
> Adds a target 'prog_tests/test_loader_auto_wrappers.c' as part of
> rulesets for 'test_progs' and 'test_progs-no_alu32'. The content of
> this C file is generated by make and has the following structure:
>
>   #include <test_progs.h>
>
>   #include "some_test_1.skel.h"
>   #include "some_test_2.skel.h"
>   ...
>
>   void test_some_test_1(void) { RUN_TESTS(some_test_1); }
>   void test_some_test_2(void) { RUN_TESTS(some_test_2); }
>   ...
>
> Here RUN_TESTS is a macro defined in test_progs.h, it expands to a
> code that uses test_loader.c:test_loader__run_subtests() function to
> load tests specified by appropriate skel.h.
>
> In order to get the list of tests included in
> 'test_loader_auto_wrappers.c' the generation script looks for
> 'progs/*.c' files that contain a special comment:
>
>   /* Use test_loader marker */
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

It feels like this is a bit of an overkill, tbh. There are

$ ls verifier/*.c | wc -l
94

files. We can move each migrated set of tests from verifier/xxx.c to
progs/verifier_xxx.c. And then just have just manually maintained
prog_tests/verifier.c file where for each converted test we have one
#include and one void test_some_test_1(void) { RUN_TESTS(some_test_1);
}.

It sometimes would useful to add some extra debugging printfs in such
a file, so having it auto generated would be actually an
inconvenience. And that on top of further Makefile complication.

For initial conversion we can auto-generate this file, of course. And
then for each migrated file adding 2 lines manually doesn't seem like
a big deal?



>  tools/testing/selftests/bpf/Makefile          | 34 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/.gitignore       |  1 +
>  2 files changed, 35 insertions(+)
>

[...]
