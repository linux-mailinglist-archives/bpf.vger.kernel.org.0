Return-Path: <bpf+bounces-78794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4E9D1BE8F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 468DD30504F4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13029A30E;
	Wed, 14 Jan 2026 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV7FCV1Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0D287245
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353777; cv=none; b=Vs+64iAg33FwjfpOahOyw5JUiz4YWGq1qC/U+AJ8mNK7NFYwGC+whnHmrWGUSZNP74FNvU4M5si/8PUz3tIQecAkVGooNm0mOHeRss9BWwvXjY86PhIlxi/vIcxfYxvekFNw/AOEjUrWl1qPHzyXO5DWbSA/dLFzlJYcIJDIVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353777; c=relaxed/simple;
	bh=V9PR7P8+oHvSzq9IvIAWUry3qBCyDc5DQcqO7Fyg0iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuYKD0rzzT0QQfGvDRyRYf6yUO9RPPo5McFvI7r4OAyqG5Y5aByCtNy41EY9DIuDjtQqLo3iQHNt0cv4nL6gbRD0cPGgKg8i7wsUIKpqegsJb8e9Z2fRDjAwXpxjNHTpaA6N9eyCu0/22Z/v2/hdF+R5hKtmBurwdUAmSRPHRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RV7FCV1Z; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c2af7d09533so5225733a12.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353774; x=1768958574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp3yniDKb6aM9fUToSqoqN/fYQ0OnPThNrfUdPGCP3M=;
        b=RV7FCV1ZREF1tCkArG+zf8JRGZsFeBm0AtsVnpNAZPSPfFl2gjkCIx8SmnI7YBY56f
         e15S+Ic5uTKchNzEyOeIjDFtkIqgqu16hs9rvy3NaOJyUYyBjecyCFi1NnwuWXFaTFuU
         GGV7d7veNGz3Mxp+bDUkXLv5IdmpxbT5eR7sJl0NSfOsjT7jugZr8bJfW0sN4DU9AhI9
         tZubiLo9F5uYJi41VU8BPG2awkOZuap8cGzRPQNnUQUm1kc0fv+Ihvh8w6Y7h3I6athU
         eC1C0azdtINaonxIXU+lhisu/D+hVB5soP219q9HdY8x+sWYUaUhc8AStSubSNf/LRD4
         lTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353774; x=1768958574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pp3yniDKb6aM9fUToSqoqN/fYQ0OnPThNrfUdPGCP3M=;
        b=vSQAw+FxnvFHgAvQu7QfTeUM1xFzeIkd4gd6b4I1e5jA7m5vFofGgrpLzIMvX2A1Jk
         SS/ZZ4XjSKO7VjImyQDGkMNAlUxdRfso++xmPSts5YU8hDM7VlWqa7YGVxKX8vjFFBK6
         v9IWan1WaiSvxXZAzFT/oVWcNE7BcXOQpRFkpzW3EBBjoaHx4R/IvviGYB5v1+uj17zj
         SBvaUtKufxSApKPdhjrvUKA0sv4q5QXMQwMbd7Yp1lxnhMJcEoQXgymAqEP1wn2005FP
         quFDaxXP1mtdkYUx2fH0TR8p1yR1gs+JDLO8c9v1Xlyj/Qhw3dYIHzMYrd9oMlLcjZu/
         fVCA==
X-Forwarded-Encrypted: i=1; AJvYcCVSANQBgpJJNKBj/Zda2D5KT94DQDIPJYsIFIIFQkyi6AA2QI0WsJJvpXH9EpPVkMr8m80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhgw897GwCY2+5poxjDm7wUjJ/UeJ2ePqW9lUw0h5I40Q6YLj
	8z5BNpew0QPL1v7Yrvo7lzvMI7XclZs2gmeUhCHE07CZx1wf02o0Y2WGnPHUf5vUmzo9CEaje6u
	TSd2Zn5X5X/lxy8RU8v0hAay8L+NzyA4=
X-Gm-Gg: AY/fxX7IjGDtn27D7onyTg/u5Ft9kzgxAHpKeoxZAGLxEXTOjXv/BqomNGy/QCGkaXe
	u5JyQbpmPoeSBZ/E3+sPBG6T277LM1wYPs6p/JQQRJ78GRXguXcSmtFMibSjM7jikvTVFH8rNPS
	M5obZwbgmwpeEqVDXyJBskSdQTZcF6SDWoufrbAPQuNhrcM4T3YA35aV5gZIc+vP19BbIbnm64A
	WNjhNChSk5pSPdv91KJoeNW+Gu3JLDyg7o+eyW5ssmxiBs/tX/AIrXIV/n9niyPjo7RrjNh2REm
	UC1IOywT7bs=
X-Received: by 2002:a05:6a21:6d8a:b0:366:5d1a:c737 with SMTP id
 adf61e73a8af0-38befa93165mr420367637.16.1768353773854; Tue, 13 Jan 2026
 17:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-2-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:22:41 -0800
X-Gm-Features: AZwV_QhlOKou7QUKKKa_VDsCfGtSaih_Vd9EBFHnlGVLosadwfHVqjBxzWeHa9Y
Message-ID: <CAEf4Bzb+p4fXkCL01MVrvCwPvboeMWXgu4uTSMhweO_MYL+tqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 01/11] bpf: add fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The fsession is something that similar to kprobe session. It allow to
> attach a single BPF program to both the entry and the exit of the target
> functions.
>
> Introduce the struct bpf_fsession_link, which allows to add the link to
> both the fentry and fexit progs_hlist of the trampoline.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v5:
> - unify the name to "fsession"
> - use more explicit way in __bpf_trampoline_link_prog()
>
> v4:
> - instead of adding a new hlist to progs_hlist in trampoline, add the bpf
>   program to both the fentry hlist and the fexit hlist.
> ---
>  include/linux/bpf.h                           | 19 +++++++++
>  include/uapi/linux/bpf.h                      |  1 +
>  kernel/bpf/btf.c                              |  2 +
>  kernel/bpf/syscall.c                          | 18 ++++++++-
>  kernel/bpf/trampoline.c                       | 40 ++++++++++++++++---
>  kernel/bpf/verifier.c                         | 12 ++++--
>  net/bpf/test_run.c                            |  1 +
>  net/core/bpf_sk_storage.c                     |  1 +
>  tools/include/uapi/linux/bpf.h                |  1 +
>  .../bpf/prog_tests/tracing_failure.c          |  2 +-
>  10 files changed, 87 insertions(+), 10 deletions(-)
>

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 539c9fdea41d..8b1dcd440356 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct bpf_ve=
rifier_log *log, const struct
>                 case BPF_TRACE_FENTRY:
>                 case BPF_TRACE_FEXIT:
>                 case BPF_MODIFY_RETURN:
> +               case BPF_TRACE_FSESSION:
>                         /* allow u64* as ctx */
>                         if (btf_is_int(t) && t->size =3D=3D 8)
>                                 return 0;
> @@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
>                         fallthrough;
>                 case BPF_LSM_CGROUP:
>                 case BPF_TRACE_FEXIT:
> +               case BPF_TRACE_FSESSION:

According to the comment below we make this exception due to LSM.
FSESSION won't be using FSESSION programs, no? So this is not
necessary?

>                         /* When LSM programs are attached to void LSM hoo=
ks
>                          * they use FEXIT trampolines and when attached t=
o
>                          * int LSM hooks, they use MODIFY_RETURN trampoli=
nes.

[...]

> @@ -4350,6 +4365,7 @@ attach_type_to_prog_type(enum bpf_attach_type attac=
h_type)
>         case BPF_TRACE_RAW_TP:
>         case BPF_TRACE_FENTRY:
>         case BPF_TRACE_FEXIT:
> +       case BPF_TRACE_FSESSION:
>         case BPF_MODIFY_RETURN:
>                 return BPF_PROG_TYPE_TRACING;
>         case BPF_LSM_MAC:
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 2a125d063e62..11e043049d68 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -111,7 +111,7 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *p=
rog)
>
>         return (ptype =3D=3D BPF_PROG_TYPE_TRACING &&
>                 (eatype =3D=3D BPF_TRACE_FENTRY || eatype =3D=3D BPF_TRAC=
E_FEXIT ||
> -                eatype =3D=3D BPF_MODIFY_RETURN)) ||
> +                eatype =3D=3D BPF_MODIFY_RETURN || eatype =3D=3D BPF_TRA=
CE_FSESSION)) ||
>                 (ptype =3D=3D BPF_PROG_TYPE_LSM && eatype =3D=3D BPF_LSM_=
MAC);

this is getting crazy, switch to the switch (lol) maybe?

>  }
>
> @@ -559,6 +559,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tr=
amp(struct bpf_prog *prog)
>                 return BPF_TRAMP_MODIFY_RETURN;
>         case BPF_TRACE_FEXIT:
>                 return BPF_TRAMP_FEXIT;
> +       case BPF_TRACE_FSESSION:
> +               return BPF_TRAMP_FSESSION;
>         case BPF_LSM_MAC:
>                 if (!prog->aux->attach_func_proto->type)
>                         /* The function returns void, we cannot modify it=
s
> @@ -596,6 +598,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tram=
p_link *link,
>  {
>         enum bpf_tramp_prog_type kind;
>         struct bpf_tramp_link *link_exiting;
> +       struct bpf_fsession_link *fslink;

initialize to NULL to avoid compiler (falsely, but still) complaining
about potentially using uninitialized value

> +       struct hlist_head *prog_list;
>         int err =3D 0;
>         int cnt =3D 0, i;
>

[...]

> -       hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
> -       tr->progs_cnt[kind]++;
> +       hlist_add_head(&link->tramp_hlist, prog_list);
> +       if (kind =3D=3D BPF_TRAMP_FSESSION) {
> +               tr->progs_cnt[BPF_TRAMP_FENTRY]++;
> +               fslink =3D container_of(link, struct bpf_fsession_link, l=
ink.link);
> +               hlist_add_head(&fslink->fexit.tramp_hlist,
> +                              &tr->progs_hlist[BPF_TRAMP_FEXIT]);

fits under 100 characters? keep on a single line then

> +               tr->progs_cnt[BPF_TRAMP_FEXIT]++;
> +       } else {
> +               tr->progs_cnt[kind]++;
> +       }
>         err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>         if (err) {
>                 hlist_del_init(&link->tramp_hlist);
> -               tr->progs_cnt[kind]--;
> +               if (kind =3D=3D BPF_TRAMP_FSESSION) {
> +                       tr->progs_cnt[BPF_TRAMP_FENTRY]--;
> +                       hlist_del_init(&fslink->fexit.tramp_hlist);
> +                       tr->progs_cnt[BPF_TRAMP_FEXIT]--;
> +               } else {
> +                       tr->progs_cnt[kind]--;
> +               }
>         }
>         return err;
>  }
> @@ -659,6 +683,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tr=
amp_link *link,
>                                         struct bpf_trampoline *tr,
>                                         struct bpf_prog *tgt_prog)
>  {
> +       struct bpf_fsession_link *fslink;

used in only one branch, move declaration there?

>         enum bpf_tramp_prog_type kind;
>         int err;
>
> @@ -672,6 +697,11 @@ static int __bpf_trampoline_unlink_prog(struct bpf_t=
ramp_link *link,
>                 guard(mutex)(&tgt_prog->aux->ext_mutex);
>                 tgt_prog->aux->is_extended =3D false;
>                 return err;
> +       } else if (kind =3D=3D BPF_TRAMP_FSESSION) {
> +               fslink =3D container_of(link, struct bpf_fsession_link, l=
ink.link);
> +               hlist_del_init(&fslink->fexit.tramp_hlist);
> +               tr->progs_cnt[BPF_TRAMP_FEXIT]--;
> +               kind =3D BPF_TRAMP_FENTRY;
>         }
>         hlist_del_init(&link->tramp_hlist);
>         tr->progs_cnt[kind]--;

[...]

