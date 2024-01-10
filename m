Return-Path: <bpf+bounces-19323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC41829B37
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 14:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5FA1F25226
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0500C48CC7;
	Wed, 10 Jan 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwxV2bot"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CBE4879C;
	Wed, 10 Jan 2024 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed85ec5b5so2757832276.3;
        Wed, 10 Jan 2024 05:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704893420; x=1705498220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPfofe3u+lD4YDt2+isSaKDrOXF8CqH8aujHfVtRZ9M=;
        b=fwxV2botUZ18RlcFJCaaXwhWmI0z4VNrN++395buH3CRiUGJSaO64QNZmIwtYEDnYF
         yEu7cCpDCe1rDW5AJFuPet8PjUbSNf/VnmXc/oNJysfSTcI66+IsBLszaeHdvlHAdx9w
         uxkyoPULgVeuFAnj9MUWCrobo5CF+Ck8vH8dRCJRe0qSChZ6DdqiMR3NQOufBVN1Oc/8
         fc40+EdWkxGQifH7vQIMpOCPviepwjCtv6tV9FTaOcfJUr6HilSWJTjFgJK2sEdosDZt
         K4/qciiNAyRtd68n3F0R7JyMrtJa/lTDbEkEYNT54DIsaa+YRfoVZNND/mSW0RuZwyxc
         2pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704893420; x=1705498220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPfofe3u+lD4YDt2+isSaKDrOXF8CqH8aujHfVtRZ9M=;
        b=agv/ot29N5/k1MfB9wuV1e8LHG76kDBLJosaEzOdFU+paRx3K0iQVuOWUCHIFsHOW1
         QSTqKH8Xkibv+4apWrCPIReCtvnDZFKbxWJg6mYeGLqpX2G+pTGXUVqcn9DskCd11zI3
         7/rX59JZ2RYeQboDjRjesLRL24AbK78H4h2AsBeDrQ+/Giv0tz2W0w6cC9h94881B5LW
         IJ3ohYnesJguqOqrh2HOf9wKYV6LaOl9XOwagscFfPcGKx29MY+/Dme8z6kYANQxqD9M
         jL0C2lwsgAynIKiGReZN8TZSM/Dstlnex7ZFlEBujg4Pr2hkCPkGOuNL2UaYM98n1/fZ
         MwIg==
X-Gm-Message-State: AOJu0YxvieAUiW1iZ4X5M7w9UC0ogXevjT+pVOGo+f0Ye9ntYl8Ofqly
	2GZlwqOcLWUx6MgqvyES5UbEBE3VQQt23ytMigpEglqDdg==
X-Google-Smtp-Source: AGHT+IHldQ5FbsYwsl7/kMG4XMWHRmUUUzRMVW9HLAaONINbCy9xupCgO+u0BED+KojM+wDvQ+6UhexddYWEBgHhsbU=
X-Received: by 2002:a25:d697:0:b0:dbd:1254:414f with SMTP id
 n145-20020a25d697000000b00dbd1254414fmr474612ybg.42.1704893419920; Wed, 10
 Jan 2024 05:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110125317.13742-1-sunhao.th@gmail.com> <20240110125317.13742-2-sunhao.th@gmail.com>
In-Reply-To: <20240110125317.13742-2-sunhao.th@gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 10 Jan 2024 14:30:08 +0100
Message-ID: <CACkBjsaWfo9h7H0O4wUWJ2qrAsw0XkJSUiKOC9H_FkOivvq=5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Add tests for alu on PTR_TO_FLOW_KEYS
To: bpf@vger.kernel.org
Cc: willemb@google.com, ast@kernel.org, linux-kernel@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:53=E2=80=AFPM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> Add two cases for PTR_TO_FLOW_KEYS alu. One for rejecting alu with
> variable offset, another for fixed offset.
>
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---
>  .../bpf/progs/verifier_value_illegal_alu.c    | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu=
.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> index 71814a753216..49089361c98a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> @@ -146,4 +146,41 @@ l0_%=3D:     exit;                                  =
         \
>         : __clobber_all);
>  }
>
> +SEC("flow_dissector")
> +__description("flow_keys illegal alu op with variable offset")
> +__failure
> +__msg("R7 pointer arithmetic on flow_keys prohibited")
> +__naked void flow_keys_illegal_variable_offset_alu(void)
> +{
> +       asm volatile("                                                  \
> +       r6 =3D r1;                                                       =
         \
> +       r7 =3D *(u64*)(r6 + %[flow_keys_off]);    \
> +       r8 =3D 8;                                                        =
         \
> +       r8 /=3D 1;                                                       =
         \
> +       r8 &=3D 8;                                                       =
         \
> +       r7 +=3D r8;                                                      =
         \
> +       r0 =3D *(u64*)(r7 + 0);                                   \
> +       exit;                                                            =
       \
> +"      :
> +       : __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys=
))
> +       : __clobber_all);
> +}
> +
> +SEC("flow_dissector")
> +__description("flow_keys valid alu op with fixed offset")
> +__success
> +__naked void flow_keys_legal_fixed_offset_alu(void)
> +{
> +       asm volatile("                                                  \
> +       r6 =3D r1;                                                       =
         \
> +       r7 =3D *(u64*)(r6 + %[flow_keys_off]);    \
> +       r8 =3D 8;                                                        =
         \
> +       r7 +=3D r8;                                                      =
         \
> +       r0 =3D *(u64*)(r7 + 0);                                   \
> +       exit;                                                            =
       \
> +"      :
> +       : __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys=
))
> +       : __clobber_all);
> +}
> +

The format here is strange and should be fixed later.
I'm also curious, why only fixed-off is used in check_flow_keys_access()
for validation?

