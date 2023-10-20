Return-Path: <bpf+bounces-12849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132E87D14D7
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1154282468
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D53A20310;
	Fri, 20 Oct 2023 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0SB6J5N"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0A1DA43
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 17:26:30 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D2911B;
	Fri, 20 Oct 2023 10:26:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d834ec222so758671f8f.0;
        Fri, 20 Oct 2023 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697822787; x=1698427587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJSpYiCN3QN/TY7u+xw31FjEI9RUYvZalJzVd9jzlj8=;
        b=M0SB6J5NjitIOCpYq96zx8rLm/tpqEEm8vvNI3Pd5UlcNtCek3EcODBlwf0XELWVYV
         IeHIrq+7RMojG29t37UYz8mlfBabVF+iAEriaX9GQdk3t3AnmqoHPj7TCjtdP9qmtl0S
         LNxxMXPyIurle1mAoZdMhCOZIKFrShrMO6s54SWBIFaLFW/qvJlXsgRMpCe3IQJQYw0A
         oQlEgzh4BkIl4UPoOlLKWWNTHVcKcUIIZ7CWGctt0EecypKRt/jV1XE9r3QF7sa3vX9M
         Q5vqSSsMcMuUaNBDebWCsSdcvO1sYXJkABDNCPznQSR1BfhLcFx8+j2G25gqbGsdP+Qs
         JY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822787; x=1698427587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJSpYiCN3QN/TY7u+xw31FjEI9RUYvZalJzVd9jzlj8=;
        b=NO//8jiyYDoLYXeMZBncLd9XKO0LeuvmUpMc4JXFDdJutf3SiOa+MubLX2oxKHHXiZ
         JkJqJ7Dmm8d7lnDl2cz/lMFm9upsUS6Ks1tkoi3CsmtzURNOzy9KH0NaifEaAHJlhygB
         iHsgrsuaqaaU9ttr0CyxnDnl6/ao+YgElVzraRP2iIUPQkGf/Zdi4hiFReepIqDmPCeI
         DcMoOLNK71tpLLq4rsMdVEvCJXO+xLFB+lGHKOOjoTj5yphhLE14P1fo8PuIdWBcRLgC
         tokQ0wJxnJCWIz3j490sgU2x6aPSBsCx7OaaDTlTCZdMYbdKVMpN/QGnQ4zUvtgFoXAr
         Hykw==
X-Gm-Message-State: AOJu0Yz4FafBfyiIBoYT/ATSzjpZZ6DTjU9rErZKWZHX1/HO6w5161iJ
	ykR9tC/5xACK2OBr/U8e1FYteYY1v3P4EXq8zWM=
X-Google-Smtp-Source: AGHT+IHnR9YY++aPCL+6tLnRr0XZ5JTa8kWa3j20XBlP5u8TMD5HwJ0BPx876YEPZsSsdjOOrqfFT20wA+vsWFp5LK8=
X-Received: by 2002:adf:f0c2:0:b0:32d:ba78:d608 with SMTP id
 x2-20020adff0c2000000b0032dba78d608mr1906451wro.52.1697822786819; Fri, 20 Oct
 2023 10:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020132749.1398012-1-arnd@kernel.org>
In-Reply-To: <20231020132749.1398012-1-arnd@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Oct 2023 10:26:15 -0700
Message-ID: <CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpoR1RQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: hide cgroup functions for configs without cgroups
To: Arnd Bergmann <arnd@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>, Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 6:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When cgroups are disabled, the newly added functions don't build:
>
> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared (f=
irst use in this function)
>   917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>       |              ^~~~~~~~~~~~~~~~~~~
> kernel/bpf/task_iter.c:925:60: error: invalid application of 'sizeof' to =
incomplete type 'struct css_task_iter'
>   925 |         kit->css_it =3D bpf_mem_alloc(&bpf_global_ma, sizeof(stru=
ct css_task_iter));
>       |                                                            ^~~~~~
>
> Hide them in an #ifdef section.
>
> Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator kfuncs=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/bpf/task_iter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 654601dd6b493..15a184f4f954d 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -904,6 +904,7 @@ __diag_push();
>  __diag_ignore_all("-Wmissing-prototypes",
>                   "Global functions as their definitions will be in vmlin=
ux BTF");
>
> +#ifdef CONFIG_CGROUPS
>  __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>                 struct cgroup_subsys_state *css, unsigned int flags)
>  {
> @@ -947,6 +948,7 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf=
_iter_css_task *it)
>         css_task_iter_end(kit->css_it);
>         bpf_mem_free(&bpf_global_ma, kit->css_it);
>  }
> +#endif

Did you actually test build it without cgroups and with bpf+btf?
I suspect the resolve_btfid step should be failing the build.
It needs
#ifdef CONFIG_CGROUPS
around BTF_ID_FLAGS(func, bpf_iter_css_task*

