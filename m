Return-Path: <bpf+bounces-39870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7076D978B5F
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 00:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F711F23A4A
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 22:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D991714C6;
	Fri, 13 Sep 2024 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCuznCCg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A74A21;
	Fri, 13 Sep 2024 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266378; cv=none; b=rVMUvCNq87b8utT3q+T9Yg277JXYp6asLtyendewcxJmiThH+GUfGKF43maK/ufWKlXezey/SDmOGPYVP7wFrBG7beNGytRVYcEIk3c+12i9Y8sPGLTcgo4ehP6JWxwft9MiE+y4fiEK+9CWpb7uxscS91s+uQlOq4BozQlk3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266378; c=relaxed/simple;
	bh=9cJQyS5tckhCBfLGqyRval8t4KISO8g7HDnpONuphig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r22vN5Ee/P8jT58nQ5fqyxunIKVWyY4AdLSdR15rTolN3ZMJOP29JzWf18TmRbMMXsyz+aWkKdc3XTRFek+HW9ozwS6KpYldTsSJMeEWpHBDHPkc63LQ7pIYJsGdXgEUTuDhGz5CLpUPsg37NP9amnXWR+Gal+BI7QBU+9Sp4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCuznCCg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso2220042a91.0;
        Fri, 13 Sep 2024 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726266376; x=1726871176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=577wDrVMlYw6/7vSWbBSE5NWOXmotjfe7aI48K4g2gs=;
        b=BCuznCCgRG6N+RfoukMKKSuxRPnr9VBTuWUTOEk6Xlt7ifUsnSczuStl+hZYU7InBm
         bB1zWDxLHVPJuXvDw2pOJOwhcRBRMthsgMwmW8FcqIYrt6p3YGS1EOLaUao1zBfERLi6
         OtdpV5js/fs4QIoY5nJHKsv8Cpq7H7cdkhcJuJ/7Pjz3NuC6B315qYn8WfvqM0QrDfzI
         NWYgc9InAOqXJTCkrLJTohHWfQrtLO6vDVkZrH0Vj9Jze5OK7EjKEOSimZ/MKXzlRlGA
         AkY4MGSK4sdQX2cgp106YcBz9C7eLKX84WL0K8arFjt8TWGKmJwycgdtcarfwyEEJOWt
         lRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726266376; x=1726871176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=577wDrVMlYw6/7vSWbBSE5NWOXmotjfe7aI48K4g2gs=;
        b=MSCPj237F0ltuNUyvkCIcXvPyTq35ds8lvKm1XqHBgZ3faELOPpqoKB2+CjhFtQAVN
         rDK2eVwpak2ZpRYX4xzSdeypkhYdHXQkSnYHlge5C83CoZcFJnoPo2gtjUcWS/rsra/5
         pvZ9VfR0s84diu8AcD8xExFBzqcVSOPpdJQ+pDHJZOtnuUiLycoDgqKG9eaRqeh89sEr
         eGuENFTcZ70oLl/nKq5dxY5vTCpVleQ6OQEi9uAxEjadnY73N17Cx0VIwVt0j+pFnE39
         G7+NQlgmtVrNrXA7pdX6gBxkcA3YhRXGo3Ybjipst38gtd/HcIftENXsdhpjw4VGg4gw
         Lq1w==
X-Forwarded-Encrypted: i=1; AJvYcCUrCQ6+6S9oDhD1kpsiaLkWq35qNp8kg/QSVxbWNetrywfqOM10UhU9nKC9JkphSb4Sg7I=@vger.kernel.org, AJvYcCXvA9kvFMI5nGzuyPnCx174XQ0HBHK04P1BK3dD/8BvU8nvFHkA8TQBJ/jK+n8rUu6MWXMh93m6H9p1nIDe@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIIgzA2hYivBpzFVV8mOj70/9iIEzU5NAAMXR6G6LtduyekCG
	wcfOQsXXvDQNqVMPgH0TBTcSTk3r9kg0aVBfkQUal4O5hLJUgVWjEAjwvkskcqUF/VOoigO2ZIH
	EKcI4ti0eMoVINzhbBUXjgCAsC7WejQ==
X-Google-Smtp-Source: AGHT+IHvnwtB3+stKJHSsZVtQW2oiRmiz6NV/Jr4tCbAT1Zn462bwAj8DwFN1UoHGTNK6F8Ml/KmyNQAj0Pwqb1YGmk=
X-Received: by 2002:a17:90b:886:b0:2ca:2c4b:476 with SMTP id
 98e67ed59e1d1-2db9ffbcb61mr9072136a91.10.1726266375883; Fri, 13 Sep 2024
 15:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913173759.1316390-1-masahiroy@kernel.org>
In-Reply-To: <20240913173759.1316390-1-masahiroy@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Sep 2024 15:26:04 -0700
Message-ID: <CAEf4Bzawf_EgHyHB+-=2U6eyJtBDVHVQ+Nx1JFw+TTbNSqSmuA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] btf: remove redundant CONFIG_BPF test in scripts/link-vmlinux.sh
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 10:38=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> CONFIG_DEBUG_INFO_BTF depends on CONFIG_BPF_SYSCALL, which in turn
> selects CONFIG_BPF.
>
> When CONFIG_DEBUG_INFO_BTF=3Dy, CONFIG_BPF=3Dy is always met.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> ---
>

Masahiro,

Are you planning to take this through your tree, or you'd prefer us
routing it through bpf-next?

> (no changes since v1)
>
>  scripts/link-vmlinux.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index bd196944e350..cfffc41e20ed 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -288,7 +288,7 @@ strip_debug=3D
>  vmlinux_link vmlinux
>
>  # fill in BTF IDs
> -if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
> +if is_enabled CONFIG_DEBUG_INFO_BTF; then
>         info BTFIDS vmlinux
>         ${RESOLVE_BTFIDS} vmlinux
>  fi
> --
> 2.43.0
>

