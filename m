Return-Path: <bpf+bounces-4708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F674E482
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14AA1C20CFA
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 02:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F54210D;
	Tue, 11 Jul 2023 02:56:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BCA7F
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:56:42 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D4E4B
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 19:56:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so79802191fa.3
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 19:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689044200; x=1691636200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLXkiTUiFKf75LmozqRrPjFkWO+v3ABTl3MSi35FjIM=;
        b=I8c9/c2WV8vZP8lTmLdDBcpSm/NMES7xdWVO35rao1AH6htnoxP8ndD3/3eOPW46gD
         fjutUmonEmFJTz9w7dTYsV0bAp4eXR6NnR/tS9grRoW3EMCaocVK9jaZQU4l5z57bh1p
         6skkfX3Vsul1Ihe3pa3ll5cu/h0u+Phygu8m2yPAJ1kWmoc91XKCfCGN7A7ulms/DRez
         OMzsbXVmwDRtVPhFG3JIktYSW+sSMzlWqOYLdO1AtI0jVSocYIgPmX0ZVTIv1IJUcNkB
         rrHqffIyza9Mx0laiszNkZdYKfmxedz4kTl3Jetkjm2KH2fU7YZZHX3DgnJh1n+F2rSw
         FvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689044200; x=1691636200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLXkiTUiFKf75LmozqRrPjFkWO+v3ABTl3MSi35FjIM=;
        b=RC0h18zCPpAJzYqWSlRqNrGykaF7Tx0ruoXUfjWpzGMr83yxYtO4hGPD1ZUJwkyk59
         ZbBcsCCVZ3INz0gomaeFeMyoh/XUSER2fbdJmpMLNPoLndH6u7rN+pABcWdilFIshHTK
         9IhbZwe/pRnRPT+TSUNC7utbw5yVgMsigutg0BDozCOmBt0iTUkLJj8OjKN3W1Vj00IP
         NcvkK8qmPLJrpZqhO1QuFiMmbkrE3kIlut3cRm/lgRdhXUu871Unxr8Z7rIKP5MJKqZo
         gmtgrUcUDpubMlDqj5hKlmJRDJvzo5kO4puNR5FjBE5f3qBraH3FmcpgX/FFYTCFRvg+
         F6sQ==
X-Gm-Message-State: ABy/qLZ/hef35gjiRFHWr77JPrwdksoGRzNyQDxgUJ1Xdv4hheKLePw+
	TEmie/n+fPNJjW5nNceUO9DMRDNcW3shkRHdMS0=
X-Google-Smtp-Source: APBJJlHoUfVRcqj5tF0073v/AMgyZc82JvcZuChXJsSiIebOs4mxcviiSLMdqNH6W9jUORL2E43v+o3hS2eh1MTSutU=
X-Received: by 2002:a2e:b0c6:0:b0:2b6:a7dd:e22 with SMTP id
 g6-20020a2eb0c6000000b002b6a7dd0e22mr11660685ljl.48.1689044199713; Mon, 10
 Jul 2023 19:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230709025912.3837-1-laoar.shao@gmail.com> <20230709025912.3837-4-laoar.shao@gmail.com>
In-Reply-To: <20230709025912.3837-4-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 19:56:28 -0700
Message-ID: <CAADnVQLUY4tb2s-tzSuxO5_8g3PAqnq_a-LwswPqxNL7=qLHBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: Fix an error in verifying a field in a union
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 8, 2023 at 7:59=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> We are utilizing BPF LSM to monitor BPF operations within our container
> environment. When we add support for raw_tracepoint, it hits below
> error.
>
> ; (const void *)attr->raw_tracepoint.name);
> 27: (79) r3 =3D *(u64 *)(r2 +0)
> access beyond the end of member map_type (mend:4) in struct (anon) with o=
ff 0 size 8
>
> It can be reproduced with below BPF prog.
>
> SEC("lsm/bpf")
> int BPF_PROG(bpf_audit, int cmd, union bpf_attr *attr, unsigned int size)
> {
>         switch (cmd) {
>         case BPF_RAW_TRACEPOINT_OPEN:
>                 bpf_printk("raw_tracepoint is %s", attr->raw_tracepoint.n=
ame);
>                 break;
>         default:
>                 break;
>         }
>         return 0;
> }
>
> The reason is that when accessing a field in a union, such as bpf_attr,
> if the field is located within a nested struct that is not the first
> member of the union, it can result in incorrect field verification.
>
>   union bpf_attr {
>       struct {
>           __u32 map_type; <<<< Actually it will find that field.
>           __u32 key_size;
>           __u32 value_size;
>          ...
>       };
>       ...
>       struct {
>           __u64 name;    <<<< We want to verify this field.
>           __u32 prog_fd;
>       } raw_tracepoint;
>   };
>
> Considering the potential deep nesting levels, finding a perfect
> solution to address this issue has proven challenging. Therefore, I
> propose a solution where we simply skip the verification process if the
> field in question is located within a union.
>
> Fixes: 7e3617a72df3 ("bpf: Add array support to btf_struct_access")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index fae6fc24a845..a542760c807a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6368,7 +6368,7 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
>                  * that also allows using an array of int as a scratch
>                  * space. e.g. skb->cb[].
>                  */
> -               if (off + size > mtrue_end) {
> +               if (off + size > mtrue_end && !(*flag & PTR_UNTRUSTED)) {

The selftest for this condition is missing.

