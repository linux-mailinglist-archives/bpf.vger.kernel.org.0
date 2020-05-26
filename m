Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8681E3273
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 00:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbgEZW0z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 18:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389821AbgEZW0y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 18:26:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9022FC061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:26:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b27so12480778qka.4
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoxANCY5U843woCPs8CTSwvWQTNqALufM6dJtd4Q+Ag=;
        b=oZq1NkTOK2YsLm/bmJquf5/A9BMLEhr4dLa4T1lc/u3anTuwrdk0TmXYush1vhBywv
         DvkJXX9K7ufENA3vqG/JuWlaGznmko1iDt27ImCB+k+msKBhJquKsF5R0wAsxriZ4v8s
         9XTRFunlXiJ6HBlFhdk60hheahFLSXbM49cWDvjOuSNxeCFpkWyTu4KcASVO2HiuA1ob
         ca48tScmFOFOb5g35gHDqYggToDrKmMC+MdPAZiPEnE+kyO/dPXtQ9AVJRgwW2qDVDul
         2Nix4Ovata5HdHmFOQM0TE4iQILlJFHde4Qss889AhqxUXRJdZMBRgo9XZedLEZIM/Pr
         tvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoxANCY5U843woCPs8CTSwvWQTNqALufM6dJtd4Q+Ag=;
        b=dL/HD9rWFWfv55n+Iu6QG/pDIDrz1ploe36LAC0qGaIJL4nYUbMY7JhGqHGtmWid7Z
         AYnr6jkVMCpEduwVTAmPn4RgYiH02fWIO6OOoOPlSjZsbSFS9twOBm4m6irTq+6RzPfO
         F/AQYFPzL8zbH7Cpu3CvSwqy/LJU6+EXcXOWBB8OPECuq7itgtesZyD6C9t0SPlvy+EY
         LGTbj8ObZ9PErEuBKemTwvudZknCOm1LF4pAvMY+UCeAXr5k4B4rF7op0lRIfq7fbMhm
         DdgDU84qzEtgde+SIE0qYjIyo0bTIJX8oUKZaRXea56FZqqTXcMjAHSxrWUIpsjdgzkM
         sV8g==
X-Gm-Message-State: AOAM530aRcKzHqY09HKODcjctQ/TjWyyo4lGK64tsXL32lMVp4+49oM3
        Fm2FGBUTvhTcXliiYeEhMKNdNiFkWp9vRr31mZ4HGR8hbOs=
X-Google-Smtp-Source: ABdhPJy0BCoifi+UIpv7NzIEkU8IPuKZIFYReCmr91NzB7vAHTAJHHRuyxq5Eu4WSAtuUQtnMakjZtixrnKX+sGfoMU=
X-Received: by 2002:a05:620a:12d2:: with SMTP id e18mr1163275qkl.437.1590532013726;
 Tue, 26 May 2020 15:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com> <20200522041310.233185-8-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-8-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 15:26:43 -0700
Message-ID: <CAEf4BzaJtf-B66Srjk+2H-Ey8KYUutYFaOQX86ETAEizaXV1zA@mail.gmail.com>
Subject: Re: [PATCH 7/8] selftests/bpf: fix test.h placing for out of tree build
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Flavors of test.h are generated in tree even for out of tree
> build. Use OUTPUT directory for that.
>
> It requires rules to make sure the directories exist.
>
> Split EXTRA_CLEAN generation since existance of test.h files depends
> of dynamic makefile generation.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 38 +++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 31598ca2d396..bade24e29a1a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -83,6 +83,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>         test_lirc_mode2_user xdping test_cpp runqslower bench
>
>  TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
> +EXTRA_CLEAN += $(TEST_CUSTOM_PROGS)

why += instead of := here?

>
>  # Emit succinct information message describing current building step
>  # $1 - generic step name (e.g., CC, LINK, etc);
> @@ -267,7 +268,7 @@ TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,   \
>  TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,          \
>                                  $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
>  TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
> -TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
> +TRUNNER_TESTS_HDR := $(OUTPUT)/$(TRUNNER_TESTS_DIR)/tests.h
>  TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
>  TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS))
>  TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,      \
> @@ -295,6 +296,11 @@ $(TRUNNER_OUTPUT)-dir := y
>  $(TRUNNER_OUTPUT):
>         $$(call msg,MKDIR,,$$@)
>         mkdir -p $$@
> +
> +ifneq ($2,)
> +EXTRA_CLEAN +=$(TRUNNER_OUTPUT)
> +endif
> +
>  endif
>
>  # ensure we set up BPF objects generation rule just once for a given
> @@ -320,13 +326,19 @@ endif
>  # ensure we set up tests.h header generation rule just once
>  ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
>  $(TRUNNER_TESTS_DIR)-tests-hdr := y
> -$(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
> +$(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c | $(dir $(TRUNNER_TESTS_HDR))
>         $$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
>         $$(shell ( cd $(TRUNNER_TESTS_DIR);                             \
>                   echo '/* Generated header, do not edit */';           \
>                   ls *.c 2> /dev/null |                                 \
>                         sed -e 's@\([^\.]*\)\.c@DEFINE_TEST(\1)@';      \
>                  ) > $$@)
> +
> +EXTRA_CLEAN += $(TRUNNER_TESTS_HDR)
> +
> +$(dir $(TRUNNER_TESTS_HDR)):
> +       $$(call msg,MKDIR,,$$@)
> +       mkdir -p $$@
>  endif
>
>  # compile individual test files
> @@ -402,14 +414,23 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>  # It is much simpler than test_maps/test_progs and sufficiently different from
>  # them (e.g., test.h is using completely pattern), that it's worth just
>  # explicitly defining all the rules explicitly.
> -verifier/tests.h: verifier/*.c
> +$(OUTPUT)/verifier/tests.h: verifier/*.c | $(OUTPUT)/verifier
>         $(shell ( cd verifier/; \
>                   echo '/* Generated header, do not edit */'; \
>                   echo '#ifdef FILL_ARRAY'; \
>                   ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
>                   echo '#endif' \
> -               ) > verifier/tests.h)
> -$(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
> +               ) > $@)
> +
> +EXTRA_CLEAN += $(OUTPUT)/verifier/tests.h
> +
> +$(OUTPUT)/verifier:
> +       $(call msg,MKDIR,,$@)
> +       mkdir -p $@

See below, given this directory is well-known and sort of static, can
you just add them to the list of pre-created directories at line 176?

> +
> +$(OUTPUT)/test_verifier: CFLAGS += -I$(abspath verifier)
> +$(OUTPUT)/test_verifier: test_verifier.c $(OUTPUT)/verifier/tests.h $(BPFOBJ) \
> +                       | $(OUTPUT)
>         $(call msg,BINARY,,$@)
>         $(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> @@ -433,7 +454,6 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
>         $(call msg,BINARY,,$@)
>         $(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
>
> -EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR)                     \
> -       prog_tests/tests.h map_tests/tests.h verifier/tests.h           \

Why not just append $(OUTPUT) to these three and keep TRUNNER rules
just a bit simpler, they don't need any extra complexity.

> -       feature                                                         \
> -       $(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc)

same for no_alu32 and bpf_gcc, just append $(OUTPUT)/ to them?

> +EXTRA_CLEAN += $(SCRATCH_DIR)                  \
> +       feature                                 \
> +       $(addprefix $(OUTPUT)/,*.o *.skel.h)
> --
> 2.26.2
>
