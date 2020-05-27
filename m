Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2D1E3401
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 02:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgE0ATc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 20:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgE0ATb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 20:19:31 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C59C061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 17:19:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ee19so10388354qvb.11
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 17:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgIkdTJ2fV3jCpNCnpmWRYJAdI69E2EbKa0x+7NQeFI=;
        b=FtvrbalSHSjACl6/FwTE1ixvwxvbFOSYYKHXJqbRdXqHfGApFy/SaMHqGzLy7E5fjK
         N0t8a/K70oap+mXL5PLoJ59djZmENT67s6Ur1NqkLQKU6Re/wISB2MHzfApS3KOje3dr
         xFUxcgSRdNZMwM5zYbNVD5i6uHNQccDgFtMOyiAvj3VQsCAXm00yuorDpX5BnzV/HFEb
         P0eM0Vfbvd8fgkSPbaNGMS3nczVAx7iclSi2880k+qSGlVS+xt8x0TnMCOzTiAZdns4F
         N2QGYF5uLYOZcMAo31TQRAx66rNL3mfdK8gH1j2lTewPM/94D14DJMoC89+GKxnQSh9x
         4pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgIkdTJ2fV3jCpNCnpmWRYJAdI69E2EbKa0x+7NQeFI=;
        b=V9fy/SID2J9gKO2134lyQDU/zmbgl4tm9skn289+NtfwtF/L3M/W0+Mw59vFp5C2rT
         7XwyspSp2fgpnvGDIW8CaGyc+WTkJeXVATP4GzxazV7aw65uAZ7Daaj3fiYVjmpnxRnz
         ooJt1hCUF/lT5+IkNfq3PaS21YQVFe05arETf7dp1s17cO+6/bc3ZJ4o8TehBlJmDhUA
         4XzVWbXRlBMzavjKZEHxTKYLEkC0gPa+/iVkxNRLh1Hg/QSS5ByRbOml9TJF7+PZLCck
         DfmcBewxjHaQ13P5mTbThonAWRe/oc6+OjMk3Tn35xEPQRGMegT8Map57LKMA8hzcaPR
         O8hQ==
X-Gm-Message-State: AOAM5314SL2j/giP5VxZMV8Oeu4G00StN0eAwzazvHHZ2VE9yRw8MTgo
        4qeuHN7iXySUSuKym/xKcRb2Tzobf8mY/Yo+NZI=
X-Google-Smtp-Source: ABdhPJzDyyoifhtoUslYvEq6zHkPgVvN/eo+hw9yyJvc/t6KZ7Tqa2xx51Bu3HAC+1JNfhvwfzrGW17gsPKbF2Pmfp8=
X-Received: by 2002:a0c:b92f:: with SMTP id u47mr9171084qvf.247.1590538769398;
 Tue, 26 May 2020 17:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <xuny367so4k3.fsf@redhat.com> <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 17:19:18 -0700
Message-ID: <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 22, 2020 at 1:19 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> There is difference in depoying static and generated extra resource
> files between in/out of tree build and flavors:
>
> - in case of unflavored out-of-tree build static files are not
> available and must be copied as well as both static and generated
> files for flavored build.
>
> So split the rules and variables. The name TRUNNER_EXTRA_GEN_FILES
> is chosen in analogy to TEST_GEN_* variants.
>

Can we keep them together but be smarter about what needs to be copied
based on source/target directories? I would really like to not blow up
all these rules.

> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 26497d8869ea..c80c06272759 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -363,12 +363,28 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:                             \
>         $$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
>         $$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
>
> -# only copy extra resources if in flavored build
> -$(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
> -ifneq ($2,)
> +# copy extra resources when needed.
> +# Static files for both out of tree and flavored (so, not current dir).
> +# Generated files for flavored only.
> +$(TRUNNER_BINARY)-extras: $(TRUNNER_BINARY)-extras-static \
> +                         $(TRUNNER_BINARY)-extras-gen
> +
> +$(TRUNNER_BINARY)-extras-static: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
> +ifneq ($(CURDIR)),$(realpath $(TRUNNER_OUTPUT)))
>         $$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
> +ifneq ($(TRUNNER_EXTRA_FILES),)
>         cp -a $$^ $(TRUNNER_OUTPUT)/
>  endif
> +endif
> +
> +$(TRUNNER_BINARY)-extras-gen: $(addprefix $(OUTPUT)/,$(TRUNNER_EXTRA_GEN_FILES)) \
> +                           | $(TRUNNER_OUTPUT)
> +ifneq ($2,)
> +       $$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_GEN_FILES))
> +ifneq ($(TRUNNER_EXTRA_GEN_FILES),)
> +       cp -a $$^ $(TRUNNER_OUTPUT)/
> +endif
> +endif
>
>  $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                      \
>                              $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)           \
> @@ -384,7 +400,8 @@ TRUNNER_BPF_PROGS_DIR := progs
>  TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c \
>                          network_helpers.c testing_helpers.c            \
>                          flow_dissector_load.h
> -TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(BTF_C_FILES)
> +TRUNNER_EXTRA_FILES := $(BTF_C_FILES)
> +TRUNNER_EXTRA_GEN_FILES := urandom_read
>  TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>  TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>  TRUNNER_BPF_LDFLAGS := -mattr=+alu32
> @@ -408,6 +425,7 @@ TRUNNER_TESTS_DIR := map_tests
>  TRUNNER_BPF_PROGS_DIR := progs
>  TRUNNER_EXTRA_SOURCES := test_maps.c
>  TRUNNER_EXTRA_FILES :=
> +TRUNNER_EXTRA_GEN_FILES :=
>  TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
>  TRUNNER_BPF_CFLAGS :=
>  TRUNNER_BPF_LDFLAGS :=
> --
> 2.26.2
>
