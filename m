Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02255F02A6
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 04:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiI3CQQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 22:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiI3CQP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 22:16:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34792A98DC;
        Thu, 29 Sep 2022 19:16:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b21so2778551plz.7;
        Thu, 29 Sep 2022 19:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date;
        bh=hN8i+ahxYo6RAKbNxNF7K0nemkxzuff1evcs/mHC4xs=;
        b=Jr0I0Xzoxv3h29iH+VrCcH6NXRCTnN0W9lU1CDX6bDMgIzVjRCHwSDRIoPIlG2vB5b
         bySQqoFDCZmFEcrhFlJVZS1Ms9N1ZIzg+ZiwUU6CPFoqH5GNQtFO0bdAD1PtO+g89wQ/
         Vlmgs0l83/WvffuNrTaiUiwfIHa1g8OXYV0t/YHvfLHGlVQ9ge1PZPPyTlDwQahqE97I
         WPm9Hm4wVSZTQ0GkW9Tst8O7p7jYPvhWiUARWkOpaXYWYXZ5nwo7nvHwR9z5lUFi84Py
         qFBi98dG7IQzj7tizxrfXHhcxisv0aLuMBGSgRALMSeFC0ap56ts3T0R8lEKC6xrz7ph
         JyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=hN8i+ahxYo6RAKbNxNF7K0nemkxzuff1evcs/mHC4xs=;
        b=vyBqEY2GPznQ2c7cNhE5Em0dy6FVvlUiHNYI9jplMAnD32cc/xODyEQs/elSnbPU14
         dA9oOarGoD03yKDhSnuDSGqtCQOsypgfIPv6EfEJvJx8cXevZBdQxmuE0bH8MGIcdakD
         FQX8zI/DPMoTH2I5M5tlobGE9T0Erx659ATxGQLhFUbhZjNV1OWpEdl5W/XdZMbQCy+S
         lq9PaChTGkbn6FvFyMmzVmvyezJw+eGypAqaJAalSam4B0TIkIpW9nc/OGlSwFx8aGX8
         No6d7crD33ELH83baIvPKUKHy1GxLUPRTBkWf/xH+VZiYlAvyDQvQE4cEE8bchFBsfMR
         mK1Q==
X-Gm-Message-State: ACrzQf2yT/jeeFeEyOYQzm6YGv42j9xVT9gzzAtA2Uuu8vAUB8H7dKue
        BVUJDeXI/Ujf61XmNUwpd28=
X-Google-Smtp-Source: AMsMyM7gvIK19y8sjE+7B4VM9FGO8XiohKhsIEYqTXhABGeMVOwyZPrc3qshCBP0fsOKEZP7WzqawA==
X-Received: by 2002:a17:902:ce84:b0:176:b0fb:96a7 with SMTP id f4-20020a170902ce8400b00176b0fb96a7mr6311052plg.51.1664504173714;
        Thu, 29 Sep 2022 19:16:13 -0700 (PDT)
Received: from localhost ([98.97.42.14])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ce8100b001782aee4881sm588970plg.153.2022.09.29.19.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:16:12 -0700 (PDT)
Date:   Thu, 29 Sep 2022 19:16:11 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Xin Liu <liuxin350@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com, zhudi2@huawei.com,
        kongweibin2@huawei.com
Message-ID: <6336516b63153_233df208c4@john.notmuch>
In-Reply-To: <CAEf4BzZp1oGtOy56noPtx+MimQq5ua7X25mB4Sf05CHLx=1m0g@mail.gmail.com>
References: <20220924101209.50653-1-liuxin350@huawei.com>
 <20220924101209.50653-2-liuxin350@huawei.com>
 <CAEf4BzZp1oGtOy56noPtx+MimQq5ua7X25mB4Sf05CHLx=1m0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libbpf: add fPIC option for static library
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Sat, Sep 24, 2022 at 3:13 AM Xin Liu <liuxin350@huawei.com> wrote:
> >
> > Some programs depned on libbpf.a(eg:bpftool). If libbpf.a miss -fPIC,
> > this will cause a similar error at compile time:
> >
> > /usr/bin/ld: .../libbpf.a(libbpf-in.o): relocation
> > R_AARCH64_ADR_PREL_PG_HI21 against symbol `stderr@@GLIBC_2.17' which
> > may bind externally can not be used when making a sharedobject;
> > recompile with -fPIC
> >
> > Use -fPIC for static library compilation to solve this problem.
> >
> > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > ---
> >  tools/lib/bpf/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> > index 4c904ef0b47e..427e971f4fcd 100644
> > --- a/tools/lib/bpf/Makefile
> > +++ b/tools/lib/bpf/Makefile
> > @@ -91,9 +91,10 @@ override CFLAGS += $(INCLUDES)
> >  override CFLAGS += -fvisibility=hidden
> >  override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
> >  override CFLAGS += $(CLANG_CROSS_FLAGS)
> > +override CFLAGS += -fPIC
> >
> 
> It seems wrong to force -fPIC for static library just because in some
> situations users might want to statically link their *shared* library
> with *static* libbpf. It's a bit unconventional, even though I see
> situations in which this might be useful.
> 
> But I don't think this can be a default. I see three possible solutions:
> 
> 1. Do nothing. Let users specify EXTRA_CFLAGS=-fPIC if they need
> position-independent static lib
> 2. Let packagers decide this (again, through EXTRA_CFLAGS or by
> patching Makefile, whichever is best). Or maybe build both PIC and
> non-PIC static libraries and package both?
> 3. Produce PIC and non-PIC libbpf.a libraries from libbpf's Makefile.
> 
> I'm not sure which one is the best answer, would be nice to hear
> opinions of people who do the packaging and distribution of libbpf in
> distros.

Not a distro or pkg maintainer but my $.02 is I would just leave it
for 1 and 2.

> 
> >  # flags specific for shared library
> > -SHLIB_FLAGS := -DSHARED -fPIC
> > +SHLIB_FLAGS := -DSHARED
> >
> >  ifeq ($(VERBOSE),1)
> >    Q =
> > --
> > 2.33.0
> >
