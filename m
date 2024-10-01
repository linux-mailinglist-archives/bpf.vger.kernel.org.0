Return-Path: <bpf+bounces-40628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909CC98B1BF
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 03:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13066B22047
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DCAB67D;
	Tue,  1 Oct 2024 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EljkLKOM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D417C64
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745732; cv=none; b=GYm5GIpfDyXgAV2mHgblRlMO5s8udDfT2LiWQWcrnpRn+8vb8DNK+6hOGp/Nba/L9J8Ydzq8I47gvCobvHC2WtTBi3fM4WOMcnKQlkrndmq0zkJB5AqCKMyBikGmtG+/VS8jqyYv59n24u3BDkyydgr4hHNLIdpgS/Ss51yq6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745732; c=relaxed/simple;
	bh=EBzae7cWbV2/v7is3t+OVJyLcXnOhKdFfJNP6JXfpoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jb9+hRDQ9mDrnVa3TONdQ37h8M6vzlFVJlRGYDff+4h03UjvhOm5WlMWpcShsLRbA/78TYxefMa5Yyl2lhnH4TXfyXB63r8bzRimmz3mrW+P5cV6/pc3B5xnyXOSpDp+9oD9LlRtjMEQEzrrJRq0YD8uurZwkYvZMCbiJDWMVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EljkLKOM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so38623975e9.0
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 18:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727745729; x=1728350529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HBw7WDvbXHtgx5IrY5rObEkoz4SEAqXZTe2RkdUyEQ=;
        b=EljkLKOMuLyKaBluveQ5QOIsazprSZkWACvUH/hsV115QF/fiGGOstRxrK5YHEPW+d
         o8sBlVrkozJFE1TMDjlU1kOEgb5aH76KrYSIP6bipCo+btURI7IMLNwYMZ8+yYd2GXcr
         cUva5Qp0V08+z34I9b+L3sXsU6sb2HqfPjbZrI+oLZOgXeGhwKt4cAEPo7GFsyMaCxgY
         DECOvUJM1xaGDJCkUD69FP5qNrspeA6FA5PMMyZlYwfOxR1OTQ9KG+PTIaE5kBFX7bpT
         KA0iq89thW0QlgDUgRXDzujB6jr923ua4lHcZGGW4xl8TEJjhRqztQu6o9UlQDyPcB9w
         7mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727745729; x=1728350529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HBw7WDvbXHtgx5IrY5rObEkoz4SEAqXZTe2RkdUyEQ=;
        b=GQXXpwNqS6Wwlv+AQH1NB7GuCjrR8OnSet/VjRO2b6aY8oVd6WWbszRgV6KE/cl1Lk
         UQbeD/xPnQd9cnpEnAju9tjDMB1zEuA34XxRtTVXs3Zcrzq+atZfCNouK+oVajmRD60r
         q/4o3BIuEo9dMEU5Bw3BLCYvRzue6Q8MwjkvIuiZqTcU/ZNRp8OxQF+dm1QXRLpupbgG
         qdu34Vb37wkEw7KX3BYtkd/e50jFv1clqR8tit8JyfTNSz6oYFGZmlxikCmyPk8J5hId
         0ep1LCoxaT5cG69d/Jl6r7o3NOlfDg6rUhbN0pissgYM36lZSmT+U4eVNtLy8VzdYLx6
         9RJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAYWIW/Z9mfwaIYef7UvZ5hHa5QYizwdsQzU2sF/OyjeoObhkF905SxQ747LO3BRWTtyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDyd4hu08huwhzYXNtZjjU5skJ9gR+jsnPQWVAZz7opltd1d5
	6PQ4MtMsR19G8qE71tHQVPTVmODkOQU4OTxA2NXhwPbhcMA0wAcfqG2GPSx0L4HstlbcH4uL8H6
	wXfQRzaLgLvtOwUyQU6Fyuf7yJLM=
X-Google-Smtp-Source: AGHT+IF1UVy61J2SNXqz1vKJqwXFg5k9pEJfoyWdr+Q5S7VVcyI4jsh0XI7Y680qtujLW47+KoN+3vY4Npt/UOtPt8c=
X-Received: by 2002:a5d:5258:0:b0:37c:cc54:ea72 with SMTP id
 ffacd0b85a97d-37cd5a687c8mr7559886f8f.4.1727745728873; Mon, 30 Sep 2024
 18:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1058f400-50d8-4799-b5ed-149dba761966@ijzerbout.nl>
In-Reply-To: <1058f400-50d8-4799-b5ed-149dba761966@ijzerbout.nl>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 18:21:57 -0700
Message-ID: <CAADnVQK7VfTZNPO4rDDdH0HaD9XEy4-CF7h65i_4oJeeEYwpww@mail.gmail.com>
Subject: Re: Possible out-of-bounds writing at kernel/bpf/verifier.c:19927
To: Kees Bakker <kees@ijzerbout.nl>, bpf <bpf@vger.kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 11:01=E2=80=AFAM Kees Bakker <kees@ijzerbout.nl> wr=
ote:
>
> Hi,
>
> In the following commit you added a few lines to kernel/bpf/verifier.c
>
> commit 1f1e864b65554e33fe74e3377e58b12f4302f2eb
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Thu Jul 27 18:12:07 2023 -0700
>
>      bpf: Handle sign-extenstin ctx member accesses
>
>      Currently, if user accesses a ctx member with signed types,
>      the compiler will generate an unsigned load followed by
>      necessary left and right shifts.
>
>      With the introduction of sign-extension load, compiler may
>      just emit a ldsx insn instead. Let us do a final movsx sign
>      extension to the final unsigned ctx load result to
>      satisfy original sign extension requirement.
>
>      Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>      Link:
> https://lore.kernel.org/r/20230728011207.3712528-1-yonghong.song@linux.de=
v
>      Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ...
>
> +               if (mode =3D=3D BPF_MEMSX)
> +                       insn_buf[cnt++] =3D BPF_RAW_INSN(BPF_ALU64 |
> BPF_MOV | BPF_X,
> + insn->dst_reg, insn->dst_reg,
> +                                                      size * 8, 0);
>
> However, you forgot to check for array out-of-bounds check. In the if
> statement
> right above it, it is possible that insn_buf is filled up to the max.

I don't think it's possible.
There is no need for such a check.

Next time pls cc bpf@vger right away.

> I've attached a patch which will catch that situation. I've used the
> same error
> message from earlier in the code.
>
> Please consider adding my patch.
> --
> Kees Bakker

