Return-Path: <bpf+bounces-4942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB7E7518B4
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7632E281BE1
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49185686;
	Thu, 13 Jul 2023 06:18:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB15679
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:18:29 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C941FFD
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:18:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4036bd4fff1so139781cf.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689229104; x=1691821104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UTNm86plFh/k2eGtcW75hQfR4xWGehFoa1IxPLLJrc=;
        b=VQ0o8Ivxg50xA5rOqT4uT6vesCBtnsp+40lvEQJVltui9zNkSqevWpQvDVy21+3+7p
         7C+dTyvLQu0X+Go/GjpnOMk2sOu8xVWvm+JEGtflRimp4IdRfFPC4Yvm/ODY6jje+tqc
         XzdSkeez0q950LidJFJn/OIHRfjdxjXtxAvUazBUDoEH1zQhHNzRIxzNr03E2UjnavXF
         fSKmkPP4kUqTiiP1ePIYbOL9W/lIJMc11Fkg5FA8fge53D6YILwUjBF04OWdOt1/KNkN
         XnaTRiF27OL4XGXBmpkiB+333ztHAYHCcXN/EhYevYwJoRrkugILmGTcF+tXA6CmLAZu
         84Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689229104; x=1691821104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UTNm86plFh/k2eGtcW75hQfR4xWGehFoa1IxPLLJrc=;
        b=Un+dyTeJQV5IXgfVDPBhUdTbTBUWFmn4N55Aeg3/wEcZxLe7epKQgp0EvKT9h5Vevh
         E8/GWRJrWxuoJ0wa624mAhOcqTHmqMkKN/2mL+Pjq/iCeVjgs2WnxAA3yQCtEykgwcnv
         C/X0/gNgBNPVX1Bj2Mf/E8KTARzdkam9EUeNTpdsxqvixN4LTiJbfynmGINcqU/J/TTD
         n5EE002X6PIctKJyhm37emx8wbev44nTRcxnBa08Q9nXA8v52GOoRA2ys1ls8EFRQff2
         LE1iD+b4VKa6pvO2372XUG2+IFlHGQto9DqBT9rUJrZTf1dQm1GH3M552SUqoV665Qdm
         W10g==
X-Gm-Message-State: ABy/qLa/koEmZX8jQ1APVBgjyO2dIPLiewMQ5eacVDQ0meJv4ExtyFY6
	vYYVT1upkOaRGXLlNyrRTIANCOdHctLjUDZZHcjNPXpGKPUo8FSnKaI=
X-Google-Smtp-Source: APBJJlHJvF7NM7IX/qz65lNOMGQpeKenoUsJVoOJPBH5XK2KGfp//cjcLspERE5wDqNewYL+S2GXsMkNTtWegTibv0Q=
X-Received: by 2002:ac8:5905:0:b0:3ef:302c:319e with SMTP id
 5-20020ac85905000000b003ef302c319emr445046qty.8.1689229103971; Wed, 12 Jul
 2023 23:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713060718.388258-1-yhs@fb.com> <20230713060800.392500-1-yhs@fb.com>
In-Reply-To: <20230713060800.392500-1-yhs@fb.com>
From: Fangrui Song <maskray@google.com>
Date: Wed, 12 Jul 2023 23:18:12 -0700
Message-ID: <CAFP8O3L04X_c2wD0pg7Av24K107SFeCUm+-xtCs30EbQag5xOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/15] selftests/bpf: Add a cpuv4 test runner
 for cpu=v4 testing
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 11:11=E2=80=AFPM Yonghong Song <yhs@fb.com> wrote:
>
> Similar to no-alu32 runner, a cpuv4 runner is created to test
> bpf programs compiled with -mcpu=3Dv4.
>
> The following are some num-of-insn statistics for each newer
> instructions, excluding naked asm (verifier_*) tests:
>    insn pattern                # of instructions
>    reg =3D (s8)reg               4
>    reg =3D (s16)reg              2
>    reg =3D (s32)reg              26
>    reg =3D *(s8 *)(reg + off)    11
>    reg =3D *(s16 *)(reg + off)   14
>    reg =3D *(s32 *)(reg + off)   15214
>    reg =3D bswap16 reg           133
>    reg =3D bswap32 reg           38
>    reg =3D bswap64 reg           14
>    reg s/=3D reg                 0
>    reg s%=3D reg                 0
>    gotol <offset>              58
>
> Note that in llvm -mcpu=3Dv4 implementation, the compiler is a little
> bit conservative about generating 'gotol' insn (32-bit branch offset)
> as it didn't precise count the number of insns (e.g., some insns are
> debug insns, etc.). Compared to old 'goto' insn, newer 'gotol' insn
> should have comparable verification states to 'goto' insn.
>
> I did not collect verifier stats now since I have not really
> started to do proper range bound estimation with these
> instructions.
>
> With current patch set, all selftests passed with -mcpu=3Dv4
> when running test_progs-cpuv4 binary.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/.gitignore |  2 ++
>  tools/testing/selftests/bpf/Makefile   | 18 ++++++++++++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index 116fecf80ca1..110518ba4804 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -13,6 +13,7 @@ test_dev_cgroup
>  /test_progs
>  /test_progs-no_alu32
>  /test_progs-bpf_gcc
> +/test_progs-cpuv4
>  test_verifier_log
>  feature
>  test_sock
> @@ -36,6 +37,7 @@ test_cpp
>  *.lskel.h
>  /no_alu32
>  /bpf_gcc
> +/cpuv4
>  /host-tools
>  /tools
>  /runqslower
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 882be03b179f..4b2cf5d40120 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -44,7 +44,7 @@ TEST_GEN_PROGS =3D test_verifier test_tag test_maps tes=
t_lru_map test_lpm_map test
>         test_sock test_sockmap get_cgroup_id_user \
>         test_cgroup_storage \
>         test_tcpnotify_user test_sysctl \
> -       test_progs-no_alu32
> +       test_progs-no_alu32 test_progs-cpuv4
>
>  # Also test bpf-gcc, if present
>  ifneq ($(BPF_GCC),)
> @@ -383,6 +383,11 @@ define CLANG_NOALU32_BPF_BUILD_RULE
>         $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
>         $(Q)$(CLANG) $3 -O2 --target=3Dbpf -c $1 -mcpu=3Dv2 -o $2
>  endef
> +# Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
> +define CLANG_CPUV4_BPF_BUILD_RULE
> +       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> +       $(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=3Dv4 -o $2
> +endef

Use --target=3D (Clang 3.4 preferred form) for new code :)

>  # Build BPF object using GCC
>  define GCC_BPF_BUILD_RULE
>         $(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
> @@ -425,7 +430,7 @@ LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(foreach=
 skel,$(LINKED_SKELS),$($(ske
>  # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
>  # Parameters:
>  # $1 - test runner base binary name (e.g., test_progs)
> -# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
> +# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
>  define DEFINE_TEST_RUNNER
>
>  TRUNNER_OUTPUT :=3D $(OUTPUT)$(if $2,/)$2
> @@ -453,7 +458,7 @@ endef
>  # Using TRUNNER_XXX variables, provided by callers of DEFINE_TEST_RUNNER=
 and
>  # set up by DEFINE_TEST_RUNNER itself, create test runner build rules wi=
th:
>  # $1 - test runner base binary name (e.g., test_progs)
> -# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
> +# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
>  define DEFINE_TEST_RUNNER_RULES
>
>  ifeq ($($(TRUNNER_OUTPUT)-dir),)
> @@ -584,6 +589,11 @@ TRUNNER_BPF_BUILD_RULE :=3D CLANG_NOALU32_BPF_BUILD_=
RULE
>  TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
>  $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
>
> +# Define test_progs-cpuv4 test runner.
> +TRUNNER_BPF_BUILD_RULE :=3D CLANG_CPUV4_BPF_BUILD_RULE
> +TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
> +$(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
> +
>  # Define test_progs BPF-GCC-flavored test runner.
>  ifneq ($(BPF_GCC),)
>  TRUNNER_BPF_BUILD_RULE :=3D GCC_BPF_BUILD_RULE
> @@ -681,7 +691,7 @@ EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) =
$(HOST_SCRATCH_DIR)      \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
>         feature bpftool                                                 \
>         $(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h       \
> -                              no_alu32 bpf_gcc bpf_testmod.ko          \
> +                              no_alu32 cpuv4 bpf_gcc bpf_testmod.ko    \
>                                liburandom_read.so)
>
>  .PHONY: docs docs-clean
> --
> 2.34.1
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

