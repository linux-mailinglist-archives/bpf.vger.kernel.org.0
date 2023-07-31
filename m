Return-Path: <bpf+bounces-6483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FB76A397
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F571C20D80
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 22:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B523B1E532;
	Mon, 31 Jul 2023 22:00:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED981DDC5
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 22:00:02 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B8E7;
	Mon, 31 Jul 2023 15:00:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so36045531fa.1;
        Mon, 31 Jul 2023 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690840799; x=1691445599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va3Hr//Iy6un0Gflh3lVoQezkuRZ1y6D/A+Si7I5RQY=;
        b=qOEWF1aXanGlasHGN4tOlxdbOZ45FjOQlnuMlfoSh6LGTJH7GMhoU6WVb5wRfZ21ER
         BDC55DvGgNAwHLmnxWoMbhtEWMiMsjbKjhraRxRN2u/8uH0wOjAmRow1+ZTBverzGeJ3
         19MbLpL1lsLWn9h12OzowfZ3sLM1JrZoM6jqZeX5e9IUG8yLczNL7gGG2F5rQu+x48OY
         R8ACCnHqTCJ3/RdE7CMfXrbU0ZWRuSZdne8tHZpMxtg2rpmWRIcD2271xUHE/b+GSss4
         PbxRLYGNqdK+ncwCKcmM6iOsmpCvJs4F+Ne2V4u+ulerIFySvhBaQwt3MVE1ICJkgBNV
         8Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840799; x=1691445599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va3Hr//Iy6un0Gflh3lVoQezkuRZ1y6D/A+Si7I5RQY=;
        b=So4/vb0BPL25NbeYwrZAAnExFM3MWvU0jGHibCCyr+nfjFiXY59OCVFIdD6FVBTI2f
         5ugmQB2VWb4Dpd6sEXvQRfXZQn6Diu1ED1lfhrRBro8ZTxW5Xh8V2Fhi1hjVEow4oXZV
         SHHHQhETiMTXgTeFNOp3uMJmfE9LfGtjMzfaNAzk/4XjxIJuTVPhf0q4VIL+uLhLBzdf
         DPdgjYIg8bBH9g5u6gZLDkkakGEaoOocPBp6WD/RN4eJYMveLHYa+SdOV+xY63sxhu8C
         DCgIpze/crlCOnbe82ESsMHaBBUOJeoSdCZ5/KJ2i7F+9tUOLu/WRcV1tZtQidbJiIM2
         vBGQ==
X-Gm-Message-State: ABy/qLblljKmhbTxeFEpcb2fndqoEd3PfgC2w1PirhWq5Wizwc664cCH
	t5JiKUl21d98OgRy7OdcaLh2o5CxMRpiyrBrizTK8vNP
X-Google-Smtp-Source: APBJJlFt1FDaf3Tfj2lH9M+bK7BuBkfyranBWqJMKAVmXgk/857+ZzH6Syb9LE8GgRnk3RpIgMEyfrsJcwNDdI/rbo4=
X-Received: by 2002:a2e:b011:0:b0:2b6:9fdf:d8f4 with SMTP id
 y17-20020a2eb011000000b002b69fdfd8f4mr833455ljk.29.1690840798696; Mon, 31 Jul
 2023 14:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2> <169078863449.173706.2322042687021909241.stgit@devnote2>
In-Reply-To: <169078863449.173706.2322042687021909241.stgit@devnote2>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Jul 2023 14:59:47 -0700
Message-ID: <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 12:30=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add btf_find_struct_member() API to search a member of a given data struc=
ture
> or union from the member's name.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  Changes in v3:
>   - Remove simple input check.
>   - Fix unneeded IS_ERR_OR_NULL() check for btf_type_by_id().
>   - Move the code next to btf_get_func_param().
>   - Use for_each_member() macro instead of for-loop.
>   - Use btf_type_skip_modifiers() instead of btf_type_by_id().
>  Changes in v4:
>   - Use a stack for searching in anonymous members instead of nested call=
.
> ---
>  include/linux/btf.h |    3 +++
>  kernel/bpf/btf.c    |   40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 20e3a07eef8f..4b10d57ceee0 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -226,6 +226,9 @@ const struct btf_type *btf_find_func_proto(const char=
 *func_name,
>                                            struct btf **btf_p);
>  const struct btf_param *btf_get_func_param(const struct btf_type *func_p=
roto,
>                                            s32 *nr);
> +const struct btf_member *btf_find_struct_member(struct btf *btf,
> +                                               const struct btf_type *ty=
pe,
> +                                               const char *member_name);
>
>  #define for_each_member(i, struct_type, member)                        \
>         for (i =3D 0, member =3D btf_type_member(struct_type);      \
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f7b25c615269..8d81a4ffa67b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -958,6 +958,46 @@ const struct btf_param *btf_get_func_param(const str=
uct btf_type *func_proto, s3
>                 return NULL;
>  }
>
> +#define BTF_ANON_STACK_MAX     16
> +
> +/*
> + * Find a member of data structure/union by name and return it.
> + * Return NULL if not found, or -EINVAL if parameter is invalid.
> + */
> +const struct btf_member *btf_find_struct_member(struct btf *btf,
> +                                               const struct btf_type *ty=
pe,
> +                                               const char *member_name)
> +{
> +       const struct btf_type *anon_stack[BTF_ANON_STACK_MAX];
> +       const struct btf_member *member;
> +       const char *name;
> +       int i, top =3D 0;
> +
> +retry:
> +       if (!btf_type_is_struct(type))
> +               return ERR_PTR(-EINVAL);
> +
> +       for_each_member(i, type, member) {
> +               if (!member->name_off) {
> +                       /* Anonymous union/struct: push it for later use =
*/
> +                       type =3D btf_type_skip_modifiers(btf, member->typ=
e, NULL);
> +                       if (type && top < BTF_ANON_STACK_MAX)
> +                               anon_stack[top++] =3D type;
> +               } else {
> +                       name =3D btf_name_by_offset(btf, member->name_off=
);
> +                       if (name && !strcmp(member_name, name))
> +                               return member;
> +               }
> +       }
> +       if (top > 0) {
> +               /* Pop from the anonymous stack and retry */
> +               type =3D anon_stack[--top];
> +               goto retry;
> +       }

Looks good, but I don't see a test case for this.
The logic is a bit tricky. I'd like to have a selftest that covers it.

You probably need to drop Alan's reviewed-by, since the patch is quite
different from the time he reviewed it.

Assuming that is addressed. How do we merge the series?
The first 3 patches have serious conflicts with bpf trees.

Maybe send the first 3 with extra selftest for above recursion
targeting bpf-next then we can have a merge commit that Steven can pull
into tracing?

Or if we can have acks for patches 4-9 we can pull the whole set into bpf-n=
ext.

