Return-Path: <bpf+bounces-4399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4227974A9F7
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730F11C20F46
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBAC1FAB;
	Fri,  7 Jul 2023 04:35:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59DEA0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:35:16 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0CF19BD
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:35:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbfcc6dae4so4903075e9.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688704513; x=1691296513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnRGX2uydckPD7cWET5sOosQgY0NC4dhCPwN5CpvWVo=;
        b=UUL61yCZq9K5L2rsQAOs+IVEiXVabHHSYDNhFyTJpNjdmlMu0UPtM92saggyg2m9DU
         vEJo6yVrEw+maNDeiU2DhJ+tyRHeV0ayD0BNudqi54ezlr33pGdU7ThRZBjPLN3+p3Hd
         dd0FLectUVILJAlGsHncki3qWnAhtlPJcxDsAlVqAtRtQdVSPrG47oZFKEg3QtKR4lLr
         wffj8u+V0f1DADQPLG3m9KiRoVU0vQengXv7bDMRyIvA1ensHVDO2onOwwXrLbOlDlqU
         GvqSyRtO3N2Y8epXqwELVKyWakgATrnzCuj/2CrZkQv03KPjzxsx80bWJBUkrXsxCzSY
         0BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704513; x=1691296513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnRGX2uydckPD7cWET5sOosQgY0NC4dhCPwN5CpvWVo=;
        b=JTRYxkBTfSztQkoWJb+9LnVyIU8fUTSgNNiwAISlNERH6nMjJPatEonJltmOA0m/U+
         sqni3Z4p8UbTOkHyAZpd313+8CMPdkEaBxOpKJq8KFrYg2CBtw13AVKh33OsIuVlHYRB
         pjV3ElVrC8ybNsTyefkhrtTXQFJgOEBLcYTBrouTAc+MMWQYZO20Cw9rwNQFLp4OeqMA
         sZW4FwbROZxO/Gd6C9YgS4N2rc5l7dYgEuWDcMWj4jqUaIPS8VzTWyRkVXg1WRuLJ05X
         eqfK+JMSSSUsY0+k2ez6+GL8wZjKpHP/n+lYTDR4phVrfXufE8aIsAa+3+WsP3FWYVaY
         gzbQ==
X-Gm-Message-State: ABy/qLZ9+aZXgUjbb9Oql70ndT9LU+tomadZet/Fsb3Rd0axT4moRizA
	UY1gkQYDiJRSxKco43UEtuSGQYc22dE2lSVs4h4=
X-Google-Smtp-Source: APBJJlEdHqQu8eDLLkkwuddP3UhZv9djcf1o4y0X46ZoM+JbEMUfqgShlOzw7BU/oHF1NWMdfjty2FWhL6vsBT20pk0=
X-Received: by 2002:a7b:c3cf:0:b0:3fa:e92e:7a7b with SMTP id
 t15-20020a7bc3cf000000b003fae92e7a7bmr3076490wmj.15.1688704513361; Thu, 06
 Jul 2023 21:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-21-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-21-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:35:01 -0700
Message-ID: <CAEf4BzZktv97EtRnRGOhPoaJaSwdQjeNAT_BAciKmShWGX5YGg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 20/26] selftests/bpf: Add uprobe_multi test program
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 1:37=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe_multi test program that defines 50k uprobe_multi_func_*
> functions and will serve as attach point for uprobe_multi bench test
> in following patch.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile       |  5 ++
>  tools/testing/selftests/bpf/uprobe_multi.c | 53 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index ad6b585e0d7c..acf7c9a29082 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -567,6 +567,7 @@ TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read $(OUT=
PUT)/bpf_testmod.ko      \
>                        $(OUTPUT)/liburandom_read.so                     \
>                        $(OUTPUT)/xdp_synproxy                           \
>                        $(OUTPUT)/sign-file                              \
> +                      $(OUTPUT)/uprobe_multi                           \

would adding all this to urandom_read be too bad in terms of size and
performance? I'm just not sure we won't yet more custom binaries and
rules in Makefile

>                        ima_setup.sh                                     \
>                        verify_sig_setup.sh                              \
>                        $(wildcard progs/btf_dump_test_case_*.c)         \
> @@ -670,6 +671,10 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@
>
> +$(OUTPUT)/uprobe_multi: uprobe_multi.c
> +       $(call msg,BINARY,,$@)
> +       $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> +
>  EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)=
 \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
>         feature bpftool                                                 \
> diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/s=
elftests/bpf/uprobe_multi.c
> new file mode 100644
> index 000000000000..115a7f6cebfa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/uprobe_multi.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +
> +#define __PASTE(a, b) a##b
> +#define PASTE(a, b) __PASTE(a, b)
> +
> +#define NAME(name, idx) PASTE(name, idx)
> +
> +#define DEF(name, idx)  int NAME(name, idx)(void) { return 0; }
> +#define CALL(name, idx) NAME(name, idx)();
> +
> +#define F(body, name, idx) body(name, idx)
> +
> +#define F10(body, name, idx) \
> +       F(body, PASTE(name, idx), 0) F(body, PASTE(name, idx), 1) F(body,=
 PASTE(name, idx), 2) \
> +       F(body, PASTE(name, idx), 3) F(body, PASTE(name, idx), 4) F(body,=
 PASTE(name, idx), 5) \
> +       F(body, PASTE(name, idx), 6) F(body, PASTE(name, idx), 7) F(body,=
 PASTE(name, idx), 8) \
> +       F(body, PASTE(name, idx), 9)
> +
> +#define F100(body, name, idx) \
> +       F10(body, PASTE(name, idx), 0) F10(body, PASTE(name, idx), 1) F10=
(body, PASTE(name, idx), 2) \
> +       F10(body, PASTE(name, idx), 3) F10(body, PASTE(name, idx), 4) F10=
(body, PASTE(name, idx), 5) \
> +       F10(body, PASTE(name, idx), 6) F10(body, PASTE(name, idx), 7) F10=
(body, PASTE(name, idx), 8) \
> +       F10(body, PASTE(name, idx), 9)
> +
> +#define F1000(body, name, idx) \
> +       F100(body, PASTE(name, idx), 0) F100(body, PASTE(name, idx), 1) F=
100(body, PASTE(name, idx), 2) \
> +       F100(body, PASTE(name, idx), 3) F100(body, PASTE(name, idx), 4) F=
100(body, PASTE(name, idx), 5) \
> +       F100(body, PASTE(name, idx), 6) F100(body, PASTE(name, idx), 7) F=
100(body, PASTE(name, idx), 8) \
> +       F100(body, PASTE(name, idx), 9)
> +
> +#define F10000(body, name, idx) \
> +       F1000(body, PASTE(name, idx), 0) F1000(body, PASTE(name, idx), 1)=
 F1000(body, PASTE(name, idx), 2) \
> +       F1000(body, PASTE(name, idx), 3) F1000(body, PASTE(name, idx), 4)=
 F1000(body, PASTE(name, idx), 5) \
> +       F1000(body, PASTE(name, idx), 6) F1000(body, PASTE(name, idx), 7)=
 F1000(body, PASTE(name, idx), 8) \
> +       F1000(body, PASTE(name, idx), 9)
> +
> +F10000(DEF, uprobe_multi_func_, 0)
> +F10000(DEF, uprobe_multi_func_, 1)
> +F10000(DEF, uprobe_multi_func_, 2)
> +F10000(DEF, uprobe_multi_func_, 3)
> +F10000(DEF, uprobe_multi_func_, 4)
> +
> +int main(void)
> +{
> +       F10000(CALL, uprobe_multi_func_, 0)
> +       F10000(CALL, uprobe_multi_func_, 1)
> +       F10000(CALL, uprobe_multi_func_, 2)
> +       F10000(CALL, uprobe_multi_func_, 3)
> +       F10000(CALL, uprobe_multi_func_, 4)
> +       return 0;
> +}
> --
> 2.41.0
>

