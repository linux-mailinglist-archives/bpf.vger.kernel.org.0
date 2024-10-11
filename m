Return-Path: <bpf+bounces-41755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710CD99A8E5
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EF72857E4
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4A19E993;
	Fri, 11 Oct 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7m4PY+t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847F19E960
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664200; cv=none; b=XW2Z/u8QLCREfRxAu0F/W7wgZbyJohnkn8eS68Hx2T6naQju09gTRJqp1yo50tjEA4mgnQBcdAfuPT1umCWA0u2ru+4Azm004xp2Pje/V6VsxA3jTA3tk+vH4xHmIl0s7/m85z8ED9XcbChol9dTqqoIapsR2SlQFILyd0KHS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664200; c=relaxed/simple;
	bh=3bkFb9qc71A3ZzY/BpgjRbRvq55rQVjY8cjZZmRwFQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmhyhQkK5dSuNQJzyI832FjiEqA7UVo64CTauhRdTYEDsvJbruI57TzV4IlSgWHSYlHqqrx3z0GAnqCctkeTpkTtKuRjr2xh1OjWx/vqhxux8kkn6o1y8ACRsn3+/WWmShT5q0dtW0ECJC6sCfpxBk/ivpfRhhbSHk+XT+5AhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7m4PY+t; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d41894a32so1456872f8f.1
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728664197; x=1729268997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/gFd3LPuX3UKlFESgUm3PZSFttlXSkFCTeSAtKt2T0=;
        b=U7m4PY+toven+uWFi86Q2isM+HnFRYfWhAy2Ak3BQkv8Ilp+8T4yNOq6dlvOfsgMQH
         PLuJ93BdygBQxJwbLMwf0O8PYrca2rajey/w2+yN/piKcwPXa6eVrKo2W8hMN5+EVoSK
         gEbXcjSrqdjY6QxmaMcmYz49fs1eFQIXIhJrbH/INrZgh1zqcFvgbb9TV7ry5HdYg3wg
         NTGaaU7Q44aLWvaiqnU8dMcTCyhzmZrXaFIHimSpvsnNSU5To2vwkteCPPxzV/TBqg3/
         ni57rom2z8u7g1C+CMkEIxBvLB4PO0LepJuP6sSSEynISpS344arXY2SMQ+e7CMvDJ+1
         npCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664197; x=1729268997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/gFd3LPuX3UKlFESgUm3PZSFttlXSkFCTeSAtKt2T0=;
        b=MZCRG3VHfvzOvA5V9j11CWt5fU4O0bZtLKdO/DDZYVc+qvl94e3zRKtkIL78Jrq/Oo
         mS5u5A7pFsOu4Q23H0nqWkBo02RjRtxiShysjGRs0eOmXxYAsfCKcevy61Xt58plJ9he
         0/ipHLy/3bytIikZefbY3lI8AuMaZ5qR8BVP0WjnmLFYOZboyjkurZiKDJ+5ORGLB8Or
         43s3CsW1RuX1SESptTTA0aBwSnEIc5cozsVPoUxEhx6zRKS8sLpUeBnL6W6WKrWjyju5
         ux/xe77xPak9oYxWjTEqaAQlmnIPUQCDI9WY8lyH0ZP0wfSXcnXE/lLliNOKwMaPZcR3
         hoQQ==
X-Gm-Message-State: AOJu0YzB6if9AxuO8IQjjoAFLc7ynmqPf8ur1Z8wUt1Isz2kLBmjU7l/
	dY+t/L9c7ra63NlhEdBpH7iifkXrVqj4I2lXMpGO6AkJbwbURjqY1I98EuENTKdoUvkKL/ijcv4
	xx1fc7piX4cg4bUOSj7z62gMZI/w=
X-Google-Smtp-Source: AGHT+IEaideAaLiGnNsfQN986dhcv1mXABNdKLoHnI9yWdXrUyPj/TIImxRRfUf0KzI7u72TbExtZ6D0kEWY3lbt6Do=
X-Received: by 2002:a5d:6882:0:b0:371:8685:84c with SMTP id
 ffacd0b85a97d-37d551fbe1emr2531319f8f.15.1728664196644; Fri, 11 Oct 2024
 09:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-4-houtao@huaweicloud.com>
In-Reply-To: <20241008091501.8302-4-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Oct 2024 09:29:45 -0700
Message-ID: <CAADnVQKmkaYJixBrJpWPDpHM9R9jq91meY9bERCVaC11CN4G_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/16] bpf: Parse bpf_dynptr in map key
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> +#define MAX_DYNPTR_CNT_IN_MAP_KEY 4
> +
>  static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>                          const struct btf *btf, u32 btf_key_id, u32 btf_v=
alue_id)
>  {
> @@ -1103,6 +1113,40 @@ static int map_check_btf(struct bpf_map *map, stru=
ct bpf_token *token,
>         if (!value_type || value_size !=3D map->value_size)
>                 return -EINVAL;
>
> +       if (btf_type_is_dynptr(btf, key_type))
> +               map->key_record =3D btf_new_bpf_dynptr_record();
> +       else
> +               map->key_record =3D btf_parse_fields(btf, key_type, BPF_D=
YNPTR, map->key_size);
> +       if (!IS_ERR_OR_NULL(map->key_record)) {
> +               if (map->key_record->cnt > MAX_DYNPTR_CNT_IN_MAP_KEY) {
> +                       ret =3D -E2BIG;
> +                       goto free_map_tab;

Took me a while to grasp that map->key_record is only for dynptr fields
and map->record is for the rest except dynptr fields.

Maybe rename key_record to dynptr_fields ?
Or at least add a comment to struct bpf_map to explain
what each btf_record is for.

It's kinda arbitrary decision to support multiple dynptr-s per key
while other fields are not.
Maybe worth looking at generalizing it a bit so single btf_record
can have multiple of certain field kinds?
In addition to btf_record->cnt you'd need btf_record->dynptr_cnt
but that would be easier to extend in the future ?

