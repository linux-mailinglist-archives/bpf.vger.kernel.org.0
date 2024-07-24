Return-Path: <bpf+bounces-35581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389193B970
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 01:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0961E1C2186A
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B7142659;
	Wed, 24 Jul 2024 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR/pVsM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692118E10;
	Wed, 24 Jul 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721863813; cv=none; b=YNnlutepvzdmdanSYjv33U01Rq6naowRQDivTfpEZ2zxijqbjRkrSgU9PbmiA4O0ePqxASb4vGjydJ40JzDatv0W2NCWtgcUE2PKXymRn8kZD2Id+dc3Svp662j1f1qi9ro9anwRma8ENX9fQwXxc2o0pXi0zuFvNDsZxil3ClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721863813; c=relaxed/simple;
	bh=qUQWp7xslV6alFBkjtNQVWInvD8M/M2ljHxy5fdr5SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ad8qhV8MQaL9zQxyt/JIvfIM+Zy437tpqiwwf/XXza+trLlYvcDLygZ3Q5uxbsC78qeZl7C4ZhqZeC8BD3z2dr+MZo1WaZsLAUZfoNHxLBPbU8icGon2JZWotw0rFLckir660gXMRaAR+vPuwt/1OPOfNn0KNYIEWM9A5Ka87B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR/pVsM8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb55418470so266112a91.1;
        Wed, 24 Jul 2024 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721863811; x=1722468611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rekp8AoedR+ZAA6LWf1d+Lz4IL9HB1czD7tOuhj7qTA=;
        b=UR/pVsM8FpGMO341xtjC48uK/EOTp1KVyCczrzIRD29UFYGkTsg6AjdSSLnlKqz50u
         dMNhVb1P6c/3IypsvrDAwU6KFNIu4wLNqK4pzEMMpJLHwA5VUVNo2m2j4KIuDhlRd9Tc
         fIpGmZHT0q9f8gOqLZLl/B8t95smxvaDbW/XhK6it2u7881mrXzUdUqyAItzyBPxqqJW
         KvEuU3/CuS129VvlCiXCBbbfR7ny1jPB+3QCJMSbRcPFoQrtr1Gl2FPNW7PD6/OCLAr+
         jKc46HZmZlgnx2KNE0bMMJUQxixYwZHpkm5wtLwrhuO+uj0a6AI2mT1q811DB20zDYB0
         H5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721863811; x=1722468611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rekp8AoedR+ZAA6LWf1d+Lz4IL9HB1czD7tOuhj7qTA=;
        b=IuYh5B2/YKzLzYVCUkXC/yiXl9WP77fT3KfOtfCaqX5q4aC7J8j8xA7JM04Ko8Jbni
         9u84GvN81fBehk6UmOJ2M2J0Cm5TObqUxisfQCh42BS2OGJRRNOmw2SfPW6cyYZql80a
         YMPKW7PrXBUFf3MIhbmG4a64BoheRL1SW9NIljtLhuAL0qbosD1E5sFmQyLVpQ4jQRJq
         6rGPaXiGN27qZCBXS0DKQNO/V7bHsQdkMvrZHyf7oNeMNMM8Q2RsgsfDbqZnAh5osB5B
         ABVDPPMQ0HHlRR+GzXevniMfhhG9iJdhPRsZ8FOy0Abf0KfT1GrQG5/QvJP+M2jbPj7h
         0zdA==
X-Forwarded-Encrypted: i=1; AJvYcCXFv5msE1StoeT0NuQWBZhk1gByFdAkMsfMWuROsNz/rHL9n6tOvwV4Wdax3qr/GjRuBV+y+n0ZHTrlfVipTqah/rbu0nDztMUuYBQpEWHLazdeAl/yD3qo8cMU27B02VuIBBHjkgpOzSwMjAsjWu002ybAnYapNoCrqcdPEoFKxzF8aliq
X-Gm-Message-State: AOJu0YxJRD18iX/vtRoPcyaHRIVCRIk+1pfdoanwHJ2TzthHuX94pc8V
	rIJ9HR/rlkX29ywclYB0J/ECjaSJ+NtTGJmVGlBR7Spa37+US8iHaPf+lPZqRYSwZ8Chmczl1n4
	2ujqqoCgWkW5ETwp7XKSV1eW5c0k=
X-Google-Smtp-Source: AGHT+IGs7+UI9LvHaqkX9zkckiGm/WOZ1NEhfaleFO/gJ6YfCWY/NaQdZRaZ5mgyfjBGdH58zivYRFH/EQ/dB0V1ELU=
X-Received: by 2002:a17:90b:3b90:b0:2c9:8189:7b4f with SMTP id
 98e67ed59e1d1-2cf2eb067d6mr51146a91.32.1721863811538; Wed, 24 Jul 2024
 16:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723012827.13280-1-technoboy85@gmail.com> <20240723012827.13280-2-technoboy85@gmail.com>
In-Reply-To: <20240723012827.13280-2-technoboy85@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jul 2024 16:29:59 -0700
Message-ID: <CAEf4Bzb8kj2L+MNgcCXCPC9RBm1K8wyrHiYF+OqsVe1Ymfoc1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: enable generic kfuncs for
 BPF_CGROUP_* programs
To: technoboy85@gmail.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 6:28=E2=80=AFPM <technoboy85@gmail.com> wrote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> These kfuncs are enabled even in BPF_PROG_TYPE_TRACING, so they
> should be safe also in BPF_CGROUP_* programs.
>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---
>  kernel/bpf/helpers.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5f0adae8293..23b782641077 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3051,6 +3051,12 @@ static int __init kfunc_init(void)
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &gene=
ric_kfunc_set);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS=
, &generic_kfunc_set);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &=
generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB=
, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_DEV=
ICE, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K_ADDR, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SYS=
CTL, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
KOPT, &generic_kfunc_set);

a bit crazy we have so many cgroup program types, but it is what it
is, this lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>         ret =3D ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
>                                                   ARRAY_SIZE(generic_dtor=
s),
>                                                   THIS_MODULE);
> --
> 2.45.2
>
>

