Return-Path: <bpf+bounces-4333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270CA74A617
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDC91C20E0F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45E15ACE;
	Thu,  6 Jul 2023 21:45:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239E1097D
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:45:34 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAB6E5
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 14:45:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3143b88faebso1255952f8f.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688679931; x=1691271931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d31RailAhVMP4wQXsENJss2Kw82sAAPn/GD4QvSjuiQ=;
        b=J7lmlI+ky5FCaA81CWy9QWLzaY/NQgSKPMek8XvIGyiKhXqvBRpk4iRJAw95D+RqQR
         HvtQSX/yc2lpbYRs4zy7+unJWE7RDjQZG14D2/haJJnPAW50LuZtdWeGdb+uf1C6hJAa
         uxFfqRGF7Dl1UhWriTBROfiCRGHLEEnNUI3/4/pyTFMSUDVOZNoGbhIbVB0PD5S06cuY
         uGs/X7wnVVFjsX7T1GHZA3Elc7z7WqG+HFf9E6BwF+hgYvPyKfkySqP0BY1gMEjWBxNa
         deodt6NHh+vlQl9GRIRWeQjVSP9v8Ix+IYiLS4Zr9K2s3p0CjQIRIGVScxJ3BUibKyQn
         VUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688679931; x=1691271931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d31RailAhVMP4wQXsENJss2Kw82sAAPn/GD4QvSjuiQ=;
        b=YlDMFsxdUlof6C0X4zIlFgZ8Ly5eIBgiPBbwLNVNopRV348B6u9rwE5SiNixsAh4pE
         KjQairDgTdZJJJrXujtkN4xCFhc1z90MhUYWJCxvfA30a2GYAYxeXiGaRhJG7t09vUnX
         YX3cDEfbrmJWcN2cVsHwhnJWcp1FvzN7vwb1dejMsOpsskWijUrM0OJWv9gfNngis8Jh
         Uu4+klOExffstpd28IDxHcAjkS2G9tAGzPUoNlBkXsq/4A7FqJmbAVZ30jN2LQ7x33AH
         7Dz8/xkZJCsgKb6gXL1sL1uYVlJ1jbF994pNRH6ywHBe6peOMdH0Bt/8Pql5Zeq6rO69
         H1FQ==
X-Gm-Message-State: ABy/qLZjy0cIiz5p/DmCFQ9Qk37O5dW5n4Un7xyeFRUj1Nt407bxKQhi
	/qH4GUHVRtuUhe/7HW+1H/WPozjIMIYKBETyqmZ9aysqU+4=
X-Google-Smtp-Source: APBJJlE1Y9DqnzGq3S7x1FpsYux+jkwwCUmh+5P/0ma7OZeSvciNFIf2HltqQ6gfJk47AflELF2dIR7e234jLd2RzXw=
X-Received: by 2002:a05:6000:11ce:b0:313:fe1b:f442 with SMTP id
 i14-20020a05600011ce00b00313fe1bf442mr2872700wrx.37.1688679930768; Thu, 06
 Jul 2023 14:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705091209.3803873-1-liu.yun@linux.dev>
In-Reply-To: <20230705091209.3803873-1-liu.yun@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 14:45:18 -0700
Message-ID: <CAEf4BzYnTJ4Vg1KQzPaAqgy8o+LBYhvuAWR6Ev68OGBrQkzq2w@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] libbpf: kprobe.multi: cross filter using
 available_filter_functions and kallsyms
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 2:12=E2=80=AFAM Jackie Liu <liu.yun@linux.dev> wrote=
:
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
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307030355.TdXOHklM-lkp@i=
ntel.com/
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  v6->v7: fix leak "FILE *f"
>  v5->v6: fix crash by not init "const char *syms"
>  v4->v5: simplified code
>
>  tools/lib/bpf/libbpf.c | 107 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 97 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 214f828ece6b..af7e224ba4ca 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10224,6 +10224,12 @@ static const char *tracefs_uprobe_events(void)
>         return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_=
events";
>  }
>
> +static const char *tracefs_available_filter_functions(void)
> +{
> +       return use_debugfs() ? DEBUGFS"/available_filter_functions" :
> +                              TRACEFS"/available_filter_functions";
> +}
> +
>  static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>                                          const char *kfunc_name, size_t o=
ffset)
>  {
> @@ -10539,14 +10545,26 @@ struct kprobe_multi_resolve {
>         size_t cnt;
>  };
>
> -static int
> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> -                       const char *sym_name, void *ctx)
> +static int avail_compare_function(const void *a, const void *b)
> +{
> +       return strcmp(*(const char **)a, *(const char **)b);
> +}
> +
> +struct avail_kallsyms_data {
> +       const char **syms;
> +       size_t cnt;
> +       struct kprobe_multi_resolve *res;
> +};
> +
> +static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
> +                            const char *sym_name, void *ctx)
>  {
> -       struct kprobe_multi_resolve *res =3D ctx;
> +       struct avail_kallsyms_data *data =3D ctx;
> +       struct kprobe_multi_resolve *res =3D data->res;
>         int err;
>
> -       if (!glob_match(sym_name, res->pattern))
> +       if (!bsearch(&sym_name, data->syms, data->cnt, sizeof(void *),
> +                    avail_compare_function))
>                 return 0;
>
>         err =3D libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeo=
f(unsigned long),
> @@ -10558,6 +10576,79 @@ resolve_kprobe_multi_cb(unsigned long long sym_a=
ddr, char sym_type,
>         return 0;
>  }
>
> +static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *=
res)
> +{
> +       struct avail_kallsyms_data data;
> +       char sym_name[500];
> +       const char *available_functions_file =3D tracefs_available_filter=
_functions();
> +       FILE *f;
> +       int err =3D 0, ret, i;
> +       const char **syms =3D NULL;
> +       size_t cap =3D 0, cnt =3D 0;
> +
> +       f =3D fopen(available_functions_file, "r");
> +       if (!f) {
> +               err =3D -errno;
> +               pr_warn("failed to open %s\n", available_functions_file);
> +               return err;
> +       }
> +
> +       while (true) {
> +               char *name;
> +
> +               ret =3D fscanf(f, "%499s%*[^\n]\n", sym_name);
> +               if (ret =3D=3D EOF && feof(f))
> +                       break;
> +
> +               if (ret !=3D 1) {
> +                       pr_warn("failed to read available function file e=
ntry: %d\n",
> +                               ret);
> +                       err =3D -EINVAL;
> +                       goto cleanup;
> +               }
> +
> +               if (!glob_match(sym_name, res->pattern))
> +                       continue;
> +
> +               err =3D libbpf_ensure_mem((void **)&syms, &cap, sizeof(vo=
id *),
> +                                       cnt + 1);
> +               if (err)
> +                       goto cleanup;
> +
> +               name =3D strdup(sym_name);
> +               if (!name) {
> +                       err =3D -errno;
> +                       goto cleanup;
> +               }
> +
> +               syms[cnt++] =3D name;
> +       }
> +       /* not found entry, return direct */
> +       if (!cnt) {
> +               fclose(f);
> +               return -ENOENT;

this leaks syms, you should have done `err =3D -ENOENT; goto cleanup;`
here to keep it simple and consistent. I fixed this up, did a few more
small cosmetic changes, and applied to bpf-next, thanks.

> +       }
> +
> +       /* sort available functions */
> +       qsort(syms, cnt, sizeof(void *), avail_compare_function);
> +
> +       data.syms =3D syms;
> +       data.res =3D res;
> +       data.cnt =3D cnt;
> +       libbpf_kallsyms_parse(avail_kallsyms_cb, &data);
> +
> +       if (!res->cnt)
> +               err =3D -ENOENT;
> +
> +cleanup:
> +       for (i =3D 0; i < cnt; i++)
> +               free((char *)syms[i]);
> +       free(syms);
> +
> +       fclose(f);
> +       return err;
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>                                       const char *pattern,
> @@ -10594,13 +10685,9 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
>                 return libbpf_err_ptr(-EINVAL);
>
>         if (pattern) {
> -               err =3D libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &r=
es);
> +               err =3D libbpf_available_kallsyms_parse(&res);
>                 if (err)
>                         goto error;
> -               if (!res.cnt) {
> -                       err =3D -ENOENT;
> -                       goto error;
> -               }
>                 addrs =3D res.addrs;
>                 cnt =3D res.cnt;
>         }
> --
> 2.25.1
>
>

