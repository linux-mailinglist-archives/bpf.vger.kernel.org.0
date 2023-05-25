Return-Path: <bpf+bounces-1249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB834711857
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 22:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5901C20EBE
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB51C21CEA;
	Thu, 25 May 2023 20:43:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4191D2AD
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 20:43:35 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4871199
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 13:43:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510d92184faso5253769a12.1
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685047412; x=1687639412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUNwNo/+vxU4GXLCxCMuB+dsyPAjYDAAV9uDPvqpZP8=;
        b=N8omsgo0rBBdW6q4mz1c+NzTjbeRFJqnNDsAkfNI+FvXFoK8VdUodx5PM9cnPGGSxN
         w2enRQ0SZb5JWw0o/UqojeSIQPwI+6sZ6rE5TK5587javUvbOvzypv+apnRbTDiJb3Yp
         lB+iumj91gpx+rpWrYjGejMhvXF16dF6iOxYXOjuFS+OCDAG9XBgWAOyjMx9Rc4cz9Bv
         zL8LLTPw+x+55kIUkAHm1TSOrj3z/8jBwv3vVBgFthEvp4A+K2zibsK7KwmUlTsJZjDz
         BxOgP0c825f5T4DzJz8gusLDPtjIe/yHM5rpnvicC+bel9mBQMXwtXDIqS24gX1xAMfP
         8mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685047412; x=1687639412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUNwNo/+vxU4GXLCxCMuB+dsyPAjYDAAV9uDPvqpZP8=;
        b=lXPBN7w5ngroF9GpjxIP0SRjQuI3ImZk72yPBED/VcO4O25sbuwW/sodPx+VBX5wGc
         66LXytw7Qk1N2uV3QHX9KUo82xUrQU8+m8p17R5+/jRmla1s4wR34e6RlLIDhn3+LDtA
         PHYFuRlVg2Oa3shUj5QRG6aaa1YjJR3vVXWWMoCtKYwKB6IYD6m0fWE3BHybf9l7D9nS
         4SiGlMyojRyq22lmLWgRCNcx4RnwHVSYpW2CoXrJJ9DITKAQu9/4ewYT/wlKX+0YdeUp
         nHWnsY4MYxsNwdCvO8PgYKteYdDkv/CYS1FaLDDIa/hJ+S7G+QdD54tRVBqQGOhYBjMF
         9WBA==
X-Gm-Message-State: AC+VfDxmHoKffSAajajlMJMeXOWlkwCgZi4K8+MK86ie+KC9Po4sEbpn
	4M2rJIG6ftl+fyYgr42kUU3DU03WjyX+r+PLWjc=
X-Google-Smtp-Source: ACHHUZ4SuMuugMcUMsLtQwb8f2HzHB/akAAHfj+NLA2lRw6eLucgWEh+4dJUDIFtEeLUaDsnhkTHPeZ9hyZiXcDmyaU=
X-Received: by 2002:a17:907:c1a:b0:973:84af:66e5 with SMTP id
 ga26-20020a1709070c1a00b0097384af66e5mr6317ejc.40.1685047411802; Thu, 25 May
 2023 13:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZG8f7ffghG7mLUhR@krava> <20230525102747.68708-1-liu.yun@linux.dev>
In-Reply-To: <20230525102747.68708-1-liu.yun@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 May 2023 13:43:20 -0700
Message-ID: <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
Subject: Re: [PATCH v4] libbpf: kprobe.multi: Filter with available_filter_functions
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

On Thu, May 25, 2023 at 3:28=E2=80=AFAM Jackie Liu <liu.yun@linux.dev> wrot=
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
> Use available_filter_functions check first, if failed, fallback to
> kallsyms.
>
> Here is the test eBPF program [1].
> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3ea=
dde97f7a4535e867
>
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 83 insertions(+), 9 deletions(-)
>

Question to you and Jiri: what happens when multi-kprobe's syms has
duplicates? Will the program be attached multiple times? If yes, then
it sounds like a problem? Both available_filters and kallsyms can have
duplicate function names in them, right?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ad1ec893b41b..3dd72d69cdf7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10417,13 +10417,14 @@ static bool glob_match(const char *str, const c=
har *pat)
>  struct kprobe_multi_resolve {
>         const char *pattern;
>         unsigned long *addrs;
> +       const char **syms;
>         size_t cap;
>         size_t cnt;
>  };
>
>  static int
> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> -                       const char *sym_name, void *ctx)
> +kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_t=
ype,
> +                                const char *sym_name, void *ctx)
>  {
>         struct kprobe_multi_resolve *res =3D ctx;
>         int err;
> @@ -10431,8 +10432,8 @@ resolve_kprobe_multi_cb(unsigned long long sym_ad=
dr, char sym_type,
>         if (!glob_match(sym_name, res->pattern))
>                 return 0;
>
> -       err =3D libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeo=
f(unsigned long),
> -                               res->cnt + 1);
> +       err =3D libbpf_ensure_mem((void **) &res->addrs, &res->cap,
> +                               sizeof(unsigned long), res->cnt + 1);
>         if (err)
>                 return err;
>
> @@ -10440,6 +10441,73 @@ resolve_kprobe_multi_cb(unsigned long long sym_a=
ddr, char sym_type,
>         return 0;
>  }
>
> +static int ftrace_resolve_kprobe_multi_cb(const char *sym_name, void *ct=
x)
> +{
> +       struct kprobe_multi_resolve *res =3D ctx;
> +       int err;
> +       char *name;
> +
> +       if (!glob_match(sym_name, res->pattern))
> +               return 0;
> +
> +       err =3D libbpf_ensure_mem((void **) &res->syms, &res->cap,
> +                               sizeof(const char *), res->cnt + 1);
> +       if (err)
> +               return err;
> +
> +       name =3D strdup(sym_name);
> +       if (!name)
> +               return errno;

-errno

> +
> +       res->syms[res->cnt++] =3D name;
> +       return 0;
> +}
> +
> +typedef int (*available_filter_functions_cb_t)(const char *sym_name, voi=
d *ctx);

quite mouthful, maybe just "available_kprobe_cb_t"? "filters"
terminology isn't common within libbpf and BPF tracing in general

> +
> +static int
> +libbpf_ftrace_parse(available_filter_functions_cb_t cb, void *ctx)

let's call it "libbpf_available_kprobes_parse" ?

> +{
> +       char sym_name[256];
> +       FILE *f;
> +       int ret, err =3D 0;
> +
> +       f =3D fopen("/sys/kernel/debug/tracing/available_filter_functions=
", "r");

we need to check between DEBUGFS and TRACEFS, let's do something like
tracefs_kprobe_events()

> +       if (!f) {
> +               pr_warn("failed to open available_filter_functions, fallb=
ack to /proc/kallsyms.\n");
> +               return -EINVAL;

preserve errno, just like libbpf_kallsyms_parse

> +       }
> +
> +       while (true) {
> +               ret =3D fscanf(f, "%s%*[^\n]\n", sym_name);

%255s, similar to libbpf_kallsyms_probe. You have precedent code that
does parsing like this, please stick to the same approaches

> +               if (ret =3D=3D EOF && feof(f))
> +                       break;
> +               if (ret !=3D 1) {
> +                       pr_warn("failed to read available_filter_function=
s entry: %d\n",

s/available_filter_functions/kprobe/

> +                               ret);

err =3D -EINVAL

> +                       break;
> +               }
> +
> +               err =3D cb(sym_name, ctx);
> +               if (err)
> +                       break;
> +       }
> +
> +       fclose(f);
> +       return err;
> +}
> +
> +static void kprobe_multi_resolve_free(struct kprobe_multi_resolve *res)
> +{
> +       if (res->syms) {
> +               while (res->cnt)
> +                       free((char *)res->syms[--res->cnt]);
> +               free(res->syms);
> +       } else {
> +               free(res->addrs);

there is no need to assume that res->addrs will be null, let's free it
unconditionally. free() handles NULL just fine

> +       }
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>                                       const char *pattern,
> @@ -10476,13 +10544,19 @@ bpf_program__attach_kprobe_multi_opts(const str=
uct bpf_program *prog,
>                 return libbpf_err_ptr(-EINVAL);
>
>         if (pattern) {
> -               err =3D libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &r=
es);
> -               if (err)
> -                       goto error;
> +               err =3D libbpf_ftrace_parse(ftrace_resolve_kprobe_multi_c=
b, &res);
> +               if (err) {
> +                       /* fallback to kallsyms */
> +                       err =3D libbpf_kallsyms_parse(kallsyms_resolve_kp=
robe_multi_cb,
> +                                                   &res);
> +                       if (err)
> +                               goto error;
> +               }
>                 if (!res.cnt) {
>                         err =3D -ENOENT;
>                         goto error;
>                 }
> +               syms =3D res.syms;
>                 addrs =3D res.addrs;
>                 cnt =3D res.cnt;
>         }
> @@ -10511,12 +10585,12 @@ bpf_program__attach_kprobe_multi_opts(const str=
uct bpf_program *prog,
>                 goto error;
>         }
>         link->fd =3D link_fd;
> -       free(res.addrs);
> +       kprobe_multi_resolve_free(&res);
>         return link;
>
>  error:
>         free(link);
> -       free(res.addrs);
> +       kprobe_multi_resolve_free(&res);
>         return libbpf_err_ptr(err);
>  }
>
> --
> 2.25.1
>
>

