Return-Path: <bpf+bounces-69921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D6BBA6FF6
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 13:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A393B6169
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF42DCF65;
	Sun, 28 Sep 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfhu+Yut"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2276280CD2
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759059506; cv=none; b=A+YIWsdp0AWLu8E12QUKlUCp5zA4vrrt3e5qu/Rpu1ZbCxU4PF6Ofl1z17cQ8w2d2tvqnjHP6AxydbEN2R97IcryQ3NhO/mbhsZ8FDfNLHYSPsDq8a8UhrNBE7csa1O8OMVgpTFILSIkUWJxpiwmEMqE8PNTP/msLg3xhZUTfKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759059506; c=relaxed/simple;
	bh=UWXHyb5fW71etsDBlaN+K6xYk233c3qY+BvulNc09+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AC22fO5I/gFz2bcHOH/75ZTVwWS67HSPRA80lTSXChxmeBJTIaMmAPs2O0CzMeXPSy5HETcG1tdxkXW94clfOLxdknOX7K3uUseRtE4IR917+97S0V+Yo9ZXX++A0frQ7+Im0sNIPQ3wqcNYvzjtKOSEgVIrVVx73t5e6ALHuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cfhu+Yut; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ef166e625aso2965556f8f.2
        for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 04:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759059503; x=1759664303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJbyj7CTQs5Hq3X4BmLYSl2wXTOQJPC2yJvcoDb8Pu4=;
        b=Cfhu+Yutuv1ICa97DiNeOzS2vaPrMPW/auYyWlEbTAzElnCJt4G2BAZIklUFWFYbVT
         pDDpZ2rvNjjpxoKa/y0wzj8ns6EF1d6PQR1PInZZyOl8uEIjRUEKzhcB60jYGnqL1QNW
         aD/nca4TgnCkYcs7PyjlMjljygHsIP6o/zprPPWSnaOMxulG5wokAx6ek44MPJRClYEb
         augi6R34xWP/XxpKfLOS9aQL5AWYgfCipc7gHPSZEOtZVi23wn6ZKds9a8qHU+WRVJZc
         7HCCDXU7gRL7dF+PzoDbycOgXdePrt0ywMiiJzrCJaXE+nla6ZuNv4fDeT6vspf6JNLu
         s5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759059503; x=1759664303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJbyj7CTQs5Hq3X4BmLYSl2wXTOQJPC2yJvcoDb8Pu4=;
        b=B/zPwm0nTIpkhfdm8yVuLZZqLKjiABYXF3UlUBOKN3DWh63Hc1mxP3GBPVmYsZWTBn
         iwVGMMGZedi6QzCalYwGQZfGLNfxO2Xo3DV+dlBirIytfix37WCWURwFjzrUkcAFVUw0
         mUDaFVUIupN6oO6ccNegUSoakNqt8KMIvNd96/NowVcepBgqgwqv0b9R5ZLGXFY7+7hs
         ZUnkZuhbmG8pnJtD/wduQk2oBnpzc/Cy+HUBb+pm3VujrIKmeT9C0GRm1YipCM5tMDGC
         588NpFAhURQo95WVtcke6wg8IlV2tnmD+AExyu3kBPLOiQIqF4Pu7MVocAjdzLoQb1Uq
         zgLA==
X-Gm-Message-State: AOJu0Yxo9Uw+Rdrcl3xe0Y+7AJK0ng3+aIp5j8CboSb1V01MwBIWVFSu
	A5Sc0y+BsVvkCTy+TYaE83U6NfZQzO0fsCAMOcjViWHXlvcQBWKQnFL0ic+GeTcXXlSwWbGS+eO
	qPpW6r4K6csEO+mjnRJxoipSdeJ5HKqA=
X-Gm-Gg: ASbGncsri2VY/B8Z85B7E1H6VYJU5X0kGHRiovo+t3Htk+Wq1w5sVMsmCbv2E+SvE6H
	VXuPjXL+cPlifao5P85H/LDBecaOeMtNd+jJEQBRJ0DSl6gMRShPbWIwZptv+3jCGdZAMHb4VO4
	YXjPxVzU1xiw5cL7NvtEn/LmObVY3f1lRELubMbHbE93jecPInGi5IVuZ9RcM/uDM4lYFm8zYnz
	S+NZlEqDHrQqvvK
X-Google-Smtp-Source: AGHT+IG5gTtwFXeUzvsJ2VqaPa0CMNS4HK3Y/UagjYN3qOQg/bakMLvXYWHNxz7sZTKthRY+L6R5rDP6tc8yoc8r0do=
X-Received: by 2002:a05:6000:2005:b0:3ee:d165:2edd with SMTP id
 ffacd0b85a97d-40e4b666ffcmr12929230f8f.28.1759059503066; Sun, 28 Sep 2025
 04:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928003833.138407-1-ebiggers@kernel.org>
In-Reply-To: <20250928003833.138407-1-ebiggers@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 28 Sep 2025 12:38:11 +0100
X-Gm-Features: AS18NWDF4pVhW0K0jrrRfv67o0OX71OOEMAIVbexLs8vE527XzYFys8Sg4We4Xg
Message-ID: <CAADnVQ+ukRuU74ZY=c0RNhJ1ETDj6F4gcBPCS9jDFRnAivgTKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Don't use AF_ALG for SHA-256
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 1:39=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Reimplement libbpf_sha256() using some basic SHA-256 C code.  This
> eliminates the newly-added dependency on AF_ALG, which is a problematic
> UAPI that is not supported by all kernels.
>
> Make libbpf_sha256() return void, since it can no longer fail.  This
> simplifies some callers.  Also drop the unnecessary 'sha_out_sz'
> parameter.  Finally, also fix the typo in "compute_sha_udpate_offsets".
>
> Tested by uncommenting the included test code and running
> 'make -C tools/bpf/bpftool', which causes the test to be executed.
>
> Fixes: c297fe3e9f99 ("libbpf: Implement SHA256 internal helper")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>
> Let me know if there's some way I should wire up the test.  But libbpf
> doesn't seem to have an internal test suite.

It does.

> +
> +#if 0 /* To test libbpf_sha256(), uncomment this.  Requires -lcrypto. */
> +#include <openssl/sha.h>
> +
> +/* Test libbpf_sha256() for all lengths from 0 to 4096 bytes inclusively=
. */
> +static void __attribute__((constructor)) test_libbpf_sha256(void)

Dropped this bit and applied.
Please follow up with a test similar to
tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
There are quite a few tests there that exercise libbpf_internal.h

