Return-Path: <bpf+bounces-6547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044DD76B3E9
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 13:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272201C20CA6
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F110214F3;
	Tue,  1 Aug 2023 11:53:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3020FA4
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 11:53:54 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D8AA1
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 04:53:52 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6378cec43ddso28864486d6.2
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 04:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690890832; x=1691495632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA3UwUNKJ2zMMfjvUmDipgclPocbnjFFbuAeLe+WgNw=;
        b=ZjDg2skFxSzjB4ed/MnDMp89l54PJEX3jEQrcWUuvfDJszbxtmh+y6N+MZh/frp6I0
         YMN36nsY0H+xxVwGUJEo1JwtcbUy/wSWJH00cS8YsZPloWzkgPM9ioVgs4JGehj9igXY
         H334aiUup8JBkqRvPgAvKaRTSbRq9yKrZtyKKTM6IYKgoEDGJjvPsReJoW+AP0ROhT9p
         Hk2bxv3vNjpUGkkKbfreMI8H/0sPmGDfF+XUTAXFBB0jhRtCN2odO1FwZAHQdZ/ZnxvI
         umPM6IGeoi9RRqX3S/r73T1m3CEon4nwsuJJSGPdX4MzYyzRyNZJMmax4JIZqW7Ad+ZY
         p+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690890832; x=1691495632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eA3UwUNKJ2zMMfjvUmDipgclPocbnjFFbuAeLe+WgNw=;
        b=SCNZ3kJpUbFtpbJj5YjlmrYHNWdkJ1JZhyah7ZZoUJ7wFC9IxjeBgb1O48xADyE2JU
         x9WZ0RD+CZVCK840tXgDfBFzWWin3xnVCRu0S0MliksrEieozOpWZoDomtxfMIBHO4kT
         hVdiT045L2R87z/Fs3je+bCxNs0Ab9R33yzDlaDGJDMQHmElyc4DOPF9uBzNc7H1KfbR
         LQUpGVrGkF3JSI8XPKQQh/0byj2NdjR7B7xkS1vzFoZCy4sknqfWPz730FWbdbp2DxRh
         4v04z0/6Vo5zWhmWboszh49ty5Eu5ZgK3aa9idP8Fb3TDdyheNRzJi0TYV589i3tlDcB
         QrJg==
X-Gm-Message-State: ABy/qLa9/H1pjMBpZQa6mTK7SGXiSWFZn5NTUh07Fh0vVhu2nXHb1vN+
	vQqqYjUG/dxX26DEk+bPnCt6jZ9zESUoHqvORbU=
X-Google-Smtp-Source: APBJJlHWSswHyuFpFhF6b+uhXitaYiDeg1hFQPFXO15rr+T5ZlslUjKFJoLSsEfqAhXvO6UYkSErEAqmn0xtGEiYcrc=
X-Received: by 2002:a05:6214:1395:b0:63c:f8d2:8b3f with SMTP id
 pp21-20020a056214139500b0063cf8d28b3fmr11087560qvb.44.1690890831678; Tue, 01
 Aug 2023 04:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801073002.1006443-1-jolsa@kernel.org> <20230801073002.1006443-2-jolsa@kernel.org>
In-Reply-To: <20230801073002.1006443-2-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 1 Aug 2023 19:53:15 +0800
Message-ID: <CALOAHbDdurfzh7jRfqWVVS5RFRT44fx3zjQRNN8B66HJDNogAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add support for bpf_get_func_ip helper
 for uprobe program
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 3:30=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for bpf_get_func_ip helper for uprobe program to return
> probed address for both uprobe and return uprobe.
>
> We discussed this in [1] and agreed that uprobe can have special use
> of bpf_get_func_ip helper that differs from kprobe.
>
> The kprobe bpf_get_func_ip returns:
>   - address of the function if probe is attach on function entry
>     for both kprobe and return kprobe
>   - 0 if the probe is not attach on function entry
>
> The uprobe bpf_get_func_ip returns:
>   - address of the probe for both uprobe and return uprobe
>
> The reason for this semantic change is that kernel can't really tell
> if the probe user space address is function entry.
>
> The uprobe program is actually kprobe type program attached as uprobe.
> One of the consequences of this design is that uprobes do not have its
> own set of helpers, but share them with kprobes.
>
> As we need different functionality for bpf_get_func_ip helper for uprobe,
> I'm adding the bool value to the bpf_trace_run_ctx, so the helper can
> detect that it's executed in uprobe context and call specific code.
>
> The is_uprobe bool is set as true in bpf_prog_run_array_sleepable which
> is currently used only for executing bpf programs in uprobe.

That is error-prone.  If we don't intend to rename
bpf_prog_run_array_sleepable() to bpf_prog_run_array_uprobe(), I think
we'd better introduce a new parameter 'bool is_uprobe' into it.

>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> [1] https://lore.kernel.org/bpf/CAEf4BzZ=3DxLVkG5eurEuvLU79wAMtwho7ReR+XJ=
AgwhFF4M-7Cg@mail.gmail.com/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h            |  5 +++++
>  include/uapi/linux/bpf.h       |  7 ++++++-
>  kernel/trace/bpf_trace.c       | 21 ++++++++++++++++++++-
>  kernel/trace/trace_probe.h     |  5 +++++
>  kernel/trace/trace_uprobe.c    |  5 -----
>  tools/include/uapi/linux/bpf.h |  7 ++++++-
>  6 files changed, 42 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ceaa8c23287f..8ea071383ef1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1819,6 +1819,7 @@ struct bpf_cg_run_ctx {
>  struct bpf_trace_run_ctx {
>         struct bpf_run_ctx run_ctx;
>         u64 bpf_cookie;
> +       bool is_uprobe;
>  };
>
>  struct bpf_tramp_run_ctx {
> @@ -1867,6 +1868,8 @@ bpf_prog_run_array(const struct bpf_prog_array *arr=
ay,
>         if (unlikely(!array))
>                 return ret;
>
> +       run_ctx.is_uprobe =3D false;
> +
>         migrate_disable();
>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>         item =3D &array->items[0];
> @@ -1906,6 +1909,8 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_=
array __rcu *array_rcu,
>         rcu_read_lock_trace();
>         migrate_disable();
>
> +       run_ctx.is_uprobe =3D true;
> +
>         array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_he=
ld());
>         if (unlikely(!array))
>                 goto out;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 70da85200695..d21deb46f49f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5086,9 +5086,14 @@ union bpf_attr {
>   * u64 bpf_get_func_ip(void *ctx)
>   *     Description
>   *             Get address of the traced function (for tracing and kprob=
e programs).
> + *
> + *             When called for kprobe program attached as uprobe it retu=
rns
> + *             probe address for both entry and return uprobe.
> + *
>   *     Return
> - *             Address of the traced function.
> + *             Address of the traced function for kprobe.
>   *             0 for kprobes placed within the function (not at the entr=
y).
> + *             Address of the probe for uprobe and return uprobe.
>   *
>   * u64 bpf_get_attach_cookie(void *ctx)
>   *     Description
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c92eb8c6ff08..7930a91ca7f3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1057,9 +1057,28 @@ static unsigned long get_entry_ip(unsigned long fe=
ntry_ip)
>  #define get_entry_ip(fentry_ip) fentry_ip
>  #endif
>
> +#ifdef CONFIG_UPROBES
> +static unsigned long bpf_get_func_ip_uprobe(struct pt_regs *regs)
> +{
> +       struct uprobe_dispatch_data *udd;
> +
> +       udd =3D (struct uprobe_dispatch_data *) current->utask->vaddr;
> +       return udd->bp_addr;
> +}
> +#else
> +#define bpf_get_func_ip_uprobe(regs) (u64) -1
> +#endif
> +
>  BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
>  {
> -       struct kprobe *kp =3D kprobe_running();
> +       struct bpf_trace_run_ctx *run_ctx;
> +       struct kprobe *kp;
> +
> +       run_ctx =3D container_of(current->bpf_ctx, struct bpf_trace_run_c=
tx, run_ctx);
> +       if (run_ctx->is_uprobe)
> +               return bpf_get_func_ip_uprobe(regs);
> +
> +       kp =3D kprobe_running();
>
>         if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
>                 return 0;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 01ea148723de..7dde806be91e 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -519,3 +519,8 @@ void __trace_probe_log_err(int offset, int err);
>
>  #define trace_probe_log_err(offs, err) \
>         __trace_probe_log_err(offs, TP_ERR_##err)
> +
> +struct uprobe_dispatch_data {
> +       struct trace_uprobe     *tu;
> +       unsigned long           bp_addr;
> +};
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 555c223c3232..fc76c3985672 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -88,11 +88,6 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn=
_event *ev)
>  static int register_uprobe_event(struct trace_uprobe *tu);
>  static int unregister_uprobe_event(struct trace_uprobe *tu);
>
> -struct uprobe_dispatch_data {
> -       struct trace_uprobe     *tu;
> -       unsigned long           bp_addr;
> -};
> -
>  static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs=
 *regs);
>  static int uretprobe_dispatcher(struct uprobe_consumer *con,
>                                 unsigned long func, struct pt_regs *regs)=
;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 70da85200695..d21deb46f49f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5086,9 +5086,14 @@ union bpf_attr {
>   * u64 bpf_get_func_ip(void *ctx)
>   *     Description
>   *             Get address of the traced function (for tracing and kprob=
e programs).
> + *
> + *             When called for kprobe program attached as uprobe it retu=
rns
> + *             probe address for both entry and return uprobe.
> + *
>   *     Return
> - *             Address of the traced function.
> + *             Address of the traced function for kprobe.
>   *             0 for kprobes placed within the function (not at the entr=
y).
> + *             Address of the probe for uprobe and return uprobe.
>   *
>   * u64 bpf_get_attach_cookie(void *ctx)
>   *     Description
> --
> 2.41.0
>
>


--=20
Regards
Yafang

