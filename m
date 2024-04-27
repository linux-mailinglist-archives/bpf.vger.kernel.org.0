Return-Path: <bpf+bounces-28026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E88B4665
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 15:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058A41F24DBA
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1250D4EB42;
	Sat, 27 Apr 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2VRpjfU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A742047
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714223206; cv=none; b=uZZwgjnSg4cD9mIAXrDtV0G6Pxh1hsb6f+LS53iZCd6Ne44KtkXJ4wN/IuXWJ3WLT/Eov4eVTchgyF5IqgsnukY2Ou4n0QKVsJRj76XcmtpcJKPRfBPsUlUPlDaf9+3VMd64Oa1/MeQGs1nnNFAlU/vKblmPUJ5cvkpc05rhE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714223206; c=relaxed/simple;
	bh=leQrtatoiZ3Ha5OIk+geZJctYZOo/BVugVNXiKy/0Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShocEE/c8v4O/NepWRLvj5YgxQlDyAlKgMeSfAs92S8Vj0Re9Ip5sn/fD++1Z8GlPNoMFuyuOKw4efb1W+E5khcRbNSLwYzte+EP4ztgfv1Gbu2+G5GhChPvzfKAJUHAq45QH++ETEc1OMxca6rXjScyUYwBB+2IrDVxKK4IYFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2VRpjfU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so3810a12.0
        for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714223203; x=1714828003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQUL5fl18WL0ZKXvOjs5LrQEgdQrTnHGFv8AkEWwYJ8=;
        b=u2VRpjfUuRUrIxwjQCp3oKYVGWP1j7V2ufd+CZ2U8iY294lLoA+Eo8EVhcKqlSxNeE
         yQi+GSBlSoTlmgzZjRBKFUD4ZdtJVxBZbFgr3QxW77eSWBLrg2qaKyTPE++GJzjICaKn
         aPWbIjHPqD5jyI7eZk62fsuHnPaW8Q9B/9n/+fG+Gozhwketwb8uHx9SMNgBXrHKuG1D
         9fwBduJND8+AzJgEfErIRyIDfkktMAGLZ1Q6ZZq8PGfU/geiQ3Ei7RirTJPTJMSafx3P
         iDIVbLPYsGOKrUFk3yUMKnQAxco8nTp9VqpNnOsicoprOfzn+ELKXR7gCMtewdXWeAon
         e7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714223203; x=1714828003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQUL5fl18WL0ZKXvOjs5LrQEgdQrTnHGFv8AkEWwYJ8=;
        b=pVSgpOlNzSRrGxxLx9+CSqB32zL9z000ZG4SN21wvUzT91OrutbDlhCvdgsV+AfPFg
         71gv887idfEVA8x/00wEhgenK+HsXAVpfmTZRjH+CwrpMEFOv1EjednCUF7cFUQg2fAG
         FBX55W8gcGlGQZc9/CDJbTKbx0XFFjtdO8KhtHeODDyy6QBKGP9xHE3nNpTlt7AelTZ9
         Pzw2td1EMYqahzyyzykNZSCWjieyeIOVBdxxk/jaGOe+JphbTITTJubL5IUJIZEURXmp
         JY/RWXfP0RBbxkA6nthwQXn6n3IwvIY90EDaaO0vWYzQ+iZkDTR2FmuxIJlM6/+XuM4R
         jriA==
X-Forwarded-Encrypted: i=1; AJvYcCWRoidtJAfgoq1toE8cQimvI8ayfEuxigd+kjbnD+ePmSeumbeOC/gL6BItB84/8+iJ6Z/EfMa/o7nzjasRpFjaMZTt
X-Gm-Message-State: AOJu0Yyod2/GbVnby7QbqotjnrBd5AkRKkT8chht11pU0jFyUTa782OE
	pjpq5Kv9r3bGrPa0CPW66+JWa89KJH1K9sqmwHqkD2jIXgX2qW2Oe5SjvYVFKRHVa0nNMTHPVGu
	dOAHyQsYGY+1JK1cTkNbdLQ0XtS0baeTUs59N
X-Google-Smtp-Source: AGHT+IGWABgpAh73R+Nkuk9KHLNNB1TVJVsPGK9UUOMNEL4x+Ak23xL+y1CGqbsru3TcKWbCtlDHHgk4rv5VJgNTfKs=
X-Received: by 2002:aa7:c6c9:0:b0:572:fae:7f96 with SMTP id
 b9-20020aa7c6c9000000b005720fae7f96mr93652eds.6.1714223202418; Sat, 27 Apr
 2024 06:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424203713.4003974-1-miaxu@meta.com>
In-Reply-To: <20240424203713.4003974-1-miaxu@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 27 Apr 2024 15:06:31 +0200
Message-ID: <CANn89i+HO59Sxwu2fhrKOJCX_3DjOPp+os0LOO3TjvrTdvEiyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [PATCH net-next,1/2] Add new args for cong_control in tcp_congestion_ops
To: Miao Xu <miaxu@meta.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Martin Lau <kafai@meta.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:38=E2=80=AFPM Miao Xu <miaxu@meta.com> wrote:
>
> This patch adds two new arguments for cong_control of struct
> tcp_congestion_ops:
>  - ack
>  - flag
> These two arguments are inherited from the caller tcp_cong_control in
> tcp_intput.c. One use case of them is to update cwnd and pacing rate
> inside cong_control based on the info they provide. For example, the
> flag can be used to decide if it is the right time to raise or reduce a
> sender's cwnd.
>
> Another change in this patch is to allow the write of tp->snd_cwnd_stamp
> for a bpf tcp ca program. An use case of writing this field is to keep
> track of the time whenever tp->snd_cwnd is raised or reduced inside the
> cong_control callback.
>
> Signed-off-by: Miao Xu <miaxu@meta.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

