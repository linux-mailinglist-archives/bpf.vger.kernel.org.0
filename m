Return-Path: <bpf+bounces-70325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EEBB7DE9
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C0694EE783
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D5D2DC760;
	Fri,  3 Oct 2025 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExtcsMFZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA2442C
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515404; cv=none; b=Xe7kKpwec3mARYBJxyxK8t3xCVi0L3KfJWjVppX9Iq53IZn3Vlc51+Vs6TXAIbb5/08Z/IyQOpLVb24A5mb4lR/hjwzbwm36UJpzI2nhgjuE8Tv67bhalrJ1MU90X4DpRU0MeHfcQIcu7fv3f1kMs+ZEyUsindR/OJYCaDZpM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515404; c=relaxed/simple;
	bh=LgARPdM+3Nl1Ny1COH4WKAT7eYTd0/6hxQa5IVNlp0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfUheyBV3Lz9BWtXCi65YHnk+cbrOHVeAQOQ+XZV/f8bfLwoyxKlWJbidm/GHtuQRddc+J+rzPflyhO0h8VRR9CEcD5yTMS3T/r+JIHs691jMCY1UqVbfZWeziC6InqvuGs4rQ1Nmekdqjf2ePl03gdAYmROaMPoLyl1Pabv/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExtcsMFZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3322e63602eso3671002a91.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515403; x=1760120203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0f1bWgaeSMAksWvrFsowiHb80WhjzYYGFsi5cqa0s8=;
        b=ExtcsMFZiXA2GjXYoLnPgvxvMVet418TyKpQiqawLZGM7AXnCmgN7UhimbkoWrxQ5W
         O/8wg0a6PwU9WaHUvH9p1keHh6p6xQ6qsMOMm0xHsrKwzwdLx0HWd9iEpqgCtDbarvJi
         4MBUmXpHOswCQQE5rXEMU9R8eUvSRF+lXYPg0TuwKmzK6JmJU6xQAEvisVqKvGuOH29X
         6B1qotdrtozK73BJUZyKD7s72GBEYyq0Wp74f/cqh7YkAYD8TnfZoGAzTvbpHlFtd4eQ
         /fqnjxZRDprg+WWZ29mmczn4NRd8K42/9sjSC6Wj7mfINyQVjggGGRdR6BVdTO1Ivgze
         YYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515403; x=1760120203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0f1bWgaeSMAksWvrFsowiHb80WhjzYYGFsi5cqa0s8=;
        b=cE9r2DANpu96Mk0uwM9c8m1m0dUDUN9NHCuH8EOxF88ZSwbxSMVApC/Bb3fssrU28Q
         JOt/38LfijJnAesGmxHW/bgpbeOdA6ukWMd7bqiZ3ctr8trRvvbrMRIyDXTwKTuOvQno
         E2fdlYGajYEAWSNjSPfOfclvEZXFKZjOQSuiXH/4uh88VqBLo2h0lt7jLYjjcqUgmmsi
         MitxsGMFgh80XLwj42YLlc1kpBLB6a7NZPAe0RjfoMDKfssOrU0WDvGoDs1eCgWOaVj3
         tqn8/N1WO7Exz2CUNniVFW/3fkToS9+b858U1qw7NCg98+yCiJY7s9JfHF53Vwt4c0FJ
         22iA==
X-Gm-Message-State: AOJu0YyDq9MwYG2nwXGxqpdw42uViyvOxdySDxL06EzuCYl3DUJWrfrY
	jveAuTlwsBUsGxkkBDPYyqLdZLWsxi52YVmvPXVFqlKWEzIgkB21kQbE9sI2I2h4nTvz0neZNcv
	jqxiDORq1vyO2H2iG6y6Rehq+OR8kEgY=
X-Gm-Gg: ASbGncvuAAzLyL30a6RHsjKpC9aF+mq2UlKIHy0IwPeeaZ06MjXX06+JF73QvUVXcFl
	Cjm2KcAsNnp2iYCxTqHLF8qrica/pmuMURqYnNk7jj/U09ID2mcsPPCUbaDaDXbCBS8rqdDWENm
	U+jgqdJpLQpYeTTVnSICib9FJqedplggLBh9wTt8QSWB7vEJqUH03y9QezNlBdQaQVKtB8lHg5D
	EsUdaRWsHsxXBheEYGbUdzjJQjcmuS69rTkDuJ5yBI/YcY=
X-Google-Smtp-Source: AGHT+IHx51wSgLCadVZQunUaPKL9RdD3BLe+NczOXnSoiXef/HhS2exn3NuE4PFVVGOyePAWf/y1PliWEnPGrotxLYo=
X-Received: by 2002:a17:90b:4a8e:b0:32b:96fa:5f46 with SMTP id
 98e67ed59e1d1-339c272481emr4184877a91.5.1759515402647; Fri, 03 Oct 2025
 11:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Oct 2025 11:16:24 -0700
X-Gm-Features: AS18NWCzSsivZpxkNbk60x-vwVF9cz9z4BXG7eaYQ2g5i0blXP5kNYdveaIorqM
Message-ID: <CAEf4BzZom07Xvan0q6Zv7S36STzt-OMeaKjNPZz1=Mx_Hg6qSg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 03/10] lib: extract freader into a separate files
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move the freader implementation from buildid.{c,h} into a dedicated
> compilation unit, freader.{c,h}.
>
> This allows reuse of freader outside buildid, e.g. for file dynptr
> support added later. Includes are updated and symbols are exported as
> needed. No functional change intended.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/freader.h |  32 +++++++++
>  lib/Makefile            |   2 +-
>  lib/buildid.c           | 145 +---------------------------------------
>  lib/freader.c           | 133 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 167 insertions(+), 145 deletions(-)
>  create mode 100644 include/linux/freader.h
>  create mode 100644 lib/freader.c
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

