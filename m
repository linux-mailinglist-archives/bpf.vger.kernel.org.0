Return-Path: <bpf+bounces-65685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 699DDB26F38
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E2754E2880
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A289722332E;
	Thu, 14 Aug 2025 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POXkcbPf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC5319869;
	Thu, 14 Aug 2025 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197205; cv=none; b=DhTD+96cui7EevYNCCXNKkjtfK0w4EgsBYWoZaHNoYOEQ0AVpz+4JvEpYXc2jlsSGDAQp1ZKb/shoDkxl4cXbttVQ+8d5AryLsbTMfrZdVJ8wC7p7j/S+2v9biJ2GcfSRbBgDtRzKIhFZyUqPKn96HMbQPx/D8Xe6QF7zRg5Dt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197205; c=relaxed/simple;
	bh=4w5PjtM7z0hPiojpj6RmXoYAtfKWcMPkMO5IK0b5u5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pce+6gkhYPJqe7RvoKtXtYiFA35rWpjq+glRW5Hrx/XepJ2HMzhynDDWJgFwbu5+SmAyBPdAFCAmY0NBr2Rb7pB+nrAZr/wo1tpKIHucmCA7CiXmiEF0SWv7crJavmtuKAHvsw6MxPTGoBaG+Q08+m3fORBI5w6uCABEAn+KL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POXkcbPf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445826fd9dso14089425ad.3;
        Thu, 14 Aug 2025 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197203; x=1755802003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJqXIbReyoOC0CT2Vg/59HwofrZjheLlv4j8hyJUaTk=;
        b=POXkcbPfJZ0JQGSFikqCw5NI8eMucIquYPsP6RaSrjroKZtJAjqKOz1KrTKvg8OltY
         1oa8wIMrQqqEPsrfOKD+66swQe7/lSFs5UVB6iThyI1VKCKH9G2whnuz/bqTo/pSgx9u
         MBaAmVJFPTClT678baxPzagiiyBZBn2vnmX/e5CIbDtjtBIbg79vm9uv7zQZCPzEeHJJ
         5k8RaT5ta0JnXI9iW7Sm4M/JwvkEIKwPNDlJUkU6+dfkqXYYWEAV+kL4fYrEFGQFiSrt
         XT2AUzDDdZGcl/soiMOWm6JIgVYM16v3tjzBavhjf22ai5CAth0vfXcdUR/guIsQbw6W
         o7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197203; x=1755802003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJqXIbReyoOC0CT2Vg/59HwofrZjheLlv4j8hyJUaTk=;
        b=RKoOuAytaTj3Eb95owks1XcLjAregkI59SgU1FafjLZJJgr9SXzgywY+DGJS87xwv2
         2FLvny2RFcjBlr4MzkulY/Qu+blQPdv+wVVqjmcMZH9NK8YNNbyeC74SZTvsxpj35YfW
         xB+QF4CKwezYhWp9hCuqhJqwaT4SgQcMRAEQDxgULiuIQJlze5fYxCGjgGtJIqSCyJ3/
         IWuamUOQJIw3DbXGFQzHzC6iC5wuhQqWPB5iU/R/5e7G80fLAQsvRL1wJJS6atFrf5uo
         jFO1dIAqSsLonrH5CUADnRhQDKigRfDTQBka6ZYZS9mtA6fZ+NHRdKrRTm+yzs6R2qGj
         LIFw==
X-Forwarded-Encrypted: i=1; AJvYcCXjs2qPb3l0FzrV0Hk0TpUAShQTvrBogJgQFur3LnbUhmorUWFcHGalN4IX9czaTDM4pk2+Qgbi7x7GvzYVj1MgNAdSMbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySOrtdb9jxU84rxr6HJfqOHoGLQy2U1dHcc/0V2xKKud0QG3w2
	I7cnhuuW+mfcg5wnDlXOb+7ohiZ94A8XsKZyMYPqGybaYPZzEPJ0j+i+Y6ndKcdI3ydF5EWfnd8
	5Z+S5UFrvk2WT57w63ouz1FqMkNEuyQQZ9g==
X-Gm-Gg: ASbGncunqAgkJpHWTB5TMf/Q5zdkBQ7SeBmcFmtPlPQuDW/zITtWSsM5pmhOYt2cr+G
	2qNKfMo8+272iusXHIDO6+wWacGZTNEpmyZXcfi5PbYZ+4WNih6+B/DKH8ylHE61BdjtgYlCx/J
	J3BCzZPnGBg1qVV2kODDklpCTT5eMukPv+tdPgRVIS1CWeIFekJB0DHezcXtSpocX8Oklo8i+aQ
	3HiwFeqpikikdbkrGTeeezcSg==
X-Google-Smtp-Source: AGHT+IF4evQW1V+BK3k/FVikyBI39rbySVtRw802/uz0jrsCUPSqisvfV/mWVn4Cem1XK1Q5k+5EUjeJnZUH2g9/FpI=
X-Received: by 2002:a17:903:b0e:b0:23f:f3e1:7363 with SMTP id
 d9443c01a7336-2445853fef5mr48990695ad.23.1755197203126; Thu, 14 Aug 2025
 11:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-7-kpsingh@kernel.org>
In-Reply-To: <20250813205526.2992911-7-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Aug 2025 11:46:29 -0700
X-Gm-Features: Ac12FXxi8VEZQm_Q9hAaLu1KA7PHIkW_Tmn6dmmwfGhfIP8BGtymDaz6IFmEm4Q
Message-ID: <CAEf4BzaXA9R4_tJtA6jsVc3im9LJWhzRGQoVyGjFnH89ohZbcw@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> Currently only array maps are supported, but the implementation can be
> extended for other maps and objects. The hash is memoized only for
> exclusive and frozen maps as their content is stable until the exclusive
> program modifies the map.
>
> This is required  for BPF signing, enabling a trusted loader program to
> verify a map's integrity. The loader retrieves
> the map's runtime hash from the kernel and compares it against an
> expected hash computed at build time.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h                           |  3 +++
>  include/uapi/linux/bpf.h                      |  2 ++
>  kernel/bpf/arraymap.c                         | 13 +++++++++++
>  kernel/bpf/syscall.c                          | 23 +++++++++++++++++++
>  tools/include/uapi/linux/bpf.h                |  2 ++
>  .../selftests/bpf/progs/verifier_map_ptr.c    |  7 ++++--
>  6 files changed, 48 insertions(+), 2 deletions(-)
>

[...]

>  struct bpf_btf_info {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools=
/testing/selftests/bpf/progs/verifier_map_ptr.c
> index 11a079145966..e2767d27d8aa 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> @@ -70,10 +70,13 @@ __naked void bpf_map_ptr_write_rejected(void)
>         : __clobber_all);
>  }
>
> +/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, acc=
essing
> + * into this array is valid. The opts field is now at offset 33.
> + */

Does hash have to be at the beginning of struct bpf_map? why not just
put it at the end and not have to adjust any tests?.. (which now will
fail on older kernel for no good reason, unless I miss something)


>  SEC("socket")
>  __description("bpf_map_ptr: read non-existent field rejected")
>  __failure
> -__msg("cannot access ptr member ops with moff 0 in struct bpf_map with o=
ff 1 size 4")
> +__msg("cannot access ptr member ops with moff 32 in struct bpf_map with =
off 33 size 4")
>  __failure_unpriv
>  __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
>  __flag(BPF_F_ANY_ALIGNMENT)
> @@ -82,7 +85,7 @@ __naked void read_non_existent_field_rejected(void)
>         asm volatile ("                                 \
>         r6 =3D 0;                                         \
>         r1 =3D %[map_array_48b] ll;                       \
> -       r6 =3D *(u32*)(r1 + 1);                           \
> +       r6 =3D *(u32*)(r1 + 33);                          \
>         r0 =3D 1;                                         \
>         exit;                                           \
>  "      :
> --
> 2.43.0
>

