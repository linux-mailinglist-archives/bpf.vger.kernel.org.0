Return-Path: <bpf+bounces-73515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101F3C334D6
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D523BAF5D
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2363148D8;
	Tue,  4 Nov 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtjdVBBf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52E2765DC
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296437; cv=none; b=B6WSXcyWhNCY/P2SXt54G2Qsq90x7EBy0Nh5hFL528hrWZYSgQcsd/V8iFavtj050VPz7DaE0tQvsw8U2ownEH/PukVVTrTpk+TQdKnge0nuHR8+lAQS25v4EggalKJr2qi4k6gA1bbyIcEZbOznBRgx9pzCoJElK03xlSrBJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296437; c=relaxed/simple;
	bh=ttE5S7wwqPw49dyHopnuwUPC3BigiKb4GjHcvddERr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQJ22P2x2KQlaijeycdJQVknNhpLAqj9CA/o6FDh+VJtftWTd7E95VD+K5PrIiUJX3SODqZlhkX/XP1DwmG6o95G2tc/aOSXsY+7xQqQInaOBf3u4H55rky7q0Uz6Hs3Hz9rlve9MapBwbpzxXGt3fNEeBhwnbW5MRADe8YqK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtjdVBBf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3407f385dd0so3987650a91.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 14:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762296435; x=1762901235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oex3gVqJV7cKxXXag2BN3RgEpKXJjKKoWEzC9BYAilE=;
        b=OtjdVBBfem3249yALnZGqs0o38y9DKSY/cTI5nOpF0q8PuQqG5WzLn6lCiiqQ+AwDR
         jDItYV7mymvJ6qV27/Yzq4EG+7vkzectN/kRoftX9hoP8l+voJddt3p+wuYh/jNITYuj
         tPXSOSjJk1tdqkvZ0pAoLpddx5dSBCDBg6+njm2ZDo0uzhYRdmXZRBLC3lxfLVjU52ZH
         RPqtUnoXw1+qa+UK6JVzdv1dgP/JZTPlAejOdXgKqaiIEH0JVuPFktlx57QGmnWfqEa9
         RDcyyT5jVWq6F69ZpEAjcX+pI8MsvLN6YYIE4YJS37fNePN1gAgtM+V3+B708hEEZhRk
         5cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296435; x=1762901235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oex3gVqJV7cKxXXag2BN3RgEpKXJjKKoWEzC9BYAilE=;
        b=ScpxjTxYMbwFHtc46H2L/l1hjacs/JXxrlVDVsVTIZTMKctH+5JQZJMVCuonBHpJ60
         IwxHy2XhiEk7IrIV2oZQM1FccygVa5wQggseXwhLTqBwtPhKKCPKFJiQrJlxqMK5Mscd
         XZYdbuWqY1vbhPuWI2Jcqa0u/Aemoc+RoZxZz5fsq90PbqpLlc6+MU0Bg/BVv1zwpnUa
         TkNTxXtapQPVJZxePnMpMK6XmE9ez8Zokvwm8yFc6w5K899f3Tl0F6U9MQcdKzQiamWO
         rxbRYnuSaQDh+6z+Hfe9UvlVtQ3GBOvo7mZpgGxt5leEncjjfZctztwlHJFbTkQw18Ov
         cODA==
X-Gm-Message-State: AOJu0YxYsjEMQY1g6TvMKU+gi6vUGoWak6seA+v5bUzAXNHz65CpH5Tq
	+mcpV/znFzo1FyPF8wspn29vUf/pfdso0t9UNPRhNChwI9SN481rutLUoD5I+CRuj2YBhOkP6KM
	2wXkYU3cDx/OZICd76PtllR59ZLvvs4c=
X-Gm-Gg: ASbGncs+KsCHRmDF1TENoRqAR0KAomFoB6xweZ96ClWf4Of0n3C7QU84xd64GqgTUF6
	qRj04dK8GlGXjkVqcC5zxi4/RL/4rdVqlKgAVRd7lCFiV4T5tDPdKWywVLrHli3QxXYC8KMo4fx
	vRy5cP64KlhdxQeBbkaoow5S3D2wI+USgY60lq/Cc+4XTrKDly3avD0frcLWN+d9ypEspiMXg4l
	+6hC2ELcbfXFKHVo/M2VvRMCE11zARfkt4FVc60T3Lm4J484/mI0MV1/nhcUF0c/GfgxYC6n3J6
X-Google-Smtp-Source: AGHT+IE0pDqYS0rawnI5DY9rBtKN3Ak4K7+k/cjqZD9g5MnYL47iU10VVn6Lodw80i7XL+L0TRW2aLRgFPzJJDt2QW4=
X-Received: by 2002:a17:90b:1d12:b0:32e:7340:a7f7 with SMTP id
 98e67ed59e1d1-341a6c05109mr782590a91.2.1762296435231; Tue, 04 Nov 2025
 14:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-3-ameryhung@gmail.com>
In-Reply-To: <20251104172652.1746988-3-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 14:47:01 -0800
X-Gm-Features: AWmQ_bmlHHOlbQ1cAC3KoIhq2T6NnEHeUWUY0sg0w01QbVKc2UtF-5Qdlk6HdCY
Message-ID: <CAEf4Bzbz4jY3cKGxPro7yn_2tjKqkK6P+oU8_8ZZhAfewkNEnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:27=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
> a BPF program with a struct_ops map. This command takes a file
> descriptor of a struct_ops map and a BPF program and set
> prog->aux->st_ops_assoc to the kdata of the struct_ops map.
>
> The command does not accept a struct_ops program nor a non-struct_ops
> map. Programs of a struct_ops map is automatically associated with the
> map during map update. If a program is shared between two struct_ops
> maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
> associated struct_ops is ambiguous. The pointer, once poisoned, cannot
> be reset since we have lost track of associated struct_ops. For other
> program types, the associated struct_ops map, once set, cannot be
> changed later. This restriction may be lifted in the future if there is
> a use case.
>
> A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
> the associated struct_ops pointer. The returned pointer, if not NULL, is
> guaranteed to be valid and point to a fully updated struct_ops struct.
> For struct_ops program reused in multiple struct_ops map, the return
> will be NULL.
>
> To make sure the returned pointer to be valid, the command increases the
> refcount of the map for every associated non-struct_ops programs. For
> struct_ops programs, the destruction of a struct_ops map already waits fo=
r
> its BPF programs to finish running. A later patch will further make sure
> the map will not be freed when an async callback schedule from struct_ops
> is running.
>
> struct_ops implementers should note that the struct_ops returned may or
> may not be attached. The struct_ops implementer will be responsible for
> tracking and checking the state of the associated struct_ops map if the
> use case requires an attached struct_ops.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf.h            | 16 ++++++
>  include/uapi/linux/bpf.h       | 17 +++++++
>  kernel/bpf/bpf_struct_ops.c    | 90 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/core.c              |  3 ++
>  kernel/bpf/syscall.c           | 46 +++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 17 +++++++
>  6 files changed, 189 insertions(+)
>

[...]

>  static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *st_=
map)
>  {
>         int i;
> @@ -801,6 +812,12 @@ static long bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
>                         goto reset_unlock;
>                 }
>
> +               err =3D bpf_prog_assoc_struct_ops(prog, &st_map->map);
> +               if (err) {
> +                       bpf_prog_put(prog);
> +                       goto reset_unlock;
> +               }
> +
>                 link =3D kzalloc(sizeof(*link), GFP_USER);
>                 if (!link) {

I think we need to call bpf_prog_disassoc_struct_ops() here if
kzalloc() fails (just like we do bpf_prog_put). After kzalloc link
will be put into plink list and generic clean up path will handle all
this, but not here.

>                         bpf_prog_put(prog);
> @@ -980,6 +997,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *m=
ap)
>         if (btf_is_module(st_map->btf))
>                 module_put(st_map->st_ops_desc->st_ops->owner);
>
> +       bpf_struct_ops_map_dissoc_progs(st_map);
> +
>         bpf_struct_ops_map_del_ksyms(st_map);
>
>         /* The struct_ops's function may switch to another struct_ops.

[...]

