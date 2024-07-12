Return-Path: <bpf+bounces-34690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7693014D
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F935281E8D
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9186E381C2;
	Fri, 12 Jul 2024 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKChhkHV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B8FC1D
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720816256; cv=none; b=M3PLvOWdpUp/Xi03SwV9OoTCjv5Ay8ToVNcFhAnsEG9T68beKSWZMj7U6/mq+2AL3zz7GtvNgY5SoGcWDKhpAOD53+IFgIu4VMIv0Mpi4H4B4uaI4pIxhs4T6zyXlG8rn9BL6Ru73pofByhEPQ4HP1N+yzgWC7JMLciOr/rgDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720816256; c=relaxed/simple;
	bh=66tENcTNuJkAxkyE7ntiuzhDZT1LjXd8L9fXiBY/81w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qww5ar0L8EQlJ2uwFLWdffH5Whxme8+sWowcEjqxkjmwQmJ5Jvxup7hyUko2wjbmVdxgcBjCq5k6eEiRqYA1lGKcJTr7jrpFQwrBl7H76vLmwIavPtzdg5jgo25lfjlO9vJkReQFVmTr45dnBItO4aTiAnVCZ2+nfp7Z9P0JaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKChhkHV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so18918205e9.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720816253; x=1721421053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Del57IESCZ8nQLxkcdbjHYAJopnxr83OlVMQmczNPlw=;
        b=VKChhkHVY5Q+tXzjJbmympmH276FKGN0aIsqi/eLnNQRVpBb7yO66TOqNTNhbF8ooS
         IxL0YXaxgjTjBVeGlZkk7B7FwxsratOgeSRzgqtMoEvXj4/r/2tbV1JDIZyMU8cM4tMC
         5eGOn/xIcwUoI1aHSk6q3Y+wiSt72maYMHFo25MuvqbjhQXHUt9jDmsLr14J/09iSzDJ
         FLwryRBjk5oVOskW8Sc8RZ4Qd+qxS+iE3SMaAIxf3Qz6MB2IQLDU5Vpti4cEqpdcOpc8
         L6U20w1wcliQhR6pJo6V62N8AHSJQKWzDrWSrRyKM4tdcoq/actxc+hwwPbjrbGTbKIi
         q7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720816253; x=1721421053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Del57IESCZ8nQLxkcdbjHYAJopnxr83OlVMQmczNPlw=;
        b=EwyWpRmpV3ILUSRzF4eqzIzcxbwy3goNSAI0Pe7bpN6LrdMEE7Gh0lKkplYRlicSmo
         s11sBH03M9QeYaPaDt2Cmystikk8tPb0k6VzXFz7db8WlYxphtQW8z9eL04c8Iy0WxMj
         kMKXmCtjiRLsdIj7WQrl4Om0ojlBrQYYD1vxdCPPgEqRwq8zRnL4oH68MLQ+01+TFmKu
         py/FcsFwpiPkmvuauhpv+QJmZzfLWM8nPepx6B+X5DUX6ft3SwuWXKl1uZXEmRL8a3UZ
         L3ln8RDlOeBQz47o1gBtbVfpWrslDKe+s5LXlzkJjp6/zP0eiZVPHDxqB2AGrfDYFC7q
         w6gw==
X-Gm-Message-State: AOJu0YwCzTq4RHWqR8lS2HCPrvNgWiDbRqnfkXub4BeNnofmne3fR0k4
	fLGOmiJobGyGKM8aWU3dZsMLoVBMidabXXIr5e7uKIZiRYGL6ageFeyPSqrnn0RlmVHcQxyIvhn
	/UgWBKmpWSNv2xfUhDsSlHDapdn8=
X-Google-Smtp-Source: AGHT+IEP8pq8HMgLRyEKw2yj5L8K7zvseKDD24Mlc3JuBNyJK7ftecxuiOLjDqeYF+2H3uTAANq11KPGPFaPwlM92qw=
X-Received: by 2002:a05:600c:6a12:b0:426:6bf9:608d with SMTP id
 5b1f17b1804b1-426707cf81cmr100462585e9.12.1720816252702; Fri, 12 Jul 2024
 13:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712202815.3540564-1-yonghong.song@linux.dev>
In-Reply-To: <20240712202815.3540564-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jul 2024 13:30:40 -0700
Message-ID: <CAADnVQKhfXg0N-yNOxxmR+Nq_YxG2zHPzpY9BjtBfwvFpQLZ_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Get better reg range with ldsx and
 32bit compare
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 1:28=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
> +       if (reg->s32_min_value >=3D 0) {
> +               if ((reg->smin_value >=3D S32_MIN && reg->smax_value <=3D=
 S32_MAX) ||
> +                   (reg->smin_value >=3D S16_MIN && reg->smax_value <=3D=
 S16_MAX) ||
> +                   (reg->smin_value >=3D S8_MIN && reg->smax_value <=3D =
S8_MAX)) {

Could you do:
if (reg->s32_min_value >=3D 0 &&
    (reg->smin_value >=3D S32_MIN ...

to remove one indent below.

> +                       reg->smin_value =3D reg->umin_value =3D reg->s32_=
min_value;
> +                       reg->smax_value =3D reg->umax_value =3D reg->s32_=
max_value;
> +                       reg->var_off =3D tnum_intersect(reg->var_off,
> +                                                     tnum_range(reg->smi=
n_value,
> +                                                                reg->sma=
x_value));

