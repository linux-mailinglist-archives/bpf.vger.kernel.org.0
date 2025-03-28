Return-Path: <bpf+bounces-54870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C2A75040
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 19:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB91B188AD21
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ED21E102E;
	Fri, 28 Mar 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnPyRRye"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A41E0E0A;
	Fri, 28 Mar 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185709; cv=none; b=duIV+zivCTAx8jYSPvu//Mkt4qb2uozHtKGJoXb9vO3eL2u9dV2qlaQpSmxmymLNDLIRU2TD7JmCrxVdPmQ5WTjn7gxMe+Ya53scqyiFrjjqhFlRLwMplLQ0C4Occa3J6ztBATL57J5YfHAh8FpQK1sjIFyoyRoBkfAmbV3Op70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185709; c=relaxed/simple;
	bh=1WYiVC9lV01fMmGdapZKojKijVkt+J+BAamM/QLu8+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sa/dujznL6QsEOc23HX/3PR3Tmd49c2tPUFRAV0obGEDO2WV8JMIZm2UKYZYhiOFhD7/G92C9uQwcsFt5zk66NBHPCnVztyEnPLGSLDg2ig5VI9r/9rbsYH47WixOfevCfVzypNCD5uiC/3duKk89G1KvY+pyYBJ+WHjCyYlOEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnPyRRye; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso54978495ad.2;
        Fri, 28 Mar 2025 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743185706; x=1743790506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtZna3j+CxXjkNh4wGSlYeGcWJMOvvSqD8UdEcRuHkA=;
        b=PnPyRRyec5/KHcMuw5SJjzEh/nrVmcj/66wA5DKHzk0WI9uqjJm9Aj6tQDChD04xyL
         5Jj2l4AjS/kFgSdAARSvVeJ19jmY8XLXUV3PsiH9d7pCYXW+UGrOvLhF5GZYc4ca2Kfz
         bfwlom5o8cKhDskQQrj/T4i5Fq9c4ZjhIw0Z2VBXwH/xn/ukGpZL24AhJs1xObtiOats
         i8oaa9iT/8m3P2kJdr7H9HshMACjuXezQ7aSJ8OgbLrtE63Y633B0m3cmnn015WzvKPH
         8ya8LMX9Cc5hIyo6QTZr7Nw3J108DgdoW4KfIyFJ1MmPx/IHNGuTPSjNGvry8nBcRpoK
         yADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743185706; x=1743790506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtZna3j+CxXjkNh4wGSlYeGcWJMOvvSqD8UdEcRuHkA=;
        b=ABN9o5IPTL4aXOClAATOZ19tO2pgAm6HCRPfaLVOXmOa8VMFKLpi9texkAuBmPyodT
         GUdEBn9RTjoEHmCuBKbaSEVMz/ye3IcegisKVcNGkt2fkLWhCwAEaji3qyxI+jt6fo+8
         +0gJdzHbexrZyJyESjoTt2T75qWlfc8vgUd2JObgeeYdbYGvk4AdYzrc4rW6Zk94tz9O
         bhGTEwa6HNY4qJ4rCaWhK671kZi1tsVl1aMBpz+86H4eFK7LzLUDx6fhpbTb1EBUrLpc
         qLqq5G4Tl7jPjYKxDWtW6dGmBi7I8keDcFZKQFrM+xpkxnscDDMCx/75mP8/Ai3/sgB+
         mYGw==
X-Forwarded-Encrypted: i=1; AJvYcCVGgjLPEakiIGTB7lx4qgCIvL3roDQuKLUzCcfm0UreNPZRWP4E84ejaQ+swaR8cUD5BQPnjV3ZxX1XpaIx@vger.kernel.org, AJvYcCWgd57DnSas1luqPL0UC26R1J0os1OqwSotlcsaCVCcTYgZMGoYVyy/BhblSUaUzDX8/Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/buDj9H5BYzCEJNk+UD1EwyGuvYq2wa3SADPpxJI6c6Swv4c
	K3vQIJsuh3IPCBxYbBo1XrZM8t/UV6O7LCVPYjqrK+Q2q/zdA8TPrWBPCX7BpMaWu+Zy9vEgLZx
	FYaRm9jQ+UMT8fTmeWv4bVP8+X8w=
X-Gm-Gg: ASbGncuS96fFngqJIc5TITD/K7KAEFOevMszfc9MUpaweAIq1qUlNcnhRvBW0dvkoZr
	Mt3muyBcJ6gVW9Vtk8TU9ExE8I2obH6tN92pqcQtMTUshRlhxEX7OYw22gvJB2s1I6k0YbupIar
	/ThLTou7ZyFlHQSXFb/uJqdGY/Pqgw+nBYny2q5apBUg==
X-Google-Smtp-Source: AGHT+IG81uHsTF1SmbTmqfeZfF2y8cAKyyTuAwJ00cXTfliqE094GzCzpT3QEUiEyyq8LL1/096MKesgfew1kCQEDm4=
X-Received: by 2002:a05:6a21:9188:b0:1f5:591b:4f73 with SMTP id
 adf61e73a8af0-2009f7537ddmr511099637.34.1743185706054; Fri, 28 Mar 2025
 11:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327100733.27881-1-bieganski.gm@gmail.com>
In-Reply-To: <20250327100733.27881-1-bieganski.gm@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 11:14:54 -0700
X-Gm-Features: AQ5f1JrxQO7vNdRNIPLHPjjjCjV7pZecdsfPt9dmHqa6XA3pw7LkEL7us8LNGAw
Message-ID: <CAEf4BzbGbfhdanY0yZtRoRTZaiMG4ML1PYUz1m4QbG-Kw2tNtA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix multi-uprobe attach not working with dynamic symbols
To: Mateusz Bieganski <bieganski.gm@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 3:08=E2=80=AFAM Mateusz Bieganski
<bieganski.gm@gmail.com> wrote:
>
> ENOENT is incorrectly propagated to caller, if requested symbol is
> present in dynamic linker symbol table and not present in symbol table.
>
> Signed-off-by: Mateusz Bieganski <bieganski.gm@gmail.com>
> ---
>  tools/lib/bpf/elf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 823f83ad819c..41839ef5bc97 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -439,8 +439,10 @@ int elf_resolve_syms_offsets(const char *binary_path=
, int cnt,
>                 struct elf_sym *sym;
>
>                 err =3D elf_sym_iter_new(&iter, elf_fd.elf, binary_path, =
sh_types[i], st_type);
> -               if (err =3D=3D -ENOENT)
> +               if (err =3D=3D -ENOENT) {
> +                       err =3D 0;
>                         continue;
> +               }

Don't we have the same problem in elf_resolve_pattern_offsets() as
well? Can you please fix both issues in one go?

It seems it's only elf_find_func_offset() that do want to preserve
that -ENOENT, all others are just error-prone implementations.

pw-bot: cr

>                 if (err)
>                         goto out;
>
> --
> 2.39.5
>

