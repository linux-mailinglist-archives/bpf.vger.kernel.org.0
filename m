Return-Path: <bpf+bounces-4347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884C74A75D
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A063F2814E1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8616427;
	Thu,  6 Jul 2023 23:02:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19763BA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 23:02:37 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7E1723
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:02:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so13922125e9.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688684554; x=1691276554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKCrKIMipyhRuz9DjFfu6bOANmZ9b32jEEZwgzbiQCM=;
        b=spxFZhJyZ5yGxCdoq/7C/RlSJY2WMUs/08lc+Cci6A1Fu3W3AnvUGTAhKPbKiR4sUv
         FVlqZEC1s8MtHcrnAXo6PsXoVszLUMDZMyBqJ2jZIHLmm5XfK0Tkmse78LIIJZaEOQGn
         yiTO0JJQ+qsAMIvNtFca15vhomSmLHXHkGOZwmIJQW9gSgE22QbgjAYHroejHyRmFnfn
         B2rF2AD2yNcCPHj2bb7lJPpgNpm4tJ6nzMMwgVGlfX67g0kIRS3yi/CVMglKTHRQgss1
         rZIx1o5XyNwES8A62ZHodsXD2psSLscoKVgu76/gLSgaZNaqVmUldD/1TMuI7/Im8hw8
         r1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688684554; x=1691276554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKCrKIMipyhRuz9DjFfu6bOANmZ9b32jEEZwgzbiQCM=;
        b=WDixLYoNNgKO5Oo1jQqIfDPSr74xOBr96rM84qtO5snZSmVg6u5cRP4Rpp6VG3yOMk
         z8QPzipa1UFrV1G47XFQQ0fitObIbWiPAVuW5UzOBakY1y4tJz+EU0yWyIqmF4e4IKMG
         xnt3AtVcaqiuPg17/VyztWfeJIRCZcxIlFAezDAwOR+QDh/aw/bA9VA/cZqFPzdYmxQu
         C4sqlvzMruuJI73cVdo/y3UpeUz8LNuL6Ot2AcaCugf2ZiaArNwVu8PM0lPnR9mbVhk5
         4Tm0uRnb4XT9xXn0C/z8HD78xrtygA4YmdJBy8wwGjYijxD7jlrpUiQs2gsYChboC24C
         Ap/w==
X-Gm-Message-State: ABy/qLZrFLvtl0ttPwBrkHf3XgfxFtpFkY18iYWFAQNULzkrUvIxwcps
	eYNULb6hIdR1PFKf4ahfs+63ssyF+oqwCtUq+BU=
X-Google-Smtp-Source: APBJJlFhp9lKKYx5phq2NXKtP2xUMjJ/bKmK2cTV1EfXArg6wsrFIaUcNLoFKjDuETz2O5BI17wBzFCTiv4pLns5/Yg=
X-Received: by 2002:a05:600c:c8:b0:3fa:95c7:e891 with SMTP id
 u8-20020a05600c00c800b003fa95c7e891mr2772866wmm.35.1688684553732; Thu, 06 Jul
 2023 16:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-8-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 16:02:22 -0700
Message-ID: <CAEf4BzbLDnEyCwEBn2PJCM_756d_C8Pbb+ocvwEkacnd1b8yVQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 07/26] libbpf: Move elf_find_func_offset*
 functions to elf object
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

On Fri, Jun 30, 2023 at 1:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new elf object that will contain elf related functions.
> There's no functional change.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/Build        |   2 +-
>  tools/lib/bpf/elf.c        | 198 +++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c     | 186 +---------------------------------
>  tools/lib/bpf/libbpf_elf.h |  11 +++
>  4 files changed, 211 insertions(+), 186 deletions(-)
>  create mode 100644 tools/lib/bpf/elf.c
>  create mode 100644 tools/lib/bpf/libbpf_elf.h
>

[...]

> diff --git a/tools/lib/bpf/libbpf_elf.h b/tools/lib/bpf/libbpf_elf.h
> new file mode 100644
> index 000000000000..1b652220fabf
> --- /dev/null
> +++ b/tools/lib/bpf/libbpf_elf.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +
> +#ifndef __LIBBPF_LIBBPF_ELF_H
> +#define __LIBBPF_LIBBPF_ELF_H
> +
> +#include <libelf.h>
> +
> +long elf_find_func_offset(Elf *elf, const char *binary_path, const char =
*name);
> +long elf_find_func_offset_from_file(const char *binary_path, const char =
*name);
> +
> +#endif /* *__LIBBPF_LIBBPF_ELF_H */

we have libbpf_internal.h, let's put all this there for now, it's
already all the internal stuff together, I don't know if separate
header with few functions gives us much

> --
> 2.41.0
>

