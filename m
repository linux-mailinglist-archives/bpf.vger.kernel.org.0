Return-Path: <bpf+bounces-35240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DF3939287
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36A4282024
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014EB16EBE0;
	Mon, 22 Jul 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1nz/Oay"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8E2907;
	Mon, 22 Jul 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665801; cv=none; b=rILABqq56lxfMRmOTJ3HVmhiIGMDyI6J7gRgemSxPj0DljBMKksMahO/2gQS/AEvpeOTNQjE49C6MnTT6wJdICk5MpuH23s01csH5qkSowALJi1dzE1VqXjG1LXcxrSe93Vi6+W0+V1gDrGjOe7D9kNt0zcxO10TVDzWugyWNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665801; c=relaxed/simple;
	bh=TQMIdHBDqbQcpRzi7MPTAmUdhL2eie6DOnXyNiLx8MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nm66W9mlSiWuHJBYr6+KLoTbfVFbFFGuONHRY8APyDVFsksXrSRKDcSVQZDeidxPsumX/oo9ZxntPrGV2+xc4js4ykfyYASDQjjoH7QWcXRS9BJVYr0boS/x5jROtemb+NctmCGQtBsmE7wAH8PZOdvDfiFbOu3dFzhi9JkIzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1nz/Oay; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f51e80f894so570192e0c.1;
        Mon, 22 Jul 2024 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721665799; x=1722270599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMpK173jqbhGBQkIhTiO0UNUwU5v1AxINxh19kaGO8Q=;
        b=E1nz/OayAeE6c+q7P/sYhEAwpvBcX2q/XxfSX5dfYESN6Yv7Ss9TcMLI5qzfQF3stS
         LSxcyq+os5G3QJqxk4mvy/EHM0Vs+tGmlC9jkw7fxuHZlSMuepu5ry3mczawPAxDsdAv
         9ZcXFdR5piwPyuqS1yEuYXqcaTum+sGHpV5D4WdjaVdrhT3SdYpIOE3Ali4AyKxFyUH5
         2cEupYTU/odUPjDMqIPIyAG9G63fcUmppRkbqNDg5fiBeY1V0vVi1aFfTjRI2De0knQC
         bA6CtgfgJ9nHulhJLSvwczoD6E2QPx+JluXRdg5Aehgp1XEIwCUdu9Pz5QQUWPpH0l/h
         /EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721665799; x=1722270599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMpK173jqbhGBQkIhTiO0UNUwU5v1AxINxh19kaGO8Q=;
        b=nRWA07A5zZCPdQjuO1/AeGH17q/Unxrm2fyPpGQxrYY7bVatEeF1qDmwYh5Tavn2fo
         qVfdScdw3n4BR7GmGizUtV8KJjPCJ4uCBidaLYBKF67OdiBxBgVoYJan/nPXaN3KoKJh
         YsHiDtmD6oFeI6XpRuCCdHbIOXoJM/cDUeLpecq+npEOaugQr0Okr7xRYGRVq2GUMvhG
         tt1U8Pw9siV/nTwl6+NNgYHGfjlULsx0Db6LEN3NyHy4nl3tKCyQj/ROIslULDLzEZQX
         tZb7Wnna4KGslwnmGOsNHJOhF1jMpvPjtroTfuFwzmwfaHRqQt8VFUmlHJvWB/GNZg95
         uYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLl5xWS07QPCHRd4Mukz+ewxF7oNEExpawsAdcoK1HXSULq+7W9Q4DGd2P/ovFvlKlyxe4KrNtKyEAz/D+rGiGKkdhLqLq0wh09J8UjWMF01AP+FKIQ+jKew7Tb0+q5uuaNFWFna8FpkcZscgvrFJUMaCiooURqz9X
X-Gm-Message-State: AOJu0YyyRYeU7cwz+L42EWzoFiKLJC3Z37MlSdksK8tyAPe11VHEglyz
	c1UU2zr1kQD8Qoy0ERDEuAuyu78qvLQ+Ob7pST1GMNuDEo+xDYlbXB0aQ8dxv9aJnZdXVxsDYvn
	KkeBNhJKDTHiSGa4UqlKMycBsZmo=
X-Google-Smtp-Source: AGHT+IEXABDa6VN4CsqLj7xeSwXNGQVxnM0LfKN1zcSnE8JaHi67IhpiyP8Bt8mxjlog677gjmHuMOW0jZXrvPri2Mw=
X-Received: by 2002:a05:6122:169d:b0:4e4:ed90:27e6 with SMTP id
 71dfb90a1353d-4f506668452mr8406989e0c.5.1721665798870; Mon, 22 Jul 2024
 09:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch> <20240722030841.93759-1-dracodingfly@gmail.com>
In-Reply-To: <20240722030841.93759-1-dracodingfly@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 22 Jul 2024 09:29:21 -0700
Message-ID: <CAF=yD-+Hx9Tg-Fj+7hutPJ7inL_GpgiY4WAXXdhN-tzj5Q1caQ@mail.gmail.com>
Subject: Re: [PATCH bpf v5] bpf: Fixed segment issue when downgrade gso_size
To: Fred Li <dracodingfly@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, herbert@gondor.apana.org.au, john.fastabend@gmail.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 8:08=E2=80=AFPM Fred Li <dracodingfly@gmail.com> wr=
ote:
>
> Linearize skb when downgrad gso_size to prevent triggering
> the BUG_ON during segment skb as described in [1].
>
> v5 changes:
>  - add bpf subject prefix.
>  - adjust message to imperative mood.
>
> v4 changes:
>  - add fixed tag.
>
> v3 changes:
>  - linearize skb if having frag_list as Willem de Bruijn suggested [2].
>
> [1] https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail=
.com/
> [2] https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.google=
rs.com.notmuch/
>
> Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
> Signed-off-by: Fred Li <dracodingfly@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

My comments were informational, for a next patch if any, really. v4
was fine. v5 is too.

