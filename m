Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C795A1A69
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbiHYUf6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbiHYUf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 16:35:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C202D10E;
        Thu, 25 Aug 2022 13:35:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id og21so4230491ejc.2;
        Thu, 25 Aug 2022 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=7jCpBi0gO1X5H+QivyPxPqlG7PUje4Vf82qjoN1XYWI=;
        b=nr6R7SSDginCvMcow4HYvrEPPqf16D6Hr+lEamHliByKhbOB3MyST9QLxZCR5V/sSy
         NnfKtO495pDJa+xe26BjoREzFUuN0kypsXSXHDybt3BJgwp5Y1RJozfbOBsi1UZih0Sc
         hKoayD0xSrNIkwkQ/hgywNrtWeGWQA7pnr2vhxlMZtQi9iNWGFBgaB8ep1Ica5XZbM14
         YoKTBFOIg3MC3sEsv5/UJz7hoKSt0FeI/LPITK8hAbZBzzU24vnAS7AkRQPknwXIYnsO
         3cqcYx/Agrr/oxAvG1hRisnE53p4inf5KYoUs0EzcQ82+kGLJsWvOhwz2zaCMq5JLQ5I
         U5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7jCpBi0gO1X5H+QivyPxPqlG7PUje4Vf82qjoN1XYWI=;
        b=1tQ+DsbfyUG3Is9chDq2uhPU/DqQ6FOYDTiPmN3y7+uzvMMyPtgMCF0ceuHlBrar9N
         SnUTVQkXhRUqS2ICX0bFPux8j3rPRe53FKAOML9U9Dit7mAF4kLQ1HWta/Ohn8idH5q7
         g3dZbax6XnBA2RFuI18G2HyuOiDhHAkLGYbeLgHZ0N5MyrGi44Bvf70ensNln7mwKVkz
         UUoYsFV6fV9qQIkRB60OC54QZVmuIivUjsV2Ia+Fh75nyLGA+7emNmGt3LaCP656jaEV
         9XQtrtWj0zG7rwcgDCiysrIMoPg9Lv3FWfMlJNwGJBd++u7IkO2VLXvVNKmfpgqM1PZs
         X5Ag==
X-Gm-Message-State: ACgBeo1Wyxjqc3i4Hx2ykoF1i+1GKUeiKQgtMxW/UdN72krdLIUmlUEk
        tGzX9xRnJTKb4Q50COEphsdgM5Kkxc8si1liwPjUAS0Z
X-Google-Smtp-Source: AA6agR6tU3tYvv9KsddpLK7CsQyVz3mtd+el7q2X+xyQhZE6CwY2yk6dDl5oUOL1tBC1zwVxPB6unzcQfFG8VZYlGto=
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id
 gs18-20020a1709072d1200b007316a4eceb0mr3489988ejc.115.1661459751643; Thu, 25
 Aug 2022 13:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220824221018.24684-1-donald.hunter@gmail.com> <20220824221018.24684-3-donald.hunter@gmail.com>
In-Reply-To: <20220824221018.24684-3-donald.hunter@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 13:35:40 -0700
Message-ID: <CAEf4BzZnsEAGOXY0KGAN6ZcLsHeMYEfRGaO20jEJk_soqLnD7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] Add table of BPF program types to libbpf docs
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 3:30 PM Donald Hunter <donald.hunter@gmail.com> wro=
te:
>
> Extend the libbpf documentation with a table of program types,
> attach points and ELF section names. This table uses data from
> program_types.csv which is generated from tools/lib/bpf/libbpf.c
> during the documentation build.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/Makefile                     |  3 +-
>  Documentation/bpf/libbpf/Makefile          | 36 ++++++++++++++++++++++
>  Documentation/bpf/libbpf/index.rst         |  3 ++
>  Documentation/bpf/libbpf/program_types.rst | 18 +++++++++++
>  Documentation/bpf/programs.rst             |  3 ++
>  5 files changed, 62 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/bpf/libbpf/Makefile
>  create mode 100644 Documentation/bpf/libbpf/program_types.rst
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 8a63ef2dcd1c..f007314770e1 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -66,7 +66,8 @@ I18NSPHINXOPTS  =3D $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) =
.
>  loop_cmd =3D $(echo-cmd) $(cmd_$(1)) || exit;
>
>  BUILD_SUBDIRS =3D \
> -       Documentation/userspace-api/media
> +       Documentation/userspace-api/media \
> +       Documentation/bpf/libbpf
>
>  quiet_cmd_build_subdir =3D SUBDIR  $2
>        cmd_build_subdir =3D $(MAKE) BUILDDIR=3D$(abspath $(BUILDDIR)) $(b=
uild)=3D$2 $3
> diff --git a/Documentation/bpf/libbpf/Makefile b/Documentation/bpf/libbpf=
/Makefile
> new file mode 100644
> index 000000000000..c0c2811c4dd6
> --- /dev/null
> +++ b/Documentation/bpf/libbpf/Makefile
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Rules to convert BPF program types in tools/lib/bpf/libbpf.c
> +# into a .csv file
> +
> +FILES =3D program_types.csv
> +
> +TARGETS :=3D $(addprefix $(BUILDDIR)/, $(FILES))
> +
> +$(BUILDDIR)/program_types.csv: $(srctree)/tools/lib/bpf/libbpf.c
> +       $(Q)awk -F'[",[:space:]]+' \
> +       'BEGIN { print "Program Type,Attach Type,ELF Section Name,Sleepab=
le" } \
> +       /SEC_DEF\(\"/ && !/SEC_DEPRECATED/ { \
> +       type =3D "``BPF_PROG_TYPE_" $$4 "``"; \
> +       attach =3D index($$5, "0") ? "" : "``" $$5 "``"; \
> +       section =3D "``" $$3 "``"; \
> +       sleepable =3D index($$0, "SEC_SLEEPABLE") ? "Yes" : ""; \
> +       print type "," attach "," section "," sleepable }' \
> +       $< > $@
> +
> +.PHONY: all html epub xml latex linkcheck clean
> +
> +all: $(BUILDDIR) ${TARGETS}
> +       @:
> +
> +html: all
> +epub: all
> +xml: all
> +latex: all
> +linkcheck:
> +
> +clean:
> +       -$(Q)rm -f ${TARGETS} 2>/dev/null
> +
> +$(BUILDDIR):
> +       $(Q)mkdir -p $@
> diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbp=
f/index.rst
> index 3722537d1384..2c04a9b3aa1f 100644
> --- a/Documentation/bpf/libbpf/index.rst
> +++ b/Documentation/bpf/libbpf/index.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>
> +.. _libbpf:
> +
>  libbpf
>  =3D=3D=3D=3D=3D=3D
>
> @@ -9,6 +11,7 @@ libbpf
>     API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>

I'd put program_types here, it's more relevant and important than
libbpf naming conventions

>     libbpf_naming_convention
>     libbpf_build
> +   program_types
>
>  This is documentation for libbpf, a userspace library for loading and
>  interacting with bpf programs.
> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/b=
pf/libbpf/program_types.rst
> new file mode 100644
> index 000000000000..dc65ede09eef
> --- /dev/null
> +++ b/Documentation/bpf/libbpf/program_types.rst
> @@ -0,0 +1,18 @@
> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +.. _program_types_and_elf:
> +
> +Program Types  and ELF Sections

nit: two spaces?

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +The table below lists the program types, their attach types where releva=
nt and the ELF section
> +names supported by libbpf for them. The ELF section names follow these r=
ules:
> +
> +- ``type`` is an exact match, e.g. ``SEC("socket")``
> +- ``type+`` means it can be either exact ``SEC("type")`` or well-formed =
``SEC("type/extras")``
> +  with a =E2=80=98``/``=E2=80=99 separator, e.g. ``SEC("tracepoint/sysca=
lls/sys_enter_open")``

'/' is always going to be a type and "extras" separator, but extra
section format is not formalized. We have cases where it's all '/'s
(like tracepoint you mentioned), but newer and more complicated format
uses ':' as separator, e.g.
SEC("usdt/<path-to-binary>:<usdt_provide>:<usdt_name>") (let's mention
the latter as well to not create false impression of only ever having
'/' as separator)

> +
> +.. csv-table:: Program Types and Their ELF Section Names
> +   :file: ../../output/program_types.csv
> +   :widths: 40 30 20 10
> +   :header-rows: 1

it would be helpful to include a short snippet from generated CSV file
to give a general idea of the output

> diff --git a/Documentation/bpf/programs.rst b/Documentation/bpf/programs.=
rst
> index 620eb667ac7a..c99000ab6d9b 100644
> --- a/Documentation/bpf/programs.rst
> +++ b/Documentation/bpf/programs.rst
> @@ -7,3 +7,6 @@ Program Types
>     :glob:
>
>     prog_*
> +
> +For a list of all program types, see :ref:`program_types_and_elf` in
> +the :ref:`libbpf` documentation.
> --
> 2.35.1
>
