Return-Path: <bpf+bounces-63267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633CEB04A11
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6464A2A06
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B05E27A455;
	Mon, 14 Jul 2025 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWpeev8a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C72063F3;
	Mon, 14 Jul 2025 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530881; cv=none; b=krkdS0cGVAJGBxmPnZHEMxYXIzU+w68/7YQG8WljDo6rmHA0YGnntCWYH713FiID95ByhGk10u6QPmKa4FZ9pbA+leYIQR0JyKGbG4CZpgOwD2qn2M4IQU3zaW3+B64INlyNPWkY9JJKaBLyvTqM4hxMqFAOstmAaLV4a1xIXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530881; c=relaxed/simple;
	bh=PnQ3UAxhanZFZT5AOwomyDVAEJhC3lGQlKF7agppkZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieSwV1QAfrZS/LhIZ7sb7MkxNpozGIZgJ3Pd7YH2k/oxYxR5HARA1CaBGP8k+9r8GqO6p1Mf/7yuqcJWHiVY2qHpnQ4gifiFzoSyKwlx/PIVthW00ey/T6SNT72ZU8z6VAE1TGM5kcknwUsjA8MuS2b0OtGRtfhlyTArDWXYqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWpeev8a; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2366e5e4dbaso45734705ad.1;
        Mon, 14 Jul 2025 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752530879; x=1753135679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifiqAHNf1JDIJwOdCgwdg8rpBzDCZAH8z8rjgxIqajA=;
        b=SWpeev8aa4WnGktGZICyXYopP9j8TjXKNrTFRLqzUH+/WSC7jsGcl32+0yNocdKO10
         NrxpCw7OErnSjt+ds2pUOWFQVEfCbhvQ7eWzn8SkGxdLBmdvkdO391FZwWCyvVYe+Leh
         8E7lmwveD7x5EvjR2J+twkSkQoKL05lR3DSsGKYngyzyaMTkFBIf5K0dRg2h+ARv8ga2
         yGxtvKf5t8NFH0qHMk5zpVC2nE2/ZQdCAAq+qpefqyc6xb9GJuO6eH9YhYeIZYeqI/x9
         Pg2egyRa4EMytahCd5ritOuVvnH4ZsKLaVyvGalwGsbkxVznyALZZXKKstSItfU9E5hy
         0QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530879; x=1753135679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifiqAHNf1JDIJwOdCgwdg8rpBzDCZAH8z8rjgxIqajA=;
        b=hTkC+uaY4rTsQf8y+TFNPtHiCXKMOefQMrIZ6AwVuAUAJNCyU2Ha4GggsL+wdLJe3g
         kd7ynw4Neq5wdZZ700r5TwtX/7EdhY/zxDiNr1oLXD3NuxaEqPJdkkSxRSW0YtdLN95L
         cvBgxhmtA0Q2LPEueAlnmPStUL6pEajlml+TYhY9GpZEC1Bsc2KozhxP2eJsvtr5bSW+
         2xXfg+gjwS3yZ5LQ/VMZ3S1c8keVy5GID7inLItg+91AZBJ0nZvzt2dd+UrSqoWVuAr0
         3ODOvg89drwuh2HVT49XpgSAhDHN6C+UDP753Yra91pJWDiwnTEmCO04EzLUTo5dvO4s
         03XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnooo3YNbbsLZuqA2QGkWa7gKmaQf8dpDcpuHRM1TM2UVbWTTTrGHLLQX6t46TsHnsfyc1ns4uCwBS5t7z@vger.kernel.org, AJvYcCXB+Ffn4fluCw1JpBht3NFgYWyGhCVDsLJGtarenXwbnDPqF1U6aNMrnOOtNzNkM8TiqrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMCrNawO9AeLvnN5519QuH/Tw7mN79Lo7JddzZn3M+eJWcC02S
	gfme1iFrsh3p2iJqYzm7HK4S43q1XSAdw+g5E5wxwFCG1aHriON6WrvodbqEvu30mupDpp0UfIW
	qCM9C5ZSuFPZxUiQn+kxU23uAXqfyy6I=
X-Gm-Gg: ASbGncsC1sus8ked6gWwSZujoVoRDLfl3URg/46X1vuPGKsyZgbybid+Jg4alqKwMzi
	Boa+OOBMxK7TgwtWI6MB66g5ZrdPUDPyvWk5x32xlA79DysZvaMD4zeR7NCf0zB6yYlWZtKnc8N
	qe88qdDzwLmmruCbJ8Ui0Lg6hGTWavrg1NgbTeHvtwxUPv22buh1SN5zhyYvPgKN+lxOQa4OigK
	PypbqtbiXen0H3dwqW2v0GYBs/Voby/sg==
X-Google-Smtp-Source: AGHT+IHBi4YSYM22JyDkajLAHHpTjyZ6KJ6JdhVbdUuIpd2P8cADLImSIo3J3ZMuvtk41+qNAJU4Wuc1XNvDRqexj2I=
X-Received: by 2002:a17:902:c408:b0:233:d3e7:6fd6 with SMTP id
 d9443c01a7336-23e1a4c68a5mr19142995ad.19.1752530879121; Mon, 14 Jul 2025
 15:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn> <20250703121521.1874196-14-dongml2@chinatelecom.cn>
In-Reply-To: <20250703121521.1874196-14-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Jul 2025 15:07:42 -0700
X-Gm-Features: Ac12FXzZktxK-7DNUcyA9Bw6WUm6_7S9P23NsYI7i4a6eLH7GcPWEfGJI59jpDw
Message-ID: <CAEf4BzaxLm1qm-WxFKDWO0rHqUrvfg8sC0737MMKKQb77cRe7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 13/18] libbpf: support tracing_multi
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org, 
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:24=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> Add supporting for the attach types of:
>
> BPF_TRACE_FENTRY_MULTI
> BPF_TRACE_FEXIT_MULTI
> BPF_MODIFY_RETURN_MULTI
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  tools/bpf/bpftool/common.c |   3 +
>  tools/lib/bpf/bpf.c        |  10 +++
>  tools/lib/bpf/bpf.h        |   6 ++
>  tools/lib/bpf/libbpf.c     | 168 ++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h     |  19 +++++
>  tools/lib/bpf/libbpf.map   |   1 +
>  6 files changed, 204 insertions(+), 3 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 1342564214c8..5c97acec643d 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -422,6 +422,12 @@ struct bpf_link_create_opts {
>                 struct {
>                         __u64 cookie;
>                 } tracing;
> +               struct {
> +                       __u32 cnt;
> +                       const __u32 *btf_ids;
> +                       const __u32 *tgt_fds;

tgt_fds are always BTF FDs, right? Do we intend to support
freplace-style multi attachment at all? If not, I'd name them btf_fds,
and btf_ids -> btf_type_ids (because BTF ID can also refer to kernel
ID of BTF object, so ambiguous and somewhat confusing)

> +                       const __u64 *cookies;
> +               } tracing_multi;
>                 struct {
>                         __u32 pf;
>                         __u32 hooknum;
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 530c29f2f5fc..ae38b3ab84c7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -136,6 +136,9 @@ static const char * const attach_type_name[] =3D {
>         [BPF_NETKIT_PEER]               =3D "netkit_peer",
>         [BPF_TRACE_KPROBE_SESSION]      =3D "trace_kprobe_session",
>         [BPF_TRACE_UPROBE_SESSION]      =3D "trace_uprobe_session",
> +       [BPF_TRACE_FENTRY_MULTI]        =3D "trace_fentry_multi",
> +       [BPF_TRACE_FEXIT_MULTI]         =3D "trace_fexit_multi",
> +       [BPF_MODIFY_RETURN_MULTI]       =3D "modify_return_multi",
>  };
>
>  static const char * const link_type_name[] =3D {
> @@ -410,6 +413,8 @@ enum sec_def_flags {
>         SEC_XDP_FRAGS =3D 16,
>         /* Setup proper attach type for usdt probes. */
>         SEC_USDT =3D 32,
> +       /* attachment target is multi-link */
> +       SEC_ATTACH_BTF_MULTI =3D 64,
>  };
>
>  struct bpf_sec_def {
> @@ -7419,9 +7424,9 @@ static int libbpf_prepare_prog_load(struct bpf_prog=
ram *prog,
>                 opts->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI;
>         }
>
> -       if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
> +       if ((def & (SEC_ATTACH_BTF | SEC_ATTACH_BTF_MULTI)) && !prog->att=
ach_btf_id) {
>                 int btf_obj_fd =3D 0, btf_type_id =3D 0, err;
> -               const char *attach_name;
> +               const char *attach_name, *name_end;
>
>                 attach_name =3D strchr(prog->sec_name, '/');
>                 if (!attach_name) {
> @@ -7440,7 +7445,27 @@ static int libbpf_prepare_prog_load(struct bpf_pro=
gram *prog,
>                 }
>                 attach_name++; /* skip over / */
>
> -               err =3D libbpf_find_attach_btf_id(prog, attach_name, &btf=
_obj_fd, &btf_type_id);
> +               name_end =3D strchr(attach_name, ',');
> +               /* for multi-link tracing, use the first target symbol du=
ring
> +                * loading.
> +                */
> +               if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
> +                       int len =3D name_end - attach_name + 1;

for multi-kprobe we decided to only support a single glob  as a target
in declarative SEC() definition. If a user needs more control, they
can always fallback to the programmatic bpf_program__attach_..._opts()
variant. Let's do the same here, glob is good enough for declarative
use cases, and for complicated cases programmatic is the way to go
anyways. You'll avoid unnecessary complications like this one then.

BTW, it's not trivial to figure this out from earlier patches, but
does BPF verifier need to know all these BTF type IDs during program
verification time? If yes, why and then why do we need to specify them
during LINK_CREATE time. And if not, then great, and we don't need to
parse all this during load time.

> +                       char *first_tgt;
> +
> +                       first_tgt =3D malloc(len);
> +                       if (!first_tgt)
> +                               return -ENOMEM;
> +                       libbpf_strlcpy(first_tgt, attach_name, len);
> +                       first_tgt[len - 1] =3D '\0';
> +                       err =3D libbpf_find_attach_btf_id(prog, first_tgt=
, &btf_obj_fd,
> +                                                       &btf_type_id);
> +                       free(first_tgt);
> +               } else {
> +                       err =3D libbpf_find_attach_btf_id(prog, attach_na=
me, &btf_obj_fd,
> +                                                       &btf_type_id);
> +               }
> +
>                 if (err)
>                         return err;
>
> @@ -9519,6 +9544,7 @@ static int attach_kprobe_session(const struct bpf_p=
rogram *prog, long cookie, st
>  static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
>  static int attach_lsm(const struct bpf_program *prog, long cookie, struc=
t bpf_link **link);
>  static int attach_iter(const struct bpf_program *prog, long cookie, stru=
ct bpf_link **link);
> +static int attach_trace_multi(const struct bpf_program *prog, long cooki=
e, struct bpf_link **link);
>
>  static const struct bpf_sec_def section_defs[] =3D {
>         SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
> @@ -9565,6 +9591,13 @@ static const struct bpf_sec_def section_defs[] =3D=
 {
>         SEC_DEF("fentry.s+",            TRACING, BPF_TRACE_FENTRY, SEC_AT=
TACH_BTF | SEC_SLEEPABLE, attach_trace),
>         SEC_DEF("fmod_ret.s+",          TRACING, BPF_MODIFY_RETURN, SEC_A=
TTACH_BTF | SEC_SLEEPABLE, attach_trace),
>         SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC_ATT=
ACH_BTF | SEC_SLEEPABLE, attach_trace),
> +       SEC_DEF("tp_btf+",              TRACING, BPF_TRACE_RAW_TP, SEC_AT=
TACH_BTF, attach_trace),

duplicate


> +       SEC_DEF("fentry.multi+",        TRACING, BPF_TRACE_FENTRY_MULTI, =
SEC_ATTACH_BTF_MULTI, attach_trace_multi),
> +       SEC_DEF("fmod_ret.multi+",      TRACING, BPF_MODIFY_RETURN_MULTI,=
 SEC_ATTACH_BTF_MULTI, attach_trace_multi),
> +       SEC_DEF("fexit.multi+",         TRACING, BPF_TRACE_FEXIT_MULTI, S=
EC_ATTACH_BTF_MULTI, attach_trace_multi),
> +       SEC_DEF("fentry.multi.s+",      TRACING, BPF_TRACE_FENTRY_MULTI, =
SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
> +       SEC_DEF("fmod_ret.multi.s+",    TRACING, BPF_MODIFY_RETURN_MULTI,=
 SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
> +       SEC_DEF("fexit.multi.s+",       TRACING, BPF_TRACE_FEXIT_MULTI, S=
EC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
>         SEC_DEF("freplace+",            EXT, 0, SEC_ATTACH_BTF, attach_tr=
ace),
>         SEC_DEF("lsm+",                 LSM, BPF_LSM_MAC, SEC_ATTACH_BTF,=
 attach_lsm),
>         SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTACH_BTF =
| SEC_SLEEPABLE, attach_lsm),
> @@ -12799,6 +12832,135 @@ static int attach_trace(const struct bpf_progra=
m *prog, long cookie, struct bpf_
>         return libbpf_get_error(*link);
>  }
>

[...]

