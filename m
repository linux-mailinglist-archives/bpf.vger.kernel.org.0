Return-Path: <bpf+bounces-3639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0932740B2C
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 10:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F132811E6
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8006FAD;
	Wed, 28 Jun 2023 08:23:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFEF63C9
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 08:23:00 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB1D2D73;
	Wed, 28 Jun 2023 01:22:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7659dc74d91so364735385a.0;
        Wed, 28 Jun 2023 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687940577; x=1690532577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPlJ3d55zkkCE0158NpdPdIacPtyKpxD+77cxWNgQn4=;
        b=B/FZcfHwfA80FMXQD1r+by4GfJ0G7ym+e7/y8s8Dee0ja1UvDXu8hKfBtvH2b7omy4
         iT2OS4wkVrFBsCEOfq2lPYFeWGMp25v0lOosQ2FsDX90HXA1RCJikhqpyOYR57VSWCYU
         HUZkoJEPXkhwug4GOxIrQue/HFohjUSoIXllRFpNNsKQL73oNgrsqCPqjIbezwC8i8cz
         hwQQYWWOBblL/zFLWntF32HtInNOxKnpqM5HAlqh5Rip8WXlQLddiQTz7HqF03uRQsJz
         LC0xfiBf+i0vX0VrRdbjeFnHtWDtSe0L1JFNnd9Icg+eOK0964Pc+8KNOR5dv3Pqy1Dc
         vfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940577; x=1690532577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPlJ3d55zkkCE0158NpdPdIacPtyKpxD+77cxWNgQn4=;
        b=MjWxZTrHLVlxW/2+31BV5YYgeh7oVR6QRM/zd/g/bIQ+UfSOIYMTIV39niaVN6XXVe
         NWGyBT+c62OL+iMLLGWpxdK1hMD8rkvIMtUWCleKBUzpWqHADqgOqsgy8zK6UHTcti8o
         4d2otioCSEu0g6YPvpl57iOTaFibLciu5nbH55Tvcu9wNdrZkOvxHbdULWO88bt8j3QG
         xY8ba3h8/Gj694q+7nJm2MC/9ZzB2wDOgn2BqjatdIyLp52qMX7XhGbrvP8sQdflynnR
         gOHUKsqjkx3CGoLQmY3dvya1h2WAesCM4OR7r2UZzq7E9auLXtyPHNpF2hGXYmMsHmXw
         7lbA==
X-Gm-Message-State: AC+VfDxgAqpqcbeVeYXKl8wLVUIXm6ndDily+hDmJyUDfkbRcha7HASc
	uXMfeUsYiqFEJrWGOzhWWWBv9kcHvUyOCuONdZOcV19vzStasQ==
X-Google-Smtp-Source: ACHHUZ4SZINxUDCT1VOxGKSGnyrORp5xMAlVWVYZ4VVr9D12NJWQpx1JwNxevKpURs5vLH73EZrUYAMXE2UkZpD5Us8=
X-Received: by 2002:a05:6214:2524:b0:5f4:5af6:1304 with SMTP id
 gg4-20020a056214252400b005f45af61304mr36084024qvb.16.1687936643694; Wed, 28
 Jun 2023 00:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517034510.15639-1-zegao@tencent.com> <20230517034510.15639-3-zegao@tencent.com>
In-Reply-To: <20230517034510.15639-3-zegao@tencent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 28 Jun 2023 15:16:47 +0800
Message-ID: <CALOAHbC6UpfFOOibdDiC7xFc5YFUgZnk3MZ=3Ny6we=AcrNbew@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] fprobe: make fprobe_kprobe_handler recursion free
To: Ze Gao <zegao2021@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 11:45=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrote=
:
>
> Current implementation calls kprobe related functions before doing
> ftrace recursion check in fprobe_kprobe_handler, which opens door
> to kernel crash due to stack recursion if preempt_count_{add, sub}
> is traceable in kprobe_busy_{begin, end}.
>
> Things goes like this without this patch quoted from Steven:
> "
> fprobe_kprobe_handler() {
>    kprobe_busy_begin() {
>       preempt_disable() {
>          preempt_count_add() {  <-- trace
>             fprobe_kprobe_handler() {
>                 [ wash, rinse, repeat, CRASH!!! ]
> "
>
> By refactoring the common part out of fprobe_kprobe_handler and
> fprobe_handler and call ftrace recursion detection at the very beginning,
> the whole fprobe_kprobe_handler is free from recursion.
>
> Signed-off-by: Ze Gao <zegao@tencent.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-3-ze=
gao@tencent.com
> ---
>  kernel/trace/fprobe.c | 59 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 9abb3905bc8e..097c740799ba 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -20,30 +20,22 @@ struct fprobe_rethook_node {
>         char data[];
>  };
>
> -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> -                          struct ftrace_ops *ops, struct ftrace_regs *fr=
egs)
> +static inline void __fprobe_handler(unsigned long ip, unsigned long
> +               parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fr=
egs)
>  {
>         struct fprobe_rethook_node *fpr;
>         struct rethook_node *rh =3D NULL;
>         struct fprobe *fp;
>         void *entry_data =3D NULL;
> -       int bit, ret;
> +       int ret;
>
>         fp =3D container_of(ops, struct fprobe, ops);
> -       if (fprobe_disabled(fp))
> -               return;
> -
> -       bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> -       if (bit < 0) {
> -               fp->nmissed++;
> -               return;
> -       }
>
>         if (fp->exit_handler) {
>                 rh =3D rethook_try_get(fp->rethook);
>                 if (!rh) {
>                         fp->nmissed++;
> -                       goto out;
> +                       return;
>                 }
>                 fpr =3D container_of(rh, struct fprobe_rethook_node, node=
);
>                 fpr->entry_ip =3D ip;
> @@ -61,23 +53,60 @@ static void fprobe_handler(unsigned long ip, unsigned=
 long parent_ip,
>                 else
>                         rethook_hook(rh, ftrace_get_regs(fregs), true);
>         }
> -out:
> +}
> +
> +static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> +               struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +       struct fprobe *fp;
> +       int bit;
> +
> +       fp =3D container_of(ops, struct fprobe, ops);
> +       if (fprobe_disabled(fp))
> +               return;
> +
> +       /* recursion detection has to go before any traceable function an=
d
> +        * all functions before this point should be marked as notrace
> +        */
> +       bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> +       if (bit < 0) {
> +               fp->nmissed++;
> +               return;
> +       }
> +       __fprobe_handler(ip, parent_ip, ops, fregs);
>         ftrace_test_recursion_unlock(bit);
> +
>  }
>  NOKPROBE_SYMBOL(fprobe_handler);
>
>  static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent=
_ip,
>                                   struct ftrace_ops *ops, struct ftrace_r=
egs *fregs)
>  {
> -       struct fprobe *fp =3D container_of(ops, struct fprobe, ops);
> +       struct fprobe *fp;
> +       int bit;
> +
> +       fp =3D container_of(ops, struct fprobe, ops);
> +       if (fprobe_disabled(fp))
> +               return;
> +
> +       /* recursion detection has to go before any traceable function an=
d
> +        * all functions called before this point should be marked as not=
race
> +        */
> +       bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> +       if (bit < 0) {
> +               fp->nmissed++;
> +               return;
> +       }
>
>         if (unlikely(kprobe_running())) {
>                 fp->nmissed++;

I have just looked through this patchset, just out of curiosity,
shouldn't we call ftrace_test_recursion_unlock(bit) here ?
We have already locked it successfully, so why should we not unlock it?

>                 return;
>         }
> +
>         kprobe_busy_begin();
> -       fprobe_handler(ip, parent_ip, ops, fregs);
> +       __fprobe_handler(ip, parent_ip, ops, fregs);
>         kprobe_busy_end();
> +       ftrace_test_recursion_unlock(bit);
>  }
>
>  static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> --
> 2.40.1
>
>


--=20
Regards
Yafang

