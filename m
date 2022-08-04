Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D07589FC7
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 19:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiHDRRP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiHDRRO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 13:17:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FAA6A485;
        Thu,  4 Aug 2022 10:17:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i14so475384ejg.6;
        Thu, 04 Aug 2022 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QsqdAv7lzfCzVrls5e3D/1HBUNjDsakydLuhi3H9Yhg=;
        b=KmSc8/HSgtUjLn/eY3kel/629G+B2lunQLmO6hXxq1nf+hYt51xD57hD1DUHn14NDV
         GuU4KrLJBRZPUCk/xtb8q7q4qV+gtwvIFPFYmCfo6ZczQeKDHnxNi6Q4FPM08VGpxN9F
         AT2hgVK6n6aHUnbW7RdrTyTADlBpkKFIdJi/mlRALt5sk3rDKNYsClN4hAF6HYk2k8ud
         AJh7F1chqTi24O7vdHwXGlWZHnmz1jqddqvqXf9b9QUzCL28CUpEyeuoo2C/WzE5HbWU
         m49pWie4g/HPSf5BUPsb/VsJx59+rh8m4muCh1vOzFiPnCaCOs0qaYRbKAY0vyKYSgmW
         zbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QsqdAv7lzfCzVrls5e3D/1HBUNjDsakydLuhi3H9Yhg=;
        b=r9X5X9bseGsz6VjJWkRCtgkqSA603GliEdUhsmup86x0lLzMkZ2OALE3BKOMqEzJM9
         mh6T2cT2SADWRZSE0Kqth9XrZ0iZ/6VBEiiH/Vbu/kwMfw7R+2+fijMic4RfVv0OCDbZ
         9dTitVekV2LGk7UqFdMND+gdtieyvhVkFiH4B+OrLevx/tMwjwKaFc8bGLC6qrXG6d5z
         IOLMWqjEit0PwSixEySW1gMzS6zRwyWwLG5+iMjScY6xGdNgFNvB/KJ0xdrL22DKtWnU
         VceIL3ayB2fCscpSpOwKP3CeHXjssodVMUYO7hf0oQRihL14i4IXx9gWouRuFdI/bqVB
         LSjA==
X-Gm-Message-State: ACgBeo3o34pWLtCvmV4r0BgMrBXIM3kwoNAd6Z/3FmVFhmavvKDdbZAR
        XfqFyNnF182o6GA9wD1iAJvuGRsI3T25dUBsciY=
X-Google-Smtp-Source: AA6agR6OoOj08B7Hsh9uYlMY2QWamsku3wjAUwuzJj8XR5bHi7H75/jMIvGbCspmJi45/sQjkh7ZRgWruXaZmSq+nfE=
X-Received: by 2002:a17:907:6e02:b0:72b:9f16:1bc5 with SMTP id
 sd2-20020a1709076e0200b0072b9f161bc5mr2244766ejc.676.1659633430590; Thu, 04
 Aug 2022 10:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220803134821.425334-1-lee@kernel.org>
In-Reply-To: <20220803134821.425334-1-lee@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 Aug 2022 10:16:59 -0700
Message-ID: <CAADnVQ+X_B4LC6CtYM1PXPA4BBprWLj5Qip--Eeu32Zti==Ydw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] bpf: Drop unprotected find_vpid() in favour of find_get_pid()
To:     Lee Jones <lee@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 3, 2022 at 6:48 AM Lee Jones <lee@kernel.org> wrote:
>
> The documentation for find_pid() clearly states:
>
>   "Must be called with the tasklist_lock or rcu_read_lock() held."
>
> Presently we do neither.
>
> Let's use find_get_pid() which searches for the vpid, then takes a
> reference to it preventing early free, all within the safety of
> rcu_read_lock().  Once we have our reference we can safely make use of
> it up until the point it is put.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>
> v1 => v2:
>   * Commit log update - no code differences
>
>  kernel/bpf/syscall.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 83c7136c5788d..c20cff30581c4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>         const struct perf_event *event;
>         struct task_struct *task;
>         struct file *file;
> +       struct pid *ppid;
>         int err;
>
>         if (CHECK_ATTR(BPF_TASK_FD_QUERY))
> @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>         if (attr->task_fd_query.flags != 0)
>                 return -EINVAL;
>
> -       task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> +       ppid = find_get_pid(pid);
> +       task = get_pid_task(ppid, PIDTYPE_PID);
> +       put_pid(ppid);

rcu_read_lock/unlock around this line
would be a cheaper and faster alternative than pid's
refcount inc/dec.
