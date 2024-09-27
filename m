Return-Path: <bpf+bounces-40443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170C988C0A
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 23:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7302839CA
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16F818B470;
	Fri, 27 Sep 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzncUpP9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25CA14BF8B;
	Fri, 27 Sep 2024 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727473958; cv=none; b=mdEkXYv/NQVmAaU6Rbo1QHxp/Spn4j6pCAB3Kf41tdcTsZD09Ym/ptJZ0e+IC19xsGGB3/AQzJsfXoVnidGPDCb9t1it0ljGFIwA3H1McrvG1jdHXam9hQJixs040mhrX10uuBdv6EyOjYb36ie8fGmvqc/uCqIdLxu/TgRwVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727473958; c=relaxed/simple;
	bh=KgNkij5ARbIS8TSicp5/QE/xvWbM3MIuVXdtO5tuAsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ner8AKeMlD3pWl+yvYfgYlED4Yh3MsYmIMgLDYGeIlJvklQQ4NRJtnp8qtnU0RpfG2H2c3WHIEphpgBJA1NamZGd6ot2j2QrgwE6XVxSp4BDQAeKY6CKeA1dGQr9WXvLJnSoCp0D9DS9FRcjPzMQI9Hat1A+/TG0ovCkCIT0s4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzncUpP9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206bd1c6ccdso25352725ad.3;
        Fri, 27 Sep 2024 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727473956; x=1728078756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wt5HI5c1/abCfhsYESVTQWnehbXIiI7JPMSwXe+tPLU=;
        b=TzncUpP9/j604iWDzyFeSZA+SjiFuNhaHfWEwadqXSc9rQqgwqZjAE4H8tXxLuiwYX
         c/RwvDPJf1sf2RNqkqNRghuso5kPIO4DohCMis1Ebdk6Qfjx1QVSTAp6xUWyQrt7OfJK
         Brr/BEGlHvirZwjcSfpsBu9Tba0qpbUL6dZxdUiq4r3AQK1L8eHr35WeTiS1328/2Jav
         e3RmtsJbntcZ1xlrpQUlUk3+NBu+lnvqyRkT1zw0NUQAEnPe6Lv+MmmXIKEXwsrzMIi6
         hvzKIxdh9S+aQOgNJFOGeQNUZp4g7h914uCayb6+fkIG8OW8Of39FmwT0YWzjZhGl7Vh
         1lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727473956; x=1728078756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt5HI5c1/abCfhsYESVTQWnehbXIiI7JPMSwXe+tPLU=;
        b=mU5KAytDBh+hU8Jq8Xwa+qjuS1kY1Z2nVd9hiAwTSAWLzb5aPxdGO6acq1HUVc+1y7
         nZgSM0gINeL/h8ahWF/L9kHdIkUHPfWjNOmMedZNeCyzJX0AuI3ilXOrfwso8ckZj4g2
         wwLevqF1acxbUXsSbGssrbAjLZ/dgP3NLqF3D85BHkGgMfPGtcX9g6s6TrWzEDFVZA6E
         jeRN0jeKITbtYKyam65oGPaI0gjaC09WbvgqJNLUYYQmtkOoe8+QjNbjblG6xuih9r5K
         UpA2ahcf8W4rkBS7xE/fXwGCZMhEZOBElsby3tnlId6YMO2Ka6H45Z6N6Gx3cjQCOh6X
         0zZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVblf197pN8zaCaIONtdmYTwgBm5lRL8BYnxjkHQ3r8p0s9dKfNBd6okAoM+M3mM1vi37M=@vger.kernel.org
X-Gm-Message-State: AOJu0YweN0DxNdzNVDxtKM8JKjH7xU30gWDyHP+GrQ7dEITXgs5EuvKK
	vZ5VU+ftDfPvBfigtB75GPznsRyO8P5lsGyemETUN734k/FLPkbM/gIp5hQuwIQEKUtT9uI0MoL
	CYgZyZlSc7+D4tbYRvncER9LxSk0=
X-Google-Smtp-Source: AGHT+IEGB26D0EiMCRLY/fsm2tCjL7SvuHTeefrLnB5vZcJdE9GKA+Vm6tlX5baLsevU0nURHRj6JjkHBRBFe13cVqo=
X-Received: by 2002:a17:90b:83:b0:2cf:eaec:d74c with SMTP id
 98e67ed59e1d1-2e0b8a1b905mr5288738a91.16.1727473956392; Fri, 27 Sep 2024
 14:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916091921.2929615-1-eddyz87@gmail.com>
In-Reply-To: <20240916091921.2929615-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 14:52:24 -0700
Message-ID: <CAEf4BzY5qmrRjNHESAjNm9DnMdfqmaHWYFXZZUC=L0pLJMLuwA@mail.gmail.com>
Subject: Re: [PATCH dwarves v1] pahole: generate "bpf_fastcall" decl tags for
 eligible kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 2:19=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> For kfuncs marked with KF_FASTCALL flag generate the following pair of
> decl tags:
>
>     $ bpftool btf dump file vmlinux
>     ...
>     [A] FUNC 'bpf_rdonly_cast' type_id=3D...
>     ...
>     [B] DECL_TAG 'bpf_kfunc' type_id=3DA component_idx=3D-1
>     [C] DECL_TAG 'bpf_fastcall' type_id=3DA component_idx=3D-1
>
> So that bpftool could find 'bpf_fastcall' decl tag and generate
> appropriate C declarations for such kfuncs, e.g.:
>
>     #ifndef __VMLINUX_H__
>     #define __VMLINUX_H__
>     ...
>     #define __bpf_fastcall __attribute__((bpf_fastcall))
>     ...
>     __bpf_fastcall extern void *bpf_rdonly_cast(...) ...;
>
> For additional information about 'bpf_fastcall' attribute,
> see the following commit in the LLVM source tree:
>
> 64e464349bfc ("[BPF] introduce __attribute__((bpf_fastcall))")
>
> And the following Linux kernel commit:
>
> 52839f31cece ("Merge branch 'no_caller_saved_registers-attribute-for-help=
er-calls'")
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  btf_encoder.c | 59 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 16 deletions(-)
>

LGTM,

Acked-by: Andrii Nakryiko <andrii@kernel.org>

Arnaldo, can you please take a look and if everything seems sane apply
it to pahole master, so it's easier to use it locally? Thanks!

[...]

