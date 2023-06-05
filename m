Return-Path: <bpf+bounces-1891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60460723372
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 01:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C152813A2
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732C2773D;
	Mon,  5 Jun 2023 23:00:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5906437F
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 23:00:32 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6E683;
	Mon,  5 Jun 2023 16:00:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1b3836392so45394011fa.0;
        Mon, 05 Jun 2023 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686006028; x=1688598028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufUMgXtKZskJ5A1Ms0gGQgSBIIEscNczMp6djc5L6sc=;
        b=FbUq4NSQKDq/C6PoerANuzeaN7LYA6UqpfUoV/dbjQN+M0bB7VCt7vO5Ab363b0ty7
         VTtF/z58p/GyHmdHtnVulRlxLiOmlAbH/nFPYUJFF4QKRH4jTLF9QjLwXT50i1i+8okd
         K4DGD8enfm67Iy71CfZ6WZys8ZJrvhS+/nhjOf+/peU9C2RLZsk6yAfbWHjC2qExPFZb
         rhRK2oYyTM+vG5yAP0WoYegRhF3QwZ+zgNXIT8kIgrPkygbmew8TCrjtHWffJHgyr99w
         7y1g8ZrF85X1cAEoW106MXGF4Jbz7IHQ6SlwLtMH1afbkQHdcBzwO3C7+/YOkuzpnyBH
         8Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006028; x=1688598028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufUMgXtKZskJ5A1Ms0gGQgSBIIEscNczMp6djc5L6sc=;
        b=DUcE+zuTbE4fVO+J/DXuVU3qwzfI+KR/U+JO/oMxjcSHzEJM2XUeaFveP9CCnrcqip
         KFwLit7UIYdrDntKLTnStU0EQ+epv0VTT56ECU8pCguvFnErqhyqS7sxTk9K5J6h2KUu
         sR4mri3q8uJP4VCtFW+eIsXb08Z/4/Eod1/UT7Caw37dd1rWlIrT/BGC4pabB5s1PZOj
         aCP8QIcdTiT8FmencxOi8PR0yP3+A/x42ze9nk0s8mwcuphL2sqao3wwFCga5iUkf4oD
         93NrOvv3qUZg2aHZ0eDqD0VqSlpyRg0//fzBdZMg+nkN80rO0PKftrNEMSdK5Z1UKxgr
         g/nQ==
X-Gm-Message-State: AC+VfDy6ww7XyATJEJIRQxNpHx3xwZj9FALOfin98wtycilCVDabFRRV
	MTbnnbljbHUhX+Wj0LSZXDMtGztyvfrNCniI86A=
X-Google-Smtp-Source: ACHHUZ7UODwgfcxEHtXxNP940FZn6CFy8HtE6ntDyqUp40bA7/MRBwmux0XrhDwFVHsf32H+Rj9JalMKk6nNln78UB4=
X-Received: by 2002:a2e:9884:0:b0:2b1:a8b9:4543 with SMTP id
 b4-20020a2e9884000000b002b1a8b94543mr350270ljj.53.1686006028367; Mon, 05 Jun
 2023 16:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230604140103.3542071-1-jolsa@kernel.org>
In-Reply-To: <20230604140103.3542071-1-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jun 2023 16:00:16 -0700
Message-ID: <CAADnVQJNKu=57nu6dd_jGR9ypT4R4cAUppz02XBiU8RnLxF7Bw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Add extra path pointer check to d_path helper
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, stable <stable@vger.kernel.org>, 
	Anastasios Papagiannis <tasos.papagiannnis@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
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

On Sun, Jun 4, 2023 at 7:01=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Anastasios reported crash on stable 5.15 kernel with following
> bpf attached to lsm hook:
>
>   SEC("lsm.s/bprm_creds_for_exec")
>   int BPF_PROG(bprm_creds_for_exec, struct linux_binprm *bprm)
>   {
>           struct path *path =3D &bprm->executable->f_path;
>           char p[128] =3D { 0 };
>
>           bpf_d_path(path, p, 128);
>           return 0;
>   }
>
> but bprm->executable can be NULL, so bpf_d_path call will crash:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000018
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
>   ...
>   RIP: 0010:d_path+0x22/0x280
>   ...
>   Call Trace:
>    <TASK>
>    bpf_d_path+0x21/0x60
>    bpf_prog_db9cf176e84498d9_bprm_creds_for_exec+0x94/0x99
>    bpf_trampoline_6442506293_0+0x55/0x1000
>    bpf_lsm_bprm_creds_for_exec+0x5/0x10
>    security_bprm_creds_for_exec+0x29/0x40
>    bprm_execve+0x1c1/0x900
>    do_execveat_common.isra.0+0x1af/0x260
>    __x64_sys_execve+0x32/0x40
>
> It's problem for all stable trees with bpf_d_path helper, which was
> added in 5.9.
>
> This issue is fixed in current bpf code, where we identify and mark
> trusted pointers, so the above code would fail to load.
>
> For the sake of the stable trees and to workaround potentially broken
> verifier in the future, adding the code that reads the path object from
> the passed pointer and verifies it's valid in kernel space.
>
> Cc: stable@vger.kernel.org # v5.9+
> Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Reported-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9a050e36dc6c..aecd98ee73dc 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -900,12 +900,22 @@ static const struct bpf_func_proto bpf_send_signal_=
thread_proto =3D {
>
>  BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
>  {
> +       struct path copy;
>         long len;
>         char *p;
>
>         if (!sz)
>                 return 0;
>
> +       /*
> +        * The path pointer is verified as trusted and safe to use,
> +        * but let's double check it's valid anyway to workaround
> +        * potentially broken verifier.
> +        */
> +       len =3D copy_from_kernel_nofault(&copy, path, sizeof(*path));
> +       if (len < 0)
> +               return len;
> +
>         p =3D d_path(path, buf, sz);

Since we copied it anyway, let's use a stable copy here?
Otherwise somebody might send a patch to remove 'dead code'.

