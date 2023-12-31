Return-Path: <bpf+bounces-18757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5599F820FC5
	for <lists+bpf@lfdr.de>; Sun, 31 Dec 2023 23:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F211C21B56
	for <lists+bpf@lfdr.de>; Sun, 31 Dec 2023 22:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806CC2C0;
	Sun, 31 Dec 2023 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPjU10Ab"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA2C127;
	Sun, 31 Dec 2023 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336746a545fso4763764f8f.0;
        Sun, 31 Dec 2023 14:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704061731; x=1704666531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cQ7dAlg8dvK0u1JM7suKS/rJ6Yn0bYuLvOXdSYO1Ak=;
        b=OPjU10AbeM3mOljBRkixF35SijqFa920BvSEtb6ZkffzBSqK08fCRgN58ZKJRnhwmD
         JnkP81KrXQt01uOVEMluijZvZA+hmfpn+1R3LQwtnpXCYdq/xPbj3PgX4fNXEOVRm+tZ
         LwXiPJSmZVwV63oPdO/LyfrQvLndYX8A0ovVuHmZifE+zcm8U/l39VZKhBTKTH9nWeXU
         WdIsC3YXUlMeKE3Ijex2KSgkSRu8bAf2NwXn39LUzswoFEqc4Fsdf8tvek9sBRFwQTD1
         GDwe2s3jsKAVt7oDiRXpnN1mbqiiEUgnnBaQM8wQdgTLLjeJ+4JE7r374q5KwI/xroso
         3lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704061731; x=1704666531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cQ7dAlg8dvK0u1JM7suKS/rJ6Yn0bYuLvOXdSYO1Ak=;
        b=VE38r7s7pEDpsPkJrGDd3tPB1Ix80x0izCQZfBOdRWnnB7gSBjHok6kR5ibcFPrssQ
         VzsTGux1k5sFk43AQINEvOhNLDBeCKp95P3lkE0BzqX1+I8ODF90L5PZy3Pm4SL9MoFL
         rrHqvBOmhYjkgujZE7lBAlCkDQ9por3mVU5dgK8dBjwXYSZ3Bc64NldgC7J4f6nNkQ/h
         VMGGJP2CUKK4adj2TDvEiBCSbj85Sy3/q52vy2RwF+lx0VZ5zKur5L7dn0skfkdiYrNW
         gYgV/1xOjEqi9HLiFSg0z+hjL2xR2GM8Cg3aUCk2GtJUEmyCpoL02qIi6rqPBNOKjxij
         TmvQ==
X-Gm-Message-State: AOJu0YxJjhBbC4XbD/9iAr2D9fJJGDc1AEJ4A+XibmaxHtULCQomLeE5
	Tshyus5L0CPZYinn75YXOwsyWjHv+KcpRmT3dUQ=
X-Google-Smtp-Source: AGHT+IHNi6dZhDS0epQz+mEmSYY/YeBLka2pG9b+mY0Phd9O6WkTRrP7h95+Q9fbkdycfV1QhbAy1MoI/sERN1d5dQg=
X-Received: by 2002:adf:b35a:0:b0:336:7472:a40b with SMTP id
 k26-20020adfb35a000000b003367472a40bmr7965585wrd.0.1704061730737; Sun, 31 Dec
 2023 14:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7011cdcc-4287-4e63-8bfa-f08710f670b1@web.de>
In-Reply-To: <7011cdcc-4287-4e63-8bfa-f08710f670b1@web.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 Dec 2023 14:28:39 -0800
Message-ID: <CAADnVQLq7RKV+RBJm02HwfXujaUwFXsD77BqJK6ZpLQ-BObCdA@mail.gmail.com>
Subject: Re: [PATCH 0/5] bpf: Adjustments for four function implementations
To: Markus Elfring <Markus.Elfring@web.de>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 12:04=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 30 Dec 2023 20:51:23 +0100
>
> A few update suggestions were taken into account
> from static source code analysis.

Auto Nack.
Pls don't send such patches. You were told multiple
times that such kfree usage is fine.

