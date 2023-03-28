Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250B76CB471
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 05:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjC1DEl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 23:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjC1DEb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 23:04:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CBC268C
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 20:04:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so44054719edb.4
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 20:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679972667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqXP8sGMbmvNa71s080ANzvst0TmUJedtcxv63lzs/k=;
        b=iQ0udfLVPB7HJGzdmH5/BHq1oCAMoP+tiGPGsyEEn6idPoOc5l6NYigDf+dLdmvUzo
         o9gsRFZyZvEKBkjz0H7WmRVY/N2iJ8bhkeVDMZqcJ+OE/3kczsvbcllSQjZR+fPgGT3d
         LJw5vIT74ju2+DAL49yKbEp7ygz3s0KJ7zFpW1RyWAZqvcB0+/9ZUu58kDWyjdjKbZwk
         XSSNKUDSQKiNpu1xL6LR17hQLwAeKW3pnSsZgM/V8+0DnmefUCnP0I3TP+9cHYwNHUEK
         7KyubjbBoLPkUEPFYB6LYlALLAohFwmaxP+5Mipx1exXq9i592jfk7oamsTqqz9D1SiM
         i7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqXP8sGMbmvNa71s080ANzvst0TmUJedtcxv63lzs/k=;
        b=Z87XOp+MkLFvzwDL1z7HAXlf1C8wnKDHKp2yUI3j859lEMfljUweu85Hj31vJh8FAy
         9R5qYESYWErOJT0FoWpke2uD/kPipp6FHCQsZir+5fQ8IRRXZ4bz8JB8rQBt01wjI5ye
         eZ+s/pVIzUOIPFsz6fnuD/HJoYCon6zmTqAmnXdvGr34DdN0tuq3vVnCIA6OEqoh1rBT
         afmOPhzGMaQL5/RxhSVnW56J+XmhjeGamFMQQ5d+tYh1GlTcpVJDdbkY5o8ykBsu3/qK
         pcWpCQhsHESLEQhkX7RjXKCUUPBYbVi7Y3OYVYdV05b1D8lrsIepAAF+QddpdDnC/r48
         ZYGg==
X-Gm-Message-State: AAQBX9cWnGbsb2hXpIrl9vqUgBlq83AHH9XOXbUsrQog6IGu1SM7oj4D
        fN7+CQDqdoNrX/kt/yaHqIrwi6VNSVQ1r/glQJ1KJbkl
X-Google-Smtp-Source: AKy350bFvU04yFJ93HdTCv6fogWQ7dXSiElhLFTdwe2vrDIa1Jwz7X3Y6VNltPNRc/XmPhfjbgVLgUnJL4XFwsSK6RM=
X-Received: by 2002:a50:bac5:0:b0:4ab:49b9:686d with SMTP id
 x63-20020a50bac5000000b004ab49b9686dmr6805460ede.1.1679972667070; Mon, 27 Mar
 2023 20:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230328004738.381898-1-eddyz87@gmail.com> <20230328004738.381898-2-eddyz87@gmail.com>
In-Reply-To: <20230328004738.381898-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 20:04:15 -0700
Message-ID: <CAEf4BzZoUh3HTevd+vAEOt_jvozEpUAaK7xS44oTrO=qe5SBTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Test if bpftool linker
 handles empty sections
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com, james.hilliard1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 27, 2023 at 5:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Adds two empty functions to linked_funcs[12].c. The functions are
> annotated as "naked" and go to a separate section. This section ends
> up having size 0. bpftool linker merges content for sections with
> identical names. This tests if it can handle empty sections.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/linked_funcs1.c | 3 +++
>  tools/testing/selftests/bpf/progs/linked_funcs2.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/linked_funcs1.c b/tools/te=
sting/selftests/bpf/progs/linked_funcs1.c
> index c4b49ceea967..029bb5022ba2 100644
> --- a/tools/testing/selftests/bpf/progs/linked_funcs1.c
> +++ b/tools/testing/selftests/bpf/progs/linked_funcs1.c
> @@ -86,4 +86,7 @@ int BPF_PROG(handler1, struct pt_regs *regs, long id)
>         return 0;
>  }
>
> +SEC(".empty_section")
> +__naked void empty_function1(void) {}
> +
>  char LICENSE[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/linked_funcs2.c b/tools/te=
sting/selftests/bpf/progs/linked_funcs2.c
> index 013ff0645f0c..4547c8dfc689 100644
> --- a/tools/testing/selftests/bpf/progs/linked_funcs2.c
> +++ b/tools/testing/selftests/bpf/progs/linked_funcs2.c
> @@ -86,4 +86,7 @@ int BPF_PROG(handler2, struct pt_regs *regs, long id)
>         return 0;
>  }
>
> +SEC(".empty_section")
> +__naked void empty_function2(void) {}

These empty section functions make this whole BPF object file invalid
from libbpf's standpoint. It didn't feel worth it to add this
confusion just to test this edge case in realloc() handling. So I
dropped this patch and only applied libbpf fix. Pushed to bpf-next,
thanks!

> +
>  char LICENSE[] SEC("license") =3D "GPL";
> --
> 2.40.0
>
