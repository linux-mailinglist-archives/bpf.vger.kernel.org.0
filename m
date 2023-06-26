Return-Path: <bpf+bounces-3517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669EE73EF73
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 01:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70332280F2E
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0605215AF0;
	Mon, 26 Jun 2023 23:47:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E612B66
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 23:47:14 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08EF1BC7
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 16:47:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso15236625e9.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 16:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687823226; x=1690415226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewTHXCkhk2nHswNTNldAaJe+Xc6H4y7RQpeolz64+kE=;
        b=RaaVzI0w+Ca5/FzXRShtbGemHrtPwQltUw0maeNEjiz9n9Q9QjWH14k49UpPSYE2vk
         ztJ9hnMrBCI++YDX87nlPslZcUWmFVfS6QIf8VuiKSO6Rqe3cLpUE4JCFFtaI9YEgGEP
         +4WA5TIRMbA8O+2QaGqqttnauIFWMOXy03PvyO4u23DnLB5hs6MkM1quk4gd349WZ25m
         dJ4gDS8hQS5Ua5EwkqnWZLSYu4Z/s6bGloLlafiPLAU2uuFMKLST35M3MeL7fWhKA3HT
         ZUib9rVLt+9L8vf04V0UpCsB36bN5YcDoKmGF6/EyYdqu16E0C4sCjsIm0R5AXqWwqtR
         KrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687823226; x=1690415226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewTHXCkhk2nHswNTNldAaJe+Xc6H4y7RQpeolz64+kE=;
        b=dG/zlzyb43PWr9F0yjKzVDnC3rT93OI1aZBcT6w+5MHwy+E7D1Tba7mdPOqg1u7okc
         /k1wlDSIxn4/AjuVmn2o2LbdgnDopiHFADIY8C0/TVqXehcNsuszkyYV57R43CPsvHHF
         FXQg2DLVCFRvpQTGCiXoc/AGmwjNrEgpvy9OorBEm4vJlyQKfvBVq8PNbo8ILGNKPkNg
         a6rAiafHBVWIlMrY0IHIUIh82ureIoxFQFVfmJl7XIa+jH8gJb5lmbLcjMVkhLh8EmMV
         1VMA1aaWpFrNcnXnOeDfvfmazLO8gOrJgb2rrVlNdukmHRc5JjdOhm1oQ340Dz4aCt92
         X+OA==
X-Gm-Message-State: AC+VfDxRx4SASHMY77N8ZIM2Zev1oCQbmjSMQDDxLUZN/9SYMlX9VUKJ
	hUe0feFZgaPhwo1ThoF6YlCmMxugSCHuKYyQ554IGmwZV7frLQ==
X-Google-Smtp-Source: ACHHUZ6RKBHbOHR0QQgvERSWN2x1UQbWjlM/OkXvlm1gI8j7W3WqAmO60ncvfqGz2TVla6jjh2t4YYIe0aY1kNLF+jk=
X-Received: by 2002:a05:600c:2942:b0:3f7:e7a2:25f6 with SMTP id
 n2-20020a05600c294200b003f7e7a225f6mr27677158wmd.17.1687823225875; Mon, 26
 Jun 2023 16:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230625011326.1729020-1-liu.yun@linux.dev>
In-Reply-To: <20230625011326.1729020-1-liu.yun@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 16:46:54 -0700
Message-ID: <CAEf4BzaaBtGTZa4V7QzxUxeKq6D2w+PSXih0sBL4K10UHR3ycw@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: kprobe.multi: Filter with available_filter_functions_addrs
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 6:14=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> wrot=
e:
>
> From: Jackie Liu <liuyun01@kylinos.cn>
>
> When using regular expression matching with "kprobe multi", it scans all
> the functions under "/proc/kallsyms" that can be matched. However, not al=
l
> of them can be traced by kprobe.multi. If any one of the functions fails
> to be traced, it will result in the failure of all functions. The best
> approach is to filter out the functions that cannot be traced to ensure
> proper tracking of the functions.
>
> Use available_filter_functions_addrs check first, if failed, fallback to
> kallsyms.
>

This is good, but it also doesn't address the original problem. On
older kernels that don't have available_filter_functions_addrs, we'll
still be trying to attach to non-attachable kprobes?

So I think we'll still need to add available_filter_functions-based
filtering on top of kallsyms. I guess we'll have to collect all
symbols+addr from kallsyms, sort them, then go over
available_filter_functions and do binary search. If element is not
found, we'll mark it for removal. Then last pass to filter out marked
entries to keep only addrs to be passed to kernel?


> Here is the test eBPF program [1].
> [1] https://github.com/JackieLiu1/ketones/tree/master/src/funccount
>
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 81 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a27f6e9ccce7..fca5d2e412c5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10107,6 +10107,12 @@ static const char *tracefs_uprobe_events(void)
>         return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_=
events";
>  }
>
> +static const char *tracefs_available_filter_functions_addrs(void)
> +{
> +       return use_debugfs() ? DEBUGFS"/available_filter_functions_addrs"=
 :
> +                              TRACEFS"/available_filter_functions_addrs"=
;
> +}
> +
>  static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>                                          const char *kfunc_name, size_t o=
ffset)
>  {
> @@ -10422,9 +10428,8 @@ struct kprobe_multi_resolve {
>         size_t cnt;
>  };
>
> -static int
> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> -                       const char *sym_name, void *ctx)
> +static int ftrace_resolve_kprobe_multi_cb(unsigned long long sym_addr,
> +                                         const char *sym_name, void *ctx=
)
>  {
>         struct kprobe_multi_resolve *res =3D ctx;
>         int err;
> @@ -10441,6 +10446,63 @@ resolve_kprobe_multi_cb(unsigned long long sym_a=
ddr, char sym_type,
>         return 0;
>  }
>
> +static int
> +kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_t=
ype,
> +                                const char *sym_name, void *ctx)
> +{
> +       return ftrace_resolve_kprobe_multi_cb(sym_addr, sym_name, ctx);
> +}
> +
> +typedef int (*available_kprobe_cb_t)(unsigned long long sym_addr,
> +                                    const char *sym_name, void *ctx);
> +
> +static int
> +libbpf_available_kprobes_parse(available_kprobe_cb_t cb, void *ctx)
> +{
> +       unsigned long long sym_addr;
> +       char sym_name[256];
> +       FILE *f;
> +       int ret, err =3D 0;
> +       const char *available_path =3D tracefs_available_filter_functions=
_addrs();
> +
> +       f =3D fopen(available_path, "r");
> +       if (!f) {
> +               err =3D -errno;
> +               pr_warn("failed to open %s, fallback to /proc/kallsyms.\n=
",
> +                       available_path);

if this is expected to happen, we shouldn't pr_warn() and pollute log outpu=
t

> +               return err;
> +       }
> +
> +       while (true) {
> +               ret =3D fscanf(f, "%llx %255s%*[^\n]\n", &sym_addr, sym_n=
ame);
> +               if (ret =3D=3D EOF && feof(f))
> +                       break;
> +               if (ret !=3D 2) {
> +                       pr_warn("failed to read available kprobe entry: %=
d\n",
> +                               ret);
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               err =3D cb(sym_addr, sym_name, ctx);
> +               if (err)
> +                       break;
> +       }
> +
> +       fclose(f);
> +       return err;
> +}
> +
> +static void kprobe_multi_resolve_reinit(struct kprobe_multi_resolve *res=
)
> +{
> +       free(res->addrs);
> +
> +       /* reset to zero, when fallback */
> +       res->cap =3D 0;
> +       res->cnt =3D 0;
> +       res->addrs =3D NULL;
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>                                       const char *pattern,
> @@ -10477,9 +10539,16 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
>                 return libbpf_err_ptr(-EINVAL);
>
>         if (pattern) {
> -               err =3D libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &r=
es);
> -               if (err)
> -                       goto error;
> +               err =3D libbpf_available_kprobes_parse(ftrace_resolve_kpr=
obe_multi_cb,
> +                                                    &res);
> +               if (err) {
> +                       /* fallback to kallsyms */
> +                       kprobe_multi_resolve_reinit(&res);

instead of try, fail, try something else approach, can we check that
tracefs_available_filter_functions_addrs() exists and is readable, and
if yes -- commit to it. If something fails -- to bad. If it doesn't
exist, fallback to kallsyms. And we won't need ugly
kprobe_multi_resolve_reinit() hack.

> +                       err =3D libbpf_kallsyms_parse(kallsyms_resolve_kp=
robe_multi_cb,
> +                                                   &res);
> +                       if (err)
> +                               goto error;
> +               }
>                 if (!res.cnt) {
>                         err =3D -ENOENT;
>                         goto error;
> --
> 2.25.1
>
>

