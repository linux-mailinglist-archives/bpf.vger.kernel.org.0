Return-Path: <bpf+bounces-2746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F7F73376C
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE932817BB
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCD1C773;
	Fri, 16 Jun 2023 17:25:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636D182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:25:48 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E751FD7;
	Fri, 16 Jun 2023 10:25:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso1257118a12.3;
        Fri, 16 Jun 2023 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686936345; x=1689528345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WOUSqHHDDxpch1TJqgV2f+62UgYbb/xkkpc8zQS/vs=;
        b=MUPpRm1DBRAQ1gr4rZOgCEmRnFugKNFVBtAkm3SAVULh8n6N8tTKaZ13eYJDIC3MVx
         RwpH9C2dHdAy4HitSSiJTYvcf8lUrDcOOuD1DBFmpifbSyjdqrnkIspBcB55YLUrRDLp
         uAm3WUj4BnW+Zu7TRHpWlTr17rS9fkkczVyLDtkGLVzF5iOIdM9hwvB33cfV00eF64tF
         fbwH+LYrfk2EsIb/r5wdb6ozCktFz1Ay4Sr3yWu5o4Jy6HPkyxA789pyZNZNd7l9ygPm
         el4lteuXHHGm0fv83cw4M7EYrX6uJ3RM3jCnJ8kNr1/GQh972dTMHLq8G4Vq5dF8FhnQ
         +4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686936345; x=1689528345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WOUSqHHDDxpch1TJqgV2f+62UgYbb/xkkpc8zQS/vs=;
        b=eu7lZJTL9t/0chIleH6a4hrwcMIRJGc4JqTEMf+4rshz9ILs9hqCF1k5Hp9ujWxSAA
         b83zK3X26Ue6e4Rs11SByF6rbypVHpXuQtP3eh95XCKGFJdLBCdtCRwTdYssTJIWlzRt
         D55KiIo6cjVe6sNzXbUPzNgovorRlFoeaqQDADaIxAfFv9ZwN72BtYLsn4AZdjnMGceP
         rPYkt9m8us8XTwyh36Jnkcm7f3vu4JoGoUhUrc7yvk8m+GW7fN6rDfh82eg7InoWsIcK
         CORE3hN8LLKxN3kBJNI1HMmGdLgZkWT852PZWifbP6d5dRJapsQzWZMiyy5Rubhl8tj5
         4FyA==
X-Gm-Message-State: AC+VfDz7e6fCGvoIC8QOvBpdUfymp+PbFrrF7pHw9tCqPoY0xbq6VKz0
	++ReUF15fKoGtpC5uVVuuD1RGUlhDr1e82W1UBQ=
X-Google-Smtp-Source: ACHHUZ76xlzfeIwKLiHd4oP1VgbNqo7VJdVDE+Na0RquLFbhBE+9KkeMHfU5owTJOPOpEBg1RGIdzQO0A/bz/v+y62s=
X-Received: by 2002:a17:907:9720:b0:973:df9c:b1aa with SMTP id
 jg32-20020a170907972000b00973df9cb1aamr2509399ejc.71.1686936345410; Fri, 16
 Jun 2023 10:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-3-laoar.shao@gmail.com>
In-Reply-To: <20230612151608.99661-3-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jun 2023 10:25:33 -0700
Message-ID: <CAEf4BzYWMu9LDBewPh+dJ7niCURbSEtdNmDEmAbkrfeBr5QnYw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/10] bpftool: Dump the kernel symbol's
 module name
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> If the kernel symbol is in a module, we will dump the module name as
> well.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
>  tools/bpf/bpftool/xlated_dumper.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated=
_dumper.c
> index da608e1..dd917f3 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -46,7 +46,11 @@ void kernel_syms_load(struct dump_data *dd)
>                 }
>                 dd->sym_mapping =3D tmp;
>                 sym =3D &dd->sym_mapping[dd->sym_count];
> -               if (sscanf(buff, "%p %*c %s", &address, sym->name) !=3D 2=
)
> +
> +               /* module is optional */
> +               sym->module[0] =3D '\0';
> +               if (sscanf(buff, "%p %*c %s %s", &address, sym->name,
> +                   sym->module) < 2)

nit: please keep it single line if it fits in under 100 characters

>                         continue;
>                 sym->address =3D (unsigned long)address;
>                 if (!strcmp(sym->name, "__bpf_call_base")) {
> diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated=
_dumper.h
> index 9a94637..5df8025 100644
> --- a/tools/bpf/bpftool/xlated_dumper.h
> +++ b/tools/bpf/bpftool/xlated_dumper.h
> @@ -5,12 +5,14 @@
>  #define __BPF_TOOL_XLATED_DUMPER_H
>
>  #define SYM_MAX_NAME   256
> +#define MODULE_NAME_LEN        64
>
>  struct bpf_prog_linfo;
>
>  struct kernel_sym {
>         unsigned long address;
>         char name[SYM_MAX_NAME];
> +       char module[MODULE_NAME_LEN];
>  };
>
>  struct dump_data {
> --
> 1.8.3.1
>

