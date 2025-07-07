Return-Path: <bpf+bounces-62540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887D0AFB9A2
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E431AA8304
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78F62E8DE5;
	Mon,  7 Jul 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN2pHR61"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA82E88B0;
	Mon,  7 Jul 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907930; cv=none; b=GQMb3llHxo3Wle46ttmzLj57P9qS4l0s0SyXUBu/ympEMNRAy5Z4CBuMGbpsqRlDHYRGw/HHRKJRNKVblbbEPZ75CJM3v/FclZALlDQ05eowVXV5yZ6Om1Nxl4pa5DeKuHFRndiW1eq3dqs9e6ACcBhMdHjyQoDwZshuHvGzvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907930; c=relaxed/simple;
	bh=cGcng1B5uYbpvwTXbTYW+kCGrhRXMUcNW6KCHqQ9f38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb0BpnhRtEiUbOjEpweL0j9nQ0s+LxGmfSiAyakzj4P1R4SilD0dUdm2SerjD5qBl7Dl1jA6TII79XZMh0Hs6WcqOvCNyrjghx5xUwTMEr/zwlLiVxh1GrcDEfcpuraCBs9e/N9OhbcGAklBZ8LsGN4d1UqjfrQetKyrVBU3oHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN2pHR61; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so2108915f8f.0;
        Mon, 07 Jul 2025 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751907927; x=1752512727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFj0ww0Wgt6avL1qowBSB8Jckrv7U2t3qC7ziVbRCB8=;
        b=NN2pHR61K9OH1oCtUyPCbtrCbaNMi/Hn9W1DayU0nq9JOljHP4khqEMb5wX/xiEv61
         qsLEGDs5ssbr0WoztYdvlRn8wW327sVf+z5dcaPU0aEX54moLMc+O9rsbcVK3e1qDsOs
         lR3ub2ztyCzvXPTNzEAWEu5yL+RW6bJElSh+9NvoNoqGjowfUm989JOr08nqGC+zBxrr
         Ibh78sBAQ6T6AJRQnS2s7L2XCz9TwAHn5aADrUyx5Nl48apT/2U3Gb+G3e1GPodrb6rK
         KyC4qz2J5xl5iRSzbK4Smb+DM7r8pZqHTDK/bSrNfEjvEoEDYc/UKRuACPiGDuUmnNLW
         lZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751907927; x=1752512727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFj0ww0Wgt6avL1qowBSB8Jckrv7U2t3qC7ziVbRCB8=;
        b=omG00ZBS4I1Zgp4uIjrdDtpC3QhYXmnPLCO8pcG19x67MSIGNZtzLU1EBj4Kp3sMmD
         MfcVWQ+v9OinJ2Mu1EZxHUdRgbSxAlz5zjzbshPh/wS0gOEbmdE71FJCEEe8NyFYNlZf
         RsJg45r9IE9hWoMYkg4Ti15vrP3nzEdd2HkwzK/Pelcb8NazUasOpmHy3/QXfGt2l2Q3
         v6pJSk9DcC5KC5RHoZcQ5S0fORk4Rx8TCWBFLw6/ZhsvObcbkYlKe9u9jk91OGjEaaYG
         O4GtFf+lbbC8ynxjeqWS55X6+eLOZrHrRhsHW1pwcjapE4STkCUS+qYYtV8lwtZY8U+U
         QbkA==
X-Forwarded-Encrypted: i=1; AJvYcCXCm7SKdFsq6ilnts+qqgWswoXUNJbnntcB69OQGqgnuRCzanLMAKq6QFccfTZ+SCSvbps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqTxvGQyWQ6kmEqqBawqbOlrOCZP7C1vTCPmzYiBq+1qREfJi
	IE6Ew2yQyGsuQ0T3oSVJZM2a4YuVgpwvLz6Y+ccNqn9ZW8CVCoNss5nXWJmNKtAJYe8eb+5KZaQ
	b1461MbY7+iBD3g0xUfX5jSR3VmjBdYE=
X-Gm-Gg: ASbGncsGyUPmIXxGzl30uY1UumaNFlgCB0eaK0LGcWkX6YUd3x0YDrwpmlTjEhDvF6V
	XgEr5Y4AGa05LI18WwY6TKT+e8WrxP41VOTA3C1fOxNZAT9O0XFrvNi+pMimCX+sX0UJEMnmi77
	UDJv5R1XtC2G4Ysu3wW5FNaARC4hVJSoi5bdcH5BnqV+/UA5ODPSI73tmwMDk=
X-Google-Smtp-Source: AGHT+IHz2yoSbu5F1c7gf7YVIBdBJrvR6ihySIA4UhhduXBs4OCAVk9N2ZHYJPwx5NEqpAUUa+vHtUo14dczfcnEros=
X-Received: by 2002:a05:6000:18a5:b0:3a5:2182:bce2 with SMTP id
 ffacd0b85a97d-3b4964c0a9fmr12354928f8f.17.1751907926458; Mon, 07 Jul 2025
 10:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com> <20250707-btf_skip_structs_on_stack-v3-1-29569e086c12@bootlin.com>
In-Reply-To: <20250707-btf_skip_structs_on_stack-v3-1-29569e086c12@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 10:05:12 -0700
X-Gm-Features: Ac12FXyO37GQhp3x3YjuWJgNAw6X7RtoaXNm7Hlox3eYREQtBT6gF427Cz_F1BU
Message-ID: <CAADnVQJUYNBJVOA532Zkwa1ggVdvv4nay5jU7GEtt6gNjNG0uw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btf_encoder: skip functions consuming packed
 structs passed by value on stack
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexei Starovoitov <ast@fb.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 7:02=E2=80=AFAM Alexis Lothor=C3=A9 (eBPF Foundation=
)
<alexis.lothore@bootlin.com> wrote:
>
> Most ABIs allow functions to receive structs passed by value, if they
> fit in a register or a pair of registers, depending on the exact ABI.
> However, when there is a struct passed by value but all registers are
> already used for parameters passing, the struct is still passed by value
> but on the stack. This becomes an issue if the passed struct is defined
> with some attributes like __attribute__((packed)) or
> __attribute__((aligned(X)), as its location on the stack is altered, but
> this change is not reflected in dwarf information. The corresponding BTF
> data generated from this can lead to incorrect BPF trampolines
> generation (eg to attach bpf tracing programs to kernel functions) in
> the Linux kernel.
>
> Prevent those wrong cases by not encoding functions consuming structs
> passed by value on stack, when those structs do not have the expected
> alignment due to some attribute usage.
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>

...

> +static bool ftype__has_uncertain_arg_loc(struct cu *cu, struct ftype *ft=
ype)
> +{
> +       struct parameter *param;
> +       int param_idx =3D 0;
> +
> +       if (ftype->nr_parms < cu->nr_register_params)
> +               return false;
> +
> +       ftype__for_each_parameter(ftype, param) {
> +               if (param_idx++ < cu->nr_register_params)
> +                       continue;
> +
> +               struct tag *type =3D cu__type(cu, param->tag.type);
> +
> +               if (type =3D=3D NULL || !tag__is_struct(type))
> +                       continue;
> +
> +               struct type *ctype =3D tag__type(type);
> +               if (ctype->namespace.name =3D=3D 0)
> +                       continue;
> +
> +               struct class *class =3D tag__class(type);
> +
> +               class__infer_packed_attributes(class, cu);
> +
> +               if (class->is_packed)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +

The logic looks good to me.

