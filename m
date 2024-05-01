Return-Path: <bpf+bounces-28392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004E58B8F8B
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D001F21F26
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 18:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDB15443A;
	Wed,  1 May 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZVZeU5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE03153BD6
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588269; cv=none; b=hhT0OamCwYCUyAbzKJHLEobDCgNe3z01L+d2tnxRtXBlPYh44eUaRQNPE4XSu/lKHybF94o5eKXWiQB64JLycSFwPSnyjWZByPdYQ/AnU5n7SUHqBc4ePo2cuDWgXs4Toc2zoc7Of4rE01LV3o5YBK/c6jXt7M35O2imdwKYLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588269; c=relaxed/simple;
	bh=7PRuX3baSAAS7XvthpXgbSvS4/ZTEz8Q15Pmh9XWiKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPCk65cuJmnCr8/livBiqk0+LkcF6YYbJGLzNSgtNWGwjktE3doYSRacZYHsPmKQT1QGDmtUUEhFEiCXNX4pZk/NAp+OGbdiLuOT5zi3uV9F2oVKHQ0es4ud13XZcAB4ClNvKcQVVnkiSyBPzNYKiCR3dVu+nv9E4fylVYZ3b3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZVZeU5E; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6123726725eso2969569a12.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714588267; x=1715193067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbHIUOTN5eghlxE3lf6C7sqQ8lVgYO3Oz3JjzDXTEPQ=;
        b=dZVZeU5En3lN1zVxzbfPjaS/chAgmQxuQ3R3KH2f7Rgo8J8KQwYgSAxfMbdCIyTi27
         eEAuyfRpF6vZuBapn/tWg7ZNVvFSoDDBWf2T8Xm+g1l6FpuXXvJYO2A28CkOq16yzQl3
         veEqvqSEOYwIv00Dg6INSvC8MhPm9/lXmbrHrJp1TMeAA+6+BNN0g+a+PYzxUBb8PE39
         cYMbSLxXip/j7X6rMWZeniOkwc8kbiH/qP0LVQTxgF8woSKjjnIgiweKDpDS42hQ4wd6
         mLrd5UnfH5npU34+HMj2jOyhIiplH8BBdioQIMWJgam5YyvN00GkUqyRs4NGE5iw4JUK
         w68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714588267; x=1715193067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbHIUOTN5eghlxE3lf6C7sqQ8lVgYO3Oz3JjzDXTEPQ=;
        b=pMRtjipcfRWnNbOs2aUGRTqi9NsONdLGnVtr9pHB+TNbweZvB/s0TC3iXzDeOtxN3x
         P7OoxZBc1F8cs1ODafyTAQpPd836M0XuXAfUDdd2FuBxLwnaUeIpu6OwFcAI1Y4+2fb7
         +cxVU/C0X7yzuU/9xIUS7a8iFrib/78BAmtFt5OJufdxG4QJnvkN0p9ea8wHi04aoI9s
         ryyZ6WychOqfGVV9VjbQv9z/a+tZ48ZhyaiUh9Az/ieGgO+HMT7Nfg6gPU7PwgxbV5E9
         kiqKJNeUciJlCWJHjGnua4ennCMAXzl0e5z9+RYU+rcvsDFqf57EnTp1wQIMgf66vzKY
         UHMw==
X-Forwarded-Encrypted: i=1; AJvYcCXDnEX8dXoDX6YxHmEWYhlK8bYNQ7zRQiflHJDFUCObsDF04P2Qv4RDZjm3jx1mk6LuWQtSCdmmDffQTgz0/4oLLB7h
X-Gm-Message-State: AOJu0YygXO5QQgU2JBiHXkPMuC7jAyCaTy4VHUSojAys95yT0fmUHyLV
	lFayLkCKAALnzo6CFmq6VS35/X5r6O3Op0QT44Ekg3mrlAQJomy2XyvuPP/veOwxUD5Yu/IrMZv
	CfzF/RPSsxMRWQk3o+srxc6B/cdIAHA==
X-Google-Smtp-Source: AGHT+IH83s2lLlJcDgvy0Ke4QTEG5T5cVLWo9p9S2enELihrmLIgQ6LBH+vP0bd64UeJ/xTcm5Fj/eXRA4NkRF41sqw=
X-Received: by 2002:a17:90b:3556:b0:2b3:ed2:1aaf with SMTP id
 lt22-20020a17090b355600b002b30ed21aafmr2485662pjb.29.1714588267412; Wed, 01
 May 2024 11:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430112830.1184228-1-jolsa@kernel.org> <20240430112830.1184228-5-jolsa@kernel.org>
In-Reply-To: <20240430112830.1184228-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 May 2024 11:30:55 -0700
Message-ID: <CAEf4BzbxSWvoNYJez8qc1TtKvTZG8S=hAYLrnwPwayuRnW1N9g@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 4/7] libbpf: Add support for kprobe session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:29=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach program in kprobe session mode
> with bpf_program__attach_kprobe_multi_opts function.
>
> Adding session bool to bpf_kprobe_multi_opts struct that allows
> to load and attach the bpf program via kprobe session.
> the attachment to create kprobe multi session.
>
> Also adding new program loader section that allows:
>  SEC("kprobe.session/bpf_fentry_test*")
>
> and loads/attaches kprobe program as kprobe session.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/bpf.c    |  1 +
>  tools/lib/bpf/libbpf.c | 39 +++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h |  4 +++-
>  3 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index c9f4e04f38fe..466a29d80124 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -766,6 +766,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>                         return libbpf_err(-EINVAL);
>                 break;
>         case BPF_TRACE_KPROBE_MULTI:
> +       case BPF_TRACE_KPROBE_SESSION:
>                 attr.link_create.kprobe_multi.flags =3D OPTS_GET(opts, kp=
robe_multi.flags, 0);
>                 attr.link_create.kprobe_multi.cnt =3D OPTS_GET(opts, kpro=
be_multi.cnt, 0);
>                 attr.link_create.kprobe_multi.syms =3D ptr_to_u64(OPTS_GE=
T(opts, kprobe_multi.syms, 0));
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 898d5d34ecea..16dae279a900 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9273,6 +9273,7 @@ static int attach_tp(const struct bpf_program *prog=
, long cookie, struct bpf_lin
>  static int attach_raw_tp(const struct bpf_program *prog, long cookie, st=
ruct bpf_link **link);
>  static int attach_trace(const struct bpf_program *prog, long cookie, str=
uct bpf_link **link);
>  static int attach_kprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
> +static int attach_kprobe_session(const struct bpf_program *prog, long co=
okie, struct bpf_link **link);
>  static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
>  static int attach_lsm(const struct bpf_program *prog, long cookie, struc=
t bpf_link **link);
>  static int attach_iter(const struct bpf_program *prog, long cookie, stru=
ct bpf_link **link);
> @@ -9289,6 +9290,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_=
uprobe),
>         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
>         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
> +       SEC_DEF("kprobe.session+",      KPROBE, BPF_TRACE_KPROBE_SESSION,=
 SEC_NONE, attach_kprobe_session),
>         SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
>         SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
>         SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
> @@ -11381,13 +11383,14 @@ bpf_program__attach_kprobe_multi_opts(const str=
uct bpf_program *prog,
>         struct kprobe_multi_resolve res =3D {
>                 .pattern =3D pattern,
>         };
> +       enum bpf_attach_type attach_type;
>         struct bpf_link *link =3D NULL;
>         char errmsg[STRERR_BUFSIZE];
>         const unsigned long *addrs;
>         int err, link_fd, prog_fd;
> +       bool retprobe, session;
>         const __u64 *cookies;
>         const char **syms;
> -       bool retprobe;
>         size_t cnt;
>
>         if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
> @@ -11426,6 +11429,12 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
>         }
>
>         retprobe =3D OPTS_GET(opts, retprobe, false);
> +       session  =3D OPTS_GET(opts, session, false);
> +
> +       if (retprobe && session)
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       attach_type =3D session ? BPF_TRACE_KPROBE_SESSION : BPF_TRACE_KP=
ROBE_MULTI;
>
>         lopts.kprobe_multi.syms =3D syms;
>         lopts.kprobe_multi.addrs =3D addrs;
> @@ -11440,7 +11449,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
>         }
>         link->detach =3D &bpf_link__detach_fd;
>
> -       link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, &=
lopts);
> +       link_fd =3D bpf_link_create(prog_fd, 0, attach_type, &lopts);
>         if (link_fd < 0) {
>                 err =3D -errno;
>                 pr_warn("prog '%s': failed to attach: %s\n",
> @@ -11546,6 +11555,32 @@ static int attach_kprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>         return libbpf_get_error(*link);
>  }
>
> +static int attach_kprobe_session(const struct bpf_program *prog, long co=
okie,
> +                                struct bpf_link **link)
> +{
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts, .session =3D true);
> +       const char *spec;
> +       char *pattern;
> +       int n;
> +
> +       *link =3D NULL;
> +
> +       /* no auto-attach for SEC("kprobe.session") */
> +       if (strcmp(prog->sec_name, "kprobe.session") =3D=3D 0)
> +               return 0;
> +
> +       spec =3D prog->sec_name + sizeof("kprobe.session/") - 1;
> +       n =3D sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> +       if (n < 1) {
> +               pr_warn("kprobe session pattern is invalid: %s\n", patter=
n);

this should be printing spec, not pattern, please send a follow up fix, tha=
nks

> +               return -EINVAL;
> +       }
> +
> +       *link =3D bpf_program__attach_kprobe_multi_opts(prog, pattern, &o=
pts);
> +       free(pattern);
> +       return *link ? 0 : -errno;
> +}
> +
>  static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link)
>  {
>         char *probe_type =3D NULL, *binary_path =3D NULL, *func_name =3D =
NULL;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 1333ae20ebe6..c3f77d9260fe 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -539,10 +539,12 @@ struct bpf_kprobe_multi_opts {
>         size_t cnt;
>         /* create return kprobes */
>         bool retprobe;
> +       /* create session kprobes */
> +       bool session;
>         size_t :0;
>  };
>
> -#define bpf_kprobe_multi_opts__last_field retprobe
> +#define bpf_kprobe_multi_opts__last_field session
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> --
> 2.44.0
>

