Return-Path: <bpf+bounces-3825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081E744295
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 21:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB082810FD
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB8171BB;
	Fri, 30 Jun 2023 19:01:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB52156CB
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 19:01:55 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DACEE
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 12:01:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso2393160e87.1
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688151712; x=1690743712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAbGfNBEJJJiZ07vg0Q9y8r4SjWOnr0Two0v8l2xOvs=;
        b=XjWA953/zNyT3TME99DOBCcgV18wrLKwrdGAF5rHBWZVtWXPXQUqKySGFGpiMnRKYD
         SlxJcYQyY/8a2Xl3KJ/i1fnGSg2QMUA7wdzxpVWzzmsi5+gweylYsJFZ+DZ4WpfNgZm8
         lb0f+CeDnrJmHOcp2uyGF5ZhUAcmVrfmvX33IMM93BwZhOVlLQxAtNm8dSPO+oZ+o9BS
         m5ey5bLqLzhGvIIQjChAe6nTpmVzEgMT7xWk/hVFGWY1VWYIYGp941yAGhETK0ZxqLmb
         gQxZ1DZziDtht8DOL7PmZOGjFwmmve7VcqBDaeEfOMCHhCl110IrFXooVjr2XjvrqY+m
         wTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688151712; x=1690743712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAbGfNBEJJJiZ07vg0Q9y8r4SjWOnr0Two0v8l2xOvs=;
        b=J2Cb0mnCap6nMMR1Mh/hFRSWTA12OaZ7FuSBXSOR1/+Cdf7OfSQQvs6v/QpTI8NRVf
         UVUf/EtfHE55JKJPlAyBvDPybNbfcmtenzyBpJt01UWG7uSkTUqJqgZsnTz6S+RX0Jjh
         L5WaMU7KL85oes1pucZF5FjzfTCvgkZuZyUA0Ao8vQnvwxXZziia5a8ZCoAm89m2cXds
         ilxTgqLv+udwzvm63mim6xyIjBJXQKPCeQB610tC/FI+25+eevts49PNSNt//aqUm1EY
         km38KREcQIz4qYyEvNREmBQ8ISuX6nbwnkOOaCPNi2B1Z/LtJNQZmF+31iIZnKysPSjc
         Qk4A==
X-Gm-Message-State: ABy/qLbe78ZE5nNNXoSghyhN/ibXUVXgtD6oJ4/jSvfuvXGR0pnFfxb/
	gV+5wQFh2ARRRDwEblcwFaDln0VHqLMrgWHPv2igLDOowwQ=
X-Google-Smtp-Source: APBJJlFlzsDYpa5iQrkmXxAr/K5TiUf9X7VVAZAmjfH8kH29TecDRyF/+zub8z4rJqIvTQQru87QGVJkzfyblCuWXpI=
X-Received: by 2002:a05:6512:15a3:b0:4fb:7da3:de4 with SMTP id
 bp35-20020a05651215a300b004fb7da30de4mr4162118lfb.13.1688151712108; Fri, 30
 Jun 2023 12:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230625011326.1729020-1-liu.yun@linux.dev> <CAEf4BzaaBtGTZa4V7QzxUxeKq6D2w+PSXih0sBL4K10UHR3ycw@mail.gmail.com>
 <211cd152-b018-a803-cd3c-3861eec60eab@linux.dev>
In-Reply-To: <211cd152-b018-a803-cd3c-3861eec60eab@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jun 2023 12:01:40 -0700
Message-ID: <CAEf4BzYMq5g6YEG7A-XvRa9yZS8+6XmFrf4ba4MGSWxM8pF3Xw@mail.gmail.com>
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

On Mon, Jun 26, 2023 at 6:38=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> wrot=
e:
>
>
>
> =E5=9C=A8 2023/6/27 07:46, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Sat, Jun 24, 2023 at 6:14=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> =
wrote:
> >>
> >> From: Jackie Liu <liuyun01@kylinos.cn>
> >>
> >> When using regular expression matching with "kprobe multi", it scans a=
ll
> >> the functions under "/proc/kallsyms" that can be matched. However, not=
 all
> >> of them can be traced by kprobe.multi. If any one of the functions fai=
ls
> >> to be traced, it will result in the failure of all functions. The best
> >> approach is to filter out the functions that cannot be traced to ensur=
e
> >> proper tracking of the functions.
> >>
> >> Use available_filter_functions_addrs check first, if failed, fallback =
to
> >> kallsyms.
> >>
> >
> > This is good, but it also doesn't address the original problem. On
> > older kernels that don't have available_filter_functions_addrs, we'll
> > still be trying to attach to non-attachable kprobes?
> >
> > So I think we'll still need to add available_filter_functions-based
> > filtering on top of kallsyms. I guess we'll have to collect all
> > symbols+addr from kallsyms, sort them, then go over
> > available_filter_functions and do binary search. If element is not
> > found, we'll mark it for removal. Then last pass to filter out marked
> > entries to keep only addrs to be passed to kernel?
>
> The first patch I submitted was to re-search available_filter_functions
> in the case of kallsyms matching. The link is at:
>
> https://lore.kernel.org/all/20230523132547.94384-1-liu.yun@linux.dev/,
>
> but it is very slow and takes about 5s to start. If necessary, I can
> continue to add it to the V3 patch. Maybe you have other better
> algorithms?

Of course it's very slow. For every matched kallsyms symbol you are
reopening/reparsing/scanning linearly entire
available_filter_functions. You need to make sure that you parse both
kallsyms and available_filter_functions just once, and then join them
together to keep only symbols in both files.

See my suggestion above about sorting and binary search. That's one
way to do it efficiently.

>
> --
> Jackie Liu
>
> >
> >
> >> Here is the test eBPF program [1].
> >> [1] https://github.com/JackieLiu1/ketones/tree/master/src/funccount
> >>
> >> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> >> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 81 ++++++++++++++++++++++++++++++++++++++--=
--
> >>   1 file changed, 75 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index a27f6e9ccce7..fca5d2e412c5 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -10107,6 +10107,12 @@ static const char *tracefs_uprobe_events(void=
)
> >>          return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/upr=
obe_events";
> >>   }
> >>
> >> +static const char *tracefs_available_filter_functions_addrs(void)
> >> +{
> >> +       return use_debugfs() ? DEBUGFS"/available_filter_functions_add=
rs" :
> >> +                              TRACEFS"/available_filter_functions_add=
rs";
> >> +}
> >> +
> >>   static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> >>                                           const char *kfunc_name, size=
_t offset)
> >>   {
> >> @@ -10422,9 +10428,8 @@ struct kprobe_multi_resolve {
> >>          size_t cnt;
> >>   };
> >>
> >> -static int
> >> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> >> -                       const char *sym_name, void *ctx)
> >> +static int ftrace_resolve_kprobe_multi_cb(unsigned long long sym_addr=
,
> >> +                                         const char *sym_name, void *=
ctx)
> >>   {
> >>          struct kprobe_multi_resolve *res =3D ctx;
> >>          int err;
> >> @@ -10441,6 +10446,63 @@ resolve_kprobe_multi_cb(unsigned long long sy=
m_addr, char sym_type,
> >>          return 0;
> >>   }
> >>
> >> +static int
> >> +kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sy=
m_type,
> >> +                                const char *sym_name, void *ctx)
> >> +{
> >> +       return ftrace_resolve_kprobe_multi_cb(sym_addr, sym_name, ctx)=
;
> >> +}
> >> +
> >> +typedef int (*available_kprobe_cb_t)(unsigned long long sym_addr,
> >> +                                    const char *sym_name, void *ctx);
> >> +
> >> +static int
> >> +libbpf_available_kprobes_parse(available_kprobe_cb_t cb, void *ctx)
> >> +{
> >> +       unsigned long long sym_addr;
> >> +       char sym_name[256];
> >> +       FILE *f;
> >> +       int ret, err =3D 0;
> >> +       const char *available_path =3D tracefs_available_filter_functi=
ons_addrs();
> >> +
> >> +       f =3D fopen(available_path, "r");
> >> +       if (!f) {
> >> +               err =3D -errno;
> >> +               pr_warn("failed to open %s, fallback to /proc/kallsyms=
.\n",
> >> +                       available_path);
> >
> > if this is expected to happen, we shouldn't pr_warn() and pollute log o=
utput
> >
> >> +               return err;
> >> +       }
> >> +
> >> +       while (true) {
> >> +               ret =3D fscanf(f, "%llx %255s%*[^\n]\n", &sym_addr, sy=
m_name);
> >> +               if (ret =3D=3D EOF && feof(f))
> >> +                       break;
> >> +               if (ret !=3D 2) {
> >> +                       pr_warn("failed to read available kprobe entry=
: %d\n",
> >> +                               ret);
> >> +                       err =3D -EINVAL;
> >> +                       break;
> >> +               }
> >> +
> >> +               err =3D cb(sym_addr, sym_name, ctx);
> >> +               if (err)
> >> +                       break;
> >> +       }
> >> +
> >> +       fclose(f);
> >> +       return err;
> >> +}
> >> +
> >> +static void kprobe_multi_resolve_reinit(struct kprobe_multi_resolve *=
res)
> >> +{
> >> +       free(res->addrs);
> >> +
> >> +       /* reset to zero, when fallback */
> >> +       res->cap =3D 0;
> >> +       res->cnt =3D 0;
> >> +       res->addrs =3D NULL;
> >> +}
> >> +
> >>   struct bpf_link *
> >>   bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog=
,
> >>                                        const char *pattern,
> >> @@ -10477,9 +10539,16 @@ bpf_program__attach_kprobe_multi_opts(const s=
truct bpf_program *prog,
> >>                  return libbpf_err_ptr(-EINVAL);
> >>
> >>          if (pattern) {
> >> -               err =3D libbpf_kallsyms_parse(resolve_kprobe_multi_cb,=
 &res);
> >> -               if (err)
> >> -                       goto error;
> >> +               err =3D libbpf_available_kprobes_parse(ftrace_resolve_=
kprobe_multi_cb,
> >> +                                                    &res);
> >> +               if (err) {
> >> +                       /* fallback to kallsyms */
> >> +                       kprobe_multi_resolve_reinit(&res);
> >
> > instead of try, fail, try something else approach, can we check that
> > tracefs_available_filter_functions_addrs() exists and is readable, and
> > if yes -- commit to it. If something fails -- to bad. If it doesn't
> > exist, fallback to kallsyms. And we won't need ugly
> > kprobe_multi_resolve_reinit() hack.
>
> Sounds good.
>
> >
> >> +                       err =3D libbpf_kallsyms_parse(kallsyms_resolve=
_kprobe_multi_cb,
> >> +                                                   &res);
> >> +                       if (err)
> >> +                               goto error;
> >> +               }
> >>                  if (!res.cnt) {
> >>                          err =3D -ENOENT;
> >>                          goto error;
> >> --
> >> 2.25.1
> >>
> >>

