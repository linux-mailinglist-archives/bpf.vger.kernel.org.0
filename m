Return-Path: <bpf+bounces-69470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F24B973EA
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 20:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB10119C5A9A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044C42E0914;
	Tue, 23 Sep 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpozEqWp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A227CCE7
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653561; cv=none; b=fSDPXC/UjLlW+SjBLs8TpO0Nu7OeE3rN69ipm2j4wPN7SIvQRMBR3ABqvldTIPA/jFNeJdukrF0hWIPTs9NDZ9guL5UhxKVeDhHwhdp3OtcJzCZDVB+VXjoujlViOxHVjGB+yv/4ZVZbH1IZD0ua/vjtKfs3Ej2p40Xtf+hMhWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653561; c=relaxed/simple;
	bh=cgONVmkhgMelsDdmMuAt/qU/DExf9Qngi25mO8xSTew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFK2TJiV7xy/Rd+6yWgeDa7i3I1wDIk6p+m3DQm1/iL/wYMohndYHmt3XQ10GmyBf29cI+zxIIeQhWr5QSkayEXtIjyOJqfJ3l8UE9QDaf3wg31x+Wk46q0h/RS0h8qz5Bpa5s8Pi3gfNTAoMWYW9GJXQIlOHeOXXUQ+SZM9w3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpozEqWp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46db5bb2e9dso1000645e9.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758653558; x=1759258358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUn2OpHmm7pfo4BppeNZW2V1cfojK5GlgjBJHRJGklM=;
        b=hpozEqWp2Dcg0CBYlV+BDbO+v4I8FQ90V6/QmuCwjbEvRgA5ETJUTY2sXvMC8DlNZx
         oxHNEy6hgI1qhVw7V8DxrF28Qf88j/EXbMXSm+xx1OrYx+AfhWTsNnljvG8w8WoFaIHS
         1x1ijLt9/CSRINFStPQh2gbczJ34EKtz6UHBA4C/oObYGxcv7zstFT96lKpOi66J6IKN
         rByU36HKgmN+dT1PKnWLuBZWR6hmfFAp5AakOzWfeIXSJdCYhWnfw/N1tLqYgyqwT1m3
         XJUyHrKjs3hG18IJeZBiMX0WzpkyTtcZ3szF7sORSL3LbAK/vfO9cEnOuwpAIjxTf4+q
         lRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758653558; x=1759258358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUn2OpHmm7pfo4BppeNZW2V1cfojK5GlgjBJHRJGklM=;
        b=HWopBWHLV/maocUYmz+nx1X0uojKXCvCk3TuX3iJTb4/uul07A95HsciG4aJoZnBBV
         e+U1pYql89Z9SgIeQ5RaqeETAQdlqcHIN93yVQALacjuaAP82+uen0lkKRGdKf+pcnML
         dGynZUD7FAIAk9vsPw8Nsh/QSyXWdBJZOoYcyOPssYxBQBBq/ZNQTWobl0rGBxBiTCf8
         qXRkerFdncpbxDNTBPVjs0huIiiNUG5FVyYlE1iLbnnx73Gsv3jAV3kaSxsHNQ3503Jk
         sBMltKfkFuYh9gjaEjwy4VbpFoQWlJPXn8cMJJf6mZyv0gYWXm+F6HmBcmHPmA8sMPfM
         vL2A==
X-Forwarded-Encrypted: i=1; AJvYcCXozklOzSLpSw4fciGiAd3DyqtdLg9UZkRBK4uacKNnNvLcl8TfbANMia4swz4i3S6TcR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGHP6rZTfSWFArmZfucG1rDtT/DoQvxq6dax01/8gljKYMsNw/
	OO6j0hNwQ/Dyo9BJxOa5MExCsxD5r77KGhlItR9RPhPNAs3f031WSUdVWa/CQCdJvsYCuSKccCs
	GOP2fzMrEVScCRgeBEC5X1kCeMcMS1rI=
X-Gm-Gg: ASbGncvY6NeeoD/Le69iqZm+nqCWYgQBnsuJ/mS6lR2gBHzKQZDHd1ePAY2cjxFvMnP
	z/OazXVKQhG8RbqLAFrq/DXaDhRdNqq7/3ixxiS4/VzVyCmYq/5ERjxHSKyE1bCnsLRORQwZn41
	M20F48VF/RyyeCgcGn8onM/ctr6noAWoUeZe+9L0HxHjf8zPVjmRwk58CMxk5dYdX4wP1grbfCK
	E1z6I8=
X-Google-Smtp-Source: AGHT+IFXdr1qAFRKrRIhRvTAlUBj6EMd3fVOhJImQNL3jAjkCWTz1HxTEqxRjvy5Y2MiYiNM5folI9tZZzb0E6VAjPo=
X-Received: by 2002:a05:6000:1885:b0:3f0:8d2f:5ed9 with SMTP id
 ffacd0b85a97d-405ca2a64bfmr2999158f8f.1.1758653557938; Tue, 23 Sep 2025
 11:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com> <20250923164357.1578295-1-listout@listout.xyz>
In-Reply-To: <20250923164357.1578295-1-listout@listout.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 11:52:26 -0700
X-Gm-Features: AS18NWD76Xqc7COam94wfoYJ9nOoP1gcYlOdh0b2K3xOtwaSSY20L2ccQKJi6N4
Message-ID: <CAADnVQJva1iQbVk4h9sKEEBnfDVd4iJDKR499n=hj_JL1dMZ5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] bpf: fix NULL pointer dereference in print_reg_state()
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 9:44=E2=80=AFAM Brahmajit Das <listout@listout.xyz>=
 wrote:
>
> Syzkaller reported a general protection fault due to a NULL pointer
> dereference in print_reg_state() when accessing reg->map_ptr without
> checking if it is NULL.
>
> The existing code assumes reg->map_ptr is always valid before
> dereferencing reg->map_ptr->name, reg->map_ptr->key_size, and
> reg->map_ptr->value_size.
>
> Fix this by adding explicit NULL checks before accessing reg->map_ptr
> and its members. This prevents crashes when reg->map_ptr is NULL,
> improving the robustness of the BPF verifier's verbose logging.
>
> Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  kernel/bpf/log.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 38050f4ee400..b38efbbf22cf 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -716,11 +716,12 @@ static void print_reg_state(struct bpf_verifier_env=
 *env,
>         if (type_is_non_owning_ref(reg->type))
>                 verbose_a("%s", "non_own_ref");
>         if (type_is_map_ptr(t)) {
> -               if (reg->map_ptr->name[0])
> +               if (reg->map_ptr !=3D NULL && reg->map_ptr->name[0] !=3D =
'\0')
>                         verbose_a("map=3D%s", reg->map_ptr->name);

Looks like you're bandaiding a symptome instead of fixing
underlying issue. For map types map_ptr should always be set.

pw-bot: cr

