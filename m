Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A393865F410
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 20:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjAETDE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 14:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjAETDD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 14:03:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C3C5F4A4
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 11:03:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so2062815wms.4
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 11:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M3ywnK0Rwj44NUmEowj3uFpeqoi3dfNf/zj6axWlexI=;
        b=GOodjTv4XXA0h7zfwxBAR+mgxcePBgkoSL1rN2OXga9+OyCkGuDbWRKhWN7EsNCAsl
         nfjC8x5GiRxiOIcMrZRloa65u4rPYuSOTvs9Fpe2j3ZNMxQMJh/91HUUUUWEHHNkVOR7
         clbW1fiA+YU3pRwo1bL8Zy0dLVFKNJQlX5nxtDjDjbkjq83y8xi/zkK7x5DvZ2IILMgJ
         /XMmyuVpVjqp3lkW1nneMesHgFkTXv/AH2t8Ndup3fJQBgZXOLtJZ96rDKeDpm5Psa78
         9zvKmJK52kmhNmtr9UdwuUBozaZ0yMK+B0V0QpYAksmGhN6iEwlQpHbtur0vbXYej3oF
         4gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3ywnK0Rwj44NUmEowj3uFpeqoi3dfNf/zj6axWlexI=;
        b=M6m436lh4jK4lXt9+ip38PwwfvYbDN/OxwuRSv8t8pfS8/QzJOznkvpChQYuWrJwCQ
         NR0ysdVVnQMrzVw4u/lnFLMKCXwHxWm9KxSMTffcaQgGSnwZmiaxsEGw/u0NqiLWfORt
         tLxAmcafDQojZ1ulEaNFUYtUmj30DCiKSxh2sqRXJZE6esxc1pa9BXewKs2FYZFKpd7G
         hvcD6GsDgsYsDM2z9qP7FAufORJWE47F7VIQD86g5t0aoPI6TzwehnYASYWpOSjfINGC
         kfe0/rZlZSI71l2YhmdC2C9hEaFRqAI4pVDsAbbXPnNQAbkmC1pOawdmLRk8P58qIBNB
         73Aw==
X-Gm-Message-State: AFqh2kqIaLyer/uDui8PJBt5tI0ewvFMJcphejFittKJCLlbfBj3keo8
        WGTsTaBxBwBAQV32yBk5ypGwvuedemQlKT37tjbfew==
X-Google-Smtp-Source: AMrXdXszKVXQGCVA2N+u2+voiQh0jNEYJQJkgtP9T1vAZL4rMFn2cDbZZJqf84H6E8ijktUGriW7B1JNprdb0jEROtQ=
X-Received: by 2002:a05:600c:3b04:b0:3d0:50c4:432c with SMTP id
 m4-20020a05600c3b0400b003d050c4432cmr2552732wms.67.1672945380644; Thu, 05 Jan
 2023 11:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20230105172243.7238-1-mike.leach@linaro.org>
In-Reply-To: <20230105172243.7238-1-mike.leach@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Jan 2023 11:02:48 -0800
Message-ID: <CAP-5=fVbPVE4rxJ2s8phhJ5RRH4EnKaWrF2kaT0oCmK6kvhP2g@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix build error when NO_LIBBPF=1
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 5, 2023 at 9:22 AM Mike Leach <mike.leach@linaro.org> wrote:
>
> Recent updates to perf build result in the following output when cross
> compiling to aarch64, with libelf unavailable, and therefore
> NO_LIBBPF=1 set.
>
> ```
>   $make -C tools/perf
>
>   <cut>
>
>   Makefile.config:428: No libelf found. Disables 'probe' tool, jvmti
>   and BPF support in 'perf record'. Please install libelf-dev,
>   libelf-devel or elfutils-libelf-devel
>
>   <cut>
>
>   libbpf.c:46:10: fatal error: libelf.h: No such file or directory
>       46 | #include <libelf.h>
>          |          ^~~~~~~~~~
>   compilation terminated.
>
>   ./tools/build/Makefile.build:96: recipe for target
>   '.tools/perf/libbpf/staticobjs/libbpf.o' failed
>
> ```
>
> plus one other include error for <gelf.h>

Ouch, apologies for the breakage. You wouldn't happen to have
something like a way with say a docker image to repro the problem? The
make line above is somewhat minimal.

> The issue is that the commit noted below adds libbpf to the prepare:
> target but no longer accounts for the NO_LIBBPF define. Additionally
> changing the include directories means that even if the libbpf target
> build is prevented, bpf headers are missing in other parts of the build.
>
> This patch ensures that in the case of NO_LIBBPF=1, the build target is
> changed to a header only target, and the headers are installed, without
> attempting to build the libbpf.a target.
>
> Applies to perf/core
>
> Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  tools/perf/Makefile.perf | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 13e7d26e77f0..ee08ecf469f6 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -305,7 +305,11 @@ else
>  endif
>  LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
>  LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
> +ifndef NO_LIBBPF
>  LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
> +else
> +LIBBPF = $(LIBBPF_INCLUDE)/bpf/bpf.h

This seems strange, don't we want to avoid libbpf targets?

> +endif
>  CFLAGS += -I$(LIBBPF_OUTPUT)/include
>
>  ifneq ($(OUTPUT),)
> @@ -826,10 +830,16 @@ $(LIBAPI)-clean:
>         $(call QUIET_CLEAN, libapi)
>         $(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
>
> +ifndef NO_LIBBPF
>  $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
>         $(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
>                 O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
>                 $@ install_headers
> +else
> +$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
> +       $(Q)$(MAKE) -C $(LIBBPF_DIR) OUTPUT=$(LIBBPF_OUTPUT)/ \
> +               DESTDIR=$(LIBBPF_DESTDIR) prefix= install_headers
> +endif

Shouldn't we just be able to conditionalize having $(LIBBPF) as a
dependency for the perf binary? If there is no dependency then the
targets won't be built and we shouldn't need to conditionalize here.

Thanks!
Ian

>  $(LIBBPF)-clean:
>         $(call QUIET_CLEAN, libbpf)
> --
> 2.17.1
>
