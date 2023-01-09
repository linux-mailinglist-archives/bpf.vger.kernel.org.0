Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08865663058
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 20:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjAITaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 14:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjAITaH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 14:30:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03365AE8
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 11:30:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs20so9303314wrb.3
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 11:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=umpn61oKPhQIWtfGabqqzgHdYHu2WDs51U35aBX8Lfo=;
        b=H/pjvl98pNKYxrYNiyNBQhZqTFCcVg65dz8WgwQigVGPltD9a0u4cVp0FnoAh9SV+U
         VAK7+1Aq4Lno4TvwbVeZF4NYrPJwOz2mcr7uglBe5eBAwKs1Q5+6rw6cGQQbsABBEibk
         UhxBTMaanmmRS7z4HWxKsEQjKUvWOb77cw9z87aZjdjHBXmCGIgXSlYPWBFzX3DIg2np
         p/3Sr7P341WXzNpYxVfP7YiUp9nojLafT+S1xuZUHxJ3o5ltrdR3C2kWT7NhcGlkvAfK
         yw9o9OeIN3dLd9llUBm9O+q/1iky0lUHqN5R3bODqG2NVYUkmy6HZwHlHscuO8vfjuBf
         S1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umpn61oKPhQIWtfGabqqzgHdYHu2WDs51U35aBX8Lfo=;
        b=SQq2585CoXfSPDDoLvZZsLj/OJ49Nk5NR2Rfzy1VJMDfamenWX2KIZh4uURpd2H4zI
         7tkQWNRb+A5g3GxsiQx21uRURI5MWBm43OsW9F9iP1ZuV/stfDivhKlzxzDYxp7Z6cnl
         p9FQ7Tqhs/E3dH8ahqkS5tUfkb6E3HSLJMqpC2LdR+9B5yyqSaWR6eCH1hGiVHVpZgFU
         PMA6Ngz0OA6kPuBK4Kh88wkq3ys6vuVhDEh2f6ASR5hDhMFMV3eEzvMbpAqyA+8ORCIg
         Z/llwiLwp3R+M4tm6LCZOc8RmSR+2p9qbEpxVZMmhPPvsINmIW/1x/RF4xRWjiW9zLIK
         wXlQ==
X-Gm-Message-State: AFqh2kpq6eGcWtAFE/9EAldlGUeesYnxhla6e2OXPAWgmj1eJIiAgH1U
        NUEkUpcKRN5vULelR1vOq68d+hYFksIZxxJspzPudw==
X-Google-Smtp-Source: AMrXdXuYso3slBJ1PMuHUf3gFuJpF2juSV4x53983D7fAEr1eSH/IZCW3v93ieiblLx23iDJErX7BDAyFkwV8rhVqPc=
X-Received: by 2002:a5d:614d:0:b0:2bc:7ed4:cd50 with SMTP id
 y13-20020a5d614d000000b002bc7ed4cd50mr151039wrt.40.1673292603341; Mon, 09 Jan
 2023 11:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20230106151320.619514-1-irogers@google.com> <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org> <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org> <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org> <Y7xYimp0h4YT72/N@krava> <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
In-Reply-To: <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Jan 2023 11:29:51 -0800
Message-ID: <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
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

On Mon, Jan 9, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Jan 9, 2023 at 10:10 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jan 09, 2023 at 12:12:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Jan 06, 2023 at 11:06:46AM -0800, Ian Rogers escreveu:
> > > > So trying to get build-test working on my Debian derived distro is a
> > > > PITA with broken feature detection for options I don't normally use.
> > >
> > > Its really difficult to have perf building with so many dependent
> > > libraries, mowing out some should be in order.
> > >
> > > > I'll try to fix this.
> > >
> > > Thanks.
> > >
> > > > In any case I think I've spotted what is really happening here and it
> > > > isn't a failure but a feature :-D The build is specifying
> > >
> > > I get it.
> > >
> > > > LIBBPF_DYNAMIC=1 which means you get the libbpf headers from
> > > > /usr/include. I think the build is trying to do this on a system with
> > > > an old libbpf and hence getting the failures above. Previously, even
> > > > though we wanted the dynamic headers we still had a -I, this time for
> > > > the install_headers version. Now you really are using the system
> > > > version and it is broken. This means a few things:
> > > > - the libbpf feature test should fail if code like above is going to fail,
> > >
> > > Agreed.
> > >
> > > > - we may want to contemplate supporting older libbpfs (I'd rather not),
> > >
> > > I'd rather require everybody to be up to the latest trends, but I really
> > > don't think that is a reasonable expectation.
> > >
> > > > - does build-test have a way to skip known issues like this?
> > >
> > > Unsure, Jiri?
> >
> > I don't think so it just triggers the build, it's up to the features check
> > to disable the feature if the library is not compatible with perf code
> >
> > could we add that specific libbpf call to the libbpf feature check?
>
> Looking at the failure closer, the failing code is code inside a
> feature check trying to workaround the feature not being present. We
> need to do something like:
>
> ```
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 6e9b06cf06ee..a1c3cc230273 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -33,17 +33,18 @@
> #include <internal/xyarray.h>
>
> #ifndef HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
> -int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
> -                          struct bpf_insn *new_insns __maybe_unused,
> size_t new_insn_cnt __maybe_un
> used)
> +static int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
> +                                 struct bpf_insn *new_insns __maybe_unused,
> +                                 size_t new_insn_cnt __maybe_unused)
> {
>        pr_err("%s: not support, update libbpf\n", __func__);
>        return -ENOTSUP;
> }
>
> -int libbpf_register_prog_handler(const char *sec __maybe_unused,
> -                                 enum bpf_prog_type prog_type __maybe_unused,
> -                                 enum bpf_attach_type exp_attach_type
> __maybe_unused,
> -                                 const struct
> libbpf_prog_handler_opts *opts __maybe_unused)
> +static int libbpf_register_prog_handler(const char *sec __maybe_unused,
> +                                       enum bpf_prog_type prog_type
> __maybe_unused,
> +                                       enum bpf_attach_type
> exp_attach_type __maybe_unused,
> +                                       const void *opts __maybe_unused)
> {
>        pr_err("%s: not support, update libbpf\n", __func__);
>        return -ENOTSUP;
> ```
>
> There are some other fixes necessary too. I'll try to write the fuller
> patch but I have no means for testing except for undefining
> HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS.
>
> Thanks,
> Ian

So libbpf_prog_handler_opts is missing in the failing build, this
points to a libbpf before 0.8. I'm somewhat concerned that to work
around these linkage problems we're adding runtime errors - we may
build but the functionality is totally crippled. Is it worth
maintaining these broken builds or to just upfront fail the feature
test?

We can also switch the feature tests for LIBBPF_MAJOR_VERSION and
LIBBPF_MINOR_VERSION checks. This would have the property of letting
us tie the error messages to what version of libbpf is assumed.

In this case we could have a feature test for the libbpf version and
if the version is before libbpf 0.8 fail the feature check. A quick
way to do this is:
```
diff --git a/tools/build/feature/test-libbpf.c
b/tools/build/feature/test-libbpf.c
index a508756cf4cc..dadd8186b71d 100644
--- a/tools/build/feature/test-libbpf.c
+++ b/tools/build/feature/test-libbpf.c
@@ -1,6 +1,10 @@
// SPDX-License-Identifier: GPL-2.0
#include <bpf/libbpf.h>

+#if (LIBBPF_MAJOR_VERSION == 0) && (LIBBPF_MINOR_VERSION < 8)
+#error At least libbpf 0.8 is assumed for Linux tools.
+#endif
+
int main(void)
{
       return bpf_object__open("test") ? 0 : -1;
```

Thanks,
Ian

> > jirka
> >
> > >
> > > But yeah, previous experiences with Andrii were that we can do not too
> > > costly feature checks, not using .c programs that would fail if some
> > > required feature wasn't present but instead would just do some grep on a
> > > header and if some "smell" wasn't scent, just fail the cap query.
> > >
> > > - Arnaldo
