Return-Path: <bpf+bounces-28152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD58B6352
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEBC1C21AC0
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558C1411DD;
	Mon, 29 Apr 2024 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsIESb9Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93B1411D9
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421631; cv=none; b=TziJ6Un1SJxMrnxXYj1vlJ3oUr9TsOAac2M10b6lIlg7f7BgnPWLQuUoH20aO/D5aSZn0K+krRv7A29qy60bzHCQGhSl2UIHXt6WOMnTNad9LnZf81Nkd0AjPYXtBwzYLRuGvqNc33d4yfnQkD6hraPs+qWOrAKkd7wpGOEj0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421631; c=relaxed/simple;
	bh=obmDaH6ZshbMsYXdB3+X0vXcedTXAx92Kl8vinq7JQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7iwU/MuhfBA3AbX8wgnYMNyoXeuXFaJLAPYNJ+8OV653B722ru8EkZqMCSntatcH6/QHWGuCRg0w8v/O1RldYdeIxvfZKWOTfnriy97BhN3aCAH4FNWZ4SbBoWvV9cUfWsFZB/BtnV5Brd9DDsINmXFTE8fUKOArppEqbAkh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsIESb9Y; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so4101136a91.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714421629; x=1715026429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GeCF+I5nRVip8wfcp9CrBMQ3kSAuVi0NniA3IjtzvU=;
        b=XsIESb9Yif2Lk0JPhYdOaFgP3CtdvOmIDcE0DOb5Jy9pAx8z48SpgdOjqJNr0NLJL5
         ydUHzbQov1no3/X3SZwrh3/dJXmR63r5j+NuiNov1qA4GCtmoXDjwJ1lU4T6MPC2MDvA
         TREE06P+YOcpEjYwac5BvbqqsDquP8XzAkKhvVTzfZr7Gvo0Yb+RksiFf6kKI4pslXu7
         qV36sPheLE28W3gey1ptR4TD9+IlinGGXO4XHEBciVhb+hfkhxODCCLPxrDQ0GuL0kuq
         H9LdPisHMghtezs6+zz0gua6tlZs5v0uNHqb1Qfy24VVnbl0zFBLTF/zvh5AT9FQn/N/
         z44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421629; x=1715026429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GeCF+I5nRVip8wfcp9CrBMQ3kSAuVi0NniA3IjtzvU=;
        b=jFY1HZMhfcKLaNQI6NitiqkWFzgd+bfen/tdTjn6Qr4BqKjnRd9kQX83NvaTCRn9tv
         5E3jlV/Ep5GghSTqLzkknSssXfO2z1TmXc7HxiJCkOAW+5QXTVNO2eBo/OO6REt8kdqX
         FMkfvj9Z6NY6NHwJXq1jmscImH3bgix1x/g9DNufO+aAbhBxb6XAVQD9xB8+vFisvmFc
         1qoE+JipaO+uCR2hQiF5xL283wtq+yR2j9Gvur9nLx2qgGL13cWadYRwW1N+ijicjCFb
         TxZ0+0CBxkw7m1xOvZsQh58l7o3B6KQNTqubZ6xazWWdNyvSQRv4KD1ZOv/aTruLC9/a
         ebjw==
X-Gm-Message-State: AOJu0YxpSzflGqUuN1deuTcGgDoTk5sv4YUx+pEOzrr1Caab14BkyV/Y
	tUb9rmrdwl5n9pymcKZot2XyvhzwfoHAQFiwbvz+4w4sYuEtydg3im4sO0LqkOcrNFTGx1S8Yzd
	kasxRVE6kCMjTqmV0KQzFVMFuBiE2hP5Q
X-Google-Smtp-Source: AGHT+IGNT0C1jkmzujL3/TlzPDwyd+RFp8NWS5Msq4iUAxv5mhgQL/JTdb2V3u/f3ordh9r11COHtQCbstoKTWy71fI=
X-Received: by 2002:a17:90a:fa8e:b0:2ae:b8df:89e7 with SMTP id
 cu14-20020a17090afa8e00b002aeb8df89e7mr674088pjb.38.1714421629282; Mon, 29
 Apr 2024 13:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714133551.git.vmalik@redhat.com> <665e725ca2da793566ac42f93b954b77c0d2f7fa.1714133551.git.vmalik@redhat.com>
In-Reply-To: <665e725ca2da793566ac42f93b954b77c0d2f7fa.1714133551.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 13:13:37 -0700
Message-ID: <CAEf4Bza2k+w-YF0uDb7hH=6-sZXNPyhonZjdMTm5Z9aqr5kkEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add tests for the
 "module:function" syntax
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:17=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> The previous patch added support for the "module:function" syntax for
> tracing programs. This adds tests for explicitly specifying the module
> name via the SEC macro and via the bpf_program__set_attach_target call.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  .../selftests/bpf/prog_tests/module_attach.c  |  6 +++++
>  .../selftests/bpf/progs/test_module_attach.c  | 23 +++++++++++++++++++
>  2 files changed, 29 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

