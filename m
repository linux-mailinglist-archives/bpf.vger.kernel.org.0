Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DD167BE9D
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjAYVeE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjAYVeE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:34:04 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770895D92D
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:33:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y11so164820edd.6
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qI37ykjNTL1PlCZggU3B3r+PjzJfVF+xequWUnrKL8w=;
        b=ojk+h3/O26zI7DcENOVbwAbemnzB8SR47T7FQOBW9TfuNErxmDfnwVO9ac2ETnOapZ
         d+SnJf5NRmPSQ0yckOOr4BrwWaUFVx0Rc4lCJX7IvQbAjoE72Jpih4aLi9TKBsmMMvWF
         Kd/LpTh7tFajPwVND892vRMs/6xq5k0e1EoybPHmxSfreCS3GplDVOG5rOyohvAO5aga
         RK3yKgIifSYaj8bROwL615tYR221CYYlOBYLG+V6Xi4HIIUfH3b55WivNNQZISfJHYU9
         rSiXCzrzt1WvUVpsc1E1u7Y7XcAs3dV3r6caYmhu1WGOPSjlly4S7EPdpO54cd4yEwat
         YmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI37ykjNTL1PlCZggU3B3r+PjzJfVF+xequWUnrKL8w=;
        b=WwLG8eDUs3xV4aixe5erVA88L1VgfIH8VHHZnczBBEeo368vcLu+Egz+zuUOk2Myj1
         ouZ+ippQfP9yZEJVwhcf+b4tV1i17tKYj1vwcjZ4tZ+MYWfVu1STB2mW9eK2Mt578U73
         3K+meBtCa+ScHu88o6afFOS/yqCtnGo1GC9qasP+pEWgia6WjsMuacgwnx1nrsMyfNGi
         7cVyVdh2PJC/2NoiXxUb39UAia1ajjZJR2h8YICYa0EHidVdIkaOueV03qBQ8I4PpU+r
         bowTp7Iy7on1aJWvJL0llDIURIEfdJ7zQ1R5JnKLoxMyhYvNPNzBRUQ16/+SerdQ8Ld6
         mrsw==
X-Gm-Message-State: AO0yUKWCIcrLJDQY/JEdn7s2QbbFiIRWWOAURbrp4YCXDmla+ixqJnc4
        1UcPr6lf+/0UXJFpz872v4c=
X-Google-Smtp-Source: AK7set+M53lzPgASMQpUi5Jiz3vd+r7z8639mnk+URn1l/ojYjbEmCnMa/xYusqUWsyd3QvbRyto+g==
X-Received: by 2002:a05:6402:360c:b0:4a0:c3f7:69c3 with SMTP id el12-20020a056402360c00b004a0c3f769c3mr486420edb.29.1674682424788;
        Wed, 25 Jan 2023 13:33:44 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906345100b0087851a76573sm337916ejb.74.2023.01.25.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:33:44 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 25 Jan 2023 22:33:42 +0100
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: Move kfunc exports to
 bpf_testmod/bpf_testmod_kfunc.h
Message-ID: <Y9GgNhLiqeX7E3Ib@krava>
References: <20230124143626.250719-1-jolsa@kernel.org>
 <20230124143626.250719-2-jolsa@kernel.org>
 <Y9EFAqdLED3TT43M@samus.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9EFAqdLED3TT43M@samus.usersys.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 11:31:30AM +0100, Artem Savkov wrote:
> On Tue, Jan 24, 2023 at 03:36:22PM +0100, Jiri Olsa wrote:
> > Move all kfunc exports into separate header file and include it
> > in tests that need it.
> > 
> > We will move all test kfuncs into bpf_testmod in following change,
> > so it's convenient to have declarations in single place.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 89 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/cb_refs.c   |  1 +
> >  .../selftests/bpf/progs/jit_probe_mem.c       |  3 +-
> >  .../bpf/progs/kfunc_call_destructive.c        |  3 +-
> >  .../selftests/bpf/progs/kfunc_call_fail.c     |  9 +-
> >  .../selftests/bpf/progs/kfunc_call_race.c     |  3 +-
> >  .../selftests/bpf/progs/kfunc_call_test.c     | 15 +---
> >  .../bpf/progs/kfunc_call_test_subprog.c       | 17 +++-
> >  tools/testing/selftests/bpf/progs/map_kptr.c  |  1 +
> >  .../selftests/bpf/progs/map_kptr_fail.c       |  1 +
> >  10 files changed, 111 insertions(+), 31 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > new file mode 100644
> > index 000000000000..41d4f8543a25
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > @@ -0,0 +1,89 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _BPF_TESTMOD_KFUNC_H
> > +#define _BPF_TESTMOD_KFUNC_H
> > +
> > +#ifndef __ksym
> > +#define __ksym __attribute__((section(".ksyms")))
> > +#endif
> 
> ...
> 
> > +extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
> > +extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
> > +extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> > +extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
> > +
> > +extern void bpf_kfunc_call_test_destructive(void) __ksym;
> > +
> > +#endif /* _BPF_TESTMOD_KFUNC_H */
> 
> This is missing bpf_kfunc_call_test_kptr_get() prototype, the function is
> moved with the rest in the 5th patch.

ok, will add that one as well

> 
> > diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
> > index 7653df1bc787..b905833dc9d3 100644
> > --- a/tools/testing/selftests/bpf/progs/cb_refs.c
> > +++ b/tools/testing/selftests/bpf/progs/cb_refs.c
> > @@ -2,6 +2,7 @@
> >  #include <vmlinux.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include <bpf/bpf_helpers.h>
> > +#include "bpf_testmod/bpf_testmod_kfunc.h"
> >  
> >  struct map_value {
> >  	struct prog_test_ref_kfunc __kptr_ref *ptr;
> > diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
> > index eb8217803493..753305c22c2f 100644
> > --- a/tools/testing/selftests/bpf/progs/map_kptr.c
> > +++ b/tools/testing/selftests/bpf/progs/map_kptr.c
> > @@ -2,6 +2,7 @@
> >  #include <vmlinux.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include <bpf/bpf_helpers.h>
> > +#include "bpf_testmod/bpf_testmod_kfunc.h"
> >  
> >  struct map_value {
> >  	struct prog_test_ref_kfunc __kptr *unref_ptr;
> > diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> > index 760e41e1a632..3b5076d951df 100644
> > --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> > @@ -4,6 +4,7 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_core_read.h>
> >  #include "bpf_misc.h"
> > +#include "bpf_testmod/bpf_testmod_kfunc.h"
> >  
> >  struct map_value {
> >  	char buf[8];
> 
> These three are missing old prototype removal.

right, will remove, thanks

jirka
