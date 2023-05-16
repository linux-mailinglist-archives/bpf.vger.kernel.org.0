Return-Path: <bpf+bounces-677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD077059C1
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 23:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183151C20BE0
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62E271FF;
	Tue, 16 May 2023 21:45:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98715271EF
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:45:51 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0551D5FD2
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:45:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965ddb2093bso2209253466b.2
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684273548; x=1686865548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShaWctnp2LdTvMp54nUFEU96aqFVIkpJcV2g3mhk7k0=;
        b=KCtno1rJ/0rs731q2WRGbf/ROEicG7zRJWG46u8rt0arqzGkthkEuRjM+Dcvu7LmO0
         az6Y9w2sOhSjVvBjLToxwhkUjHplc1F+Gr7A5RUYd7WzfB38cmdibxIOfeJuYtFQpgHS
         3RkCaBiYzBCsQgG7ApFxXXTaEgu9BLcc6xRYe35fQN8V1eQFesrRlPyFZisj1v3hLECb
         CXOTDJk7aA8vnuXwUvVZJ3UC2D/C1NBv6VUGONc2/wcYBQ7zeMZRsULgKuA0IdBMweUf
         gI73bvO5UDINbkPNghGCwKhnd+PnnVaCukpxSE14PN1etS9rG2aE5COXMaJY9in8eF6/
         NSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684273548; x=1686865548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShaWctnp2LdTvMp54nUFEU96aqFVIkpJcV2g3mhk7k0=;
        b=bkETrHlJoOh/FkYo9/2ASxh/YRw/oQGtdxteXzrEu9Ny81XerCoZwgoBXE6jU/QDEB
         Y2ZAcAIu5P3gtjBA6qFvMLVjAdWSF+/vW/mtKsTleKNlqBmHHHd92iOZawzdOb2GFxxy
         hx7G+yNEWtYg4W80SkBPgU6xZdTdp+B8GV/joo9dCQTd0hW+FV0r7xZYL5KZJMF2ffa3
         AK26/Axp3/pnIDfghrUFtQBiwTu/YcgKIxULOw6U+vuA6e1gS4lw+c68sMLTlDiBf5S5
         LxGK83xDQ082zjvZeWB9qp/QJ5x8xlhxGRG/YedPvQUjsRE+AY2co3LQyXQx2AhVAU5D
         a1vw==
X-Gm-Message-State: AC+VfDzswh9FBq16RLBj34/VExg87BRWCok2sMHtj0vjqBg1VI1WURwQ
	xdIMStcepUVatBhotKlffi1Ae2EIhHbSB8+mj7Y=
X-Google-Smtp-Source: ACHHUZ7bUBY0o3o2sgBw+p8DOWYBl7FnMPI1J1Qw4jlMxGRCF3xG8Pdc0scSjAXc/UBcQ2FwxEEQaDSeixObFTTFdiE=
X-Received: by 2002:a17:907:720d:b0:966:a691:55ed with SMTP id
 dr13-20020a170907720d00b00966a69155edmr30887078ejc.70.1684273548118; Tue, 16
 May 2023 14:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515133756.1658301-1-jolsa@kernel.org> <20230515133756.1658301-9-jolsa@kernel.org>
In-Reply-To: <20230515133756.1658301-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 14:45:36 -0700
Message-ID: <CAEf4BzaLAZX_xVyRkavFiz+yLR057TuERcmsOc_amtjQCbHVoA@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 08/10] selftests/bpf: Allow to use kfunc from
 testmod.ko in test_verifier
To: Jiri Olsa <jolsa@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 6:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently the test_verifier allows test to specify kfunc symbol
> and search for it in the kernel BTF.
>
> Adding the possibility to search for kfunc also in bpf_testmod
> module when it's not found in kernel BTF.
>
> To find bpf_testmod btf we need to get back SYS_ADMIN cap.
>
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 161 +++++++++++++++++---
>  1 file changed, 139 insertions(+), 22 deletions(-)
>

Eduard is working on migrating most (if not all) test_verifier tests
into test_progs where we can use libbpf declarative functionality for
things like this.

Eduard, can you please review this part? Would it make sense to just
wait for the migration? If not, will there be anything involved to
support something like this for the future migration?


> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index 285ea4aba194..71704a38cac3 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -874,8 +874,140 @@ static int create_map_kptr(void)
>         return fd;
>  }
>

[...]

