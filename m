Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D7E5B3F75
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 21:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIITYt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 15:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIITYr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 15:24:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC792F3BE
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 12:24:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s11so3955697edd.13
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=w6UfxCTziW1stFc/lwqMuwG5rqvUjmwGbcvVEYcPsgM=;
        b=lcx4xoH5ms+KGPJhB5z9Rg22wQe6XTPeB3tlzS8hyiAJj6v/qVry6Q2IYO3vH4b9SS
         R7RFryql+grn7FR/RvkchnDv9SvQGzXKKu7zAWVWCXSqav06B2dM6grcoSGA6E+30Svg
         Yi7z3aM8B6HgKqdKa1F/HT9MXqHPXZym1LWHjKXacCiz5T/zcc3Md9PIzuL1rhS5b+wI
         21fqtuuDOpKzelQL/s0ywigPcI+bY5a97X2pIQT9xpdoqGZLzBSXg8H8DqcUbY0nh5X5
         LsdCv7nKwcfeGtruIMxLUu3OF20rgR90NXcxVpSeEHsRAWEJSDJ5kdJhjL4EA+hTt46g
         G2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=w6UfxCTziW1stFc/lwqMuwG5rqvUjmwGbcvVEYcPsgM=;
        b=XSzY5nBQ7U9YGus+vi23daK9xFFdk7NDJ4Uf0FJidwdvVHOSAk9upm2abh9mBf6PyL
         hnL07FtM6QqIPMLoIcEoSenTTz8EVcROzw0qYBvuF2PUQFiLSkEnot7wt7Mg9qrBZKP1
         3VQiLL6qtkMXfbrlD60G/Jam1U/EkEgWNeQSYfsWfvhnmWHKijhXDgm8L2qXuT5npicG
         IqJVhv+qPp1yfkm5MG2xRxpzXNZJYbIs3iGqgEvv5ra46xataGWLq0zhgvAnxvjdYsf0
         0VXBmMbKbHtpXb93qJwNH3rwXo24M//71tm42IpHatUXFqKEmKRBZ7oFCPdHbtkni8rc
         RraA==
X-Gm-Message-State: ACgBeo3ouWgNGYKJaDsr9mohZ9ugG+xrmMslK0yWWhTVoI43yVzLVs+s
        Yg9dF+++GfA0jBdxey6ZKwkA5hScb80pEOW8H0Q=
X-Google-Smtp-Source: AA6agR7QE/LmKxvSMzOKPfGBgd+/0wiHvWJ/KC9z84mbfrjcG7kZ6L+sqQpny39R+2UwQGPZsEkE9mr4pWU8I+6xYXk=
X-Received: by 2002:a05:6402:1946:b0:44e:a406:5ff5 with SMTP id
 f6-20020a056402194600b0044ea4065ff5mr12959656edz.14.1662751484685; Fri, 09
 Sep 2022 12:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220826231531.1031943-1-andrii@kernel.org> <20220826231531.1031943-4-andrii@kernel.org>
 <CACYkzJ7dNQe58g58qUBQJ3kP86o-vvLoFw+e9_hgH-Ltb9ZAHQ@mail.gmail.com> <a7cae4ad-be07-893f-3923-a64d7fc20cc7@iogearbox.net>
In-Reply-To: <a7cae4ad-be07-893f-3923-a64d7fc20cc7@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 12:24:33 -0700
Message-ID: <CAEf4BzaKCU+qzX9qVDMYkPBxnzcBHfFMYP-n0uqojh5q_L221Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add veristat tool for
 mass-verifying BPF object files
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
        ast@kernel.org, kernel-team@fb.com
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

On Mon, Aug 29, 2022 at 7:50 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/28/22 1:53 AM, KP Singh wrote:
> > On Sat, Aug 27, 2022 at 1:15 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> >>
> >> Add a small tool, veristat, that allows mass-verification of
> >> a set of *libbpf-compatible* BPF ELF object files. For each such object
> >> file, veristat will attempt to verify each BPF program *individually*.
> >> Regardless of success or failure, it parses BPF verifier stats and
> >> outputs them in human-readable table format. In the future we can also
> >> add CSV and JSON output for more scriptable post-processing, if necessary.
> >>
> >> veristat allows to specify a set of stats that should be output and
> >> ordering between multiple objects and files (e.g., so that one can
> >> easily order by total instructions processed, instead of default file
> >> name, prog name, verdict, total instructions order).
> >>
> >> This tool should be useful for validating various BPF verifier changes
> >> or even validating different kernel versions for regressions.
> >
> > Cool stuff!
>
> +1, out of curiosity, did you try with different kernels to see the deltas?

Nope, not yet, barely got the code to the current state before leaving
on vacation. But I thought about using this to track regressions and
improvements over time as we make changes to BPF verifier. I was
thinking to have not just table human-readable output, but also csv
and/or json, so that we can build some sort of automation to run this
periodically (or even in BPF CI for each patch set) and yell about
significant changes. veristat changes are easy, but someone will need
to build this sort of automation. There are projects like rustc (Rust
compiler) that have this sort of thing very nicely formalized, we
might want to do that for Clang + BPF verifier changes as well.

>
> > I think this would be useful for cases beyond these (i.e. for users to get
> > stats about the verifier in general) and it's worth thinking if this should
> > be built into bpftool?
> >
> >>
> >> Here's an example for some of the heaviest selftests/bpf BPF object
> >> files:
> >>
> >>    $ sudo ./veristat -s insns,file,prog {pyperf,loop,test_verif_scale,strobemeta,test_cls_redirect,profiler}*.linked3.o
> >>    File                                  Program                               Verdict  Duration, us  Total insns  Total states  Peak states
> >>    ------------------------------------  ------------------------------------  -------  ------------  -----------  ------------  -----------
> >>    loop3.linked3.o                       while_true                            failure        350990      1000001          9663         9663
> >
> > [...]
>
> nit: Looks like CI on gcc is bailing:
>
> https://github.com/kernel-patches/bpf/runs/8072477251?check_suite_focus=true
>
> [...]
>      INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/skel_internal.h
>    In file included from /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:20,
>      INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/libbpf_version.h
>                     from veristat.c:17:
>    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:13:10: fatal error: libbpf_version.h: No such file or directory
>       13 | #include "libbpf_version.h"
>          |          ^~~~~~~~~~~~~~~~~~

hm... Makefile dependencies not correct? I'll check and fix.

>    compilation terminated.
>      INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/usdt.bpf.h
>      HOSTCC  /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/fixdep.o
>    make: *** [Makefile:165: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/veristat.o] Error 1
>    make: *** Waiting for unfinished jobs....
>
> I wonder, to detect regressions in pruning behavior, could we add a test_progs subtest to load
> selected obj files and compare before/after 'verified insns' numbers? The workflow probably
> makes this a bit hard to run with a kernel before this change, but maybe it could be a starting
> point where we have a checked-in file containing current numbers, and e.g. if the new change
> crosses a threshold of current +10% then the test could fail?
>

Heh, wrote above before reading this. But yes, if add CSV output and
add some sort of baseline upload of last stats, we should be able to
do the diff and yell about major regressions. I also want to add
test_progs's test/subtest glob selection logic for object/program
combo so that we can narrow down list of objects and progs within them
to test. Most of programs are trivial and just pollute output, so
having shorter list is better. And then we can check in representative
list into selftests/bpf, just like we do with DENYLIST/ALLOWLIST for
BPF CI.

But you know, baby steps :)


> Thanks,
> Daniel
