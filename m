Return-Path: <bpf+bounces-1244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4473B7112D3
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D9C2815D6
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A651F944;
	Thu, 25 May 2023 17:51:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2223101DA
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:51:38 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1486189
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:51:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51426347bd2so3903180a12.2
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685037095; x=1687629095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5kdywFlR1cQZ+Yu2yVG1k3GjkogPB3q0665byUTflo=;
        b=jkL5j4OvSpsm5I0XmZKmHHA1Q+yTRcHqMkQbt/STtUesQHRx1VZ+C2gh+Y3M/7CeqU
         GMWDysyqYtvzi4V0d8UYChCcxVWtYYDKEHefPrxsol3y1Dh/OlLlmLoxIpFaV1cEsX32
         sCDiFBP49ayFPFK5xne3FUZ8LGhNW8JZ8wZhYBW1P7tMRoMTXkOgNp1+GuCZiJaJcVWh
         G+8Rjh82wXuTgdr/6A3LoAgmPXAmKFO2fWD5kj37/iNbVrk+wwaT3EH36umNjZvfDdoH
         b+rk4ZpzhvKSUjJeZ3goZrLzrT+eVNhOvzO9NVnSxnpeimfnVQlP1YIzK6p5FgY7/lK8
         rRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685037095; x=1687629095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5kdywFlR1cQZ+Yu2yVG1k3GjkogPB3q0665byUTflo=;
        b=YGgnXwiwlSb+mrMKGN9imrBMkTcLkm0uh8XYRQDdxW0PLGqEgSQgL69+h1DFWatMCB
         EoHiVsJ/4VnXnV5AAImyV1/bToeOZx/zRTxCXSsPzakbpJdppurPBVUhnhAry86OjFW+
         r3jxpvH7ZUE0zOHuwfDMHNEhlONgMVuJFHFPdrqz2pOQqRH6+0Z3mOLmycRXtroAhKsy
         rQ4RqofYF7uxZMmJokpUqDgH6/VXejOWIBFY+eEQtv6clmbJmaubVrOTwezNqP8o25xI
         VyqDVCtPP2RBf/4ThbwPyM4wA4y/uQS3TlEELxkMNdQVyQdAKPjSiHX75e6AjcBOQXtE
         kxQA==
X-Gm-Message-State: AC+VfDzReNslH9k8U61qfve9WPRIRUvt9GZSX2J/7CQ7jVjuQD6JNi8y
	QFt3uSz0AWhz+fA74ZA6lf5fM79PJRRF8nEDEfg=
X-Google-Smtp-Source: ACHHUZ7qgoDmxMulofM1KXkZtL9jwK6IAoavLJHtVgq7N9EjkqSlGtHDfSj9bPoa6A4BK93wvEqM1PVkud9xS8OKlWA=
X-Received: by 2002:a17:907:36c9:b0:953:517a:8f1a with SMTP id
 bj9-20020a17090736c900b00953517a8f1amr2024432ejc.58.1685037095147; Thu, 25
 May 2023 10:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509132433.2FSY_6t7@linutronix.de> <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com> <20230525141813.TFZLWM4M@linutronix.de>
In-Reply-To: <20230525141813.TFZLWM4M@linutronix.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 May 2023 10:51:23 -0700
Message-ID: <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Remove in_atomic() from bpf_link_put().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 25, 2023 at 7:18=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
> invoked within softirq context. By setting rcutree.use_softirq=3D0 boot
> option the RCU callbacks will be invoked in a per-CPU kthread with
> bottom halves disabled which implies a RCU read section.
>
> On PREEMPT_RT the context remains fully preemptible. The RCU read
> section however does not allow schedule() invocation. The latter happens
> in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
> from bpf_link_put().
>
> It was pointed out that the bpf_link_put() invocation should not be
> delayed if originated from close().
>
> Remove the context checks and use the workqueue unconditionally. For the
> close() callback add bpf_link_put_direct() which invokes free function
> directly.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> v1=E2=80=A6v2:
>    - Add bpf_link_put_direct() to be used from bpf_link_release() as
>      suggested.

Looks good to me, but it's not sufficient. See kernel/bpf/inode.c, we
need to do bpf_link_put_direct() from bpf_put_any(), which should be
safe as well because it all is either triggered from bpf() syscall or
by unlink()'ing BPF FS file. For file deletion we have the same
requirement to have deterministic release of bpf_link.

>
> On 2023-05-17 09:26:19 [-0700], Andrii Nakryiko wrote:
> > Is struct file_operations.release() callback guaranteed to be called
> > from user context? If yes, then perhaps the most straightforward way
> > to guarantee synchronous bpf_link cleanup on close(link_fd) is to have
> > a bpf_link_put() variant that will be only called from user-context
> > and will just do bpf_link_free(link) directly, without checking
> > in_atomic().
>
> Yes. __fput() has a might_sleep() and it invokes
> file_operations::release.
>
>  kernel/bpf/syscall.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 14f39c1e573ee..85159428e5fee 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2785,20 +2785,23 @@ void bpf_link_put(struct bpf_link *link)
>         if (!atomic64_dec_and_test(&link->refcnt))
>                 return;
>
> -       if (in_atomic()) {
> -               INIT_WORK(&link->work, bpf_link_put_deferred);
> -               schedule_work(&link->work);
> -       } else {
> -               bpf_link_free(link);
> -       }
> +       INIT_WORK(&link->work, bpf_link_put_deferred);
> +       schedule_work(&link->work);
>  }
>  EXPORT_SYMBOL(bpf_link_put);
>
> +static void bpf_link_put_direct(struct bpf_link *link)
> +{
> +       if (!atomic64_dec_and_test(&link->refcnt))
> +               return;
> +       bpf_link_free(link);
> +}
> +
>  static int bpf_link_release(struct inode *inode, struct file *filp)
>  {
>         struct bpf_link *link =3D filp->private_data;
>
> -       bpf_link_put(link);
> +       bpf_link_put_direct(link);
>         return 0;
>  }
>
> --
> 2.40.1
>

