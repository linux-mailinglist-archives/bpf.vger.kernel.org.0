Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499CC559D0B
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiFXPMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiFXPMP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 11:12:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821B4D625
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 08:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28654B8293B
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 15:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ADFC34114;
        Fri, 24 Jun 2022 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656083531;
        bh=00tiTpOSJROI7VUQCORfV2zdoxWlyEzuqoIkzjcNLpw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VseHzikcgBNf8q8HP8bj5PTfUuxHg92p+/MGiE2w46eUinqEXBKSLBV43J5qXa+AY
         qYIsL18lZHjKgMImzySoVYVX/WgjIdfPG1Srs3RGQawHHmwMtvTvgIszbaYjL+sTN7
         sh/SzQDUn/OKlnd3Wj2H21n9gQSrUvXbqscJCdHQRFvCuoCf97h/owKwdUh1O2cpVS
         6OvAMVMnsXlPSxSvpvfKfqziqThlwKclaLFjPrdk8AGEbgB2yNKkB5yxesFtS+cThQ
         vhe6M+v8G1BJO/BbnRYTDdBMKKC56hnTtNMdOb36yncl8uKEwuuSyygYT6r2YMHA5r
         4wQv3FCjsHM+A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1EBCA4766B5; Fri, 24 Jun 2022 17:12:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 00/15] libbpf: remove deprecated APIs
In-Reply-To: <CAEf4Bzb75b5cPjv1ZnM9aME3vxy4nxY0=Utp1wd0Z9P3s9mvaw@mail.gmail.com>
References: <20220603190155.3924899-1-andrii@kernel.org>
 <87wndwvjax.fsf@toke.dk>
 <CAEf4Bzb75b5cPjv1ZnM9aME3vxy4nxY0=Utp1wd0Z9P3s9mvaw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Jun 2022 17:12:09 +0200
Message-ID: <87mte2p03a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Sat, Jun 4, 2022 at 3:01 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@ker=
nel.org> wrote:
>>
>> Andrii Nakryiko <andrii@kernel.org> writes:
>>
>> > This patch set removes all the deprecated APIs in preparation for 1.0 =
release.
>> > It also makes libbpf_set_strict_mode() a no-op (but keeps it to let pe=
r-1.0
>> > applications buildable and dynamically linkable against libbpf 1.0 if =
they
>> > were already libbpf-1.0 ready) and starts enforcing all the
>> > behaviors that were previously opt-in through libbpf_set_strict_mode().
>> >
>> > xsk.{c,h} parts that are now properly provided by libxdp ([0]) are sti=
ll used
>> > by xdpxceiver.c in selftest/bpf, so I've moved xsk.{c,h} with barely a=
ny
>> > changes to under selftests/bpf.
>> >
>> > Other than that, apart from removing all the LIBBPF_DEPRECATED-marked =
APIs,
>> > there is a bunch of internal clean ups allowed by that. I've also "res=
tored"
>> > libbpf.map inheritance chain while removing all the deprecated APIs. I=
 think
>> > that's the right way to do this, as applications using libbpf as shared
>> > library but not relying on any deprecated APIs (i.e., "good citizens" =
that
>> > prepared for libbpf 1.0 release ahead of time to minimize disruption) =
should
>> > be able to link both against 0.x and 1.x versions. Either way, it does=
n't seem
>> > to break anything and preserve a history on when each "surviving" API =
was
>> > added.
>> >
>> > NOTE. This shouldn't be yet landed until Jiri's changes ([1]) removing=
 last
>> > deprecated API usage in perf lands. But I thought to post it now to ge=
t the
>> > ball rolling.
>>
>> Any chance you could push this to a branch of github as well? Makes it
>> easier to test libxdp against it :)
>>
>
> Sure, pushed to
> https://github.com/libbpf/libbpf/tree/libbpf-remove-deprecated-apis

Hi Andrii

Took this for a test run, and besides having to fix up the Makefile in
the github repository a bit (diff below), nothing broke
catastrophically. So yay!

It did flush out a BPF object file we used for testing that still had
the old long-style section name, but libbpf does output a helpful error
message for that even if it can get lost in the noise. So I guess that's
as friendly as we can make it :)

-Toke


diff --git a/src/Makefile b/src/Makefile
index 40f4f98b5681..99766f4c418c 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -8,8 +8,8 @@ else
        msg =3D @printf '  %-8s %s%s\n' "$(1)" "$(2)" "$(if $(3), $(3))";
 endif
=20
-LIBBPF_MAJOR_VERSION :=3D 0
-LIBBPF_MINOR_VERSION :=3D 8
+LIBBPF_MAJOR_VERSION :=3D 1
+LIBBPF_MINOR_VERSION :=3D 0
 LIBBPF_PATCH_VERSION :=3D 0
 LIBBPF_VERSION :=3D $(LIBBPF_MAJOR_VERSION).$(LIBBPF_MINOR_VERSION).$(LIBB=
PF_PATCH_VERSION)
 LIBBPF_MAJMIN_VERSION :=3D $(LIBBPF_MAJOR_VERSION).$(LIBBPF_MINOR_VERSION)=
.0
@@ -50,7 +50,7 @@ OBJDIR ?=3D .
 SHARED_OBJDIR :=3D $(OBJDIR)/sharedobjs
 STATIC_OBJDIR :=3D $(OBJDIR)/staticobjs
 OBJS :=3D bpf.o btf.o libbpf.o libbpf_errno.o netlink.o \
-       nlattr.o str_error.o libbpf_probes.o bpf_prog_linfo.o xsk.o \
+       nlattr.o str_error.o libbpf_probes.o bpf_prog_linfo.o  \
        btf_dump.o hashmap.o ringbuf.o strset.o linker.o gen_loader.o \
        relo_core.o usdt.o
 SHARED_OBJS :=3D $(addprefix $(SHARED_OBJDIR)/,$(OBJS))
@@ -64,7 +64,7 @@ ifndef BUILD_STATIC_ONLY
        VERSION_SCRIPT :=3D libbpf.map
 endif
=20
-HEADERS :=3D bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h \
+HEADERS :=3D bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h  \
           bpf_helpers.h bpf_helper_defs.h bpf_tracing.h \
           bpf_endian.h bpf_core_read.h skel_internal.h libbpf_version.h \
           usdt.bpf.h
