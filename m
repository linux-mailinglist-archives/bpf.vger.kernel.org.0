Return-Path: <bpf+bounces-22988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D9A86BE36
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C801C21077
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A82D638;
	Thu, 29 Feb 2024 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0gY/B+q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A492557F
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169840; cv=none; b=CikVsjJcOfV8ZXnmii640oUmNf2uIctLeRmjjN5Z3Bzb3+hpWzUzkyqnAMO+c59Mn/xhF+amsAC6qnrcfSIfGvRcHO0hKjFEx4ORTyrQ1+byNN+1h2hQn7kORBFGREscbmCuivK+6zRvvYpgIlqmn62ihbPSz98mqQcU6mXOcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169840; c=relaxed/simple;
	bh=DmD4APbqdDX4ilBFFpoWJuKXNOFOv47EqEu1s70US8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzeZijzvIL4aF6T0swopW3QI+n6N2lvk9TzU+7RD0dkTTRmCY6XHlLaq4LZtQL9Z0MuYFFaq08YovTZsroV2zNtODaTwTdSwGSjjO19lp8siLajz7aJh/VEgiz9YEm2RgLSWwKMegGesJ8kXTaQd6s8LjnaPB1G74V0bvOXPR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0gY/B+q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso333561a12.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709169838; x=1709774638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIyurZrZBosVyz9ehMUHrEeXiyWo//LV7R5Zv5ifWKQ=;
        b=K0gY/B+qR0HPfH3xIgLFrU3uk774wVRcm9AKI5pMyafsIDHLhsve4wLBAD7/lWYfqZ
         STcKZGmLBCR3KnRjBn8OEYV8ZIPFAAaYwi/yV/gMKu6Lb/4tgZvyo8z2BlwfIN/cpHPl
         V0ltH1AaAiohVIsF7YKaedQAmK3/5WTTjOAqfuraqLheNrsSj59RxaXVzjakNaVbP4RX
         ZpKlgcOUAnLwdYaji5UNTWMIw8hpnp/tomybzIZ8xCc4k8KX7mbMVBQIyn3eaJEmbtnx
         u7459MATJXdTxJV7eRlUgcD2YMWo/Ah77Ioixi1JPnBR9fjMVy/7hAGeB+KaQx4706mI
         iyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169838; x=1709774638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIyurZrZBosVyz9ehMUHrEeXiyWo//LV7R5Zv5ifWKQ=;
        b=oSrz3IolDksGhHULm6gBflwytY1OsyvxhCGDS0MGMZQQNTu3IIl9f5i3B06N3NghLF
         yD9sqMuLOHVKtmImAuU0W4MRtoz/Gq0V/0KqVL9/3O07g7++CRDeZceoJURqvhU9geE3
         4U500ekttFE6mfpkQpT9ZTnjwWIyadzRDiBy2K3exSK3uc6EGN5KVT2m1vRxEfNC/RDj
         MgUyinIspO5KYMFuFjkKxsbHxlFiHEFLN5bpn9raq1xwMKoRmZy29X0B2cDrIsVrhKoU
         CKX1huS1R7aVrE3Q8JO+EagpqzeQfjWal1uDABgo/sOt/DYRcZU7VuwCez4f2mWHd/79
         9a4w==
X-Forwarded-Encrypted: i=1; AJvYcCWiJ8n4sBt5KFJhwZ6dQ0OZ49dUvGy9emdOUaPu3mfZigVNuOlDjorzhZMkgFM+b2uCQJAri/4elAQ+WoPT2YYLD87l
X-Gm-Message-State: AOJu0Yzyw+zO1nNfB55PvKZK4A/pUmC1AmfLKTi5aHk5xIfOj7Zde04r
	JDQzId69tKNaZ9tG/b/qwF5EM+Ct3vYjMejtl17PDIBqtxlJmsEwtfnOyckhh8Vztpm2zMVYUna
	xY7C/QgbMEXNJCkMYy6jBbheT3/0=
X-Google-Smtp-Source: AGHT+IGUb9luEHZ8dv1ebvn1/Nj0L3k9YIWAHwEniT3iswYnMMfZ8/Ol6fydfmZThExl6Mtstw0mYje7FEZd/VOwopc=
X-Received: by 2002:a05:6a20:2d24:b0:19e:a36c:36ef with SMTP id
 g36-20020a056a202d2400b0019ea36c36efmr1026227pzl.48.1709169838310; Wed, 28
 Feb 2024 17:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228090242.4040210-1-jolsa@kernel.org> <20240228090242.4040210-3-jolsa@kernel.org>
In-Reply-To: <20240228090242.4040210-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 17:23:45 -0800
Message-ID: <CAEf4Bzbga6PK8UNUO5ZHL0Zo3t6xQ8S0tY4Da6aB+AFvm_jjsQ@mail.gmail.com>
Subject: Re: [PATCH RFCv2 bpf-next 2/4] bpf: Add bpf_kprobe_multi_is_return kfunc
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:03=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding bpf_kprobe_multi_is_return kfunc that returns true if the
> bpf program is executed from the exit probe of the kprobe multi
> link attached in wrapper mode. It returns false otherwise.
>
> Adding new kprobe hook for kprobe program type.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/btf.c         |  3 +++
>  kernel/trace/bpf_trace.c | 49 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6ff0bd1a91d5..5ab55720e881 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -218,6 +218,7 @@ enum btf_kfunc_hook {
>         BTF_KFUNC_HOOK_SOCKET_FILTER,
>         BTF_KFUNC_HOOK_LWT,
>         BTF_KFUNC_HOOK_NETFILTER,
> +       BTF_KFUNC_HOOK_KPROBE,
>         BTF_KFUNC_HOOK_MAX,
>  };
>
> @@ -8112,6 +8113,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_pro=
g_type prog_type)
>                 return BTF_KFUNC_HOOK_LWT;
>         case BPF_PROG_TYPE_NETFILTER:
>                 return BTF_KFUNC_HOOK_NETFILTER;
> +       case BPF_PROG_TYPE_KPROBE:
> +               return BTF_KFUNC_HOOK_KPROBE;
>         default:
>                 return BTF_KFUNC_HOOK_MAX;
>         }
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 726a8c71f0da..cb801c94b8fa 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2594,6 +2594,7 @@ struct bpf_kprobe_multi_run_ctx {
>         struct bpf_run_ctx run_ctx;
>         struct bpf_kprobe_multi_link *link;
>         unsigned long entry_ip;
> +       bool is_return;
>  };
>
>  struct user_syms {
> @@ -2793,11 +2794,13 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_r=
un_ctx *ctx)
>
>  static int
>  kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> -                          unsigned long entry_ip, struct pt_regs *regs)
> +                          unsigned long entry_ip, struct pt_regs *regs,
> +                          bool is_return)
>  {
>         struct bpf_kprobe_multi_run_ctx run_ctx =3D {
>                 .link =3D link,
>                 .entry_ip =3D entry_ip,
> +               .is_return =3D is_return,
>         };
>         struct bpf_run_ctx *old_run_ctx;
>         int err;
> @@ -2830,7 +2833,7 @@ kprobe_multi_link_handler(struct fprobe *fp, unsign=
ed long fentry_ip,
>         int err;
>
>         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> -       err =3D kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip),=
 regs);
> +       err =3D kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip),=
 regs, false);
>         return link->is_wrapper ? err : 0;
>  }
>
> @@ -2842,7 +2845,7 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, u=
nsigned long fentry_ip,
>         struct bpf_kprobe_multi_link *link;
>
>         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> +       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, t=
rue);
>  }
>
>  static int symbols_cmp_r(const void *a, const void *b, const void *priv)
> @@ -3111,6 +3114,46 @@ int bpf_kprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>         kvfree(cookies);
>         return err;
>  }
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc bool bpf_kprobe_multi_is_return(void)

and for uprobes we'll have bpf_uprobe_multi_is_return?...

BTW, have you tried implementing a "session cookie" idea?


> +{
> +       struct bpf_kprobe_multi_run_ctx *run_ctx;
> +
> +       run_ctx =3D container_of(current->bpf_ctx, struct bpf_kprobe_mult=
i_run_ctx, run_ctx);
> +       return run_ctx->is_return;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
> +BTF_ID_FLAGS(func, bpf_kprobe_multi_is_return)
> +BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
> +
> +static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfun=
c_id)
> +{
> +       if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
> +               return 0;
> +
> +       if (prog->expected_attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> +               return -EACCES;
> +
> +       return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &kprobe_multi_kfunc_set_ids,
> +       .filter =3D bpf_kprobe_multi_filter,
> +};
> +
> +static int __init bpf_kprobe_multi_kfuncs_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprob=
e_multi_kfunc_set);
> +}
> +
> +late_initcall(bpf_kprobe_multi_kfuncs_init);
>  #else /* !CONFIG_FPROBE */
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog)
>  {
> --
> 2.43.2
>

