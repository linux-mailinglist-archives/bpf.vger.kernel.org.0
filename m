Return-Path: <bpf+bounces-38219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE267961A55
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 01:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09CD1C22F56
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 23:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756D01D45E8;
	Tue, 27 Aug 2024 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSkPhQL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304B1D4153
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800436; cv=none; b=ShxlbCfCxLP9WnkWpXm89UU4sLRpGElwZZ+9xIDd5fz2HE9+JIhg9WzKWDgbdpclEWvMLlk8alCFqDDw/nupiC1TkiWty5cxwETj/7dLFrjlirqki0N08GHs529/dDYwG2l++ymC/EG0W0+XReQhYpjHAmUpbW6PObua/Juqs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800436; c=relaxed/simple;
	bh=ZGe+uY39/YyPvUI2AfHFrlFZOybpX7ed1R0RALqbH8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3Vp5k7uxIlDOZX4Z6p36WRLouG4EFEmLlDS6XQB43Y+7nmJfue47ocfDANnyMMDPm7w9fjn1eNEUVk64bjJXtl6+VhD4a1UE3J4Es9JXH1ky6peH9EXF2LeELLYhwCXR+gdi9Xu+JgCTgWJ2y8nIMqHZ4j2jnLBcGQQ92gvaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSkPhQL8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3b36f5366so4329760a91.0
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724800434; x=1725405234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxfvSlii8fIRiYjOf7HibWgbFjs3hwFQJSztAlcy/+4=;
        b=MSkPhQL8tRpaV5sj1ucGPO5RlMCQbyQKWITuW8p7EEBI+kkOizoPDw72ir5DnBkfe5
         uO38Gol2GOx5YEVDLwW8rmTPOC8NQu/dRqR8fNYoXevvm6ueytV0p7o5zDBHF4Ituooh
         21pvd8Qq0t03EMpuvZaDF+Tdognh3U2/WFqIsube6Ail4q0IndvmJxsp+XSRKEbb/WdI
         8oUTd5yqNtZBuiTmqyueRRaSFvBqRLw9hbJ4LykTGZUIa7mO3d9d7gkh2YYEf+uJwcRO
         DYp7JivBZeRP3pNt3JJwpcup//QemgJTbNuzscUI3NYWSlkqXs8JQ6QlVtxCO0K7a7R8
         1Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800434; x=1725405234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxfvSlii8fIRiYjOf7HibWgbFjs3hwFQJSztAlcy/+4=;
        b=i7/MJHq7wLTu3p1PnHUWNIMIRJkNlw0kgH0rDkuKPXYFaiVZ+ir7gMoTs7ohzfnn+p
         a6Xm7kgduHiQJgirZTlJ3UJS+qgMVxVxwTVSWogisIEf199+yc2PDJBbuL5vt6FML607
         1OpCfSfHWDA6pXW6JZMi6brAN3gkl7553w6RffDEvWLyC2hc8KkEzppFlDDHfEgmpBQW
         ga/8NF+9XtGBt4gcfZHn/ERu03dsnBSf6tPrekz0dILwQqxrxoy5/NRMqssQLn/rX2jU
         Gjla11jX67qlnGLfQf2eDlvFeen0C0SCxatNLYeS6baj4g3AtqH7uJe5wi19TAUksVYS
         3ayg==
X-Gm-Message-State: AOJu0YwnOJI6gAcfykS3qG04m/ohCClzuSgD5oPKbjccBfMvhXDrDP5u
	7uQUc02P3/YtXUjc4EjGZt7jEaLiIhPcTVW71uDz3TN7HYBZG2rhQmj6HH+/Q4fa94WHqhYKM7o
	RNI7naItvIlZtX3b615ZBjZMdFJ8=
X-Google-Smtp-Source: AGHT+IHzPRU83rOX0sGo1xztpOUAZYMW1FdQdBim+Z9R3xXKQoWUwd+7zFdRszWZ/czb2kOq0XXpEopvV0fLQzcf7Jw=
X-Received: by 2002:a17:90a:bc95:b0:2d3:b8d6:d041 with SMTP id
 98e67ed59e1d1-2d8441a2469mr282900a91.32.1724800433951; Tue, 27 Aug 2024
 16:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816191213.35573-1-thinker.li@gmail.com> <20240816191213.35573-6-thinker.li@gmail.com>
In-Reply-To: <20240816191213.35573-6-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 16:13:42 -0700
Message-ID: <CAEf4BzaDTaF9tQYjY1MSMjs2PwYM_K1XPyPOEPgFwHY-8+tcJg@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 5/6] libbpf: define __uptr.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, 
	andrii@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:12=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com=
> wrote:
>
> Make __uptr available to BPF programs to enable them to define uptrs.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/lib/bpf/bpf_helpers.h | 1 +
>  1 file changed, 1 insertion(+)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 305c62817dd3..7ff9d947b976 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -185,6 +185,7 @@ enum libbpf_tristate {
>  #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
>  #define __kptr __attribute__((btf_type_tag("kptr")))
>  #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
> +#define __uptr __attribute__((btf_type_tag("uptr")))
>
>  #if defined (__clang__)
>  #define bpf_ksym_exists(sym) ({                                         =
       \
> --
> 2.34.1
>

