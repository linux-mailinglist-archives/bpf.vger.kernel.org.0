Return-Path: <bpf+bounces-3314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E973C0A6
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536BE1C21269
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A399125AC;
	Fri, 23 Jun 2023 20:41:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E211C80
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 20:41:15 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B8E3581
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f85966b0f2so1430211e87.3
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687552834; x=1690144834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xq+QigqaVlmFs9LNTCva+bf+6IT+yPBTC3it02pSumg=;
        b=jDh/cWA2fEB3urTbsde7uXfsF395XdNqGzAonuffOPiEST+FZO6KvIkprPune0RvZg
         2wIP/8/WQsPL+FS59QOgZyMY7sEN90FNPSDOqPL4eFgilI4hJ+D8gmmxVoEV0EUxlfwd
         5TLPyuSYHzOr+VviZSBAuz3n6Gj6Eg0blRnqa+h7Z2e64JkXDacxvyqILojp21l3Q90d
         tBcbQnvIuhzFR54jE91NjddmMY/Vyzxa9hv+b8fD7ERCFHUOqR73ifUwLxlgTLmyX9yu
         xh2pYImFthTH1wMfeMl1zEQ3d3cy+LW2bfI2rwNgUEm8guHSPByP9MyxmE3devRLD4J8
         FdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552834; x=1690144834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq+QigqaVlmFs9LNTCva+bf+6IT+yPBTC3it02pSumg=;
        b=dBtvUDTOv+VKrx8MSwRkUp+n52U4HC6oT8bx+dVK2hdky3DEicWRFDbrTLmt7SmMF2
         gLwIr7cTMqpqkRe2EaARGFsyBNZ3Ia7XWH9L6hmIuT6RLSoacKQPmLclzpVskh3v+adX
         8xzPibh7MCWM6e/wGZs3Mg0b7BT+d69JoCp83wvRl1FwItQgINK83wodSKKljA0PH2fP
         oBfCy/zr3bEXaQmDPRMLAYv3fWsvxC8J+/POWLAYUb2UmIXR6dYixY3tT7ciXG5E8BIc
         pD4nTEsqxwoRBIXy82HevkhwQtlKCnKE1h6xhbRSSNf/0Fts1oibeKcMiHGPPSeyhzMA
         jwtw==
X-Gm-Message-State: AC+VfDyVzNLyz9gaI2cdUf60vfWMUpiQWwGnrDwgplt0IiP5AswoL9WF
	nUBSCZD/IKPGPhsyfqc94XkI5IxMqd+CNgWoZns=
X-Google-Smtp-Source: ACHHUZ7ltjnzNubfd/32Y8/i1wipONjAh87pdIuvZEgichcI4L164VX2cyYUURZ4LtxjWM5SYb9bCouQjoMksuJfKPg=
X-Received: by 2002:a05:6512:3284:b0:4f8:692a:6492 with SMTP id
 p4-20020a056512328400b004f8692a6492mr12096421lfe.32.1687552834285; Fri, 23
 Jun 2023 13:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-14-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-14-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 13:40:20 -0700
Message-ID: <CAEf4BzZpq96QUsWitv+TBuaE2ehy0PKuEvq0rYgjOQj6jegTGQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 13/24] libbpf: Add uprobe multi link detection
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

On Tue, Jun 20, 2023 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe-multi link detection. It will be used later in
> bpf_program__attach_usdt function to check and use uprobe_multi
> link over standard uprobe links.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c          | 29 +++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  2 files changed, 31 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e42080258ec7..3d570898459e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4815,6 +4815,32 @@ static int probe_perf_link(void)
>         return link_fd < 0 && err =3D=3D -EBADF;
>  }
>
> +static int probe_uprobe_multi_link(void)
> +{
> +       struct bpf_insn insns[] =3D {
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       int prog_fd, link_fd, err;
> +
> +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
> +                               insns, ARRAY_SIZE(insns), NULL);

I thought we needed to specify expected_attach_type (BPF_TRACE_UPROBE_MULTI=
)?

> +       if (prog_fd < 0)
> +               return -errno;
> +
> +       /* No need to specify attach function. If the link is not support=
ed
> +        * we will get -EOPNOTSUPP error before any other check is perfor=
med.

what will actually return this -EOPNOTSUPP? I couldn't find this in
the code quickly, can you please point me where?

> +        */
> +       link_fd =3D bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, =
NULL);
> +       err =3D -errno; /* close() can clobber errno */
> +
> +       if (link_fd >=3D 0)
> +               close(link_fd);
> +       close(prog_fd);
> +
> +       return link_fd < 0 && err !=3D -EOPNOTSUPP;
> +}
> +
>  static int probe_kern_bpf_cookie(void)
>  {
>         struct bpf_insn insns[] =3D {
> @@ -4911,6 +4937,9 @@ static struct kern_feature_desc {
>         [FEAT_SYSCALL_WRAPPER] =3D {
>                 "Kernel using syscall wrapper", probe_kern_syscall_wrappe=
r,
>         },
> +       [FEAT_UPROBE_LINK] =3D {
> +               "BPF uprobe multi link support", probe_uprobe_multi_link,
> +       },
>  };
>
>  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 22b0834e7fe1..a257eb81af25 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -354,6 +354,8 @@ enum kern_feature_id {
>         FEAT_BTF_ENUM64,
>         /* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPPER) =
*/
>         FEAT_SYSCALL_WRAPPER,
> +       /* BPF uprobe_multi link support */
> +       FEAT_UPROBE_LINK,

UPROBE_MULTI_LINK, we might have non-multi link in the future as well

>         __FEAT_CNT,
>  };


>
> --
> 2.41.0
>

