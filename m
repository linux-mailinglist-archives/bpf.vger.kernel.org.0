Return-Path: <bpf+bounces-18355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0338A8196C2
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 03:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A7E1C24B2B
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24132846B;
	Wed, 20 Dec 2023 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWYWo03h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABEF8486
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336746a545fso143255f8f.0
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 18:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703038762; x=1703643562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69F54k+U4iieD8I1+780eYuMVgcpCFPHt8HENHB54z4=;
        b=HWYWo03h3DMLxEFtzLTQ5UHhGMCMlDAs7P3YY6t8+U9W4VO5j8saO7cRt8hJvrXjsC
         nU6tysY7MvQbJgWHT42goNXkVgdUx7l4htwGEwRgbdQecVTPZfHYf+x2BtGeRr8M8fvb
         u7/FUUAdAjs0ha/Em3hTp4L22Yg8uWHdOBZuKHiWNZTOp3Vv4taR5GTHFxW5nrdTmA1E
         RwSj4glRCj4q344jJmo1oLmo3POc0OKGfmFqZEdLOIk77v1O1mhvOgD4CF/vH2RZoNAE
         4ABAdF9xF+XsjmQAyNt0G9WXIg1VsT3mviP/D2paToMVNtlCjCdNsii4Ypq3mN5odJ2U
         gxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703038762; x=1703643562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69F54k+U4iieD8I1+780eYuMVgcpCFPHt8HENHB54z4=;
        b=kd5bzKpLYAupcoK2kiZzeG4/sMHCk+GET69bY9EL9F9ITba+5Pb1NaGbfsauFMIU2t
         PycT9ycgJ7MN9QIQluRYZycJ+drmsVjnP2OP2K5UJx6egOwbijgng8r8iNpDdRX4trzy
         JZ8gsSTD9uT2Zw9j4GgjKBICaQ4JylcOwqGS6ewFAN5JeQtD3k5xGSjoFj7e3UKr+Muo
         DnjxKgP96R+t9p+/wm7PsxnFbdVY3Qh0v0Lk6vvSeMDVtG065fl080Oz3ga56zCH601S
         VDbTiegueGYaOG3zWCg0ltv6ataAd12ZbMQjZWYhoP+oGoY5KemDSgodsknP30+N/55C
         DvOw==
X-Gm-Message-State: AOJu0YzD3meIncW2jAwL/IyoIeAdx3BxixmwYkbPjKEkbsz0CD0r+u4E
	1fNjqQKuQiJBR+IYLZKdO6Rj2b1n0xgw4/Js3Og=
X-Google-Smtp-Source: AGHT+IH0x/04Ygu7FMj32u4Qq2unz8gpfLq7e+x7mSkm03aZw1ZCEdQanal7pUq2tr9Ga7pQ2uWA7uGUHW3/Iy27x/c=
X-Received: by 2002:a5d:5048:0:b0:336:5ea5:2743 with SMTP id
 h8-20020a5d5048000000b003365ea52743mr1195155wrt.49.1703038762353; Tue, 19 Dec
 2023 18:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215011334.2307144-1-andrii@kernel.org> <20231215011334.2307144-8-andrii@kernel.org>
In-Reply-To: <20231215011334.2307144-8-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 18:19:10 -0800
Message-ID: <CAADnVQL_aTdNBJ3oCruAFqirE-qYUQq3ycbftzN=PffT7aAx5A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/10] bpf: add support for passing dynptr
 pointer to global subprog
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 5:14=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> +               } else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_=
RDONLY)) {
> +                       ret =3D process_dynptr_func(env, regno, -1, arg->=
arg_type, 0);

Minor nit:

It's a rdonly dynptr, but still... may be pass env->insn_idx instead of -1 =
?

Separately, I'm not sure why we still pass insn_idx in so many
functions. Looks like we can use env->insn_idx pretty much everywhere
and remove that argument.

The first 5 patches are very tricky, but all tests are green,
so they must be correct :)

