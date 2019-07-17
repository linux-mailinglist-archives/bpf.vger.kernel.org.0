Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7DB6B2C6
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2019 02:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfGQAWR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jul 2019 20:22:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41536 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGQAWR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jul 2019 20:22:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so21502775qtj.8;
        Tue, 16 Jul 2019 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5TOuzcko6XHsvSKWxDxv5DWtv966Tffgh+HsiwHY5g=;
        b=DjFMUuwZzMdpJ2ZLh5d7z8qJ/Hb3ige3gfKqiLGleI9HKfYBSHY3nd441Y7kj8foWR
         qUvAZf/95SUQtmULKltGebudLK9Gh1gYDgYzLVaXpMlj0LVEZ5FE2SoxXd4uTnPzND7/
         oFJnVGxsctJXlktS+2/6GG8I3yg/JzzA6Bu1jKnSD2ekzqmxYhyh9h1DUG4IRYm58Z1w
         m6LTM7T4lcCTRTHjxecetrHHfedls3qJ/8LOJOn4RTl77yoaYQfrp+i0ONYG/brVDj3t
         wEmp7DYf4x+S40fG6UczpZmILhCUF9QpjCrpnleHKm4owuMEE1nbh+rVWEIJw5wrB6RC
         OBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5TOuzcko6XHsvSKWxDxv5DWtv966Tffgh+HsiwHY5g=;
        b=oWS2E3dzgFvHbQp1/4lQ5ieYYI09WBmd2E6kYp9rRb/orMw380qdOZEM1SeLALiczj
         qXh1Us0UQATXqvRzqsieRw32JsGy2hyrQldZvsGmHddhdC/i6B3bo7XbPStEEivZ8O9E
         QDsh4UrhqHI6EBbuZ2xYUc5sKVh1cpJz3aMa+QSvd4SEHyo5kr+QW/p/M8egD+ID7naE
         yTE0Se7+pmVblrh55jXpHr3vxoElZfTMRyO3Hyxvb+Ga4FQZnf+xy1VxIDK3up1b3+0l
         GYdVeWO4KyoM3JB26+EFt2PXjATPzxYOPdCnMxZoD62mbGod3ZY5A4KCsPG1LjuxUAT5
         cL/A==
X-Gm-Message-State: APjAAAWCamuVdViM9KStppG52A7DqZ1r3LZabLy5NKX2VcO4RibeHyOC
        MtdLVOHsJXuTLJTZHuX7OI19GonzLo7mWjv8lMI=
X-Google-Smtp-Source: APXvYqxPvMlLgFkLrEVvnynl520lT9e3sKtxAY3l9saYi1wt55TUdq/JYN2ctWXZh1wO7YnYKnNvJC/kLwgvHY7/0Aw=
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr26371518qvh.78.1563322936161;
 Tue, 16 Jul 2019 17:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190716193837.2808971-1-andriin@fb.com> <20190716195544.GB14834@mini-arch>
 <CAEf4BzZ4XAdjasYq+JGFHnhwEV3G5UYWBuqKMK1yu1KRLn19MQ@mail.gmail.com>
 <20190716225735.GC14834@mini-arch> <CAEf4BzY7NYZSGuRHVye_CerZ1BBBLsDyOT2ar5sBXsPGy8g0xA@mail.gmail.com>
 <20190717001457.GD14834@mini-arch>
In-Reply-To: <20190717001457.GD14834@mini-arch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Jul 2019 17:22:04 -0700
Message-ID: <CAEf4BzZQ9MRTNH434=oyxBjQQXWEfjMV4nU14-=LfvERafwRKw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] selftests/bpf: fix test_verifier/test_maps make dependencies
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 16, 2019 at 5:15 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 07/16, Andrii Nakryiko wrote:
> > On Tue, Jul 16, 2019 at 3:57 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > >
> > > On 07/16, Andrii Nakryiko wrote:
> > > > On Tue, Jul 16, 2019 at 12:55 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > > >
> > > > > On 07/16, Andrii Nakryiko wrote:
> > > > > > e46fc22e60a4 ("selftests/bpf: make directory prerequisites order-only")
> > > > > > exposed existing problem in Makefile for test_verifier and test_maps tests:
> > > > > > their dependency on auto-generated header file with a list of all tests wasn't
> > > > > > recorded explicitly. This patch fixes these issues.
> > > > > Why adding it explicitly fixes it? At least for test_verifier, we have
> > > > > the following rule:
> > > > >
> > > > >         test_verifier.c: $(VERIFIER_TESTS_H)
> > > > >
> > > > > And there should be implicit/builtin test_verifier -> test_verifier.c
> > > > > dependency rule.
> > > > >
> > > > > Same for maps, I guess:
> > > > >
> > > > >         $(OUTPUT)/test_maps: map_tests/*.c
> > > > >         test_maps.c: $(MAP_TESTS_H)
> > > > >
> > > > > So why is it not working as is? What I'm I missing?
> > > >
> > > > I don't know exactly why it's not working, but it's clearly because of
> > > > that. It's the only difference between how test_progs are set up,
> > > > which didn't break, and test_maps/test_verifier, which did.
> > > >
> > > > Feel free to figure it out through a maze of Makefiles why it didn't
> > > > work as expected, but this definitely fixed a breakage (at least for
> > > > me).
> > > Agreed on not wasting time. I took a brief look (with make -qp) and I
> > > don't have any clue.
> >
> > Oh, -qp is cool, noted :)
> >
> > >
> > > By default implicit matching doesn't work:
> > > # makefile (from 'Makefile', line 261)
> > > /linux/tools/testing/selftests/bpf/test_maps: CFLAGS += $(TEST_MAPS_CFLAGS)
> > > /linux/tools/testing/selftests/bpf/test_maps: map_tests/sk_storage_map.c /linux/tools/testing/selftests/bpf/test_stub.o /linux/tools/testing/selftests/bpf/libbpf.a
> > > #  Implicit rule search has not been done.
> > > #  File is an intermediate prerequisite.
> > > #  Modification time never checked.
> > > #  File has not been updated.
> > > # variable set hash-table stats:
> > > # Load=1/32=3%, Rehash=0, Collisions=0/2=0%
> > >
> > > If I comment out the following line:
> > > $(TEST_GEN_PROGS): $(OUTPUT)/test_stub.o $(BPFOBJ)
> > >
> > > Then it works:
> > > # makefile (from 'Makefile', line 261)
> > > /linux/tools/testing/selftests/bpf/test_maps: CFLAGS += $(TEST_MAPS_CFLAGS)
> > > /linux/tools/testing/selftests/bpf/test_maps: test_maps.c map_tests/sk_storage_map.c
> > > #  Implicit rule search has been done.
> > > #  Implicit/static pattern stem: 'test_maps'
> > > #  File is an intermediate prerequisite.
> > > #  File does not exist.
> > > #  File has not been updated.
> > > # variable set hash-table stats:
> > > # Load=1/32=3%, Rehash=0, Collisions=0/2=0%
> > > #  recipe to execute (from '../lib.mk', line 138):
> > >         $(LINK.c) $^ $(LDLIBS) -o $@
> > >
> > > It's because "File is an intermediate prerequisite.", but I
> > > don't see how it's is a intermediate prerequisite for anything...
> >
> > Well, it's "File is an intermediate prerequisite." in both cases, so I
> > don't know if that's it.
> > Makefiles is not my strong suit, honestly, and definitely not an area
> > of passion, so no idea
> >
> > >
> > >
> > > One other optional suggestion I have to your second patch: maybe drop all
> > > those dependencies on the directories altogether? Why not do the following
> > > instead, for example (same for test_progs/test_maps)?
> >
> > Some of those _TEST_DIR's are dependencies of multiple targets, so
> > you'd need to replicate that `mkdir -p $@` in multiple places, which
> > is annoying.
> Agreed, but one single "mkdir -p $@" might be better than having three
> lines that define XXX_TEST_DIR and then add a target that mkdir's it.
> Up to you, I can give it a try once your changes are in; the
> Makefile becomes hairier by the day, thx for cleaning it up a bit :-)
>
> > But I also don't think we need to worry about creating them, because
> > there is always at least one test (otherwise those tests are useless
> > anyways) in those directories, so we might as well just remove those
> > dependencies, I guess.
> We probably care about them for "make -C tools/selftests O=$PWD/xyz" case
> where OUTPUT would point to a fresh/clean directory.

Oh, yes, out-of-tree builds, forgot about that, so yeah, we need that.

>
> > TBH, those explicit dependencies are good to specify anyways, so I
> > think this fix is good. Second patch just makes the layout of
> > dependencies similar, so it's easier to spot differences like this
> > one.
> >
> > As usual, I'll let Alexei and Daniel decide which one to apply (or if
> > we need to take some other approach to fixing this).
> I agree, both of your changes look good. I was just trying to understand
> what's happening because I was assuming implicit rules to always kick
> in.
>
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > index 1296253b3422..c2d087ce6d4b 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -277,12 +277,9 @@ VERIFIER_TESTS_H := $(OUTPUT)/verifier/tests.h
> > >  test_verifier.c: $(VERIFIER_TESTS_H)
> > >  $(OUTPUT)/test_verifier: CFLAGS += $(TEST_VERIFIER_CFLAGS)
> > >
> > > -VERIFIER_TESTS_DIR = $(OUTPUT)/verifier
> > > -$(VERIFIER_TESTS_DIR):
> > > -       mkdir -p $@
> > > -
> > >  VERIFIER_TEST_FILES := $(wildcard verifier/*.c)
> > > -$(OUTPUT)/verifier/tests.h: $(VERIFIER_TEST_FILES) | $(VERIFIER_TESTS_DIR)
> > > +$(OUTPUT)/verifier/tests.h: $(VERIFIER_TEST_FILES)
> > > +       mkdir -p $(dir $@)
> > >         $(shell ( cd verifier/; \
> > >                   echo '/* Generated header, do not edit */'; \
> > >                   echo '#ifdef FILL_ARRAY'; \
