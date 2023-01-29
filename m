Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A31A67FC38
	for <lists+bpf@lfdr.de>; Sun, 29 Jan 2023 02:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjA2Bui (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 20:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjA2Buh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 20:50:37 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5823F756
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 17:50:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id mg12so23088387ejc.5
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 17:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQeReT042vDHO/UN9fa8MXePtTdvjhaEkhdWXrklncI=;
        b=hd7CJb8otnvpCZZ6qo6o0quTkgCZFz0KZyv2U2dajrJdrc4iy5s0xAgIoFvL9c6sKc
         P2R8EX7t7O7XhItkU3Iiu1SErOAC1FNPX0wGFhgPV7jw65qZ3l2KiHiQGixJrkmXClmm
         2kvUrHxfJtysi763ZRlxXvzH3sXin7Ze9/sbWv1iA+5DMK/hIz8SD19P8Kevgn6xnTQj
         K48JbakitHEbmuJVPwS87D5Hm5Gidy9JK7WInN5idaVRcSkGrxAqOjVpSzA7u0rjFlIM
         NFxp6a/FpWdhZKoOplgfhUdm2OCn8EAlsyfIzLiAoaVPrpDqXoDuMi2mJ9sc8TqJVaJB
         le0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQeReT042vDHO/UN9fa8MXePtTdvjhaEkhdWXrklncI=;
        b=fUsu6Ty8AC+l8j11WEFznNI7PC5q7v3jlgZbLGf+HTQIB1vhx1EZXrVpTorsry1rxU
         9TNrNkG7e+liRhvw6w2UdsXVest3d0Gf3rI6TqRS9OvVTpX6Zj+cTfLnPlJIcFyBXfk2
         TrAGRLdkGRFf8q2VhsyCVo5Y661XJpWJZRstA8z5hm+SlD9HCNZQeUu0A+4qZNduXPRe
         iahKr97Rz2TkTxW2HRkSVkj7nsg8jjk/VmtzuZq4qXw4DxeCawMWZQ36r0D6BsrG/UzR
         clTeeXBTwuz97i1qxBV1DzWlYj/lp2NZdBIRKV3p0iG1RRfMTNY8zZNNMibxOowlnZE1
         H4mQ==
X-Gm-Message-State: AFqh2koTn2M77RY6qk9Bz2J6soHYNbMxHGqC50PDpBBp7FVJuqF8fBlZ
        TrFcFrVh7OxKIi6y/TfYMLmAtoTm+kbB/oex5fU=
X-Google-Smtp-Source: AMrXdXvng1Wy5HaAjr06fgihZMvRupAUV7B9cNErbpmIUXxoQBbbwd5DicP2BFpdHPGKO+feEdqPBQl3JVKK0AlOyjc=
X-Received: by 2002:a17:906:fa8d:b0:7c1:9aaa:eb02 with SMTP id
 lt13-20020a170906fa8d00b007c19aaaeb02mr7383426ejb.65.1674957035157; Sat, 28
 Jan 2023 17:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20230128000650.1516334-1-iii@linux.ibm.com> <20230128000650.1516334-4-iii@linux.ibm.com>
 <20230128204933.6uzlvt45dpgi7zik@MacBook-Pro-6.local>
In-Reply-To: <20230128204933.6uzlvt45dpgi7zik@MacBook-Pro-6.local>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 28 Jan 2023 17:50:23 -0800
Message-ID: <CAADnVQJ2WKbrTswPzcOprwup_wY3Wi8yFZ_wAZgTb6rTScgHRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/31] selftests/bpf: Query
 BPF_MAX_TRAMP_LINKS using BTF
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Sat, Jan 28, 2023 at 12:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Jan 28, 2023 at 01:06:22AM +0100, Ilya Leoshkevich wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> > index 564b75bc087f..416addbb9d8e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> > @@ -2,7 +2,11 @@
> >  #define _GNU_SOURCE
> >  #include <test_progs.h>
> >
> > +#if defined(__s390x__)
> > +#define MAX_TRAMP_PROGS 27
> > +#else
> >  #define MAX_TRAMP_PROGS 38
> > +#endif
>
> This was a leftover from v1. I've removed it while applying.
>
> Also dropped sk_assign fix patch 18, since it requires 'tc'
> to be built with libbpf which might not be the case.
> Pls figure out a different fix.
>
> Pushed the first 26-1 patches. The last few need a respin to fix a build warn.
> Thanks! Great stuff.

One more thing.
When you respin please update DENYLIST.s390x,
so that BPF CI can confirm that a bunch of tests are now passing.
Most of the denylist can be removed, right?
