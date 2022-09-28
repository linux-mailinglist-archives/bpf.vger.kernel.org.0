Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37A35ED7DC
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiI1Iei (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiI1IeX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 04:34:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA5788DDF;
        Wed, 28 Sep 2022 01:34:13 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McqRx2qbnzWgnn;
        Wed, 28 Sep 2022 16:30:05 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 16:34:11 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 16:34:10 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <quentin@isovalent.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kongweibin2@huawei.com>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
        <martin.lau@linux.dev>, <sdf@google.com>, <song@kernel.org>,
        <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
        <yanan@huawei.com>, <yhs@fb.com>, <zhudi2@huawei.com>
Subject: Re: [PATCH 1/2] libbpf: add fPIC option for static library
Date:   Wed, 28 Sep 2022 16:32:56 +0800
Message-ID: <20220928083256.57679-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <c5c5cedb-4b32-2569-1d55-fc95cad1b260@isovalent.com>
References: <c5c5cedb-4b32-2569-1d55-fc95cad1b260@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 27 Sep 2022 at 6:21:20 PM Quentin <quentin@isovalent.com> wrote:
> Sat Sep 24 2022 11:12:08 GMT+0100 ~ Xin Liu <liuxin350@huawei.com>
> > Some programs depned on libbpf.a(eg:bpftool). If libbpf.a miss -fPIC,
> 
> Typo "depned"
> 
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
> >  # flags specific for shared library
> > -SHLIB_FLAGS := -DSHARED -fPIC
> > +SHLIB_FLAGS := -DSHARED
> >  
> >  ifeq ($(VERBOSE),1)
> >    Q =
> 
> Hi, the two patches look OK to me, but it would be nice to have a bit
> more context on what the flags do other than “fixing this particular
> issue” and how they improve bpftool security. It would also be
> interesting to have a note on what it does on various architectures, my
> understanding is that only some archs are supported (I read AArch64,
> m68k, PowerPC and SPARC), I guess the flags are silently ignored on x86
> for example?
> 
> Thanks,
> Quentin
> 
This advice is very useful to me. Thank you very much for your reply.
I'll fix it in the V2 version.

Thansk,
Xin Liu
