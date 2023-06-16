Return-Path: <bpf+bounces-2732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF7773371E
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0947F1C20EC5
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018BC1C774;
	Fri, 16 Jun 2023 17:03:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA281C764
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:03:35 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573F3A8E
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:03:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5196a728d90so1271308a12.0
        for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686934994; x=1689526994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aYA3y3Y+F6LzyOS7evX9mNQ2yYDoRHEfHRu0V5MFPQ=;
        b=mKW8nOVTJ8M0kLGhuENazfmKy+ZVBwtxjfHASdrJ2GfdBiQK1uxmTCKsB1VtwF+a+k
         ehiCii7lvkJR300qlItvJJYgNdN+Qf1iETyMClqplqW/g8ScdvcHpp7+cOOdVOO7Q0Zf
         +rZ4LrWqO5m6T02Te0LGCue03df9Lg3Nj0h1ONd5d7iE82KTH8SiKdZNqKlnrnXO2rCJ
         eHFZcgHhbgYS1Rd47Gya428TRdE49LeVIZoX0ip9Oy5mAeJuLyVJYkR31Zk5qJqxzVIz
         FMSrAyl0xIL0MaqO1bHdnzfqSQV+lFk9mf0nMll8TJ6vYDG1nzoB1aLUioCY3A1hnHB9
         BkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686934994; x=1689526994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aYA3y3Y+F6LzyOS7evX9mNQ2yYDoRHEfHRu0V5MFPQ=;
        b=fzxWa4R/mZtEMREJpaN7VppLvzfeyk7C2qZmCPqkspjtxJE/7WuaYVXZypGFX0NaFL
         wmGQSrs44XX2+PNlfmRznJfPgGd7+4uf5oQngYjGJhRZFqfF+xF263hD4htIrG0gJB4C
         aB1ZayTV5psvvzeC1YOvnQH+5LQXyd+ARU9+ArqHGM9p0HlOOcYZd8PgWPzEPdnjWTL0
         0i6NtlF6l+ZqkGjGg7UQdLYD5yU9rhsXe9X6Qvr5jAXdDP5Vrw0DBGL4X92ZsOz+bWPR
         G5id48GzgmibPfEnbp9SsQ169fnNkUIqSi4CdC7uKid2L5KZ7cL1wZFd3/8yJ08nGcNd
         /lXw==
X-Gm-Message-State: AC+VfDzlaCGoJDOR9VP0RUH6GdAXjncpINofxud8yD8cldPgmC1eNgjF
	TkWNPpl4D6cq1Gh074Swki1g0TBcPZsZZD/zDrU=
X-Google-Smtp-Source: ACHHUZ7d7tAEMzRvje2Q21eiMnZTHMmiXQUY/J+jW3xF9Hs0QNSw8ArFupBJwGBikUTRqqquV8uGxDLM5fkBfKRSWRI=
X-Received: by 2002:a17:907:8748:b0:974:1c91:a751 with SMTP id
 qo8-20020a170907874800b009741c91a751mr2128829ejc.29.1686934994434; Fri, 16
 Jun 2023 10:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615142520.10280-1-eddyz87@gmail.com>
In-Reply-To: <20230615142520.10280-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jun 2023 10:03:01 -0700
Message-ID: <CAEf4Bzb4VJ7h02QAbg77sp9jgVFJBWoXrRuWGxHkXqQdPJ6EPw@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: generate 'nomerge' for map helpers in bpf_helper_defs.h
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com, 
	jemarch@gnu.org, david.faust@oracle.com, dzq.aishenghu0@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 7:25=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Update code generation for bpf_helper_defs.h by adding
> __attribute__((nomerge)) for a set of helper functions to prevent some
> verifier unfriendly compiler optimizations.
>
> This addresses a recent mailing list thread [1].
> There Zhongqiu Duan and Yonghong Song discussed a C program as below:
>
>      if (data_end - data > 1024) {
>          bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
>      } else {
>          bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
>      }
>
> Which was converted by clang to something like this:
>
>      if (data_end - data > 1024)
>        tmp =3D &map1;
>      else
>        tmp =3D &map2;
>      bpf_for_each_map_elem(tmp, cb, &cb_data, 0);
>
> Which in turn triggered verification error, because
> verifier.c:record_func_map() requires a single map address for each
> bpf_for_each_map_elem() call.
>
> In fact, this is a requirement for the following helpers:
> - bpf_tail_call
> - bpf_map_lookup_elem
> - bpf_map_update_elem
> - bpf_map_delete_elem
> - bpf_map_push_elem
> - bpf_map_pop_elem
> - bpf_map_peek_elem
> - bpf_for_each_map_elem
> - bpf_redirect_map
> - bpf_map_lookup_percpu_elem
>
> I had an off-list discussion with Yonghong where we agreed that clang
> attribute 'nomerge' (see [2]) could be used to prevent the
> optimization hitting in [1]. However, currently 'nomerge' applies only
> to functions and statements, hence I submitted change requests [3],
> [4] to allow specifying 'nomerge' for function pointers as well.
>
> The patch below updates bpf_helper_defs.h generation by adding a
> definition of __nomerge macro, and using this macro in definitions of
> relevant helpers.
>
> The generated code looks as follows:
>
>     /* This is auto-generated file. See bpf_doc.py for details. */
>
>     #if __has_attribute(nomerge)
>     #define __nomerge __attribute__((nomerge))
>     #else
>     #define __nomerge
>     #endif
>
>     /* Forward declarations of BPF structs */
>     ...
>     static long (*bpf_for_each_map_elem)(void *map, ...) __nomerge =3D (v=
oid *) 164;
>     ...
>
> (In non-RFC version the macro definition would have to be updated to
>  check for supported clang version).
>
> Does community agree with such approach?

Makes sense to me. Let's just be very careful to do proper detection
of __nomerge "applicability" to ensure we don't cause compilation
errors for unsupported Clang (which I'm sure you are well aware of)
*and* make it compatible with GCC, so we don't fix it later.

>
> [1] https://lore.kernel.org/bpf/03bdf90f-f374-1e67-69d6-76dd9c8318a4@meta=
.com/
> [2] https://clang.llvm.org/docs/AttributeReference.html#nomerge
> [3] https://reviews.llvm.org/D152986
> [4] https://reviews.llvm.org/D152987
> ---
>  scripts/bpf_doc.py | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index eaae2ce78381..dbd4893c793e 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -777,14 +777,33 @@ class PrinterHelpers(Printer):
>          'bpf_get_socket_cookie',
>          'bpf_sk_assign',
>      ]
> +    # Helpers that need __nomerge attribute
> +    nomerge_helpers =3D set([
> +       "bpf_tail_call",
> +       "bpf_map_lookup_elem",
> +       "bpf_map_update_elem",
> +       "bpf_map_delete_elem",
> +       "bpf_map_push_elem",
> +       "bpf_map_pop_elem",
> +       "bpf_map_peek_elem",
> +       "bpf_for_each_map_elem",
> +       "bpf_redirect_map",
> +       "bpf_map_lookup_percpu_elem"
> +    ])
> +
> +    macros =3D '''\
> +#if __has_attribute(nomerge)
> +#define __nomerge __attribute__((nomerge))
> +#else
> +#define __nomerge
> +#endif'''
>
>      def print_header(self):
> -        header =3D '''\
> -/* This is auto-generated file. See bpf_doc.py for details. */
> -
> -/* Forward declarations of BPF structs */'''
> -
> -        print(header)
> +        print('/* This is auto-generated file. See bpf_doc.py for detail=
s. */')
> +        print()
> +        print(self.macros)
> +        print()
> +        print('/* Forward declarations of BPF structs */')
>          for fwd in self.type_fwds:
>              print('%s;' % fwd)
>          print('')
> @@ -846,7 +865,11 @@ class PrinterHelpers(Printer):
>              comma =3D ', '
>              print(one_arg, end=3D'')
>
> -        print(') =3D (void *) %d;' % helper.enum_val)
> +        print(')', end=3D'')
> +        if proto['name'] in self.nomerge_helpers:
> +            print(' __nomerge', end=3D'')
> +
> +        print(' =3D (void *) %d;' % helper.enum_val)
>          print('')
>
>  ########################################################################=
#######
> --
> 2.40.1
>

