Return-Path: <bpf+bounces-31733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB19028AC
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0471C21532
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B89D14AD3F;
	Mon, 10 Jun 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnDYCI6w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46326AF6;
	Mon, 10 Jun 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044246; cv=none; b=EnN21oqsWeH7VQtOglpo3hOjwkygRQ5/d76OqwAwTJLFFPV42NMQkf+SMBn4wueIvSS1NIkl5Mt5ufU1bx+A12HCbzTGmd2KyQT1PH898i6IormJrrwNuaJNlnBEGdMsg6t1Fnv7GTqoJQEwX7wW5qhrTVPNdacGqoYcrvcuEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044246; c=relaxed/simple;
	bh=bKZ7uXtHYV3lhrlpsqRdNO/3cBKQr8TOgCBnE+5IYDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfZS0S+yi9xNMp3DDoaGdPb32cVrA8Ra/eW9vyZ92P1UkWt/zznT2Mev2jD8kW4Xo7QGnlJIic5dUWTqTTIROGAULzQLwAEhoz7i0VEDV9AHouMmsTxu/7bhTR6/XYyxPRWCJ6TN4fj5uiOoTYaKdNTMJtvvS7Gobw9zgG5YMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnDYCI6w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1c567ae4so1656549f8f.1;
        Mon, 10 Jun 2024 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718044243; x=1718649043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHsuT5JGFFmWrXhZ4RDS1nh9UMmYpXpr9xPw7oqdTyA=;
        b=KnDYCI6wpfpzlOT6XtBHCwvfTGSOE1eHUzxyxB4RChA1KDv9hc5vGpEbyGaIMJU78t
         +646YiWT5dG29a3izcUwLQNOLStic2F9HevQk+HLGS8aukP8tFjqqfMUASsD01Z8bScQ
         LNGaB/4rJx2lp+SeR1wBK0lAm/r7SuZRMfMZ005a8zXlElMYXGxDrn4HiFJm4QOUCrbx
         F1SqotEgR3+nYuQ0TYtyj2w8Pe23hO1CgATvjuxFp/hIBzzTEzzdMrP7YUvG7hxTlUf8
         IN9tZD5iQXDisqlDND6bqpkttREuwp3Ebn00sa8TLrrllpq4YKXZSyxOPxUkqIBKV3/A
         rTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718044243; x=1718649043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHsuT5JGFFmWrXhZ4RDS1nh9UMmYpXpr9xPw7oqdTyA=;
        b=Q/1xhedujZWauRSlLsiaBMLsmlVx4kanQM1uoKXZ4EnhS774UMOv7oIkfFOIDsqXm1
         MhusTBT/1OB1xPcvFte+8LXw/Ya9hf09mmITZkD50ReQoLmdZNebcBMQkz0J9si8wZmI
         aqR+6iI/+8Sh+5o6QJRhEeNVi4dp5Bcb3WCZRbxNeHzpmO0QBO8bNeNthHiWDBkwOXU9
         0Q9yXZAfUTly4od1RdhXgAbTrpHeTXQ9vG03U2CLYx9dM1PLKqbdBQB6kyPE9lkvZ2lI
         6VA6Iergxh1vZ5ACwoAdc1wyIgfVC6RIgm3zMNJ0WF44DV6hcaanfyPKufD/1wnThtVG
         RbBw==
X-Forwarded-Encrypted: i=1; AJvYcCUBDU0T32qiJf13MtK/LUVbfzLAgKCsYsvTsluoOsoADXIBYIoJMi8UYdisDGq2QNooXP0Gul69FRXSX4Ot8JIIamN5t4ZWAqFHV1YCKL+qKgX4lCg75MQjZ2oH5Caf0G8h
X-Gm-Message-State: AOJu0Yx+c68yKx94fmayEKskMOsJ8mmVChfRcvcia+XKMwaF8EYbxd6g
	k/kl+zqOSQhMgHKyYTZjdb8yZJUBpLLLAjW1FGgmgzdUjW0iSNnkTxbuChRgHAsEApEzUViRtOL
	EOABppIHx/CRIKUyU4Dg5eGYlwXs=
X-Google-Smtp-Source: AGHT+IHQ6RIrxcggXaRSeCcpDy6qrZYaK7XLe+3tzgpwN3xM9tNPkqttXMDvP2qT3KYHpNSkkOIyQpe1y3ZAyF5LDTA=
X-Received: by 2002:a5d:59ae:0:b0:35f:2471:198a with SMTP id
 ffacd0b85a97d-35f24711a69mr2707284f8f.4.1718044243149; Mon, 10 Jun 2024
 11:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717881178.git.dxu@dxuuu.xyz> <e172bf47f32c6e716322bc85bb84d78b1398bd7c.1717881178.git.dxu@dxuuu.xyz>
In-Reply-To: <e172bf47f32c6e716322bc85bb84d78b1398bd7c.1717881178.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jun 2024 11:30:31 -0700
Message-ID: <CAADnVQLE=XcpZ4SnW=NARG0D5Ya6iU1-1CayTVmArnxpSzWSFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/12] bpf: verifier: Relax caller
 requirements for kfunc projection type args
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 2:16=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Currently, if a kfunc accepts a projection type as an argument (eg
> struct __sk_buff *), the caller must exactly provide exactly the same
> type with provable provenance.
>
> However in practice, kfuncs that accept projection types _must_ cast to
> the underlying type before use b/c projection type layouts are
> completely made up. Thus, it is ok to relax the verifier rules around
> implicit conversions.
>
> We will use this functionality in the next commit when we align kfuncs
> to user-facing types.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  kernel/bpf/verifier.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 81a3d2ced78d..0808beca3837 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11257,6 +11257,8 @@ static int process_kf_arg_ptr_to_btf_id(struct bp=
f_verifier_env *env,
>         bool strict_type_match =3D false;
>         const struct btf *reg_btf;
>         const char *reg_ref_tname;
> +       bool taking_projection;
> +       bool struct_same;
>         u32 reg_ref_id;
>
>         if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID) {
> @@ -11300,7 +11302,13 @@ static int process_kf_arg_ptr_to_btf_id(struct b=
pf_verifier_env *env,
>
>         reg_ref_t =3D btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_r=
ef_id);
>         reg_ref_tname =3D btf_name_by_offset(reg_btf, reg_ref_t->name_off=
);
> -       if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->of=
f, meta->btf, ref_id, strict_type_match)) {
> +       struct_same =3D btf_struct_ids_match(&env->log, reg_btf, reg_ref_=
id, reg->off, meta->btf, ref_id, strict_type_match);
> +       /* If kfunc is accepting a projection type (ie. __sk_buff), it ca=
nnot
> +        * actually use it -- it must cast to the underlying type. So we =
allow
> +        * caller to pass in the underlying type.
> +        */
> +       taking_projection =3D !strcmp(ref_tname, "__sk_buff") && !strcmp(=
reg_ref_tname, "sk_buff");

xdp_md/buff probably as well?

And with that share the code with btf_is_prog_ctx_type() ?

> +       if (!taking_projection && !struct_same) {
>                 verbose(env, "kernel function %s args#%d expected pointer=
 to %s %s but R%d has a pointer to %s %s\n",
>                         meta->func_name, argno, btf_type_str(ref_t), ref_=
tname, argno + 1,
>                         btf_type_str(reg_ref_t), reg_ref_tname);
> --
> 2.44.0
>

