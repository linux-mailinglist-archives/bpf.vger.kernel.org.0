Return-Path: <bpf+bounces-49696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB892A1BC4B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEBD188387B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A852236F1;
	Fri, 24 Jan 2025 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVxWnVfW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1191223328;
	Fri, 24 Jan 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744262; cv=none; b=IROnMreukbJumKGoytDKNjf2LVRrYtnrL6O7TqGYtrVwWUoQ+Gha5GLLTns/NrSYY23DGo9SFJCTm/lyEFagl3kaEjG3o2PfEgkNuXunv/NlevTtrAmUb7kD5VZ0LxTgSNaBgGPDgeLxpO4Kp6A7hRcGij520eQ92hJBzqVF6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744262; c=relaxed/simple;
	bh=swjNgBM9FbK2sXKFxU6qcJBLExgx+sFCNCrY/Nu9oXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUongE2cdkt0ZvUeWqIWQdMTGLHiqe2V6M/oMNvlx7TXSDeG39xzOi37lPZvdxb5aegv0BnIXJFxDSr5CQ/bGPoT5Mp8kNx1WGYQj5uSNlW/pKNANIzftbsK7YGRBp+a1U8JTEFtjTZqhRYs8FZkxRnH8k0VuXcXqidwENPc4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVxWnVfW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so4274204a91.3;
        Fri, 24 Jan 2025 10:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737744260; x=1738349060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns5/auv2UTuQ2jSAz+EklmLm9vKfhvXOtIW/L+0+qGw=;
        b=CVxWnVfWxRVI3wZtv4svaFiQkUIRJEZtNjuRL8ZF7SOPVMQPf6dkRitpXQ6xb6f+rJ
         jxCoYxrdqhBWP2+ZDjeSzT4iA4mSs4c8n/vaokEuObYrOgNG4SXMNBnU3D4rLEdOwL2J
         MBFUgdSo1f0xxhfBWJwzkQxv4mtHVunu+Bw9gTjwLsrOCkaXaOdznIAf2zV8fBH0geZM
         WAegX/NnSbeBiV8JOHjM0Uj5D0ORl90Mj7QrmxefSveTrnc9+gbfy7eugzeLNrYRh5lo
         rkHyVgOdk0w/BKMue6jS5GiwvcS3WuhcLMuw1/moiygtRRDS08sxVps6pR7dtfxt/WSj
         CG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737744260; x=1738349060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ns5/auv2UTuQ2jSAz+EklmLm9vKfhvXOtIW/L+0+qGw=;
        b=d+kM7CMDBLPCgAEE7FA3FMYd+o3CQOwJSD9cZCPedwstPQecF2RwQfSpXI35mfs+mw
         OREPloJN+wspIfFvqygZbS7HKmWq1Efoq6MAOucQYQQld9lkmqPOtPNVlBOXr16In6mU
         Pz1i8qOQE9rmZAibvVfRZvo58a8rYKdqTSygNnD51jYFaaZ/b8KKXElWRZm4XjD+PmP1
         CQZ+N+Bq627yczKc+qluGKeT+Coh4ocEHS/rtAjx3s8gGNxTXLIkasikRpB/6La55/Kr
         bgBbX3ISufN1g+0WjIWkacPLCcBVph0ahvuKecoSzuqDdwTH7B7aDdV82d3cxOYbxWMr
         sMFg==
X-Forwarded-Encrypted: i=1; AJvYcCU04cTGtsVLcsMY0Qo1iZXNhlVsbVHZI8wNURtEHljDEh6kTJIBN432EkM1aYp3W7PVXctqc5oxmYBR8V1Y@vger.kernel.org, AJvYcCVObzb3er4h5RSTUq/4z/Wkng0N8LO2FIODuWDrtDDNq3uxbG7tgb/mkk9bdBNdWVV5EGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+74Wcse93/dqDSeqANKZROJMvsQ/EWY9Od64DT9bsQ6PsgcT
	er3TnaKRTZKH7Ch7zuseP/Q0X94JosRvI1AGnUDwqoo/KV7RHAD/20LmCHZ7dqi9hdP38F65XkW
	XODagHRX1jhnWNMKubOUbuNKWcLcVpoAF
X-Gm-Gg: ASbGncuPj7dDsJ/bwMUOpCBt/sIVVonNiqw/tN895BllPm1/uUk++Z4glrlpySBmi/C
	oA4eEk8KAs9V2bTcBz5zdMjRSQ2dCazsTeJuVK7JXHiL+vb8NTDSVc65tghzmNDOabqoW8i9c8p
	57yg==
X-Google-Smtp-Source: AGHT+IE4Ip5HGtXfgggGiwrtTkKrK2Z/y+E6GJ1HeVCZ+eFJtEG8Yyk9aTfTjxKrVo7AD/MRUDYY+B6AnGYmlivAr6o=
X-Received: by 2002:a05:6a00:2443:b0:726:c23f:4e5c with SMTP id
 d2e1a72fcca58-72daf9be6a8mr39016904b3a.1.1737744260081; Fri, 24 Jan 2025
 10:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124144411.13468-1-chen.dylane@gmail.com> <20250124144411.13468-2-chen.dylane@gmail.com>
In-Reply-To: <20250124144411.13468-2-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 10:44:08 -0800
X-Gm-Features: AWEUYZncRpNZnsnYdJLCAAiqMOcDet23uCL713BqHcC_lWiU5x0I_3T4mNxTY7c
Message-ID: <CAEf4BzYTGiAedD8zEmw16NQ6JWAtkwDU2rhGLGZjXL0H1iKO+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: Refactor libbpf_probe_bpf_helper
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 6:44=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> Extract the common part as probe_func_comm, which will be used in
> both libbpf_probe_bpf_{helper, kfunc}
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf_probes.c | 38 ++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index 9dfbe7750f56..b73345977b4e 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -413,22 +413,20 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map=
_type, const void *opts)
>         return libbpf_err(ret);
>  }
>
> -int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_=
id helper_id,
> -                           const void *opts)
> +static int probe_func_comm(enum bpf_prog_type prog_type, struct bpf_insn=
 insn,
> +                          char *accepted_msgs, size_t msgs_size)
>  {
>         struct bpf_insn insns[] =3D {
> -               BPF_EMIT_CALL((__u32)helper_id),
> +               BPF_EXIT_INSN(),
>                 BPF_EXIT_INSN(),
>         };
>         const size_t insn_cnt =3D ARRAY_SIZE(insns);
> -       char buf[4096];
> -       int ret;
> +       int err;
>
> -       if (opts)
> -               return libbpf_err(-EINVAL);
> +       insns[0] =3D insn;
>
>         /* we can't successfully load all prog types to check for BPF hel=
per
> -        * support, so bail out with -EOPNOTSUPP error
> +        * and kfunc support, so bail out with -EOPNOTSUPP error
>          */
>         switch (prog_type) {
>         case BPF_PROG_TYPE_TRACING:

there isn't much logic that you will extract here besides this check
whether program type can even be successfully loaded, so I wouldn't
extract probe_func_comm(), but rather extract just the check:

static bool can_probe_prog_type(enum bpf_prog_type prog_type)
{
        /* we can't successfully load all prog types to check for BPF
helper/kfunc
         * support, so check this early and bail
         */
        switch (prog_type) {
            ...: return false
        default:
            return true;
}


And just check that can_probe_prog_type() inside
libbpf_probe_bpf_helper and libbpf_probe_bpf_kfunc

pw-bot: cr

> @@ -440,10 +438,26 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog=
_type, enum bpf_func_id helpe
>                 break;
>         }
>
> -       buf[0] =3D '\0';
> -       ret =3D probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(b=
uf));
> -       if (ret < 0)
> -               return libbpf_err(ret);
> +       accepted_msgs[0] =3D '\0';
> +       err =3D probe_prog_load(prog_type, insns, insn_cnt, accepted_msgs=
, msgs_size);
> +       if (err < 0)
> +               return libbpf_err(err);
> +
> +       return 0;
> +}
> +
> +int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_=
id helper_id,
> +                           const void *opts)
> +{
> +       char buf[4096];
> +       int ret;
> +
> +       if (opts)
> +               return libbpf_err(-EINVAL);
> +
> +       ret =3D probe_func_comm(prog_type, BPF_EMIT_CALL((__u32)helper_id=
), buf, sizeof(buf));
> +       if (ret)
> +               return ret;
>
>         /* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func=
_id)
>          * at all, it will emit something like "invalid func unknown#181"=
.
> --
> 2.43.0
>

