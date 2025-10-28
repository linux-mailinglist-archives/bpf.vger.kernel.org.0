Return-Path: <bpf+bounces-72626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C24A2C16849
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3C71B28E3A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051EB34F27D;
	Tue, 28 Oct 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPCuih3M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4834EEE6
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676819; cv=none; b=ZjMHaIykiIXYrsvqCojvWlCOQxRLdL1SySYsBAN68/oH0piOPC8yaVjEO5zbBmAzWlTymf/AAfqdxwQvrjtSaTQ/k3cjNuQcHDuXQULaDmAMSZSjwdjbsl3JI6vWqEkTFE4nhfX1kVTGff+bZRId/gn0knlrwFTTtbBdpHVGWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676819; c=relaxed/simple;
	bh=YHUyqG9og7JRiLqH4LyIAka56ptv6pdodMSXVssNBPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIhoGRbsRXGdplMNyn5Unw5eD1HBS1GTu6rKICL/zG1eaeRUoMqLX02HxC3GDFrOOPmRA74+1HUtMs2ijqW+DdQQEFpT5HVfOiOimB4u9kAAA1x2GT3DLmTuKxL/IMgrmZP3gqC8ah0w1iovi99eu62ZHsMwwCTHwBroQ2oYvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPCuih3M; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af743c232so5880920b3a.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761676817; x=1762281617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReHRtTE3vpAbKBdAM1gtLmprCAAoAlRTRkSZ/pbLtpY=;
        b=aPCuih3M3sTZfq26ff42uHYNlimbbmyUp3u23K6QobQWTGpkbinrzLU4m/AktGHdyK
         VL9WaD9M6O+cDDHkWqvVKOzV8MMmjAwMI72Apv9VkMuv4qnN9V/0Ozp3YCh/dCgGqlPV
         NHUBxLWwEefvlwe7woasAGFljrukNZ/1LfIoEkJScYLLknghxntRn+mpMLAT37ZSQ7fy
         ug1kXzeKtFr3yy9N5xnRNbv440mEv6OCKvxrXWneMwyqK0kYoQqEOVf5JeNCiBQggm11
         LFfLFAGZ6ad6BRVu97IqlO3Dk5OHhu7VPdMVXPPlilVhOuXZDXw9Hq9xUflJBEmaA8tb
         JbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676817; x=1762281617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReHRtTE3vpAbKBdAM1gtLmprCAAoAlRTRkSZ/pbLtpY=;
        b=mRR/FxRpv7FIHk39Am+iObUiVEO1OAt6SfKo75qEhds/XZenCELD9uaFtqc61sSuhq
         OmYVw4SSKkSwwO+cOkpkShQpWLJHTfjqixcvBtIae3Guk35CWmDSb/9EvwgHc3AEq3HL
         w0f+In2YbSxLaRUjQdMp8iKltM1KFNFRzBabtS+P956WrTBcx1kd1QaKEAGT13QDANaZ
         N/wMT2x1S1JE4PgrXYMhFWEX9ZBezvfAE4X0QNEmFenUhpcaTl81tt5ru7hm9BI+nWVb
         AN6gxaAgdYBxeafEdD8P4er1C/V3FyLxEZdvLQIBj8CkGr32fiKW3X4uAtOjpbDH+srr
         cFcw==
X-Forwarded-Encrypted: i=1; AJvYcCXytOggQLY+sOiztJfr3ZFcXS0sv/5JjsGNpTLR3DJ1r/PED7sAyUUwkDTFu6x5P9BqylQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYKTmrmsEv+GaKj+RVD+PKVMJbYv8ltmPSvXaIIrxyZrbdqHJ
	NbNzIuFqrOC/EK8O7WgF/jceqFDL19L+B+uZCOMQmcXwyrCFaGNh3sOAtAmrpfJTv9QngkxX6Ca
	sX8BylCFCg3h4j3TUNtA+HmEn6WOe6P4=
X-Gm-Gg: ASbGncvy8JdDbNJ5O5zYu5DqMaR6H4bjOy0tsMCxonJdTVVKTucPk9DzSsAIzaGB/cc
	ocs3iBSxLHOIXVPRA1zmsHJnaSpPjKVNrZUAENrRySlngB8oWkTjTg+DxQARrhDTFQxQsU5rzXg
	uSMpCZO9TkFqU/rGePHUpJJFfb1m/28+jjRDGPEPlegMxUdmXNTCh1ToEgs/ggaKwv7Ysa19ONx
	N4fl8iKBNjZJkmSmoBoNjh0Re00+Oq04Ay2dc6us0hkgH51APnk0KvwnDUVvfCewwh0vTz/NzSq
X-Google-Smtp-Source: AGHT+IFpi9zDAw8H+uPYXYR7N1r5jRqU5Ai68jkqn3uM+9psX8uQczEPz/AgjranWwgbURI8mlaG82WgPadfnvyMFso=
X-Received: by 2002:a17:90b:4c4d:b0:31e:d4e3:4002 with SMTP id
 98e67ed59e1d1-3403a14377emr52330a91.2.1761676817234; Tue, 28 Oct 2025
 11:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com> <20251027135423.3098490-4-dolinux.peng@gmail.com>
In-Reply-To: <20251027135423.3098490-4-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 11:40:03 -0700
X-Gm-Features: AWmQ_bkfehzA6_mDWthS_m9oyAgVFVGQGAttnEawAXl4ZiOgz-ClG0bQjogRbQ0
Message-ID: <CAEf4BzZ+tpT2ViD_zc8mwz260spriYDiPymw3MFsEibRcuqbqg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting
 verification and binary search
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> The previous commit implemented BTF sorting verification and binary
> search algorithm in libbpf. This patch enables this functionality in
> the kernel.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
> v2->v3:
> - Include btf_sort.c directly in btf.c to reduce function call overhead
> ---
>  kernel/bpf/btf.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0de8fc8a0e0b..df258815a6ca 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -33,6 +33,7 @@
>  #include <net/sock.h>
>  #include <net/xdp.h>
>  #include "../tools/lib/bpf/relo_core.h"
> +#include "../tools/lib/bpf/btf_sort.h"

I don't believe in code reuse for the sake of code reuse. This code
sharing just makes everything more entangled and complicated.
Reimplementing binary search is totally fine, IMO.

[...]

