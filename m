Return-Path: <bpf+bounces-3217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981B73AD5B
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 01:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62ACC1C20BDC
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C323C81;
	Thu, 22 Jun 2023 23:49:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067821085
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 23:49:15 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F52121
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:49:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so1543525e9.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687477752; x=1690069752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDrJLDKz6Ud6hAY8NImhH7aXBEGlQcRyHIMiCbR7vGU=;
        b=nEZ9Q12jc8Mxv5TtWSdgL2QKEyyF+AyuemULzkG35WXJaMo4POjkDQGByYQXZq+Xxu
         jrL3zPALGsfy3GOUnzGkREFa8al0Qm5NgQ/oGg47lLlyXOj8HkdkfJG2PoMBFswIZu+W
         wJuBd3N1gbdGNQlwOpZ/Brx6zxqx/RW+hvGPL9liNCYJZFMremrc1J0l+6xIsU1xfZu5
         N6RgpFCUtdARL94S/ydH+6f4C8dnYbrXF0d7JM5YubMqW4gWCHLqkyRAPKf18SeCepzl
         oW4WDVMTGzGmsyTlnLXMruxXwj/izROLMLxyUni/6UK/fJ2pLPFLZGjVkK163yf6aaF8
         yY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687477752; x=1690069752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDrJLDKz6Ud6hAY8NImhH7aXBEGlQcRyHIMiCbR7vGU=;
        b=g0RW8Qbq0sc8Nqn2mmiIBPSNpJBuHzwATPmWqa+tY4BZ8ygU50vkdOX7CvaL6DjXPe
         jRmzXgP3czRt1GUa/WmVAM33vBSoIGqTb05UtCYCysQEs5/JivMa+uexKQu3dSODBFBW
         OEbJ5rPyiXHwI5SubkiZDZWvQvpVBOupuQP1p4sWfynIw0lxY274BFGEQb08NTQ/haz4
         V1cqE1Inp/GRl/WuE1W+qn1voiLryduM7GTWM+p8vFKPkD8yalpDaSjj5CTMTIaIpwOm
         ELmcoqDu6YffXQVNykbvzpjOOgR1wrwekVhOzOgQXfRskATrBL10aReO2ds0DGBL/qVo
         yNPw==
X-Gm-Message-State: AC+VfDyHD/qb/32QAerXVAzC1kPRkjdSLBMAGg3SOCLsWkJEil+F3lYn
	41abNzV6t/wPXw3YSOwFYxLz0AtZWqMLlw37EWg=
X-Google-Smtp-Source: ACHHUZ4nMvtHanaFcQDRRrAfp/LmWmj0OMD3tABujKMv7p/Pozw/HMonK9oTDIT4LzV+zk3bskyqCX3oQQCqitGXjYA=
X-Received: by 2002:a05:600c:2206:b0:3f9:515:ccfb with SMTP id
 z6-20020a05600c220600b003f90515ccfbmr18549279wml.12.1687477751541; Thu, 22
 Jun 2023 16:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616171728.530116-1-alan.maguire@oracle.com> <20230616171728.530116-10-alan.maguire@oracle.com>
In-Reply-To: <20230616171728.530116-10-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 16:48:59 -0700
Message-ID: <CAEf4BzZxzyKKhsJUhp_isrHKCpRFmoCH4mxibRij-cdudsmAxQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: test kind encoding/decoding
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	quentin@isovalent.com, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 10:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> verify btf__new_empty_opts() adds kind layouts for all kinds supported,
> and after adding kind-related types for an unknown kind, ensure that
> parsing uses this info when that kind is encountered rather than
> giving up.  Also verify that presence of a required kind will fail
> parsing.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .../selftests/bpf/prog_tests/btf_kind.c       | 187 ++++++++++++++++++
>  1 file changed, 187 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_kind.c
> new file mode 100644
> index 000000000000..ff37126b6bc0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023, Oracle and/or its affiliates. */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include <bpf/libbpf.h>
> +
> +/* verify kind encoding exists for each kind */
> +void test_btf_kind_encoding(struct btf *btf)

static

> +{
> +       const struct btf_header *hdr;
> +       const void *raw_btf;
> +       __u32 raw_size;
> +
> +       raw_btf =3D btf__raw_data(btf, &raw_size);
> +       if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
> +               return;
> +
> +       hdr =3D raw_btf;
> +
> +       ASSERT_GT(hdr->kind_layout_off, hdr->str_off, "kind layout off");

check that it's multiple of 4 maybe?

> +       ASSERT_EQ(hdr->kind_layout_len, sizeof(struct btf_kind_layout) * =
NR_BTF_KINDS,
> +                 "kind_layout_len");
> +}
> +
> +static void write_raw_btf(const char *btf_path, void *raw_btf, size_t ra=
w_size)
> +{
> +       int fd =3D open(btf_path, O_WRONLY | O_CREAT);
> +
> +       write(fd, raw_btf, raw_size);
> +       close(fd);
> +}

why bother with writing/reading to/from file, if you can just parse it
from memory with btf__new() ?

> +
> +/* fabricate an unrecognized kind at BTF_KIND_MAX + 1, and after adding
> + * the appropriate struct/typedefs to the BTF such that it recognizes
> + * this kind, ensure that parsing of BTF containing the unrecognized kin=
d
> + * can succeed.
> + */
> +void test_btf_kind_decoding(struct btf *btf)
> +{
> +       __s32 int_id, unrec_id, id, id2;
> +       struct btf_type *t;
> +       char btf_path[64];
> +       const void *raw_btf;
> +       void *new_raw_btf;
> +       struct btf *new_btf;
> +       struct btf_header *hdr;
> +       struct btf_kind_layout *k;
> +       __u32 raw_size;
> +

[...]

> +
> +void test_btf_kind(void)
> +{
> +       LIBBPF_OPTS(btf_new_opts, opts);
> +
> +       opts.add_kind_layout =3D true;
> +
> +       struct btf *btf =3D btf__new_empty_opts(&opts);

are you trying to save 3 lines of code here but instead coupling
encoding/decoding subtests? Why? I had to go and check that there is
no expectation that test_btf_kind_encoding() has to be run first
before test_btf_kind_decoding(btf). Doesn't seem like there is, but
why doing this empty btf instantiation outside of each subtest? Keep
it simple, create empty btf inside the subtest as necessary.


> +
> +       if (!ASSERT_OK_PTR(btf, "btf_new"))
> +               return;
> +
> +       if (test__start_subtest("btf_kind_encoding"))
> +               test_btf_kind_encoding(btf);
> +       if (test__start_subtest("btf_kind_decoding"))
> +               test_btf_kind_decoding(btf);
> +       btf__free(btf);
> +}
> --
> 2.39.3
>

