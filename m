Return-Path: <bpf+bounces-4402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50CD74A9FD
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62231C20F40
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC131FAB;
	Fri,  7 Jul 2023 04:39:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6709EA0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:39:34 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C31FC4
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:39:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso2243645e87.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688704767; x=1691296767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y79vNUtnDfZ2PZ6Si7AJjq8/vZBF5/Gw2x4QrjKyLLk=;
        b=kn/QZZ8P+Qjqvw6g/YLw76HxFiSot0CTbTSslsy/ivj7nsX/kWgFRtk+Gn4LkKsrPt
         kcoeJCcxkH6ahGNB8mQ1+WgbgUkbHcj7T+199/ifd4iXwjTSbxXr5sQSXzX9V+Cl/eHs
         cmLqamdc3EFpd3+a/oOV2XoBfGSTK/kpZ6RhFMcpE1XgkVqR5eBvyuHCfAw96GwiZQuM
         1BF1NuxQiFeLgzyENCsD8KBG1X+2VxmnJ+2cQv0hhH5jlNCMxvzo2wrem/hhf9pWFfAO
         JSW40ASTzzQm4BgkaB2+4WTH13pkBuixi6sVUl3teqdK3f3Bo/xx8Mz2IuG2OTGATBds
         Krew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704767; x=1691296767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y79vNUtnDfZ2PZ6Si7AJjq8/vZBF5/Gw2x4QrjKyLLk=;
        b=X+izBbaQdooCOUY1he9Smxt2H9anlI1rIoik4soaWFAWs4jKtuC9nMPb1y18dH8dm6
         w9G9iWub/PEVXh9PoEIBR5CTpW5Z3CCkyFvVpnYTGVstWlwyb8tRc/miWJEY68CzabhC
         mUYGKpSRn+/s4XUo2c007NZHOm5EzDm+XIRDPtxOPXj8uftintBIAfwCtAm3S/qe0ZB2
         P7G/4AfjjUwcufxr/1Mj+F7XNgAHUcwFPpep/uIL6N2qoSGPlnv4S86EizWmuugTbi8y
         bHdktlCt8Fq6jDi0j+dxiGUdw/52UZuvvkPfkpa5IqopB9A9Rvia1+q5nhkM9an9BZLR
         eB2g==
X-Gm-Message-State: ABy/qLaJKryCSHJCCiUcj9zanuwj0R38AxeYchsJWZX5RfAAhVGAqpeV
	lLpOMxCcFDOqhWgRpbY2Xj3hOx5pKALckCH4rlPe/nophVI=
X-Google-Smtp-Source: APBJJlEtoZWFZDXQdQj0IXZDWuTWCappDPCipFM7qmFhCKraeFTYQusW87J7F7FSeEV1SkCa8pPkTTfbEdNjxNnFg7U=
X-Received: by 2002:ac2:5f86:0:b0:4f9:b649:23d2 with SMTP id
 r6-20020ac25f86000000b004f9b64923d2mr2477423lfe.42.1688704766989; Thu, 06 Jul
 2023 21:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-23-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-23-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:39:15 -0700
Message-ID: <CAEf4BzaWvAAwZmzBZSek=djaQ=2HX-S04sJ91jB98oY86Sq3Cg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 22/26] selftests/bpf: Add usdt_multi test program
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

On Fri, Jun 30, 2023 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding usdt_multi test program that defines 50k usdts and will
> serve as attach point for uprobe_multi usdt bench test in
> following patch.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile     |  5 +++++
>  tools/testing/selftests/bpf/usdt_multi.c | 24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/usdt_multi.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index acf7c9a29082..9762467cf0ba 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -568,6 +568,7 @@ TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read $(OUT=
PUT)/bpf_testmod.ko      \
>                        $(OUTPUT)/xdp_synproxy                           \
>                        $(OUTPUT)/sign-file                              \
>                        $(OUTPUT)/uprobe_multi                           \
> +                      $(OUTPUT)/usdt_multi                             \

that's a bit too much, if you can't put everything into urandom_read,
let's at least combine uprobe_multi and usdt_multi

>                        ima_setup.sh                                     \
>                        verify_sig_setup.sh                              \
>                        $(wildcard progs/btf_dump_test_case_*.c)         \
> @@ -675,6 +676,10 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
>
> +$(OUTPUT)/usdt_multi: usdt_multi.c
> +       $(call msg,BINARY,,$@)
> +       $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> +
>  EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)=
 \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
>         feature bpftool                                                 \
> diff --git a/tools/testing/selftests/bpf/usdt_multi.c b/tools/testing/sel=
ftests/bpf/usdt_multi.c
> new file mode 100644
> index 000000000000..fedf856bad2b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/usdt_multi.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <sdt.h>
> +
> +#define PROBE STAP_PROBE(test, usdt);
> +
> +#define PROBE10    PROBE PROBE PROBE PROBE PROBE \
> +                  PROBE PROBE PROBE PROBE PROBE
> +#define PROBE100   PROBE10 PROBE10 PROBE10 PROBE10 PROBE10 \
> +                  PROBE10 PROBE10 PROBE10 PROBE10 PROBE10
> +#define PROBE1000  PROBE100 PROBE100 PROBE100 PROBE100 PROBE100 \
> +                  PROBE100 PROBE100 PROBE100 PROBE100 PROBE100
> +#define PROBE10000 PROBE1000 PROBE1000 PROBE1000 PROBE1000 PROBE1000 \
> +                  PROBE1000 PROBE1000 PROBE1000 PROBE1000 PROBE1000
> +
> +int main(void)
> +{
> +       PROBE10000
> +       PROBE10000
> +       PROBE10000
> +       PROBE10000
> +       PROBE10000
> +       return 0;
> +}
> --
> 2.41.0
>

