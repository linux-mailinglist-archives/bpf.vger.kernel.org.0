Return-Path: <bpf+bounces-32242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD1B909EAA
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023262814EB
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7EA1C6A8;
	Sun, 16 Jun 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXGcf6tp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1A10A19
	for <bpf@vger.kernel.org>; Sun, 16 Jun 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558006; cv=none; b=Tcd3fgDw+5aqjeCqmCC0Hc7Ny096QP74H9N1Il/99Vf0t7fXZ3EjA2vWaHRb90uLTreI3po8qkYugU1DXBxonF7qdcU+t3P6z4cHTiwHNkEBu5w41CZsidfcbV/fGNYcTAGTeLSs8ONIAbVcHUHDTzMsXXgz4TXPSn48wWWZey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558006; c=relaxed/simple;
	bh=r2yYC+UoEjtnRM7WDnB1cybdnxN7RgWtEsC+CfS5zks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj0EJANiq5aCJZMrMi+fpQL9JMppFu0u1CdK1BQ80MdgDZg5aD0asmVenVQfGUKmSgR0euM4xr21E4OlaDv/a1WNjYtPRUOhUmW+hgvyBjThluJ5VkC0iyCxE6SFHzFlJWalED+rgEIstmhn2bpCygf20bVRBcfw2bMRuatxnY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXGcf6tp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217990f997so27282595e9.2
        for <bpf@vger.kernel.org>; Sun, 16 Jun 2024 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718558003; x=1719162803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2yYC+UoEjtnRM7WDnB1cybdnxN7RgWtEsC+CfS5zks=;
        b=aXGcf6tpjQbVOes655n9j7Q+9eSj74R/yCOUWyWVduCR0IBP1E1EezP8eKLe98Rd94
         ycG11zVRINzx3G/SBdXZmKIqzs8IKxyeRXSfCa1nHIiXzX529VTa5qsCZwMfxwRZHjkX
         Umop66YE8zjWsC7tflRDOIoSGsuNeuORx52EH+H1LCVTDxtuf6Lg7NidzzI/+BHAPrcQ
         H84Ck/K/L22ohJfx93+hZHnAfi7th3gu9nT3X1ggzWcwmplZF3VO6zNVSSNficxfBfej
         sMtVfFdMSJp6qbDpicD0H8w9l/NirEKZKo9+I0smVC4RJf+RYVrYE+SY7Xzz6/PHX3Vn
         2d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718558003; x=1719162803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2yYC+UoEjtnRM7WDnB1cybdnxN7RgWtEsC+CfS5zks=;
        b=U6v5Te5Qlm8B2Vqn4wXhmv5XUkqCXdEm5wBBlckyA2L7rAxad57TN16yec7phe+XE4
         iXDAO5Glgv2m387Vb81JObte3ycqjBMlW/LaG+fodrn/q1hilcURl7WNQ2GVNR5x1hY1
         OVsrcYsi8swZ45fqnD5cLBoU+8MoFF95srzrsu7L0l7uzAc/TQZgOqYaEAOCweAQT/Gh
         dV1SgUv1BbtJVUW3o3VIoS75x/cpaP0LBhDfszNm1EkXcit6iKuVBB9HCarKw2I9MdEe
         anJmM3vcVJ4mpA0gK18P7ib0HWc0E0YIQ3C5MXvdm1cC/mPHfjbSZXEvXCAycbJA5CSY
         layw==
X-Gm-Message-State: AOJu0YwUyAt2HXGhzmR8L0VnjBghn5M3ZuiexeKuOV3Mkt3ip38GXn0S
	o2u9k3QXuxbAI494tSUzqD8tifKYCe1pgPMU0behy45c8amfjkKX/vgb5bqLt35SYqqBel04Dmd
	ktqSUmCcMZoiOBpQd90Au5LYX/Po=
X-Google-Smtp-Source: AGHT+IEDHhs7mXYoeliocw9YG+J6SgMYicx7gnvQbubj8i6mOGt3oMSIWgWmqjQna2ykxtkn+Ql/FvJKdemWaFo6Ht4=
X-Received: by 2002:a05:6000:102:b0:360:6e1d:6c68 with SMTP id
 ffacd0b85a97d-3607a759bf8mr5504223f8f.16.1718558002667; Sun, 16 Jun 2024
 10:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <_rb6UwcCpRnlQuDuzb7fmzMbzQTHnFLDJfgjijmgNIDQeBxbNnmNHWrtlExYTEwiXVSfgv920x8zl-EDM0eb-oVvFgwWDizbNu0omo6UsnA=@protonmail.com>
In-Reply-To: <_rb6UwcCpRnlQuDuzb7fmzMbzQTHnFLDJfgjijmgNIDQeBxbNnmNHWrtlExYTEwiXVSfgv920x8zl-EDM0eb-oVvFgwWDizbNu0omo6UsnA=@protonmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 16 Jun 2024 10:13:11 -0700
Message-ID: <CAADnVQJ_WWx8w4b=6Gc2EpzAjgv+6A0ridnMz2TvS2egj4r3Gw@mail.gmail.com>
Subject: Re: Infinite loop with JA + JCOND
To: Zac Ecob <zacecob@protonmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 11:49=E2=80=AFPM Zac Ecob <zacecob@protonmail.com> =
wrote:
>
> Hi,
>
> Found a program that the verifier accepts but causes an infinite loop. Wo=
rks on 6.9.4 (which I ran in qemu-system-x86_64).
>
> The JA always jumps back to the start of the program, where the JCOND wil=
l never successfully jump to exit.
>
> Attached is the repro files.

Thanks for the report.
It exposes a bug in insn patching where may_goto is the first insn
and goto jumps to that very first insn.
So bpf_patch_insn_data() adjust JA's off unnecessarily.

