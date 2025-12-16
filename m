Return-Path: <bpf+bounces-76716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0136CC3B09
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 15:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0AEE3032629
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B1833B967;
	Tue, 16 Dec 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDNFR9FH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKYY5wzn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1933A9CF
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896114; cv=none; b=A2N3xouGPbmlBSXYCqR8ZkivN2blUOh8Pu9Ye9/5kQYMYmR0fF9qlMK4Xj1SYH7vW/Y/m7ywdU9bcWzYl2Y3OJPG6n2q8OCLfOUz97TzTzwKmRHF3MzamJ+cvYBwpRZp1SwR7i1Ku2F9w1u6YpMaNub7mBsYHc6Q12ymvTjZ5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896114; c=relaxed/simple;
	bh=ccNmne059vkomLlOaOaSTd251RYUCLPlgzSGqQjCrgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0k03Ox74Ufae5iENZz3fwqMhAnYIUc8sUpT2Teag816a0lsyh4HSS9WkDCWv0qkva3amoaAoB9FX/nPnm4ukqi4q4aHbCEGs5kR0QWwJisK132mIbRl1JfXrZi7ZmJcTdF3SB4JYQnN3VcBX7WKcwVjzeR9e9w7PhmoUjpLSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDNFR9FH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKYY5wzn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765896106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fkupt1S0B1BvCIMqxWnb3TuETYGWxl0IdwnizM8oMhE=;
	b=EDNFR9FHdEV6P3CfNenercS8cIbHUyBt04S93ZI7twrKCggY0Cdq1wJfRDQDpnavr33nT6
	HvGRRBg2w1HCJKiV/bge2dWYLvtRTvO3PSgs5puOTovv1O9xzlPkKe2c9pJRhmMFetoChz
	jDWtK2rEUchbO+jlpKkGfGFJyOe19yM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-wba6zb-hOxqHARLCIFpxlA-1; Tue, 16 Dec 2025 09:41:44 -0500
X-MC-Unique: wba6zb-hOxqHARLCIFpxlA-1
X-Mimecast-MFC-AGG-ID: wba6zb-hOxqHARLCIFpxlA_1765896102
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-37fd5c84925so20194181fa.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 06:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765896102; x=1766500902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fkupt1S0B1BvCIMqxWnb3TuETYGWxl0IdwnizM8oMhE=;
        b=UKYY5wznnfEN6KxCHVlkul59+ZzHRmrOkfddXmXbuSR53cFvO0Mj8gChigo+iZR20M
         s9H2Rwf2EuWoHE2csa5eIN9mb52qajGA3PBTu7TVjlzn7Y15a+FuKOcQjQzTorJTS751
         f7nhKHT1RWlPiEOwZ6aJ/Xq9kS4JQIoGaXLYsjiZIUC8UrkDWx2BeV4JR4yokcyiPaIo
         4Gj37oAiAWY3Bvj+SG/reIDt+OovSLOYZDvwLLSRK3OHqN9eFScAt6wJMGiucu8fBXd5
         9GJLreok9ejeWemZ5RWWq7vLB9a9iJOET+0f6z8biqyKs4Y8g/p7LzhlFUTnd9AGSoK2
         rkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765896102; x=1766500902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fkupt1S0B1BvCIMqxWnb3TuETYGWxl0IdwnizM8oMhE=;
        b=efHRODQsP8Xs5Fn3pjOw/tXZCPJxLg0RswpGPMh2vS7I28pUUxXuEyS/TOyf68OL0S
         7BiUK+/dJHfSH+LyVEqF4gKuXynpX1YUkqMBmIS1in8e3f8L5KZrjAp7YEbhKwGvSToz
         GN+CGf92Mn0QDfWe4ldyWyecLFP9hPtsr2dIyHyXStsl7s8eIj6HSstonc9VF+DOKd+u
         +pR3BHSxVLx3NaDilGHYPMGoUpXaMrF+cfnP6raY40ZfMX/7GkpJVWrIFw7o0mVnx5Sa
         uHhpjnj5HpQ0lg7oPLHR8iixc3bjWOZKvGUejM20LkoQig5LOeBdWFfpwvS/wpVvgH3D
         R/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXXcQwhB0TZ5AwRSvdoFqmSjiEE2JDoa3oY2glgkb7GK7V0C7qs+/VjZIU4tq8jgGD4Ib0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRs+1p9kc9N+Cs38RjBEoXjBUi0YozU5V8F5lN3L+E3BUhUQSF
	w8TsoKBjWy5H/j7Qdf3GLeHZugMXgpXsJ+kmtOTV+5IW4e788ehyXY5DR7i9twvQ8LyC26NBDzd
	YwKWR6fG5PpgnCJYbMPIXhkBW6CD40xNffOWeF/6VqRRenv/TqNdSHXPqBDhzhGozWu9NGgESLA
	/72YEOkalBFBGmPJ6m62YUg43Z9x8m
X-Gm-Gg: AY/fxX56ZtJ3Ihouh3Ise6CZ7tyDf8ADxr2NT4cXTZG0dNZzFk1yHGcS3dLLyoQqtiH
	xzqrbm50L9ddFUf6QD7ne2YqmS1sPovZOzTPkd/H/LQNf00E9wuMXZSjahW2u6QGwYgzeR1ctEy
	5LNwAnwXaSMxyXRZs8MPxG0xaxpzqojV0A/An2j988bycmRuB9jo1bnr1Ir1TYtIaFcQ==
X-Received: by 2002:a2e:be1d:0:b0:37a:2c7d:2d69 with SMTP id 38308e7fff4ca-37fd08d177cmr47513791fa.40.1765896102202;
        Tue, 16 Dec 2025 06:41:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkFeidhWoEUXLOmVzRaA5Q1vpR6sd1hl5H8AyG2YKcsJa5Z2DC+ZpSNMyIFB0VFZT2Q7ECX9btviSWdIun+M8=
X-Received: by 2002:a2e:be1d:0:b0:37a:2c7d:2d69 with SMTP id
 38308e7fff4ca-37fd08d177cmr47513691fa.40.1765896101740; Tue, 16 Dec 2025
 06:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205151924.2250142-1-costa.shul@redhat.com>
In-Reply-To: <20251205151924.2250142-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 16 Dec 2025 15:41:30 +0100
X-Gm-Features: AQt7F2pjpx9ZoHrOwX0LI8Y6w5xcnsUp4TnVRIgGM5mbKAkA2KI7TqHSvXARnbg
Message-ID: <CAP4=nvS9fTtNCtDCt254-ukTePD7hW3HoKExOPNPDOdppUig9g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] tools/rtla: Consolidate nr_cpus usage across all tools
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 5. 12. 2025 v 16:19 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
> diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src=
/timerlat_u.c
> index ce68e39d25fd..a569fe7f93aa 100644
> --- a/tools/tracing/rtla/src/timerlat_u.c
> +++ b/tools/tracing/rtla/src/timerlat_u.c
> @@ -16,7 +16,7 @@
>  #include <sys/wait.h>
>  #include <sys/prctl.h>
>
> -#include "utils.h"
> +#include "common.h"
>  #include "timerlat_u.h"
>

Since commit 2f3172f9dd58c ("tools/rtla: Consolidate code between
osnoise/timerlat and hist/top") that was merged into 6.18, common.h
includes timerlat_u.h. Your change thus causes a double include of
timerlat_u.h, leading to a build error:

In file included from src/timerlat_u.c:20:
src/timerlat_u.h:6:8: error: redefinition of =E2=80=98struct timerlat_u_par=
ams=E2=80=99
   6 | struct timerlat_u_params {
     |        ^~~~~~~~~~~~~~~~~
In file included from src/common.h:5,
                from src/timerlat_u.c:19:
src/timerlat_u.h:6:8: note: originally defined here
   6 | struct timerlat_u_params {
     |        ^~~~~~~~~~~~~~~~~

Please rebase your patchset and fix this so that timerlat_u.h is only
included once.

Tomas


