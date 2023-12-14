Return-Path: <bpf+bounces-17887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A94F813DEB
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A782836E1
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41166AA9;
	Thu, 14 Dec 2023 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUtNz1XM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF5671E0
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so68425a12.2
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 15:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702595107; x=1703199907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7t0iV27Q3OZ8kjrArKj8L8QZ6ODP7+c57v6kVhZPOQ=;
        b=DUtNz1XMSpkDZWRPgNpypU7J0YzC7bFr/D0Pa8Y8no9yCZz8cSjUWldOmS/ic/iEHf
         xAWPMtKLtOEwxyxclbH5M8ht/k6UMt1eov12n9i2s9pguC0A4FnI2wEsWxRJtS1guAyg
         kc4R8NAVql63lOBRybz/6rLbwOikprZKc48I/ulKxQudj7x+C/yW3PfIjsXqpBG7uBHY
         ftYiqadm6g8XfcIBzrbxvd6NU8CPCCsQq9adQAOtzAWWA2m3Hi2u+bQUvJlOkSbf+NAz
         PaG3zN+PevMAuv9qXK5cMTiKWxmnCCrWtlLLG41R/GmbDVeHtHJFwXLfQX8MJo0iDICE
         /BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595107; x=1703199907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7t0iV27Q3OZ8kjrArKj8L8QZ6ODP7+c57v6kVhZPOQ=;
        b=jTfqkteoEeptVJH5rkSWpM7m4XT9QJI5sXe2v+qTE3rTQzLeOEYAYYEKcWlxDI+z5z
         XDdq9dw5KYHqoe0qKOsrTyAUd5BuSvJbqtOHAGkWsStFsNsVCV3bOEXZ6cdSzhykvD7a
         g8n2/GIydxD21dytEkX4GWl6fzmbKfENKcDVkmvJYfJE1XDFo3HdRCRMJMxaRZHn1loo
         i2EprjUq8HJ1btLX/zvyrxViSwbC6jF+i8YbjZnMQ8/kB5hGiOmjZ1yLUigKU1A89Jhy
         tHfuf87+Dn0mU0qYZRGMS0u0lSFt+Tr0W0D4FDq/FQxKeQhqs7DRaS8eKiaazg+SfQCV
         dAQQ==
X-Gm-Message-State: AOJu0Yz3E9K9KsOZ511JJz8cSycbh2jZCoZ+spc8roHNoedZT1iDPv8i
	AuOauszl0SY/2ywPEKuA3LXx6EjMr/uc2e5RV02r2Kw0
X-Google-Smtp-Source: AGHT+IEec9mykCXNT9jo6pkNC4XRXpCoSeaP0Phs1VY8cSHwPmoJ9w0iUPY0/i75odRQ7/Y//fzIXDjUE3rih6o37zM=
X-Received: by 2002:a05:6512:290:b0:50d:1557:f38b with SMTP id
 j16-20020a056512029000b0050d1557f38bmr4948841lfp.38.1702594606333; Thu, 14
 Dec 2023 14:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214225016.1209867-1-andrii@kernel.org>
In-Reply-To: <20231214225016.1209867-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 14:56:34 -0800
Message-ID: <CAEf4BzZVS-U28tswb8P5scO8aXKCd4cteS=-r4xHvyXb2XVz7A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/2] BPF FS mount options parsing follow ups
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 2:50=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Original BPF token patch set ([0]) added delegate_xxx mount options which
> supported only special "any" value and hexadecimal bitmask. This patch se=
t
> attempts to make specifying and inspecting these mount options more
> human-friendly by supporting string constants matching corresponding bpf_=
cmd,
> bpf_map_type, bpf_prog_type, and bpf_attach_type enumerators.
>
> This implementation relies on BTF information to find all supported symbo=
lic
> names. If kernel wasn't built with BTF, BPF FS will still support "any" a=
nd
> hex-based mask.
>
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D80570=
7&state=3D*
>
> v1->v2:
>   - strip BPF_, BPF_MAP_TYPE_, and BPF_PROG_TYPE_ prefixes,
>     do case-insensitive comparison, normalize to lower case (Alexei).
>

Argh, patches are actually from v1, sorry, rebase troubles. Will send
v3 with the proper version of the code.


> Andrii Nakryiko (2):
>   bpf: support symbolic BPF FS delegation mount options
>   selftests/bpf: utilize string values for delegate_xxx mount options
>
>  kernel/bpf/inode.c                            | 249 +++++++++++++++---
>  .../testing/selftests/bpf/prog_tests/token.c  |  52 ++--
>  2 files changed, 243 insertions(+), 58 deletions(-)
>
> --
> 2.34.1
>

