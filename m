Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DAC6602CD
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 16:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjAFPMw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 10:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjAFPMt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 10:12:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F9A81128
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 07:12:32 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9so1918804pll.9
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 07:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pOP2U/eNUNDM/BFzz41jwnvvD0q9z7KVLxoSLmeQ5Ik=;
        b=iH0cdWoF7hCqRCgId3gkeJ5nhxynIfZPsMSD7cym2axK6NGs4o3XgpHZjB5bWHlgqB
         AoNBsLh56wsCYg6PkC4kDVE/g+pjSg4Iw+mK0FMXtOl1gsPl4GvTVbS3VNycdNuFXEsn
         a4ag/t2nRyYJu1CAmTpOpFDGkipTZNQBIkkZLuxaR79XWunm9Cvw8rrVwYzSp6GR0DKj
         /LsAoDpBOGldlGPnbIe/ry6lRakkHOXvX2M1JpHsMsR0C35CWd7aLHINdBQl808CrHu9
         uHxo+LDfuXIDogYoc+SbNNW8svMk8I1YLfI7Nz/PUkjiK/6uUmOXfisllo7wFfH+uXe1
         QI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOP2U/eNUNDM/BFzz41jwnvvD0q9z7KVLxoSLmeQ5Ik=;
        b=eIYsupBehpNMiqFE0/D80dgIu17+VjZtRxAtsDMS8/yEzOlWPX5OWJCfNif3lvPtdY
         x+k4ko60OnbBf1WoCX5sIDxaP3Hw6jpibYBlc2jBeRyTtUUvppwBfZmQOWOLcSDmZ+yk
         vTG8TKGHcBhTKLk2SxY7dDr+ya3js5Vx2zJUvyxjJVTO9O5Ss1E+Lo7ya+8WiSALvJCH
         awLJ6Rkx8iJIcLfUwgVAi8+kdMikJ6xaCM9gk3jv4iLVTwU4pS+76v6M3bxev/nu6fuA
         oIHtqZtFA/QUaLqjP/7w9BXoOVFxT6GmL+hHBzUo9TXGiSdH8vOxG+PGS/i7gOBhUuOp
         55/g==
X-Gm-Message-State: AFqh2kpPwdRhScf3I3d6I2Ml19UpvQ0lYpgKFqHqgFtJPpvNX0mqLG8S
        z2qrPohQq6ACkZLLSbge5HD9GJJq2TKps4fwaUlIDw==
X-Google-Smtp-Source: AMrXdXtU5V0QpvGP+OLVqYFgiJWNnTOSLBLIFWEusuHsSsLFG6DazczNuQ1GVC5dZz7mwSfu21vgm+nI7RXXx5oI+Z4=
X-Received: by 2002:a17:90a:5d97:b0:226:c03e:23fc with SMTP id
 t23-20020a17090a5d9700b00226c03e23fcmr716787pji.6.1673017952133; Fri, 06 Jan
 2023 07:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20230106142537.607399-1-irogers@google.com> <20230106142537.607399-2-irogers@google.com>
In-Reply-To: <20230106142537.607399-2-irogers@google.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 6 Jan 2023 15:12:21 +0000
Message-ID: <CAJ9a7VjE4PzEe+Gu_KPi3JEw3TKQpC70yZrLRT+EmaEGDRLnEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf build: Fix build error when NO_LIBBPF=1
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 6 Jan 2023 at 14:25, Ian Rogers <irogers@google.com> wrote:
>
> The $(LIBBPF) target should only be a dependency of prepare if the
> static version of libbpf is needed. Add a new LIBBPF_STATIC variable
> that is set by Makefile.config. Use LIBBPF_STATIC to determine whether
> the CFLAGS, etc. need updating and for adding $(LIBBPF) as a prepare
> dependency.
>
> As Makefile.config isn't loaded for "clean" as a target, always set
> LIBBPF_OUTPUT regardless of whether it is needed for $(LIBBPF). This
> is done to minimize conditional logic for $(LIBBPF)-clean.
>
> This issue and an original fix was reported by Mike Leach in:
> https://lore.kernel.org/lkml/20230105172243.7238-1-mike.leach@linaro.org/
>
> Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
> Reported-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config |  2 ++
>  tools/perf/Makefile.perf   | 21 ++++++++++++---------
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index c2504c39bdcb..7c00ce0a7464 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -602,6 +602,8 @@ ifndef NO_LIBELF
>            dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
>          endif
>        else
> +        # Libbpf will be built as a static library from tools/lib/bpf.
> +       LIBBPF_STATIC := 1
>         CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
>          CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
>          CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 13e7d26e77f0..4e370462e7e1 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -303,10 +303,12 @@ ifneq ($(OUTPUT),)
>  else
>    LIBBPF_OUTPUT = $(CURDIR)/libbpf
>  endif
> -LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
> -LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
> -LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
> -CFLAGS += -I$(LIBBPF_OUTPUT)/include
> +ifdef LIBBPF_STATIC
> +  LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
> +  LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
> +  LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
> +  CFLAGS += -I$(LIBBPF_OUTPUT)/include
> +endif
>
>  ifneq ($(OUTPUT),)
>    LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> @@ -393,10 +395,8 @@ endif
>  export PERL_PATH
>
>  PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
> -ifndef NO_LIBBPF
> -  ifndef LIBBPF_DYNAMIC
> -    PERFLIBS += $(LIBBPF)
> -  endif
> +ifdef LIBBPF_STATIC
> +  PERFLIBS += $(LIBBPF)
>  endif
>
>  # We choose to avoid "if .. else if .. else .. endif endif"
> @@ -756,12 +756,15 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
>         $(arch_errno_name_array) \
>         $(sync_file_range_arrays) \
>         $(LIBAPI) \
> -       $(LIBBPF) \
>         $(LIBPERF) \
>         $(LIBSUBCMD) \
>         $(LIBSYMBOL) \
>         bpf-skel
>
> +ifdef LIBBPF_STATIC
> +prepare: $(LIBBPF)
> +endif
> +
>  $(OUTPUT)%.o: %.c prepare FORCE
>         $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
>
> --
> 2.39.0.314.g84b9a713c41-goog
>

Tested-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
