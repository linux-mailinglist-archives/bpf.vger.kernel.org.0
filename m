Return-Path: <bpf+bounces-70664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90ABC99AA
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE34FBFD1
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2052EB84F;
	Thu,  9 Oct 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/skoLTt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66042EB5DC
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021173; cv=none; b=MUYdaaOF+LAz5hEKx7feq9HOPx6LDt5wVTDlNhnDwsNN44T5Caxo0VZRXKGxQdcTR0buV6rSFvxVTfqJdXzu15K1F5Kp7Joh5+TYqs/3NcbDXtV269Ma2IjFkdi1mjFcEGiCqfoZs4Sqa9BZsmoGN7LOZJJqK7ZMoXJHTyM9HxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021173; c=relaxed/simple;
	bh=1YF/kfrhlYkqcLi1GXYGGuwKlO6FjjUxn/YQCxguAYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu0lmnPYPMtoN3+PgBhJ91gf7O4vPFDZX4J1tGp2lVgskdrXDJEzy8zpmXgpKMUoOw8AtORS+y2KJCPBS5RBtkpxPi1rsyycciiaDN1fN6On6Bm84727OfIZJ78IZZj03QhxJHskvh/nJ6FvzOEWoxqanL9l/VRIe5pu2aezPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/skoLTt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4257aafab98so953145f8f.3
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760021170; x=1760625970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YF/kfrhlYkqcLi1GXYGGuwKlO6FjjUxn/YQCxguAYc=;
        b=l/skoLTtsSA/UucDQVOiNHWgsEYQRCcS8ZWkc1mASOSqv71aYtwFAo6ksTccoWzYug
         amOJ1P/8mPT4NyxzR+gFcl8iqWBPsb6zDsNDOB+nKSoSLuu46i/FKa+M3Hx8eSc1AT+4
         ilRN2Zl4DapRlxp8w9Sp0fRsuf7gnEddd893M38CXJs4Jv4QzOP+5vG1ELbSepxF30nM
         7jmTEnGX7MwTA/03p/IRive3bLnAKvwF++uv9k/p9b1yK3Bk0S2OT39SzpMywoq956G/
         TfN4GFfC/3AWg3AU3QSdrl/XCYKSog+STmZWpEajdH5E7lFh+FwgfjoAd8yW499Xifjb
         LZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021170; x=1760625970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YF/kfrhlYkqcLi1GXYGGuwKlO6FjjUxn/YQCxguAYc=;
        b=cck+ocW+JV7ZmD0rhfCB1ZKVZa/UMAVv61JPaqOgtQfX6/fQWEVhuR5A7ws1jLfvnL
         9L5hPIK7yqs/GBk3mdIyJcjadvPZv3kCzyyugXI/zGYOgpdmKr/XCv9TJJaR+T08YM1u
         RtkVHhbGX+pZ4lt8n4OB4YTjXwy3j0/Qz/5HPysZJxGZTgi5MbuW6E0SbRTG5oxRqVF3
         BPXfyox6Gw7aXeX8uhPg1S7bAOu1vz4+wi7SI2GQ79rFzaPUBEB+7K3+HmbK4cWw/7Wr
         GsWvtk3jKDNYNaGLgwDjhd8DxH2SOwK618xaRii14lckzah4nVTBsh0bSSoXFkyaYETe
         4rjg==
X-Forwarded-Encrypted: i=1; AJvYcCVOJv/X8vliBfN6GgYdbk5WtkZKQx1o7SvGaYv+DmRoMEKxtrRf9v/9xdgLoQCp15fO5B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mfKZupn+NFUjvkTKqK4qrqqHcwZeF3ZIMcukHaOW8P9p+vy3
	obh6lWSetCA6QHPyVfWz8aO3f3zHrcYl09Xql9nbukKq+5gdjKbUCCrtVKSSG4B9i8+EXHwH66P
	GLYDqEnsMMhkh26YtWLSUMANfcBIbU3A=
X-Gm-Gg: ASbGncvTb0jzuzoAJJmsLQTPKZdlQjjsQiV7nKuxmrhlgPKJ7OWTw+Mb/AtiaZTJXv9
	aEQwqttQByckAjegPxDlNnMCwJOm46MNVoJjgtrwpReGB8x9IhdHGAl5Fl5F806wFZJDQhlFkLl
	nVa3NfU7sIri1bPuf25+zlsoY7MMWO4reSrIocei9+JkqEjbThgMGZgQNrXQDUcmzPLy/2tX+N1
	0oGq/AWENyTuaGDfh7gxCE45nRXHHMWrAurZV0imzDkSeUxYKrhjOiX6W3ESQoDJu+OqR6QMVU=
X-Google-Smtp-Source: AGHT+IECWjhaZNmV1ojdHkxqbAFOmHEINNvUEgcQdI2hfmscAMsefgN2+U5CxgJIIoAua19jxGu56fLuuqU2fY9/gjg=
X-Received: by 2002:a05:6000:26cc:b0:425:7590:6a1f with SMTP id
 ffacd0b85a97d-4266e8d9301mr5195008f8f.49.1760021169790; Thu, 09 Oct 2025
 07:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev> <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com> <405caf71-315d-46a4-af35-c1fd53470b91@gmail.com>
In-Reply-To: <405caf71-315d-46a4-af35-c1fd53470b91@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 07:45:58 -0700
X-Gm-Features: AS18NWBEI8kqkZPKzG96GE2ZCLB20iemRBfaDjOtbeNUARLINqO3dUs7B56pY3o
Message-ID: <CAADnVQK8Rw19Z6ib0CfK0cMHUsYBuhEv8_464knZ4qFZ6Gfv2g@mail.gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:15=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
> The verifier can rewrite 'bpf_reg_aux()' into the following instructions:
>
> dst_reg =3D BPF_REG_AUX;
> BPF_REG_AUX =3D 0; /* clear BPF_REG_AUX */
>
> As for the architecture-specific implementation, BPF_REG_AUX can be
> mapped to an appropriate register per arch =E2=80=94 for example, r11 on =
x86_64.

it's taken. There are no free registers.

