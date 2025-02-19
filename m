Return-Path: <bpf+bounces-51888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EB1A3AF16
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905B817335B
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 01:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7A3596B;
	Wed, 19 Feb 2025 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOkBsFv1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A333E1
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929639; cv=none; b=ToLiU4csMX3U6M0ZVDmaYS7is148fRm2hlm1ClqKdXiW7lkFvi9PDSe1kBc2WMi5uG9EYG5rWIsk3uw6xPuPFK0v0LNKY9PiCNpEIhXVZd3fivkQuvIwNCBRli28eaa3zE3aQFfxOYZgdDIOV+0/Mg2dKnXDVGpgJUTbHu4Pz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929639; c=relaxed/simple;
	bh=HybSCDpc7lowXQerdocnQwmvpwyIpCyNGTKJefaf+BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOQQRzKU6yDOGcWsL7QSawiFS7e/cwXEjBP4JXzEPSWoGNzualL77gzeUE9cUJQ+eSWu8Yw1TTmRX0OvhTTPojKU1cbQQNJnaXfjy7yZ0/0Jh7tqXFT554Ilai/6wMq0qsXu2XA1PkAtEG/YLscd3DSiRVCe1LxFLUD33Cy5wIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOkBsFv1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43984e9cc90so1874365e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 17:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739929636; x=1740534436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HybSCDpc7lowXQerdocnQwmvpwyIpCyNGTKJefaf+BI=;
        b=DOkBsFv1DE6jOodpFLcTbsLEvtV9e1maV99pjjNch7KnbClfPyuxgnH7jyppkw/chV
         bGSOcYzfkgR+2QpYRwenv+HBBxCjoT0rhVDvY5AWvbtchBGwGNDejgPWuvL6Dkvn4lQf
         JfrzolJuuJWxCyaQtlZg6AaU5rXu6E2qwQu4e44pz6hEQnf6WwveRhFhX5R5anNDuSvf
         GEhUVEtiml/KEUFbfBB5ClJNs6IxntA1vz05Xo6SL724z8Ujd9ukwrZv3Y7tlKcc6Nys
         XpxTfrsZXveQbnxZTYEuBIRnv278AaU4158QTsYhCPfEF/8WHyixtb1PrxkCmhCcJ5ka
         xi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739929636; x=1740534436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HybSCDpc7lowXQerdocnQwmvpwyIpCyNGTKJefaf+BI=;
        b=OSBfpNd61uR7F7310NI+3FQbZvhATVjM0/zm6Ci8VbtaPbtGRx7PT6NtqTPnA96Eab
         7EnXz8WuT1DHpBU9Atl4UjewKifGUblDnoqd2CX4plVV3DvQC6FGXxwDkDqIPKvUNmbj
         vO1eqLYZQpuCQ55Nr4DtVdQdz9jGMF7qlxvA3rtWBYaO6JsbpIG7L/cQUR+j4arWgxJ1
         E86ALr08DJwi6AT6lh5NOfUbOGWYqg3OU7LGi3enZbXTo6OnoT6qjjLRx/8ewuH0HZ+x
         oVfMpLOOewli9+C6JRU6yWQbEwJ7pEvE+EdU26zZwkF+bCeULWK0PIK2QLqF7ptn+H4v
         Hq/g==
X-Gm-Message-State: AOJu0YxAqUG9NIXv9J0wkQOi/IlNnTB+t2tZ3ZsL/hYcPnTmW4DX04Z5
	qKDNjLRLTHPubfzk/8QsyX1rxr7xaNsARd+zK3pNsq+iY4GkIngIuZelkRrf7uIzQFa/U/QlIx2
	SQVw3HEz3J/ZvyUiaeWcXkLcQ08I=
X-Gm-Gg: ASbGncuRHxqv7RUHDslAel/lCnakn5GuDSnPkmZCvrkgNIUUfyMuVQEmvnzF/hnLFqt
	NXM9irAou5pIVlP6n8BOUEriyDTKivEc+9wio+nINo4eGVbVygSvGLMdY/vaxWzGe9NTXQUJ4W1
	aVb/x8kSlJnxc7jKTGb93H+RyYI1Vl
X-Google-Smtp-Source: AGHT+IFl1uOn/AQ0ux1Y1LBbUWg/etBs4AUpqWvg3H9g4OAhNDBIrfcz/KPE8LAstjPn+eMXrZBmNUUDMZJrZGFm3Yc=
X-Received: by 2002:a05:6000:1fa7:b0:38f:3ec3:4801 with SMTP id
 ffacd0b85a97d-38f57d94f86mr1719660f8f.25.1739929636317; Tue, 18 Feb 2025
 17:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213161931.46399-1-leon.hwang@linux.dev> <20250213161931.46399-2-leon.hwang@linux.dev>
In-Reply-To: <20250213161931.46399-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Feb 2025 17:47:05 -0800
X-Gm-Features: AWEUYZlHf30Aeo4vuD0wTjlJQRqBDHKg-uuhodIPCfoyNyq5NEr0T3RZMDoiWK8
Message-ID: <CAADnVQLhw8PgS6vcOvceJvdUdazfi77tXj6n_w0b=gD1fwMFsw@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v2 1/4] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:19=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
> +#ifdef CONFIG_SMP

What happens on !SMP ?
I think the code assumes that the verifier will adjust ld_imm64
with percpu insn.
On !SMP ld_imm64 will be pointing where?

