Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4819058DB85
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244856AbiHIQBh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 9 Aug 2022 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239710AbiHIQBg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 12:01:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEDC101C0;
        Tue,  9 Aug 2022 09:01:35 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2Hqt3L9xz67gtM;
        Wed, 10 Aug 2022 00:01:30 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 18:01:32 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Tue, 9 Aug 2022 18:01:32 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     "quentin@isovalent.com" <quentin@isovalent.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "terrelln@fb.com" <terrelln@fb.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [PATCH 4/4] build: Switch to new openssl API for test-libcrypto
Thread-Topic: [PATCH 4/4] build: Switch to new openssl API for test-libcrypto
Thread-Index: AQHYm5HfT/KQ8BwklE+dy083QuWM9q2lK0sAgAAmxQCAAVr4gIAAAaGAgAAjZQCAAAjuAA==
Date:   Tue, 9 Aug 2022 16:01:32 +0000
Message-ID: <bf906906df714ebb82259539496ec6be@huawei.com>
References: <20220719170555.2576993-1-roberto.sassu@huawei.com>
 <20220719170555.2576993-4-roberto.sassu@huawei.com>
 <5f867295-10d2-0085-d1dc-051f56e7136a@iogearbox.net>
 <YvFW/kBL6YA3Tlnc@kernel.org> <YvJ6DbzBNsAgNZS4@kernel.org>
 <YvJ7awkCVBYaZ2dd@kernel.org> <23f8c56f584b4da8acf15d050c0443b6@huawei.com>
In-Reply-To: <23f8c56f584b4da8acf15d050c0443b6@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.201.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> From: Roberto Sassu [mailto:roberto.sassu@huawei.com]
> Sent: Tuesday, August 9, 2022 5:29 PM
> > From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> > Sent: Tuesday, August 9, 2022 5:21 PM
> > Em Tue, Aug 09, 2022 at 12:15:25PM -0300, Arnaldo Carvalho de Melo
> escreveu:
> > > Em Mon, Aug 08, 2022 at 03:33:34PM -0300, Arnaldo Carvalho de Melo
> > escreveu:
> > > > Em Mon, Aug 08, 2022 at 06:14:48PM +0200, Daniel Borkmann escreveu:
> > > > > Hi Arnaldo,
> > > > >
> > > > > On 7/19/22 7:05 PM, Roberto Sassu wrote:
> > > > > > Switch to new EVP API for detecting libcrypto, as Fedora 36 returns an
> > > > > > error when it encounters the deprecated function MD5_Init() and the
> > others.
> > > > > > The error would be interpreted as missing libcrypto, while in reality it is
> > > > > > not.
> > > > > >
> > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >
> > > > > Given rest of the tooling fixes from Andres Freund went via perf tree and
> > the
> > > > > below is perf related as well, I presume you'll pick this up, too?
> > > >
> > > > Sure.
> > > >
> > > > >   [0]
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/cor
> > e
> > >
> > > So I fixed up the first one, minor fuzzes, the second I had to fix
> > > conflicts with the patchset from Andres, ended up as below, will test
> > > build it then in my container kit.

Did you push to a remote branch, so that I start from those?

Thanks

Roberto

> > So I backtracked, the way it works needs further consideration with
> > regard to the patchkit from Andres, that is already upstream, so it
> > would be good for Roberto to take a look at what is in torvalds/master
> > now and see if we have to removed that styled thing from Andres.
> 
> Will do. Thanks Arnaldo for adapting the patch.
> 
> Roberto
> 
> > Andres, if you could take a look at Roberto's patchkit as well that
> > would be great.
> >
> > - Arnaldo
> >
> > > commit bea955a0256e20cc18e87087e42f2a903b9a8b84
> > > Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > Date:   Tue Jul 19 19:05:53 2022 +0200
> > >
> > >     bpftool: Complete libbfd feature detection
> > >
> > >     Commit 6e8ccb4f624a7 ("tools/bpf: properly account for libbfd
> variations")
> > >     sets the linking flags depending on which flavor of the libbfd feature was
> > >     detected.
> > >
> > >     However, the flavors except libbfd cannot be detected, as they are not in
> > >     the feature list.
> > >
> > >     Complete the list of features to detect by adding libbfd-liberty and
> > >     libbfd-liberty-z.
> > >
> > >     Committer notes:
> > >
> > >     Adjust conflict with with:
> > >
> > >       1e1613f64cc8a09d ("tools bpftool: Don't display disassembler-four-args
> > feature test")
> > >       600b7b26c07a070d ("tools bpftool: Fix compilation error with new
> > binutils")
> > >
> > >     Fixes: 6e8ccb4f624a73c5 ("tools/bpf: properly account for libbfd
> variations")
> > >     Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > >     Cc: Alexei Starovoitov <ast@kernel.org>
> > >     Cc: Andres Freund <andres@anarazel.de>
> > >     Cc: Andrii Nakryiko <andrii@kernel.org>
> > >     Cc: bpf@vger.kernel.org
> > >     Cc: Daniel Borkmann <daniel@iogearbox.net>
> > >     Cc: Ingo Molnar <mingo@redhat.com>
> > >     Cc: John Fastabend <john.fastabend@gmail.com>
> > >     Cc: KP Singh <kpsingh@kernel.org>
> > >     Cc: llvm@lists.linux.dev
> > >     Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > >     Cc: Nathan Chancellor <nathan@kernel.org>
> > >     Cc: Nick Desaulniers <ndesaulniers@google.com>
> > >     Cc: Nick Terrell <terrelln@fb.com>
> > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > >     Cc: Quentin Monnet <quentin@isovalent.com>
> > >     Cc: Song Liu <song@kernel.org>
> > >     Cc: Stanislav Fomichev <sdf@google.com>
> > >     Link: https://lore.kernel.org/r/20220719170555.2576993-2-
> > roberto.sassu@huawei.com
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > > index 04d733e98bffbc08..9cc132277150c534 100644
> > > --- a/tools/bpf/bpftool/Makefile
> > > +++ b/tools/bpf/bpftool/Makefile
> > > @@ -93,9 +93,11 @@ INSTALL ?= install
> > >  RM ?= rm -f
> > >
> > >  FEATURE_USER = .bpftool
> > > -FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
> > libcap \
> > > +FEATURE_TESTS = libbfd libbfd-liberty libbfd-liberty-z
> > > +	disassembler-four-args disassembler-init-styled libcap \
> > >  	clang-bpf-co-re
> > > -FEATURE_DISPLAY = libbfd libcap clang-bpf-co-re
> > > +FEATURE_DISPLAY = libbfd libbfd-liberty libbfd-liberty-z
> > > +	libcap clang-bpf-co-re
> > >
> > >  check_feat := 1
> > >  NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install
> doc-
> > uninstall
> >
> > --
> >
> > - Arnaldo
