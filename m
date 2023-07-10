Return-Path: <bpf+bounces-4649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A91B274E0F7
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 00:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8FA1C20B9E
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F616430;
	Mon, 10 Jul 2023 22:23:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C4156CD;
	Mon, 10 Jul 2023 22:23:33 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184A197;
	Mon, 10 Jul 2023 15:23:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so7422860e87.3;
        Mon, 10 Jul 2023 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689027810; x=1691619810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aC5j+4htVlsymnJcEKPXKllCMhmhfroAZbbpDtPHC8=;
        b=Zyl/4HO2Ne5t2DhjrqWBoFuYOrKHSWz0Lw771twH/TmMn7zv8lW5iUh35uhhWya1L1
         /5GIumtcaWqd4nooQ4nnRdY7Z7jxFf/v6Enq5yvN/f9/1pjv7JPQVloE1XgQ54dpiIay
         lguZHH8XazPn8EnylQPHy4ZUKJqZP38ZBGQp2MSsD4SLgtfjwF71lTdn0Cr9CisnBu28
         RX6dRsaoQB9rCf9EA1BWxXTbC7Ji1pBxIVpFPxk3d5g1ICDYnPcH1pJt6nUrWFLqS777
         8TbZsouhMQHYRs93lViWXY1HeokmlxrLbUhOSJU3GIKSccPAScQNNAMyx9/dIEetZ6AB
         Ovxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689027810; x=1691619810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aC5j+4htVlsymnJcEKPXKllCMhmhfroAZbbpDtPHC8=;
        b=N5XAfhWt9/DX6eg507HKb++UOkFaJWsyIhdYIJEZ28qf05nOVjlcsm7rvAmHg+bQ8G
         E9LL0hiikZ03KvBNdjjnlIgrCEDl4nmrKIfmUu2dEsikIU+JnfoHsY/mNqu3fe0XZOmf
         GM9hRxFpkQDazHau6Xt72+jlXSKIHkviLQkrCz7EWPJ5mb/Zfscq65oqumVn7qPKFZCE
         1NAIwEbX6o2D1EATA1lqN+wV7Tf3z/Fib1Q92fvyFpJmHxB+DkZTOhlQl5SV8LNJ6YvK
         QNqKidNJ70Qw8spNLXGqimuttqPu/0YNulwNUvEM/B2SHvwh1oxRPniVkMVQ9zcFIYxn
         w+AQ==
X-Gm-Message-State: ABy/qLZ/WXhfr66hmWwywispFAuficw1WogLMwk6m5jh8xW5KQok50qF
	3JYgj05t3q/S/uAhoFI4be5aZRfFbzvYTAjsS5U=
X-Google-Smtp-Source: APBJJlFN8x2+wNX9Pho+Hycdeec6GrCe2Cvkl7Ri3UGz5HVuMNJf+5MAy7NpYDUo/9jVs0jVfN+yny92KrUU259H1vw=
X-Received: by 2002:a05:6512:3593:b0:4f9:d272:5847 with SMTP id
 m19-20020a056512359300b004f9d2725847mr10480467lfr.68.1689027809871; Mon, 10
 Jul 2023 15:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230708040750.72570-1-hffilwlqm@gmail.com> <20230708040750.72570-2-hffilwlqm@gmail.com>
In-Reply-To: <20230708040750.72570-2-hffilwlqm@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Jul 2023 15:23:17 -0700
Message-ID: <CAEf4BzZxS8sxr47GoXU0ZrwgZtp7drc5cehCOFrbx3-=n-1aFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Introduce bpf generic log
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hawk@kernel.org, tangyeechou@gmail.com, kernel-patches-bot@fb.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 9:08=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
> Currently, excluding verifier, users are unable to obtain detailed error
> information when issues occur in BPF syscall.
>
> To overcome this limitation, bpf generic log is introduced to provide
> error details similar to the verifier. This enhancement will enable the
> reporting of error details along with the corresponding errno in BPF
> syscall.
>
> Essentially, bpf generic log functions as a mechanism similar to netlink,
> enabling the transmission of error messages to user space. This
> mechanism greatly enhances the usability of BPF syscall by allowing
> users to access comprehensive error messages instead of relying solely
> on errno.
>
> This patch specifically addresses the error reporting in dev_xdp_attach()
> . With this patch, the error messages will be transferred to user space
> like the netlink approach. Hence, users will be able to check the error
> message along with the errno.
>
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  include/linux/bpf.h            | 30 ++++++++++++++++++++++++++++++
>  include/uapi/linux/bpf.h       |  6 ++++++
>  kernel/bpf/log.c               | 33 +++++++++++++++++++++++++++++++++
>  net/core/dev.c                 | 11 ++++++++++-
>  tools/include/uapi/linux/bpf.h |  6 ++++++
>  5 files changed, 85 insertions(+), 1 deletion(-)
>

Just curious, what's wrong with struct bpf_verifier_log for
implementing "generic log"? bpf_log, bpf_vlog_reset, bpf_vlog_finalize
are quite generic, I think. Why invent yet another structure? Existing
code and struct support rotating log, if necessary.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 360433f14496a..7d2124a537943 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3107,4 +3107,34 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
>         return flags;
>  }
>
> +#define BPF_GENERIC_TMP_LOG_SIZE       256
> +
> +struct bpf_generic_log {
> +       char            kbuf[BPF_GENERIC_TMP_LOG_SIZE];
> +       char __user     *ubuf;
> +       u32             len_used;
> +       u32             len_total;
> +};
> +
> +__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
> +                       const char *fmt, ...);
> +static inline void bpf_generic_log_init(struct bpf_generic_log *log,
> +                       const struct bpf_generic_user_log *ulog)
> +{
> +       log->ubuf =3D (char __user *) (unsigned long) ulog->log_buf;
> +       log->len_total =3D ulog->log_size;
> +       log->len_used =3D 0;
> +}
> +
> +#define BPF_GENERIC_LOG_WRITE(log, ulog, fmt, ...)     do {    \
> +       const char *____fmt =3D (fmt);                            \
> +       bpf_generic_log_init(log, ulog);                        \
> +       bpf_generic_log_write(log, ____fmt, ##__VA_ARGS__);     \
> +} while (0)
> +
> +#define BPF_GENERIC_ULOG_WRITE(ulog, fmt, ...) do {                    \
> +       struct bpf_generic_log ____log;                                 \
> +       BPF_GENERIC_LOG_WRITE(&____log, ulog, fmt, ##__VA_ARGS__);      \
> +} while (0)
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 60a9d59beeabb..34fa334938ba5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
>         };
>  };
>
> +struct bpf_generic_user_log {
> +       __aligned_u64   log_buf;    /* user supplied buffer */
> +       __u32           log_size;   /* size of user buffer */
> +};
> +
>  #define BPF_OBJ_NAME_LEN 16U
>
>  union bpf_attr {
> @@ -1544,6 +1549,7 @@ union bpf_attr {
>                 };
>                 __u32           attach_type;    /* attach type */
>                 __u32           flags;          /* extra flags */
> +               struct bpf_generic_user_log log; /* user log */

I think explicit triplet of log_level (should be log_flags, but too
late, probably), log_size, and log_buf is less error prone and more in
sync with other two commands that accept log (BPF_PROG_LOAD and
BPF_BTF_LOAD).

>                 union {
>                         __u32           target_btf_id;  /* btf_id of targ=
et to attach to */
>                         struct {
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 850494423530e..be56b153bbf0b 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -325,3 +325,36 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log =
*log,
>         va_end(args);
>  }
>  EXPORT_SYMBOL_GPL(bpf_log);
> +
> +static inline void __bpf_generic_log_write(struct bpf_generic_log *log, =
const char *fmt,
> +                                     va_list args)
> +{
> +       unsigned int n;
> +
> +       n =3D vscnprintf(log->kbuf, BPF_GENERIC_TMP_LOG_SIZE, fmt, args);
> +
> +       WARN_ONCE(n >=3D BPF_GENERIC_TMP_LOG_SIZE - 1,
> +                 "bpf generic log truncated - local buffer too short\n")=
;
> +
> +       n =3D min(log->len_total - log->len_used - 1, n);
> +       log->kbuf[n] =3D '\0';
> +
> +       if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
> +               log->len_used +=3D n;
> +       else
> +               log->ubuf =3D NULL;
> +}
> +

please see bpf_verifier_vlog() in kernel/bpf/log.c. We don't want to
maintain another (even if light) version of it.

> +__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
> +                                    const char *fmt, ...)
> +{
> +       va_list args;
> +
> +       if (!log->ubuf || !log->len_total)
> +               return;
> +
> +       va_start(args, fmt);
> +       __bpf_generic_log_write(log, fmt, args);
> +       va_end(args);
> +}

[...]

