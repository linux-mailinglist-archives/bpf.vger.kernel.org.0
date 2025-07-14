Return-Path: <bpf+bounces-63245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F8B0481A
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71591A659DC
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D323958A;
	Mon, 14 Jul 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD5pV9D3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20E1FCFFC;
	Mon, 14 Jul 2025 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522766; cv=none; b=uLy/uDjBbN/rowiHAuM3XV2Z9UEXDatqsYfDp6+U/D38hupcqGgnbzWsvWToW0DoCSFXjbdmZSEe4z5coluuHEIGPTMeEjTFLPt0Wa+IsRSyTAxa2wMqRWGT41CTfb/rGE0CgRWk9tNtwzKta9e6A+0a9i2w7w/mHo+U641GYjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522766; c=relaxed/simple;
	bh=L/pknVvZwDGJ1fwFxvcv3OydwDEhiyRLZA0t58Dk3qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaFqG1lLBcxEpT3DOyZpcY1zLEwVKr8+c40lOUcgXEt0MIguPd7mRz7Ki/KfyNT/vCdS9hGlaH/po7jBlruSkGr0WeD0MRye0Hc7cw7FOEUpVyDlC4Ja8R5qMR5sfyo4cOwQ5N8QHbc2I4JBJ1MSY1uF8gszeny0QAepJYn5RsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD5pV9D3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2845849f8f.1;
        Mon, 14 Jul 2025 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752522762; x=1753127562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyS0T9f63pnjgDuWxeP2mqEyub0ny7UU6n3g3ivgdCo=;
        b=mD5pV9D3Ck0d9id3XzLxPJWugR6gWUK1jwPw/lSDYWu5iQwrkLz9L0HcarqKGOWiib
         9MKLMvY9yQ5ysjF+Lsw5UZ3F7DrDXJRdM7WNKjOg/XPN1HAsKQ4r29MDzhiqNoCDXmJ1
         8qfs+H4nIc74OmjVcoRSgfM/o5lJasV9dj6TmEVptcIB24mmKDULr9nGW93Dsx3hDNJ1
         lh1TbOXSFZIanm5vyfFnNjJuUxTODJPuhKzO/BI3LB29g/aK1DYPxXEYN5YCtKui0sJP
         OnHJOD0pE6+H0elvYDjcfX7X+FuRJ82buFzggILmOcb0/8QdWN7Uu6YJOugyWuMyuhfQ
         ofeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752522762; x=1753127562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyS0T9f63pnjgDuWxeP2mqEyub0ny7UU6n3g3ivgdCo=;
        b=T4+HY7n5qRL4fC90Xvzf7SdKCAtVapkOL5gpLlXEJD9HELH8cDGMzDzIVa7SQiNNyo
         //zyAonbont/4Pw9aCXZWy28KNxL0vAUZRz2BZ3fGFvpvnpe+i3mIi4/I5TBtyVZVSiS
         h3Vjcq67Xm3VfZ4DEzJkhOo86c6AGPREpfn/+zvsKLLRAHe33ueG0iWo0FKZwgK/7It7
         bU5s1MkDX16niXWbTdB/y6pBU3PNgSJG1Y9X5lS9AioDaQBAuogOT58O5bnjOZ6aOYk6
         UP3dL31kqMS1QfvkfBhyjCJ34bjTXYnNXmQIahS7TNp01QbFg1GuGpdDycFe9QbT1pFr
         xRsA==
X-Forwarded-Encrypted: i=1; AJvYcCVC8Dq4IxW+qnEen6wGvGL+PB4O35D2L++gxdEjf6XlMhV4PJ1zm4hYMewUjZTPQx4k8Ck=@vger.kernel.org, AJvYcCWbwh5e7NvAUvqHzb8664RMiZkYKzVNGkQ0G7+PJECtb+Kv7Z+1Ftg1RlX906WqdbN/o5320VdaIeOXo3Ag@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmDx/HUeaX+Y/+JS0FzBJoSN/U2aXYqM+3jzHzFAhnDMv0JTm
	e7uwg1ISdGDrznLA2G3IqtcNP2L4FMlR4iqgtqX5ilD8TEF85XOq1JbDPfFd6MyWPyol8yGSytJ
	e+I9bn46GNAPCMH4G3WgJME7qBAUGQh8=
X-Gm-Gg: ASbGncvTpiSD1sn3TcvbsSXKPrejSCM8Gx5ZjPcBJvpw/VGHPrA4v09LkOpoYROTMwh
	7LgtaAqnExiL83BbpTM70ubDaBPxl3Wz6Apz9TbuErVZMosUT1wDc4S/UFoF+nO5vxq5XIgDIUe
	mabQYEEmifO4CB1N7hbJ9wjTT8rYDAihJyt1b1l6u4ufzIBNTbrMxiCznkVY5gPSD1Oe8Hf1FvX
	1JmONIirAnsuz3eqYudLpY=
X-Google-Smtp-Source: AGHT+IEzGRa80oH8XHZO6Y+Ui1nl99z2DAyULKvozreu8WNP+0qAhUw6TKsdCFchj0X2W8ByVJRMDrXurV5D1xAWwmI=
X-Received: by 2002:adf:8b15:0:b0:3b4:9b82:d42c with SMTP id
 ffacd0b85a97d-3b5f18807b0mr9387146f8f.17.1752522761453; Mon, 14 Jul 2025
 12:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250710070835.260831-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 12:52:28 -0700
X-Gm-Features: Ac12FXzSdQbEfThaiAy4DX_qHEbKQP8B7cXwYXZ6xada_vTlnD2m6gQ72bYTylg
Message-ID: <CAADnVQKmUE3_5RHDFLmKzNSDkLD=Z2g3bkfT2aRsPkFiMPd-4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:10=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>                         } else {
> -                               addr =3D kallsyms_lookup_name(tname);
> +                               ret =3D bpf_lookup_attach_addr(NULL, tnam=
e, &addr);
>                         }

Not sure why your benchmarking doesn't show the difference,
but above is a big regression.
kallsyms_lookup_name() is a binary search whereas your
bpf_lookup_attach_addr() is linear.
You should see a massive degradation in multi-kprobe attach speeds.

--
pw-bot: cr

