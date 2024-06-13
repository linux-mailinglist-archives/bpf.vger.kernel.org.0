Return-Path: <bpf+bounces-32102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035F79077E7
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 18:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167201C20F9D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55912FB16;
	Thu, 13 Jun 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNMNdKeM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE3A23
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295029; cv=none; b=UWW2wFLcqrtGBcSsv7rjp0nlmecD0/fQdSKqkFs2VtDXrPxLXMEZXFvGrO8l2Gr5z+krk/8xPq3dvZiteV5wj/ctHLCnhb3NIKiRyg2xO+d7uheLv4m+wvD31nyYPFr/n4xBfmoIJDUWtminRonsZ4u2XPXj/T/ScbcD35Cz7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295029; c=relaxed/simple;
	bh=FvFG1L50IzubFAjsgc9rN3gI+Zl3GADp3ftRFApkpVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOEPConqcpPvFMV4/JoCXdtOeYj9OmkbljBpmIK1d+W8s2L2C2QKIq3GktPaIpEoe7lt63XihaPmySGUNQVhKDqskqz0Qhqg2XSI8yb4O88LQktY6XJcniAfkPDHKUIn4jDuWCAAtXN66CY7sL6ZCvSJHb+Wq90iPtbknH0EmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNMNdKeM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f70509b811so9083625ad.1
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718295028; x=1718899828; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yOukDm54YluBRvUjAMMzY4UTGYLf360TNxB10DO5/WA=;
        b=KNMNdKeMnBdfMqhbtY0pf54T3OaPhhbH+QAusel68M9KLo6sh4erAd9qiuGXDIoVrK
         +rxev3mG0QX71putrZNDDtIySC5wRLitNdB4oIw+2pchtDihEuFB5HBfAvBGq5LD+/Vd
         glRgpO8ZsnYjZywLXgbTFMRrpQF5k6NfqqMcNQhv7P049Q3LQlzDKgX9S/6yfR7sndTO
         iD1zmlhA4fZN1KAmP8OQTN8ilLluKAZHnZbS8vgq+B1cdLmDindzhJBVLJy7VFWbazL5
         0k08gW/1KT1nns3Urqsfv6TZakUvNDhu1gf9RXAw3dPTSwffDGS8sVbcnc2g6V34VlyK
         8LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295028; x=1718899828;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOukDm54YluBRvUjAMMzY4UTGYLf360TNxB10DO5/WA=;
        b=E9+FpH8aBbePNb8kj0tBZufYgYsB5ZmNTvleJn6fko1mvIDe5gkRUrZ2LZs+T5IeeW
         aWBho9mbEiiLCUj0jimfpJl3NOCYZZzBdu4UyYd4Eki+Fc5w8DQhMa9td2K1CTggvOl5
         UXIyQbrOuFeUWkszISRz9anZYhZXA5839FKYj9xvXeBOmZHvzTalRFTYMB5BusPw4Pum
         TmTz8KgA80LH0mdB+Y5+eRoNeE0bgKUV0dJ/GingbwQtoiNlB5brsXeNY7L0Gng41kQT
         6bjqthht66AjfA/Rd7fbgiAkt5DUpgcOnlFSAzYPheNypdy2aoYG4HkjdYfza9hzNZd2
         p4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxT7cGtN5Fkf9wzWMk+KaUeLSjcNPEbZ+bAlnuMy699XlhvLp4bSZWtPcZrPihAvoQw5RMNJxuzT/rnfQjfETJJsXS
X-Gm-Message-State: AOJu0YykBKMcgICAijHMgslbO/lxv678nrkWz/AJZAQrPzJM1WdEUtnn
	Ax5pWHvi15YdDOmoJmq18TfYhX+rNhjAgREZEqyMSEWbEKaZFUxH
X-Google-Smtp-Source: AGHT+IEU3YqMQL1aAUWUJr7ZgPFScaZgpNBUzNYHrEPn0AuIrrfT6B3jzcY6eP71QG3sz7RWyk/96A==
X-Received: by 2002:a17:902:bcc2:b0:1f7:326:c65f with SMTP id d9443c01a7336-1f8627cbe2amr1122505ad.30.1718295027768;
        Thu, 13 Jun 2024 09:10:27 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45f4749sm1921744a91.26.2024.06.13.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:10:27 -0700 (PDT)
Message-ID: <50747d53b236c513c417c9a4ef607990b0174fd4.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/4] bpf: Track delta between "linked"
 registers.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Thu, 13 Jun 2024 09:10:22 -0700
In-Reply-To: <20240613013815.953-3-alexei.starovoitov@gmail.com>
References: <20240613013815.953-1-alexei.starovoitov@gmail.com>
	 <20240613013815.953-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 18:38 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Compilers can generate the code
>   r1 =3D r2
>   r1 +=3D 0x1
>   if r2 < 1000 goto ...
>   use knowledge of r2 range in subsequent r1 operations
>=20
> So remember constant delta between r2 and r1 and update r1 after 'if' con=
dition.
>=20
> Unfortunately LLVM still uses this pattern for loops with 'can_loop' cons=
truct:
> for (i =3D 0; i < 1000 && can_loop; i++)
>=20
> The "undo" pass was introduced in LLVM
> https://reviews.llvm.org/D121937
> to prevent this optimization, but it cannot cover all cases.
> Instead of fighting middle end optimizer in BPF backend teach the verifie=
r
> about this pattern.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

